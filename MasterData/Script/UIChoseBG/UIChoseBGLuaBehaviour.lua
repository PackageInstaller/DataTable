local View = require("UIChoseBG/UIChoseBGView")
local DataModel = require("UIChoseBG/UIChoseBGDataModel")
local ViewFunction = require("UIChoseBG/UIChoseBGViewFunction")
local Luabehaviour = {
  serialize = function()
    return DataModel.InitParams
  end,
  deserialize = function(initParams)
    DataModel.Init(initParams)
    ViewFunction.RefreshAll()
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
