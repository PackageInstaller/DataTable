--[[
-----------------------------------------------------
@filename       : MainExploreBaseThing
@Description    : 主线探索基类对象
@date           : 2022-2-11
@Author         : Zzz
@copyright      : (LY) 2018 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreBaseThing", Class.impl(model.modelLive))

--构造函数
function ctor(self)
    super.ctor(self)
    self:initData()
end

function onAwake(self)
    super.onAwake(self)
end

function onRecover(self)
    super.onRecover(self)
end

-- 主线探索：回收时父类会调用dtor，已经回收到对象池了定时销毁也会触发，所以要确保该方法逻辑做好无数据的判断
function destroy(self)
    self:removeEvents()
    self:removeUpdateFrameSn()
    self:recoverAiCtrl()
    self:initData()
    super.destroy(self)
end

function initData(self)
    self.m_tid = nil
    self.m_modelId = nil
    self.m_liveType = nil
    self.m_curAniHash = nil
    self.m_uiPrefabPath = nil
    self.m_uiShowWeaponSn = nil

    -- 行为状态
    self.mBehaviorState = nil
    -- 正在播放的动作
    self.mPlayingState = nil
    -- 记录暂停时的速度
    self.mRecordSpeed = nil
    -- AI控制器
    self.mAiCtrl = nil
    -- 帧更新能力
    self.mEnableUpdate = nil
    -- 显示状态
    self.mCurVisible = true
end

function setAiCtrl(self, aiCtrl)
    self:recoverAiCtrl()
    self.mAiCtrl = aiCtrl
end

function getAiCtrl(self)
    return self.mAiCtrl
end

function recoverAiCtrl(self)
    if(self.mAiCtrl)then
        self.mAiCtrl:poolRecover()
        self.mAiCtrl = nil
    end
end

-- 注册动作回调事件，未监听的动作回调需要添加注册监听
function _setupAniCallSys(self)
    -- self.m_ani:AddNeedCallHash()
    super._setupAniCallSys(self)
end

function setTID(self, mTid, heroType, finishCall)
    self.m_tid = mTid
    self.m_liveType = heroType
    if heroType == 0 then
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(mTid)
        if heroConfigVo then
            self:setModelID(heroConfigVo.model, heroType, finishCall)
            return
        end
    elseif heroType == 1 then
        local monsterConfigVo = monster.MonsterManager:getMonsterVo01(mTid)
        if monsterConfigVo then
            if monsterConfigVo.type == 3 then
                self:setModelID(monsterConfigVo.model, heroType, finishCall)
            else
                self:setModelID(monsterConfigVo.model, heroType, finishCall)
            end
            return
        end
    end
    logError("mTid = [" .. tostring(mTid) .. "] 没有数据")
end

function setModelID(self, modelID, heroType, finishCall)
    self.m_modelId = modelID
    local prefabPath = nil
    if heroType == 0 then
        prefabPath = UrlManager:getRolePath01(modelID)
    else
        prefabPath = UrlManager:getMonsterPath01(modelID)
    end

    if self.m_uiPrefabPath ~= prefabPath then
        self:removeWeapon()
        self:setPrefab(prefabPath, false, finishCall)
        self.m_uiPrefabPath = prefabPath
        self.m_uiShowWeaponSn = -1
    else
        if finishCall then
            if(self.mAiCtrl)then
                self.mAiCtrl:create(self)
            end
            finishCall()
        end
    end
    
    if(heroType == 0)then
        local modeShowRo = fight.RoleShowManager:getShowData(self.m_modelId)
        if modeShowRo then
            local wpath = UrlManager:getWeaponPath(string.format("%s_wq_%02d/model%s_wq_%02d.prefab", modelID, 1, modelID, 1))
            self:addWeapon(wpath, modeShowRo:getWeaponNode(), false)
        end
    end
end

function setPrefab(self, prefabPath, beAlwayEft, finishCall)
    local loadActionFinish = function()
        self:setPlayAction(mainExplore.BehaviorState.IDLE, nil, nil)
        if(self:getEnableUpdate())then
            self:addUpdateFramSn()
        end
        self:addEvents()
        if(finishCall)then
            if(self.mAiCtrl)then
                self.mAiCtrl:create(self)
            end
            finishCall()
        end
    end
    local loadFinish = function()
        self:setPreLoadAnisByHashList({fight.FightDef.ACT_STAND, fight.FightDef.ACT_RUN}, loadActionFinish)
        -- self:setWeaponLoadFightAni(true,{fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_STAND], fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_RUN]})
    end
    self:setDynamicBoneEnable(false)
    super.setupPrefab(self, prefabPath, beAlwayEft, loadFinish)
end

function playAction(self, aniHash, startCall, endCall)
    if (self.m_curAniHash ~= aniHash) then
        super.playAction(self, aniHash, startCall, endCall)
    else
        if(startCall)then
            startCall()
        end
        if(endCall)then
            endCall()
        end
    end
end

function playFade(self, aniHash, startCall, endCall)
    if (self.m_curAniHash ~= aniHash) then
        super.playFade(self, aniHash, startCall, endCall)
    else
        if(startCall)then
            startCall()
        end
        if(endCall)then
            endCall()
        end
    end
end

function addUpdateFramSn(self)
    self:removeUpdateFrameSn()
    self.mUpdateFrameSn = LoopManager:addFrame(1, 0, self, self.__onUpdateFrameHandler)
end

function removeUpdateFrameSn(self)
    if (self.mUpdateFrameSn) then
        LoopManager:removeFrameByIndex(self.mUpdateFrameSn)
        self.mUpdateFrameSn = nil
    end
end

function addEvents(self)
    if(self.mThingVo)then
        self.mThingVo:addEventListener(self.mThingVo.MOVE_CHANGE, self.onMoveChangeHandler, self)
        self.mThingVo:addEventListener(self.mThingVo.DIR_CHANGE, self.onDirChangeHandler, self)
        self.mThingVo:addEventListener(self.mThingVo.SCALE_CHANGE, self.onScaleChangeHandler, self)
    end
    GameDispatcher:addEventListener(EventName.MAIN_EXPLORE_RATE_UPDATE, self.onRateUpdateHandler, self)
end

function removeEvents(self)
    if(self.mThingVo)then
        self.mThingVo:removeEventListener(self.mThingVo.MOVE_CHANGE, self.onMoveChangeHandler, self)
        self.mThingVo:removeEventListener(self.mThingVo.DIR_CHANGE, self.onDirChangeHandler, self)
        self.mThingVo:removeEventListener(self.mThingVo.SCALE_CHANGE, self.onScaleChangeHandler, self)
    end
    GameDispatcher:removeEventListener(EventName.MAIN_EXPLORE_RATE_UPDATE, self.onRateUpdateHandler, self)
end

function onMoveChangeHandler(self, args)
end

function onDirChangeHandler(self, args)
end

function onScaleChangeHandler(self, args)
end

function onRateUpdateHandler(self)
    if(mainExplore.MainExploreManager:getRate() ~= 0)then
        if(self.resume)then
            self:resume()
        end
    else
        if(self.pause)then
            self:pause()
        end
    end
end

function __onUpdateFrameHandler(self, deltaTime)
    deltaTime = deltaTime * mainExplore.MainExploreManager:getRate()
    if(deltaTime > 0)then
        self:onUpdateFrameHandler(deltaTime)
    end
end

-- 帧更新
function onUpdateFrameHandler(self, deltaTime)
    if(not self:getEnableUpdate())then
        return
    end
    if(self.mAiCtrl)then
        self.mAiCtrl:step(deltaTime)
    end
end

-- 设置坐标
function setPosition(self, localPosition)
    super.setPosition(self, localPosition)
end

-- 获取坐标
function getPosition(self)
    return self:getTrans().position
end

-- 设置角度
function setRotation(self, rotation)
    gs.TransQuick:SetRotation(self:getTrans(), 0, rotation.y, 0)
end

-- 获取角度
function getRotation(self)
    return self:getTrans().rotation
end

-- 设置大小
function setScale(self, scale)
    gs.TransQuick:Scale(self:getTrans(), scale.x, scale.y, scale.z)
end

-- 获取大小
function getScale(self)
    return self:getTrans().localScale
end

-- 设置模型播放速度
function setAniSpeed(self, speed)
    super.setAniSpeed(self, speed)
end

-- 暂停
function pause(self)
    self.mRecordSpeed = self.m_aniSpeed
    self:setAniSpeed(0)
end

-- 恢复播放
function resume(self)
    if(self.mRecordSpeed)then
        self:setAniSpeed(self.mRecordSpeed)
        self.mRecordSpeed = nil
    end
end

-- 设置行为状态
function setBehaviorState(self, state, startCall, endCall)
    if(self.mBehaviorState ~= state)then
        local lastBehaviorState = self.mBehaviorState
        self.mBehaviorState = state
        if(not self:isPlayingState(state))then
            self.mPlayingState = state
            local function playFinish()
                self.mPlayingState = nil
                if(endCall)then
                    endCall()
                end
            end
            local triggerHash = mainExplore.getTriggerHashByState(state)
            if(triggerHash)then
                self:playActionTrigger(triggerHash, startCall, playFinish, mainExplore.getTriggerHashByState(lastBehaviorState))
            else
                self:playAction(mainExplore.getActionHashByState(state), startCall, playFinish)
            end
        end
    else
        if(startCall)then
            startCall()
        end
        if(endCall)then
            endCall()
        end
    end
end

function setPlayAction(self, state, startCall, endCall)
    if(self.mBehaviorState ~= state)then
        self.mBehaviorState = state
        if(not self:isPlayingState(state))then
            self.mPlayingState = state
            local function playFinish()
                self.mPlayingState = nil
                if(endCall)then
                    endCall()
                end
            end
            self:playAction(mainExplore.getActionHashByState(state), startCall, playFinish)
        end
    else
        if(startCall)then
            startCall()
        end
        if(endCall)then
            endCall()
        end
    end
end

function recoverBehaviorState(self, startCall, endCall)
    if(self.mBehaviorState ~= nil)then
        if(not self:isPlayingState(self.mBehaviorState))then
            self.mPlayingState = self.mBehaviorState
            local function playFinish()
                self.mPlayingState = nil
                if(endCall)then
                    endCall()
                end
            end
            self.m_curAniHash = nil
            self:playAction(mainExplore.getActionHashByState(self.mBehaviorState), startCall, playFinish)
        end
    else
        if(startCall)then
            startCall()
        end
        if(endCall)then
            endCall()
        end
    end
end

-- 获取行为状态
function getBehaviorState(self)
    return self.mBehaviorState or mainExplore.BehaviorState.IDLE
end

-- 是否正在播放某个行为动画
function isPlayingState(self, state)
    return self.mPlayingState == state
end

function addObstacle(self, go, isCapsule, center, size)
    self.mObstacleAgent = gs.GoUtil.AddComponent(go, ty.NavMeshObstacle)
    self.mObstacleAgent.shape = isCapsule and gs.NavMeshObstacleShape.Capsule or gs.NavMeshObstacleShape.Box
    self.mObstacleAgent.center = center
    self.mObstacleAgent.size = size
end

function removeObstacle(self, go)
    gs.GoUtil.RemoveComponent(go, ty.NavMeshObstacle)
    self.mObstacleAgent = nil
end

function setEnableUpdate(self, enable)
    self.mEnableUpdate = enable
end

function getEnableUpdate(self)
    return self.mEnableUpdate or false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
