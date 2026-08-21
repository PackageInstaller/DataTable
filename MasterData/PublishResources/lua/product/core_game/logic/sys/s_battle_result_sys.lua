require("battle_result_system")
_class("ServerBattleResultSystem_Logic", BattleResultSystem)
ServerBattleResultSystem_Logic = ServerBattleResultSystem_Logic

function ServerBattleResultSystem_Logic:_DoLogicBattleResult()
  self._world:BattleStat():SetBattleMatchResult(self.battleMatchResult)
  local serverWorld = self._world
  local pCoreGameLogic = serverWorld:GetCoreGameLogic()
  pCoreGameLogic:OnServerMatchEnd()
end
