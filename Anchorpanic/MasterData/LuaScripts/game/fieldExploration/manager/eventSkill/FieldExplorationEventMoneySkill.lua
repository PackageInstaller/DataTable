-- @FileName:   FieldExplorationEventMoneySkill.lua
-- @Description:   场景事件货币之类的技能，直接执行的那种
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventMoneySkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

---执行技能
function onExecute(self, executeThing, targetThing)
    super.onExecute(self, executeThing, targetThing)

    self:addBuff()
end

return _M
