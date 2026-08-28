local View = require("UIInvestCenter/UIInvestCenterView")
local DataModel = require("UIInvestCenter/UIInvestCenterDataModel")
local ViewFunction = require("UIInvestCenter/UIInvestCenterViewFunction")
local Controller = require("UIInvestCenter/UIInvestCenterController")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.initParams)
  end,
  deserialize = function(initParams)
    DataModel.initParams = {}
    DataModel.StationId = 0
    DataModel.BuildingId = 0
    DataModel.NpcId = 0
    DataModel.BgPath = ""
    DataModel.BgColor = "#FFFFFF"
    if initParams and initParams ~= "" then
      local info = Json.decode(initParams)
      if info then
        DataModel.initParams = info
        DataModel.StationId = info.stationId or 0
        DataModel.BuildingId = info.buildingId or 0
        DataModel.NpcId = info.npcId or 0
        DataModel.BgPath = info.bgPath or ""
        DataModel.BgColor = info.bgColor or "FFFFFF"
        if string.sub(DataModel.BgColor, 1, 1) ~= "#" then
          DataModel.BgColor = "#" .. DataModel.BgColor
        end
      end
    end
    Controller:Init()
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
    local npcDialog = require("Common/NPCDialog")
    npcDialog.ClearAll()
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
