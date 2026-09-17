local ReadTables = {}

local function obj2StrObjs(strObjs, obj, count)
  count = count or 0
  local str = ""
  if type(obj) ~= "table" then
    table.insert(strObjs, tostring(obj))
    return
  end
  if ReadTables[obj] then
    table.insert(strObjs, tostring(obj))
    return
  end
  ReadTables[obj] = true
  table.insert(strObjs, "\n")
  for k, v in pairs(obj) do
    for i = 1, count do
      table.insert(strObjs, "  ")
    end
    table.insert(strObjs, tostring(k))
    table.insert(strObjs, tostring(" : "))
    obj2StrObjs(strObjs, v, count + 1)
    table.insert(strObjs, "\n")
  end
end

local function objs2Str(...)
  local objs = {
    ...
  }
  local strObjs = {}
  ReadTables = {}
  for _, obj in pairs(objs) do
    obj2StrObjs(strObjs, obj)
    table.insert(strObjs, "\n")
  end
  return table.concat(strObjs)
end

function printf(tag, ...)
  local str = objs2Str(...)
  if IS_EDITOR then
    print(tag, str, [[

tag: ]] .. debug.traceback(tag, 2))
  else
    print(tag, str)
  end
end

function warnf(tag, ...)
  warn(tag, objs2Str(...), [[

tag: ]] .. debug.traceback(tag, 2))
end

function errorf(message, level)
  if message == nil then
    message = "nil"
  end
  error(message .. [[

tag: ]] .. debug.traceback("Error", 2), level)
end

function printLog(tag, ...)
  local str = objs2Str(...)
  if IS_EDITOR then
    C_MJLog.LogInfo(tag .. " " .. str .. [[

tag: ]] .. debug.traceback(tag, 2))
  else
    C_MJLog.LogInfo(tag .. " " .. str)
  end
end
