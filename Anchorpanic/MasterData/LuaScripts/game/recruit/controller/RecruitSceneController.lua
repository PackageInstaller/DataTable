module("recruit.RecruitSceneController", Class.impl(map.MapBaseController))

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
    -- GameDispatcher:addEventListener(EventName.RECRUIT_OPEN_DOOR, self.onOpenRecruit, self)
    -- GameDispatcher:addEventListener(EventName.RECRUIT_SKIP, self.onSkip, self)
    -- GameDispatcher:addEventListener(EventName.CLOSE_RECRUIT_SHOW_ONE_VIEW, self.onCloseOneView, self)

    -- GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.initData, self)
end

-- 开始加载前
function beforeLoad(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_MASKVIEW)
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_RECRUIT_MASKVIEW)

    local Environment = gs.GameObject.Find("Environment")
    if Environment then
        self.mAnimator = Environment:GetComponent(ty.Animator)

        self.m_EfxPointList = {}
        for i=1,10 do
            local str = tostring(i)
            if i < 10 then 
                str = "0" .. i
            end
            local point = Environment.transform:Find("fx_rolecard_guadian/fx_rolecard_guadian/fx_rolecard_guadian_" .. str)
            if point and not gs.GoUtil.IsTransNull(point) then 
                self.m_EfxPointList[i] = point
            end
        end
    end

    if self.mAnimator  and not gs.GoUtil.IsCompNull(self.mAnimator) then 
        local time = AnimatorUtil.getAnimatorClipTime(self.mAnimator,"rolecard_01")
        LoopManager:setTimeout(time,nil,function ()
            GameDispatcher:dispatchEvent(EventName.OPENRECRUITSKIPVIEW)
        end)
    end

    self:initData()
end

function initData(self)
    local curType = recruit.RecruitManager:getRecruitActionType()
    if curType ~= recruit.RecruitType.RECRUIT_TOP and 
    curType ~= recruit.RecruitType.RECRUIT_NEW_PLAYER and 
    curType ~= recruit.RecruitType.RECRUIT_ACTIVITY_1 and 
    curType ~= recruit.RecruitType.RECRUIT_ACTIVITY_3 then 
        return
    end
    
    self.mCurShowHeroInfo = { vo = 0, index = 0 } --当前展示的是哪个英雄的信息

    self.mRecruitHeroVo = recruit.RecruitManager:getRecruitHeroResultList()
    self.mIsOver = false
end

--点击开开关，开始抽人
function onOpenRecruit(self)
    local curType = recruit.RecruitManager:getRecruitActionType()
    if curType ~= recruit.RecruitType.RECRUIT_TOP and 
    curType ~= recruit.RecruitType.RECRUIT_NEW_PLAYER and 
    curType ~= recruit.RecruitType.RECRUIT_ACTIVITY_1 and 
    curType ~= recruit.RecruitType.RECRUIT_ACTIVITY_3 then 
        return
    end

    local maxQualiy = 0
    local otherQualiyList = {}

    if #self.mRecruitHeroVo > 1 then 
        for i=1,#self.mRecruitHeroVo do
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[i].heroTid)
            if heroConfigVo.color > maxQualiy then 
                maxQualiy = heroConfigVo.color
            else
                otherQualiyList[i] = heroConfigVo.color
            end
        end
    else
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[1].heroTid)
        maxQualiy = heroConfigVo.color
    end


    for i=1,10 do
        local efxPath = ""
        if i == 1 then 
            efxPath = string.format("arts/fx/3d/scene/ui_card_01/fx_rolecard_03_0%s.prefab", maxQualiy - 1)
        elseif otherQualiyList[i] ~= nil then 
            efxPath = string.format("arts/fx/3d/scene/ui_card_01/fx_rolecard_03_0%s.prefab", otherQualiyList[i] - 1)
        end
        if not string.NullOrEmpty(efxPath) then
            gs.ResMgr:LoadGOAysn(efxPath, function(go)
                if go then
                    go.transform:SetParent(self.m_EfxPointList[i], false)
                else
                    logAll("特效加载失败")
                end
            end)
        end
    end

    if self.mAnimator and not gs.GoUtil.IsCompNull(self.mAnimator) then  
        self.mAnimator:Play("rolecard_03")

        local time = AnimatorUtil.getAnimatorClipTime(self.mAnimator,"rolecard_03")
        LoopManager:setTimeout(time,nil,function ()
            GameDispatcher:dispatchEvent(EventName.CLOSERECRUITSKIPVIEW)
            self:ShowRecruitResult()
        end)
    end
end

--关闭立绘界面
function onCloseOneView(self)
    if self.mIsOver then 
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL)
    else
        self:ShowRecruitResult()
    end
end

--跳过
function onSkip(self)
    local curType = recruit.RecruitManager:getRecruitActionType()
    if curType ~= recruit.RecruitType.RECRUIT_TOP and 
    curType ~= recruit.RecruitType.RECRUIT_NEW_PLAYER and 
    curType ~= recruit.RecruitType.RECRUIT_ACTIVITY_1 and 
    curType ~= recruit.RecruitType.RECRUIT_ACTIVITY_3 then 
        return
    end
    
    self:onOver()
end

--展示抽卡结果
function ShowRecruitResult(self,isSkip)
    if not table.empty(self.mRecruitHeroVo) then
        if self.mCurShowHeroInfo.index < #self.mRecruitHeroVo then
            if #self.mRecruitHeroVo == 1 then
                self.mCurShowHeroInfo.index = 1
                self.mCurShowHeroInfo.vo = self.mRecruitHeroVo[1]
                GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, {heroTid = self.mRecruitHeroVo[1].heroTid,propsList = self.mRecruitHeroVo[1].propsList,isNoSkip = true})

                self.mIsOver = true
            else
                for i=1,#self.mRecruitHeroVo do
                    if i > self.mCurShowHeroInfo.index then 
                        self.mCurShowHeroInfo.index = i
                        self.mCurShowHeroInfo.vo = self.mRecruitHeroVo[i]
                        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, self.mRecruitHeroVo[i])
                        break
                    end
                end
            end
        else
            self:onOver()
        end
    end
end

--结算
function onOver(self)
    --多抽打开AllView,单抽回到抽卡界面
    if #self.mRecruitHeroVo > 1 then
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ALL_VIEW)
    elseif #self.mRecruitHeroVo == 1 then
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, {heroTid = self.mRecruitHeroVo[1].heroTid,propsList = self.mRecruitHeroVo[1].propsList,isNoSkip = true})
        self.mIsOver = true
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL)
    end
    self:clearData()
end

-- 关闭当前地图
function clearMap(self)
    super.clearMap(self)
end

function clearData(self)
    self.mCurShowHeroInfo = nil
    self.mRecruitHeroVo = nil
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.RECRUIT
end

-- 地图资源名
function getMapID(self)
    return 4
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
