_class("UIHomelandSaleAndUseWithCount", UIController)
UIHomelandSaleAndUseWithCount = UIHomelandSaleAndUseWithCount

function UIHomelandSaleAndUseWithCount:Constructor()
  self.curCount = 1
end

function UIHomelandSaleAndUseWithCount:OnShow(uiParams)
  self.item = uiParams[1]
  self.openType = uiParams[2]
  self.callBack = uiParams[3]
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.txtOwnCount = self:GetUIComponent("UILocalizationText", "txtOwnCount")
  self.txtLeftCount = self:GetUIComponent("UILocalizationText", "txtLeftCount")
  self.sldCount = self:GetUIComponent("Slider", "sldCount")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.txtSaleMoney = self:GetUIComponent("UILocalizationText", "txtSaleMoney")
  self.sale = self:GetGameObject("sale")
  self.use = self:GetGameObject("use")
  
  function self.OnSldCountValueChange(value)
    self:SetCurCount(value)
    self:Flush()
  end
  
  self.sldCount.onValueChanged:AddListener(self.OnSldCountValueChange)
  self.sldCount.value = self.curCount
end

function UIHomelandSaleAndUseWithCount:OnHide()
  self.sldCount.onValueChanged:RemoveListener(self.OnSldCountValueChange)
end

function UIHomelandSaleAndUseWithCount:SetCurCount(curCount)
  self.curCount, _ = math.modf(curCount)
end

function UIHomelandSaleAndUseWithCount:Flush()
  local tpl = self.item:GetTemplate()
  local count = self.item:GetCount()
  self.icon:LoadImage(tpl.Icon)
  self.txtName:SetText(StringTable.Get(tpl.Name))
  local max = self:GetMaxLimitCount()
  self.sldCount.maxValue = math.min(count, max)
  self.txtCount:SetText(self.curCount)
  self.txtOwnCount:SetText(count)
  self.txtLeftCount:SetText(count - self.curCount)
  if self.openType == EnumItemSaleAndUseState.Sale then
    self:FlushSale()
  else
    self:FlushUse()
  end
  self:SetInputText()
end

function UIHomelandSaleAndUseWithCount:FlushSale()
  self.use:SetActive(false)
end

function UIHomelandSaleAndUseWithCount:FlushUse()
  self.sale:SetActive(false)
end

function UIHomelandSaleAndUseWithCount:SetInputText()
  local tpl = self.item:GetTemplate()
  local itemCount = self.item:GetCount()
  if self.curCount < 1 then
    self.curCount = 1
  elseif itemCount < self.curCount then
    self.curCount = itemCount
  end
  if self.openType == EnumItemSaleAndUseState.Sale then
    local allPrice
    local itemPerPiece = tpl.SaleGold
    if self.curCount * itemPerPiece > 99999999 then
      allPrice = "9999" .. StringTable.Get("str_item_public_unit")
    else
      allPrice = tostring(self.curCount * itemPerPiece)
    end
    self.txtSaleMoney:SetText(tostring(allPrice))
  end
end

function UIHomelandSaleAndUseWithCount:GetMaxLimitCount()
  local itemData = self.item:GetTemplate()
  local nMaxLimitCount = 99
  if itemData.UseEffect == "PhyGift" then
    nMaxLimitCount = 1
    local roleModule = self:GetModule(RoleModule)
    local itemModule = self:GetModule(ItemModule)
    local nPhyData = roleModule:GetHealthPoint()
    local cfgRoleLevel = Cfg.cfg_role_level[roleModule:GetLevel()]
    if cfgRoleLevel then
      local nPhyMaxLevel = cfgRoleLevel.TotalMaxPhyPoint or 100
      local nPhyMaxLimit = Cfg.cfg_global.role_phy_max_limit.IntValue or 999
      local nPhyMax = 0
      if nPhyMaxLevel < nPhyMaxLimit then
        nPhyMax = nPhyMaxLevel
      else
        nPhyMax = nPhyMaxLimit
      end
      if nPhyData < nPhyMax then
        local nPhyEffect = itemModule:GetPhyGiftData(itemData.ID)
        if 0 < nPhyEffect then
          local nMaxCount = (nPhyMax - nPhyData) / nPhyEffect
          nMaxLimitCount = math.floor(nMaxCount)
        end
      end
    end
  end
  return nMaxLimitCount
end

function UIHomelandSaleAndUseWithCount:bgOnClick()
  self:ClosePanel()
end

function UIHomelandSaleAndUseWithCount:btnCloseOnClick()
  self:ClosePanel()
end

function UIHomelandSaleAndUseWithCount:btnAddOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self.curCount < self.sldCount.maxValue then
    self:SetCurCount(self.curCount + 1)
    self.sldCount.value = self.curCount
  end
end

function UIHomelandSaleAndUseWithCount:btnSubOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self.curCount > 1 then
    self:SetCurCount(self.curCount - 1)
    self.sldCount.value = self.curCount
  end
end

function UIHomelandSaleAndUseWithCount:btnSaleOnClick()
  if self.curCount ~= 0 then
    self.callBack(self.item, self.curCount)
  end
end

function UIHomelandSaleAndUseWithCount:btnUseOnClick()
  if self.curCount ~= 0 then
    self.callBack(self.item, self.curCount)
  end
  self:ClosePanel()
end

function UIHomelandSaleAndUseWithCount:ClosePanel()
  self:CloseDialog()
end
