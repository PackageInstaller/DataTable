_class("UIWidgetPetSkill", UICustomWidget)
UIWidgetPetSkill = UIWidgetPetSkill

function UIWidgetPetSkill:OnShow()
  self.enableFakeInput = true
  self.oneLineHeight = 154
  self.twoLineHeight = 176
  self.threeLineHeight = 189
  self.lineMaxWidth = 678
  local sop = self:GetUIComponent("UISelectObjectPath", "preattack")
  sop:SpawnObject("UIPreAttackItem")
  self.preAttackCell = sop:GetAllSpawnList()[1]
  self.preAttackCell:Enable(false)
  self:AttachEvent(GameEventType.BattleUIRefreshActiveSkillCastButtonState, self._RefreshCastButtonState)
  self.activeSkillCheckPass = true
  self._objEquipRefineUpPos = self:GetGameObject("objEquipRefineUpPos")
  self._objEquipRefineDownPos = self:GetGameObject("objEquipRefineDownPos")
end

function UIWidgetPetSkill:HideSelf()
  self._isShow = false
  self:GetGameObject():SetActive(false)
end

function UIWidgetPetSkill:ShowSelf()
  self._isShow = true
  self:GetGameObject():SetActive(true)
end

function UIWidgetPetSkill:SetUiPos(position)
  self:GetGameObject().transform.position = position
end

function UIWidgetPetSkill:GetPetSkillBtn()
  local btn = self:GetGameObject("btnGo")
  return btn
end

function UIWidgetPetSkill:SetPetPstId(petPstId)
  self.petPstId = petPstId
  local enterData = GameGlobal.GetModule(MatchModule):GetMatchEnterData()
  local matchPets = InnerGameHelperRender.GetLocalMatchPets()
  self.pet = matchPets[self.petPstId]
end

function UIWidgetPetSkill:SetPet(pet)
  self.pet = pet
end

function UIWidgetPetSkill:ShowPreAttack()
  if self.preAttackCell then
    self.preAttackCell:SetData(self.petPstId, self.skillID, false)
  end
end

function UIWidgetPetSkill:OnHide()
  self.activeSkillCheckPass = true
  self._cannotCastReason = nil
end

function UIWidgetPetSkill:ResetSkillCanCast()
  self.activeSkillCheckPass = true
  self._cannotCastReason = nil
end

function UIWidgetPetSkill:Init(skillID, maxEnergy, leftEnergy, canCast, castCallback, petPstID)
  self.skillID = skillID
  self.leftPower = leftEnergy
  self.castCallback = castCallback
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
  local skillData = ConfigServiceHelper.GetSkillConfigData(self.skillID, petPstID)
  skillName:SetText(StringTable.Get(skillData:GetSkillName()))
  if UILogicPetHelper.ShowSkillEnergy(skillData:GetSkillTriggerType()) then
    skillCD.gameObject:SetActive(true)
    skillCD:SetText(string.format(StringTable.Get("str_common_cooldown_round"), skillData:GetSkillTriggerParam()))
  else
    skillCD.gameObject:SetActive(false)
  end
  local mask = self:GetUIComponent("RevolvingTextWithDynamicScroll", "mask")
  mask:OnRefreshRevolving()
  local descForceParam = {}
  local extraParam = skillData:GetSkillTriggerExtraParam()
  if extraParam and extraParam[SkillTriggerTypeExtraParam.SanChangeByRoundCastTimes] then
    local baseCost = extraParam[SkillTriggerTypeExtraParam.SanValue]
    local modCost = extraParam[SkillTriggerTypeExtraParam.SanChangeByRoundCastTimes]
    local curTimes = BattleStatHelper.GetCurRoundDoActiveSkillTimes(self.petPstId)
    local curCost = baseCost + modCost * curTimes
    table.insert(descForceParam, tostring(curCost))
  end
  local skillDescString = skillData:GetPetSkillDes(descForceParam)
  local skillDescUtf8Len = #skillDescString
  self.skillDesc = skillDesc
  if not self:CheckRefineSkillReplace(self.skillID) then
    skillDesc:SetText(skillDescString)
  end
  local skillInfo = self:GetGameObject("skillInfo")
  skillInfo:SetActive(true)
  UIHelper.RefreshLayout(self:GetUIComponent("RectTransform", "skillInfo"))
  local skillInfoTrans = bgRectTransform.parent.parent
  local isAdapteHead = InnerGameHelperRender.UICheckIsFifthPet(self.petPstId)
  local tmpPos = skillInfoTrans.anchoredPosition3D
  tmpPos.y = 0
  if skillInfoTrans and isAdapteHead then
    local baseHeight = 170
    local heightDef = bgRectTransform.sizeDelta.y - baseHeight
    if 0 < heightDef then
      tmpPos.y = heightDef / 2
    end
  end
  skillInfoTrans.anchoredPosition3D = tmpPos
  local cancelSkillInfo = self:GetGameObject("cancelSkillInfo")
  cancelSkillInfo:SetActive(false)
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self.skillID)
  local pickUpType = skillConfigData:GetSkillPickType()
end

function UIWidgetPetSkill:btnGoOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetPetSkill",
    input = "btnGoOnClick",
    args = {}
  })
  if not self.canCast or not self.activeSkillCheckPass then
    local reasonByBuffSetCanNotReadyReason = BattleStatHelper.CheckCanCastActiveSkill_GetCantReadyReasonByBuff(self.petPstId, self.skillID)
    if not self:MissionCanCast() then
      local text = StringTable.Get("str_match_pickup_skill_limit")
      ToastManager.ShowToast(text)
    elseif reasonByBuffSetCanNotReadyReason then
      local textKey = ActiveSkillCannotCastReasonText[reasonByBuffSetCanNotReadyReason]
      local text = StringTable.Get(textKey)
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
  if not BattleStatHelper.CheckCanCastActiveSkill_SwapPetTeamOrder(self.petPstId, self.skillID) then
    local text = StringTable.Get("str_battle_hebo_cannot_change_pos_with_cursed_pet")
    ToastManager.ShowToast(text)
    return
  end
  if self.castCallback and self.canCast and self.activeSkillCheckPass then
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

function UIWidgetPetSkill:MissionCanCast()
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

function UIWidgetPetSkill:ShowCancelBtn(isShow)
  local skillInfo = self:GetGameObject("skillInfo")
  skillInfo:SetActive(false)
  local cancelSkillInfo = self:GetGameObject("cancelSkillInfo")
  cancelSkillInfo:SetActive(isShow)
end

function UIWidgetPetSkill:GetCastSkillBtn()
  return self._castBtn
end

function UIWidgetPetSkill:GetCurActiveSkillID()
  return self.skillID
end

function UIWidgetPetSkill:_RefreshCastButtonState(result, reason)
  if self._isShow then
    self.activeSkillCheckPass = result
    self._cannotCastReason = reason
    self._castBtn.interactable = result
  end
end

function UIWidgetPetSkill:GetEquipRefineUpPosObj()
  return self._objEquipRefineUpPos
end

function UIWidgetPetSkill:GetEquipRefineDownPosObj()
  return self._objEquipRefineDownPos
end

function UIWidgetPetSkill:CheckRefineSkillReplace(skillId)
  if not self.pet or not skillId then
    return false
  end
  local refineLv = self.pet:GetEquipRefineLv()
  if refineLv < 1 then
    return false
  end
  local refineConfig = UIPetEquipHelper.GetRefineCfg(self.pet:GetTemplateID(), refineLv)
  if not refineConfig then
    return false
  end
  local replaceData = refineConfig.SubstituteSkillDesc
  if not replaceData then
    return false
  end
  local newDesc
  for k, v in pairs(replaceData) do
    newDesc = v[skillId]
    if newDesc and newDesc ~= "" then
      break
    end
  end
  if newDesc then
    self.skillDesc:SetText(StringTable.Get(newDesc))
    return true
  end
  return false
end
