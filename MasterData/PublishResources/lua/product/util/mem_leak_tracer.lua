MemLeakTracer = {
  IsRecording = false,
  RecordCallStack = true,
  MemLeakTable = {},
  OutputContentTitle = "MemLeakTracer Output\n",
  OutputContent = "",
  MemoryGatherCount = 0,
  MemoryCount = {},
  MemoryKeys = {},
  MemoryInfoList = {},
  MemoryDetail = {}
}
setmetatable(MemLeakTracer.MemLeakTable, {__mode = "kv"})

function MemLeakTracer:StartRecord(recordCallStack)
  self.IsRecording = true
  self.RecordCallStack = recordCallStack == nil or recordCallStack
  self:ShowToast("MemLeakTracer Start Record  RecordCallStack=" .. tostring(self.RecordCallStack))
end

function MemLeakTracer:StopRecord()
  self.IsRecording = false
  self:ShowToast("MemLeakTracer Stop Record")
end

function MemLeakTracer:GCAndGatherLeakMemInfo()
  self.MemoryGatherCount = self.MemoryGatherCount + 1
  self:ShowToast("MemLeakTracer Take Memory Snapshot count:" .. self.MemoryGatherCount)
  HelperProxy:GetInstance():GCCollect()
  collectgarbage("collect")
  HelperProxy:GetInstance():GCCollect()
  collectgarbage("collect")
  local memoryCount = math.floor(collectgarbage("count"))
  self.MemoryCount[self.MemoryGatherCount] = memoryCount
  self:Output("current memory: " .. memoryCount .. " KB")
  local memoryInfo = {}
  self.MemoryInfoList[self.MemoryGatherCount] = memoryInfo
  for k, v in pairs(self.MemLeakTable) do
    if k and k._className then
      self.MemoryKeys[k._className] = true
      if not memoryInfo[k._className] then
        memoryInfo[k._className] = 1
      else
        memoryInfo[k._className] = memoryInfo[k._className] + 1
      end
      if not self.MemoryDetail[k._className] then
        self.MemoryDetail[k._className] = {}
      end
      self.MemoryDetail[k._className][v] = true
    end
  end
  if self.RecordCallStack then
    for k, v in pairs(memoryInfo) do
      self:Output(k .. " :" .. v)
      for trace, _ in pairs(self.MemoryDetail[k]) do
        self:Output("trace: " .. trace)
      end
    end
  end
end

function MemLeakTracer:FindDependent(className)
  self._searched = {}
  self._searched[self] = true
  local registry = debug.getregistry()
  self._searchTarget = className
  self._searchRes = {}
  self:SearchTable(registry, 0)
  self:SearchTable(_G, 0)
  self:SearchTable(package.loaded, 0)
  if #self._searchRes > 0 then
    for i = 1, #self._searchRes do
      self:Output(self._searchRes[i])
    end
  else
    self:Output("No Ref")
  end
end

function MemLeakTracer:SearchTable(table)
  if self._searched[table] then
    return
  end
  self._searched[table] = true
  local tableType
  for key, value in pairs(table) do
    tableType = type(key)
    if tableType == "table" then
      if rawget(key, "_className") == self._searchTarget then
        if table._className then
          self._searchRes[#self._searchRes + 1] = table._className
        else
          self._searchRes[#self._searchRes + 1] = tostring(table)
        end
      end
      self:SearchTable(key)
    elseif tableType == "function" then
      self:FindRefInFunction(key)
    end
    tableType = type(value)
    if tableType == "table" then
      if rawget(value, "_className") == self._searchTarget then
        if table._className then
          self._searchRes[#self._searchRes + 1] = table._className
        else
          self._searchRes[#self._searchRes + 1] = tostring(table)
        end
      end
      self:SearchTable(value)
    elseif tableType == "function" then
      self:FindRefInFunction(value)
    end
  end
  local mt = getmetatable(table)
  if mt then
    self:SearchTable(mt)
  end
end

function MemLeakTracer:FindRefInFunction(func)
  if self._searched[func] then
    return
  end
  self._searched[func] = true
  local dInfo = debug.getinfo(func, "Su")
  local upsNum = dInfo.nups
  for i = 1, upsNum do
    local strUpName, cUpValue = debug.getupvalue(func, i)
    local strUpValueType = type(cUpValue)
    if "table" == strUpValueType then
      if rawget(cUpValue, "_className") == self._searchTarget then
        self:Output("Found in function @file: " .. dInfo.short_src .. " at line: " .. dInfo.linedefined)
      end
      self:SearchTable(cUpValue)
    elseif "function" == strUpValueType then
      self:FindRefInFunction(cUpValue)
    end
  end
end

function MemLeakTracer:Output(output)
  Log.fatal(output)
end

function MemLeakTracer:ShowToast(toast)
  ToastManager.ShowToast(toast)
end

function MemLeakTracer:Output2File(filePath)
  local file = assert(io.open(filePath, "w"))
  self.OutputContent = self.OutputContentTitle
  self.OutputContent = self.OutputContent .. "泄露实例|泄露数量&构造栈\\抓取次数\t"
  for i = 1, self.MemoryGatherCount do
    self.OutputContent = self.OutputContent .. "第" .. i .. "次抓取" .. "\t"
  end
  self.OutputContent = self.OutputContent .. "\nLua内存总量(KB)\t"
  for i = 1, self.MemoryGatherCount do
    self.OutputContent = self.OutputContent .. self.MemoryCount[i] .. "\t"
  end
  self.OutputContent = self.OutputContent .. "\n"
  if self.MemoryGatherCount > 0 then
    local memoryInfo = self.MemoryInfoList[self.MemoryGatherCount]
    local dic = SortedArray:New(Algorithm.COMPARE_CUSTOM, function(obj1, obj2)
      local count1 = memoryInfo[obj1]
      local count2 = memoryInfo[obj2]
      if count1 and count2 then
        return count1 - count2
      elseif count1 then
        return 1
      elseif count2 then
        return -1
      else
        return 0
      end
    end)
    dic:AllowDuplicate()
    for k, _ in pairs(self.MemoryKeys) do
      dic:Insert(k)
    end
    for i = 1, dic:Size() do
      local className = dic:GetAt(i)
      self.OutputContent = self.OutputContent .. className .. "\t"
      for i = 1, self.MemoryGatherCount do
        local memoryInfo = self.MemoryInfoList[i]
        if memoryInfo[className] then
          self.OutputContent = self.OutputContent .. memoryInfo[className] .. "\t"
        else
          self.OutputContent = self.OutputContent .. "-\t"
        end
      end
      if self.RecordCallStack then
        self.OutputContent = self.OutputContent .. [[

Traces:
]]
        for trace, _ in pairs(self.MemoryDetail[className]) do
          self.OutputContent = self.OutputContent .. trace .. "\n"
        end
      else
        self.OutputContent = self.OutputContent .. "\n"
      end
    end
  end
  file:write(self.OutputContent)
  io.close(file)
end
