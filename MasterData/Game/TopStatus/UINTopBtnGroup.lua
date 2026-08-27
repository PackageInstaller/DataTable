local UINTopBtnGroup = class("UINTopBtnGroup", UIBaseNode)
local base = UIBaseNode

function UINTopBtnGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.__OnBtnBackClick)
  if self.ui.btn_OpenNavigation ~= nil then
    UIUtil.AddButtonListener(self.ui.btn_OpenNavigation, self, self.__OnBtnpenNavigationClick)
    self:RefreshouldShowNaviBtn(true)
  end
  if self.ui.btn_GoHome ~= nil then
    UIUtil.AddButtonListener(self.ui.btn_GoHome, self, self.__OnBtnHomeClick)
    self.ui.btn_GoHome.gameObject:SetActive(false)
  end
  self._showGoHomeBtn = true
  if self.ui.btn_Info ~= nil then
    UIUtil.AddButtonListener(self.ui.btn_Info, self, self.__OnBtnInfoClick)
    self.ui.btn_Info.gameObject:SetActive(false)
  end
  self.__ReddotNodeUpdate = BindCallback(self, self.ReddotNodeUpdate)
  self.ui.btn_Back.gameObject:SetActive(false)
  self:__TryInitBtnHomeRedDot()
end

function UINTopBtnGroup:RefreshTopGroupUI(topData)
  local currentTopData = UIUtil.PeekBackStack()
  if currentTopData ~= nil then
    topData = currentTopData
  end
  local active = self.__onBackClick ~= nil or topData.backAction ~= nil
  self.ui.btn_Back.gameObject:SetActive(active)
  self.topData = topData
  self.ui.btn_GoHome.gameObject:SetActive(active and self._showGoHomeBtn and not topData.topBtnOnlyReturn)
  self._goHomeBtnActive = active
  self.ui.btn_OpenNavigation.gameObject:SetActive(active and self._showNaviBtn and not topData.topBtnOnlyReturn)
  self.ui.btn_Info.gameObject:SetActive(topData.infoAction ~= nil and not topData.topBtnOnlyReturn)
end

function UINTopBtnGroup:GetShowTopBtnGroupGoHomeBtn()
  return self._showGoHomeBtn
end

function UINTopBtnGroup:ShowTopBtnGroupGoHomeBtn(show)
  self._showGoHomeBtn = show
  self.ui.btn_GoHome.gameObject:SetActive(self._goHomeBtnActive and self._showGoHomeBtn)
end

function UINTopBtnGroup:GetShowNaviBtn()
  return self._showNaviBtn
end

function UINTopBtnGroup:RefreshouldShowNaviBtn(show)
  local couldShow = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_QuickJump)
  self._showNaviBtn = couldShow and show
  self.ui.btn_OpenNavigation.gameObject:SetActive(self._goHomeBtnActive and self._showNaviBtn)
end

function UINTopBtnGroup:SetUITopStatusBtnShow(showHome, showNav)
  self.ui.btn_GoHome.gameObject:SetActive(self._goHomeBtnActive and self._showGoHomeBtn and showHome)
  self.ui.btn_OpenNavigation.gameObject:SetActive(self._goHomeBtnActive and self._showNaviBtn and showNav)
end

function UINTopBtnGroup:SetBeforeBackCloseNavigation(closeNavigationAction)
  self.__closeNavigationAction = closeNavigationAction
end

function UINTopBtnGroup:SetBackClickAction(onBackClick)
  self.__onBackClick = onBackClick
end

function UINTopBtnGroup:__OnBtnBackClick()
  if self.__closeNavigationAction ~= nil and self.__closeNavigationAction() then
    return
  end
  if self.__onBackClick ~= nil then
    local backFunc = self.__onBackClick
    backFunc()
    self.__onBackClick = nil
  else
    UIUtil.OnClickBackByUiTab(self.topData.uiTab)
  end
end

function UINTopBtnGroup:SetBtnHomeClickAction(onHomeClick)
  self.__onHomeClick = onHomeClick
end

function UINTopBtnGroup:__OnBtnHomeClick()
  if self.__ReturnHomeCallback == nil then
    self.__ReturnHomeCallback = BindCallback(self, self.__ReturnHome)
  end
  UIUtil.TryClickReturnHome(self.__ReturnHomeCallback)
end

function UINTopBtnGroup:__ReturnHome()
  if self.__onHomeClick ~= nil then
    self.__onHomeClick()
  else
    UIUtil.ReturnHome()
  end
end

function UINTopBtnGroup:SetBtnOpenNavigationClickAction(onNaviClick)
  self.__onNaviClick = onNaviClick
end

function UINTopBtnGroup:__OnBtnpenNavigationClick()
  if self.__onNaviClick ~= nil then
    self.__onNaviClick()
  end
end

function UINTopBtnGroup:SetInfoClickAction(infoClickAction)
  self.__onInfoClick = infoClickAction
end

function UINTopBtnGroup:__OnBtnInfoClick()
  if self.__onInfoClick ~= nil then
    self.__onInfoClick()
  end
end

function UINTopBtnGroup:SetInfoBtnActive(bool)
  local topData = UIUtil.PeekBackStack()
  if topData == nil then
    self.ui.btn_Info.gameObject:SetActive(false)
    return
  end
  self.ui.btn_Info.gameObject:SetActive(bool and topData.infoAction ~= nil)
end

function UINTopBtnGroup:SetInfoBtnBluedot(bool)
  self.ui.blueDot_info:SetActive(bool)
end

function UINTopBtnGroup:__TryInitBtnHomeRedDot()
  self.redDotNodeDic = {}
  for index, cfg in ipairs(ConfigData.navigation_sub) do
    local redDotPathList = string.split(cfg.red_dot_path, ".")
    if redDotPathList ~= nil and #redDotPathList ~= 0 then
      self:_CheckRedDot(table.unpack(redDotPathList))
    end
  end
  self:_CheckRedDot(RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisBuildResMax)
  self:_CheckRedDot(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
  self:_CheckRedDot(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel)
  self:_CheckRedDot(RedDotStaticTypeId.Main, RedDotStaticTypeId.Mail)
  self:_CheckRedDot(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameSectorI)
  self:RefreshHomeRedDotFx()
end

function UINTopBtnGroup:_CheckRedDot(...)
  local ok, node = RedDotController:GetRedDotNode(...)
  if ok and self.redDotNodeDic[node] == nil then
    RedDotController:AddListener(node.nodePath, self.__ReddotNodeUpdate)
    self.redDotNodeDic[node] = node:GetRedDotCount() > 0
  end
end

function UINTopBtnGroup:ReddotNodeUpdate(node)
  self.redDotNodeDic[node] = node:GetRedDotCount() > 0
  self:RefreshHomeRedDotFx()
end

function UINTopBtnGroup:RefreshHomeRedDotFx()
  local hasRed = false
  for node, bool in pairs(self.redDotNodeDic) do
    if bool then
      hasRed = true
      break
    end
  end
  if UIManager:GetWindow(UIWindowTypeID.NavigationBar) ~= nil and UIManager:GetWindow(UIWindowTypeID.NavigationBar).active then
    self.ui.fX_TopStatus:SetActive(false)
  else
    self.ui.fX_TopStatus:SetActive(hasRed)
  end
end

function UINTopBtnGroup:GetTopBtnBackRectTran()
  return self.ui.btn_Back.transform
end

function UINTopBtnGroup:OnDelete()
  for node, _ in pairs(self.redDotNodeDic) do
    RedDotController:RemoveListener(node.nodePath, self.__ReddotNodeUpdate)
  end
  self.redDotNodeDic = {}
  base.OnDelete(self)
end

return UINTopBtnGroup
