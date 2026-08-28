local View = require("UIWorldScan/UIWorldScanView")
local DataModel = require("UIWorldScan/UIWorldScanDataModel")
local Controller = require("UIWorldScan/UIWorldScanController")
local ViewFunction = require("UIWorldScan/UIWorldScanViewFunction")
local Luabehaviour = {
  serialize = function()
    local t = {
      activityId = DataModel.activityId,
      isBattleReturn = DataModel.isBattleReturn,
      isOpenBtnList = DataModel.isOpenBtnList,
      indexSelected = DataModel.indexSelected
    }
    return Json.encode(t)
  end,
  deserialize = function(initParams)
    DataModel.remainTime = 0
    if initParams then
      local parms = Json.decode(initParams)
      DataModel:Init(parms)
      View.Group_Btn.ScrollGrid_BtnList.self:SetActive(DataModel.isOpenBtnList == 1 and true or false)
      View.Group_Btn.Img_Bg:SetActive(DataModel.isOpenBtnList == 1 and true or false)
      View.Group_Scaning.self:SetActive(false)
      if DataModel.isBuffer == true then
        Controller:Init()
      else
        Net:SendProto("unification.world_event", function(json)
          DataModel:SetEventData(json)
          Controller:Init()
        end)
      end
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  perupdate = function()
  end,
  update = function()
    DataModel.remainTime = DataModel.remainTime + 1
    if DataModel.remainTime > 30 then
      DataModel.remainTime = 0
      Controller:RefreshTimeShow(true)
    end
    if View.timer then
      View.timer:Update()
    end
    if View.timer2 then
      View.timer2:Update()
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
