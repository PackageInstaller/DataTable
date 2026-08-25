local UIAnimationController = CS.Z1Client.UIAnimationController
local SummonedAwakerItem, Super = System.NewComponent("SummonedAwakerItem")
local GainItemType = {
  Awaker = "Awaker",
  Weapon = "Weapon",
  AwakerClip = "AwakerChip"
}

function SummonedAwakerItem:ctor(uiNode, itemData, awakerFragmentCount)
  Super.ctor(self)
  self.ui = UI_Summon_Item_Total_ShowResource(uiNode)
  self.tid = itemData.tid
  self.uid = itemData.uid
  self.itemData = itemData
  self.awakerFragmentCount = awakerFragmentCount
  self.cfg = DT.Item[self.tid]
  self.type = self:InitType(self.cfg.Type)
end

function SummonedAwakerItem:OnBind(binder)
  self.binder = binder
  self.ui.Group_Fragment:SetActive(false)
  self.ui.Image_Label:SetActive(false)
  self.ui.Text_Fragment_Number_1:SetActive(false)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.itemData.autoRefineInfo then
      ItemDataUtils.ShowItemDetailTips(binder, self.ui.uiNode, self.itemData.autoRefineInfo.targetUid, self.tid)
    else
      ItemDataUtils.ShowItemDetailTips(binder, self.ui.uiNode, self.uid, self.tid)
    end
  end)
  binder:BindToText(self.ui.Text_Name, function()
    return self.cfg.Name
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    local quality = self.cfg.Quality
    return DT.ItemQuality[quality].SummonQualityBar
  end)
  binder:BindToImage(self.ui.Image_Quality_1, function()
    local quality = self.cfg.Quality
    return DT.ItemQuality[quality].SummonQualityColor
  end)
  binder:BindToVisible(self.ui.Image_Quality_1, function()
    local quality = self.cfg.Quality
    local color = DT.ItemQuality[quality].SummonQualityColor
    return nil ~= color
  end)
  binder:BindComponent(UICompRedDotNewVue(self.ui.RedPoint_New, RedDotDefine.DynamicRedDotID.DynamicFuncNew, function()
    return self.itemData.isNew
  end))
  binder:BindToRaw(function(childBinder, path)
    if "" ~= path then
      self.weaponPrefab = childBinder:BindComponent(AwakerWeaponPrefab(self.ui.Image_Weapon, path, 0.7))
      self.weaponPrefab:HideBorder()
    end
  end, function()
    if self.type == GainItemType.Weapon then
      return self.cfg.SpIcon
    end
    return ""
  end)
  binder:BindToVisible(self.ui.Image_Weapon, function()
    return self.type == GainItemType.Weapon
  end)
  if (self.type == GainItemType.Awaker or self.type == GainItemType.AwakerClip) and self.cfg.SpParam then
    local portraitAlign = CommonDefine.PortraitAlign.Center
    local awakerId = self.cfg.SpParam[1]
    binder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, awakerId, nil, nil, portraitAlign))
  end
  binder:BindToVisible(self.ui.Image_Awaker, function()
    return false
  end)
  binder:BindToImage(self.ui.Image_Career_Icon, function()
    if (self.type == GainItemType.Awaker or self.type == GainItemType.AwakerClip) and self.cfg.SpParam then
      local awakerCfg = DT.AwakerConfig[self.cfg.SpParam[1]]
      return DT.SchoolConfig[awakerCfg.School].Icon
    end
    return ""
  end)
  binder:BindToVisible(self.ui.Image_Career_Icon, function()
    return self.type == GainItemType.Awaker or self.type == GainItemType.AwakerClip
  end)
  binder:BindToText(self.ui.Text_Label, function()
    local rst = LT.Text("ConvertedToFragment")
    if self:NeedShowAutoRefine() then
      rst = LT.Text("WeaponRefined_02")
    end
    return rst
  end)
  self:_RefreshMultipleInfo()
end

function SummonedAwakerItem:_RefreshMultipleInfo()
  local isMultiple = self.itemData.isMultipleReward == true
  self.binder:SetActive(self.ui.Group_Multiple, isMultiple)
  if not isMultiple then
    return
  end
  self.binder:SetText(self.ui.Text_Multiple, LT.Text("SummonTripleLabel"))
end

function SummonedAwakerItem:HideText_Label(bShow)
  self.ui.Text_Label:SetActive(bShow)
end

function SummonedAwakerItem:_DisplayAutoRefine()
  local refineInfo = self.itemData.displayAutoRefineInfo or self.itemData.autoRefineInfo
  self.binder:SetActive(self.ui.Group_AutoRefine, nil ~= refineInfo)
  if not refineInfo then
    return
  end
  self.binder:SetActive(self.ui.Image_Label, true)
  self.binder:SetText(self.ui.Image_Label, LT.Text("WeaponRefined_02"))
  local stars = {
    self.ui.Star_1,
    self.ui.Star_2,
    self.ui.Star_3,
    self.ui.Star_4
  }
  UIUtils.SetWeaponStar(self.binder, stars, refineInfo.targetLevel)
end

function SummonedAwakerItem:InitType(type)
  local returnType
  if type == CommonDefine.ItemType.Weapon then
    returnType = GainItemType.Weapon
  elseif type == CommonDefine.ItemType.AwakerItem or type == CommonDefine.ItemType.Awaker then
    if self.itemData.displayAwakerClip then
      returnType = GainItemType.AwakerClip
    elseif self.itemData.isNew then
      returnType = GainItemType.Awaker
    else
      returnType = GainItemType.AwakerClip
    end
  end
  return returnType
end

function SummonedAwakerItem:NeedShowFX()
  return self.cfg.Quality == CommonDefine.CommonQuality.Purple or self.cfg.Quality == CommonDefine.CommonQuality.Orange
end

function SummonedAwakerItem:ShowFX(delayTime)
  self.fxTimerID = TimerManager.Instance:CreateTimer(delayTime, 0, nil, function()
    if self.cfg.Quality == CommonDefine.CommonQuality.Purple then
      self.ui.UI_Vx_Summon_Panel_SRLoop02:SetActive(true)
      self.ui.UI_Vx_Summon_Panel_SRLoop01:SetActive(true)
    elseif self.cfg.Quality == CommonDefine.CommonQuality.Orange then
      self.ui.UI_Vx_Summon_Panel_SSRLoop02:SetActive(true)
      self.ui.UI_Vx_Summon_Panel_SSRLoop01:SetActive(true)
    end
    local soundID = CommonDefine.SummonSoundID.ShowHighlight[self.cfg.Quality]
    if soundID then
      AudioManager.Instance:PostSoundEvent(soundID)
    end
    if self.weaponPrefab then
      self.weaponPrefab:PlayAnim("UV_Vx_Weapon_Full_Open")
    end
    self.fxTimerID = nil
  end)
end

function SummonedAwakerItem:NeedShowClip()
  return self:NeedShowAwakerClip() or self:NeedAutoDecomposeClip() or self:NeedShowAutoRefine()
end

function SummonedAwakerItem:ShowClip(delayTime)
  self.clipTimerID = TimerManager.Instance:CreateTimer(delayTime, 0, nil, function()
    self.ui.Group_Fragment:SetActive(true)
    self.ui.Image_Label:SetActive(true)
    if self:NeedShowAwakerClip() then
      self:ShowAwakerClip()
    elseif self:NeedAutoDecomposeClip() then
      self:ShowAutoDecomposeClip()
    elseif self:NeedShowAutoRefine() then
      self:_DisplayAutoRefine()
    end
  end)
end

local IgnoreItemTidList = {
  cd.CurrencyType.SummonGiftMoney,
  DT.GetConstant("PrimalSoulCoreItem")
}

function SummonedAwakerItem:ShowAwakerClip()
  local extraItems = table.clone(self.itemData.extraItems or {})
  for i = #extraItems, 1, -1 do
    local extraInfo = extraItems[i]
    if table.contains(IgnoreItemTidList, extraInfo.tid) then
      table.remove(extraItems, i)
    end
  end
  local imageObjs = {
    self.ui.Image_Awaker_Head_1,
    self.ui.Image_Awaker_Head_2
  }
  local textObjs = {
    self.ui.Text_Fragment_Number_1,
    self.ui.Text_Fragment_Number_2
  }
  for i, imageObj in ipairs(imageObjs) do
    local extraInfo = extraItems[i]
    local textObj = textObjs[i]
    if extraInfo and extraInfo.tid and extraInfo.changedNum then
      self.binder:SetActive(imageObj, true)
      self.binder:SetImage(imageObj, ItemDataUtils.GetIcon(extraInfo.tid))
      if textObj then
        self.binder:SetText(textObj, ItemNumUtils.GetStr(extraInfo.changedNum))
        self.binder:SetActive(textObj, true)
      end
    else
      self.binder:SetActive(imageObj, false)
      if textObj then
        self.binder:SetText(textObj, "")
      end
    end
  end
  self.uiAnimController:PlayMultiState("UI_Summon_Item_Total_Show_Group_Fragment_Open", nil, 1, false)
  local soundID = CommonDefine.SummonSoundID.ShowFragment
  if soundID then
    AudioManager.Instance:PostSoundEvent(soundID)
  end
  self.clipTimerID = nil
end

function SummonedAwakerItem:ShowAutoDecomposeClip()
  local showItem = self:GetAutoDecomposedItem()
  if #showItem > 2 then
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Group_FragmentHead.transform, -32, 7)
  else
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Group_FragmentHead.transform, 0, 7)
  end
  for idx = 1, 3 do
    local imageObj = self.ui["Image_Awaker_Head_" .. idx]
    local textObj = self.ui["Text_Fragment_Number_" .. idx]
    local extraInfo = showItem[idx]
    if extraInfo and extraInfo.tid and extraInfo.changedNum then
      self.binder:SetActive(imageObj, true)
      self.binder:SetImage(imageObj, ItemDataUtils.GetIcon(extraInfo.tid))
      if textObj then
        self.binder:SetText(textObj, ItemNumUtils.GetStr(extraInfo.changedNum))
        self.binder:SetActive(textObj, true)
      end
    else
      self.binder:SetActive(imageObj, false)
      if textObj then
        self.binder:SetText(textObj, "")
      end
    end
  end
  self.uiAnimController:PlayMultiState("UI_Summon_Item_Total_Show_Group_Fragment_Open", nil, 1, false)
end

function SummonedAwakerItem:NeedShowAwakerClip()
  if self.type == GainItemType.AwakerClip or self.itemData.displayAwakerClip == true then
    return true
  end
  if self.type ~= GainItemType.Awaker then
    return false
  end
  local extraItems = self.itemData.extraItems or {}
  for _, extraInfo in pairs(extraItems) do
    local showCount = extraInfo and (extraInfo.changedNum or extraInfo.num or extraInfo.count)
    if extraInfo and extraInfo.tid and showCount and showCount > 0 and not table.contains(IgnoreItemTidList, extraInfo.tid) then
      return true
    end
  end
  return false
end

function SummonedAwakerItem:NeedAutoDecomposeClip()
  do return self.GetAutoDecomposedCoin end
  return self.GetAutoDecomposedCoin, self
end

function SummonedAwakerItem:NeedShowAutoRefine()
  return (self.itemData.displayAutoRefineInfo or self.itemData.autoRefineInfo) ~= nil
end

function SummonedAwakerItem:OnUnbind()
  Super.OnUnbind(self)
  if self.fxTimerID then
    TimerManager.Instance:StopTimer(self.fxTimerID)
  end
  if self.clipTimerID then
    TimerManager.Instance:StopTimer(self.clipTimerID)
  end
end

function SummonedAwakerItem:GetAutoDecomposedCoin()
  for _, extraItem in pairs(self.itemData.extraItems) do
    if extraItem.reason == "AutoDecompose" and extraItem.tid == cd.CurrencyType.JuniorMoney then
      return extraItem
    end
  end
end

function SummonedAwakerItem:GetAutoDecomposedItem()
  local rstGroup = {}
  for _, extraItem in pairs(self.itemData.extraItems) do
    if extraItem.reason == "AutoDecompose" then
      table.insert(rstGroup, extraItem)
    end
  end
  return rstGroup
end

return SummonedAwakerItem
