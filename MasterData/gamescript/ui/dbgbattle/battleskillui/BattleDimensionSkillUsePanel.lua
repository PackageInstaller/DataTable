local BattleDimensionSkillUsePanel, Super = System.NewClass("BattleDimensionSkillUsePanel", UIBasePanel)
BattleDimensionSkillUsePanel.uiResCls = UI_Battle_Popup_AngerResource

function BattleDimensionSkillUsePanel:ctor(fireSkillFunc)
  Super.ctor(self)
  self.keeperSkillId = bg.DT.GetConstant("DimensionSKill")
  self.fireSkillFunc = fireSkillFunc
  self.groupKeyWordShowed = Vue.ref(false)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleDimensionSkillUsePanel:OnBind(binder)
  self:_OnBindShortCutComps(binder)
  binder:LoadAllLangFont(self.ui.Text_Role)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindToText(self.ui.Text_C_Title, function()
    local skillCfg = bg.DT.Skill[self.keeperSkillId]
    if skillCfg then
      return skillCfg.Name
    end
  end)
  self.ui.Group_CD:SetActive(false)
  self:BindRoleInfo()
  self:BindConfirmGroup()
  self:BindSkillInfo()
end

function BattleDimensionSkillUsePanel:_OnBindShortCutComps(binder)
  local extraParam = {withoutForwardPanel = true}
  binder:BindComponent(ShortCutComp(self.ui.Text_Confirm_ShortCut, "KeyConfirm", System.fn(self, self.OnClickConfirm), extraParam))
end

function BattleDimensionSkillUsePanel:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function BattleDimensionSkillUsePanel:BindRoleInfo()
  self.binder:BindToImage(self.ui.Icon_Awaker, function()
    do return GenderDataUtils.GetMainHeadRes, bg.battleDataCenter:GetPlayerGender() end
    return GenderDataUtils.GetMainHeadRes, bg.battleDataCenter:GetPlayerGender()
  end)
  self.binder:BindToText(self.ui.Text_Role, function()
    do return bg.battleDataCenter.GetPlayerName end
    return bg.battleDataCenter.GetPlayerName, bg.battleDataCenter
  end)
end

function BattleDimensionSkillUsePanel:BindSkillInfo()
  self.binder:BindToText(self.ui.Text_Tips, function()
    local skillCfg = bg.DT.Skill[self.keeperSkillId]
    if skillCfg then
      local desc = skillCfg.tempBattleDesc or skillCfg.Desc
      do return BattleSkillUtils.GetMatchTQ, desc end
      return BattleSkillUtils.GetMatchTQ, desc, {
        skillId = self.keeperSkillId
      }, self.keeperSkillId
    end
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
    return ""
  end)
end

function BattleDimensionSkillUsePanel:BindConfirmGroup()
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

function BattleDimensionSkillUsePanel:OnClickConfirm()
  if PVEBattleReplayUtils.CheckReplayForbidTips() then
    return
  end
  if self.fireSkillFunc then
    self.fireSkillFunc()
  end
  EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.GuideCondDimensionSchoolSkillUsed)
  self:Close()
end

return BattleDimensionSkillUsePanel
