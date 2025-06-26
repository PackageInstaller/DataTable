--[[
-----------------------------------------------------
@filename       : MainExploreNormalThing
@Description    : 主线探索通用对象
@date           : 2022-2-11
@Author         : Zzz
@copyright      : (LY) 2018 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreNormalThing", Class.impl(mainExplore.MainExploreBaseThing))

--构造函数
function ctor(self)
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
    local trans = self:getTrans()
    if (trans and not gs.GoUtil.IsTransNull(trans)) then
        self:removeObstacle(self:getTrans().gameObject)
        gs.GameObject.Destroy(trans.gameObject)
        self:setTrans(nil)
    end
    self:initData()
end

function initData(self)
    self.m_position = math.Vector3(0, 0, 0)
    self.mThingVo = nil
end

function setData(self, thingVo, aiCtrl, loadFinish)
    self.mThingVo = thingVo
    self:setAiCtrl(aiCtrl)
    self:setEnableUpdate(false)
    self:setPrefab(self:getEventConfigVo().modelPrefab, loadFinish)
end

function setPrefab(self, prefabPath, finishCall)
    if(prefabPath == "")then
        self:setTrans(gs.GameObject().transform)
    else
        local thingGo = AssetLoader.GetGO(prefabPath)
        if(not thingGo)then
            thingGo = gs.GameObject()
            Debug:log_error(self.__cname, "锚点空间事件找不到对应资源：" .. prefabPath)
        end
        self:setTrans(thingGo.transform)
    end
    self:initTrans()
    if(self:getEventConfigVo().enableObstacle)then
        local type, center, size = self:getEventConfigVo():getObstacleData()
        if(type and center and size)then
            self:addObstacle(self:getTrans().gameObject, type == 2, center, size)
        end
    end
    if(self:getEnableUpdate())then
        self:addUpdateFramSn()
    end
    self:addEvents()
    if(finishCall)then
        finishCall()
    end
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
    super.onUpdateFrameHandler(self, deltaTime)
end

function setTrans(self, transform)
    self.m_trans = transform
end

function getTrans(self)
    return self.m_trans
end

-- 暂停
function pause(self)
end

-- 恢复播放
function resume(self)
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

    if (math.v3Distance(nextPos, self.mThingVo:getPosition()) < (range or 0) + 0.2) then
        self:setBehaviorState(mainExplore.BehaviorState.IDLE)
    else
        self:setBehaviorState(mainExplore.BehaviorState.COMMON_TARGET_POS_MOVE)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
