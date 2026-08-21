_class("UICampaignShopConfirmNormalController", UIController)
UICampaignShopConfirmNormalController = UICampaignShopConfirmNormalController

function UICampaignShopConfirmNormalController:Constructor()
  self.uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UICampaignShopConfirmNormalController:OnShow(uiParams)
  self:InitWidget(uiParams)
end

function UICampaignShopConfirmNormalController:InitWidget(uiParams)
  self.goodsData = uiParams[1]
  local cmptInfo = self.goodsData.exchangeCmpt:GetComponentInfo()
  self._campaignId = cmptInfo.m_campaign_id
  self._componentId = cmptInfo.m_component_id
  self._componentFullId = self.goodsData.exchangeCmpt:GetComponetCfgId(cmptInfo.m_campaign_id, cmptInfo.m_component_id)
  self.subTabType = uiParams[2]
  self.uiItem = self:GetUIComponent("RawImageLoader", "uiitem")
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self.nameTrans = self:GetUIComponent("Transform", "name")
  self.descTxt = self:GetUIComponent("UILocalizationText", "desc")
  self.descRect = self:GetUIComponent("RectTransform", "desc")
  self.descScroll = self:GetUIComponent("ScrollRect", "ContentPanel")
  self.btnGO = self:GetGameObject("btnGo")
  self._currentCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self.moneyIcon = self:GetUIComponent("Image", "moneyicon")
  self.priceTxt = self:GetUIComponent("UILocalizationText", "price")
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

function UICampaignShopConfirmNormalController:SetTextColor()
  local ownMoney = ClientCampaignShop.GetMoney(self.saleType)
  if ownMoney >= self.goodsData.costCount then
    self.priceTxt.color = Color.white
  else
    self.priceTxt.color = Color(1.0, 0.4, 0.3215686274509804, 1)
  end
end

function UICampaignShopConfirmNormalController:Refresh()
  if not self.goodsData then
    return
  end
  local cfgItem = Cfg.cfg_item[self.goodsData:GetItemId()]
  if not cfgItem then
    return
  end
  self.isPet = self.goodsData:IsPet()
  self.saleType = self.goodsData:GetSaleType()
  self.price = self.goodsData:GetSalePrice()
  local itemId = cfgItem.ID
  local icon = cfgItem.Icon
  local quality = cfgItem.Color
  local count = self.goodsData:GetItemCount()
  local text1 = count <= 1 and "" or StringTable.Get("str_shop_good_count") .. count
  self.uiItem:LoadImage(icon)
  self.nameTxt:SetText("「" .. StringTable.Get(cfgItem.Name) .. "」")
  self.descTxt:SetText(StringTable.Get(cfgItem.Intro))
  self.priceTxt:SetText(self.goodsData.costCount)
  self:SetTextColor()
  local itemCount = 0
  if self.isPet then
    if self:GetModule(PetModule):GetPetByTemplateId(itemId) ~= nil then
      itemCount = 1
    end
  else
    itemCount = self:GetModule(ItemModule):GetItemCount(itemId)
  end
  self._currentCount:SetText(StringTable.Get("str_shop_current_item_count", itemCount))
  self.moneyIcon.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(self.saleType))
  if self.isPet then
    self.btnGO:SetActive(true)
  else
    self.btnGO:SetActive(false)
  end
  self:DoAnimation()
  self:SetScroll()
end

function UICampaignShopConfirmNormalController:SetScroll()
  local perferredH = self.descTxt.preferredHeight
  if perferredH < 135 then
    self.descScroll.vertical = false
  else
    self.descScroll.vertical = true
  end
end

function UICampaignShopConfirmNormalController:DoAnimation()
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

function UICampaignShopConfirmNormalController:OnHide()
  if self._spine then
    self._spine:DestroyCurrentSpine()
    self._spine = nil
  end
end

function UICampaignShopConfirmNormalController:BtnstarOnClick(go)
  self:ShowDialog("UIShopPetDetailController", self.goodsData:GetItemId())
end

function UICampaignShopConfirmNormalController:BtnbuyOnClick(go)
  if not ClientCampaignShop.CheckBuy(self.saleType, self.goodsData.costCount) then
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
      self:Lock("UICampaignShopConfirmNormalController:btnbuyOnClick")
      local res = AsyncRequestRes:New()
      local rewards = exchangeCmpt:HandleExchangeItem(TT, res, self.goodsData:GetGoodsId(), 1)
      self:UnLock("UICampaignShopConfirmNormalController:btnbuyOnClick")
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
          elseif roleAsset.assetid > RoleAssetID.RoleAssetPetSkinBegin and roleAsset.assetid < RoleAssetID.RoleAssetPetSkinEnd then
            local skinID = roleAsset.assetid - RoleAssetID.RoleAssetPetSkinBegin
            local skin = RoleAsset:New()
            skin.assetid = skinID
            local unlockCgId
            local skinCfg = Cfg.cfg_pet_skin[skinID]
            if skinCfg then
              unlockCgId = skinCfg.ImmediateCgId
            end
            self:ShowDialog("UIPetSkinObtainController", skin, function()
              GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
              self:ShowDialog("UIGetItemController", rewards, function()
                if unlockCgId then
                  local cfg_cg = Cfg.cfg_cg_book[unlockCgId]
                  if cfg_cg then
                    self:ShowDialog("UIPetSkinsGetCgController", cfg_cg.StaticPic, false, skinID, 1)
                  end
                  ToastManager.ShowToast(StringTable.Get("str_senior_skin_draw_new_cg_tips"))
                end
                GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityShopBuySuccess, self.goodsData:GetGoodsId())
              end, true)
            end)
            self:CloseDialog()
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

function UICampaignShopConfirmNormalController:BtnbgOnClick(go)
  self:CloseDialog()
end

function UICampaignShopConfirmNormalController:InitPlayerSpine()
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._spineGo = self:GetGameObject("spine")
  self._spine:LoadSpine("duya_spine_idle")
end
