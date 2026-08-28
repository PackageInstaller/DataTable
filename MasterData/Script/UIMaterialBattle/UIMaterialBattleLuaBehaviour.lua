local View = require("UIMaterialBattle/UIMaterialBattleView")
local DataModel = require("UIMaterialBattle/UIMaterialBattleDataModel")
local Controller = require("UIMaterialBattle/UIMaterialBattleController")
local ViewFunction = require("UIMaterialBattle/UIMaterialBattleViewFunction")
local Luabehaviour = {
  serialize = function()
    local t = {}
    t.activityId = DataModel.ActivityId
    t.battleLeftIndex = DataModel.BattleLeftIndex
    return Json.encode(t)
  end,
  deserialize = function(initParams)
    if initParams then
      local parms = Json.decode(initParams)
      DataModel.ActivityId = parms.activityId
      DataModel.BattleLeftIndex = parms.battleLeftIndex
    end
    DataModel:BattleInit()
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
