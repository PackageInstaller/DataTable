local GuideGroup_55 = class("GuideGroup_55")
local mapEventConfig = {}
local groupId = 55
local totalStep = 1
local current = 1

function GuideGroup_55:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_55:BindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Add(nEventId, self, callback)
    end
  end
end

function GuideGroup_55:UnBindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
end

function GuideGroup_55:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_55:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_55:Step_1()
  local nEntryId = 300121
  self.waitAnimTime = 0.3
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, nEntryId)
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_55:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
end

return GuideGroup_55
