local View = require("UISignBattleTipKatasJK/UISignBattleTipKatasJKView")
local DataModel = require("UISignBattleTipKatasJK/UISignBattleTipKatasJKDataModel")
local ViewFunction = require("UISignBattleTipKatasJK/UISignBattleTipKatasJKViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      DataModel.isGoback = false
      DataModel.activityId = Json.decode(initParams).id
      DataModel.activityCA = PlayerData:GetFactoryData(DataModel.activityId)
      local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
      local index = ActivityMainDataModel.GetActivityTipsIndex(DataModel.activityId)
      DataModel.index = index
      PlayerData:SetPlayerPrefs("int", "ActivityTip" .. DataModel.activityId .. DataModel.index, 1)
      View.Btn_Gacha:SetActive(false)
      View.Btn_Activity:SetActive(true)
    else
      DataModel.isGoback = true
      View.Btn_Gacha:SetActive(true)
      View.Btn_Activity:SetActive(false)
    end
    View.SpineAnimation_Player:SetActive(true)
    View.Video_Main:Play("Video/SignBattle/PV_katasJK")
    local gender = PlayerData:GetUserInfo().gender or 1
    ChangeSkinUtil.InitUICaptainSpineSkin(View.SpineAnimation_Player, "dorm_stand_back")
  end,
  awake = function()
  end,
  start = function()
  end,
  perupdate = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
