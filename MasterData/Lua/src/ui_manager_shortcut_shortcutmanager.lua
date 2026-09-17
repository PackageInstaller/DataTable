local this = class("shortCutManager", G_EventManagerBase)
local PATH_SHORTKEY = "UI/Pages/ShortCut/partShortKey.prefab"

function this:ctor()
  this.super.ctor(self)
  self.pageShortCutDic = {}
  self.cutTime = 0
  self._shortCutFlagGos = {}
end

function this:initialize()
  C_UIMgr.RegisterEscShortCut()
end

local persistentShortCut = {interactive = true}

function this:dispose()
  C_UIMgr.RemoveEscShortCut()
  for i, v in pairs(self.pageShortCutDic) do
    if not persistentShortCut[i] then
      self:removeShortCut(i)
    end
  end
end

function this:registerPageMainShortCut(curModule)
  if curModule == nil then
    curModule = L_WorldManager:getCurModule()
  end
  if string.isEmpty(curModule) then
    return
  end
  local mainCityPage
  if not C_ProxyDefine.UIRootDic[curModule] then
    mainCityPage = C_ProxyDefine.UIRootDic[L_Const.worldModule.main].PageName
    errorf("(清联系liubin添加玩法枚举) 新增module L_Const.worldData  = " .. tostring(curModule))
  else
    mainCityPage = C_ProxyDefine.UIRootDic[curModule].PageName
  end
  local shortCutData = L_ShortCutConst.mainCityKeyMap[curModule]
  if not shortCutData then
    shortCutData = L_ShortCutConst.mainCityKeyMap[L_Const.worldModule.main]
    errorf("(清联系liubin添加玩法枚举) 新增module L_ShortCutConst.mainCityKeyMap  = " .. tostring(curModule))
  end
  self:registerShortCutMapList(mainCityPage, shortCutData.shortCutList)
  self:registerShortCut(mainCityPage, C_InputManager_KeyType.EMainBack, function()
    if type(shortCutData.menuFunc) == "function" then
      shortCutData.menuFunc()
    end
  end)
end

function this:registerShortCutMapList(pageName, shortCutList)
  for i, v in pairs(shortCutList) do
    self:registerShortCut(pageName, v, L_ShortCutConst.shortCutMap[v], L_ShortCutConst.shortCutMapNeedFlag[v])
  end
end

function this:registerShortCut(pageName, type, func, needFlag)
  if not self.pageShortCutDic[pageName] then
    self.pageShortCutDic[pageName] = {}
  end
  if not self.pageShortCutDic[pageName].shortCutHandle then
    self.pageShortCutDic[pageName].shortCutHandle = {}
  end
  
  local function callback(self, isPress)
    printf("ShortCut", type, isPress)
    if not self:getIsShortCutAllow() then
      return
    end
    if needFlag then
      func(isPress)
    elseif isPress or not C_InputManager.IfRequireKeyIsPressed(type) then
      func()
    end
  end
  
  local handle = self.pageShortCutDic[pageName].shortCutHandle[type]
  if handle then
    C_InputManager.RemoveKeyListener(type, handle)
  end
  handle = handler(self, callback)
  C_InputManager.AddKeyListener(type, handle)
  self.pageShortCutDic[pageName].shortCutHandle[type] = handle
end

function this:unregisterShortCut(pageName, type)
  local dict = self.pageShortCutDic[pageName]
  if dict == nil then
    return
  end
  local handle = dict.shortCutHandle[type]
  if handle then
    C_InputManager.RemoveKeyListener(type, handle)
  end
end

function this:removeShortCut(pageName)
  if self.pageShortCutDic[pageName] then
    local handleList = self.pageShortCutDic[pageName].shortCutHandle
    if not table.isEmpty(handleList) then
      for i, v in pairs(handleList) do
        C_InputManager.RemoveKeyListener(i, v)
      end
    end
    self.pageShortCutDic[pageName] = nil
  end
end

function this:generateShortKey(parent)
  local go = L_ResPool:syncGameObject(PATH_SHORTKEY, parent)
  local part = require("ui.pages.shortCut.partShortKey").new()
  part:created(go)
  return part
end

function this:generateAndCheckShortKey(parent, offset, scale)
  if not L_DeviceTpl:getIsPc() and not L_DeviceTpl:getIsMobile() then
    return
  end
  local part = self:generateShortKey(parent)
  part:refreshTransform(parent, offset, scale)
  return part
end

function this:addShortKeyFlag(obj, key, anchorType, parent, offset, scale)
  if not L_DeviceTpl:getIsPc() and not L_DeviceTpl:getIsMobile() then
    return
  end
  if obj == nil or key == nil then
    printf("ShortCut", "[addShortKeyFlag] obj or key is nil. obj: ", tostring(obj))
    return
  end
  local part = self._shortCutFlagGos[obj] and self._shortCutFlagGos[obj][key] or self:generateShortKey(parent)
  part:refreshTransform(parent, anchorType, offset, scale)
  part:refreshKey(key)
  self._shortCutFlagGos[obj] = self._shortCutFlagGos[obj] or {}
  self._shortCutFlagGos[obj][key] = part
  return part
end

function this:tryAddShortKeyFlag(paramTable)
  local obj = paramTable.obj
  local key = paramTable.key
  local anchorType = L_Const.AnchorType[paramTable.anchorType]
  local parent = paramTable.parent
  local offset = L_Vector3.new(paramTable.x, paramTable.y, paramTable.z)
  local scale = paramTable.scale
  self:addShortKeyFlag(obj, key, anchorType, parent, offset, scale)
end

function this:removeShortKeyFlag(obj, key)
  if self._shortCutFlagGos[obj] and self._shortCutFlagGos[obj][key] then
    self:destroyShortKey(self._shortCutFlagGos[obj][key])
    self._shortCutFlagGos[obj][key] = nil
  end
end

function this:getShortKey(obj, key)
  local part = self._shortCutFlagGos[obj] and self._shortCutFlagGos[obj][key] or nil
  return part and part.gameObject or nil
end

function this:refreshShortKeyTransform(obj, key, anchorType, parent, offset, scale)
  local part = self._shortCutFlagGos[obj] and self._shortCutFlagGos[obj][key] or nil
  if not part then
    return
  end
  part:refreshTransform(parent, anchorType, offset, scale)
end

function this:setShortKeyActive(obj, key, isActive)
  local part = self._shortCutFlagGos[obj] and self._shortCutFlagGos[obj][key] or nil
  if not part then
    return
  end
  part._explicitActive = isActive
  part.gameObject:SetActive(isActive)
end

function this:destroyShortKey(partShortKey)
  local go = partShortKey.gameObject
  partShortKey:destroy()
  C_BoundGameObject.Destroy(go)
end

function this:clearShortKeyFlag(obj)
  if not self._shortCutFlagGos[obj] then
    return
  end
  for _, part in pairs(self._shortCutFlagGos[obj]) do
    self:destroyShortKey(part)
  end
  self._shortCutFlagGos[obj] = nil
end

function this:getIsShortCutEscAllow()
  if L_LoadingManager:isLoading() or self:isWaitingNetOption() then
    return false
  end
  return true
end

function this:getIsShortCutAllow()
  if L_LoadingManager:isLoading() or self:isWaitingNetOption() then
    return false
  end
  return true
end

function this:showShortCut(id, idAdd)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuideEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    tdId = id,
    isAdd = idAdd,
    isGray = false
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcChange, args)
end

function this:isWaitingNetOption()
  local st = L_UI:getPageStatus("pageNetworkWaiting")
  if st and st ~= "closed" then
    return true
  end
  local st = L_UI:getPageStatus("pageNetCommonTip")
  if st and st ~= "closed" then
    return true
  end
  return false
end

return this
