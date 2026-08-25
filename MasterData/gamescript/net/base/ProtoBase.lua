local ProtoBase = System.NewClass("ProtoBase")
ProtoBase.__dispatchers = {}

function ProtoBase.RegisterDispatcher(class, protoClassName, name, func)
  local protoToList = ProtoBase.__dispatchers[protoClassName]
  if not protoToList then
    protoToList = {}
    setmetatable(protoToList, {__mode = "k"})
    ProtoBase.__dispatchers[protoClassName] = protoToList
  end
  local list = protoToList[class]
  if not list then
    list = {}
    protoToList[class] = list
  end
  local funcList = list[name]
  if not funcList then
    funcList = {}
    list[name] = funcList
  end
  table.insert(funcList, func)
end

function ProtoBase.UnRegisterDispatcher(class, protoClassName, name, func)
  local protoToList = ProtoBase.__dispatchers[protoClassName]
  if not protoToList then
    return
  end
  local list = protoToList[class]
  local funcList = list and list[name]
  if not funcList then
    return
  end
  for i, v in ipairs(funcList) do
    if v == func then
      table.remove(funcList, i)
      break
    end
  end
  if 0 == #funcList then
    list[name] = nil
    if nil == table.next(list) then
      protoToList[class] = nil
    end
  end
end

function ProtoBase:Dispatch(funcName, ...)
  local className = self:GetTypeName()
  local protoToList = ProtoBase.__dispatchers[className]
  if protoToList then
    for class, protos in pairs(protoToList) do
      if not class.destroy then
        for name, value in pairs(protos) do
          if name == funcName then
            for _, func in ipairs(value) do
              func(...)
            end
          end
        end
      end
    end
  end
  EventMgr.Instance.OnProtoMsgResponse:Dispatch(funcName)
end

function ProtoBase:Startup()
end

function ProtoBase:Shutdown()
end

function ProtoBase:ClearData()
end

return ProtoBase
