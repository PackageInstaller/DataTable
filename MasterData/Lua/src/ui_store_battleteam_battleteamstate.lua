local this = {}

function this:init()
  this.super.init(self)
end

function this:convertTeamInfo()
  return C_BattleSimulatorManager.instance.battleTeam:GetSelectHeroList()
end

function this:getBattleTeamInfo()
  return C_BattleSimulatorManager.instance.battleTeam:GetSelectHeroList()
end

function this:getControlId()
  return C_BattleSimulatorManager.instance.battleTeam.controlId
end

return this
