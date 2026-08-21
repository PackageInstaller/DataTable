_class("SMazeState_WorldBoss", SMazeStateBase)
SMazeState_WorldBoss = SMazeState_WorldBoss

function SMazeState_WorldBoss:OnEnter(fromBattle)
  self:ShowDialog("UISeasonMazeWorldBossSelectPopUp", fromBattle)
end
