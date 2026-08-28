local BattleSubUI = {}

function BattleSubUI.OpenSubUI()
  local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
  BattleControlManager:Pause(true)
  UIManager:Open("UI/CubeRogue/EnemyTalent/Group_EnemyTalent", Json.encode({isInBattle = true}))
end

return BattleSubUI
