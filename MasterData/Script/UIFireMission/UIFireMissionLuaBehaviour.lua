local View = require("UIFireMission/UIFireMissionView")
local DataModel = require("UIFireMission/UIFireMissionDataModel")
local ViewFunction = require("UIFireMission/UIFireMissionViewFunction")
local Controller = require("UIFireMission/UIFireMissionController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.initParams = initParams
    DataModel.decodeParams = Json.decode(initParams)
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
