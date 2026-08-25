local NotifyDispatcher = {}

function NotifyDispatcher.Extend(target)
  target.listenPendings = {}
  target.dispatchPendings = {}
  target.allListeners = {}
  target.dispatching = {}
  target.tempToRemoves = {}
  
  function target.AddListener(targetObj, notifyName, handler, handlerObj, priority)
    if not handler then
      Logger.Error("Notify handler cannot be nil,notifyName=", notifyName)
      return
    end
    local bExists = targetObj:_HasListenerInQueue(notifyName, handler, handlerObj)
    local bToInsert = false
    local bToDelete = false
    if targetObj.dispatching[notifyName] then
      local status = targetObj:_GetStatusInPending(notifyName, handler, handlerObj)
      if status == NotifyStatus.ToInsert then
        bToInsert = true
      elseif status == NotifyStatus.ToDelete then
        bToDelete = true
      end
    end
    if bToInsert then
      return
    end
    if bExists and not bToDelete then
      return
    end
    local entry = NotifyEntry.GetPool():FetchObject()
    entry.name = notifyName
    entry.handlerObj = handlerObj
    entry.handler = handler
    entry.priority = priority or NotifyPriority.Normal
    if targetObj.dispatching[notifyName] then
      targetObj:_RemoveFromListenPending(notifyName, handler, handlerObj)
      entry.status = NotifyStatus.ToInsert
      if not targetObj.listenPendings[notifyName] then
        targetObj.listenPendings[notifyName] = {}
      end
      table.insert(targetObj.listenPendings[notifyName], entry)
    else
      targetObj:_SafeAddListener(entry)
    end
  end
  
  function target.RemoveAllListener(targetObj, notifyName)
    if targetObj.allListeners[notifyName] == nil then
      return
    end
    local listeners = targetObj.allListeners[notifyName]
    for i = NotifyPriority.High, NotifyPriority.Low, -1 do
      local entries = listeners[i]
      local entryCount = #entries
      for j = 1, entryCount do
        local tempItem = {}
        tempItem.handler = entries[j].handler
        tempItem.handlerObj = entries[j].handlerObj
        table.insert(targetObj.tempToRemoves, tempItem)
      end
    end
    local len = #targetObj.tempToRemoves
    for i = 1, len do
      targetObj:RemoveListener(notifyName, targetObj.tempToRemoves[i].handler, targetObj.tempToRemoves[i].handlerObj)
      targetObj.tempToRemoves[i] = nil
    end
  end
  
  function target.RemoveListener(targetObj, notifyName, handler, handlerObj, isRemoveAllHandler)
    if targetObj.allListeners[notifyName] == nil then
      return
    end
    if targetObj.dispatching[notifyName] then
      targetObj:_RemoveFromListenPending(notifyName, handler, handlerObj, isRemoveAllHandler)
      local entry = NotifyEntry.GetPool():FetchObject()
      entry.handler = handler
      entry.handlerObj = handlerObj
      entry.status = NotifyStatus.ToDelete
      entry.name = notifyName
      entry.isRemoveAllHandler = isRemoveAllHandler
      if not targetObj.listenPendings[notifyName] then
        targetObj.listenPendings[notifyName] = {}
      end
      table.insert(targetObj.listenPendings[notifyName], entry)
    else
      targetObj:_SafeRemoveListener(notifyName, handler, handlerObj, isRemoveAllHandler)
    end
  end
  
  function target._RemoveFromListenPending(targetObj, notifyName, handler, handlerObj, isRemoveAllHandler)
    local pendings = targetObj.listenPendings[notifyName]
    if not pendings then
      return
    end
    local pCount = #pendings
    for i = pCount, 1, -1 do
      local entry = pendings[i]
      if entry.name == notifyName and entry.handler == handler then
        if isRemoveAllHandler then
          NotifyEntry.GetPool():ReturnObject(entry)
          table.remove(pendings, i)
        elseif entry.handlerObj == handlerObj then
          NotifyEntry.GetPool():ReturnObject(entry)
          table.remove(pendings, i)
          break
        end
      end
    end
  end
  
  function target._SafeAddListener(targetObj, entry)
    local listeners = targetObj.allListeners[entry.name]
    if nil == listeners then
      listeners = {}
      for i = NotifyPriority.Low, NotifyPriority.High do
        listeners[i] = {}
      end
      targetObj.allListeners[entry.name] = listeners
    end
    if targetObj:_HasListenerInQueue(entry.name, entry.handler, entry.handlerObj) then
      NotifyEntry.GetPool():ReturnObject(entry)
      return
    end
    entry.status = NotifyStatus.Active
    table.insert(listeners[entry.priority], entry)
  end
  
  function target._SafeRemoveListener(targetObj, notifyName, handler, handlerObj, isRemoveAllHandler)
    if targetObj.allListeners[notifyName] == nil then
      return
    end
    local listeners = targetObj.allListeners[notifyName]
    for i = NotifyPriority.Low, NotifyPriority.High do
      local entries = listeners[i]
      local entryCount = #entries
      for j = entryCount, 1, -1 do
        if entries[j].handler == handler then
          if isRemoveAllHandler then
            NotifyEntry.GetPool():ReturnObject(entries[j])
            table.remove(entries, j)
          elseif entries[j].handlerObj == handlerObj then
            NotifyEntry.GetPool():ReturnObject(entries[j])
            table.remove(entries, j)
            break
          end
        end
      end
    end
  end
  
  function target.Dispatch(targetObj, notifyName, ...)
    if targetObj.allListeners == nil or targetObj.allListeners[notifyName] == nil then
      return
    end
    if targetObj.dispatching[notifyName] then
      local dEntry = DispatchEntry.GetPool():FetchObject()
      dEntry.name = notifyName
      local args = (...)
      if nil ~= args then
        dEntry.message = {
          ...
        }
      else
        dEntry.message = nil
      end
      table.insert(targetObj.dispatchPendings, dEntry)
      return
    end
    targetObj.dispatching[notifyName] = true
    local listeners = targetObj.allListeners[notifyName]
    for i = NotifyPriority.High, NotifyPriority.Low, -1 do
      local entries = listeners[i]
      local entryCount = #entries
      for j = 1, entryCount do
        if entries[j].handlerObj then
          Trycall(entries[j].handler, entries[j].handlerObj, ...)
        else
          Trycall(entries[j].handler, ...)
        end
      end
    end
    targetObj.dispatching[notifyName] = nil
    local pendings = targetObj.listenPendings[notifyName]
    if pendings then
      local pendingCount = #pendings
      for i = 1, pendingCount do
        local pEntry = pendings[i]
        if pEntry.status == NotifyStatus.ToInsert then
          targetObj:_SafeAddListener(pEntry)
        elseif pEntry.status == NotifyStatus.ToDelete then
          targetObj:_SafeRemoveListener(pEntry.name, pEntry.handler, pEntry.handlerObj, pEntry.isRemoveAllHandler)
          NotifyEntry.GetPool():ReturnObject(pEntry)
        end
        pendings[i] = nil
      end
    end
    if #targetObj.dispatchPendings > 0 then
      local dpEntry = table.remove(targetObj.dispatchPendings, 1)
      if not targetObj.dispatching[dpEntry.name] then
        if dpEntry.message then
          targetObj:Dispatch(dpEntry.name, unpack(dpEntry.message))
        else
          targetObj:Dispatch(dpEntry.name)
        end
        DispatchEntry.GetPool():ReturnObject(dpEntry)
      end
    end
  end
  
  function target._GetStatusInPending(targetObj, notifyName, handler, handlerObj)
    local status = 0
    local pendings = targetObj.listenPendings[notifyName]
    if pendings then
      local count = #pendings
      for i = count, 1, -1 do
        local pEntry = pendings[i]
        if pEntry.name == notifyName and pEntry.handlerObj == handlerObj and pEntry.handler == handler then
          if pEntry.status == NotifyStatus.ToInsert then
            status = NotifyStatus.ToInsert
            break
          elseif pEntry.status == NotifyStatus.ToDelete then
            status = NotifyStatus.ToDelete
            break
          end
        end
      end
    end
    return status
  end
  
  function target._HasListenerInQueue(targetObj, notifyName, handler, handlerObj)
    if targetObj.allListeners[notifyName] == nil then
      return false
    end
    local listeners = targetObj.allListeners[notifyName]
    local flag = false
    for i = NotifyPriority.Low, NotifyPriority.High do
      local entries = listeners[i]
      local entryCount = #entries
      for j = entryCount, 1, -1 do
        if entries[j].handler == handler and entries[j].handlerObj == handlerObj then
          flag = true
          break
        end
      end
      if flag then
        break
      end
    end
    return flag
  end
  
  function target.HasListener(targetObj, notifyName, handler, handlerObj)
    local bRet = targetObj:_HasListenerInQueue(notifyName, handler, handlerObj)
    if targetObj.dispatching then
      local status = targetObj:_GetStatusInPending(notifyName, handler, handlerObj)
      if status == NotifyStatus.ToInsert then
        bRet = true
      elseif status == NotifyStatus.ToDelete then
        bRet = false
      end
    end
    return bRet
  end
end

return NotifyDispatcher
