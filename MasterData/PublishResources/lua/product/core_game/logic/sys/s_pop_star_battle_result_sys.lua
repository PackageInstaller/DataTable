require("pop_star_battle_result_system")
_class("PopStarBattleResultSystem_Logic", PopStarBattleResultSystem)
PopStarBattleResultSystem_Logic = PopStarBattleResultSystem_Logic

function PopStarBattleResultSystem_Logic:_DoLogicBattleResult()
  self._world:BattleStat():SetBattleMatchResult(self.battleMatchResult)
  local serverWorld = self._world
  local pCoreGameLogic = serverWorld:GetCoreGameLogic()
  pCoreGameLogic:OnServerMatchEnd()
end
