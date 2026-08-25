local CommandBufferMgr = NewClass("CommandBufferMgr")
local unpack = _ENV.unpack
local Trycall = _ENV.Trycall
local UnityTime = CS.UnityEngine.Time

function CommandBufferMgr:ctor()
  self.commandBuffer = {}
  self.tempBuffer = {}
end

function CommandBufferMgr:PushCommand(handler, handlerObj, repeatable, ...)
  if not repeatable then
    self:RemoveCommandEntry(handler, handlerObj)
  end
  local entry = CommandEntry.GetPool():FetchObject()
  entry.handler = handler
  entry.handlerObj = handlerObj
  entry.params = {
    ...
  }
  entry.isValid = true
  entry.delay = 0
  table.insert(self.commandBuffer, entry)
  return entry
end

function CommandBufferMgr:ExecuteCommandBuffer()
  if 0 == #self.commandBuffer then
    return
  end
  local deltaTime = UnityTime.deltaTime
  table.clear(self.tempBuffer)
  table.mergeWithoutGc(self.tempBuffer, self.commandBuffer)
  table.clear(self.commandBuffer)
  for i = 1, #self.tempBuffer do
    local entry = self.tempBuffer[i]
    if not entry.isValid then
      CommandEntry.GetPool():ReturnObject(entry)
    else
      entry.delay = entry.delay - deltaTime
      if entry.delay <= 0 then
        self:ExecuteCommand(entry)
        CommandEntry.GetPool():ReturnObject(entry)
      else
        table.insert(self.commandBuffer, self.tempBuffer[i])
      end
    end
  end
end

function CommandBufferMgr:ExecuteCommand(entry)
  if not entry.isValid then
    return
  end
  entry.isValid = false
  if entry.handlerObj then
    Trycall(entry.handler, entry.handlerObj, unpack(entry.params))
  else
    Trycall(entry.handler, unpack(entry.params))
  end
end

function CommandBufferMgr:ClearCommands()
  self.commandBuffer = {}
  table.clear(self.tempBuffer)
end

function CommandBufferMgr:RemoveCommandEntry(handler, handlerObj)
  for i = 1, #self.commandBuffer do
    local entry = self.commandBuffer[i]
    if entry.isValid and entry.handler == handler and entry.handlerObj == handlerObj then
      entry.isValid = false
      table.remove(self.commandBuffer, i)
      CommandEntry.GetPool():ReturnObject(entry)
      break
    end
  end
end

CommandBufferMgr.Instance = CommandBufferMgr()
return CommandBufferMgr
