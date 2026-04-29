_class("GuideLogicService", BaseService)
GuideLogicService = GuideLogicService

function GuideLogicService:Constructor(world)
  self._world = world
end

function GuideLogicService:Initialize()
  local triggerSvc = self:GetService("Trigger")
  local triggerHandler = TriggerCallbackOwner:New(self, self.AddBuff)
  self.trigger = triggerSvc:CreateTrigger(triggerHandler, {
    {
      NotifyType.GameStart
    },
    {
      TriggerType.Always
    }
  }, self._world)
  triggerSvc:Attach(self.trigger)
  self.trigger:SetActive(true)
  self.MissionId2GuideId = {}
  local s = Cfg.cfg_guide_const.guide_buff_mission_to_guideid.StrValue
  local s1 = string.split(s, "|")
  for index, value in ipairs(s1) do
    local s2 = string.split(value, ",")
    local missionId = tonumber(s2[1])
    local guideId = tonumber(s2[2])
    self.MissionId2GuideId[missionId] = guideId
  end
  local buffs = Cfg.cfg_guide_const.guide_buff_mission_to_guideid.ArrayValue
  self.LockBloodBuff = buffs[1]
  self.LockRoundBuff = buffs[2]
end

function GuideLogicService:AddBuff()
  local missionId = self._world.BW_WorldInfo.missionID
  if missionId then
    local guideId = self.MissionId2GuideId[missionId]
    if guideId then
      local guideId2Count = self._world.BW_WorldInfo.guideInfo.guide_id2count
      if guideId2Count and not guideId2Count[guideId] then
        local ownerEntity = self._world:Player():GetLocalTeamEntity()
        local buffLogicService = self._world:GetService("BuffLogic")
        buffLogicService:AddBuff(self.LockBloodBuff, ownerEntity)
        buffLogicService:AddBuff(self.LockRoundBuff, ownerEntity)
      end
    end
  end
end
