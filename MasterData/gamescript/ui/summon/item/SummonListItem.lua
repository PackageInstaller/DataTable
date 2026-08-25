local SummonListItem, Super = System.NewComponent("SummonListItem")

function SummonListItem:ctor(uiNode, showPoolData, clickCb, redCb, model)
  Super.ctor(self)
  self.ui = UI_Summon_Item_ListResource(uiNode)
  self.showPoolData = showPoolData
  self.poolTidList = showPoolData.poolTidList
  self.clickCb = clickCb
  self.redCb = redCb
  self.firstPoolId = showPoolData.poolTidList[1]
  self.firstPoolCfg = SummonDataUtils.GetSummonConfig(self.firstPoolId)
  self.model = model
end

function SummonListItem:OnBind(binder)
  self.binder = binder
  local isLuckyBagPool = SummonDataUtils.IsLuckyBagPool(self.firstPoolId)
  binder:BindToVisible(self.ui.UI_Vx_Common_Goods_Select_04, System.fn(self, self.IsSelected))
  binder:BindToVisible(self.ui.Image_Select, System.fn(self, self.IsSelected))
  if self.ui.Image_Mask_UnSelect then
    self.ui.Image_Mask_UnSelect:SetActive(false)
  end
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnButtonCLick))
  binder:BindToText(self.ui.Text_Name, function()
    do return self.GetPoolTitle end
    return self.GetPoolTitle, self
  end)
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name, 0, 0, 0, nil, true)
  if comp then
    comp:SetBtn(self.ui.Btn_Click)
  end
  binder:BindToTextColor(self.ui.Text_Name, function()
    return self:IsSelected() and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
  end)
  binder:BindToImage(self.ui.Image_D_Image, function()
    return self.firstPoolCfg.ListImage
  end)
  binder:BindToImage(self.ui.Image_Novice_Dark, function()
    return self.firstPoolCfg.ListBackgroundImage
  end)
  binder:BindToImage(self.ui.Image_Novice_Light, function()
    return self.firstPoolCfg.ListBackgroundImage
  end)
  binder:BindToImage(self.ui.Image_Mask_UnSelect, function()
    return self.firstPoolCfg.ListBGImageUnSelect
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, function()
    do return end
    return self.redCb, nil
  end))
  if SummonDataUtils.CheckDiscountSummon(self.firstPoolId) then
    binder:BindToVisible(self.ui.Com_RedDot, function()
      local playerStatsType = SummonDataUtils.GetRedTypeByPoolId(self.firstPoolId)
      return RedPointDataUtils.GetRedPointState(playerStatsType) == false
    end)
    binder:UpdateLocalizedTextAndResouce(self.ui.UI_Common_Item_Hint)
    binder:BindToVisible(self.ui.UI_Common_Item_Hint, function()
      local playerStatsType = SummonDataUtils.GetRedTypeByPoolId(self.firstPoolId)
      if isLuckyBagPool then
        return RedPointDataUtils.GetRedPointState(playerStatsType) == false and SummonDataUtils.CheckPoolListItemIsHint(self.poolTidList)
      else
        return RedPointDataUtils.GetRedPointState(playerStatsType) ~= false
      end
    end)
  elseif isLuckyBagPool then
    binder:BindToVisible(self.ui.UI_Common_Item_Hint, function()
      do return SummonDataUtils.CheckPoolListItemIsHint end
      return SummonDataUtils.CheckPoolListItemIsHint, self.poolTidList
    end)
    binder:BindToText(self.ui.Text_C_Recommend, function()
      do return LT.Text end
      return LT.Text, "LuckyBagRedDotText"
    end)
  else
    binder:SetActive(self.ui.UI_Common_Item_Hint, false)
  end
  binder:BindToVisible(self.ui.Image_Novice_Light, function()
    do return self.IsSelected end
    return self.IsSelected, self
  end)
  binder:BindToVisible(self.ui.Image_Novice_Dark, function()
    return not self:IsSelected()
  end)
  binder:BindToRaw(function()
    local spriteComp = AddLuaCompOnce(self.ui.Image_Novice_Dark, LuaUISprite2TexTexcoord)
    if spriteComp then
      spriteComp:Update()
    end
  end, function()
    return not self:IsSelected()
  end)
  if self.firstPoolCfg.Type == cd.SummonPoolType.NewbiePool then
    NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_NormalSummonBtn", self.ui.Guide_Image, Urls.SummonPanel)
  end
end

function SummonListItem:IsSelected()
  local selectedPoolCfg = SummonDataUtils.GetSummonConfig(self.model.curPoolId)
  if selectedPoolCfg.Type == cd.SummonPoolType.NormalAwaker and self.firstPoolCfg.Type == cd.SummonPoolType.NormalAwaker then
    local SummonCareerSelectList = DT.GetOriginalConstant("SummonCareerSelectList")
    do return table.contains, SummonCareerSelectList end
    return table.contains, SummonCareerSelectList, self.model.curPoolId
  end
  do return table.contains, self.poolTidList end
  return table.contains, self.poolTidList, self.model.curPoolId, self.model.curPoolId
end

function SummonListItem:GetPoolTitle()
  local groupId = self.showPoolData.poolGroupId
  if groupId then
    do return LT.Text end
    return LT.Text, "PoolGroupTitle_" .. groupId, groupId
  end
  return self.firstPoolCfg.Title
end

function SummonListItem:OnButtonCLick()
  if self.clickCb then
    local lastSelectedPoolId = SummonDataUtils.GetDefaultPoolTidByGroup(self.poolTidList)
    self.clickCb(lastSelectedPoolId)
  end
end

return SummonListItem
