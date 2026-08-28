local View = require("UIWulinMission/UIWulinMissionView")
local DataModel = require("UIWulinMission/UIWulinMissionDataModel")
local ViewFunction = require("UIWulinMission/UIWulinMissionViewFunction")
local Controller = require("UIWulinMission/UIWulinMissionController")
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
