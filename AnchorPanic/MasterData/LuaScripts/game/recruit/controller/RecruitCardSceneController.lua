module("recruit.RecruitCardSceneController", Class.impl(map.MapBaseController))

function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:__init()
    self:clearMap()
end

function __init(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.RECRUIT_OPEN_DOOR, self.onOpenRecruit, self)
    GameDispatcher:addEventListener(EventName.RECRUIT_SKIP, self.onSkip, self)
    GameDispatcher:addEventListener(EventName.CLOSE_RECRUIT_CARD_SHOW_ONE_VIEW, self.onCloseOneView, self)

    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.initData, self)
end

-- 开始加载前
function beforeLoad(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_MASKVIEW)
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_RECRUIT_MASKVIEW)

    local Environment = gs.GameObject.Find("scene_root_ui_card_02/Environment")
    if Environment then
        self.mAnimator = Environment:GetComponent(ty.Animator)

        local Efx_1_Left = Environment.transform:Find("position/ui_card_02/laoyinchouka_01_boli11_01/fx_laoyinchouka_01_boli11_01_01_hong")
        local Efx_1_Right = Environment.transform:Find("position/ui_card_02/laoyinchouka_01_boli11_02/fx_laoyinchouka_01_boli11_02_01_hong")

        local Efx_2_Left = Environment.transform:Find("position/ui_card_02/laoyinchouka_01_boli11_01/fx_laoyinchouka_01_boli11_01_01_lan")
        local Efx_2_Right = Environment.transform:Find("position/ui_card_02/laoyinchouka_01_boli11_02/fx_laoyinchouka_01_boli11_02_01_lan")

        local recruit_id = recruit.RecruitManager:getRecruitActionId()
        local meunVo = recruit.RecruitManager:getRecruitMenuVo(recruit_id)
        if meunVo then
            Efx_1_Left.gameObject:SetActive(meunVo.type == recruit.RecruitType.RECRUIT_BRACELETS)
            Efx_1_Right.gameObject:SetActive(meunVo.type == recruit.RecruitType.RECRUIT_BRACELETS)

            Efx_2_Left.gameObject:SetActive(meunVo.type == recruit.RecruitType.RECRUIT_ACTIVITY_2)
            Efx_2_Right.gameObject:SetActive(meunVo.type == recruit.RecruitType.RECRUIT_ACTIVITY_2)
        end

        self.mQuality_point = Environment.transform:Find("position/ui_card_02/laoyinchouka_01_zhongxinpingtai_01/fx_laoyinchouka_zhongtai")
    end

    AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_bracelets_01.prefab")

    if self.mAnimator and not gs.GoUtil.IsCompNull(self.mAnimator) then
        local time = AnimatorUtil.getAnimatorClipTime(self.mAnimator, "handcard_01")
        LoopManager:setTimeout(time, nil, function ()
            self.mAudioLoopData = AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_bracelets_loop.prefab", true)
            GameDispatcher:dispatchEvent(EventName.OPENRECRUITSKIPVIEW, {isNeedSkip = true, isNeedClick = true, IsNeedEfx = false, skillCall = function ()
                self:onSkip()
            end})
        end)
    end

    self:initData()
end

-- 播放场景音乐
function playSceneMusic(self)

end

function initData(self, args)
   if not self:isRecruitType() then
        return
    end

    self.mCurShowHeroInfo = {vo = 0, index = 0} --当前展示的是哪个英雄的信息
    self.mRecruitCardList = recruit.RecruitManager:getRecruitCardResultList()
    self.mIsOver = false

    self.mMaxQualiy = 1
    for k, v in pairs(self.mRecruitCardList) do
        local configVo = props.PropsManager:getPropsConfigVo(v.tid)
        if self.mMaxQualiy < configVo.color then
            self.mMaxQualiy = configVo.color
        end
    end
end

--点击开开关，开始抽人
function onOpenRecruit(self)
    if not self:isRecruitType() then
        return
    end

    local efxPath = string.format("arts/fx/3d/scene/ui_card_02/fx_laoyinchouka_01_zhongxinpingtai_01_03_0%s.prefab", self.mMaxQualiy - 1)
    gs.ResMgr:LoadGOAysn(efxPath, function(go)
        if go then
            go.transform:SetParent(self.mQuality_point, false)
        else
            logAll("特效加载失败")
        end
    end)

    if self.mAnimator and not gs.GoUtil.IsCompNull(self.mAnimator) then
        self.mAnimator:Play("handcard_03")
        AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_bracelets_02.prefab")

        local time = AnimatorUtil.getAnimatorClipTime(self.mAnimator, "handcard_03")
        LoopManager:setTimeout(time, nil, function ()
            AudioManager:stopAudioSound(self.mAudioLoopData)
            self.mAudioLoopData = nil

            self:ShowRecruitResult()
        end)
    end

    GameDispatcher:dispatchEvent(EventName.CLOSERECRUITSKIPVIEW)
end

--关闭立绘界面
function onCloseOneView(self)
    if not self:isRecruitType() then
        return
    end

    if self.mIsOver then
        GameDispatcher:dispatchEvent(EventName.RECRUIT_FINISH)
        -- GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_MASKVIEW)
    else
        self:ShowRecruitResult()
    end
end

--跳过
function onSkip(self)
    if not self:isRecruitType() then
        return
    end

    AudioManager:stopAudioSound(self.mAudioLoopData)
    self.mAudioLoopData = nil

    self:onOver()
end

--展示抽卡结果
function ShowRecruitResult(self, isSkip)
    if not table.empty(self.mRecruitCardList)then
        if self.mCurShowHeroInfo.index < #self.mRecruitCardList then
            local recruit_id = recruit.RecruitManager:getRecruitActionId()
            local recruitConfigVo = recruit.RecruitManager:getRecruitConfigVo(recruit_id)

            if #self.mRecruitCardList == 1 then
                self.mCurShowHeroInfo.index = 1
                self.mCurShowHeroInfo.vo = self.mRecruitCardList[1]
                GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_CARD_SHOW_ONE_VIEW, {tid = self.mRecruitCardList[1].tid, isNoSkip = true})

                self.mIsOver = true
            else
                for i = 1, #self.mRecruitCardList do
                    if i > self.mCurShowHeroInfo.index then
                        self.mCurShowHeroInfo.index = i
                        self.mCurShowHeroInfo.vo = self.mRecruitCardList[i]

                        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_CARD_SHOW_ONE_VIEW, {tid = self.mRecruitCardList[i].tid})
                        break
                    end
                end
            end
        else
            self:onOver()
        end
    end

    -- local sceneCamera = gs.CameraMgr:GetSceneCamera()
    -- if sceneCamera ~= nil and not gs.GoUtil.IsCompNull(sceneCamera) and sceneCamera.gameObject.activeSelf then
    --     sceneCamera.gameObject:SetActive(false)
    -- end
end

--结算
function onOver(self)
    --多抽打开AllView,单抽回到抽卡界面
    if #self.mRecruitCardList > 1 then
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_CARD_SHOW_ALL_VIEW, self.mRecruitCardList)
    elseif #self.mRecruitCardList == 1 then
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_CARD_SHOW_ONE_VIEW, {tid = self.mRecruitCardList[1].tid, isNoSkip = true})
        self.mIsOver = true
    end

    self:clearData()
end

function isRecruitType(self)
    local recruit_id = recruit.RecruitManager:getRecruitActionId()
    local meunVo = recruit.RecruitManager:getRecruitMenuVo(recruit_id)
    if not meunVo then
        return
    end

    if meunVo.type ~= recruit.RecruitType.RECRUIT_BRACELETS and
        meunVo.type ~= recruit.RecruitType.RECRUIT_APP_BRACELETS and
        meunVo.type ~= recruit.RecruitType.RECRUIT_ACTIVITY_2 then
        return
    end

    return true
end

-- 关闭当前地图
function clearMap(self)
    super.clearMap(self)
end

function clearData(self)
    self.mRecruitCardList = nil
    self.mCurShowHeroInfo = nil
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.RECRUIT_CARD
end

-- 地图资源名
function getMapID(self)
    return 5
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
