local View = require("UIBarStore/UIBarStoreView")
local DataModel = require("UIBarStore/UIBarStoreDataModel")
local Controller = require("UIBarStore/UIBarStoreController")
local ViewFunction = require("UIBarStore/UIBarStoreViewFunction")
local Luabehaviour = {
  serialize = function()
    local t = {}
    t.stationId = DataModel.StationId
    t.buildingId = DataModel.BuildingId
    t.npcId = DataModel.NpcId
    t.bgPath = DataModel.BgPath
    t.noInit = true
    t.isCityMapIn = DataModel.IsCityMapIn
    t.isStoreOpened = DataModel.isStoreOpened
    return Json.encode(t)
  end,
  deserialize = function(initParams)
    DataModel.IsCityMapIn = false
    if initParams ~= nil then
      local t = Json.decode(initParams)
      DataModel.decodeParams = t
      DataModel.StationId = t.stationId
      DataModel.BuildingId = t.buildingId
      DataModel.NpcId = t.npcId
      DataModel.BgPath = t.bgPath
      DataModel.BgColor = t.bgColor or "FFFFFF"
      DataModel.BgColor = "#" .. DataModel.BgColor
      DataModel.IsCityMapIn = t.isCityMapIn
      Controller:Init()
      if t.isStoreOpened then
        Controller:OpenStore()
      else
        View.self:PlayAnim("In")
      end
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    Controller:TimeAutoRefresh()
  end,
  ondestroy = function()
    local npcDialog = require("Common/NPCDialog")
    npcDialog.ClearAll()
    DataModel.SpecialShopProto = nil
    DataModel.BarSpecialProto = nil
    DataModel.GBSpecialProto = nil
  end,
  disenable = function()
    QuestProcess.RemoveQuestCallBack(View.self.url)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
