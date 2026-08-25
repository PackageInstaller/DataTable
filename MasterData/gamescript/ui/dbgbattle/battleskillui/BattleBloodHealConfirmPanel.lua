local Vector2 = CS.UnityEngine.Vector2
local Mathf = CS.UnityEngine.Mathf
local BattleBloodHealConfirmPanel, Super = System.NewClass("BattleBloodHealConfirmPanel", UIBasePanel)
BattleBloodHealConfirmPanel.uiResCls = UI_Battle_Popup_FurnaceResource

function BattleBloodHealConfirmPanel:ctor()
  Super.ctor(self)
  self.skillId = bg.DT.GetConstant("BloodHealSkill")
end

function BattleBloodHealConfirmPanel:OnBind(binder)
  self:_OnBindShortCutComps(binder)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  local skillCfg = bg.DT.Skill[self.skillId] or {}
  binder:BindToText(self.ui.Text_Name, function()
    return skillCfg.Name
  end)
  binder:SetText(self.ui.Text_Tips, SkillUtils.GetAwakerSkillDesc({}, self.skillId))
  self:BindConfirmGroup()
  self:BindBloodHeal()
  binder:BindToVisible(self.ui.Group_Button, function()
    do return bg.battleDataCenter.IsMyActionCamp end
    return bg.battleDataCenter.IsMyActionCamp, bg.battleDataCenter
  end)
end

function BattleBloodHealConfirmPanel:_OnBindShortCutComps(binder)
  local extraParam = {withoutForwardPanel = true}
  binder:BindComponent(ShortCutComp(self.ui.Text_Confirm_ShortCut, "KeyConfirm", System.fn(self, self.OnClickConfirm), extraParam))
end

function BattleBloodHealConfirmPanel:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function BattleBloodHealConfirmPanel:BindConfirmGroup()
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

function BattleBloodHealConfirmPanel:OnClickConfirm()
  if PVEBattleReplayUtils.CheckReplayForbidTips() then
    return
  end
  bg.battleRender:SendCommand(BattleCommand.lg_BloodRecoverSkill, {
    model = "BloodHealSkill"
  })
  EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.GuideCondBloodSchoolSkillUsed)
  self:Close()
end

function BattleBloodHealConfirmPanel:BindBloodHeal()
  self.binder:BindToText(self.ui.Text_Value, function()
    do return self.GetBloodHealValue end
    return self.GetBloodHealValue, self
  end)
  local skillId = bg.DT.GetConstant("BloodHealSkill")
  local skillCfg = bg.DT.Skill[skillId]
  self.binder:SetText(self.ui.Text_C_Title, skillCfg and skillCfg.Name or "")
  self.binder:BindToImageFillAmount(self.ui.Image_Blood, function()
    do return self.GetBloodHealProgress end
    return self.GetBloodHealProgress, self
  end)
  self.binder:BindToImageFillAmount(self.ui.Image_water01, function()
    do return self.GetBloodHealProgress end
    return self.GetBloodHealProgress, self
  end)
  self.ui.Image_water01:SetActive(false)
  self.binder:BindToRaw(function(_, progress, oldProgress)
    local x = -18.7
    local bottomY = -57.3
    local topY = 70.2
    local y = (topY - bottomY) * progress + bottomY
    self.ui.UI_Battle_Blood_Drop_Wave01.transform.anchoredPosition = Vector2(x, y)
  end, function()
    do return self.GetBloodHealProgress end
    return self.GetBloodHealProgress, self
  end)
  self.binder:BindToVisible(self.ui.Group_Max, function()
    do return self.GetBloodHealProgress end
    return self.GetBloodHealProgress, self
  end)
  self.binder:BindToVisible(self.ui.UI_Battle_Blood_Drop_Wave01, function()
    return self:GetBloodHealProgress() < 1
  end)
end

function BattleBloodHealConfirmPanel:OnGroupHeal()
  UIManager.Instance:Reopen(Urls.BattleBloodHealConfirmPanel)
end

function BattleBloodHealConfirmPanel:GetBloodHealValue()
  local cmdParser = BattleCmdParserClient({})
  local value = cmdParser:GetValueByCmd(bg.DT.GetConstant("BloodHealCount"))
  do return Mathf.CeilToInt end
  return Mathf.CeilToInt, value, bg.DT.GetConstant("BloodHealCount")
end

function BattleBloodHealConfirmPanel:GetBloodHealMaxValue()
  local cmdParser = BattleCmdParserClient({})
  local stateCfg = DT.State[bg.DT.GetConstant("BloodHealStateId")]
  do return cmdParser.GetValueByCmd, cmdParser end
  return cmdParser.GetValueByCmd, cmdParser, stateCfg.MaxLayer
end

function BattleBloodHealConfirmPanel:GetBloodHealProgress()
  local cur = self:GetBloodHealValue()
  local max = self:GetBloodHealMaxValue()
  if max and 0 ~= max then
    do return math.min, 1 end
    return math.min, 1, cur / max
  end
  return 0
end

return BattleBloodHealConfirmPanel
