local View = require("UIActivityRechargeCommon/UIActivityRechargeCommonView")
local DataModel = require("UIActivityRechargeCommon/UIActivityRechargeCommonDataModel")
local ViewFunction = require("UIActivityRechargeCommon/UIActivityRechargeCommonViewFunction")
local Controller = require("UIActivityRechargeCommon/UIActivityRechargeCommonController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local data = Json.decode(initParams)
      DataModel.id = data.activityId
    end
    Controller:InitData(DataModel.id)
    Controller:InitView()
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
