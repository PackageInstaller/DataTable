local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local S = require("Common/Singleton"):Register(_ENV, "UnforcedTutorialManager")
Enable = true
Doing = false

function Start()
  this:RegisterGameEvent("UI/WindowInited", OnWindowInited)
end

function OnWindowInited(window)
  local baseinfo = DB:GetData("fci/baseinfo/")
  if baseinfo == nil then
    return
  end
  local level = baseinfo.level
  local xlsxConfig = PB.all("UnforcedTutorial"):where(function(k, v)
    return v.windowName == window.name and v.noCondition and level >= v.minLevel
  end):toarray()[1]
  if xlsxConfig then
    TriggerTutorial(xlsxConfig.id)
  end
end

function TriggerTutorial(tutorialId, OnInitedCallback)
  if not Enable then
    return
  end
  if HasTriggered(tutorialId) or S:Get("TutorialManager").IsTutorialDoing() then
    return
  end
  local xlsxConfig = PB.get("UnforcedTutorial", tutorialId)
  local window = WU.FindWindow(xlsxConfig.windowName)
  local refTutorial = _ENV["$"](window.transform:Find("WindowSize/UnforcedTutorial_" .. tutorialId)) or _ENV["$"](WU.InstantiateWindowPrefab(_ENV["$"](window).WindowSize, window.name .. "/UnforcedTutorial_" .. tutorialId, "UnforcedTutorial_" .. tutorialId))
  refTutorial["$$HideTutorial"]()
  refTutorial["$$Init"]()
  if OnInitedCallback then
    OnInitedCallback(refTutorial)
  end
  refTutorial["$$StartTutorial"](xlsxConfig.delay)
end

function HasTriggered(tutorialId)
  if DB:GetData("fci/baseinfo").level > PB.index("Misc", 1).UnforcedTutorialMaxLevel then
    return true
  end
  local _, t = table.find(this:GetData("fci/tutorial"), function(k, v)
    return v.id == tutorialId
  end)
  if t == nil or t.status == 1 then
    return true
  end
  return false
end
