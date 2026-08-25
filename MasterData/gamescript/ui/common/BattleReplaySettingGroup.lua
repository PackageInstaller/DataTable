local BattleReplaySettingGroup, Super = System.NewComponent("BattleReplaySettingGroup")

function BattleReplaySettingGroup:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Common_BattleAndMapSet_BgResource(uiNode)
  self.settingVisible = Vue.ref(false)
end

function BattleReplaySettingGroup:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    if self.settingVisible.value then
      self.settingVisible.value = false
    end
  end)
  binder:BindToVisible(self.ui.uiNode, function()
    return self.settingVisible.value
  end)
  binder:SetActive(self.ui.Btn_Survey_Evaluation, false)
  binder:SetActive(self.ui.Btn_Achievement_Reward, false)
  binder:SetActive(self.ui.Btn_Tutorial, false)
  binder:SetActive(self.ui.Btn_ReStart_Battle, false)
  binder:SetActive(self.ui.Btn_Daily_Rule, false)
  binder:SetActive(self.ui.Btn_Setting, false)
  binder:SetActive(self.ui.Btn_SaveAndExit, false)
  binder:SetActive(self.ui.Btn_Exit_Survey, true)
  binder:BindZ1Button(self.ui.Btn_Exit_Survey, function()
    UIManager.Instance:CloseByUrl(Urls.PVEReplayBattlePanel)
    UIManager.Instance:CloseByUrl(Urls.PVPReplayBattlePanel)
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "PvPExitReplay"
  end)
end

function BattleReplaySettingGroup:SwitchVisible()
  self.settingVisible.value = not self.settingVisible.value
  if self.settingVisible.value == true then
    AudioManager.Instance:PostSoundEvent("Play_UI_Exp_SettingMenu_On")
  else
    AudioManager.Instance:PostSoundEvent("Play_UI_Exp_SettingMenu_Off")
  end
end

return BattleReplaySettingGroup
