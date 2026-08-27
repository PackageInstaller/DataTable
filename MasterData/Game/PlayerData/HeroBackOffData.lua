local HeroBackOffData = class("HeroBackOffData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function HeroBackOffData:ctor(datas)
  self.backActivitys = {}
  for _, actdata in pairs(datas) do
    local backActivity = {}
    backActivity.backHeros = {}
    backActivity.actId = actdata.actId
    for _, data in pairs(actdata.elems) do
      backActivity.backHeros[data.heroId] = data
    end
    local activityFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    local activityId = activityFrameCtr:GetIdByActTypeAndActId(ActivityFrameEnum.eActivityType.HeroBackOff, backActivity.actId)
    backActivity.__activityData = activityFrameCtr:GetActivityFrameData(activityId or 0)
    self.backActivitys[backActivity.actId] = backActivity
  end
end

function HeroBackOffData:IsHeroBackOffEnable(heroId)
  for actId, backActivity in pairs(self.backActivitys) do
    if backActivity.__activityData ~= nil and backActivity.__activityData:IsActivityOpen() then
      local returnCfg = ConfigData.activity_return[actId]
      if returnCfg ~= nil and returnCfg.role_dic[heroId] and backActivity.backHeros[heroId] == nil then
        return true, actId
      end
    end
  end
  return false, 0
end

return HeroBackOffData
