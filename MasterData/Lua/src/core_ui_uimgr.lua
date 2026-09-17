G_UIBase = require("core.ui.base.uiBase")
G_UIPageBase = require("core.ui.base.pageBase")
G_UIModuleBase = require("core.ui.base.moduleBase")
G_UIPartBase = require("core.ui.base.partBase")
G_EventManagerBase = require("core.ui.base.eventManagerBase")
C_UIMgr = C_UIMgr or CS.Azur.Gameplay.UI.UIManager
local this = class("uiMgr", G_EventManagerBase)
require("core.ui.uiAdapter")
this.pageEvent = {
  reqOpen = "reqOpen",
  reqClose = "reqClose",
  preOpen = "preOpen",
  opened = "opened",
  closed = "closed",
  hided = "hided",
  showed = "showed",
  firstOpen = "firstOpen"
}
this.groupKeys = {stack = "stack", freedom = "freedom"}
this.pageStatus = {
  shown = "shown",
  hided = "hided",
  opening = "opening",
  closed = "closed"
}
local csToLuaEvent = {
  [1] = this.pageEvent.reqOpen,
  [2] = this.pageEvent.reqClose,
  [3] = this.pageEvent.preOpen,
  [4] = this.pageEvent.opened,
  [5] = this.pageEvent.closed,
  [6] = this.pageEvent.hided,
  [7] = this.pageEvent.showed,
  [8] = this.pageEvent.firstOpen
}

function this:ctor()
  this.super.ctor(self)
  self._auxiliaries = {}
  self._uiConfig = {}
  self._updateHandlers = {}
end

function this:initialize()
  self._uiConfig = C_UIMgr.GetUIConfigData()
  self:_initAuxiliary()
  local mask = C_UIMgr.recorder.mask
  self._tmpTopGuideMask = CS.UnityEngine.Object.Instantiate(mask, self:getRoot())
  self._tmpTopGuideMask.name = "[TempTopGuideMask]"
end

function this:createModule(name)
  local config = C_UIMgr.luaMiddleware:GetSubModuleConfig(name)
  local module = require(config.scriptPath).new()
  module.moduleName = name
  module.cls = module
  module.config = config
  return module
end

function this:createPage(name, path)
  local page = require(path).new()
  page.pageName = name
  page.cls = page
  page.config = C_UIMgr.GetPageConfig(name)
  return page
end

function this:sendEvent(eventId, pageName)
  local eve = csToLuaEvent[eventId]
  this.super.sendEvent(self, eve, pageName)
end

function this:_initAuxiliary()
  for i = 0, self._uiConfig.auxiliary.Count - 1 do
    local value = self._uiConfig.auxiliary[i]
    local aux = {}
    aux.config = value
    local cls = require(value.luaPath).new()
    aux.cls = cls
    aux.auxiliaryName = value.auxiliaryName
    if cls.initialize then
      cls:initialize(value)
    end
    self._auxiliaries[value.auxiliaryName] = aux
  end
end

function this:initGameplay()
  for _, v in pairs(self._auxiliaries) do
    if v and type(v.cls.initGameplayEvents) == "function" then
      v.cls:initGameplayEvents()
    end
  end
  C_UIMgr.uiListenerMiddleware:InitGamePlayEvents()
end

function this:getRoot()
  return C_UIMgr.root
end

function this:getCanvasScaler()
  return C_UIMgr.recorder.canvasScaler
end

function this:getRefResolution()
  local scaler = self:getCanvasScaler()
  return scaler.referenceResolution
end

function this:setRefResolution(v2)
  local scaler = self:getCanvasScaler()
  scaler.referenceResolution = v2
end

function this:open(pageName, options, callback, ignoreQueueCheck)
  if pageName == nil then
    errorf("pageName is nil")
    return
  end
  local pageConfig = C_UIMgr.GetPageConfig(pageName)
  if pageConfig == nil then
    errorf("don't has this pageName: " .. pageName)
    return
  end
  options = self:getOptions(options)
  if ignoreQueueCheck == nil then
    ignoreQueueCheck = false
  end
  C_UIMgr.Open(pageName, options, callback, ignoreQueueCheck)
end

function this:close(pageName, options, callback)
  if pageName == nil or pageName == "" then
    errorf("uimgr close pagename is null or empty")
    return
  end
  options = self:getOptions(options)
  C_UIMgr.Close(pageName, options, callback)
end

function this:middleware()
end

function this:show(pageName)
  C_UIMgr.ShowOrHide(pageName, true)
end

function this:hide(pageName)
  C_UIMgr.ShowOrHide(pageName, false)
end

function this:openRoot(pageName, options, callback, exclusion)
  if exclusion ~= nil then
    C_UIMgr.Lua_BackAllWithExclusion(exclusion)
  else
    C_UIMgr.BackAll()
  end
  if pageName ~= nil then
    self:open(pageName, options, callback)
  end
end

function this:getOptions(options)
  local op
  if options ~= nil then
    op = C_UIMgr.luaMiddleware:GetLuaOptions(options)
    if options.mode == "replace" then
      op.mode = 4
    elseif options.mode == "replaceSwiftly" then
      op.mode = 4
      op.transition = 1
    end
  end
  return op
end

function this:backToRoot(callback)
  C_UIMgr.BackToRoot(callback)
end

function this:backToPage(pageName, options)
  local op = self:getOptions(options)
  C_UIMgr.BackToPage(pageName, op)
end

function this:getAllPages(group)
  local tab = {}
  local index = group == this.groupKeys.stack and 0 or 1
  local list = C_UIMgr.GetAllPages(index)
  for i = 0, list.Count - 1 do
    local page = list[i]
    tab[page.name] = self:wrapPage(page)
  end
  return tab
end

function this:getPage(pageName)
  local page = C_UIMgr.GetPage(pageName)
  page = self:wrapPage(page)
  return page
end

local csPageBindMeta = {
  __index = function(t, k)
    local csPage = t.cls
    if k == "status" then
      return C_UIMgr.luaMiddleware:GetPageLuaStatus(csPage)
    else
      return csPage[k]
    end
  end,
  __newindex = function(t, k, v)
    t.cls[k] = v
  end
}

function this:wrapPage(page)
  if page == nil then
    return
  end
  if page.scriptObject then
    return page.scriptObject
  else
    local csPage = setmetatable({
      cls = page,
      pageName = page.name,
      graphicRaycaster = page.raycaster
    }, csPageBindMeta)
    return csPage
  end
end

function this:currentPage(group)
  local index = group == this.groupKeys.stack and 0 or 1
  local top = C_UIMgr.GetTopPage(index)
  return top and top.name
end

function this:stackRootPage()
  local root = C_UIMgr.GetRootPage(0)
  return root and root.name
end

function this:checkPageOpen(pageName)
  if string.isEmpty(pageName) then
    return false
  end
  local result = C_UIMgr.IsPageShowed(pageName)
  return result
end

function this:checkPageShown(pageName, ignoreAnim)
  local page = self:getPage(pageName)
  if not page then
    return false
  end
  return self:getPageStatus(pageName) == this.pageStatus.shown and (ignoreAnim or not page.animating)
end

function this:checkPageHided(pageName, ignoreAnim)
  local page = self:getPage(pageName)
  if not page then
    return false
  end
  return self:getPageStatus(pageName) == this.pageStatus.hided and (ignoreAnim or not page.animating)
end

function this:getPageBlendDefinition(page)
  if not page then
    return nil
  end
  if page.cls.blendDefinition then
    return page.cls.blendDefinition
  end
  return C_UIMgr.luaMiddleware:GetPageLuaBlendDefinition(page.cls)
end

function this:checkPagePlayingAnim(page)
  if not page then
    return false
  end
  local blendDefinition = self:getPageBlendDefinition(page)
  if not L_CommonUtil.isValid(blendDefinition) then
    return false
  end
  if not L_CommonUtil.isValid(blendDefinition.m_openStyle.animation) then
    return false
  end
  local isAniPlaying = blendDefinition.m_openStyle.animation.isPlaying
  if isAniPlaying then
    local it = blendDefinition.m_openStyle.animation:GetEnumerator()
    while it:MoveNext() do
      local st = it.Current
      if string.find(string.lower(st.name), "loop") then
        isAniPlaying = st.weight == 0
      end
    end
  end
  return isAniPlaying
end

function this:getPageStatus(pageName)
  local page = self:getPage(pageName)
  return page and page.status
end

function this:setTempTopMaskVisible(visible)
  self:setGlobleMask("temp", visible)
end

function this:setGlobleMask(key, visible)
  C_MJLog.LogInfo("setGlobleMask：" .. tostring(key) .. ":" .. tostring(visible), C_ELogModule.Guide)
  C_UIMgr.SetGloableMaskEnable(key, visible)
end

function this:setTempTopGuideMask(visible)
  if self._tmpTopGuideMask then
    self._tmpTopGuideMask:SetActive(visible)
  end
end

function this:update()
  for i, v in pairs(self._auxiliaries) do
    local cls = v.cls
    if cls and cls.update then
      cls:update()
    end
  end
  for _, v in pairs(self._updateHandlers) do
    v.handler(v.scriptObject)
  end
end

function this:getPageConfig(pageName)
  return C_UIMgr.GetPageConfig(pageName)
end

function this:getPageIsControlMove(pageName)
  local config = C_UIMgr.GetPageConfig(pageName)
  if config then
    return config.control.controlMove
  end
  return false
end

function this:addPageUpdateHandler(instanceId, scriptObject, handler)
  self._updateHandlers = self._updateHandlers or {}
  if self._updateHandlers[instanceId] then
    errorf("update handler already exists: " .. instanceId)
  end
  self._updateHandlers[instanceId] = {scriptObject = scriptObject, handler = handler}
end

function this:removePageUpdateHandler(instanceId)
  if self._updateHandlers then
    self._updateHandlers[instanceId] = nil
  end
end

return this
