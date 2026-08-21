_class("UIWidgetPetSubSkill", UICustomWidget)
UIWidgetPetSubSkill = UIWidgetPetSubSkill

function UIWidgetPetSubSkill:OnShow()
  local sop = self:GetUIComponent("UISelectObjectPath", "preattack")
  sop:SpawnObject("UIPreAttackItem")
  self._preAttackCell = sop:GetAllSpawnList()[1]
  self._preAttackCell:Enable(false)
  self._btnGo = self:GetUIComponent("Button", "btnGo")
  self._txtGo = self:GetUIComponent("UILocalizationText", "txtGo")
  self._skillListRoot = self:GetUIComponent("UISelectObjectPath", "skillListRoot")
  self._txtSkillName = self:GetUIComponent("UILocalizationText", "skillName")
  self._tmpSkillDesc = self:GetUIComponent("UILocalizedTMP", "skillDesc")
  self._rectBg = self:GetUIComponent("RectTransform", "bg")
  self._txtSkillCD = self:GetUIComponent("UILocalizationText", "skillCD")
  self._rtxtMask = self:GetUIComponent("RevolvingTextWithDynamicScroll", "mask")
  self._objSkillInfo = self:GetGameObject("skillInfo")
  self._rectSkillInfo = self:GetUIComponent("RectTransform", "skillInfo")
  self._objCancelSkillInfo = self:GetGameObject("cancelSkillInfo")
  self._selectIndex = 1
  self._curSkillID = nil
end

function UIWidgetPetSubSkill:HideSelf()
  self:GetGameObject():SetActive(false)
end

function UIWidgetPetSubSkill:ShowSelf()
  self:GetGameObject():SetActive(true)
end

function UIWidgetPetSubSkill:SetUiPos(position)
  self:GetGameObject().transform.position = position
end

function UIWidgetPetSubSkill:GetPetSkillBtn()
  local btn = self:GetGameObject("btnGo")
  return btn
end

function UIWidgetPetSubSkill:SetPetPstId(petPstId)
  self._petPstId = petPstId
  local enterData = GameGlobal.GetModule(MatchModule):GetMatchEnterData()
  local matchPets = InnerGameHelperRender.GetLocalMatchPets()
  self._pet = matchPets[self._petPstId]
end

function UIWidgetPetSubSkill:SetPet(pet)
  self._pet = pet
end

function UIWidgetPetSubSkill:ShowPreAttack(skillID)
  if self._preAttackCell then
    self._preAttackCell:SetData(self._petPstId, skillID, false)
  end
end

function UIWidgetPetSubSkill:ClearCurSkillID()
  self._curSkillID = nil
end

function UIWidgetPetSubSkill:OnHide()
end

function UIWidgetPetSubSkill:_OnRefreshSkillList(skillList)
  self._skillListRoot:SpawnObjects("UIWidgetTrapSkillItem", #skillList)
  local uiSkillList = self._skillListRoot:GetAllSpawnList()
  self._skillItems = uiSkillList
  for i = 1, #skillList do
    local uiSkillItem = uiSkillList[i]
    uiSkillItem:GetGameObject():SetActive(true)
    uiSkillItem:Init(i, skillList[i], function(index)
      self._selectIndex = index
      for i = 1, #uiSkillList do
        local uiSkillIem = uiSkillList[i]
        local canCast = self._canCast and self:_OnGetCanCastSkill(skillList[index])
        uiSkillIem:OnSelect(i == index, canCast)
      end
      self:_OnShowSelectSkill(skillList[index])
    end)
  end
  uiSkillList[self._selectIndex]:buttonBgOnClick(nil)
end

function UIWidgetPetSubSkill:_OnShowSelectSkill(skillID)
  if self._curSkillID == skillID then
    return
  end
  self._curSkillID = skillID
  self:ShowPreAttack(skillID)
  local canCast = self._canCast and self:_OnGetCanCastSkill(skillID)
  if canCast then
    self._btnGo.interactable = true
    self._txtGo.color = Color.white
  else
    self._btnGo.interactable = false
    self._txtGo.color = Color(0.4823529411764706, 0.4823529411764706, 0.4823529411764706, 1)
  end
  local skillData = ConfigServiceHelper.GetSkillConfigData(skillID)
  self._txtSkillName:SetText(StringTable.Get(skillData:GetSkillName()))
  if skillData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
    self._txtSkillCD.gameObject:SetActive(false)
  else
    self._txtSkillCD.gameObject:SetActive(true)
    local strSkillCD = string.format(StringTable.Get("str_common_cooldown_round"), skillData:GetSkillTriggerParam())
    self._txtSkillCD:SetText(strSkillCD)
  end
  self._rtxtMask:OnRefreshRevolving()
  local strSkillDes = skillData:GetPetSkillDes()
  if not self:CheckRefineSkillReplace(skillID) then
    self._tmpSkillDesc:SetText(strSkillDes)
  end
  self._objSkillInfo:SetActive(true)
  UIHelper.RefreshLayout(self._rectSkillInfo)
  local skillInfoTrans = self._rectBg.parent.parent
  local isAdapteHead = InnerGameHelperRender.UICheckIsFifthPet(self._petPstId)
  local tmpPos = skillInfoTrans.anchoredPosition3D
  tmpPos.y = 0
  if skillInfoTrans and isAdapteHead then
    local baseHeight = 170
    local heightDef = self._rectBg.sizeDelta.y - baseHeight
    if 0 < heightDef then
      tmpPos.y = heightDef / 2
    end
  end
  skillInfoTrans.anchoredPosition3D = tmpPos
  self._objCancelSkillInfo:SetActive(false)
  self:_SwitchSkillPreview(canCast)
end

function UIWidgetPetSubSkill:_SwitchSkillPreview(canCast)
  local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
  local enableInput = GameGlobal:GetInstance():IsInputEnable()
  if coreGameStateID == GameStateID.WaitInput and enableInput == true then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
  elseif coreGameStateID == GameStateID.PreviewActiveSkill or coreGameStateID == GameStateID.PickUpActiveSkillTarget then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.StopPreviewActiveSkill, true, false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._curSkillID, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPetHead, self._petPstId, true, self._curSkillID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SelectSubActiveSkill, self._curSkillID, canCast)
end

function UIWidgetPetSubSkill:Init(skillID, maxEnergy, leftEnergy, canCast, castCallback)
  self._skillID = skillID
  self._canCast = canCast
  self._castCallback = castCallback
  local skillData = ConfigServiceHelper.GetSkillConfigData(self._skillID)
  local skillList = skillData:GetSubSkillIDList()
  self:_OnRefreshSkillList(skillList)
end

function UIWidgetPetSubSkill:BtnGoOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetPetSubSkill",
    input = "BtnGoOnClick",
    args = {}
  })
  local skillData = ConfigServiceHelper.GetSkillConfigData(self._skillID)
  local skillList = skillData:GetSubSkillIDList()
  local skillID = skillList[self._selectIndex]
  local canCast = self._canCast and self:_OnGetCanCastSkill(skillID)
  if not canCast then
    if not self:MissionCanCast() then
      local text = StringTable.Get("str_match_pickup_skill_limit")
      ToastManager.ShowToast(text)
    elseif not BattleStatHelper.CheckCanCastActiveSkill_TeamLeaderCondi(self._petPstId, skillID) then
      local text = StringTable.Get("str_battle_team_leader_active_skill_disabled")
      ToastManager.ShowToast(text)
    else
      local text = StringTable.Get("str_match_cannot_cast_skill_reason")
      ToastManager.ShowToast(text)
    end
  end
  if not BattleStatHelper.CheckCanCastActiveSkill_SwapPetTeamOrder(self._petPstId, skillID) then
    local text = StringTable.Get("str_battle_hebo_cannot_change_pos_with_cursed_pet")
    ToastManager.ShowToast(text)
    return
  end
  if self._castCallback and canCast then
    local skillConfigData = ConfigServiceHelper.GetSkillConfigData(skillID)
    local pickUpType = skillConfigData:GetSkillPickType()
    if self:MissionCanCast() then
      self._castCallback(skillID, pickUpType)
    else
      local text = StringTable.Get("str_match_pickup_skill_limit")
      ToastManager.ShowToast(text)
    end
  end
end

function UIWidgetPetSubSkill:_OnGetCanCastSkill(skillID)
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(skillID)
  local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
  if not cfgExtraParam then
    return true
  end
  local trapID = cfgExtraParam[SkillTriggerTypeExtraParam.TrapID]
  if InnerGameHelperRender:IsTrapCovered(trapID, self._petPstId) then
    return false
  end
  return true
end

function UIWidgetPetSubSkill:MissionCanCast()
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

function UIWidgetPetSubSkill:ShowCancelBtn(isShow)
  self._objSkillInfo:SetActive(false)
  self._objCancelSkillInfo:SetActive(isShow)
end

function UIWidgetPetSubSkill:GetCastSkillBtn()
  return self._btnGo
end

function UIWidgetPetSubSkill:GetCurActiveSkillID()
  return self._curSkillID
end

function UIWidgetPetSubSkill:CheckRefineSkillReplace(skillId)
  if not self._pet or not skillId then
    return false
  end
  local refineLv = self._pet:GetEquipRefineLv()
  if refineLv < 1 then
    return false
  end
  local refineConfig = UIPetEquipHelper.GetRefineCfg(self._pet:GetTemplateID(), refineLv)
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
    self._tmpSkillDesc:SetText(StringTable.Get(newDesc))
    return true
  end
  return false
end
