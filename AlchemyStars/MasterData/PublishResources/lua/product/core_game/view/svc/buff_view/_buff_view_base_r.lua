_class("BuffViewBase", Object)
BuffViewBase = BuffViewBase

function BuffViewBase:Constructor(viewInstance, buffResult, viewName, triggers, notify)
  self._viewInstance = viewInstance
  self._buffResult = buffResult
  self._world = viewInstance:World()
  self._entity = viewInstance:Entity()
  self._viewName = viewName
  self._triggers = triggers
  self._notify = notify
end

function BuffViewBase:BuffViewInstance()
  return self._viewInstance
end

function BuffViewBase:GetBuffResult()
  return self._buffResult
end

function BuffViewBase:Entity()
  return self._entity
end

function BuffViewBase:World()
  return self._world
end

function BuffViewBase:ViewName()
  return self._viewName
end

function BuffViewBase:ViewParams()
  return self._viewInstance:BuffConfigData():GetViewParams()
end

function BuffViewBase:GetNotify()
  return self._notify
end

function BuffViewBase:GetTriggers()
  return self._triggers
end

function BuffViewBase:HasTriggerType(triggerType)
  if not self._triggers then
    return false
  end
  for _, trigger in ipairs(self._triggers) do
    if triggerType == trigger:GetTriggerType() then
      return true
    end
  end
  return false
end

function BuffViewBase:IsNotifyMatch(notify)
  return true
end

function BuffViewBase:CheckNotifyAndTriggers(notify)
  local notifyType = notify:GetNotifyType()
  if notify.GetChainSkillTimeIndex then
    if notify:GetChainSkillTimeIndex() ~= self._notify:GetChainSkillTimeIndex() then
      return false
    end
    if notify.GetChainSkillStageIndex and notify:GetChainSkillStageIndex() ~= self._notify:GetChainSkillStageIndex() then
      return false
    end
  end
  if self:HasTriggerType(TriggerType.NotifyMe) and notify:GetNotifyEntity() ~= self._entity then
    return false
  end
  return self:IsNotifyMatch(notify)
end

function BuffViewBase:PlayView(TT)
end
