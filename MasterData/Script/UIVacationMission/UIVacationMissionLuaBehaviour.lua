local View = require("UIVacationMission/UIVacationMissionView")
local DataModel = require("UIVacationMission/UIVacationMissionDataModel")
local ViewFunction = require("UIVacationMission/UIVacationMissionViewFunction")
local Controller = require("UIVacationMission/UIVacationMissionController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.Group_Title.Img_Title:SetSprite((GetResPath(88300315)))
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
