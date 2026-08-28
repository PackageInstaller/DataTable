local View = require("UIFriendTrain/UIFriendTrainView")
local DataModel = require("UIFriendTrain/UIFriendTrainDataModel")
local ViewFunction = require("UIFriendTrain/UIFriendTrainViewFunction")
local Timer = require("Common/Timer")
local params
local Luabehaviour = {
  serialize = function()
    local data = Json.decode(params)
    data.isBack = true
    return Json.encode(data)
  end,
  deserialize = function(initParams)
    params = initParams
    if params then
      local data = Json.decode(initParams)
      DataModel.backScene = data.backScene
      DataModel.backUI = data.backUI
      if not data.isBack then
        DataModel.InitTrainData()
      end
    else
      params = DataModel.backScene == "Main" and "{\"backScene\":\"Main\"}" or "{\"backScene\":\"Home\"}"
    end
    UIManager.HomePage = "UI/Friends/FriendTrain"
    View.Group_MainUI.Img_Head.Group_AccountInfo.Txt_Name:SetText(PlayerData.visitInfo.role_name)
    View.Group_MainUI.Img_Head.Group_AccountInfo.Txt_Level:SetText("Lv" .. PlayerData.visitInfo.lv)
    local waste_block = PlayerData.visitInfo.rubbish_area.waste_block or 0
    View.Group_MainUI.Img_Head.Img_RubbishInfo.Group_RubbushNum.Txt_Num:SetText(waste_block)
    local myBlock = PlayerData.visitInfo.my_rubbish_area.waste_block
    local rubbushCapacity = PlayerData.visitInfo.my_rubbish_area.max_space
    View.Group_MainUI.Img_Head.Img_RubbishInfo.Group_MyRubbush.Txt_Num:SetText(myBlock .. "/" .. rubbushCapacity)
    View.Group_MainUI.Img_Head.Img_RubbishInfo.Btn_Take:SetActive(true)
    local path, photoFactory = DataModel.GetHeadPath()
    View.Group_MainUI.Img_Head.Img_Mask.Img_Character:SetSprite(path)
    CommonTips:SetPlayerHeadShader(View.Group_MainUI.Img_Head.Img_Mask.Img_spAdd, photoFactory)
    DataModel.UpdateStoleInfo()
    View.timer = Timer.New(1, function()
      DataModel.UpdateStoleCD()
    end)
    View.timer:Start()
  end,
  awake = function()
  end,
  start = function()
    UIManager.HomePage = "UI/Friends/FriendTrain"
  end,
  update = function()
    if View.timer then
      View.timer:Update()
    end
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
