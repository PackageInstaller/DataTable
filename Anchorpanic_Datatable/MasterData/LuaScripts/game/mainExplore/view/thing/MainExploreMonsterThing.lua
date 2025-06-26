--[[
-----------------------------------------------------
@filename       : MainExploreMonsterThing
@Description    : 主线探索怪物
@date           : 2022-2-11
@Author         : Zzz
@copyright      : (LY) 2018 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreMonsterThing", Class.impl(mainExplore.MainExploreBaseThing))

--构造函数
function ctor(self)
    super.ctor(self)
end

function onAwake(self)
    super.onAwake(self)
end

function onRecover(self)
    super.onRecover(self)
end

function initData(self)
    super.initData(self)
    self.mThingVo = nil
end

-- 主线探索：回收时父类会调用dtor，已经回收到对象池了定时销毁也会触发，所以要确保该方法逻辑做好无数据的判断
function destroy(self)
    if (self:getRootGO() and not gs.GoUtil.IsGoNull(self:getRootGO())) then
        self:removeObstacle(self:getRootGO())
    end
    super.destroy(self)
end

function setData(self, thingVo, aiCtrl, loadFinish)
    self.mThingVo = thingVo
    self:setAiCtrl(aiCtrl)
    self:setEnableUpdate(true)
    local _loadFinish = function()
        self:initTrans()
        if(self:getEventConfigVo().enableObstacle)then
            local type, center, size = self:getEventConfigVo():getObstacleData()
            if(type and center and size)then
                self:addObstacle(self:getRootGO(), type == 2, center, size)
            end
        end
        if(loadFinish)then
            loadFinish()
        end
    end
    self:setPrefab(self:getEventConfigVo().modelPrefab, false, _loadFinish)
end

function initTrans(self)
    self:setPosition(self.mThingVo:getPosition())
    self:setRotation(self.mThingVo:getRotation())
    self:setScale(self.mThingVo:getScale())
    self:getTrans().name = string.format("event_thing_%s_%s", self:getEventConfigVo().eventType, self:getEventConfigVo().eventId)
end

function getThingVo(self)
    return self.mThingVo
end

function getEventConfigVo(self)
    return self.mThingVo:getEventConfigVo()
end

function addEvents(self)
    super.addEvents(self)
end

function removeEvents(self)
    super.removeEvents(self)
end

function onMoveChangeHandler(self, args)
    self:setPosition(self.mThingVo:getPosition())
end

function onDirChangeHandler(self, args)
    self:setRotation(self.mThingVo:getRotation())
end

function onScaleChangeHandler(self, args)
    self:setScale(self.mThingVo:getScale())
end

-- 帧更新
function onUpdateFrameHandler(self, deltaTime)
    if(not self:getEnableUpdate())then
        self:setBehaviorState(mainExplore.BehaviorState.IDLE, nil, nil)
    end
    super.onUpdateFrameHandler(self, deltaTime)
end

-- 目标点移动
function moveStpe(self, deltaTime, nextPos, range, moveSpeed, gravity)
    local dir = (nextPos - self:getPosition()):normalize()
    if(not mainExplore.isZeroVector3(dir))then
        local targetRotation = gs.Quaternion.LookRotation(dir)
        if (gs.Quaternion.Angle(self:getRotation(), targetRotation) > 1) then
            self.mThingVo:setRotation(gs.Quaternion.Slerp(self:getRotation(), targetRotation, 10 * deltaTime))
        end
    end
    local offsetVector3 = math.Vector3(dir.x, gravity or 0, dir.z) * moveSpeed * deltaTime
    self.mThingVo:setPosition(self.mThingVo:getPosition() + offsetVector3)
    
    if (math.v3Distance(nextPos, self.mThingVo:getPosition()) < (range or 0) + 0.1) then
        if(not self:isPlayingState(mainExplore.BehaviorState.IDLE))then
            self:setBehaviorState(mainExplore.BehaviorState.IDLE)
        end
    else
        if(not self:isPlayingState(mainExplore.BehaviorState.MONSTER_TARGET_POS_MOVE))then
            self:setBehaviorState(mainExplore.BehaviorState.MONSTER_TARGET_POS_MOVE)
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
