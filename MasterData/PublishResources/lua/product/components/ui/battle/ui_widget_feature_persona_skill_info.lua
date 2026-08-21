_class("UIWidgetFeaturePersonaSkillInfo", UICustomWidget)
UIWidgetFeaturePersonaSkillInfo = UIWidgetFeaturePersonaSkillInfo

function UIWidgetFeaturePersonaSkillInfo:OnShow()
  self.oneLineHeight = 154
  self.twoLineHeight = 176
  self.threeLineHeight = 189
  self.lineMaxWidth = 678
  local sop = self:GetUIComponent("UISelectObjectPath", "preattack")
  sop:SpawnObject("UIPreAttackItem")
  self.preAttackCell = sop:GetAllSpawnList()[1]
  self.preAttackCell:Enable(false)
end

function UIWidgetFeaturePersonaSkillInfo:ShowPreAttack()
  if self.preAttackCell then
    self.preAttackCell:SetData(self.petPstId, self.skillID, false)
  end
end

function UIWidgetFeaturePersonaSkillInfo:OnHide()
  self._cannotCastReason = nil
end

function UIWidgetFeaturePersonaSkillInfo:ResetSkillCanCast()
  self._cannotCastReason = nil
end

function UIWidgetFeaturePersonaSkillInfo:Init(featureType, skillID, maxEnergy, leftEnergy, canCast, castCallback, cancelCallBack)
  self.featureType = featureType
  self.skillID = skillID
  self.leftPower = leftEnergy
  self.castCallback = castCallback
  self.cancelCallBack = cancelCallBack
  local skillName = self:GetUIComponent("UILocalizationText", "skillName")
  local skillDesc = self:GetUIComponent("UILocalizedTMP", "skillDesc")
  local bgRectTransform = self:GetUIComponent("RectTransform", "bg")
  local skillCD = self:GetUIComponent("UILocalizationText", "skillCD")
  local btnGo = self:GetUIComponent("Button", "btnGo")
  local txtGo = self:GetUIComponent("UILocalizationText", "txtGo")
  self._castBtn = btnGo
  self.canCast = canCast
  self:ShowPreAttack()
  if canCast then
    btnGo.interactable = true
    txtGo.color = Color.white
  else
    btnGo.interactable = false
    txtGo.color = Color(0.4823529411764706, 0.4823529411764706, 0.4823529411764706, 1)
  end
  local skillData = ConfigServiceHelper.GetSkillConfigData(self.skillID)
  skillName:SetText(StringTable.Get(skillData:GetSkillName()))
  if skillData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
    skillCD.gameObject:SetActive(false)
  else
    skillCD.gameObject:SetActive(true)
    local MaxPower = skillData:GetSkillTriggerParam()
    local cdOff = BattleStatHelper.GetAllFeatureSkillCdOff()
    local specificCdOff = BattleStatHelper.GetSpecificFeatureSkillCdOff(self.featureType)
    MaxPower = MaxPower + cdOff + specificCdOff
    if MaxPower < 0 then
      MaxPower = 0
    end
    skillCD:SetText(string.format(StringTable.Get("str_common_cooldown_round"), MaxPower))
  end
  local mask = self:GetUIComponent("RevolvingTextWithDynamicScroll", "mask")
  mask:OnRefreshRevolving()
  local skillDescString = skillData:GetPetSkillDes()
  local skillDescUtf8Len = #skillDescString
  skillDesc:SetText(skillDescString)
  local skillInfo = self:GetGameObject("skillInfo")
  skillInfo:SetActive(true)
  UIHelper.RefreshLayout(self:GetUIComponent("RectTransform", "skillInfo"))
  self._cancelSkillInfo = self:GetGameObject("cancelSkillInfo")
  self._cancelSkillInfo:SetActive(false)
end

function UIWidgetFeaturePersonaSkillInfo:BtnGoOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetFeaturePersonaSkillInfo",
    input = "btnGoOnClick",
    args = {}
  })
  if not self.canCast then
    if not self:MissionCanCast() then
      local text = StringTable.Get("str_match_pickup_skill_limit")
      ToastManager.ShowToast(text)
    elseif not BattleStatHelper.CheckCanCastActiveSkill_TeamLeaderCondi(self.petPstId, self.skillID) then
      local text = StringTable.Get("str_battle_team_leader_active_skill_disabled")
      ToastManager.ShowToast(text)
    elseif self._cannotCastReason then
      local textKey = ActiveSkillCannotCastReasonText[self._cannotCastReason]
      local text = StringTable.Get(textKey)
      ToastManager.ShowToast(text)
    else
      local text = StringTable.Get("str_match_cannot_cast_skill_reason")
      ToastManager.ShowToast(text)
    end
  end
  if self.castCallback and self.canCast then
    local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self.skillID)
    local pickUpType = skillConfigData:GetSkillPickType()
    if self:MissionCanCast() then
      self.castCallback(self.skillID, pickUpType)
    else
      local text = StringTable.Get("str_match_pickup_skill_limit")
      ToastManager.ShowToast(text)
    end
  end
end

function UIWidgetFeaturePersonaSkillInfo:MissionCanCast()
  do return true end
  local matchModule = GameGlobal.GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  if enterData:GetMatchType() == MatchType.MT_Mission then
    local currentMissionId = enterData:GetMissionCreateInfo().mission_id
    local current_mission_cfg = Cfg.cfg_mission[currentMissionId]
    if current_mission_cfg == nil then
      return true
    end
    local missionCanCast = current_mission_cfg.CastSkillLimit
    return missionCanCast
  end
  return true
end

function UIWidgetFeaturePersonaSkillInfo:ShowCancelBtn(isShow)
  self._cancelSkillInfo:SetActive(isShow)
end

function UIWidgetFeaturePersonaSkillInfo:GetCastSkillBtn()
  return self._castBtn
end

function UIWidgetFeaturePersonaSkillInfo:GetCurActiveSkillID()
  return self.skillID
end

function UIWidgetFeaturePersonaSkillInfo:CancelSkillBtnOnClick(go)
  if self.cancelCallBack then
    self.cancelCallBack()
  end
end
