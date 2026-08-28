local View = require("UIGroup_EnemyTalent/UIGroup_EnemyTalentView")
local DataModel = require("UIGroup_EnemyTalent/UIGroup_EnemyTalentDataModel")
local ViewFunction = require("UIGroup_EnemyTalent/UIGroup_EnemyTalentViewFunction")
local Controller = require("UIGroup_EnemyTalent/UIGroup_EnemyTalentController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local param = Json.decode(initParams)
      DataModel.isInBattle = param.isInBattle
      if param.isInBattle ~= true then
        Controller:InitSingularityInfo()
      end
    end
    Controller:RefreshSingularityInfo()
    Controller:RefreshPanelInfo()
    Controller:RefreshTalent()
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
