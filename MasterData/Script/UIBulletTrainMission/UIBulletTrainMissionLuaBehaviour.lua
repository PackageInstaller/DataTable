local View = require("UIBulletTrainMission/UIBulletTrainMissionView")
local DataModel = require("UIBulletTrainMission/UIBulletTrainMissionDataModel")
local ViewFunction = require("UIBulletTrainMission/UIBulletTrainMissionViewFunction")
local Controller = require("UIBulletTrainMission/UIBulletTrainMissionController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.Group_Title.Img_Title:SetSprite((GetResPath(88300301)))
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
