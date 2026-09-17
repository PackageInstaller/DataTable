local this = class("pageMainMenu", G_UIPageBase)
local _unitTpl = L_GameTpl:getUnitTpl()
local _mainBottomButtonsTpl = L_GameTpl:getMainBottomButtonsTpl()
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _playerLevelTpl = L_GameTpl:getPlayerLevelTpl()
local connect_power = L_GameConstTpl:getData("CONNECT_POWER", L_Const.GameTplType.int)
local MAIN_MENU_BG_PREFS_KEY = "MainMenuBg_CurrentTab"
local _listIntType = CS.System.Collections.Generic.List(CS.System.Int32)

function this.bind()
  return {
    module_currency = {
      moduleName = "modulePages/moduleCurrency"
    },
    module_banner = {
      moduleName = "pages/main/moduleActivityBanner"
    },
    txt_shop_lock_name = "",
    txt_shop_unlock_name = "",
    btn_close = true,
    btn_closeOn = false,
    module_currency_go = true,
    gruop_botomBtn = true,
    group_rightBtn = true,
    btn_back = false,
    btn_more = true,
    btn_changeBg = true,
    group_expend = false,
    bottomList = {
      moduleName = "pages/main/cellMainMenuButton"
    },
    bottomMoreList = {
      moduleName = "pages/main/cellMainMenuButton"
    },
    active_startLevBtn = false,
    active_startHelp = false,
    active_startLev = false,
    txt_startLev = "",
    txt_startName = "",
    txt_helpDesc = "",
    fill_exp = 1
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self:closePage()
    end,
    onClick_exit = function(self)
      L_GameUtil.showCommonTip({
        txtTitle = L_WordsTpl:getValue("title_notice_login_exit"),
        txtContent = L_WordsTpl:getValue("notice_login_exit"),
        confirmCallback = function()
          C_LoginManager.ExitGame()
        end
      })
    end,
    onClick_photograph = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.photo)
    end,
    onClick_playerCard = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.playerCard)
    end,
    onClick_gacha = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.gacha)
    end,
    onClick_announcement = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.announcemenet)
    end,
    onClick_option = function(self)
      L_UI:open("pageOption")
    end,
    onClick_shop = function(self)
      local isOpenShop = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.MallControlSwitch)
      if not isOpenShop then
        C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.MallControlSwitch)
        return
      end
      L_UI:open("PageShopUI")
    end,
    onClick_adventure = function(self)
      L_UI:open("pageBigMap")
    end,
    onClick_mail = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.mail)
    end,
    onClick_more = function(self)
      self.isExpend = true
      self.bindComponents.more_animation:Play("anim_mainmenu_more_open")
      L_AudioUtil.playSound("Play_SFX_System_UI_MainMenu_Overflow_Open")
      self:refreshExpend()
      local navMng = self.gameObject:GetComponent(typeof(C_UINavigationBinding))
      navMng:SelectArea("ExpendBtns")
    end,
    onClick_back = function(self)
      self:onExpendClose()
    end,
    onClick_backOn = function(self)
      self:onExpendClose()
    end,
    onClick_helpBtn = function(self)
      self:onHelpBtn(true)
    end,
    onClick_helpClose = function(self)
      self:onHelpBtn(false)
    end,
    onClick_changeBg = function(self)
      L_UI:open("pageMainMenuBgChange")
    end
  }
end

function this:ctor()
  this.super.ctor(self)
  self._needsToPlayBottomButtonAnim = true
  self.data = {
    pageLock = {}
  }
  self.lockers = {}
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.mainMenu)
  if not result then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_systemMessage_04~"))
  end
  callback(result)
end

function this:preOpen(options)
  self:initPage()
  if self._needsToPlayBottomButtonAnim then
    self.bindComponents.effectAnim:Open()
    self._needsToPlayBottomButtonAnim = false
  end
  self.cameraTactics = C_CameraManager.CreateCommonTactics(self.bindComponents.virtualCam_menuVirtualCamera.gameObject, C_CinemachineBlendType.Cut, true)
  L_PhotoManager:addListener(L_PhotoManager.event.pagePhotoOpen, self.onPagePhotoOpen, self)
  self._onBattlePassFullSyncHandle = handler(self, self.onBattlePassFullSync)
  C_BattlePassStoreEvent.instance:Listen(C_EBattlePassStoreEvent.FullInfoSync, self._onBattlePassFullSyncHandle)
  AzurWorld.HUDMgr:SetAllVisible(false, "esc")
  C_BattleUIManager.GMSetUIShowState(false)
  self.bindComponents.virtualCam_menuVirtualCamera.enabled = true
  self.bindComponents.trans_lookAtPoint:SetParent(nil)
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(true)
  end
  self.powerOfConnection = C_IntegrateMgr.SystemUnlockModule:getOnlySystemUnlock(L_SystemConst.enum.PowerOfConnection)
  if self.powerOfConnection then
    self.bind.active_startLev = true
    L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.onEvent_refreshBaseInfo, self)
    self:onHeroLevel()
  end
end

function this:show()
  AzurWorld.RedDotMgr:RefreshRedDot("1001")
  AzurWorld.HUDMgr:SetAllVisible(false, "esc")
  C_BattleUIManager.GMSetUIShowState(false)
  if self._needsToPlayBottomButtonAnim then
    self.bindComponents.effectAnim:Open()
    self._needsToPlayBottomButtonAnim = false
  end
  if L_CommonUtil.isValid(self.bindComponents.virtualCam_menuVirtualCamera.gameObject) then
    self.bindComponents.virtualCam_menuVirtualCamera.gameObject:SetActive(true)
  end
  self:cameraSearchPos()
  self:refreshMoreRedDot()
  AzurWorld.InteractMgr:SetAllWorldInteractUIVisible(false, "pageMainMenu")
  self.bindComponents.virtualCam_menuVirtualCamera.enabled = true
  C_InputManager.SetGamepadUIInputMap(self.pageName, true)
  self.isTopLeft = false
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPageMainMenuNavLeftTop, function()
    if not self.isTopLeft and not self.isExpend then
      self.isTopLeft = true
      local navMng = self.gameObject:GetComponent(typeof(C_UINavigationBinding))
      navMng:SelectArea("TopLeftBtns")
    end
  end)
end

function this:hide()
  self.bindComponents.effectAnim:Close()
  self._needsToPlayBottomButtonAnim = true
  AzurWorld.HUDMgr:SetAllVisible(true, "esc")
  C_BattleUIManager.GMSetUIShowState(true)
  AzurWorld.InteractMgr:SetAllWorldInteractUIVisible(true, "pageMainMenu")
  L_ShortCutManager:unregisterShortCut(self.pageName, C_InputManager_KeyType.EPageMainMenuNavLeftTop)
  C_InputManager.SetGamepadUIInputMap(self.pageName, false)
end

function this:close()
  self.petCatalogRedNode = nil
  AzurWorld.RedDotMgr:UnRegistRedDot("1001")
  if L_CommonUtil.isValid(self.bindComponents.virtualCam_menuVirtualCamera.gameObject) then
    self.bindComponents.virtualCam_menuVirtualCamera.enabled = false
  end
  if self.powerOfConnection then
    L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.onEvent_refreshBaseInfo)
  end
  self:destroyAllLocker()
  if L_CommonUtil.isValid(self.bindComponents.virtualCam_menuVirtualCamera.gameObject) then
    C_GameObject.Destroy(self.bindComponents.virtualCam_menuVirtualCamera.gameObject)
  end
  if L_CommonUtil.isValid(self.bindComponents.trans_lookAtPoint) then
    C_GameObject.Destroy(self.bindComponents.trans_lookAtPoint.gameObject)
  end
  if L_CommonUtil.isValid(self.cameraTactics) then
    C_CameraManager.ExitAndCompleteCamera(self.cameraTactics)
    self.cameraTactics:Dispose()
    C_CameraManager.RemoveTactics(self.cameraTactics)
  end
  L_PhotoManager:removeListener(L_PhotoManager.event.pagePhotoOpen, self.onPagePhotoOpen, self)
  if self._onBattlePassFullSyncHandle ~= nil then
    C_BattlePassStoreEvent.instance:Cancel(C_EBattlePassStoreEvent.FullInfoSync, self._onBattlePassFullSyncHandle)
    self._onBattlePassFullSyncHandle = nil
  end
  AzurWorld.HUDMgr:SetAllVisible(true, "esc")
  C_BattleUIManager.GMSetUIShowState(true)
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(false)
  end
end

function this:initPage()
  self.specialSystemCheckFuncs = self.specialSystemCheckFuncs or {
    [L_SystemConst.enum.battlePass] = self.checkShowBattlePass,
    [L_SystemConst.enum.formation] = self.checkShowFormation
  }
  self.modules.module_banner:initModule()
  self:initCurrencyList()
  self:initReddot()
  self:cameraSearchPos()
  self:IsOpenShop()
  self:upButtonsSetVisible()
  self:buildBottomButtons()
end

function this:initCurrencyList()
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.assetMenu) then
    local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.mainMenu)
    self.modules.module_currency:refreshRes(tpl_sys)
  else
    self.modules.module_currency:refreshRes()
  end
end

function this:initReddot()
  local reddotMap = {
    [L_ReddotManager.DotDef.PlayerInfo] = self.bindComponents.redotPlayerCard,
    [L_ReddotManager.DotDef.Mail] = self.bindComponents.redotMail,
    [L_ReddotManager.DotDef.HomeScience] = self.bindComponents.redotHomeScience,
    [L_ReddotManager.DotDef.SpecialShop] = self.bindComponents.redotSpecialShop,
    [L_ReddotManager.DotDef.Adventure] = self.bindComponents.redotAdventure,
    [L_ReddotManager.DotDef.Announcement] = self.bindComponents.redotAnnouncement,
    [L_ReddotManager.DotDef.Gacha] = self.bindComponents.redotGacha,
    [L_ReddotManager.DotDef.Shop] = self.bindComponents.redotShop
  }
  for key, go in pairs(reddotMap) do
    L_ReddotManager:registerReddot(go, key)
  end
  local systemToReddotMap = {
    [L_SystemConst.enum.friend] = L_ReddotManager.DotDef.Friend,
    [L_SystemConst.enum.playerCard] = L_ReddotManager.DotDef.PlayerInfo,
    [L_SystemConst.enum.hero] = L_ReddotManager.DotDef.Hero,
    [L_SystemConst.enum.pet] = L_ReddotManager.DotDef.Pet,
    [L_SystemConst.enum.announcemenet] = L_ReddotManager.DotDef.Announcement,
    [L_SystemConst.enum.home] = L_ReddotManager.DotDef.Home,
    [L_SystemConst.enum.homeCenter] = L_ReddotManager.DotDef.HomeCenter,
    [L_SystemConst.enum.mail] = L_ReddotManager.DotDef.Mail,
    [L_SystemConst.enum.homeScience] = L_ReddotManager.DotDef.HomeScience,
    [L_SystemConst.enum.specialShop] = L_ReddotManager.DotDef.SpecialShop,
    [L_SystemConst.enum.petCatalog] = L_ReddotManager.DotDef.PetCatalog,
    [L_SystemConst.enum.entrustTask] = L_ReddotManager.DotDef.EntrustTaskEnter,
    [L_SystemConst.enum.adventure] = L_ReddotManager.DotDef.Adventure,
    [L_SystemConst.enum.achievement] = L_ReddotManager.DotDef.Achieve,
    [L_SystemConst.enum.journeyTask] = L_ReddotManager.DotDef.JourneyTaskMainMenu,
    [L_SystemConst.enum.battlePass] = L_ReddotManager.DotDef.BattlePassMainMenu,
    [L_SystemConst.enum.gacha] = L_ReddotManager.DotDef.Gacha,
    [L_SystemConst.enum.shop] = L_ReddotManager.DotDef.Shop
  }
  self.systemToReddotMap = systemToReddotMap
  if not self.petCatalogRedNode or not L_CommonUtil.isValid(self.petCatalogRedNode) then
    self.petCatalogRedNode = AzurWorld.RedDotMgr:RegistRedDot("1001", nil, nil, function()
      return C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.petCatalog) and L_CatalogStore:getHasNew()
    end, true)
  end
end

function this:refreshMoreRedDot()
  if not self.bindComponents.redotBtnMore or not self.moreBtnEnable then
    return
  end
  local hasRedDot = false
  for systemId, _ in pairs(_mainBottomButtonsTpl.data) do
    local buttonTpl = _mainBottomButtonsTpl:getTplById(systemId)
    if buttonTpl then
      local extendOrder = _mainBottomButtonsTpl:getExtendOrder(buttonTpl)
      if extendOrder and extendOrder ~= 0 then
        if systemId == L_SystemConst.enum.petCatalog then
          if AzurWorld.RedDotMgr:GetRedDotState("1001") and C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.petCatalog) then
            hasRedDot = true
            break
          end
        else
          local reddotType = self.systemToReddotMap[systemId]
          if reddotType and L_ReddotManager:getRedDotState(reddotType) and C_IntegrateMgr.SystemUnlockModule:Check(systemId) then
            hasRedDot = true
            break
          end
        end
      end
    end
  end
  self.bindComponents.redotBtnMore:ActiveTrans(hasRedDot)
end

function this:closePage()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  self.bindComponents.effectAnim:Close()
  L_UI:close(self.pageName)
end

function this:cameraSearchPos()
  self.deltaPosYBetweenEntityAndNode = C_LuaTools.CameraSearchPos(self.bindComponents.virtualCam_menuVirtualCamera, self.bindComponents.trans_lookAtPoint, self.deltaPosYBetweenEntityAndNode or 0)
end

function this:IsOpenShop()
  local isOpenShop = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.MallControlSwitch)
  self.bindComponents.rTrans_shopUnlock.transform:ActiveTrans(isOpenShop)
  self.bindComponents.rTrans_shopLock.transform:ActiveTrans(not isOpenShop)
end

function this:onPagePhotoOpen()
  if L_CommonUtil.isValid(self.bindComponents.virtualCam_menuVirtualCamera.gameObject) then
    self.bindComponents.virtualCam_menuVirtualCamera.gameObject:SetActive(false)
  end
end

function this:refreshExpend()
  self.bind.btn_close = not self.isExpend
  self.bind.btn_closeOn = self.isExpend
  self.bind.module_currency_go = not self.isExpend
  self.bind.gruop_botomBtn = not self.isExpend
  self.bind.group_expend = self.isExpend
  self.bind.group_rightBtn = not self.isExpend
  self.bind.commonTopBar = not self.isExpend
  self.bind.btn_back = self.isExpend
  self.bind.btn_more = not self.isExpend
  self.bind.active_startLev = not self.isExpend
  self.bindComponents.blur_bg.enabled = self.isExpend
end

function this:getMainMenuBgTabType()
  local v = Unity.PlayerPrefs.GetInt(MAIN_MENU_BG_PREFS_KEY, L_Const.mainMenuBgTabType.Default)
  if v < L_Const.mainMenuBgTabType.Default or v > L_Const.mainMenuBgTabType.Dormitory then
    v = L_Const.mainMenuBgTabType.Default
  end
  return v
end

function this:upButtonsSetVisible()
  self.systemToTrans = {
    [L_SystemConst.enum.adventure] = {
      self.bindComponents.rTransAdventure
    },
    [L_SystemConst.enum.mail] = {
      self.bindComponents.rTransMail
    },
    [L_SystemConst.enum.announcemenet] = {
      self.bindComponents.rTransAnnouncement
    },
    [L_SystemConst.enum.photo] = {
      self.bindComponents.rTransPhoto
    },
    [L_SystemConst.enum.playerCard] = {
      self.bindComponents.rTransPlayerCard
    },
    [L_SystemConst.enum.mainBanner] = {
      self.bindComponents.rTransMainBanner
    },
    [L_SystemConst.enum.gacha] = {
      self.bindComponents.rTransGacha
    },
    [L_SystemConst.enum.MallControlSwitch] = {
      self.bindComponents.rTransSpecialShop
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    if v ~= nil then
      local tpl = _systemUnlockTpl:getTplById(systemId)
      local shouldShow = tpl and _systemUnlockTpl:getButtonShow(tpl)
      if not shouldShow then
        local locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
        if locker then
          self.lockers[systemId] = locker
          self:refreshSystem(systemId, false)
          locker:setCallback(self.refreshSystem, self, self.gameObject)
        end
      end
    end
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = self.lockers[systemId]
  for _, v in ipairs(node) do
    locker:tryShowOrHide(v, isUnlock)
  end
  if systemId == L_SystemConst.enum.MallControlSwitch then
    self:IsOpenShop()
  end
end

function this:destroyAllLocker()
  for _, v in pairs(self.lockers) do
    local locker = v
    if locker then
      C_IntegrateMgr.SystemUnlockModule:RemoveLocker(locker)
    end
  end
end

function this:buildBottomButtons()
  self.moreBtnEnable = true
  local unlockMoreCondition = L_GameConstTpl:getData("MAIN_BOTTOM_BUTTONS_MORE_CONDITION", L_Const.GameTplType.condition)
  for _, unlockCondition in pairs(unlockMoreCondition) do
    if not L_ConditionManager:singleIsComplete(unlockCondition) then
      self.moreBtnEnable = false
    end
  end
  if self.moreBtnEnable then
    self:buildButtonsWithMore()
  else
    self:buildButtonsNoMore()
  end
end

function this:buildButtonsWithMore()
  self.bind.btn_more = true
  self.bind.bottomList:clear()
  self.bind.bottomMoreList:clear()
  local allButtons = {}
  local bottomButtons = {}
  local moreButtons = {}
  for systemId, _ in pairs(_mainBottomButtonsTpl.data) do
    local buttonTpl = _mainBottomButtonsTpl:getTplById(systemId)
    if buttonTpl then
      local bottomOrder = _mainBottomButtonsTpl:getBottomOrder(buttonTpl)
      local extendOrder = _mainBottomButtonsTpl:getExtendOrder(buttonTpl)
      local isUnlocked = C_IntegrateMgr.SystemUnlockModule:getOnlySystemUnlock(systemId)
      local tpl = _systemUnlockTpl:getTplById(systemId)
      local shouldShow = tpl and _systemUnlockTpl:getButtonShow(tpl)
      local show = isUnlocked or shouldShow
      if show and self.specialSystemCheckFuncs and self.specialSystemCheckFuncs[systemId] then
        show = self.specialSystemCheckFuncs[systemId](self)
      end
      if show then
        table.insert(allButtons, {
          systemId = systemId,
          bottomOrder = bottomOrder,
          extendOrder = extendOrder
        })
      else
        local locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
        if locker then
          self.lockers[systemId] = locker
          locker:setCallback(self.buildButtonsWithMore, self, self.gameObject)
        end
      end
    end
  end
  for _, button in ipairs(allButtons) do
    if button.bottomOrder ~= nil and button.bottomOrder > 0 then
      table.insert(bottomButtons, button)
    end
  end
  table.sort(bottomButtons, function(a, b)
    return a.bottomOrder > b.bottomOrder
  end)
  local bottomButtonList = {}
  if #bottomButtons % 2 == 1 then
    table.insert(bottomButtonList, {
      systemId = 0,
      isPlaceholder = true,
      go_Button = false
    })
  end
  for i, button in ipairs(bottomButtons) do
    if i == math.floor(#bottomButtons / 2) + 1 then
      table.insert(bottomButtonList, {
        systemId = 0,
        isPlaceholderMiddle = true,
        go_Button = false
      })
    end
    table.insert(bottomButtonList, {
      systemId = button.systemId
    })
  end
  for _, button in ipairs(allButtons) do
    if button.extendOrder ~= nil and button.extendOrder > 0 then
      table.insert(moreButtons, button)
    end
  end
  table.sort(moreButtons, function(a, b)
    return a.extendOrder < b.extendOrder
  end)
  local bottomMoreButtonList = {}
  for _, button in ipairs(moreButtons) do
    table.insert(bottomMoreButtonList, {
      systemId = button.systemId
    })
  end
  self.bind.bottomList:insert_array(bottomButtonList)
  self.bind.bottomMoreList:insert_array(bottomMoreButtonList)
end

function this:buildButtonsNoMore()
  self.bind.btn_more = false
  self.bind.bottomList:clear()
  local bottomButtonList = {}
  for systemId, _ in pairs(_mainBottomButtonsTpl.data) do
    local show = C_IntegrateMgr.SystemUnlockModule:Check(systemId)
    if show and self.specialSystemCheckFuncs and self.specialSystemCheckFuncs[systemId] then
      show = self.specialSystemCheckFuncs[systemId](self)
    end
    if show then
      table.insert(bottomButtonList, {systemId = systemId})
    end
  end
  table.sort(bottomButtonList, function(a, b)
    return a.systemId > b.systemId
  end)
  if 9 < #bottomButtonList then
    local limitedList = {}
    local startIndex = #bottomButtonList - 8
    for i = startIndex, #bottomButtonList do
      table.insert(limitedList, bottomButtonList[i])
    end
    bottomButtonList = limitedList
  end
  self.bind.bottomList:insert_array(bottomButtonList)
end

function this:setShortcutGuidePCActive(isShow)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuidePcUiPanelEventArgs()
  args.isLuaEvent = true
  args.luaTable = {shortcutGuidePcUiPanel = 2}
  if isShow then
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcShowUiPanel, args)
  else
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcHideUiPanel, args)
  end
end

function this:CheckCanFindTargetCellItem(guideSerializeId, guideParam)
  return true
end

function this:FindTargetCellItem(guideSerializeId, guideParam)
  if guideSerializeId == L_Const.GuideSerializeId.MainMenu then
    local bottomListCount = self.bind.bottomList:getLength()
    for i = 1, bottomListCount do
      local chile = self.bind.bottomList:getItemCls(i)
      if guideParam == chile.systemId then
        return chile.bindComponents.rTrans.gameObject
      end
    end
    local bottomMoreListCount = self.bind.bottomMoreList:getLength()
    for i = 1, bottomMoreListCount do
      local chile = self.bind.bottomMoreList:getItemCls(i)
      if guideParam == chile.systemId then
        return chile.bindComponents.rTrans.gameObject
      end
    end
  end
  return nil
end

function this:onExpendClose()
  self.isExpend = false
  self.bindComponents.more_animation:Play("anim_mainmenu_more_close")
  L_AudioUtil.playSound("Play_SFX_System_UI_MainMenu_Overflow_Close")
  self:refreshExpend()
  local navMng = self.gameObject:GetComponent(typeof(C_UINavigationBinding))
  navMng:SelectArea("BottomBtns")
end

function this:escHandle()
  if self.isExpend then
    self:onExpendClose()
  elseif self.isTopLeft then
    self.isTopLeft = false
    local navMng = self.gameObject:GetComponent(typeof(C_UINavigationBinding))
    navMng:SelectArea("BottomBtns")
  else
    L_UI:close(self.pageName)
  end
end

function this:onEvent_refreshBaseInfo()
  self:onHeroLevel()
end

function this:onHeroLevel()
  self.bind.txt_startName = L_PlayerStore:getPlayerName()
  local lv, isMaxLv = L_PlayerStore:getLv()
  local exp = L_PlayerStore:getExp()
  self.bind.txt_startLev = tostring(lv)
  local tpl_level = _playerLevelTpl:getTplById(lv)
  local totalExp = _playerLevelTpl:getExp(tpl_level)
  self.bind.fill_exp = isMaxLv and 1 or exp / totalExp
  local itemId = 22
  local conf = L_ItemTplManager:getItemConfig(L_Const.resType.currency, itemId)
  local num = conf.num <= 0 and connect_power or conf.num
  self.bind.txt_helpDesc = L_WordsTpl:getValue("connectpower_tips", {
    [0] = num,
    [1] = num
  })
end

function this:onHelpBtn(isShow)
  self.bind.active_startLevBtn = isShow
  self.bind.active_startHelp = isShow
end

function this:checkShowBattlePass()
  return C_BattlePassStore.CheckShowBattlePass()
end

function this:onBattlePassFullSync()
  self:buildBottomButtons()
end

function this:checkShowFormation()
  local unlock = C_IntegrateMgr.SystemUnlockModule:getOnlySystemUnlock(L_SystemConst.enum.formation)
  local disable = C_IntegrateMgr.SystemUnlockModule:CheckIsDisableSystem(L_SystemConst.enum.formation)
  return unlock and not disable
end

return this
