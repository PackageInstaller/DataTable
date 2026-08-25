local _showDebugInfo = false
local AudioChangeUIStack = System.NewClass("AudioChangeUIStack")

function AudioChangeUIStack._Debug(msg, ...)
  msg = string.format(msg, ...)
  Logger.Error(msg)
end

function AudioChangeUIStack:ctor()
  self.stack = {}
end

function AudioChangeUIStack:Push(newUrl)
  if _showDebugInfo then
    local lastUrl = self:GetTopElement() or "nil"
    AudioChangeUIStack._Debug("OpenNewUI : %s, LastUI : %s", newUrl, lastUrl)
  end
  table.insert(self.stack, newUrl)
end

function AudioChangeUIStack:Pop()
  local url = table.remove(self.stack)
  if url and _showDebugInfo then
    local lastUrl = self:GetTopElement() or "nil"
    AudioChangeUIStack._Debug("CloseUI : %s, CurTopShowUI : %s", url, lastUrl)
  end
  return url
end

function AudioChangeUIStack:Remove(uiPanel)
  for idx, url in ipairs(self.stack) do
    if url == uiPanel then
      if _showDebugInfo then
        AudioChangeUIStack._Debug("Remove %s", uiPanel)
      end
      table.remove(self.stack, idx)
      return url
    end
  end
end

function AudioChangeUIStack:GetTopElement()
  local cnt = #self.stack
  return cnt > 0 and self.stack[cnt] or nil
end

function AudioChangeUIStack:Clear()
  self.stack = {}
  if _showDebugInfo then
    AudioChangeUIStack._Debug("Clear")
  end
end

return AudioChangeUIStack
