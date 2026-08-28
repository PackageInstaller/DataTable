local View = require("UIGroup_WeaponBreak/UIGroup_WeaponBreakView")
local DataModel = require("UIGroup_WeaponBreak/UIGroup_WeaponBreakDataModel")
local ViewFunction = require("UIGroup_WeaponBreak/UIGroup_WeaponBreakViewFunction")
local Controller = require("UIGroup_WeaponBreak/UIGroup_WeaponBreakController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local data = Json.decode(initParams)
      Controller:Init(data)
    end
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
