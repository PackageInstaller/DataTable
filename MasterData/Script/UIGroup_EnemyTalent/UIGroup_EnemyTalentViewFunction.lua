local View = require("UIGroup_EnemyTalent/UIGroup_EnemyTalentView")
local DataModel = require("UIGroup_EnemyTalent/UIGroup_EnemyTalentDataModel")
local ViewFunction = {
  Group_EnemyTalent_Btn_UP_Click = function(btn, str)
    UIManager:GoBack(false)
    if DataModel.isInBattle == true then
      local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
      BattleControlManager:Pause(false)
    end
  end
}
return ViewFunction
