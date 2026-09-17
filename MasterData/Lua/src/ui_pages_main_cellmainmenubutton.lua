local this = class("cellMainMenuButton", G_UIModuleBase)
local _mainBottomButtonsTpl = L_GameTpl:getMainBottomButtonsTpl()
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
  [L_SystemConst.enum.activation] = L_ReddotManager.DotDef.Activity,
  [L_SystemConst.enum.journeyTask] = L_ReddotManager.DotDef.JourneyTaskMainMenu,
  [L_SystemConst.enum.battlePass] = L_ReddotManager.DotDef.BattlePassMainMenu,
  [L_SystemConst.enum.handbook] = L_ReddotManager.DotDef.HandBook,
  [L_SystemConst.enum.rogue] = L_ReddotManager.DotDef.Rogue
}

function this.bind()
  return {
    txt_normal = "",
    decorateText_normal = "",
    txt_exit = "",
    decorateText_exit = "",
    txt_lock = "",
    decorateText_lock = "",
    img_lockIconBg = "",
    img_lockIcon = "",
    img_unlockIconBg = "",
    img_unlockIcon = "",
    go_imgBg = false,
    go_lock = false,
    go_unlock = true,
    go_normalText = true,
    go_exitText = false,
    go_Button = true
  }
end

function this.methods()
  return {
    onClick_btn = function(self)
      self:handleClick()
    end
  }
end

function this:open()
  self.systemId = self.bind.systemId
  if self.bind.isPlaceholderMiddle then
    local btn = self.gameObject:GetComponent(typeof(C_LButton))
    btn:SetShouldBeManaged(false)
    self.bind.go_Button = false
    if not L_DeviceTpl:getIsPc() then
      self.bindComponents.rTrans.sizeDelta = C_Vector2(0, 71)
    else
      self.bindComponents.rTrans.sizeDelta = C_Vector2(59.5, 71)
    end
    return
  end
  if self.bind.isPlaceholder then
    local btn = self.gameObject:GetComponent(typeof(C_LButton))
    btn:SetShouldBeManaged(false)
    self.bind.go_Button = false
    if not L_DeviceTpl:getIsPc() then
      self.bindComponents.rTrans.sizeDelta = C_Vector2(77, 71)
    else
      self.bindComponents.rTrans.sizeDelta = C_Vector2(59.5, 71)
    end
    return
  end
  local buttonTpl = _mainBottomButtonsTpl:getTplById(self.systemId)
  local icon = _mainBottomButtonsTpl:getIcon(buttonTpl)
  local buttonNormalText = _mainBottomButtonsTpl:getText(buttonTpl)
  local buttonNormalDecorateText = _mainBottomButtonsTpl:getDecorateText(buttonTpl)
  local buttonExitText = _mainBottomButtonsTpl:getExitText(buttonTpl)
  local buttonExitDecorateText = _mainBottomButtonsTpl:getExitDecorateText(buttonTpl)
  self.bind.img_lockIconBg = icon
  self.bind.img_lockIcon = icon
  self.bind.img_unlockIconBg = icon
  self.bind.img_unlockIcon = icon
  self.bind.txt_normal = buttonNormalText
  self.bind.decorateText_normal = buttonNormalDecorateText
  self.bind.txt_exit = buttonExitText
  self.bind.decorateText_exit = buttonExitDecorateText
  self.bind.txt_lock = buttonNormalText
  self.bind.decorateText_lock = buttonNormalDecorateText
  self.bind.go_imgBg = false
  self.bind.go_lock = false
  self.bind.go_unlock = true
  self.bind.go_Button = true
  local exitEnable = self:exitEnable()
  self.bind.go_normalText = not exitEnable
  self.bind.go_exitText = exitEnable
  self:refreshLocker()
  self:initReddot()
end

function this:refreshLocker()
  self.locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(self.systemId)
  if self.locker then
    self:refreshSystem(self.systemId, false)
    self.locker:setCallback(self.refreshSystem, self, self.gameObject)
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.bindComponents.rTrans
  local lock = L_GameUtil.findTranByName(node, "lock")
  local unlock = L_GameUtil.findTranByName(node, "unlock")
  if lock then
    lock.gameObject:ActiveTrans(not isUnlock)
  end
  if unlock then
    unlock.gameObject:ActiveTrans(isUnlock)
  end
end

function this:show()
  if self.systemId == L_SystemConst.enum.petCatalog then
    if AzurWorld.RedDotMgr:GetRedDotState("1001") and C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.petCatalog) then
      self.bindComponents.redDot.gameObject:SetActive(true)
    else
      self.bindComponents.redDot.gameObject:SetActive(false)
    end
  end
end

function this:initReddot()
  if self.systemId == L_SystemConst.enum.petCatalog then
    if AzurWorld.RedDotMgr:GetRedDotState("1001") and C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.petCatalog) then
      self.bindComponents.redDot.gameObject:SetActive(true)
    else
      self.bindComponents.redDot.gameObject:SetActive(false)
    end
  else
    local reddotType = systemToReddotMap[self.systemId]
    if reddotType and self.bindComponents.redDot then
      L_ReddotManager:registerReddot(self.bindComponents.redDot, reddotType)
    end
  end
end

function this:close()
  if self.locker then
    C_IntegrateMgr.SystemUnlockModule:RemoveLocker(self.locker)
  end
end

local systemClickHandlers = {
  [L_SystemConst.enum.specialShop] = function()
    L_SystemBreakManager:jumpTo(L_SystemConst.enum.specialShop, {shopId = 9999})
  end,
  [L_SystemConst.enum.homeCenter] = function()
    L_UI:open("pageHomeCenterNew")
  end,
  [L_SystemConst.enum.home] = function()
    C_HomeUtil.SwitchInOutHome()
  end,
  [L_SystemConst.enum.pet] = function()
    L_UI:open("pagePetBox")
  end,
  [L_SystemConst.enum.petCatalog] = function()
    if C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petCatalog) then
      L_UI:open("pagePetCatalogue")
    end
  end,
  [L_SystemConst.enum.entrustTask] = function()
    L_UI:open("pageDungeonEntrustEntrance")
  end,
  [L_SystemConst.enum.achievement] = function()
    L_UI:open("pageAchieveGroup")
  end,
  [L_SystemConst.enum.rogue] = function()
    L_UI:open("pageRogueEntry")
  end,
  [L_SystemConst.enum.handbook] = function()
    L_UI:open("pageIllustratedbookMain")
  end,
  [L_SystemConst.enum.friend] = function()
  end,
  [L_SystemConst.enum.formation] = function()
    L_SystemBreakManager:jumpTo(L_SystemConst.enum.formation, {dontBack2RootWhenClose = true, isSubFormation = true})
  end,
  [L_SystemConst.enum.wishlist] = function()
    L_UI:open("pageWishlist")
  end,
  [L_SystemConst.enum.homeScience] = function()
    C_HomeUtil.OpenHomeTechnology(false)
  end,
  [L_SystemConst.enum.HomeRecipe] = function()
    L_UI:open("pageHomeLevelInfo")
  end,
  [L_SystemConst.enum.MultiTeamHub] = function()
    local ableToOpen = C_MultiTeamHubStore.CheckAbleToOpenHubPage()
    if not ableToOpen then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("multiteamhub_block"))
    else
      L_UI:open("pageMultiTeamHub")
    end
  end,
  [L_SystemConst.enum.battlePass] = function()
    L_UI:open("pageBattlePassMain")
  end
}

function this:handleClick()
  if self.bind.isPlaceholder then
    return
  end
  local isOpen = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(self.systemId)
  if not isOpen then
    return
  end
  local handler = systemClickHandlers[self.systemId]
  if handler then
    handler()
  else
    L_SystemBreakManager:jumpTo(self.systemId)
  end
end

function this:exitEnable()
  if self.systemId == L_SystemConst.enum.home then
    local curModule = L_WorldManager:getCurModule()
    local isHome = curModule == L_Const.worldModule.home
    return isHome
  end
  return false
end

return this
