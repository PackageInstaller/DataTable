local BattleAwakerSuperSkillPanel, Super = System.NewClass("BattleAwakerSuperSkillPanel", BattleAwakerSkillPanel)
BattleAwakerSuperSkillPanel.uiResCls = UI_Battle_Popup_Anger_OverrunResource

function BattleAwakerSuperSkillPanel:OnBind(binder)
  Super.OnBind(self, binder)
  AudioManager.Instance:PostSoundEvent("Play_POP_NTC_SuperExSkill_bling")
end

function BattleAwakerSuperSkillPanel:_GetUltiSkillDesc()
  do return self.battleAwakerInfo.GetSuperUltlSkillDesc end
  return self.battleAwakerInfo.GetSuperUltlSkillDesc, self.battleAwakerInfo
end

function BattleAwakerSuperSkillPanel:_GetSkillName()
  local awakerData = self.battleAwakerInfo:GetAwakerDataModel()
  local info = AwakerDataUtils.GetSuperUltiSkillInfo(awakerData.tid)
  if info and info.name then
    do return LT.Text end
    return LT.Text, info.name
  end
  do return Super._GetSkillName end
  return Super._GetSkillName, self
end

return BattleAwakerSuperSkillPanel
