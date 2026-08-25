local SummonAwakerWeaponItem, Super = System.NewComponent("SummonAwakerWeaponItem")
SummonAwakerWeaponItem.uiResCls = UI_Summon_Item_AwakerWeaponResource

function SummonAwakerWeaponItem:ctor(uiNode)
  Super.ctor(self)
  self.ui = SummonAwakerWeaponItem.uiResCls(uiNode)
end

function SummonAwakerWeaponItem:OnBind(binder)
  self.binder = binder
end

function SummonAwakerWeaponItem:RefreshView(itemTid, firstRefresh)
  self._itemTid = itemTid
  self.binder:SetActive(self.ui.UI_Vx_Switch, false)
  local delay = 0.3
  if firstRefresh then
    delay = 0
    self.binder:SetActive(self.ui.AwakerCon, false)
    self.binder:SetActive(self.ui.WeaponCon, false)
  else
    self.binder:SetActive(self.ui.UI_Vx_Switch, true)
    self.binder:SetActive(self.ui.Btn_Click, false)
  end
  self.binder:BindTimer(delay, 0, nil, function()
    self.binder:SetActive(self.ui.Btn_Click, true)
    local itemType = ItemCfgUtils.GetCfgField("Type", self._itemTid)
    if itemType == CommonDefine.ItemType.AwakerItem then
      self:_RefreshAwaker()
      self.binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self._OnClickAwaker))
    elseif itemType == CommonDefine.ItemType.Weapon then
      self:_RefreshWeapon()
      self.binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self._OnClickWeapon))
    end
  end)
end

function SummonAwakerWeaponItem:_RefreshAwaker()
  self.binder:SetActive(self.ui.Image_Career, true)
  self.binder:SetActive(self.ui.AwakerCon, true)
  self.binder:SetActive(self.ui.WeaponCon, false)
  local awakerTid = ItemCfgUtils.GetItemAwakerTid(self._itemTid)
  if not awakerTid then
    return
  end
  local schoolIcon = AwakerCfgUtils.GetAwakerSchoolIcon(awakerTid)
  if schoolIcon then
    self.binder:SetImage(self.ui.Image_Career, schoolIcon)
  end
  if not self._awakerPortraitComp then
    local portraitAlign = CommonDefine.PortraitAlign.Center
    self._awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.AwakerCon, awakerTid, nil, nil, portraitAlign))
  else
    self._awakerPortraitComp:ChangeAwakerTid(awakerTid)
  end
end

function SummonAwakerWeaponItem:_RefreshWeapon()
  self.binder:SetActive(self.ui.Image_Career, false)
  self.binder:SetActive(self.ui.AwakerCon, false)
  self.binder:SetActive(self.ui.WeaponCon, true)
  local weaponTid = self._itemTid
  local weaponSpIcon = ItemDataUtils.GetSpIcon(weaponTid)
  if self._weaponPrefab then
    self._weaponPrefab.binder:teardown()
  end
  self._weaponPrefab = self.binder:BindComponent(AwakerWeaponPrefab(self.ui.WeaponCon, weaponSpIcon, 1))
end

function SummonAwakerWeaponItem:_OnClickAwaker()
  local awakerTid = ItemCfgUtils.GetItemAwakerTid(self._itemTid)
  if not awakerTid then
    return
  end
  
  local function panelOpenFunc()
    local awakerBasePanelData = {}
    awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
    awakerBasePanelData.specialAwakerList = {
      AwakerDataUtils.GetAwakerData(awakerTid)
    }
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end
  
  FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
end

function SummonAwakerWeaponItem:_OnClickWeapon()
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, self._itemTid)
end

return SummonAwakerWeaponItem
