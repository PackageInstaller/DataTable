local View = require("UIGuidance/UIGuidanceView")
local DataModel = require("UIGuidance/UIGuidanceDataModel")
local ViewFunction = require("UIGuidance/UIGuidanceViewFunction")
local Controller = require("UIGuidance/UIGuidanceController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
