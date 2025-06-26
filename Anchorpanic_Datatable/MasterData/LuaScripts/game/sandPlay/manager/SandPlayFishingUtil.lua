-- @FileName:   SandPlayFishingUtil.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-29 17:33:37
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.utils.SandPlayFishingUtil', Class.impl())

m_CameraPath = "arts/character/pet/Camera/modelCamera.prefab"
m_WeaponPath = "arts/character/scene_module/fish/3101_qb_yg_01/model3101_qb_yg_01.prefab"

isFishing = false

function active(self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_CLICK, self.onClickFish, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_SUCCESS, self.onSuccessFish, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_FAIL, self.onFailFish, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_RECEIVE_FISH, self.showFishingResult, self)

end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_FISHING_CLICK, self.onClickFish, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_FISHING_SUCCESS, self.onSuccessFish, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_FISHING_FAIL, self.onFailFish, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_FISHING_RECEIVE_FISH, self.showFishingResult, self)

    self:clearData()

    self:clearReadyEatTimeSn()

    self:clearWaterFish()
end

--成功调到鱼
function onSuccessFish(self)
    --在win动作上添加鱼的展示
    if self.m_eatFishInfo then
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_fs_6.prefab")

        self.mPlayerThing:forceActionState(SandPlayConst.HERO_ACTION_STATE.FISH_WIN01)

        local fishConfigVo = sandPlay.SandPlayManager:getFishConfigVo(self.m_eatFishInfo.fish_id)
        local showWinFish_Path = string.format("arts/character/scene_module/fish/%s", fishConfigVo.modelName)

        local parent = gs.GoUtil.FindNameInChilds(self.mPlayerThing:getTrans(), "Fish_node")
        self.mShowWinFish = self:addWinShowFish(showWinFish_Path, parent)

        GameDispatcher:dispatchEvent(EventName.SANDPLAY_CLOSE_FISHING_UI)

        --向服务端上行钓鱼结果
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_ONREQ_FISHING, self.m_eatFishInfo)

        self:clearWaterFish()
    end
end

--失败调到鱼
function onFailFish(self)
    if self.mPlayerThing:setActionState(SandPlayConst.HERO_ACTION_STATE.FISH_CHANGE) then
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_fs_2.prefab")
        if self.m_eatFishInfo then
            gs.Message.Show(_TT(98337))
        end

        GameDispatcher:dispatchEvent(EventName.SANDPLAY_CLOSE_FISHING_UI)
    end

    self:clearWaterFish()
end

function addWinShowFish(self, path, parent)
    local showFish = {}
    showFish.m_go = gs.GOPoolMgr:Get(path, false)

    if showFish.m_go == nil or gs.GoUtil.IsGoNull(showFish.m_go) then
        gs.GOPoolMgr:Recover(showFish.m_go, path)
        showFish = nil
        return
    end

    showFish.m_go:SetActive(true)
    showFish.mAnimator = showFish.m_go:GetComponent(ty.Animator)
    showFish.mAnimatCall = showFish.m_go:GetComponent(ty.AnimatCall)

    showFish.m_path = path
    if parent and not gs.GoUtil.IsTransNull(parent) and not gs.GoUtil.IsTransNull(showFish.m_go.transform) then
        wpos = wpos or gs.VEC3_ZERO
        gs.TransQuick:SetParentOrg01(showFish.m_go, parent)
        gs.TransQuick:LPos(showFish.m_go.transform, wpos)
    end

    showFish.playAction = function (fish, actionName)
        if fish.mAnimator and not gs.GoUtil.IsCompNull(fish.mAnimator) then
            fish.mAnimator:Play(actionName)
        end
    end

    showFish.addFrameCallEvent = function(fish, key, funcall)
        if fish.mAnimatCall and not gs.GoUtil.IsCompNull(fish.mAnimatCall) then
            fish.mAnimatCall:AddFrameEventCall(key, funcall)
        end
    end

    showFish.recover = function (fish)
        gs.GOPoolMgr:Recover(fish.m_go, fish.m_path)
    end

    return showFish
end

function showFishingResult(self)
    if not self.mShowRecruitResult_Success then
        return
    end

    local curFishingFishResult = sandPlay.SandPlayManager:getCurFishingFishResult()
    if curFishingFishResult then
        curFishingFishResult.fish_info.cur_size = self.m_eatFishInfo.size
        local finishCall = function (isAutoFish)
            sandPlay.SandPlayManager:setCurFishingFishResult(nil)

            if self.mShowWinFish then
                self.mShowWinFish:recover()
                self.mShowWinFish = nil
            end

            if isAutoFish then
                self:clearData()
                GameDispatcher:dispatchEvent(EventName.SANDPLAY_OPEN_FISHING_UI)
            else
                self.mPlayerThing:revertState()
            end
        end
        GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_FISHING_RESULTPANEL, {result = curFishingFishResult, bait_id = self.m_eatFishInfo.bait_id, finishCall = finishCall})
    end
end

function addPlayerThingFrameEvent(self)
    if not self.mPlayerThing then return end

    -- local fish_node = gs.GoUtil.FindNameInChilds(self.mPlayerThing:getTrans(), "Fish_node")
    -- if fish_node and not gs.GoUtil.IsTransNull(fish_node) then
    --     local frameNameList =
    --     {
    --         "fx_fish_yuying_die",
    --         "fx_fish_yuying_ready",
    --         "fx_fish_yuying_atk01",
    --         "fx_fish_yuying_goin",
    --     }

    --     for _, frameName in pairs(frameNameList) do
    --         self.mPlayerThing:addFrameCallEvent(frameName, function ()
    --             self:addEffect(frameName .. ".prefab", fish_node)
    --         end, -1)
    --     end
    -- end

    -- --根据美术在win添加的帧事件，移除水下鱼影
    -- self.mPlayerThing:addFrameCallEvent("remove_water_fish", function ()
    --     self:clearWaterFish()
    -- end, -1)

    local aniName = SandPlayConst.HERO_ACTIONSTATE_ACTHASH[SandPlayConst.HERO_ACTION_STATE.FISH_WIN01]
    local frameCount = self.mPlayerThing:GetTotalFrameCount(aniName)
    if frameCount > 0 then

        --win 动作结束 打开结果展示界面、奖励展示界面。然后重新回到准备钓鱼阶段；清理展示的鱼模型，所有特效
        self.mPlayerThing:addFrameCallEvent(aniName, function ()
            self.mShowRecruitResult_Success = true
            self:showFishingResult()
        end, frameCount - 1)
    end

    local aniName = SandPlayConst.HERO_ACTIONSTATE_ACTHASH[SandPlayConst.HERO_ACTION_STATE.FISH_WIN02]
    local frameCount = self.mPlayerThing:GetTotalFrameCount(aniName)
    if frameCount > 0 then
        --win 动作结束 打开结果展示界面、奖励展示界面。然后重新回到准备钓鱼阶段；清理展示的鱼模型，所有特效
        self.mPlayerThing:addFrameCallEvent(aniName, function ()

            self:clearData()
            GameDispatcher:dispatchEvent(EventName.SANDPLAY_OPEN_FISHING_UI)
        end, frameCount - 1)
    end

    local aniName = SandPlayConst.HERO_ACTIONSTATE_ACTHASH[SandPlayConst.HERO_ACTION_STATE.FISH_CHANGE]
    local frameCount = self.mPlayerThing:GetTotalFrameCount(aniName)
    if frameCount > 0 then
        self.mPlayerThing:addFrameCallEvent(aniName, function ()

            self:clearData()
            GameDispatcher:dispatchEvent(EventName.SANDPLAY_OPEN_FISHING_UI)
        end, frameCount - 1)
    end

    local aniName = SandPlayConst.HERO_ACTIONSTATE_ACTHASH[SandPlayConst.HERO_ACTION_STATE.FISH_DREADY]
    local frameCount = self.mPlayerThing:GetTotalFrameCount(aniName)
    if frameCount > 0 then
        self.mPlayerThing:addFrameCallEvent(aniName, function ()
            self:readyFishEat()

            self:showWaterFish()
        end, frameCount - 1)
    end
end

--在美术添加的动画帧事件上添加特效
function addEffectFrameCallEvent(self)
    if self.mWaterFish then
        local fish_node = gs.GoUtil.FindNameInChilds(self.mPlayerThing:getTrans(), "Fish_node")
        if fish_node and not gs.GoUtil.IsTransNull(fish_node) then
            local frameNameList =
            {
                "fx_fish_yuying_die",
                "fx_fish_yuying_ready",
                "fx_fish_yuying_atk01",
                "fx_fish_yuying_goin",
            }

            for _, frameName in pairs(frameNameList) do
                self.mWaterFish:addFrameCallEvent(frameName, function ()
                    if self.mShowRecruitResult_Success then
                        return
                    end

                    self:addEffect(frameName .. ".prefab", fish_node)
                end, -1)
            end
        end

        -- local remove = function ()
        --     self:clearWaterFish()
        -- end
        -- self.mWaterFish:addFrameCallEvent("remove_water_fish", remove)
    end
end

function clearData(self)
    self.isFishing = false
    self.m_eatFishInfo = nil
    self.mShowRecruitResult_Success = false
end

--移除水下鱼影
function clearWaterFish(self)
    if self.mWaterFish then
        self.mWaterFish:recover()
        self.mWaterFish = nil
    end
end

function onStartFish(self, playerThing, cameraUtil, eventConfig)
    self.mPlayerThing = playerThing
    self.mCamera = cameraUtil

    if self.mPlayerThing then

        --先加载武器，加载完了之后再寻路。播放扛着杠走的动作
        self.mPlayerThing:addWeapon(self.m_WeaponPath, 1, false, function ()
            --寻路到钓鱼点
            local event_param = eventConfig.event_param
            local pos = {x = event_param[1][1], y = event_param[1][2], z = event_param[1][3]}
            local angle = event_param[2]

            self.mPlayerThing:findPath({param = pos, actionState = SandPlayConst.HERO_ACTION_STATE.FISH_MOVE, finishCall = function ()
                self.mPlayerThing:setAngle(angle)
                self.mPlayerThing:revertState(SandPlayConst.HERO_ACTION_STATE.FISH_MOVE)

                GameDispatcher:dispatchEvent(EventName.SANDPLAY_OPEN_FISHING_UI)
            end})

            self.mLateCameraParent = gs.CameraMgr:GetSceneCameraTrans().parent

            local TweenAngle_x = 45 - (270 - angle)
            --转镜头
            self.mCamera:DoTweenAngle(3.9, 36, TweenAngle_x, 1, function ()
                self.mPlayerThing:addAssembly(self.m_CameraPath, false, function (assembly)
                    local node = assembly.m_modelTrans:Find("Root_Camera_node/Camera_node")
                    if node and not gs.GoUtil.IsTransNull(node) then
                        gs.CameraMgr:GetSceneCameraTrans():SetParent(node, true)
                    end
                end)
            end)
        end)

        self:addPlayerThingFrameEvent()

        GameDispatcher:dispatchEvent(EventName.CLOSE_SANDPLAY_SCENEUI)
    end
end

function onExitFish(self)
    if self.mLateCameraParent then
        gs.CameraMgr:GetSceneCameraTrans():SetParent(self.mLateCameraParent, true)
    end

    self.mCamera:restoreTween()

    self.mPlayerThing:clearAssembly()
    self.mPlayerThing:removeWeapon()
    self.mPlayerThing:forceActionState(SandPlayConst.HERO_ACTION_STATE.STAND)

    self:clearWaterFish()

    GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_SCENEUI)
end

function onClickFish(self)
    if not self.isFishing then
        if self.mPlayerThing:forceActionState(SandPlayConst.HERO_ACTION_STATE.FISH_DREADY) then
            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_fs_1.prefab")
            self.isFishing = true
        end
    else
        if not self.m_eatFishInfo then
            self:clearReadyEatTimeSn()
            self:onFailFish()
        end
    end
end

--展示鱼影
function showWaterFish(self)
    local path = "arts/character/scene_module/fish/yuying/modelyuying.prefab"

    self.mWaterFish = {}
    self.mWaterFish.m_go = gs.GOPoolMgr:Get(path, false)

    if self.mWaterFish.m_go == nil or gs.GoUtil.IsGoNull(self.mWaterFish.m_go) then
        self.mWaterFish = nil
        gs.GOPoolMgr:Recover(self.mWaterFish.m_go, path)
        return
    end

    self.mWaterFish.m_go:SetActive(true)
    self.mWaterFish.mAnimator = self.mWaterFish.m_go:GetComponent(ty.Animator)
    self.mWaterFish.mAnimatCall = self.mWaterFish.m_go:GetComponent(ty.AnimatCall)

    self.mWaterFish.m_path = path

    local parent = gs.GoUtil.FindNameInChilds(self.mPlayerThing:getTrans(), "Fish_node")
    if parent and not gs.GoUtil.IsTransNull(parent) and not gs.GoUtil.IsTransNull(self.mWaterFish.m_go.transform) then
        wpos = wpos or gs.VEC3_ZERO
        gs.TransQuick:SetParentOrg01(self.mWaterFish.m_go, parent)
        gs.TransQuick:LPos(self.mWaterFish.m_go.transform, wpos)
    end

    self.mWaterFish.playAction = function (fish, actionName)
        if fish.mAnimator and not gs.GoUtil.IsCompNull(fish.mAnimator) then
            fish.mAnimator:Play(actionName)
        end
    end

    self.mWaterFish.addFrameCallEvent = function(fish, key, funcall)
        if fish.mAnimatCall and not gs.GoUtil.IsCompNull(fish.mAnimatCall) then
            fish.mAnimatCall:AddFrameEventCall(key, funcall)
        end
    end

    self.mWaterFish.recover = function (fish)
        AudioManager:stopAudioSound(self.mWaterFish.mFatkAudioData)
        self.mWaterFish.mFatkAudioData = nil
        gs.GOPoolMgr:Recover(fish.m_go, fish.m_path)
    end

    self:addEffectFrameCallEvent()
end

--准备鱼咬钩
function readyFishEat(self)
    if not self.isFishing then return end

    local curBait = sandPlay.SandPlayManager:getFishingBait()
    if curBait then
        local baitConfig = sandPlay.SandPlayManager:getBaitConfigVo(curBait)
        if baitConfig then
            local minTime, maxTime = baitConfig.bite_time[1], baitConfig.bite_time[2]
            local randomTime = math.random(minTime, maxTime)

            self:clearReadyEatTimeSn()
            self.m_EatTimeSn = LoopManager:setTimeout(randomTime, self, self.onFishGet)

            local tryEat = function ()
                if self.mWaterFish then
                    self.mWaterFish:playAction("Fready")
                    AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_fs_4.prefab")
                end
            end
            self.m_ShowWaterTimeSn = LoopManager:setTimeout(randomTime - 1.5, self, tryEat)
        end
    end
end

function clearReadyEatTimeSn(self)
    if self.m_EatTimeSn then
        LoopManager:clearTimeout(self.m_EatTimeSn)
        self.m_EatTimeSn = nil
    end

    if self.m_ShowWaterTimeSn then
        LoopManager:clearTimeout(self.m_ShowWaterTimeSn)
        self.m_ShowWaterTimeSn = nil
    end
end

--鱼咬钩
function onFishGet(self)
    self.m_eatFishInfo = sandPlay.SandPlayManager:getFishByCurBait()
    if self.m_eatFishInfo then

        local action = SandPlayConst.HERO_ACTION_STATE.FISH_ATK01
        local random = math.random(1, 3)
        if random == 1 then
            action = SandPlayConst.HERO_ACTION_STATE.FISH_ATK01
        elseif random == 2 then
            action = SandPlayConst.HERO_ACTION_STATE.FISH_ATK02
        elseif random == 3 then
            action = SandPlayConst.HERO_ACTION_STATE.FISH_ATK03
        end

        self.mPlayerThing:setActionState(action)
        gs.Message.Show(_TT(98343))

        self:clearReadyEatTimeSn()
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_FISHEAT, self.m_eatFishInfo)
    end

    if self.mWaterFish then
        self.mWaterFish:playAction("Fatk01")
        self.mWaterFish.mFatkAudioData = AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_fs_5.prefab", true)
    end
end

function addEffect(self, effctName, parent)
    if string.NullOrEmpty(effctName) then return end

    -- if not self.mEffectList then
    --     self.mEffectList = {}
    -- end

    -- local effct = sandPlay.SandPlay_effect:create(SandPlayConst.getEffectPath(effctName), parent)
    sandPlay.SandPlay_effect:create(nil, SandPlayConst.getEffectPath(effctName), parent)
end

return _M
