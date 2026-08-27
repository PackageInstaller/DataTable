local UINShopRefreshNode = class("UINShopRefreshNode", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINShopRefreshNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.OnRefreshBtnClick)
  self._RefreshCallback = BindCallback(self, self.RefreshCallback)
  self.__UpdateTime = BindCallback(self, self.UpdateTime)
end

function UINShopRefreshNode:HeadBarCommonInit(uiShop)
  self.OpenShopePageCallback = uiShop.__OnClickRefreshShop
  self.shopCtrl = uiShop.shopCtrl
end

function UINShopRefreshNode:RefreshHeadBarNode(shopData, shopCfg)
  self.ui.obj_refresh:SetActive(false)
  self:RefreshNodeByCfg(shopCfg)
  if shopData == nil then
    return
  end
  if not shopData:GetIsHaveRefresh() then
    return
  end
  self.ui.obj_refresh:SetActive(true)
  self:InitRefreshNode(shopData)
end

function UINShopRefreshNode:InitRefreshNode(shopData)
  self.shopData = shopData
  self.ui.btn_Refresh.gameObject:SetActive(true)
  self.ui.tex_CashNum.gameObject:SetActive(shopData.couldFresh)
  self.ui.img_CashIcon.gameObject:SetActive(shopData.couldFresh)
  self.ui.tex_limit:SetActive(not shopData.couldFresh)
  if shopData.couldFresh then
    self.cost = shopData.refreshCost
    self.costItemCfg = ConfigData.item[self.cost.costId]
    local costNum = self.cost.costNum
    self.ui.tex_CashNum.text = costNum
    local smallIcon = self.costItemCfg.small_icon
    self.ui.img_CashIcon.sprite = CRH:GetSprite(smallIcon)
    self.ui.text_Count:SetIndex(0, tostring(shopData.freshCount), tostring(shopData.couldFreshCount))
  else
    self.ui.text_Count:SetIndex(0, tostring(shopData.couldFreshCount), tostring(shopData.couldFreshCount))
  end
  self.shopCtrl:AddShopTimerCallback(self.__UpdateTime, "RefreshNode")
  self:UpdateTime()
end

function UINShopRefreshNode:RefreshNodeByCfg(shopCfg)
  if shopCfg == nil then
    self.ui.tex_Adv:SetIndex(0)
    return
  end
  local desId = shopCfg.info_des
  if desId == 0 then
    self.ui.tex_Adv:SetIndex(0)
    return
  end
  local desTxt = ConfigData.shop_des[desId].info_des
  self.ui.tex_Adv:SetIndex(1, LanguageUtil.GetLocaleText(desTxt))
end

function UINShopRefreshNode:UpdateTime()
  local time = self.shopData:GetRemainAutoRefreshTime()
  local d, h, m, s = TimeUtil:TimestampToTimeInter(time, false, true)
  local hStr = 10 <= h and tostring(h) or "0" .. tostring(h)
  local mStr = 10 <= m and tostring(m) or "0" .. tostring(m)
  local sStr = 10 <= s and tostring(s) or "0" .. tostring(s)
  if 0 < d then
    self.ui.tex_Timer:SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    self.ui.tex_Timer:SetIndex(1, hStr, mStr, sStr)
  end
  if time < -1 then
    self.shopCtrl:ReqShopDetail(self.shopData.shopId, self._RefreshCallback)
    self.shopCtrl:RemoveShopTimerCallback(self.__UpdateTime)
  end
end

function UINShopRefreshNode:OnRefreshBtnClick()
  if not self.shopData.couldFresh then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Shop_CanNotRefresh_RefreshCountInsufficient))
    return
  end
  local msg = ConfigData:GetTipContent(328, self.cost.costNum, LanguageUtil.GetLocaleText(self.costItemCfg.name))
  if self._refreshShopFunc == nil then
    self._refreshShopFunc = BindCallback(self, self._RefreshShop)
  end
  if PlayerDataCenter.cacheSaveData:GetEnableShopRefreshExecuteConfirm() then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    window:ShowTextBoxWithYesAndNo(msg, self._refreshShopFunc)
    window:ShowDontRemindTog(function(isOn)
      PlayerDataCenter.cacheSaveData:SetEnableShopRefreshExecuteConfirm(not isOn)
    end)
  else
    self._refreshShopFunc()
  end
end

function UINShopRefreshNode:_RefreshShop()
  local function buyFunc()
    self.shopCtrl:RemoveShopTimerCallback(self.__UpdateTime)
    
    local win = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
    if win ~= nil then
      win:SlideOut()
    end
    self.shopCtrl:ReqRefreshShopDetail(self.shopData.shopId, self._RefreshCallback)
  end
  
  local ownNum = PlayerDataCenter:GetItemCount(self.cost.costId)
  if ownNum >= self.cost.costNum then
    buyFunc()
  else
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    if not payCtrl:TryConvertPayItem(self.cost.costId, self.cost.costNum - ownNum, nil, nil, buyFunc) then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(string.format(ConfigData:GetTipContent(TipContent.Shop_CanNotRefresh_LackOfItem), LanguageUtil.GetLocaleText(self.costItemCfg.name)))
    end
  end
end

function UINShopRefreshNode:RefreshCallback()
  self:_TryHideShowMessageCommon(function()
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(329))
  end)
  if self.OpenShopePageCallback ~= nil then
    local win = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
    if win ~= nil then
      win:SlideOut()
    end
    self.OpenShopePageCallback(self.shopData.shopId)
  end
end

function UINShopRefreshNode:_TryHideShowMessageCommon(Func)
  local window = UIManager:GetWindow(UIWindowTypeID.MessageCommon)
  if window ~= nil and window.active then
    window:Hide()
    if Func ~= nil then
      Func()
    end
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(329))
  end
end

function UINShopRefreshNode:OnHide()
  self.shopCtrl:RemoveShopTimerCallback(self.__UpdateTime)
  self:_TryHideShowMessageCommon()
  base.OnHide(self)
end

function UINShopRefreshNode:OnDelete()
  base.OnDelete(self)
end

return UINShopRefreshNode
