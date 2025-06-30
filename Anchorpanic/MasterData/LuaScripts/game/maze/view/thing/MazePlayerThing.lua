module("maze.MazePlayerThing", Class.impl(maze.MazeBaseEventThing))

function getLayer(self)
    return maze.LAYER_PLAYER
end

function onRecover(self)
    self:stopAngleTweener()
    -- self:stopMoveTweener()
    self:removeMoveFrame()
    self.mState = nil
    self.mSpeed = nil
    self.mTempAngle = nil
	self.mHeroCuteConfigVo = nil
    super.onRecover(self)
end

function create(self, eventThingVo, finishCall)
    super.create(self, eventThingVo, finishCall)
end

function addEvents(self)
    self:getData():addEventListener(self:getData().PLAYER_POS_REFRESH, self.__onPosRefreshView, self)
    self:getData():addEventListener(self:getData().PLAYER_HP_UPDATE, self.__onHpUpdateView, self)
    self:getData():addEventListener(self:getData().PLAYER_MOVE_FINISH, self.__onMoveFinishView, self)
    self:getData():addEventListener(self:getData().PLAYER_MOVE_END, self.__onMoveEndView, self)
    self:getData():addEventListener(self:getData().PLAYER_MOVE_UPDATE, self.__onMoveUpdateView, self)
    self:getData():addEventListener(self:getData().PLAYER_MOVE_STOP, self.onStopMove, self)
end

function removeEvents(self)
    self:getData():removeEventListener(self:getData().PLAYER_POS_REFRESH, self.__onPosRefreshView, self)
    self:getData():removeEventListener(self:getData().PLAYER_HP_UPDATE, self.__onHpUpdateView, self)
    self:getData():removeEventListener(self:getData().PLAYER_MOVE_FINISH, self.__onMoveFinishView, self)
    self:getData():removeEventListener(self:getData().PLAYER_MOVE_END, self.__onMoveEndView, self)
    self:getData():removeEventListener(self:getData().PLAYER_MOVE_UPDATE, self.__onMoveUpdateView, self)
    self:getData():removeEventListener(self:getData().PLAYER_MOVE_STOP, self.onStopMove, self)
end

function updateModel(self, finishCall)
    self.mPlayerModel = maze.MazePlayerModel.new()
    self.mPlayerModel:setTid(maze.getPlayerHeroTid(), 
    function()
        self:__modelLoadComplete(finishCall)
    end)
	self.mHeroCuteConfigVo = hero.HeroCuteManager:getHeroCuteConfigVo(maze.getPlayerHeroTid())
end

function __modelLoadComplete(self, finishCall)
    self:setTrans(self.mPlayerModel:getTrans())
    self:getTrans():SetParent(maze.MazeSceneThingManager:getLayer(self:getLayer()), true)
    gs.TransQuick:LPos(self:getTrans(), self:getTilePos())
    gs.TransQuick:SetLRotation(self:getTrans(), 0, 0, 0)
    gs.GoUtil.AddComponent(self.mPlayerModel:getModelGO(), ty.FogRevealerUnit).VisionRange = sysParam.SysParamManager:getValue(SysParamType.MAZE_PLAYER_FOG_LIGHT_RANGE)

    local function actionListFinish()
        self:playAction(DormitoryCost.ACT_SHOW_STAND)
        if(finishCall)then
            finishCall()
        end
    end
    -- self.mPlayerModel.m_ani:LoadClipWithHash(DormitoryCost.ACT_SHOW_STAND)
    -- self.mPlayerModel.m_ani:LoadClipWithHash(DormitoryCost.ACT_SHOW_WALK)
    -- self.mPlayerModel:setPreLoadAnis({"Qstand", "Qwalk"}, actionListFinish)
    self.mPlayerModel:setPreLoadAnisByHashList({DormitoryCost.ACT_SHOW_STAND, DormitoryCost.ACT_SHOW_WALK}, actionListFinish)
end

function playActionTrigger(self, triggerHash, startCall, endCall,resetTriggerHash)
    if(self.mState ~= triggerHash)then
        self.mState = triggerHash
        -- self.mPlayerModel:setAnimationTriggerVal(triggerHash)
        self.mPlayerModel:playActionTrigger(triggerHash, startCall, endCall,resetTriggerHash)
    else
        if(startCall)then
            startCall()
        end
        if(endCall)then
            endCall()
        end
    end
end

function playAction(self, aniHash, startCall, endCall)
    if(self.mState ~= aniHash)then
        self.mState = aniHash
        -- self.mPlayerModel:setAnimationTriggerVal(aniHash)
        self.mPlayerModel:playAction(aniHash, startCall, endCall)
    else
        if(startCall)then
            startCall()
        end
        if(endCall)then
            endCall()
        end
    end
end

function __onPosRefreshView(self, tweenTime)
    if(tweenTime and tweenTime> 0)then
        self:__onMoveUpdateView({onceMoveTime = tweenTime, speedRate = 1})
    else
        gs.TransQuick:LPos(self:getTrans(), self:getTilePos())
    end
end

function __onHpUpdateView(self)
end

-- 移动完成
function __onMoveFinishView(self)
end

-- 移动结束
function __onMoveEndView(self, args)
    self.mSpeed = 1
    self.mPlayerModel:setAniSpeed(self.mSpeed)
    self:playActionTrigger(DormitoryCost.CONDITION_TO_STAND,nil,nil,DormitoryCost.CONDITION_TO_WALK)
end

--移动中断
function onStopMove(self)
    -- self:stopMoveTweener()
    self:stopAngleTweener()
end

function __onMoveUpdateView(self, args)
    local targetLPos = self:getTilePos()
    self:__turnDirByVector(targetLPos, true)
    -- self:stopMoveTweener()
    -- self.mMoveTweener = TweenFactory:move2Lpos(self:getTrans(), targetLPos, self.mHeroCuteConfigVo:getMazeOnceMoveTime() * args.moveSpeedRate, nil)
    self.mMoveArgs = args
    self:removeMoveFrame()
    self:addMoveFrame()

    self.mSpeed = args.animaSpeed
    self.mPlayerModel:setAniSpeed(self.mSpeed)
    self:playActionTrigger(DormitoryCost.CONDITION_TO_WALK,nil,nil,DormitoryCost.CONDITION_TO_STAND)
end

function addMoveFrame(self)
    if self.m_MoveFrameSn == nil then
        self.m_MoveFrameSn = LoopManager:addFrame(1, 0, self, self.updateMove)
    end
end

function removeMoveFrame(self)
    if self.m_MoveFrameSn == nil then return end
    LoopManager:removeFrameByIndex(self.m_MoveFrameSn)
    self.m_MoveFrameSn = nil
end

function updateMove(self)
    local targetLPos = self:getTilePos()
    self:getTrans().localPosition = gs.Vector3.MoveTowards(self:getTrans().localPosition, targetLPos, self.mMoveArgs.moveSpeedRate * gs.Time.deltaTime)

    if gs.Vector3.Distance(targetLPos,self:getTrans().localPosition) <= 0.1 then 
        self:removeMoveFrame()

        if self.mMoveArgs.callback then 
            self.mMoveArgs.callback()
        end
    end
end

function __turnDirByVector(self, targetLPos, isNow)
    local position = self:getTrans().localPosition
    position = math.Vector3(position.x, position.y, position.z)
    if targetLPos:equals(position) then
        return
    end
    local dir = position - targetLPos
    local angle = math.get_angle_ignoreY(math.Vector3.BACK, dir)
    if angle ~= nil then
        self:setAngle(angle, isNow)
    end
end

function setAngle(self, angle, isNow)
    if(not self.mTempAngle)then
        local rotation = self:getTrans().localRotation
        self.mTempAngle = math.Vector3(rotation.x, rotation.y, rotation.z)
    end
    if isNow then
        self:stopAngleTweener()
        self.mTempAngle.y = angle
        gs.TransQuick:SetRotation(self:getTrans(), 0, self.mTempAngle.y, 0)
    else
        if angle ~= self.mTempAngle.y then
            self:stopAngleTweener()
            self.mTempAngle.y = angle
            self.mAngleTweener = TweenFactory:rotate(self:getTrans(), self.mTempAngle, 0.2)
        end
    end
end

function stopAngleTweener(self)
    if (self.mAngleTweener) then
        self.mAngleTweener:Kill()
        self.mAngleTweener = nil
    end
end

-- function stopMoveTweener(self)
--     if (self.mMoveTweener) then
--         self.mMoveTweener:Kill()
--         self.mMoveTweener = nil
--     end
-- end

function clearModel(self)
    if (self.mPlayerModel) then
        if(self.mPlayerModel:getModelGO() and not gs.GoUtil.IsGoNull(self.mPlayerModel:getModelGO()))then
            gs.GoUtil.RemoveComponent(self.mPlayerModel:getModelGO(), ty.FogRevealerUnit)
        end
        self.mPlayerModel:destroy()
        self.mPlayerModel = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
