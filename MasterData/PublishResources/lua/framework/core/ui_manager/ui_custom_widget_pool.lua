_class("UICustomWidgetPool", Object)
UICustomWidgetPool = UICustomWidgetPool
local TABLE_CLEAR = table.clear

function UICustomWidgetPool:Constructor(parent, dynamicInfoOfEngine)
  self.parent = parent
  self.uiCustomWidgets = {}
  self.dynamicInfoOfEngine = dynamicInfoOfEngine
end

function UICustomWidgetPool:Dispose()
  local uiCustomWidgets = self.uiCustomWidgets
  for i = 1, #uiCustomWidgets do
    local uiCustomWidget = uiCustomWidgets[i]
    uiCustomWidget:UnLoad()
    uiCustomWidget:Dispose()
  end
  self.uiCustomWidgets = nil
  self.parent = nil
  self.dynamicInfoOfEngine = nil
end

function UICustomWidgetPool:ClearWidgets()
  local uiCustomWidgets = self.uiCustomWidgets
  for i = 1, #uiCustomWidgets do
    local uiCustomWidget = uiCustomWidgets[i]
    uiCustomWidget:UnLoad()
    uiCustomWidget:Dispose()
  end
  self.uiCustomWidgets = {}
end

function UICustomWidgetPool:GetAllSpawnList()
  return self.uiCustomWidgets
end

function UICustomWidgetPool:SpawnObject(uiCustomWidgetName)
  local haveItemCount = #self.uiCustomWidgets
  if haveItemCount == 0 then
    local go = self.dynamicInfoOfEngine:SpawnOneObject("0")
    return self:CreateScript(uiCustomWidgetName, go)
  else
    return self:SpawnObjectFromPool()
  end
end

function UICustomWidgetPool:AsyncSpawnObject(TT, uiCustomWidgetName)
  local haveItemCount = #self.uiCustomWidgets
  if haveItemCount == 0 then
    local go = self:AsyncCreateResources(TT, "0")
    return self:CreateScript(uiCustomWidgetName, go)
  else
    self:SpawnObjectFromPool()
  end
end

function UICustomWidgetPool:SpawnObjects(uiCustomWidgetName, count, outSpawnList)
  if outSpawnList then
    TABLE_CLEAR(outSpawnList)
    self:SpawnObjectsInternal(uiCustomWidgetName, count, outSpawnList)
  else
    outSpawnList = {}
    self:SpawnObjectsInternal(uiCustomWidgetName, count, outSpawnList)
    return outSpawnList
  end
end

function UICustomWidgetPool:AsyncSpawnObjects(TT, uiCustomWidgetName, count, outSpawnList)
  if outSpawnList then
    TABLE_CLEAR(outSpawnList)
    self:AsyncSpawnObjectsInternal(TT, uiCustomWidgetName, count, outSpawnList)
  else
    outSpawnList = {}
    self:AsyncSpawnObjectsInternal(TT, uiCustomWidgetName, count, outSpawnList)
    return outSpawnList
  end
end

function UICustomWidgetPool:Engine()
  return self.dynamicInfoOfEngine
end

function UICustomWidgetPool:SpawnObjectsInternal(uiCustomWidgetName, count, outSpawnList)
  if self.uiCustomWidgets == nil then
    Log.fatal("uiCustomWidgets为空：", debug.traceback())
  end
  local haveItemCount = #self.uiCustomWidgets
  local subNum = haveItemCount - count
  for i = 1, -subNum do
    local go = self.dynamicInfoOfEngine:SpawnOneObject(haveItemCount + i - 1)
    if not self:CreateScript(uiCustomWidgetName, go) then
      return
    end
  end
  self:AfterSpawnObjects(count, outSpawnList)
end

function UICustomWidgetPool:AsyncSpawnObjectsInternal(TT, uiCustomWidgetName, count, outSpawnList)
  local haveItemCount = #self.uiCustomWidgets
  local subNum = haveItemCount - count
  for i = 1, -subNum do
    local go = self:AsyncCreateResources(TT, haveItemCount + i - 1)
    if not self:CreateScript(uiCustomWidgetName, go) then
      return
    end
  end
  self:AfterSpawnObjects(count, outSpawnList)
end

function UICustomWidgetPool:CreateUICustomWidget(uiCustomWidgetName)
  local uiCustomWidget = _createInstance(uiCustomWidgetName)
  if not uiCustomWidget then
    Log.fatal("[UI] UICustomWidgetPool:CreateUICustomWidget Error, No UICustomWidget of name = ", uiCustomWidgetName)
  else
    if not uiCustomWidget:IsChildOf("UICustomWidget") then
      Log.fatal("[UI] UICustomWidgetPool:CreateUICustomWidget Fail, ", uiCustomWidgetName, " is not inherited from UICustomWidget!")
      return
    end
    uiCustomWidget:SetName(uiCustomWidgetName)
  end
  return uiCustomWidget
end

function UICustomWidgetPool:SurplusSpawnItem(uiCustomWidget, enable)
  uiCustomWidget:Enable(enable)
end

function UICustomWidgetPool:CreateScript(uiCustomWidgetName, go)
  if uiCustomWidgetName then
    local uiCustomWidget = self:CreateUICustomWidget(uiCustomWidgetName)
    if not uiCustomWidget then
      Log.fatal("[UI] UICustomWidgetPool:CreateScript Error, ", uiCustomWidgetName)
      return
    end
    local view = go:GetComponent("UIView")
    if not view then
      Log.fatal("[UI] UICustomWidgetPool:CreateScript Error, View is Null ", uiCustomWidgetName)
      return
    end
    uiCustomWidget:Load(view, self.parent)
    self.uiCustomWidgets[#self.uiCustomWidgets + 1] = uiCustomWidget
    return uiCustomWidget
  end
end

function UICustomWidgetPool:AsyncCreateResources(TT, name)
  local req
  if self.dynamicInfoOfEngine.selectType == UISelectObjectPath.SelectType.selectByPath then
    req = ResourceManager:GetInstance():AsyncLoadAsset(TT, self.dynamicInfoOfEngine.m_ObjectName, LoadType.GameObject)
  end
  return self.dynamicInfoOfEngine:CallAfterLoad(name, req)
end

function UICustomWidgetPool:AfterSpawnObjects(count, outSpawnList)
  local uiCustomWidgets = self.uiCustomWidgets
  for i = 1, #uiCustomWidgets do
    local uiCustomWidget = uiCustomWidgets[i]
    if i <= count then
      outSpawnList[#outSpawnList + 1] = uiCustomWidget
      uiCustomWidget:Enable(true)
    else
      uiCustomWidget:Enable(false)
    end
  end
end

function UICustomWidgetPool:SpawnObjectFromPool()
  for i = 1, #self.uiCustomWidgets do
    local uiCustomWidget = self.uiCustomWidgets[i]
    uiCustomWidget:Enable(i == 1)
  end
  if #self.uiCustomWidgets > 0 then
    return self.uiCustomWidgets[1]
  end
end
