local View = require("UIChangeSkin/UIChangeSkinView")
local DataModel = require("UIChangeSkin/UIChangeSkinDataModel")
local ViewFunction = require("UIChangeSkin/UIChangeSkinViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.InitData()
    if initParams then
      DataModel.SetJsonData(initParams)
    end
    DataModel.RefreshOnShow()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    if DataModel.sound then
      DataModel.sound:Stop()
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
