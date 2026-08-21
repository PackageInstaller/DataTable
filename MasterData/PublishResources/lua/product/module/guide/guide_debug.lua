_class("GuideDebug", Object)
GuideDebug = GuideDebug
GuideDebug.Enable = nil
GuideDebug.LastGuide = nil
GuideDebug.LastStep = nil
GuideDebug.TestGudie = nil

function GuideDebug.LogGuide(guide)
  if not GuideDebug.Enable then
    return
  end
  if GuideDebug.LastGuide == guide then
    return
  end
  GuideDebug.LastGuide = guide
  GuideDebug.LastStep = nil
  Log.debug("[GuideDebug] new Guide : " .. guide)
end

function GuideDebug.LogStep(step)
  if not GuideDebug.Enable then
    return
  end
  if GuideDebug.LastStep == step then
    return
  end
  GuideDebug.LastStep = step
  Log.debug("[GuideDebug] Guide : " .. GuideDebug.LastGuide .. " Step : " .. step)
end
