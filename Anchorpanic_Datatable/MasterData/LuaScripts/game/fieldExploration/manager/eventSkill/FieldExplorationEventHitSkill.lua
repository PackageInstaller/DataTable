-- @FileName:   FieldExplorationEventHitSkill.lua
-- @Description:   受击
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventHitSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function onExecute(self, executeThing, targetThing)
    super.onExecute(self, executeThing, targetThing)

    self.mTargetThing:setActionState(FieldExplorationConst.HERO_ACTION_STATE.HIT)
end

return _M
