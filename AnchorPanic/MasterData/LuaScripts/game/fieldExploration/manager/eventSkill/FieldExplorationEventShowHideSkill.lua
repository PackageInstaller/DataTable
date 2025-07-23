-- @FileName:   FieldExplorationEventShowHideSkill.lua
-- @Description:   取反显隐技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventShowHideSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)

    self.m_showState = self.config.param[1] == 1
end

function onExecute(self, executeThing, targetThing)
    self.m_showState = not self.m_showState
    executeThing:setVisible(self.m_showState)
end

return _M
