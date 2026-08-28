local View = require("UISignBattleTipTeresa/UISignBattleTipTeresaView")
local DataModel = require("UISignBattleTipTeresa/UISignBattleTipTeresaDataModel")
local ViewFunction = {
  SignBattleTipTeresa_Video_Main_Skip_Click = function(btn, str)
  end,
  SignBattleTipTeresa_Btn_Gacha_Click = function(btn, str)
    View.SpineAnimation_Player:SetActive(false)
    if DataModel.isGoback == true then
      UIManager:GoBack()
    else
      UIManager:CloseSpecialUI("UI/Activity/ActivitySignBattle/SignBattleTipTeresa")
    end
    local poolId
    local actCa = PlayerData:GetFactoryData(86000305)
    if actCa and actCa.bannerList and actCa.bannerList[1] then
      poolId = actCa.bannerList[1].id
    end
    local t = {}
    t.poolId = 80500327
    UIManager:Open("UI/Gacha/GachaNew", Json.encode(t))
  end,
  SignBattleTipTeresa_Btn_Activity_Click = function(btn, str)
    View.SpineAnimation_Player:SetActive(false)
    UIManager:CloseSpecialUI("UI/Activity/ActivitySignBattle/SignBattleTipTeresa")
    UIManager:Open("UI/Activity/ActivityMain", Json.encode({
      id = DataModel.activityId
    }))
  end
}
return ViewFunction
