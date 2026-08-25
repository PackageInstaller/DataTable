local MaterialIconMgr, Super = NewClass("MaterialIconMgr", Manager)
local ItemType = CommonDefine.ItemType
local IconCommonPath = "UI/UI_Icon/Icon_Common.prefab"
local IconAlchemyPath = "UI/UI_Common/UI_Common_Prefab/UI_Common_Item_WuPin_Type1.prefab"
local SocialRelationListItemPath = "UI/UI_Social/UI_Social_Prefab/UI_Social_Panel_Main_Item.prefab"
local IconMonsterPath = "UI/UI_Chapter/UI_Chapter_Prefab/UI_Chapter_Item_Monster.prefab"
local TempArray
local DelayClearTime = 10

function MaterialIconMgr:ctor()
  Super.ctor(self)
end

function MaterialIconMgr:Awake()
  Super.Awake(self)
  local uiRoot = UIRootMgr.GetUIRoot()
  local iconsRoot = CS.UnityEngine.GameObject("MaterialIconMgr")
  iconsRoot:SetActive(false)
  self.iconsRootTf = iconsRoot:AddComponent(typeof(CS.UnityEngine.RectTransform))
  self.iconsRootTf:SetParent(uiRoot.transform, false)
  self.iconCons = {}
  self.allCons = {}
  self.proxyPool = {}
  self.proxyTime = {}
  self.unusedPool = {}
  self.iconGameObjectsPool = {}
  self:_OnRegisterAgent()
end

function MaterialIconMgr:_OnRegisterAgent()
  self:_RegisterIconAgent(MaterialIconType.CommonIcon, IconCommonPath, CommonIcon)
  self:_RegisterIconAgent(MaterialIconType.CommonIcon_Obsolete, IconCommonPath, CommonIconObsolete)
  self:_RegisterIconAgent(MaterialIconType.AlchemyIcon, IconAlchemyPath, AlchemyIconBase)
  self:_RegisterIconAgent(MaterialIconType.SocialRelationListItem, SocialRelationListItemPath, SocialRelationListItem)
  self:_RegisterIconAgent(MaterialIconType.CommonMonster, IconMonsterPath, CommonMonster)
end

function MaterialIconMgr:OnDestroy()
  Super.OnDestroy(self)
end

function MaterialIconMgr:CreateMaterialIconProxy(iconType, parentNode, tid, onlyOne)
  if IsNil(parentNode) then
    Logger.Error(">>>>>>>>MaterialIconMgr.SetIcon图标挂载需要一个父节点")
    return
  end
  local iconCls = self:_GetIconCls(iconType)
  if not iconCls then
    Logger.Error(">>>>>>>>MaterialIconMgr.SetIcon 无法找到代理类，ID=", tid)
    return
  end
  if nil == onlyOne then
    onlyOne = true
  end
  local proxy
  if onlyOne then
    local allProxys = self:GetAllChildrenProxys(parentNode)
    local isExited = false
    for _, p in ipairs(allProxys) do
      if not proxy and p.iconCls.__name == iconCls.__name then
        proxy = p
      else
        self:ResetPorxy(p)
      end
    end
  end
  if not proxy then
    local prefabPath = self:_GetIconPrefabPath(iconType)
    proxy = self:_CreateProxy(prefabPath, iconCls)
  end
  return proxy
end

function MaterialIconMgr:SetIcon(iconType, view, parentNode, data, onlyOne)
  local proxy = self:CreateMaterialIconProxy(iconType, parentNode, data.tid, onlyOne)
  if proxy then
    proxy:SetActive(true)
    proxy:SetParent(parentNode)
    proxy:SetView(view)
    proxy:SetData(data)
    proxy:OnActive()
  end
  return proxy
end

function MaterialIconMgr:SetIcon_Obsolete(iconType, binder, parentNode, data, onlyOne)
  local proxy = self:CreateMaterialIconProxy(iconType, parentNode, data.tid, onlyOne)
  if proxy then
    proxy:SetActive(true)
    proxy:SetParent(parentNode)
    proxy:SetBinder(binder)
    proxy:SetData(data)
    proxy:OnActive()
  end
  return proxy
end

function MaterialIconMgr:ResetAll(parent)
  if IsNil(parent) then
    return
  end
  local trs = parent.transform
  if nil ~= trs and trs.childCount > 0 then
    local count = trs.childCount
    for i = count, 1, -1 do
      local child = trs:GetChild(i - 1)
      self:TryReset(child.gameObject)
    end
  end
end

function MaterialIconMgr:TryReset(go)
  if IsNil(go) then
    return
  end
  local flag = GetLuaComp(go, MaterialIconFlag)
  if nil ~= flag then
    self:ResetPorxy(flag.proxy)
  end
end

function MaterialIconMgr:ResetPorxy(proxy)
  if not proxy.isActive then
    return
  end
  local go = proxy.gameObject
  if IsNil(go) then
    return
  end
  go.transform:SetParent(self.iconsRootTf)
  SetScaledActive(go, false)
  proxy:SetActive(false)
  proxy:ResetTransform()
  proxy:OnDeative()
  local key = proxy.iconCls.__name
  self.proxyPool[key] = self.proxyPool[key] or {}
  table.insert(self.proxyPool[key], proxy)
end

function MaterialIconMgr:LoadProxyIcon(proxy)
  local prefabPath = proxy.prefabPath
  if not prefabPath then
    return
  end
  self.unusedPool[prefabPath] = nil
  local goPool = self.iconGameObjectsPool[prefabPath] or GameObjectPool(prefabPath)
  goPool.useInstancedQueue = true
  self.iconGameObjectsPool[prefabPath] = goPool
  goPool:LoadResource(function()
    if proxy.gameObject then
      proxy:SetGameObject(goPool:FetchGameObject())
    end
  end)
end

function MaterialIconMgr:UnloadProxyIcon(proxy)
  local prefabPath = proxy.prefabPath
  local iconGameObject = proxy.iconGameObject
  if not prefabPath or not iconGameObject then
    return
  end
  iconGameObject.transform:SetParent(self.iconsRootTf, false)
  local goPool = self.iconGameObjectsPool[prefabPath]
  goPool:ReturnGameObject(iconGameObject)
  proxy.prefabPath = nil
  proxy.iconGameObject = nil
  if 0 == goPool:RefCount() then
    self.unusedPool[prefabPath] = UnityTime.time
  else
    self.unusedPool[prefabPath] = nil
  end
end

function MaterialIconMgr:GetProxy(container)
  if nil ~= container then
    local gameObject = container.gameObject
    local flag = GetLuaComp(gameObject, MaterialIconFlag)
    if nil ~= flag then
      return flag.proxy
    end
  end
  return nil
end

function MaterialIconMgr:LateUpdate()
  local time = UnityTime.time
  TempArray = TempArray or {}
  table.clear(TempArray)
  if self.proxyPool then
    for k, v in pairs(self.proxyPool) do
      table.mergeWithoutGc(TempArray, v)
      for i = 1, #TempArray do
        if 0 ~= TempArray[i].deactiveTime and time >= TempArray[i].deactiveTime + DelayClearTime then
          TempArray[i]:Dispose()
          table.removeByValue(self.proxyPool[k], TempArray[i])
        end
      end
    end
  end
  table.clear(TempArray)
  for k, v in pairs(self.unusedPool) do
    if time >= v + DelayClearTime then
      table.insert(TempArray, k)
    end
  end
  for i = 1, #TempArray do
    local prefabPath = TempArray[i]
    local goPool = self.iconGameObjectsPool[prefabPath]
    self.iconGameObjectsPool[prefabPath] = nil
    self.unusedPool[prefabPath] = nil
    goPool:UnloadResource()
  end
end

function MaterialIconMgr:GetAllChildrenProxys(parent)
  TempArray = TempArray or {}
  table.clear(TempArray)
  if IsNil(parent) then
    return TempArray
  end
  local trs = parent.transform
  if trs.childCount > 0 then
    local count = trs.childCount
    for i = count, 1, -1 do
      local child = trs:GetChild(i - 1)
      local proxy = self:GetProxy(child)
      if proxy then
        table.insert(TempArray, proxy)
      end
    end
  end
  return TempArray
end

function MaterialIconMgr:_CreateProxy(prefabPath, iconCls)
  local proxy
  local proxyPool = self.proxyPool[iconCls.__name]
  if proxyPool and #proxyPool > 0 then
    proxy = table.remove(proxyPool, #proxyPool)
  end
  self.proxyTime[iconCls.__name] = nil
  if nil == proxy then
    proxy = MaterialIconProxy(iconCls)
    proxy:LoadIcon(prefabPath)
  end
  return proxy
end

function MaterialIconMgr:_RegisterIconAgent(iconType, prefabPath, cls)
  local key = self:_GetKey(iconType)
  self.iconCons[key] = {prefabPath = prefabPath, iconCls = cls}
  self.allCons[iconType] = true
end

function MaterialIconMgr:_GetKey(iconType)
  local key = iconType
  return key
end

function MaterialIconMgr:_GetIconCls(iconType)
  local key = self:_GetKey(iconType)
  local obj = self.iconCons[key]
  local cls
  if nil ~= obj then
    return obj.iconCls
  end
  key = self:_GetKey(iconType, 0)
  obj = self.iconCons[key]
  if nil ~= obj then
    return obj.iconCls
  end
  return CommonIcon
end

function MaterialIconMgr:_GetIconPrefabPath(iconType)
  local key = self:_GetKey(iconType)
  local obj = self.iconCons[key]
  local cls
  if nil ~= obj then
    return obj.prefabPath
  end
  key = self:_GetKey(iconType, 0)
  obj = self.iconCons[key]
  if nil ~= obj then
    return obj.prefabPath
  end
  return IconCommonPath
end

return MaterialIconMgr
