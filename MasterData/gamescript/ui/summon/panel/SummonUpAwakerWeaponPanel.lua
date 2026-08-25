local SummonUpAwakerWeaponPanel, Super = System.NewClass("SummonUpAwakerWeaponPanel", UIBasePanel)
SummonUpAwakerWeaponPanel.uiResCls = UI_Summon_Popup_AwakerWeaponResource

function SummonUpAwakerWeaponPanel:ctor(summonPoolTid)
  self.summonPoolTid = summonPoolTid
  self.summonPoolType = DT.Summon[summonPoolTid] and DT.Summon[summonPoolTid].Type
end

function SummonUpAwakerWeaponPanel:OnBind(binder)
  self.binder = binder
  self:_BindEvent()
  self:_UpdateViewData()
  self:_RefreshView()
  CameraManager:SetUICameraModel(true)
end

function SummonUpAwakerWeaponPanel:OnUnbind()
  CameraManager:SetUICameraModel(false)
end

function SummonUpAwakerWeaponPanel:_BindEvent()
  self.binder:BindButtonClick(self.ui.Button_ChooseAwaker, System.fn(self, self._OnClickChooseAwaker))
  self.binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self.binder:BindEvent(EventMgr.Instance.OnSummonSelectAwakerUP, System.fn(self, self._OnSummonSelectAwakerUP))
end

function SummonUpAwakerWeaponPanel:_OnClickConfirm()
  SummonDataUtils.ReqChooseUpAwaker(self.summonPoolType, self.summonPoolTid, self._selectAwakerItemTid, System.fn(self, self.Close))
end

function SummonUpAwakerWeaponPanel:_OnClickChooseAwaker()
  local viewData = {
    poolTid = self.summonPoolTid,
    confirmFunc = System.fn(self, self._SetSelectAwakerItemTid),
    selectItemTid = SummonDataUtils.GetChooseUpSSRItemTid(self.summonPoolType, self.summonPoolTid)
  }
  UIManager.Instance:Reopen(Urls.SummonSelectAwakerPanel, viewData)
end

function SummonUpAwakerWeaponPanel:_OnSummonSelectAwakerUP()
  self:_UpdateViewData()
  self:_RefreshView()
end

function SummonUpAwakerWeaponPanel:_SetSelectAwakerItemTid(itemTid)
  self._selectAwakerItemTid = itemTid
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self._selectAwakerItemTid)
  self._selectWeapon = AwakerCfgUtils.GetFirstRecommendWeapon(awakerTid)
  self:_RefreshView()
end

function SummonUpAwakerWeaponPanel:_UpdateViewData()
  self._selectAwakerItemTid = SummonDataUtils.GetChooseUpSSRItemTid(self.summonPoolType, self.summonPoolTid)
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self._selectAwakerItemTid)
  self._selectWeapon = AwakerCfgUtils.GetFirstRecommendWeapon(awakerTid)
end

function SummonUpAwakerWeaponPanel:_RefreshView()
  self.binder:SetText(self.ui.Text_Desc, LT.Text("SummonSelectAwakePanelDesc"))
  self:_RefreshSelectAwaker()
  self:_RefreshSelectWeapon()
  self:_RefreshConfirmBtnState()
end

function SummonUpAwakerWeaponPanel:_RefreshSelectAwaker()
  self.ui.Btn_AwakerInfo:SetActive(self._selectAwakerItemTid)
  self.ui.Group_AwakerEmpty:SetActive(not self._selectAwakerItemTid)
  if self._selectAwakerItemTid then
    local portraitAlign = CommonDefine.PortraitAlign.Center
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self._selectAwakerItemTid)
    if not self.awakerPortraitComp then
      self.awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.AwakerCon, awakerTid, nil, nil, portraitAlign))
    else
      self.awakerPortraitComp:ChangeAwakerTid(awakerTid)
    end
    local ui = UI_Summon_Btn_JumpResource(self.ui.Btn_AwakerInfo)
    SummonUiUtils.RefreshAwakerJumpButtonInfo(self.binder, ui, false, awakerTid)
  end
end

function SummonUpAwakerWeaponPanel:_RefreshSelectWeapon()
  self.ui.Btn_WeaponInfo:SetActive(self._selectWeapon)
  self.ui.Group_WeaponEmpty:SetActive(not self._selectWeapon)
  if self._selectWeapon then
    local weaponSpIcon = ItemDataUtils.GetSpIcon(self._selectWeapon)
    if self.weaponPrefab then
      self.weaponPrefab:OnUnbind()
    end
    self.weaponPrefab = self.binder:BindComponent(AwakerWeaponPrefab(self.ui.WeaponCon, weaponSpIcon, 1))
    local ui = UI_Summon_Btn_JumpResource(self.ui.Btn_WeaponInfo)
    SummonUiUtils.RefreshWeaponJumpButtonInfo(self.binder, ui, false, self._selectWeapon)
  end
end

function SummonUpAwakerWeaponPanel:_RefreshConfirmBtnState()
  self.binder:BindZ1Button(self.ui.Btn_Confirm, function()
    if not self._selectAwakerItemTid then
      Alert.ShowStr(LT.Text("SummonSelectAwakerBtnUnClickTips"))
      return
    end
    local tipsTypeTid = 20169
    local tipsTypeCfg = DT.TipsType[tipsTypeTid]
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self._selectAwakerItemTid)
    local awakerName = LT.Text(AwakerCfgUtils.GetCfgField("Name", awakerTid))
    local weaponName = LT.Text(ItemDataUtils.GetItemName(self._selectWeapon))
    local desc = LT.Textf(tipsTypeCfg.Desc, awakerName, weaponName)
    Alert.Show(tipsTypeTid, nil, System.fn(self, self._OnClickConfirm), nil, desc)
  end, function()
    if not self._selectAwakerItemTid then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end)
end

return SummonUpAwakerWeaponPanel
