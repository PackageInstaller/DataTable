local ResonanceItem, Super = System.NewClass("ResonanceItem", UIBasePanel)
ResonanceItem.uiResCls = UI_Chaper_Item_Level_VibesResource

function ResonanceItem:ctor(uiNode, resonanceModel, resonanceConfig, showClick, view)
  Super.ctor(self)
  self.ui = UI_Chaper_Item_Level_VibesResource(uiNode)
  self.view = view
  self.resonanceConfig = resonanceConfig
  self.resonanceModel = resonanceModel
  self.showClick = showClick
end

function ResonanceItem:OnBind(binder)
  self.binder = binder
  self:BindResonanceIcon()
  self:BindResonanceState()
  self:BindRedPoint()
  self:BindResonanceSelected()
  binder:BindToText(self.ui.Text_Name, function()
    do return self.resonanceModel.GetResonanceLevelProgress, self.resonanceModel end
    return self.resonanceModel.GetResonanceLevelProgress, self.resonanceModel, self.resonanceConfig.ID
  end)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  binder:BindToVisible(self.ui.Group_Senior, function()
    return false
  end)
  binder:BindToRaw(function(_, resonanceType, _)
    local isElite = resonanceType == CommonDefine.ResonanceType.Elite
    local groupUnClickQualit = self.ui.Group_Unclickable.transform:Find("Image_Quality")
    local groupNormalQualit = self.ui.Group_Normal.transform:Find("Image_Quality")
    local groupHighQualit = self.ui.Group_High.transform:Find("Image_Quality")
    if groupUnClickQualit then
      groupUnClickQualit.gameObject:SetActive(isElite)
    end
    if groupNormalQualit then
      groupNormalQualit.gameObject:SetActive(isElite)
    end
    if groupHighQualit then
      groupHighQualit.gameObject:SetActive(isElite)
    end
    self.ui.bg_Normal_Square:SetActive(isElite)
    self.ui.bg_Normal_Circle:SetActive(not isElite)
    self.ui.bg_Click_Square:SetActive(isElite and self.showClick)
    self.ui.bg_Click_Circle:SetActive(not isElite and self.showClick)
    self.ui.bg_Unclickable_Square:SetActive(isElite)
    self.ui.bg_Unclickable_Circle:SetActive(not isElite)
    self.ui.bg_High_Square:SetActive(isElite)
    self.ui.bg_High_Circle:SetActive(not isElite)
  end, function()
    do return self.resonanceModel.GetResonanceType, self.resonanceModel end
    return self.resonanceModel.GetResonanceType, self.resonanceModel, self.resonanceConfig.ID
  end)
end

function ResonanceItem:BindResonanceSelected()
  self.binder:BindToVisible(self.ui.Group_Click, function()
    return self.resonanceModel.selectResonanceID == self.resonanceConfig.ID
  end)
end

function ResonanceItem:BindResonanceSelected()
  self.binder:BindToVisible(self.ui.Group_Click, function()
    return self.resonanceModel.selectResonanceID == self.resonanceConfig.ID
  end)
end

function ResonanceItem:BindResonanceSelected()
  self.binder:BindToVisible(self.ui.Group_Click, function()
    return self.resonanceModel.selectResonanceID == self.resonanceConfig.ID
  end)
end

function ResonanceItem:BindResonanceState()
  self.binder:BindToVisible(self.ui.Group_Unclickable, function()
    return not ResonanceDataUtils.IsResonanceUnLocked(self.resonanceConfig.ID)
  end)
  self.binder:BindToVisible(self.ui.Group_Normal, function()
    do return ResonanceDataUtils.IsResonanceActive end
    return ResonanceDataUtils.IsResonanceActive, self.resonanceConfig.ID
  end)
  self.binder:BindToVisible(self.ui.Group_High, function()
    return not ResonanceDataUtils.IsResonanceActive(self.resonanceConfig.ID) and ResonanceDataUtils.IsResonanceUnLocked(self.resonanceConfig.ID)
  end)
end

function ResonanceItem:BindResonanceIcon()
  self.binder:BindToImage(self.ui.Group_Unclickable_Icon, function()
    do return self.resonanceModel.GetResonanceUnlockIcon, self.resonanceModel end
    return self.resonanceModel.GetResonanceUnlockIcon, self.resonanceModel, self.resonanceConfig.ID
  end)
  self.binder:BindToImage(self.ui.Group_Normal_Icon, function()
    do return self.resonanceModel.GetResonanceIcon, self.resonanceModel end
    return self.resonanceModel.GetResonanceIcon, self.resonanceModel, self.resonanceConfig.ID
  end)
  self.binder:BindToImage(self.ui.Group_High_Icon, function()
    do return self.resonanceModel.GetResonanceUnactionIcon, self.resonanceModel end
    return self.resonanceModel.GetResonanceUnactionIcon, self.resonanceModel, self.resonanceConfig.ID
  end)
end

function ResonanceItem:BindRedPoint()
  if not self.view then
    return
  end
  self.view:AddRedPoint(self.ui.RedDot, RedDotDefine.DynamicRedDotID.ResonanceRedDot, {
    resonanceTid = self.resonanceConfig.ID,
    useExtraItem = false
  })
end

function ResonanceItem:OnClick()
  self.resonanceModel:SetSelectResonanceID(self.resonanceConfig.ID)
end

return ResonanceItem
