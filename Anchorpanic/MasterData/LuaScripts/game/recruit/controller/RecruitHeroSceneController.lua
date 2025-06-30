module("recruit.RecruitHeroSceneController", Class.impl(map.MapBaseController))

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
    GameDispatcher:addEventListener(EventName.RECRUIT_SKIP, self.onSkip, self)
    GameDispatcher:addEventListener(EventName.CLOSE_RECRUIT_SHOW_ONE_VIEW, self.onCloseOneView, self)
    GameDispatcher:addEventListener(EventName.OPEN_HERORECRUIT_MAP, self.initScene, self)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.initData, self)
    GameDispatcher:addEventListener(EventName.RECRUIT_OPEN_DOOR, self.onShowRecruitResult, self)
end

-- 开始加载前
function beforeLoad(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_MASKVIEW)
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)

    local Environment = gs.GameObject.Find("scene_root_ui_card_04/Environment1")
    if Environment then
        self.mAnimator_1 = Environment:GetComponent(ty.Animator)

        if self.mAnimator_1 and not gs.GoUtil.IsCompNull(self.mAnimator_1) then
            local time = AnimatorUtil.getAnimatorClipTime(self.mAnimator_1, "chouka_cs_01")
            LoopManager:setTimeout(time - 0.5, nil, function ()
                --这里需要特殊处理，原因因为动画修改了 相机fieldOfView 值
                if not gs.Application.isMobilePlatform then
                    gs.CameraMgr:GetToScreenSceneCamera().fieldOfView = gs.CameraMgr:GetSceneCamera().fieldOfView
                end

                if not StorageUtil:getBool1(gstor.RECRUIT_HERO_GUIDE) then
                    local closeCall = function ()
                        GameDispatcher:dispatchEvent(EventName.OPENRECRUITSKIPVIEW, {isNeedSkip = false, isNeedClick = false, isNeedEfx = true, addEfxTime = 1, efxPoint = self.mClick_L_Collier})
                    end

                    TipsFactory:RecommendTips({data = tips.TipsManager:getRecommandData()[2], closeCall = closeCall})
                    StorageUtil:saveBool1(gstor.RECRUIT_HERO_GUIDE, true)
                end
            end)
        end
    end

    Environment = gs.GameObject.Find("scene_root_ui_card_04/Environment1/Environment3")
    if Environment then
        self.mAnimator_2 = Environment:GetComponent(ty.Animator)

        if self.mAnimator_2 and not gs.GoUtil.IsCompNull(self.mAnimator_2) then
            if self.mAnimator_2.enabled then
                self.mAnimator_2.enabled = false
            end
        end

        local maxQualiy_wheel = 0
        for i = 1, #self.mRecruitHeroVo do
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[i].heroTid)
            if heroConfigVo.color - 1 > maxQualiy_wheel then
                maxQualiy_wheel = heroConfigVo.color - 1
            end
        end

        local audioMusic = {"ui_beam_blue_loop", "ui_beam_purple_loop", "ui_beam_gold_loop"}
        local playWheelMusci = function (quality)
            if maxQualiy_wheel == quality then
                AudioManager:playMusic(string.format("arts/audio/UI/recruit/%s.prefab", audioMusic[maxQualiy_wheel]))
            end
        end

        local audioSoundList = {"ui_beam_blue", "ui_beam_purple", "ui_beam_gold"}

        self.mAnimatCall_2 = self.mAnimator_2:GetComponent(ty.AnimatCall)
        self.mAnimatCall_2:AddFrameEventCall("PlayQualitySound_1", function()
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[1].heroTid)
            AudioManager:playSoundEffect(string.format("arts/audio/UI/recruit/%s.prefab", audioSoundList[heroConfigVo.color - 1]))

            playWheelMusci(heroConfigVo.color - 1)

            -- gs.EditorApplication.isPaused = true
        end)
        self.mAnimatCall_2:AddFrameEventCall("PlayQualitySound_2", function()
            if #self.mRecruitHeroVo <= 1 then
                return
            end

            local maxQualiy = 0
            for _, index in pairs({2, 5, 8}) do
                local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[index].heroTid)
                if heroConfigVo.color - 1 > maxQualiy then
                    maxQualiy = heroConfigVo.color - 1
                end
            end

            AudioManager:playSoundEffect(string.format("arts/audio/UI/recruit/%s.prefab", audioSoundList[maxQualiy]))
            playWheelMusci(maxQualiy)
            -- gs.EditorApplication.isPaused = true
        end)
        self.mAnimatCall_2:AddFrameEventCall("PlayQualitySound_3", function()
            if #self.mRecruitHeroVo <= 1 then
                return
            end

            local maxQualiy = 0
            for _, index in pairs({3, 4, 6, 7, 9, 10}) do
                local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[index].heroTid)
                if heroConfigVo.color - 1 > maxQualiy then
                    maxQualiy = heroConfigVo.color - 1
                end
            end

            AudioManager:playSoundEffect(string.format("arts/audio/UI/recruit/%s.prefab", audioSoundList[maxQualiy]))
            playWheelMusci(maxQualiy)
            -- gs.EditorApplication.isPaused = true
        end)

        local animatPoint = Environment.transform:Find("ui_card_03_hexin_01")
        if animatPoint ~= nil and not gs.GoUtil.IsTransNull(animatPoint) then
            self.mQualityAnimator = animatPoint:GetComponent(ty.Animator)
        end

        animatPoint = Environment.transform:Find("Camera/[SCamera]")
        if animatPoint ~= nil and not gs.GoUtil.IsTransNull(animatPoint) then
            self.mCameraAnimator = animatPoint:GetComponent(ty.Animator)
        end

        animatPoint = Environment.transform:Find("ui_card_03_hexin_01/ui_card_04")
        if animatPoint ~= nil and not gs.GoUtil.IsTransNull(animatPoint) then
            self.mChargingAnimator = animatPoint:GetComponent(ty.Animator)
        end

        self.mQulityExfList_1 = {}
        for i = 1, 3 do
            local point = Environment.transform:Find("Camera/[SCamera]/fx_ui_card_03_gua_01/fx_ui_card_03_0" .. i)
            if point and not gs.GoUtil.IsTransNull(point) then
                self.mQulityExfList_1[i] = point
            end
        end

        self.mQulityExfList_2 = {}
        for i = 1, 3 do
            local point = Environment.transform:Find("ui_card_03_hexin_01/fx_ui_card_03_gua_02/fx_ui_card_03_01_g_0" .. i)
            if point and not gs.GoUtil.IsTransNull(point) then
                self.mQulityExfList_2[i] = point
            end
        end

        self.mQulityExfList_3 = {}
        for i = 1, 3 do
            self.mQulityExfList_3[i] = {}
            for j = 1, 3 do
                local fx = Environment.transform:Find(string.format("ui_card_03_hexin_01/fx_ui_card_03_0%s/fx_ui_card_03_0%s_0%s", i, i, j))
                self.mQulityExfList_3[i][j] = fx
            end
        end

        self.mQulityExfList_4 = {}
        for i = 1, 10 do
            self.mQulityExfList_4[i] = gs.GameObject.Find(string.format("fx_quality_%02d", i))
        end

        self.mClick_L_Collier = Environment.transform:Find("ui_card_03_hexin_01/ui_card_04/_601_03_xiaowujian05_001/fx_601_03_anniu_01_L/fx_601_03_anniu_01_L_xunhuan/click_L_Collier")
        self.mClick_R_Collier = Environment.transform:Find("ui_card_03_hexin_01/ui_card_04/_601_03_xiaowujian05_001_1/fx_601_03_anniu_01_R/fx_601_03_anniu_01_R_xunhuan/click_R_Collier")

        if self.mClick_L_Collier and not gs.GoUtil.IsTransNull(self.mClick_L_Collier) then
            local mouseEvent = self.mClick_L_Collier.gameObject:AddComponent(ty.GoMouseEvent)
            mouseEvent:SetCallFun(self, nil, self.onMouseDown_L, self.onMouseUp)
        end

        if self.mClick_R_Collier and not gs.GoUtil.IsTransNull(self.mClick_R_Collier) then
            local mouseEvent = self.mClick_R_Collier.gameObject:AddComponent(ty.GoMouseEvent)
            mouseEvent:SetCallFun(self, nil, self.onMouseDown_R, self.onMouseUp)
        end

        --特殊处理16/9以下的分辨率
        if gs.Screen.width / gs.Screen.height <= 1280 / 960 then
            local click_L_Collier_Parent = Environment.transform:Find("ui_card_03_hexin_01/ui_card_04/_601_03_xiaowujian05_001/fx_601_03_anniu_01_L")
            if click_L_Collier_Parent and not gs.GoUtil.IsTransNull(click_L_Collier_Parent) then
                click_L_Collier_Parent.localPosition = click_L_Collier_Parent.localPosition + gs.Vector3(-3, 0, 0)
            end

            local click_R_Collier_Parent = Environment.transform:Find("ui_card_03_hexin_01/ui_card_04/_601_03_xiaowujian05_001_1/fx_601_03_anniu_01_R")
            if click_R_Collier_Parent and not gs.GoUtil.IsTransNull(click_R_Collier_Parent) then
                click_R_Collier_Parent.localPosition = click_R_Collier_Parent.localPosition + gs.Vector3(-3, 0, 0)
            end
        end
    end

    self:initScene()

    GameDispatcher:dispatchEvent(EventName.CLOSE_RECRUIT_MASKVIEW)
end

-- 播放场景音乐
function playSceneMusic(self)

end

--初始化
function initScene(self)
    if not self:isRecruitType() then
        return
    end

    if self.mAnimator_1 and not gs.GoUtil.IsCompNull(self.mAnimator_1) then
        self.mAnimator_1.speed = 1
        self.mAnimator_1:Play("chouka_cs_01")
    end

    if self.mAnimator_2 and not gs.GoUtil.IsCompNull(self.mAnimator_2) then
        if not self.mAnimator_2.enabled then
            self.mAnimator_2.enabled = true
        end

        self.mAnimator_2:Play("chouka_cs_03_daohui")
        LoopManager:setTimeout(0.1, self, function ()
            self.mAnimator_2:Play("Empty")

            if self.mAnimator_2.enabled then
                self.mAnimator_2.enabled = false
            end
        end)
    end

    if not table.empty(self.mQulityExfList_1) and not table.empty(self.mQulityExfList_2) and not table.empty(self.mQulityExfList_3) then
        local efx = nil
        for i = 1, 3 do
            efx = self.mQulityExfList_1[i]
            if efx ~= nil and not gs.GoUtil.IsTransNull(efx) then
                efx.gameObject:SetActive(false)
            end

            efx = self.mQulityExfList_2[i]
            if efx ~= nil and not gs.GoUtil.IsTransNull(efx) then
                efx.gameObject:SetActive(false)
            end

            for _, fx in pairs(self.mQulityExfList_3[i]) do
                fx.gameObject:SetActive(false)
            end
        end
    end

    if self.mChargingAnimator and not gs.GoUtil.IsCompNull(self.mChargingAnimator) then
        self.mChargingAnimator:Play("Empty")
    end

    if self.mQualityAnimator and not gs.GoUtil.IsCompNull(self.mQualityAnimator) then
        self.mQualityAnimator.gameObject:SetActive(true)
        self.mQualityAnimator:Play("Empty")

        LoopManager:setFrameout(2, nil, function ()
            if self.mQualityAnimator.enabled then
                self.mQualityAnimator.enabled = false
            end
        end)
    end

    AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_recruit.prefab")
    AudioManager:playMusic("arts/audio/UI/recruit/ui_recruit_loop.prefab")

    AudioManager:resumeMusicByFade(0)

    self:initData()
end

function initData(self)
    if not self:isRecruitType() then
        return
    end

    self.mCurShowHeroInfo = {vo = 0, index = 0} --当前展示的是哪个英雄的信息
    self.mIsOver = false
    self.mClickRecruitCount = 0

    self.mMaxQualiy = 0
    self.mRecruitHeroVo = recruit.RecruitManager:getRecruitHeroResultList()

    if not table.empty(self.mRecruitHeroVo) then
        if #self.mRecruitHeroVo > 1 then
            for i = 1, #self.mRecruitHeroVo do
                local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[i].heroTid)
                if heroConfigVo.color > self.mMaxQualiy then
                    self.mMaxQualiy = heroConfigVo.color - 1
                end
            end
        else
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[1].heroTid)
            self.mMaxQualiy = heroConfigVo.color - 1
        end
    end

    self.mShowingTween = false
    self.mOnShowRecruitResult = false
    self.mIsMouseDown = false
    self.mIsMouseUp = false

    if gs.Application.isMobilePlatform then
        if not self.mTouchFrameSn then
            self.mTouchFrameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
        end
    end
end

--按下去(左)
function onMouseDown_L(self)
    if subPack.SubDownLoadController:isExistNeedUpdate() then
        self:onOver()
        gs.Message.Show("请等待资源下载完成获得最佳体验")
        return
    end

    if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(gs.UnityEngineUtil.GetMousePosX(), gs.UnityEngineUtil.GetMousePosY())).Count > 0 then
        return
    end

    if self.mIsMouseDown then
        return
    end
    self.mIsMouseDown = true

    LoopManager:setTimeout(0.2, nil, function ()
        if gs.Input.touchCount >= 2 then
            return
        end

        if self.mIsMouseUp then
            self:onShowTween3()
        else
            self:onOpenRecruit(2)
        end
    end)
end

--按下去(右)
function onMouseDown_R(self)
    if subPack.SubDownLoadController:isExistNeedUpdate() then
        self:onOver()
        gs.Message.Show("请等待资源下载完成获得最佳体验")
        return
    end

    if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(gs.UnityEngineUtil.GetMousePosX(), gs.UnityEngineUtil.GetMousePosY())).Count > 0 then
        return
    end

    if self.mIsMouseDown then
        return
    end
    self.mIsMouseDown = true

    LoopManager:setTimeout(0.2, nil, function ()
        if gs.Input.touchCount >= 2 then
            return
        end

        if self.mIsMouseUp then
            self:onShowTween3()
        else
            self:onOpenRecruit(1)
        end
    end)
end

--松开
function onMouseUp(self)
    if not self.mIsMouseDown then
        return
    end

    if self.mIsMouseUp then
        return
    end

    if not self.mIsMouseUp then
        self.mIsMouseUp = true
    end

    if not self.mShowingTween then
        return
    end

    self:onShowTween3()
end

function onFrame(self)
    local sceneCamera = gs.CameraMgr:GetToScreenSceneCamera()
    if not sceneCamera or gs.GoUtil.IsCompNull(sceneCamera) then
        return

    end

    if gs.Input.touchCount == 2 then
        local touch_1 = gs.Input.GetTouch(0)
        local touch_2 = gs.Input.GetTouch(1)

        local centerPos_x = gs.Screen.width / 2
        local collider = self.mClick_L_Collier

        local hitInfo_1 = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, gs.Vector3(touch_1.position.x, touch_1.position.y, 0), "Building", 500)
        if hitInfo_1 and hitInfo_1.collider then
            if gs.TransQuick:GetTouchPosition_X(touch_1) > centerPos_x then
                collider = self.mClick_R_Collier
            end

            if hitInfo_1.collider.transform == collider then
                self.mClickRecruitCount = self.mClickRecruitCount + 1
            end
        end

        local hitInfo_2 = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, gs.Vector3(touch_2.position.x, touch_2.position.y, 0), "Building", 500)
        if hitInfo_2 and hitInfo_2.collider then
            if gs.TransQuick:GetTouchPosition_X(touch_2) > centerPos_x then
                collider = self.mClick_R_Collier
            end

            if hitInfo_2.collider.transform == collider then
                self.mClickRecruitCount = self.mClickRecruitCount + 1
            end
        end

        if self.mClickRecruitCount >= 2 then
            self.mIsMouseDown = true
            self:onOpenRecruit(3)
        end

    elseif gs.Input.touchCount <= 0 and self.mShowingTween then
        self:onMouseUp()
    end
end

--点击开开关，开始抽人
function onOpenRecruit(self, clip_type)
    if table.empty(self.mRecruitHeroVo) then return end
    if self.mShowingTween then return end

    self.mShowingTween = true

    GameDispatcher:dispatchEvent(EventName.RECRUIT_HERO_CLICK)

    if self.mAnimator_1 and not gs.GoUtil.IsCompNull(self.mAnimator_1) then
        self.mAnimator_1:Play("chouka_cs_02_xunhuan")
    end

    if self.mChargingAnimator and not gs.GoUtil.IsCompNull(self.mChargingAnimator) then
        self.mChargingAnimator:Play(string.format("guandao_0%s", clip_type))
    end

    local index = 0
    local showQuality = function ()
        index = index + 1
        if index <= self.mMaxQualiy then
            local efx = self.mQulityExfList_2[index]
            if efx ~= nil and not gs.GoUtil.IsTransNull(efx) then
                efx.gameObject:SetActive(true)
            end

            local clipName = string.format("ui_card_03_hexin_0%s_0%s", index - 1, index)
            if not self.mQualityAnimator.enabled then
                self.mQualityAnimator.enabled = true
            end
            self.mQualityAnimator:Play(clipName)

            local clipName = string.format("camera_0%s", index)
            if self.mCameraAnimator and not gs.GoUtil.IsCompNull(self.mCameraAnimator) then
                if not self.mCameraAnimator.enabled then
                    self.mCameraAnimator.enabled = true
                end
                self.mCameraAnimator:Play(clipName)
            end

            local audioPath = ""
            local audioPath_sound = ""
            ---充能动画播放倍速
            if index == 1 then
                self.mAnimator_1.speed = 5

                audioPath = "arts/audio/UI/recruit/ui_blue_loop.prefab"
                audioPath_sound = "arts/audio/UI/recruit/ui_hint_blue.prefab"
            elseif index == 2 then
                self.mAnimator_1.speed = 10

                audioPath = "arts/audio/UI/recruit/ui_purple_loop.prefab"
                audioPath_sound = "arts/audio/UI/recruit/ui_hint_purple.prefab"
            elseif index == 3 then
                self.mAnimator_1.speed = 15

                audioPath = "arts/audio/UI/recruit/ui_gold_loop.prefab"
                audioPath_sound = "arts/audio/UI/recruit/ui_hint_gold.prefab"
            end

            AudioManager:playSoundEffect(audioPath_sound)
            AudioManager:playMusic(audioPath)
        end
    end

    showQuality()
    self:clearTimer()
    --充能间隔秒数
    self.mShowQualityTimer = LoopManager:addTimer(1, -1, self, function ()
        showQuality()
    end)

    if not self.mOutShowRecruitSn then
        self.mOutShowRecruitSn = LoopManager:setTimeout(20, self, self.onShowTween3)
    end
end

--展示第三阶段动画
function onShowTween3(self)
    self:clearTimer()
    self:clearFrame()

    GameDispatcher:dispatchEvent(EventName.CLOSERECRUITSKIPVIEW)
    AudioManager:pauseMusicByFade(1)
    self.m_ShootSoundAuidoData = AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_beam_shoot.prefab")

    GameDispatcher:dispatchEvent(EventName.OPENRECRUITSKIPVIEW, {isNeedSkip = true, skillCall = function ()
        self:onShowRecruitResult()
    end})

    for _, fx_list in pairs(self.mQulityExfList_3) do
        local fx = fx_list[self.mMaxQualiy]
        if fx and not gs.GoUtil.IsTransNull(fx) then
            fx.gameObject:SetActive(true)
        end
    end

    self.mQualityFxGoList = {}
    if not table.empty(self.mRecruitHeroVo) then
        if #self.mRecruitHeroVo > 1 then
            for i = 1, #self.mRecruitHeroVo do
                local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[i].heroTid)

                local path = string.format("arts/fx/3d/scene/ui_card_01/fx_rolecard_03_%02d.prefab", heroConfigVo.color - 1)
                local quality_fx_go = gs.GOPoolMgr:Get(path, false)

                gs.TransQuick:SetParentOrg01(quality_fx_go, self.mQulityExfList_4[i].transform)
                gs.TransQuick:LPos(quality_fx_go.transform, gs.VEC3_ZERO)

                table.insert(self.mQualityFxGoList, {go = quality_fx_go, path = path})
            end
        else
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[1].heroTid)

            local path = string.format("arts/fx/3d/scene/ui_card_01/fx_rolecard_03_%02d.prefab", heroConfigVo.color - 1)
            local quality_fx_go = gs.GOPoolMgr:Get(path, false)

            gs.TransQuick:SetParentOrg01(quality_fx_go, self.mQulityExfList_4[1].transform)
            gs.TransQuick:LPos(quality_fx_go.transform, gs.VEC3_ZERO)

            table.insert(self.mQualityFxGoList, {go = quality_fx_go, path = path})
        end
    end

    if self.mCameraAnimator and not gs.GoUtil.IsCompNull(self.mCameraAnimator) then
        self.mCameraAnimator:Play("Empty")

        LoopManager:setFrameout(2, nil, function ()
            if self.mCameraAnimator.enabled then
                self.mCameraAnimator.enabled = false
            end
        end)
    end

    if self.mAnimator_2 and not gs.GoUtil.IsCompNull(self.mAnimator_2) then
        if not self.mAnimator_2.enabled then
            self.mAnimator_2.enabled = true
        end
        self.mAnimator_2:Play("chouka_cs_03_qiehuan")

        self:clearAnimator_2_qiehuanTimeOut()
        self.mAnimator_2_qiehuanTimeOut = LoopManager:setFrameout(220, self, self.onAnimaTweenEnd)
    end
end

function clearAnimator_2_qiehuanTimeOut(self)
    if self.mAnimator_2_qiehuanTimeOut then
        LoopManager:removeFrameByIndex(self.mAnimator_2_qiehuanTimeOut)
        self.mAnimator_2_qiehuanTimeOut = nil
    end
end

function onAnimaTweenEnd(self)
    GameDispatcher:dispatchEvent(EventName.OPENRECRUITSKIPVIEW, {isNeedClick = true, isNeedSkip = false})
end

--展示结果
function onShowRecruitResult(self)
    if not self:isRecruitType() then
        return
    end

    -- if self.mOnShowRecruitResult then return end
    -- self.mOnShowRecruitResult = true

    self:clearTimer()
    self:clearFrame()
    self:clearQualityFxGo()

    GameDispatcher:dispatchEvent(EventName.CLOSERECRUITSKIPVIEW)

    for i = 1, 3 do
        local efx = self.mQulityExfList_1[i]
        if efx ~= nil and not gs.GoUtil.IsTransNull(efx) then
            efx.gameObject:SetActive(i == self.mMaxQualiy)
        end

        efx = self.mQulityExfList_2[i]
        if efx ~= nil and not gs.GoUtil.IsTransNull(efx) then
            efx.gameObject:SetActive(false)
            efx.gameObject:SetActive(i == self.mMaxQualiy)
        end
    end

    AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_recruit_get.prefab")
    --出结果等待时间
    LoopManager:setTimeout(0.8, self, function ()
        self:ShowRecruitResult()

        AudioManager:stopAudioSound(self.m_ShootSoundAuidoData)
        self.m_ShootSoundAuidoData = nil

        if self.mAnimator_2 and not gs.GoUtil.IsCompNull(self.mAnimator_2) then
            if self.mAnimator_2.enabled then
                self.mAnimator_2.enabled = false
            end
        end
    end)
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

    --判断是不是新站员，有的话展示下立绘
    for i = 1, #self.mRecruitHeroVo do
        if i > self.mCurShowHeroInfo.index then
            local isShow = table.empty(self.mRecruitHeroVo[i].propsList)
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[i].heroTid)
            if isShow and heroConfigVo.color == 4 then
                self.mCurShowHeroInfo.index = i
                self.mCurShowHeroInfo.vo = self.mRecruitHeroVo[i]
                GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, self.mRecruitHeroVo[i])
                return
            end
        end
    end

    self:onOver()
end

--展示抽卡结果
function ShowRecruitResult(self, isSkip)
    if not table.empty(self.mRecruitHeroVo) then
        if self.mCurShowHeroInfo.index < #self.mRecruitHeroVo then
            if #self.mRecruitHeroVo == 1 then
                self.mCurShowHeroInfo.index = 1
                self.mCurShowHeroInfo.vo = self.mRecruitHeroVo[1]
                GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, {heroTid = self.mRecruitHeroVo[1].heroTid, propsList = self.mRecruitHeroVo[1].propsList, isNoSkip = true})

                self.mIsOver = true
            else
                for i = 1, #self.mRecruitHeroVo do
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

    if self.mQualityAnimator and not gs.GoUtil.IsCompNull(self.mQualityAnimator) then
        self.mQualityAnimator.gameObject:SetActive(false)
    end

    self:clearAnimator_2_qiehuanTimeOut()
    AudioManager:pauseMusicByFade(1)
end

--结算
function onOver(self)
    if not table.empty(self.mRecruitHeroVo) then
        --多抽打开AllView,单抽回到抽卡界面
        if #self.mRecruitHeroVo > 1 then
            GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ALL_VIEW)
        elseif #self.mRecruitHeroVo == 1 then
            GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, {heroTid = self.mRecruitHeroVo[1].heroTid, propsList = self.mRecruitHeroVo[1].propsList, isNoSkip = true})
            self.mIsOver = true
        end
    end
end

function isRecruitType(self)
    local recruit_id = recruit.RecruitManager:getRecruitActionId()
    local menuVo = recruit.RecruitManager:getRecruitMenuVo(recruit_id)
    if not menuVo then
        return
    end

    if menuVo.type ~= recruit.RecruitType.RECRUIT_TOP and
        menuVo.type ~= recruit.RecruitType.RECRUIT_NEW_PLAYER and
        menuVo.type ~= recruit.RecruitType.RECRUIT_ACTIVITY_1 and
        menuVo.type ~= recruit.RecruitType.RECRUIT_ACTIVITY_3 and
        menuVo.type ~= recruit.RecruitType.RECRUIT_APP_ACTTOP then
        return
    end

    return true
end

function clearTimer(self)
    if self.mShowQualityTimer then
        LoopManager:removeTimerByIndex(self.mShowQualityTimer)
        self.mShowQualityTimer = nil
    end
end

function clearFrame(self)
    if self.mTouchFrameSn then
        LoopManager:removeFrameByIndex(self.mTouchFrameSn)
        self.mTouchFrameSn = nil
    end

    if self.mOutShowRecruitSn then
        LoopManager:clearTimeout(self.mOutShowRecruitSn)
        self.mOutShowRecruitSn = nil
    end
end

function clearQualityFxGo(self)
    if self.mQualityFxGoList then
        for _, fx in pairs(self.mQualityFxGoList) do
            gs.GOPoolMgr:Recover(fx.go, fx.path)
        end
        self.mQualityFxGoList = {}
    end
end

-- 关闭当前地图
function clearMap(self)
    super.clearMap(self)

    self:clearTimer()
    self:clearFrame()
    self:clearQualityFxGo()
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.RECRUIT_HERO
end

-- 地图资源名
function getMapID(self)
    return 13
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
