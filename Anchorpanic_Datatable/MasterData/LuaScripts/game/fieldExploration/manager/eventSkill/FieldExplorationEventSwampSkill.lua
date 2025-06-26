-- @FileName:   FieldExplorationEventSwampSkill.lua
-- @Description:   沼泽技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventSwampSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function onExecute(self, executeThing, targetThing)
    super.onExecute(self, executeThing, targetThing)
    
    self:addBuff()

end

function onCancel(self)
    self:clearBuff()
end

return _M
