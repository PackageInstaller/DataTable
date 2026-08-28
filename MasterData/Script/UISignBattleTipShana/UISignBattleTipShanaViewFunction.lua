local View = require("UISignBattleTipShana/UISignBattleTipShanaView")
local DataModel = require("UISignBattleTipShana/UISignBattleTipShanaDataModel")
local ViewFunction = {
  SignBattleTipShana_Video_Main_Skip_Click = function(btn, str)
  end,
  SignBattleTipShana_Btn_Gacha_Click = function(btn, str)
    View.SpineAnimation_Player:SetActive(false)
    if DataModel.isGoback == true then
      UIManager:GoBack()
    else
      UIManager:CloseSpecialUI("UI/Activity/ActivitySignBattle/SignBattleTipShana")
    end
    local poolId
    local actCa = PlayerData:GetFactoryData(86000283)
    if actCa and actCa.bannerList and actCa.bannerList[1] then
      poolId = actCa.bannerList[1].id
    end
    local t = {}
    t.poolId = poolId
    UIManager:Open("UI/Gacha/GachaNew", Json.encode(t))
  end,
  SignBattleTipShana_Btn_Activity_Click = function(btn, str)
    View.SpineAnimation_Player:SetActive(false)
    UIManager:CloseSpecialUI("UI/Activity/ActivitySignBattle/SignBattleTipShana")
    UIManager:Open("UI/Activity/ActivityMain", Json.encode({
      id = DataModel.activityId
    }))
  end
}
return ViewFunction
