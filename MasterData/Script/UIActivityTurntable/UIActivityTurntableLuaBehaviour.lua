local View = require("UIActivityTurntable/UIActivityTurntableView")
local DataModel = require("UIActivityTurntable/UIActivityTurntableDataModel")
local ViewFunction = require("UIActivityTurntable/UIActivityTurntableViewFunction")
local Controller = require("UIActivityTurntable/UIActivityTurntableController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local params = Json.decode(initParams)
      if params and params.activityId then
        DataModel.activityId = tonumber(params.activityId) or 0
      end
    end
    Controller.Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  perupdate = function()
  end,
  update = function()
    Controller.OnUpdate()
  end,
  ondestroy = function()
    Controller.Release()
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
