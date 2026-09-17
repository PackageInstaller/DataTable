local this = class("topBarManager", G_EventManagerBase)
local uiTopBarTpl = L_GameTpl:getUiTopBarTpl()
local topBarResPath = "UI/CommonPrefabs/commonTopBar.prefab"
local topBarNodePath = "UI/CommonPrefabs/commonTopBarNode.prefab"
local topBarMoudlePath = "ui.pages.common.modules.commonTopBar"

function this:getCurrentPageName()
  local curPage = L_UI:currentPage(L_UI.groupKeys.stack)
  return curPage
end

function this:playOpen(pageName)
  if self.curPageName == pageName then
    return
  end
  local options = self:getTopBarConfigData(pageName)
  if not options then
    return
  end
  local page = L_UI:getPage(pageName)
  if not page or not L_CommonUtil.isValid(page.gameObject) then
    return
  end
  self.curPageName = pageName
  self:setTopBar(options)
  self.topBarTrans:SetParent(page.gameObject.transform)
  self.topBarTrans.localScale = C_Vector3.one
  if page.canvas then
    self.topBarSortingOrderFromCanvas.parentCanvas = page.canvas
    self.topBarSortingOrderFromCanvas.additionalOrderOffset = 9
  end
  if self.topBarModule ~= nil then
    self.topBarModule:playOpen()
    if self.cachePageTopBarVisibleInfo and self.cachePageTopBarVisibleInfo[pageName] ~= nil then
      local visible = self.cachePageTopBarVisibleInfo[pageName]
      self:setTopBarVisible(visible)
    end
  end
  if page.cls and page.cls.refreshTopBar ~= nil then
    page.cls:refreshTopBar()
  end
end

function this:onPagePreOpen(p)
  local pageName = self:getCurrentPageName()
  if not pageName then
    return
  end
  self.isShow = false
  self:playOpen(pageName)
end

function this:onPageShow()
  if self.isShow then
    return
  end
  self.isShow = true
  local pageName = self:getCurrentPageName()
  if not pageName then
    return
  end
  self:playOpen(pageName)
end

function this:onPageHide()
  if self.isShow then
    self.isShow = false
  end
end

function this:onPageClosed(pageName)
  if self.curPageName == pageName then
    self.curPageName = nil
    self.topBarTrans:SetParent(self.rootTrans)
    self.topBarModule:playClose()
  end
  self:disposeTimer()
  self.closeTimer = Timer.once(self.closeTime, function()
    self:onPagePreOpen()
    self.closeTimer = nil
  end, self)
end

function this:disposeTimer()
  if self.closeTimer ~= nil then
    Timer.remove(self.closeTimer)
    self.closeTimer = nil
  end
end

function this:initialize()
  self.closeTime = 0.12
  self.curRoot = nil
  local root = L_ResPool:syncGameObject(topBarNodePath, L_UI:getRoot())
  root.name = "[CommonTopBarNode]"
  self.rootTrans = root.transform
  self.topBar = L_ResPool:syncGameObject(topBarResPath, self.rootTrans)
  self.topBar.name = "commonTopBar"
  self.topBarTrans = self.topBar.transform
  self.topBarSortingOrderFromCanvas = self.topBar:GetComponent(typeof(C_SortingOrderFromCanvas))
  self.topBarModule = require(topBarMoudlePath).new(G_UIModuleBase.ModuleType.Dynamic)
  self.topBarModule:created()
  self.topBarModule:toBind(self.topBar:GetComponent(typeof(C_UIBinding)))
  L_UI:addListener(L_UI.pageEvent.preOpen, self.onPagePreOpen, self)
  L_UI:addListener(L_UI.pageEvent.showed, self.onPageShow, self)
  L_UI:addListener(L_UI.pageEvent.closed, self.onPageClosed, self)
  L_UI:addListener(L_UI.pageEvent.hided, self.onPageHide, self)
end

function this:dispose()
  L_UI:removeListener(L_UI.pageEvent.preOpen, self.onPagePreOpen, self)
  L_UI:removeListener(L_UI.pageEvent.showed, self.onPageShow, self)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onPageClosed, self)
  L_UI:removeListener(L_UI.pageEvent.hided, self.onPageHide, self)
  self:disposeTimer()
  if self.topBarModule then
    self.topBarModule:_ensureUnbind()
    self.topBarModule:_dispose()
    self.topBarModule = nil
  end
  if self.rootTrans ~= nil and L_CommonUtil.isValid(self.rootTrans.gameObject) then
    C_BoundGameObject.Destroy(self.rootTrans.gameObject)
  end
  self.topBar = nil
  self.topBarModule = nil
  self.closeTime = nil
end

function this:getTopBarConfigData(pageName)
  if pageName == "pageShop" then
    local page = L_UI:getPage(pageName)
    if not page then
      return nil
    end
    local shopTpl = L_GameTpl:getShopTpl()
    return {
      closeBtnShow = false,
      pageName = page.pageName,
      resource = shopTpl:getResourceBar(shopTpl:getTplById(page.data.curShopId))
    }
  end
  local tpl = uiTopBarTpl:getTplByPageName(pageName)
  if not tpl then
    return nil
  end
  local data = {
    backName = uiTopBarTpl:getBackTxt(tpl),
    closeBtnShow = uiTopBarTpl:getCloseButton(tpl),
    helpBtnShow = uiTopBarTpl:getHelpButton(tpl),
    mainBtnShow = uiTopBarTpl:getNavigationButton(tpl),
    pageName = pageName,
    introId = uiTopBarTpl:getIntroductionGroupId(tpl),
    resource = uiTopBarTpl:getResourceBar(tpl)
  }
  return data
end

function this:getCloseAniamtionTime()
  return self.closeTime or 0
end

function this:setTopBar(data)
  if self.topBarModule ~= nil and data ~= nil then
    self.topBarModule:initModule(data)
  end
end

function this:setResourcesBySystemId(systemId)
  local tpl_sys
  if systemId ~= nil then
    tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(systemId)
  end
  if self.topBarModule ~= nil then
    self.topBarModule:refreshTopBarResources(tpl_sys)
  end
end

function this:setResourcesByResList(resList)
  if self.topBarModule ~= nil then
    self.topBarModule:setResources(resList)
  end
end

function this:setResourceVisible(isShow)
  if self.topBarModule ~= nil then
    self.topBarModule:setResourceVisible(isShow)
  end
end

function this:setTopBarBackName(txtName)
  if self.topBarModule ~= nil then
    self.topBarModule:setBackName(txtName)
  end
end

function this:setTopBarReturnBtnVisible(isShow)
  if self.topBarModule ~= nil then
    self.topBarModule:setReturnBtnVisible(isShow)
  end
end

function this:setTopBarHelpBtnVisible(isShow)
  if self.topBarModule ~= nil then
    self.topBarModule:setHelpBtnVisible(isShow)
  end
end

function this:setTopBarMainBtnVisible(isShow)
  if self.topBarModule ~= nil then
    self.topBarModule:setMainBtnVisible(isShow)
  end
end

function this:setTopBarCloseFunc(closeFunc)
  if self.topBarModule ~= nil then
    self.topBarModule:setCloseFunc(closeFunc)
  end
end

function this:setTopBarHelpBtnFunc(helpBtnFunc)
  if self.topBarModule ~= nil then
    self.topBarModule:setHelpBtnFunc(helpBtnFunc)
  end
end

function this:setTopBarMainBtnFunc(mainBtnFunc)
  if self.topBarModule ~= nil then
    self.topBarModule:setMainBtnFunc(mainBtnFunc)
  end
end

function this:setTopBarVisible(isShow)
  if self.topBarModule ~= nil then
    self.topBarModule:setVisible(isShow)
  end
end

function this:setTopBarVisibleByPageName(pageName, visible)
  if self.cachePageTopBarVisibleInfo == nil then
    self.cachePageTopBarVisibleInfo = {}
  end
  self.cachePageTopBarVisibleInfo[pageName] = visible
  self:setTopBarVisible(visible)
end

function this:setTopBarCanvasSortOrder(sortOrder)
  if self.topBarModule ~= nil then
    self.topBarModule:setCanvasSortOrder(sortOrder)
  end
end

function this:resetBarPos()
  if self.topBarModule ~= nil then
    self.topBarModule:resetModulePos()
  end
end

return this
