local this = L_BevTree:registClass("guide.checkSkillStartRelease", L_BevTree.action)

function this:param()
  self.skillSlot = ""
  self.skillIds = ""
end

function this:parse()
  self.skillSlot = self:getParam("skillSlot")
  self.skillIds = self:getParam("skillIds")
  self.detectSlotIds = {}
  if not string.isEmpty(self.skillSlot) then
    local slots = string.split(self.skillSlot, "|")
    for _, v in ipairs(slots) do
      if not string.isEmpty(v) then
        table.insert(self.detectSlotIds, tonumber(v))
      end
    end
  end
  self.detectSkillIds = {}
  if not string.isEmpty(self.skillIds) then
    local skills = string.split(self.skillIds, "|")
    for _, v in ipairs(skills) do
      if not string.isEmpty(v) then
        table.insert(self.detectSkillIds, tonumber(v))
      end
    end
  end
end

function this:onEnter()
  L_GuideManager:setIsDetectSkill(true)
  self.result = L_BevTree.taskResult.Running
  self.skillCheckHandle = self.skillCheckHandle or handler(self, self.onSkillCheck)
  if self.skillCheckHandle ~= nil then
    C_ExternalManager.AddEvent(C_EExternalEventType.SkillStart, self.skillCheckHandle)
  end
end

function this:onFinish()
  self:removeEvent()
  self:resumeWorld()
end

function this:onReset()
  self:removeEvent()
  self.resume = false
end

function this:removeEvent()
  if self.skillCheckHandle ~= nil then
    C_ExternalManager.RemoveEvent(C_EExternalEventType.SkillStart, self.skillCheckHandle)
    self.skillCheckHandle = nil
  end
  L_GuideManager:setIsDetectSkill(false)
end

function this:resumeWorld()
  if not self.resume then
    L_GuideManager:setWorldPause(false, self.tree.param.guideId)
    self.resume = true
  end
end

function this:onSkillCheck(arg)
  if table.containsValue(self.detectSlotIds, arg.slotId) or table.containsValue(self.detectSkillIds, arg.skillId) then
    self:resumeWorld()
    self.result = L_BevTree.taskResult.Success
  end
end

function this:execute()
  return self.result
end

return this
