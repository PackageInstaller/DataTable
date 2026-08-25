local BattleKeeperSkillPanel, Super = System.NewClass("BattleKeeperSkillPanel", UIBasePanel)
BattleKeeperSkillPanel.uiResCls = UI_Battle_Popup_AngerResource

function BattleKeeperSkillPanel:ctor(roleInfo, fireSkillFunc)
  Super.ctor(self)
  self.roleInfo = roleInfo
  self.keeperSkillId = roleInfo.GetKeeperSkillId()
  self.fireSkillFunc = fireSkillFunc
  self.groupKeyWordShowed = Vue.ref(false)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleKeeperSkillPanel:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindToText(self.ui.Text_C_Title, function()
    do return LT.Text end
    return LT.Text, "KeeperSkillTitle"
  end)
  self.ui.Group_CD:SetActive(false)
  self:BindRoleInfo()
  self:BindConfirmGroup()
  self:BindSkillInfo()
end

function BattleKeeperSkillPanel:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function BattleKeeperSkillPanel:BindRoleInfo()
  self.binder:BindToImage(self.ui.Icon_Awaker, function()
    do return GenderDataUtils.GetBattleMainHeadRes end
    return GenderDataUtils.GetBattleMainHeadRes, self.roleInfo.gender
  end)
  self.binder:BindToText(self.ui.Text_Role, function()
    return self.roleInfo.name
  end)
end

function BattleKeeperSkillPanel:BindSkillInfo()
  self.binder:BindToText(self.ui.Text_Tips, function()
    do return KeeperSkillUtils.GetKeeperSkillDesc end
    return KeeperSkillUtils.GetKeeperSkillDesc, self.keeperSkillId
  end, nil, nil, nil)
  self.binder:BindToRaw(function(_, v, _)
    self.ui.Group_Keyword:SetActive(v)
    self.ui.Button_Keyword:SetActive(v)
  end, function()
    return self.groupKeyWordShowed.value
  end)
  self.binder:BindZ1Button(self.ui.Button_Keyword, function()
    self.groupKeyWordShowed.value = false
  end)
  self.binder:BindToText(self.ui.Text_Name, function()
    do return KeeperSkillUtils.GetSkillName end
    return KeeperSkillUtils.GetSkillName, self.keeperSkillId
  end)
  local desc = KeeperSkillUtils.GetKeeperSkillDesc(self.keeperSkillId)
end

function BattleKeeperSkillPanel:BindConfirmGroup()
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnClickConfirm),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end,
    text = LT.Text("UniversalConfirmButton")
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.Close),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end,
    text = LT.Text("UniversalCancelButton")
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  self.binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_S, commonPopupConfirmTipsData))
end

function BattleKeeperSkillPanel:OnClickConfirm()
  if self.fireSkillFunc then
    self.fireSkillFunc()
  end
  self:Close()
end

return BattleKeeperSkillPanel
