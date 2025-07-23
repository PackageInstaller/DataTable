--[[   
     主城场景
]]
module('mainCity.MainCityScene', Class.impl())
UIRes = UrlManager:getUIPrefabPath('mainCity/MainCityScene.prefab')

function ctor(self)
    -- self:loadAsset()
end

function loadAsset(self)
    if (self.UIRes ~= nil and self.UIRes ~= '') then
        if (self.IsAsyn == nil or self.IsAsyn == false) then
            AssetLoader.PreLoad(self.UIRes, self.onLoadAssetComplete, self)
        else
            AssetLoader.PreLoadAsyn(self.UIRes, self.onLoadAssetComplete, self)
        end
    end
end

function onLoadAssetComplete(self)
    -- 实例化是一个克隆对象，并不是加载的那个prefab，需要重新取
    self.UIObject = AssetLoader.GetGO(self.UIRes, self)
    self.UITrans = self.UIObject.transform
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)
end

function active(self)
    GameDispatcher:addEventListener(EventName.HERO_LIST_INIT, self.onInitHeroListHandler, self)
    GameDispatcher:addEventListener(EventName.SET_MAIN_SCENE_GYRO, self.onGryoEnableHandler, self)
    GameDispatcher:addEventListener(EventName.MAINUI_SPINE_MODEL_CHANGE, self.onChangeDynamicPicHandler, self)
    GameDispatcher:addEventListener(EventName.MAINUI_SPINE_DRAG_START, self.starDragSpine, self)
    GameDispatcher:addEventListener(EventName.MAINUI_SPINE_DRAG_END, self.endDragSpine, self)
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.HERO_LIST_INIT, self.onInitHeroListHandler, self)
    GameDispatcher:removeEventListener(EventName.SET_MAIN_SCENE_GYRO, self.onGryoEnableHandler, self)
    GameDispatcher:removeEventListener(EventName.MAINUI_SPINE_MODEL_CHANGE, self.onChangeDynamicPicHandler, self)
    GameDispatcher:removeEventListener(EventName.MAINUI_SPINE_DRAG_START, self.starDragSpine, self)
    GameDispatcher:removeEventListener(EventName.MAINUI_SPINE_DRAG_END, self.endDragSpine, self)

    if self.sceneGyro then
        self.sceneGyro:removeGyro()
        self.sceneGyro = nil
    end

    self:clear()
end

function onGryoEnableHandler(self)
    local enable = web.WebManager.platform ~= web.DEVICE_TYPE.WINDOWS and CS.UnityEngine.supportsGyroscope
    if enable then
        enable = enable and
        systemSetting.SystemSettingManager:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.gyro)
    end

    gs.UnityEngineUtil.SetGyro(enable)

    if self.sceneGyro then
        self.sceneGyro:resetTran()
        self.sceneGyro:setRun(enable)
    end
    -- if self.modelGyro then
    --     self.modelGyro:runStart(start)
    -- end
end

function linkMainSceneGyro(self)
    if self.sceneGyro == nil then
        self.sceneGyro = SceneGyro.new()
        self.sceneGyro:attach(self.m_modelView, gs.GameObject.Find("Gyro_nodel"))
    end

    local enable = web.WebManager.platform ~= web.DEVICE_TYPE.WINDOWS and CS.UnityEngine.supportsGyroscope
    if enable then
        enable = enable and
        systemSetting.SystemSettingManager:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.gyro)
    end

    gs.UnityEngineUtil.SetGyro(enable)
end

function setMoveModel(self, bo)
    if self.sceneGyro then
        self.sceneGyro:setMoveModel(bo)
    end
end


function onInitHeroListHandler(self)
    if (self.mVisible == nil or self.mVisible == true) then
        self:updateModel()
    end
end

function clear(self)
    self:recyModel()
end

function setSceneActive(self, state, isChange)
    self.mVisible = state
    if (state) then
        self:updateModel(isChange)
    else
        self:recyModel()
    end
end

function recyModel(self)
    if self.sceneGyro then
        self.sceneGyro:resetTran()
        self.sceneGyro:setRun(false)
    end

    self:clearSpine()

    -- self:onGryoEnableHandler()
    mainui.MainUIManager:StopCvMutual()

    if self.m_modelView then
        self.m_modelView:stopPlayCv()
        self.m_modelView:destroy()
        self.m_modelView = nil
    end

    LoopManager:removeTimerByIndex(self.mTimeSn)
    LoopManager:removeFrame(self, self.onUpdate)
end

function updateModel(self, isChange)
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_MAIN, nil, nil, "")

    local groupData = role.RoleManager:getHeroGroup()
    if not groupData or table.empty(groupData) and role.RoleManager:getHeroGroupShowSpine() == 1 then
        -- 没有保存动态立绘设置，自动改回模型
        -- gs.Message.Show("助理助未设置，已关闭使用动态立绘")
        gs.Message.Show(_TT(41743))
        role.RoleManager:setHeroGroupShowSpine(0)
    end

    if mainui.MainUIManager:getIsShowDynamic() == 1 and hero.HeroInteractManager:getShowBoardHeroDynamic() then
        self:updateShowSpine()
        return
    end

    local id = role.RoleManager:getRoleVo():getShowBoardHeroId()
    local heroVo = hero.HeroManager:getHeroVo(id)
    if (heroVo) then
        self:recyModel()
        self.isCompleteCall = false
        self.m_modelView = fight.LiveView.new()
        if self.m_modelView.tid ~= heroVo.tid then
            self.m_modelView:setHeroId(heroVo.id, true, nil, function()
                self:__updateModelComplete(isChange)
            end)
            self.m_modelView:setModeType(MainCityConst.ROLE_MODE_MAIN)
            self.m_modelView:setDynamicBoneEnable(false)
            gs.GoUtil.AddComponent(self.m_modelView:getRootGO(), ty.LightRotate)

            LoopManager:removeTimerByIndex(self.mTimeSn)
            self.mTimeSn = LoopManager:addTimer(8, 1, self, self.onTimeOver) --8秒后强进
        end

        if self.sceneGyro then
            local enable = web.WebManager.platform ~= web.DEVICE_TYPE.WINDOWS and CS.UnityEngine.supportsGyroscope
            if enable then
                enable = enable and
                systemSetting.SystemSettingManager:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.gyro)
            end

            self.sceneGyro:resetTran()
            self.sceneGyro:setRun(enable)
        end
    end
end

function onTimeOver(self)
    self:__updateModelComplete()
end

function __updateModelComplete(self, isChange)
    if self.isCompleteCall then
        return
    end
    self.isCompleteCall = true
    LoopManager:removeTimerByIndex(self.mTimeSn)

    self:updateModelCamera()
    if isChange then
        self.m_modelView:removeOtherEft1()
        self.m_modelView:addOtherEft0("arts/fx/3d/scene/fx_ui_common_zhuanhuan.prefab", nil, nil, nil)
    end

    local init = self.sceneGyro == nil

    self:linkMainSceneGyro()
    if init then
        self.sceneGyro:setRun(true)
    end

    -- self:onSetMainSceneGryoHandler(true)

    self:startInitMainUI(isChange)
end

-- 更新显示模型或spine
function updateShowSpine(self)
    self:clearSpine()
    local modelId = hero.HeroInteractManager:getShowBoardHeroModelId()
    if not modelId then
        return
    end
    local blackLayer = SubLayerMgr:getLayer(gud.SPINE_BLACK)
    if blackLayer and not gs.GoUtil.IsTransNull(blackLayer) then
        blackLayer.gameObject:SetActive(true)
    end

    local onLoadSpineFinish = function(go)
        self.mSpineGo = go
        gs.TransQuick:SetParentOrg(self.mSpineGo.transform, GameView.scene)

        local state = hero.HeroInteractManager:getShowBoardUnique()
        if state then
            self.spineInteract = require('game/spineInteract/SpineInteract_' .. modelId).new()
            if self.spineInteract then
                self.spineInteract:setup(self.mSpineGo, modelId)
            end
        end


        self:startInitMainUI()
    end
    self.mSpineLoadSn = gs.ResMgr:LoadGOAysn(string.format("arts/fx/spine/%s/spine_%s.prefab", modelId, modelId), onLoadSpineFinish)
end

function playSpineAnim(self)
    if not self.mSpineGo then
        return
    end
    local modelId = hero.HeroInteractManager:getShowBoardHeroModelId()
    if not modelId then
        return
    end

    local time = os.time()
    if self.mClickTime and time < self.mClickTime then
        return
    end

    local spineTrans = self.mSpineGo.transform:Find("mGroup/spine_" .. modelId)
    local anim = spineTrans:GetComponent(ty.Animator)
    if anim and not gs.GoUtil.IsCompNull(anim) then
        local tweenTime = AnimatorUtil.getAnimatorClipTime(anim, "anim01")
        if modelId == "4506_3" then
            -- 先写死
            self.mClickTime = time + 99999
        else
            self.mClickTime = time + tweenTime
        end

        anim:SetTrigger("show")
    end
end

function clearSpine(self)
    if self.mSpineLoadSn and self.mSpineLoadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.mSpineLoadSn)
        self.mSpineLoadSn = nil
    end
    if self.spineInteract then
        self.spineInteract:destroy()
        self.spineInteract = nil
    end
    if self.mSpineGo then
        gs.GameObject.Destroy(self.mSpineGo)
        self.mSpineGo = nil
    end
    self.mClickTime = 0

    local blackLayer = SubLayerMgr:getLayer(gud.SPINE_BLACK)
    if blackLayer and not gs.GoUtil.IsTransNull(blackLayer) then
        blackLayer.gameObject:SetActive(false)
    end

    LoopManager:removeFrame(self, self.onUpdate)
end

-- 切换动态立绘和模型
function onChangeDynamicPicHandler(self)
    local state = mainui.MainUIManager:getIsShowDynamic()
    if state == 0 then
        mainui.MainUIManager:setIsShowDynamic(1)
        self:recyModel()
        self:updateShowSpine()
    else
        self:clearSpine()
        mainui.MainUIManager:setIsShowDynamic(0)
        self:updateModel(true)
    end
end

-- 开始拖拽spine准备切换
function starDragSpine(self)
    self.dragSpineMousePos = gs.Input.mousePosition
    if not self.mSpineGo then
        return
    end

    LoopManager:addFrame(1, 0, self, self.onUpdate)

end

-- 结束拖拽spine准备切换
function endDragSpine(self)
    LoopManager:removeFrame(self, self.onUpdate)
    if not self.dragSpineMousePos then
        return
    end
    if self.mSpineGo then
        gs.TransQuick:LPosX(self.mSpineGo.transform, 0)
    end

    local pos = gs.Input.mousePosition - self.dragSpineMousePos
    if math.abs(pos.x) > 500 then
        local state = pos.x > 0 and 1 or 2
        mainui.MainUIManager.isDragSpine = true

        local tempIndex = 1
        local currIndex = 1
        local currId = 0
        local groupData = role.RoleManager:getHeroGroup()
        local showId = role.RoleManager:getRoleVo():getShowBoardHeroId()
        if not groupData or table.empty(groupData) then
            return
        end
        -- 表里最大最小键
        local maxIndex, minIndex = nil, nil
        for key, v in pairs(groupData) do
            local key = tonumber(key)
            if maxIndex == nil or key > maxIndex then
                maxIndex = key
            end
            if minIndex == nil or key < minIndex then
                minIndex = key
            end

        end

        -- 取当前的展示的key
        for k, v in pairs(groupData) do
            if v == showId then
                currIndex = tonumber(k)
                break
            end
        end

        if state == 1 then
            tempIndex = minIndex
            if currIndex <= tempIndex then
                currIndex = maxIndex + 1
            end
            for k, v in pairs(groupData) do
                if tonumber(k) < currIndex and tonumber(k) >= tempIndex and v and v > 0 then
                    tempIndex = tonumber(k)
                    currId = v
                end
            end
        end
        if state == 2 then
            tempIndex = maxIndex
            if currIndex >= tempIndex then
                currIndex = minIndex - 1
            end
            for k, v in pairs(groupData) do
                if tonumber(k) > currIndex and tonumber(k) <= tempIndex and v and v > 0 then
                    tempIndex = tonumber(k)
                    currId = v
                end
            end
        end
        if currId > 0 and currId ~= showId then
            GameDispatcher:dispatchEvent(EventName.REQ_CHANGE_SHOW_BOARD_HERO, { heroId = currId })
        end
    end
end

-- 插值缓动
function onUpdate(self)
    local pos = gs.Input.mousePosition - self.dragSpineMousePos
    local currX = pos.x * 0.2
    currX = math.max(-230, math.min(currX, 230))
    gs.TransQuick:LPosX(self.mSpineGo.transform, currX)
end

-- 开始进入主UI流程
function startInitMainUI(self, isChange)
    -- 主UI进入流程，包括登录和其他场景退出等
    -- 延迟一帧，避免主UI动效显示第一帧异常
    LoopManager:addFrame(1, 1, self, function()
        -- 关闭登录的初始加载界面
        if (loginLoad.LoginLoadController:isLoginLoading()) then
            loginLoad.LoginLoadController:destroyLoading()
        end

        UIFactory:closeForcibly()
        GameDispatcher:dispatchEvent(EventName.START_CHECK_TRIGGER_DOWNLOAD)

        -- 此处比如迷宫的奖励预览里的道具tip跳转到商店，这里先打开了商店后才加载完主场景，然后模型异步加载完又打开主UI，此时关闭商店后执行的主界面open逻辑里被return导致没显示主界面货币栏
        local allOpenCount = gs.PopPanelManager.GetAllPanelCount(1)
        if (allOpenCount <= 0 and not isChange) then
            GameDispatcher:dispatchEvent(EventName.MAIN_CITY_RT_UPDATE, true)
            GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI, { isShowTween = true, isFirstCV = true })
        end

    end)
    -- mainCity.MainCityController:playMainCityMusic()
    -- 通知打开战斗前的功能UI
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_SHOW_BEFORE_UI)
end

function updateModelCamera(self)
    if (self.m_modelView) then
        -- local cameraNode = gs.GameObject.Find("OriginalCameraPos")
        -- local roleNode = gs.GameObject.Find("Role_node")
        -- print(self.__cname, "主场景更新模型", cameraNode, roleNode)
        -- Perset3dHandler:setSceneShowData(MainCityConst.ROLE_MODE_MAIN, nil, cameraNode and cameraNode.transform or nil, roleNode and roleNode.transform or nil)
        Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_MAIN, self.m_modelView:getTrans(),
        self.m_modelView:getModelId())
    end
end

function moveCamera(self, cusType)
    local cameraGo = gs.GameObject.Find("[SCamera]")
    if cusType == 2 then
        TweenFactory:lRotate(cameraGo.transform, gs.Vector3(0, -10, 0), 0.3)
    else
        TweenFactory:lRotate(cameraGo.transform, gs.Vector3(0, 0, 0), 0.3)
    end
end


-- 播放动画
function playAction(self)
    if self.m_modelView then
        local function finishCall(ret)
            mainui.MainUIManager:setIsInteract(false)
        end

        local startPlayCvCall = function(audioData)
            mainui.MainUIManager:setCurPlayCv(audioData)
        end

        local finishPlayCvCall = function()
            GameDispatcher:dispatchEvent(EventName.MAINUI_LIVEVIEW_CVCALLFINISH)
            mainui.MainUIManager:setCurPlayCv(nil)
        end

        -- mainui.MainUIManager:stopCurPlayCv()
        mainui.MainUIManager:setIsInteract(true)
        return self.m_modelView:playClickAction(finishCall, startPlayCvCall, finishPlayCvCall)
    end

    -- 立绘处理
    local ret, baseData = mainui.MainUIManager:getHeroInteract()

    local finishPlayCvCall = function()
        GameDispatcher:dispatchEvent(EventName.MAINUI_LIVEVIEW_CVCALLFINISH)
        mainui.MainUIManager:setCurPlayCv(nil)
    end

    local audioData = AudioManager:playHeroCVOnReplace(baseData.cv_id, finishPlayCvCall)
    mainui.MainUIManager:setCurPlayCv(audioData)

    return ret, baseData
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]