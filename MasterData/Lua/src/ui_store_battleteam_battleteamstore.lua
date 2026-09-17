local this = class("battleTeamStore", G_BaseStore)
this.event = {}
this.constSaveKey = "battleTeam"
this:importPartialClass(require(L_R.store .. "battleTeam.battleTeamState"))

function this:setControlIdByIndex(index)
  local selectTeam = L_BattleTeamStore:getBattleTeamInfo()
  local num = selectTeam.Count
  if index <= num then
    L_BattleTeamStore:setHeroIdWithControl(index)
  end
end

function this:setHeroIdWithControl(heroId)
  C_BattleSimulatorManager.instance.battleTeam.controlId = heroId - 1
end

return this
