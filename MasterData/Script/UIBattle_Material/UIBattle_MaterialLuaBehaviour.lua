local View = require("UIBattle_Material/UIBattle_MaterialView")
local DataModel = require("UIBattle_Material/UIBattle_MaterialDataModel")
local ViewFunction = require("UIBattle_Material/UIBattle_MaterialViewFunction")
local Controller = require("UIBattle_Material/UIBattle_MaterialController")
local params
local Luabehaviour = {
  serialize = function()
    return params
  end,
  deserialize = function(initParams)
    params = initParams
    DataModel:Init(initParams)
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
