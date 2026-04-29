_class("UICampaignShopConfirmDetailController", UIController)
UICampaignShopConfirmDetailController = UICampaignShopConfirmDetailController
local MAX_COUNT = 99

function UICampaignShopConfirmDetailController:Constructor()
end

function UICampaignShopConfirmDetailController:OnShow(uiParams)
  self:InitWidget(uiParams)
end

function UICampaignShopConfirmDetailController:InitWidget(uiParams)
  self.goodsData = uiParams[1]
  local cmptInfo = self.goodsData.exchangeCmpt:GetComponentInfo()
  self._campaignId = cmptInfo.m_campaign_id
  self._componentId = cmptInfo.m_component_id
  self._componentFullId = self.goodsData.exchangeCmpt:GetComponetCfgId(cmptInfo.m_campaign_id, cmptInfo.m_component_id)
  self.subTabType = uiParams[2]
  self.isPet = self.goodsData:IsPet()
  self.uiItem = self:GetUIComponent("RawImageLoader", "uiitem")
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self.nameTrans = self:GetUIComponent("Transform", "name")
  self.descTxt = self:GetUIComponent("UILocalizationText", "desc")
  self.descRect = self:GetUIComponent("RectTransform", "desc")
  self.descScroll = self:GetUIComponent("ScrollRect", "ContentPanel")
  self.btnGo = self:GetGameObject("btnGo")
  self.countGroupGO = self:GetGameObject("countgroup")
  self.countGroupRect = self:GetUIComponent("RectTransform", "countgroup")
  self._currentCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self.moneyIcon = self:GetUIComponent("Image", "moneyicon")
  self.priceTxt = self:GetUIComponent("UILocalizationText", "price")
  self.countFollowTxt = self:GetUIComponent("UILocalizationText", "countfollow")
  self.remainTxt = self:GetUIComponent("UILocalizationText", "remain")
  self.remainGO = self:GetGameObject("remaintxt")
  local btnBuyGO = self:GetGameObject("btnbuy")
  local etl = UICustomUIEventListener.Get(btnBuyGO)
  self:AddUICustomEventListener(etl, UIEvent.Press, function(go)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Unhovered, function(go)
    self:SetTextColor()
  end)
  self:AddUICustomEventListener(etl, UIEvent.Release, function(go)
    self:SetTextColor()
  end)
  self:Refresh()
end

function UICampaignShopConfirmDetailController:SetTextColor()
  local ownMoney = ClientCampaignShop.GetMoney(self.saleType)
  if ownMoney >= self.price then
    self.priceTxt.color = Color.white
  else
    self.priceTxt.color = Color(1.0, 0.4, 0.3215686274509804, 1)
  end
end

function UICampaignShopConfirmDetailController:Refresh()
  if not self.goodsData then
    return
  end
  local cfgItem = Cfg.cfg_item[self.goodsData:GetItemId()]
  if not cfgItem then
    return
  end
  self.count = 1
  self.singlePrice = self.goodsData:GetSalePrice()
  local itemId = cfgItem.ID
  local icon = cfgItem.Icon
  local quality = cfgItem.Color
  local count = self.goodsData:GetItemCount()
  local text1 = count <= 1 and "" or StringTable.Get("str_shop_good_count") .. count
  self.uiItem:LoadImage(icon)
  self.nameTxt:SetText("「" .. StringTable.Get(cfgItem.Name) .. "」")
  local itemCount = self:GetModule(ItemModule):GetItemCount(itemId)
  self._currentCount:SetText(StringTable.Get("str_shop_current_item_count", itemCount))
  self.descTxt:SetText(StringTable.Get(cfgItem.Intro))
  self.saleType = self.goodsData:GetCostItemId()
  self.moneyIcon.sprite = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas):GetSprite(ClientShop.GetCurrencyImageName(self.saleType))
  if self.isPet then
    self.btnGo:SetActive(true)
  else
    self.btnGo:SetActive(false)
  end
  self.remainCount = self.goodsData:GetRemainCount()
  self.countGroupGO:SetActive(true)
  if self.goodsData:IsUnLimit() then
    self.remainGO:SetActive(false)
  else
    self.remainGO:SetActive(false)
    self.remainTxt:SetText(self.remainCount)
  end
  self:SetCountPriceTxt()
  self:DoAnimation()
  self:SetScroll()
end

function UICampaignShopConfirmDetailController:SetScroll()
  local perferredH = self.descTxt.preferredHeight
  if perferredH < 135 then
    self.descScroll.vertical = false
  else
    self.descScroll.vertical = true
  end
end

function UICampaignShopConfirmDetailController:DoAnimation()
  self._cg = self:GetUIComponent("CanvasGroup", "UICanvas")
  self._panel = self:GetUIComponent("RectTransform", "panel")
  self._infoTrans = self:GetUIComponent("Transform", "info")
  self._cg.alpha = 0
  self:StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    self._cg:DOFade(1, 0.3)
    self._panel.localScale = Vector3(0.5, 0.5, 0.5)
    local y = self._infoTrans.localPosition.y
    self._panel:DOScale(Vector3(1, 1, 1), 0.3):OnComplete(function()
    end)
    self._infoTrans:DOLocalMoveY(y + 3, 0.2):OnComplete(function()
      self._infoTrans:DOLocalMoveY(y - 3, 0.2)
    end)
  end, self)
end

function UICampaignShopConfirmDetailController:OnHide()
  if self._spine then
    self._spine:DestroyCurrentSpine()
    self._spine = nil
  end
end

function UICampaignShopConfirmDetailController:BtnstarOnClick(go)
  self:ShowDialog("UIShopPetDetailController", self.goodsData:GetItemId())
end

function UICampaignShopConfirmDetailController:BtnbuyOnClick(go)
  if not ClientCampaignShop.CheckBuy(self.saleType, self.price) then
    if self.saleType == RoleAssetID.RoleAssetGlow then
      self:CloseDialog()
    end
    local tips = StringTable.Get("str_pay_item_not_enough")
    ToastManager.ShowToast(tips)
    return
  end
  local exchangeCmpt = self.goodsData.exchangeCmpt
  if exchangeCmpt then
    self:StartTask(function(TT)
      self:Lock("UICampaignShopConfirmDetailController:btnbuyOnClick")
      local res = AsyncRequestRes:New()
      local rewards = exchangeCmpt:HandleExchangeItem(TT, res, self.goodsData:GetGoodsId(), self.count)
      self:UnLock("UICampaignShopConfirmDetailController:btnbuyOnClick")
      if res:GetSucc() then
        if rewards and 0 < #rewards then
          local roleAsset = rewards[1]
          local assetList = rewards
          if self:GetModule(PetModule):IsPetID(roleAsset.assetid) then
            self:ShowDialog("UIPetObtain", assetList, function()
              GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
              self:ShowDialog("UIGetItemController", assetList, function()
                GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityShopBuySuccess, self.goodsData:GetGoodsId())
              end)
              self:CloseDialog()
            end)
          else
            self:ShowDialog("UIGetItemController", assetList, function()
              GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityShopBuySuccess, self.goodsData:GetGoodsId())
            end)
            self:CloseDialog()
          end
        else
          self:CloseDialog()
        end
      else
        if res:GetResult() == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE then
          GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityComponentCloseEvent, self._componentFullId)
        end
        local campaignModule = GameGlobal.GetModule(CampaignModule)
        campaignModule:CheckErrorCode(res:GetResult(), self._campaignId, function()
          GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityShopNeedRefresh, self._campaignId)
        end, nil)
        self:CloseDialog()
      end
    end, self)
  end
end

function UICampaignShopConfirmDetailController:SetCountPriceTxt()
  self.countFollowTxt:SetText(self.count)
  self.price = self.count * self.goodsData.costCount
  self.priceTxt:SetText(self.price)
  self:SetTextColor()
end

function UICampaignShopConfirmDetailController:MinOnClick(go)
  self.count = 1
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDecDown)
  self:SetCountPriceTxt()
end

function UICampaignShopConfirmDetailController:RemoveOnClick(go)
  if self.count > 1 then
    self.count = self.count - 1
  else
    self.count = 1
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDecDown)
  self:SetCountPriceTxt()
end

function UICampaignShopConfirmDetailController:AddOnClick(go)
  local ownMoney = ClientCampaignShop.GetMoney(self.saleType)
  local maxCount = math.floor(ownMoney / self.goodsData.costCount)
  if maxCount <= 0 then
    self.count = 1
  else
    self.count = self.count + 1
    if maxCount <= self.count then
      self.count = maxCount
    end
    if 0 <= self.remainCount and self.count >= self.remainCount then
      self.count = self.remainCount
    end
    if self.count >= MAX_COUNT then
      self.count = MAX_COUNT
    end
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAddUp)
  self:SetCountPriceTxt()
end

function UICampaignShopConfirmDetailController:MaxOnClick(go)
  local ownMoney = ClientCampaignShop.GetMoney(self.saleType)
  local maxCount = math.floor(ownMoney / self.goodsData.costCount)
  if maxCount <= 0 then
    maxCount = 1
  else
    if 0 <= self.remainCount and maxCount >= self.remainCount then
      maxCount = self.remainCount
    end
    if maxCount >= MAX_COUNT then
      maxCount = MAX_COUNT
    end
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAddUp)
  self.count = maxCount
  self:SetCountPriceTxt()
end

function UICampaignShopConfirmDetailController:BtnbgOnClick(go)
  self:CloseDialog()
end

function UICampaignShopConfirmDetailController:InitPlayerSpine()
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._spineGo = self:GetGameObject("spine")
  self._spine:LoadSpine("duya_spine_idle")
end
