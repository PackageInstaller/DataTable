local View = require("UIActivityGlobalBattle/UIActivityGlobalBattleView")
local DataModel = require("UIActivityGlobalBattle/UIActivityGlobalBattleDataModel")
local Controller = require("UIActivityGlobalBattle/UIActivityGlobalBattleController")
local ViewFunction = require("UIActivityGlobalBattle/UIActivityGlobalBattleViewFunction")
local Luabehaviour = {
  serialize = function()
    local status = {}
    status.activityId = DataModel.activityId
    return Json.encode(status)
  end,
  deserialize = function(initParams)
    DataModel.remainTime = 0
    if initParams then
      local parms = Json.decode(initParams)
      DataModel:Init(parms)
      Controller:Init()
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  perupdate = function()
  end,
  update = function()
    DataModel.remainTime = DataModel.remainTime + 1
    if DataModel.remainTime > 1000 then
      DataModel.remainTime = 0
      Controller:RefreshTimeShow(true)
    end
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
