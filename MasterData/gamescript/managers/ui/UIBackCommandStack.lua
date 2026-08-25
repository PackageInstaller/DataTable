local M = {
  _cmdStack = {},
  _showDebugInfo = false
}

function M._Debug(msg, ...)
  if M._showDebugInfo then
    msg = string.format(msg, ...)
    Logger.Debug("[backstack] " .. msg)
  end
end

function M.Push(cmd)
  if cmd then
    table.insert(M._cmdStack, 1, cmd)
    M._Debug("Push %s", cmd.uiPanel.url or cmd.uiPanel)
  end
end

function M.GetTopElement()
  if #M._cmdStack > 0 then
    return M._cmdStack[1]
  else
    return nil
  end
end

function M.Pop()
  local cmd = table.remove(M._cmdStack, 1)
  if cmd then
    M._Debug("Pop %s", cmd.uiPanel.url or cmd.uiPanel)
  end
  return cmd
end

function M.MoveToTop(uiPanel)
  local cmd = M.Remove(uiPanel)
  if cmd then
    table.insert(M._cmdStack, 1, cmd)
    M._Debug("MoveToTop %s", cmd.uiPanel.url or cmd.uiPanel)
  end
end

function M.MoveToBottom(uiPanel)
  local cmd = M.Remove(uiPanel)
  if cmd then
    table.insert(M._cmdStack, cmd)
    M._Debug("MoveToBottom %s", cmd.uiPanel.url or cmd.uiPanel)
  end
end

function M.Remove(uiPanel)
  for idx, cmd in ipairs(M._cmdStack) do
    if cmd.uiPanel == uiPanel then
      table.remove(M._cmdStack, idx)
      M._Debug("Remove %s", cmd.uiPanel.url or cmd.uiPanel)
      return cmd
    end
  end
end

function M.Clear()
  M._cmdStack = {}
  M._Debug("Clear")
end

return M
