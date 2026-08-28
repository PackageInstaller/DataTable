local View = require("UIFlameMission/UIFlameMissionView")
local DataModel = require("UIFlameMission/UIFlameMissionDataModel")
local ViewFunction = require("UIFlameMission/UIFlameMissionViewFunction")
local Controller = require("UIFlameMission/UIFlameMissionController")
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
