local View = require("UISignBattleTipCommon/UISignBattleTipCommonView")
local DataModel = require("UISignBattleTipCommon/UISignBattleTipCommonDataModel")
local ViewFunction = {
  SignBattleTipCommon_Video_Main_Skip_Click = function(btn, str)
  end,
  SignBattleTipCommon_Btn_Common_Click = function(btn, str)
    View.SpineAnimation_Player:SetActive(false)
    if DataModel.IsGacha then
      UIManager:GoBack()
      UIManager:Open("UI/Gacha/GachaNew", Json.encode({
        poolId = DataModel.activityCA.poolId
      }))
    else
      UIManager:CloseSpecialUI("UI/Activity/ActivitySignBattle/SignBattleTipCommon")
      UIManager:Open("UI/Activity/ActivityMain", Json.encode({
        id = DataModel.activityCA.id
      }))
    end
  end
}
return ViewFunction
