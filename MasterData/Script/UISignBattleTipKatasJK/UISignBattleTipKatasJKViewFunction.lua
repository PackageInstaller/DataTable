local View = require("UISignBattleTipKatasJK/UISignBattleTipKatasJKView")
local DataModel = require("UISignBattleTipKatasJK/UISignBattleTipKatasJKDataModel")
local ViewFunction = {
  SignBattleTipKatasJK_Video_Main_Skip_Click = function(btn, str)
  end,
  SignBattleTipKatasJK_Btn_Gacha_Click = function(btn, str)
    View.SpineAnimation_Player:SetActive(false)
    if DataModel.isGoback == true then
      UIManager:GoBack()
    else
      UIManager:CloseSpecialUI("UI/Activity/ActivitySignBattle/SignBattleTipKatasJK")
    end
    local t = {}
    t.poolId = 80500347
    UIManager:Open("UI/Gacha/GachaNew", Json.encode(t))
  end,
  SignBattleTipKatasJK_Btn_Activity_Click = function(btn, str)
    View.SpineAnimation_Player:SetActive(false)
    UIManager:CloseSpecialUI("UI/Activity/ActivitySignBattle/SignBattleTipKatasJK")
    UIManager:Open("UI/Activity/ActivityMain", Json.encode({
      id = DataModel.activityId
    }))
  end
}
return ViewFunction
