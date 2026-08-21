_staticClass("SystemFilter")
SystemFilter.LogicSystems = {
  CommandSendSystem = true,
  CommandReceiveSystem = true,
  MainFSMSystem = true,
  GameFSMSystem = true,
  LoadingSystem = true,
  BattleEnterSystem = true,
  WaveEnterSystem = true,
  RoundEnterSystem = true,
  FirstWaveEnterSystem = true,
  WaitInputSystem = true,
  WaveResultSystem = true,
  WaveResultAwardSystem = true,
  WaveResultAwardApplySystem = true,
  RoleMovementSystem = true,
  RoleTurnResultStateSystem = true,
  PreChainStateSystem = true,
  ActiveSkillSystem = true,
  PersonaSkillSystem = true,
  MonsterBuffCalcSystem = true,
  RoundResultSystem = true,
  ChainAttackStateSystem = true,
  PieceRefreshSystem = true,
  MonsterMoveSystem = true,
  BattleResultSystem = true,
  WaveSwitchSystem = true,
  PieceEffectSystem = true,
  WaitInputChainSystem = true,
  BuffUnloadSystem = true,
  ChessPetMoveSystem = true,
  ChessPetAttackSystem = true,
  ChessPetMoveAndAttackSystem = true,
  ChessPetResultSystem = true,
  AutoFightSystem = true,
  MirageEnterSystem = true,
  MirageWaitInputSystem = true,
  MirageRoleTurnSystem = true,
  MirageMonsterTurnSystem = true,
  MirageEndSystem = true,
  PopStarLoadingSystem = true,
  PopStarBattleEnterSystem = true,
  PopStarWaveEnterSystem = true,
  PopStarRoundEnterSystem = true,
  PopStarPieceRefreshSystem = true,
  PopStarTrapTurnSystem = true,
  PopStarRoundResultSystem = true,
  PopStarWaveResultSystem = true,
  PopStarBattleResultSystem = true,
  PopStarProPieceRefreshSystem = true,
  PopStarProRoleTurnSystem = true,
  UnscaledCountDownFinishNotifySystem = true
}

function SystemFilter:CheckSystem(system_name, world_running_postion)
  if self.LogicSystems[system_name] and world_running_postion == WorldRunPostion.AtServer then
    return true
  elseif world_running_postion == WorldRunPostion.AtClient then
    return true
  else
    return false
  end
end
