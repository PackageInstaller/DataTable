-- @FileName:   FieldExplorationEventInitShowSkill.lua
-- @Description:   初始显隐技能
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventInitShowSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)

    self.m_showState = self.config.param[1] == 1
end

function onExecute(self, executeThing, targetThing)
    executeThing:setVisible(self.m_showState)
end

return _M
