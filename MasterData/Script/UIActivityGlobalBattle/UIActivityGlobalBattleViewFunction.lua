local View = require("UIActivityGlobalBattle/UIActivityGlobalBattleView")
local DataModel = require("UIActivityGlobalBattle/UIActivityGlobalBattleDataModel")
local NPCDialog = require("Common/NPCDialog")
local ViewFunction = {
  ActivityGlobalBattle_Group_NPC_Btn__Click = function(btn, str)
    NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.talkText)
  end,
  ActivityGlobalBattle_Group_Reward_Btn_Reward_Click = function(btn, str)
    UIManager:Open("UI/Activity/ActivityGlobalBattle/GlobalBattleRewards", Json.encode({
      activityId = DataModel.activityId,
      reward = DataModel.reward,
      progressNum = DataModel.progressNum
    }))
  end,
  ActivityGlobalBattle_Group_Material_Btn_Enter_Click = function(btn, str)
    UIManager:Open("UI/Activity/ActivityGlobalBattle/MaterialBattle", Json.encode({
      activityId = DataModel.activityId
    }))
  end,
  ActivityGlobalBattle_Group_World_Btn_Enter_Click = function(btn, str)
    UIManager:Open("UI/Activity/ActivityGlobalBattle/WorldScan", Json.encode({
      activityId = DataModel.activityId
    }))
  end
}
return ViewFunction
