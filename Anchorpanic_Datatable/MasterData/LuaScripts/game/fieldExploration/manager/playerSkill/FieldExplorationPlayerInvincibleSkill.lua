-- @FileName:   FieldExplorationPlayerInvincibleSkill.lua
-- @Description:   站员无敌金身技能
-- @Author: ZDH
-- @Date:   2023-07-31 17:55:09
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.player.FieldExplorationPlayerInvincibleSkill', Class.impl(fieldExploration.FieldExplorationPlayerBaseSkill))

function resetData(self)
    super.resetData(self)

    self.useEnergy = self.config.effect[1] --所需能量
end

--是否可以执行技能
function isCanExecute(self)
    if not super.isCanExecute(self) then
        return false
    end

    if self.mPlayerTing then
        local attr = self.mPlayerTing:getAttr()
        if attr.energy < self.useEnergy then
            return false
        end
    end

    return true
end

--实现技能效果
function onExecuteEffect(self)
    super.onExecuteEffect(self)

    self.isShowSkillEffect = false
end

return _M
