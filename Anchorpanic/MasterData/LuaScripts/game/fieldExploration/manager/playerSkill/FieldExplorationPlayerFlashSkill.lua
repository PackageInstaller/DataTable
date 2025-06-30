-- @FileName:   FieldExplorationPlayerFlashSkill.lua
-- @Description:   站员闪现技能
-- @Author: ZDH
-- @Date:   2023-07-31 17:44:51
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.player.FieldExplorationPlayerFlashSkill', Class.impl(fieldExploration.FieldExplorationPlayerBaseSkill))

function resetData(self)
    super.resetData(self)

    --闪现距离
    self.mFlash_Distance = self.config.effect[1] * 0.01
    --闪现最大速度
    self.mFlash_Time = self.config.effect[2]

    --是否碰到了障碍物
    self.mIsOnCollider = false

    --技能间隔计时
    self.mExecuteInterval = 0

    self:initColliderUtil()
end

function initColliderUtil(self)
    super.initColliderUtil(self)
    self.mTran.localPosition = gs.Vector3(0, 0.5, self.mFlash_Distance)
end

--实现技能效果
function onExecuteEffect(self)
    super.onExecuteEffect(self)

    self:initColliderUtil()

    self.mExecuteInterval = 0
    self.mPlayerTing:setMoveMode(FieldExplorationConst.PlayerMoveType.None)

    local pos = self.mPlayerTing:getPosition()
    local radius = self.mPlayerTing:getData().config.agent_radius - 0.1
    local dir = self.mPlayerTing:getTrans().forward
    local raycastHits = gs.UnityEngineUtil.RaycastSphereCastAll(pos, radius, dir, self.mFlash_Distance, "Event", "AirWall")
    local raycastHitsList = {}
    for i = 0, raycastHits.Length - 1 do
        table.insert(raycastHitsList, raycastHits[i])
    end

    table.sort(raycastHitsList, function (a, b)
        return a.distance > b.distance
    end)

    self.mCurFlashDistance = 0
    local length = #raycastHitsList
    if self.mIsOnCollider or length > 1 then
        if length > 0 then
            self.mCurFlashDistance = raycastHitsList[length].distance
        end
    else
        self.mCurFlashDistance = self.mFlash_Distance
        --这里避免跳出空气墙
        for i = 0, raycastHits.Length - 1 do
            if raycastHits[i].collider.gameObject.layer == gs.LayerMask.NameToLayer("AirWall") then
                self.mCurFlashDistance = raycastHits[i].distance
                break
            end
        end
    end
    self.mPlayerTing:removeEffect(self.mTrigger_effct01)
    self.mTrigger_effct01 = self.mPlayerTing:addEffect(self.config.trigger_effct[1])
end

function onFinishSkill(self)
    super.onFinishSkill(self)

    self.mPlayerTing:removeEffect(self.mTrigger_effct02)
    self.mTrigger_effct02 = self.mPlayerTing:addEffect(self.config.trigger_effct[2])

    self.mPlayerTing:setActionState(FieldExplorationConst.HERO_ACTION_STATE.FLASH)

    local trans = self.mPlayerTing:getTrans()
    self.mPlayerTing:setPosition(self.mPlayerTing:getPosition() + trans.forward * self.mCurFlashDistance)
    self.mPlayerTing:resetMoveMode()
end

function addSkillEffect(self)

end

function removeSkillEffect(self)

end

--动画帧
function onFrame(self)
    super.onFrame(self)

    if self.isShowSkillEffect then
        if self.mCurFlashDistance > 0 then
            self.mExecuteInterval = self.mExecuteInterval + (gs.Time.deltaTime * 1000)
            if self.mExecuteInterval >= self.mFlash_Time then
                self:onFinishSkill()
            end
        else
            self:onFinishSkill()
        end
    end
end

function onTriggerStayCall(self, tag, colliderTagID)
    self.mIsOnCollider = true
end

--提示器碰撞退出
function onTriggerExitCall(self, tag, colliderTagID)
    self.mIsOnCollider = false
end

function getColliderTags(self)
    return {FieldExplorationConst.ColliderTag.Event}
end

return _M
