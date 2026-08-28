local View = require("UIGlobalBattleRewards/UIGlobalBattleRewardsView")
local DataModel = require("UIGlobalBattleRewards/UIGlobalBattleRewardsDataModel")
local Controller = require("UIGlobalBattleRewards/UIGlobalBattleRewardsController")
local ViewFunction = require("UIGlobalBattleRewards/UIGlobalBattleRewardsViewFunction")
local Luabehaviour = {
  serialize = function()
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
