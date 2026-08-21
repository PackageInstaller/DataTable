_class("UIShopSecretTabBtn", UICustomWidget)
UIShopSecretTabBtn = UIShopSecretTabBtn

function UIShopSecretTabBtn:OnShow()
  self._isSelected = false
  self._uiUnsel = self:GetUIComponent("RectTransform", "uiUnsel")
  self._uiSel = self:GetUIComponent("RectTransform", "uiSel")
  self._unselName = self:GetUIComponent("UILocalizedTMP", "unselName")
  self._selName = self:GetUIComponent("UILocalizedTMP", "selName")
  self._limitedTime = self:GetUIComponent("RectTransform", "limitedTime")
  self._new = self:GetGameObject("new")
  self.animation = self:GetGameObject():GetComponent("Animation")
  self:AttachEvent(GameEventType.ShopNew, self.ShopNew)
end

function UIShopSecretTabBtn:SkinTabDetachEvent()
  self:DetachEvent(GameEventType.ShopNew, self.ShopNew)
end

function UIShopSecretTabBtn:ShopNew()
  local new = self:GetSubTabNew()
  self._new:SetActive(new)
end

function UIShopSecretTabBtn:FlushNew(isNew)
  self._new:SetActive(isNew)
end

function UIShopSecretTabBtn:OnHide()
  self:DetachEvent(GameEventType.ShopNew, self.ShopNew)
end

function UIShopSecretTabBtn:Init(subTabType, name, nestsubTabType, onClickTabBtn, param)
  self.subTabType = subTabType
  self.nestSubTabType = nestsubTabType
  self.onClickTabBtn = onClickTabBtn
  self.param = param
  self._unselName:SetText(name or "")
  self._selName:SetText(name or "")
  self._limitedTime.gameObject:SetActive(subTabType ~= nil and subTabType >= MarketType.Shop_CampaignMarket)
  self:Select(false)
  self:ShopNew()
end

function UIShopSecretTabBtn:SetData(k, name, onClickTabBtn)
  self.onClickTabBtn = onClickTabBtn
  self.param = k
  self._unselName:SetText(name or "")
  self._selName:SetText(name or "")
  self._limitedTime.gameObject:SetActive(false)
  self:Select(false)
end

function UIShopSecretTabBtn:GetSubTabNew()
  local new = false
  if self.subTabType == MarketType.Shop_Season then
    local shopModule = GameGlobal.GetModule(ShopModule)
    new = shopModule:GetExchangeTab_SeasonNew()
  end
  if self.subTabType == MarketType.Shop_BattlePass then
    local shopModule = GameGlobal.GetModule(ShopModule)
    new = shopModule:GetBattlePassTabNew(self.nestSubTabType)
  end
  return new
end

function UIShopSecretTabBtn:Select(isSelect)
  local preSelected = self._isSelected
  self._isSelected = isSelect
  self._uiUnsel.gameObject:SetActive(not isSelect)
  self._uiSel.gameObject:SetActive(isSelect)
  if preSelected ~= self._isSelected then
    if self._isSelected then
      self:PlayInAnimation()
    else
      self:PlayOutAnimation()
    end
  end
end

function UIShopSecretTabBtn:SetSelected(isSelect)
  self:Select(isSelect)
end

function UIShopSecretTabBtn:IsSelected()
  return self._isSelected
end

function UIShopSecretTabBtn:BtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  self.onClickTabBtn(self.param, self.subTabType, self.nestSubTabType)
end

function UIShopSecretTabBtn:GetSubType()
  return self.subTabType
end

function UIShopSecretTabBtn:GetNestSubType()
  return self.nestSubTabType
end

function UIShopSecretTabBtn:PlayInAnimation()
  self.animation:Play("uianim_UIShopSecretTabBtn_in")
  return 333
end

function UIShopSecretTabBtn:PlayOutAnimation()
  self._uiSel.gameObject:SetActive(true)
  self.animation:Play("uianim_UIShopSecretTabBtn_out")
  local animLength = 250
  self:StartSafeTask("UIShopSecretTabBtn::PlayOutAnimation", function(lockName, TT)
    self:Lock(lockName)
    YIELD(TT, animLength)
    self:UnLock(lockName)
    self._uiSel.gameObject:SetActive(self._isSelected)
  end)
  return animLength
end
