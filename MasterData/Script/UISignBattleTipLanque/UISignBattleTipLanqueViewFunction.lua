local View = require("UISignBattleTipLanque/UISignBattleTipLanqueView")
local DataModel = require("UISignBattleTipLanque/UISignBattleTipLanqueDataModel")
local ViewFunction = {
  SignBattleTipLanque_Video_Main_Skip_Click = function(btn, str)
  end,
  SignBattleTipLanque_Btn_Gacha_Click = function(btn, str)
    View.SpineAnimation_Player:SetActive(false)
    if DataModel.isGoback == true then
      UIManager:GoBack()
    else
      UIManager:CloseSpecialUI("UI/Activity/ActivitySignBattle/SignBattleTipLanque")
    end
    local t = {}
    t.poolId = 80500378
    UIManager:Open("UI/Gacha/GachaNew", Json.encode(t))
  end,
  SignBattleTipLanque_Btn_Activity_Click = function(btn, str)
    View.SpineAnimation_Player:SetActive(false)
    UIManager:CloseSpecialUI("UI/Activity/ActivitySignBattle/SignBattleTipLanque")
    UIManager:Open("UI/Activity/ActivityMain", Json.encode({
      id = DataModel.activityId
    }))
  end
}
return ViewFunction
