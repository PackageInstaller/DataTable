local ShowCharacterUtil = {}
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_LeanGesture = CS.Lean.Touch.LeanGesture

function ShowCharacterUtil.DoGestureFunc(trackedDolly, fingerList)
  if trackedDolly == nil then
    return
  end
  local screenDelta
  if fingerList.Count == 0 then
    screenDelta = CS_LeanGesture.GetScreenDelta(CS_LeanTouch.Fingers)
  else
    screenDelta = CS_LeanGesture.GetScreenDelta(fingerList)
  end
  trackedDolly.m_PathPosition = trackedDolly.m_PathPosition + -screenDelta.x * 2.5E-4
end

return ShowCharacterUtil
