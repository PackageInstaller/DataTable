local View = require("UIESC/UIESCView")
local DataModel = require("UIESC/UIESCDataModel")
local Controller = require("UIESC/UIESCController")
local ViewFunction = require("UIESC/UIESCViewFunction")
local RoomBackDataModel = require("UIChoseBG/UIChoseBGDataModel")
local params
local Luabehaviour = {
  serialize = function()
    if params then
      return params
    end
  end,
  deserialize = function(initParams)
    params = initParams
    if initParams ~= nil then
      local data = Json.decode(initParams)
      if data.showAdjutantBg then
        View.Img_AdjutantBG:SetActive(data.showAdjutantBg)
        View.Img_AdjutantBG:SetSprite(RoomBackDataModel.GetCurrentRoomBackBgPath())
      else
        View.Img_AdjutantBG:SetActive(false)
      end
    else
      View.Img_AdjutantBG:SetActive(false)
    end
    DataModel.headInfo = {}
    DataModel.showStationLst = {}
    DataModel.headSelectId = 0
    DataModel.usedHeadId = 0
    Controller:Init()
    Controller:SetTrainMode()
    DataModel.FirstFrame = true
    View.self:PlayAnim("ESCIn")
    DataModel.InitLvRewardInfo()
    View.Group_Info.Group_License.Img_Icon:SetSprite(DataModel.lv_icon)
    View.Group_Info.Group_License.Txt_Name:SetText(DataModel.lv_name)
    View.Group_Info.Group_License.Btn_Lv.Img_RemindOut:SetActive(0 < DataModel.can_recv_cnt)
    local data = PlayerData:GetFactoryData(DataModel.lv_cfg[DataModel.max_lvidx].id)
    View.Group_Info.Group_License.Txt_Title:SetText(data.Rankname)
    Controller.RefreshSkin()
    Controller.RefreshLvInfo()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.FirstFrame then
      DataModel.FirstFrame = false
      if MainManager.bgSceneName == "Main" then
        local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
        if not TradeDataModel.GetInTravel() then
          TrainCameraManager:OpenCamera(1)
        else
          TrainCameraManager:OpenCamera(0)
        end
      else
        TrainCameraManager:OpenCamera(2)
      end
    end
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    if UIManager:GetPanel("UI/MainUI/MainUI") and UIManager:GetPanel("UI/MainUI/MainUI").IsActive then
      return
    end
    if UIManager:GetPanel("UI/HomeFurniture/HomeFood") and UIManager:GetPanel("UI/HomeFurniture/HomeFood").IsActive then
      return
    end
    TrainCameraManager:OpenCamera(-1)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
