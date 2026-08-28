local View = require("UISignBattleTipCommon/UISignBattleTipCommonView")
local DataModel = require("UISignBattleTipCommon/UISignBattleTipCommonDataModel")
local ViewFunction = require("UISignBattleTipCommon/UISignBattleTipCommonViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local data = Json.decode(initParams)
      local id = data.id
      DataModel.activityCA = PlayerData:GetFactoryData(id)
      local GroupName = DataModel.activityCA.GroupName
      DataModel.IsGacha = data.IsGacha or false
      if DataModel.IsGacha == false then
        local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
        local index = ActivityMainDataModel.GetActivityTipsIndex(tostring(id))
        PlayerData:SetPlayerPrefs("int", "ActivityTip" .. tostring(id) .. index, 1)
      end
      View.Video_Main:Play(DataModel.activityCA.videoPath)
      local transform = View.Group_List.self.transform
      local count = transform.childCount - 1
      for i = 0, count do
        transform:GetChild(i).gameObject:SetActive(false)
      end
      View.Group_List[GroupName]:SetActive(true)
      View.Group_List[GroupName].Img_Gacha:SetActive(DataModel.IsGacha)
      View.Group_List[GroupName].Img_Activity:SetActive(not DataModel.IsGacha)
      View.SpineAnimation_Player:SetActive(true)
      ChangeSkinUtil.InitUICaptainSpineSkin(View.SpineAnimation_Player, "dorm_stand_back")
    end
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
