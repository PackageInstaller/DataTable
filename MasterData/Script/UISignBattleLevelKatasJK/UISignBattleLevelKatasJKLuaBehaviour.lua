local View = require("UISignBattleLevelKatasJK/UISignBattleLevelKatasJKView")
local DataModel = require("UISignBattleLevelKatasJK/UISignBattleLevelKatasJKDataModel")
local Controller = require("UISignBattleLevelKatasJK/UISignBattleLevelKatasJKController")
local ViewFunction = require("UISignBattleLevelKatasJK/UISignBattleLevelKatasJKViewFunction")
local Luabehaviour = {
  serialize = function()
    local params = {}
    params.activityId = DataModel.activityCA.id
    return Json.encode(params)
  end,
  deserialize = function(initParams)
    local params = Json.decode(initParams)
    DataModel.initParams = params
    local id = params.activityId
    if params.mainActivityId then
      DataModel.mainActivityId = params.mainActivityId
    end
    DataModel:Init(id)
    View.ScrollGrid_Map.grid.self:SetActive(false)
    Net:SendProto("activity.get_cs_activity", function(json)
      DataModel:SetSignBattleData(json)
      View.self:StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        Controller:Init()
      end))
      local activityCA = PlayerData:GetFactoryData(id)
      local cs_activity = DataModel.signBattleData
      local data = cs_activity[tostring(id)]
      if table.count(cs_activity) ~= 0 and data ~= nil and #data.pass_level_index == #activityCA.signLevelList and data.reward == false and 0 < #activityCA.signBattleRewards then
        Net:SendProto("activity.rec_cs_reward", function(json)
          CommonTips.OpenShowItem(json.reward)
        end, id)
      end
    end)
  end,
  awake = function()
  end,
  start = function()
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
