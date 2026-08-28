local View = require("UIChildMission/UIChildMissionView")
local DataModel = require("UIChildMission/UIChildMissionDataModel")
local ViewFunction = require("UIChildMission/UIChildMissionViewFunction")
local Controller = require("UIChildMission/UIChildMissionController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.Group_Title.Img_Title:SetSprite((GetResPath(88300324)))
    DataModel.initParams = initParams
    DataModel.decodeParams = Json.decode(initParams)
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
