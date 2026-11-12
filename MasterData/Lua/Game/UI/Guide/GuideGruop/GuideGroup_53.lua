local GuideGroup_53 = class("GuideGroup_53")
local mapEventConfig = {}
local groupId = 53
local totalStep = 1
local current = 1

function GuideGroup_53:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_53:BindEvent()
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

function GuideGroup_53:UnBindEvent()
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

function GuideGroup_53:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_53:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_53:Step_1()
  local nEntryId = 300120
  self.waitAnimTime = 0.3
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, nEntryId)
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_53:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
end

return GuideGroup_53
