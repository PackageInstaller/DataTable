_class("UIActivityNPlusSixEventData", Object)
UIActivityNPlusSixEventData = UIActivityNPlusSixEventData

function UIActivityNPlusSixEventData:Constructor(eventId)
  local cfg = Cfg.cfg_component_build_event[eventId]
  if not cfg then
    return
  end
  self._eventId = eventId
  self._type = cfg.Type
  self._rewards = {}
  if cfg.Reward then
    for i = 1, #cfg.Reward do
      local reward = RoleAsset:New()
      reward.assetid = cfg.Reward[i][1]
      reward.count = cfg.Reward[i][2]
      self._rewards[#self._rewards + 1] = reward
    end
  end
  self._name = ""
  if cfg.Name then
    self._name = StringTable.Get(cfg.Name)
  end
  self._title = ""
  if cfg.Title then
    self._title = StringTable.Get(cfg.Title)
  end
  self._des = ""
  if cfg.Des then
    self._des = StringTable.Get(cfg.Des)
  end
  local posConfig = cfg.MapPos
  self._posX = posConfig[1]
  self._posY = posConfig[2]
  self._spineName = cfg.SpineName
  self._idleAnimName = cfg.IdleAnimName
  self._completeAnimName = cfg.CompleteAnimName
  self._completAnimLength = cfg.CompleteAnimLength
  local triggerArea = cfg.TriggerArea
  self._triggerPosX = triggerArea[1]
  self._triggerPosY = triggerArea[2]
  self._triggerWidth = triggerArea[3]
  self._triggerHeight = triggerArea[4]
  self._height = cfg.Height
end

function UIActivityNPlusSixEventData:GetEventId()
  return self._eventId
end

function UIActivityNPlusSixEventData:GetType()
  return self._type
end

function UIActivityNPlusSixEventData:GetRewards()
  return self._rewards
end

function UIActivityNPlusSixEventData:GetName()
  return self._name
end

function UIActivityNPlusSixEventData:GetTitle()
  return self._title
end

function UIActivityNPlusSixEventData:GetDes()
  return self._des
end

function UIActivityNPlusSixEventData:GetPosX()
  return self._posX
end

function UIActivityNPlusSixEventData:GetPosY()
  return self._posY
end

function UIActivityNPlusSixEventData:GetSpineName()
  return self._spineName
end

function UIActivityNPlusSixEventData:GetIdleAnimName()
  return self._idleAnimName
end

function UIActivityNPlusSixEventData:GetCompleteAnimName()
  return self._completeAnimName
end

function UIActivityNPlusSixEventData:GetCompleteAnimLength()
  return self._completAnimLength
end

function UIActivityNPlusSixEventData:GetTriggerAreaPosX()
  return self._triggerPosX
end

function UIActivityNPlusSixEventData:GetTriggerAreaPosY()
  return self._triggerPosY
end

function UIActivityNPlusSixEventData:GetTriggerAreaWidth()
  return self._triggerWidth
end

function UIActivityNPlusSixEventData:GetTriggerAreaHeight()
  return self._triggerHeight
end
