_class("UISeasonSkinConfirmNormalController", UIController)
UISeasonSkinConfirmNormalController = UISeasonSkinConfirmNormalController

function UISeasonSkinConfirmNormalController:Constructor()
  self.atlas = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
  self.uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonSkinConfirmNormalController:LoadDataOnEnter(TT, res, uiParams)
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self._seasonId = uiParams and uiParams[1]
  self._component = uiParams and uiParams[2]
  self._info = uiParams and uiParams[3]
  self._buyCount = 1
  if self._info == nil then
    Log.error("UISeasonExchangeConfirm:LoadDataOnEnter() param = nil")
    res:SetSucc(false)
    return
  end
end

function UISeasonSkinConfirmNormalController:OnShow(uiParams)
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self._currentCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self.nameTrans = self:GetUIComponent("Transform", "name")
  self.descTxt = self:GetUIComponent("UILocalizationText", "desc")
  self.descRect = self:GetUIComponent("RectTransform", "desc")
  self.btnStarGO = self:GetGameObject("btnstar")
  self.btnGo = self:GetGameObject("btnGo")
  self.moneyIcon = self:GetUIComponent("Image", "moneyicon")
  self.priceTxt = self:GetUIComponent("UILocalizationText", "price")
  self:Refresh()
end

function UISeasonSkinConfirmNormalController:SetTextColor()
  local ownMoney = self:_CalcHaveCount()
  if ownMoney >= self.saleShowPrice then
    self.priceTxt.color = Color.white
  else
    self.priceTxt.color = Color.red
  end
end

function UISeasonSkinConfirmNormalController:Refresh()
  local cfgItem = Cfg.cfg_item[self._info.m_reward.assetid]
  if not cfgItem then
    return
  end
  self.isPet = false
  self.saleShowPrice = self:GetSaleTypePrice()
  local itemId = cfgItem.ID
  local icon = cfgItem.Icon
  self.icon:LoadImage(icon)
  self.nameTxt:SetText(StringTable.Get(cfgItem.Name))
  local itemCount = 0
  if self.isPet then
    if self:GetModule(PetModule):GetPetByTemplateId(itemId) ~= nil then
      itemCount = 1
    end
  else
    itemCount = self:GetModule(ItemModule):GetItemCount(itemId)
  end
  self._currentCount:SetText(StringTable.Get("str_shop_current_item_count", itemCount))
  self.descTxt:SetText(StringTable.Get(cfgItem.Intro))
  self.priceTxt:SetText(self.saleShowPrice)
  self:SetTextColor()
  local itemId = self._component:GetCostItemId(self._info.m_is_special)
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  self.moneyIcon.sprite = self.uiCommonAtlas:GetSprite(spriteName)
  if self.isPet then
    self.btnStarGO:SetActive(true)
    self.btnGo:SetActive(true)
  else
    self.btnStarGO:SetActive(false)
    self.btnGo:SetActive(false)
  end
  self:DoAnimation()
end

function UISeasonSkinConfirmNormalController:GetSaleTypePrice()
  return self._info.m_cost_count
end

function UISeasonSkinConfirmNormalController:DoAnimation()
  self._cg = self:GetUIComponent("CanvasGroup", "UICanvas")
  self._panel = self:GetUIComponent("RectTransform", "panel")
  self._infoTrans = self:GetUIComponent("Transform", "info")
  self._cg.alpha = 0
  self:Lock("UISeasonSkinConfirmNormalController:DoAnimation")
  self:StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    self._cg:DOFade(1, 0.3)
    GameGlobal.Timer():AddEvent(400, function()
      self:UnLock("UISeasonSkinConfirmNormalController:DoAnimation")
    end)
  end, self)
end

function UISeasonSkinConfirmNormalController:_CalcHaveCount()
  local itemId = self._info.m_cost_item_id
  local itemModule = GameGlobal.GetModule(ItemModule)
  local haveCount = itemModule:GetItemCount(itemId)
  return haveCount
end

function UISeasonSkinConfirmNormalController:_CalcTotalPrice(buyCount)
  local price = self._info.m_cost_count
  local total = price * buyCount
  return total
end

function UISeasonSkinConfirmNormalController:_CheckCoinEnough(buyCount)
  local haveCount = self:_CalcHaveCount()
  local total = self:_CalcTotalPrice(buyCount)
  return haveCount >= total
end

function UISeasonSkinConfirmNormalController:_OnReceiveRewards(res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    self:CloseDialog()
    UISeasonHelper.ShowUIGetRewards(rewards)
  else
    self._seasonModule:CheckErrorCode(res.m_result, self._seasonId)
  end
end

function UISeasonSkinConfirmNormalController:OnHide()
end

function UISeasonSkinConfirmNormalController:btnstarOnClick(go)
  self:ShowDialog("UIShopPetDetailController", self.goodData:GetItemId())
end

function UISeasonSkinConfirmNormalController:btnbuyOnClick(go)
  if self:_CheckCoinEnough(self._buyCount) then
    local id = self._info.m_id
    local count = self._buyCount
    self._component:Start_HandleExchangeItem(id, count, function(res, rewards)
      self:_OnReceiveRewards(res, rewards)
    end)
  else
    ToastManager.ShowToast(StringTable.Get("str_pay_item_not_enough"))
  end
end

function UISeasonSkinConfirmNormalController:btnbgOnClick(go)
  self:CloseDialog()
end
