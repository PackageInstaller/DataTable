_class("UIMainLobbyBtnShop", UICustomWidget)
UIMainLobbyBtnShop = UIMainLobbyBtnShop

function UIMainLobbyBtnShop:OnShow()
  self._active = true
  self.shopBtnBg = self:GetGameObject("shopBtnBg")
  self._shopImg = self:GetUIComponent("Image", "shopImg")
  self._shopBtn = self:GetUIComponent("Button", "btnShop")
  self._shopBtnPool = self:GetUIComponent("UISelectObjectPath", "btnShop")
  self._storeNameEnLabel = self:GetUIComponent("UILocalizationText", "nameEn")
  self._storeNameChLabel = self:GetUIComponent("UILocalizationText", "name")
  self._shopRedpoint = self:GetGameObject("ShopRedpoint")
  self.imgNewShop = self:GetGameObject("imgNewShop")
  self._atlas = self:GetAsset("UIMainLobby.spriteatlas", LoadType.SpriteAtlas)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._shopBtn.gameObject), UIEvent.Press, function(go)
    self._shopImg.sprite = self._atlas:GetSprite("main_zjm_icon27")
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._shopBtn.gameObject), UIEvent.Release, function(go)
    self._shopImg.sprite = self._atlas:GetSprite("main_zjm_icon26")
  end)
  self:AttachEvent(GameEventType.CheckMonthCardRedpoint, self.FlushMonthCardRedpoint)
  self:AttachEvent(GameEventType.ShopNew, self.CoFlushNew)
  self.mRedDot = GameGlobal.GetModule(RedDotModule)
  self.mRedDot:ListenRedDot({
    [RedDotType.RDT_SHOP_HOMEPAGE_NEW] = GameEventType.ShopNew
  })
  self.mShop = GameGlobal.GetModule(ShopModule)
  self:Flush()
end

function UIMainLobbyBtnShop:OnHide()
  self:RemoveAllCustomEventListener()
  self:DetachEvent(GameEventType.CheckMonthCardRedpoint, self.FlushMonthCardRedpoint)
  self:DetachEvent(GameEventType.ShopNew, self.CoFlushNew)
  self.mRedDot:UnListenRedDot({
    RedDotType.RDT_SHOP_HOMEPAGE_NEW
  })
  self.imgNewShop = nil
  self._active = false
end

function UIMainLobbyBtnShop:Flush()
  self:FlushMonthCardRedpoint()
  self:CoFlushNew()
end

function UIMainLobbyBtnShop:FlushLockStatus()
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Shop)
  self.shopBtnBg:SetActive(not isLock)
  local shopButtonFunction = self._shopBtnPool:SpawnObject("UIFunctionLockButton")
  shopButtonFunction:SetFunctionType(GameModuleID.MD_Shop, ButtonLockType.MaskAndTips, nil, MaskShowType.Small, function()
    self._storeNameEnLabel.color = Color(1, 1, 1, 0.08)
    self._storeNameChLabel.color = Color(0.30980392156862746, 0.30980392156862746, 0.30980392156862746, 1)
    self._shopImg.color = Color(0.30980392156862746, 0.30980392156862746, 0.30980392156862746, 1)
  end, function()
    self._storeNameEnLabel.color = Color(1, 1, 1, 0.21568627450980393)
    self._storeNameChLabel.color = Color(1, 1, 1, 1)
    self._shopImg.color = Color(1, 1, 1, 1)
  end)
end

function UIMainLobbyBtnShop:FlushMonthCardRedpoint()
  local show, tips, day = self.mShop:ShowMonthCardRedPoint()
  self._shopRedpoint:SetActive(show)
end

function UIMainLobbyBtnShop:CoFlushNew()
  local limitedTimeRechargeOpen = self:GetUIModule(SignInModule):CheckEventOpen(CommonEventType.LimitedTimeRecharge)
  if limitedTimeRechargeOpen then
    local localDbKey = "LimitedTimeRechargeRead" .. self:GetModule(RoleModule):GetPstId()
    if not LocalDB.HasKey(localDbKey) then
      self.imgNewShop:SetActive(true)
      return
    end
  end
  self:StartTask(function(TT)
    local res = self.mRedDot:RequestRedDotStatus(TT, {
      RedDotType.RDT_SHOP_HOMEPAGE_NEW
    })
    if not self.imgNewShop then
      return
    end
    if res and res[RedDotType.RDT_SHOP_HOMEPAGE_NEW] then
      self.imgNewShop:SetActive(true)
    else
      local showNew = self.mShop:GetHomelandShopTabNew()
      showNew = showNew or self.mShop:GetHomelandRechargeTabNew()
      self.imgNewShop:SetActive(showNew)
    end
  end, self)
end

function UIMainLobbyBtnShop:btnShopOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_ShopController"
  }, true)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Shop)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  TaskManager:GetInstance():StartTask(function(TT)
    GameGlobal.GetModule(RoleModule):OnHomePageEnter(TT, CLICKENTRANCE.CE_SHOP)
  end)
  ClientShop.OpenShop(nil, nil, nil, nil, true)
end
