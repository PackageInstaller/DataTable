local time = CS.UnityEngine.Time
local M = {
  _actionList = {}
}
local waiterIndex = 0

function M.OnNextFrame(action, delay_frame)
  waiterIndex = waiterIndex + 1
  delay_frame = delay_frame or 0
  table.insert(M._actionList, {
    frameCount = time.frameCount + delay_frame,
    action = action,
    waiterIndex = waiterIndex
  })
  return waiterIndex
end

function M.RemoveWaiter(action)
  if not action then
    return
  end
  local actionList = M._actionList
  local actionInfo
  for i = #actionList, 1, -1 do
    actionInfo = actionList[i]
    if actionInfo.action == action or actionInfo.waiterIndex == action then
      table.remove(M._actionList, i)
      break
    end
  end
end

function M.Update()
  local frameCount = time.frameCount
  for i = #M._actionList, 1, -1 do
    local action = M._actionList[i]
    if frameCount > action.frameCount then
      table.remove(M._actionList, i)
      action.action()
    end
  end
end

return M
