_class("GameEventDispatcher", Object)
GameEventDispatcher = GameEventDispatcher
local tableIKey = table.ikey
local tableClear = table.clear
local tableInsert = table.insert
local fieldGetListenerID = "GetListenerID"
local fieldGetID = "GetID"

function GameEventDispatcher:Constructor()
  self.type2ListenerContexts = {}
  self.type2Callbacks = {}
  self.type2ListenerContextsTodoList = {}
  self.type2CallbacksTodoList = {}
  self.dispatchedIDArray = {}
end

function GameEventDispatcher:AddListener(gameEventType, listenerContext)
  local listenerContexts = self.type2ListenerContextsTodoList[gameEventType]
  if not listenerContexts then
    listenerContexts = ArrayList:New()
    self.type2ListenerContextsTodoList[gameEventType] = listenerContexts
  end
  if self:IsIDInContainer(listenerContexts, listenerContext.listenerID, fieldGetListenerID) then
    return
  end
  listenerContexts:PushFront(listenerContext)
end

function GameEventDispatcher:RemoveListener(gameEventType, listenerID)
  self:RemoveListenerFrom(gameEventType, listenerID, self.type2ListenerContexts, fieldGetListenerID)
  self:RemoveListenerFrom(gameEventType, listenerID, self.type2ListenerContextsTodoList, fieldGetListenerID)
end

function GameEventDispatcher:AddCallbackListener(gameEventType, callback)
  local listenerCallbacks = self.type2CallbacksTodoList[gameEventType]
  if not listenerCallbacks then
    listenerCallbacks = ArrayList:New()
    self.type2CallbacksTodoList[gameEventType] = listenerCallbacks
  end
  if self:IsIDInContainer(listenerCallbacks, callback:GetID(), fieldGetID) then
    return
  end
  listenerCallbacks:PushFront(callback)
end

function GameEventDispatcher:RemoveCallbackListener(gameEventType, callback)
  if self.type2Callbacks[gameEventType] and callback then
    self:RemoveListenerFrom(gameEventType, callback:GetID(), self.type2Callbacks, fieldGetID)
  end
  if self.type2CallbacksTodoList[gameEventType] and callback then
    self:RemoveListenerFrom(gameEventType, callback:GetID(), self.type2CallbacksTodoList, fieldGetID)
  end
end

function GameEventDispatcher:RegisterEventCallBack(gameEventType, clsObject, callback)
  local callBackFunc = GameHelper:GetInstance():CreateEventCallback(gameEventType, callback, clsObject)
  self:AddCallbackListener(gameEventType, callBackFunc)
  return callBackFunc
end

function GameEventDispatcher:UnRegisterEventCallback(eventCallback)
  local type = eventCallback:GetEventType()
  self:RemoveCallbackListener(type, eventCallback)
end

function GameEventDispatcher:Dispatch(gameEventType, ...)
  self:MergeListenersTodoToCurrent(self.type2ListenerContextsTodoList, self.type2ListenerContexts, fieldGetListenerID)
  self:MergeListenersTodoToCurrent(self.type2CallbacksTodoList, self.type2Callbacks, fieldGetID)
  local dispatchedIDArray = tableClear(self.dispatchedIDArray)
  local listenerContexts = self.type2ListenerContexts[gameEventType]
  if listenerContexts then
    for i = listenerContexts:Size(), 1, -1 do
      local listenerContext = listenerContexts:GetAt(i)
      if listenerContext and not tableIKey(dispatchedIDArray, listenerContext.listenerID) then
        tableInsert(dispatchedIDArray, listenerContext.listenerID)
        listenerContext:OnGameEvent(gameEventType, ...)
      end
    end
  end
  tableClear(dispatchedIDArray)
  local listenerCallbacks = self.type2Callbacks[gameEventType]
  if listenerCallbacks then
    for i = listenerCallbacks:Size(), 1, -1 do
      local listenerCallback = listenerCallbacks:GetAt(i)
      if listenerCallback and not tableIKey(dispatchedIDArray, listenerCallback:GetID()) then
        tableInsert(dispatchedIDArray, listenerCallback:GetID())
        listenerCallback:Call(...)
      end
    end
  end
end

function GameEventDispatcher:RemoveAllListeners()
  self.type2ListenerContexts = {}
  self.type2Callbacks = {}
  self.type2ListenerContextsTodoList = {}
  self.type2CallbacksTodoList = {}
end

function GameEventDispatcher:RemoveListenerFrom(gameEventType, listenerID, t, checkField)
  local listeners = t[gameEventType]
  if not listeners then
    return
  end
  for i = 1, listeners:Size() do
    local listener = listeners:GetAt(i)
    if listener and listener[checkField](listener) == listenerID then
      listeners:RemoveAt(i)
      break
    end
  end
end

function GameEventDispatcher:MergeListenersTodoToCurrent(todoTable, curTable, checkField)
  for gameEventType, todoListeners in pairs(todoTable) do
    local curListeners = curTable[gameEventType]
    if curListeners then
      for i = todoListeners:Size(), 1, -1 do
        local todoListener = todoListeners:GetAt(i)
        local todoListenerID = todoListener[checkField](todoListener)
        if not self:IsIDInContainer(curListeners, todoListenerID, checkField) then
          curListeners:PushFront(todoListener)
        end
      end
    else
      curTable[gameEventType] = todoListeners
    end
  end
  tableClear(todoTable)
end

function GameEventDispatcher:IsIDInContainer(arrayList, targetID, checkField)
  for i = 1, arrayList:Size() do
    local obj = arrayList:GetAt(i)
    if obj and obj[checkField](obj) == targetID then
      return true
    end
  end
  return false
end
