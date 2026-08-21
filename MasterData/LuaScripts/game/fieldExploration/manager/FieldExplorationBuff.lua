-- @FileName:   FieldExplorationBuff.lua
-- @Description:   场景事件buff效果实现，如果是直接碰撞触发的buff，不需要显示伤害范围的可以直接用这个脚本
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.FieldExplorationBuff', Class.impl())

function ctor(self)

end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

--actionThing作用对象
--addThing 添加对象
-- 通过已有资源创建新实例
function create(self, buffId, actionThing, addThing)
    local item = self:poolGet()
    item.m_snId = SnMgr:getSn()
    item.buff_id = buffId
    item.actionThing = actionThing
    item.addThing = addThing
    item.config = fieldExploration.FieldExplorationManager:getBuffConfigVo(buffId)

    item:onAdd()

    return item
end

function onAdd(self)
    if self.config.type == FieldExplorationConst.Buff_Type.add_Speed then -- 加减速
        local attr = self.actionThing:getAttr()

        local addSpeedRate = self.config.effect[1] * 0.01
        self.addSpeed = attr.speed * addSpeedRate --当前添加的加速度
        self.actionThing:addMoveSpeed(self.addSpeed)

    elseif self.config.type == FieldExplorationConst.Buff_Type.time_Speed then --持续加减速
        local attr = self.actionThing:getAttr()

        local addSpeedRate = self.config.effect[1] * 0.01
        local sustainTime = self.config.effect[2] * 0.001

        self.addSpeed = attr.speed * addSpeedRate --存一次玩家当前的速度
        self.actionThing:addMoveSpeed(self.addSpeed)

        self:clearTimeOutSn()
        self.mTimeOutSn = LoopManager:setTimeout(sustainTime, self, self.remove)
    elseif self.config.type == FieldExplorationConst.Buff_Type.add_Life then --加减血量
        self.actionThing:addLife(self.config.effect[1])

    elseif self.config.type == FieldExplorationConst.Buff_Type.vertigo then --眩晕
        self.actionThing:setActionState(FieldExplorationConst.HERO_ACTION_STATE.VERTIGO)

        local sustainTime = self.config.effect[1] * 0.001
        self:clearTimeOutSn()
        self.mTimeOutSn = LoopManager:setTimeout(sustainTime, self, self.remove)

    elseif self.config.type == FieldExplorationConst.Buff_Type.add_score then --加减积分
        self.actionThing:addScore(self.config.effect[1])

    elseif self.config.type == FieldExplorationConst.Buff_Type.disorder then --混乱
        self.actionThing:setMoveDir(-1)

        local sustainTime = self.config.effect[1] * 0.001
        self:clearTimeOutSn()
        self.mTimeOutSn = LoopManager:setTimeout(sustainTime, self, self.remove)
    elseif self.config.type == FieldExplorationConst.Buff_Type.add_energy then --加减能量
        self.actionThing:addEnergy(self.config.effect[1])
    elseif self.config.type == FieldExplorationConst.Buff_Type.add_moneyGold then --添加金币
        self.actionThing:addMoney_Gold(self.config.effect[1])
    elseif self.config.type == FieldExplorationConst.Buff_Type.add_moneySilver then --添加银币
        self.actionThing:addMoney_Silver(self.config.effect[1])

    elseif self.config.type == FieldExplorationConst.Buff_Type.invincible then --无敌
        local sustainTime = self.config.effect[1] * 0.001
        self.actionThing:updateInvincibleEndTimeDt(GameManager:getClientTime() + sustainTime)

        self:clearTimeOutSn()
        self.mTimeOutSn = LoopManager:setTimeout(sustainTime, self, self.remove)

    elseif self.config.type == FieldExplorationConst.Buff_Type.repel then --击退
        self.mMaxDistance = self.config.effect[1] * 0.01

        self.mCurForwardDistance = 0
        self.mSpeed = self.config.effect[2] * 0.01

        self:clearFrameSn()
        self.mFrameSn = LoopManager:addFrame(1, 0, self, self.onFrame)

    elseif self.config.type == FieldExplorationConst.Buff_Type.hit then --受击
        self.actionThing:onHit(self.config.effect[1])
    end

    if not string.NullOrEmpty(self.config.trigger_effct) then
        self.mTrigger_effct = self.actionThing:addEffect(self.config.trigger_effct)
    end

    --容错回收
    self.mRecoverTimeOutSn = LoopManager:setTimeout(30, self, self.remove)
end

function remove(self)
    self.actionThing:removeBuff(self.m_snId)
    self:onRemove()
    self:recover()
end

function onRemove(self)
    if self.config.type == FieldExplorationConst.Buff_Type.add_Speed then -- 加减速
        self.actionThing:addMoveSpeed(-1 * self.addSpeed)
        self.addSpeed = nil
    elseif self.config.type == FieldExplorationConst.Buff_Type.time_Speed then --持续加减速
        self.actionThing:addMoveSpeed(-1 * self.addSpeed)
        self.addSpeed = nil
    elseif self.config.type == FieldExplorationConst.Buff_Type.add_Life then --加减血量
    elseif self.config.type == FieldExplorationConst.Buff_Type.vertigo then --眩晕
        self.actionThing:stateRevert(FieldExplorationConst.HERO_ACTION_STATE.VERTIGO)

    elseif self.config.type == FieldExplorationConst.Buff_Type.add_score then --加减积分
    elseif self.config.type == FieldExplorationConst.Buff_Type.disorder then --混乱
        self.actionThing:setMoveDir(1)

    elseif self.config.type == FieldExplorationConst.Buff_Type.add_energy then --加减能量
    elseif self.config.type == FieldExplorationConst.Buff_Type.invincible then --无敌
    elseif self.config.type == FieldExplorationConst.Buff_Type.repel then --击退
        self:clearFrameSn()
    elseif self.config.type == FieldExplorationConst.Buff_Type.hit then --受击

    end
end

function onFrame(self)
    if self.config.type == FieldExplorationConst.Buff_Type.repel then --击退
        self.mSpeed = gs.Mathf.Lerp(self.mSpeed, 0, gs.Time.deltaTime)
        self.mCurForwardDistance = self.mCurForwardDistance + self.mSpeed

        if self.mCurForwardDistance > self.mMaxDistance then
            self:onRemove()
            self.mSpeed = self.mMaxDistance - self.mCurForwardDistance
        end

        local forward = self.actionThing:getPosition() - self.addThing:getPosition()
        self.actionThing:setTranForward(self.mSpeed * -1, forward.normalized)
    end
end

function clearFrameSn(self)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

function clearTimeOutSn(self)
    if self.mTimeOutSn then
        LoopManager:clearTimeout(self.mTimeOutSn)
        self.mTimeOutSn = nil
    end
end

function clearEffect(self)
    if self.mTrigger_effct then
        self.actionThing:removeEffect(self.mTrigger_effct)
        self.mTrigger_effct = nil
    end
end

-- 回收
function recover(self)
    if self.mRecoverTimeOutSn then
        LoopManager:clearTimeout(self.mRecoverTimeOutSn)
        self.mRecoverTimeOutSn = nil
    end

    self:clearEffect()
    self:clearTimeOutSn()
    self:clearFrameSn()

    LuaPoolMgr:poolRecover(self)
end

return _M
