_class("UIWidgetTrapSkill", UICustomWidget)
UIWidgetTrapSkill = UIWidgetTrapSkill

function UIWidgetTrapSkill:Constructor()
  self._selectIndex = {}
end

function UIWidgetTrapSkill:OnShow()
  self.enableFakeInput = true
  self._root = self:GetGameObject("root")
  self._selectRect = self:GetUIComponent("RectTransform", "root")
  self._skillName = self:GetUIComponent("UILocalizationText", "skillName")
  self._revolvingTextName = self:GetUIComponent("RevolvingTextWithDynamicScroll", "RevolvingTextName")
  self._skillDesc = self:GetUIComponent("UILocalizationText", "skillDesc")
  self._skillCD = self:GetUIComponent("UILocalizationText", "skillCD")
  self._revolvingTextCD = self:GetUIComponent("RevolvingTextWithDynamicScroll", "RevolvingTextCD")
  self._btnGo = self:GetUIComponent("Button", "btnGo")
  local txtGo = self:GetUIComponent("UILocalizationText", "txtGo")
  self._uiSkillListRoot = self:GetUIComponent("UISelectObjectPath", "skillListRoot")
  self._uiSkillListRootRect = self:GetUIComponent("RectTransform", "skillListRoot")
  self._isSummonLimit = false
end

function UIWidgetTrapSkill:OnHide()
end

function UIWidgetTrapSkill:Init(trapEntityID)
  self._entityID = trapEntityID
  if not self._selectIndex[self._entityID] then
    self._selectIndex[self._entityID] = 1
  end
  self:GetGameObject():SetActive(true)
  self._isAutoFighting = BattleStatHelper.GetAutoFightStat()
  local pos = InnerGameHelperRender.CalcUIPos(trapEntityID)
  if pos then
    self._selectRect.anchoredPosition = pos
  end
  local skillList = InnerGameHelperRender.GetTrapActiveSkillList(trapEntityID)
  self:_OnRefreshTrapSkillInfo(skillList)
end

function UIWidgetTrapSkill:_OnRefreshTrapSkillInfo(skillList)
  self._uiSkillListRoot:SpawnObjects("UIWidgetTrapSkillItem", #skillList)
  if table.count(skillList) <= 3 then
    self._uiSkillListRootRect.sizeDelta = Vector2(360, 120)
    self._uiSkillListRootRect.anchoredPosition = Vector2(-15, 56)
  else
    self._uiSkillListRootRect.sizeDelta = Vector2(480, 120)
    self._uiSkillListRootRect.anchoredPosition = Vector2(-70, 56)
  end
  local uiSkillList = self._uiSkillListRoot:GetAllSpawnList()
  self.items = uiSkillList
  for i = 1, #skillList do
    local uiSkillItem = uiSkillList[i]
    uiSkillItem:GetGameObject():SetActive(i <= #skillList)
    if i <= #skillList then
      uiSkillItem:Init(i, skillList[i], function(index)
        self._selectIndex[self._entityID] = index
        for i = 1, #uiSkillList do
          local uiSkillIem = uiSkillList[i]
          local canCast = self:_OnGetCanCastSkill(skillList[i])
          uiSkillIem:OnSelect(i == index, canCast)
        end
        self:_OnShowSelectSkill(skillList[index])
      end)
    end
  end
  uiSkillList[self._selectIndex[self._entityID]]:buttonBgOnClick(nil)
end

function UIWidgetTrapSkill:_OnShowSelectSkill(skillId)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetTrapSkill",
    input = "_OnShowSelectSkill",
    args = {skillId}
  })
  self._skillId = skillId
  local cfgSkillInfo = BattleSkillCfg(self._skillId)
  local strName = StringTable.Get(cfgSkillInfo.Name)
  local showSkillCostPower = InnerGameHelperRender.GetTrapAttribute(self._entityID, "ShowSkillCostPower")
  if showSkillCostPower == 1 then
    local strSkillCostPower = StringTable.Get("str_trap_cost_trap_power", cfgSkillInfo.TriggerParam)
    strName = strName .. strSkillCostPower
  end
  self._skillName:SetText(strName)
  self._revolvingTextName:OnRefreshRevolving()
  local canCastSkillCount = InnerGameHelperRender.GetTrapCurRoundCanCastSkillCount(self._entityID)
  local oneRoundLimit = InnerGameHelperRender.GetTrapAttribute(self._entityID, "OneRoundLimit")
  if oneRoundLimit == 1 then
    self._skillCD:SetText(string.format(StringTable.Get("str_common_cooldown_round"), cfgSkillInfo.TriggerParam))
  elseif oneRoundLimit == 99 then
    self._skillCD:SetText(string.format(StringTable.Get("str_common_cooldown_round"), 0))
  else
    self._skillCD:SetText(StringTable.Get("str_trap_can_cast_count", canCastSkillCount))
  end
  self._revolvingTextCD:OnRefreshRevolving()
  self._skillDesc:SetText(StringTable.Get(cfgSkillInfo.Desc))
  self._canCast = self:_OnGetCanCastSkill(self._skillId)
  self._btnGo.interactable = self._canCast
  self._isSummonLimit = self:_IsSummonCountLimit(self._skillId)
  local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
  local enableInput = GameGlobal:GetInstance():IsInputEnable()
  if coreGameStateID == GameStateID.WaitInput and enableInput == true then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
  elseif coreGameStateID == GameStateID.PreviewActiveSkill or coreGameStateID == GameStateID.PickUpActiveSkillTarget then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.StopPreviewActiveSkill, true, false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._skillId, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickTrapHead, self._skillId, self._entityID, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TrapPowerVisible, false)
end

function UIWidgetTrapSkill:_OnGetCanCastSkill(skillID)
  if not skillID then
    return false
  end
  local cfgSkillInfo = BattleSkillCfg(skillID)
  local canCastSkillCount = InnerGameHelperRender.GetTrapCurRoundCanCastSkillCount(self._entityID)
  local trapPower = InnerGameHelperRender.GetTrapAttribute(self._entityID, "TrapPower")
  local canCastByLimitCount = not self:_IsSummonCountLimit(skillID)
  local canCast = 0 < canCastSkillCount and trapPower >= cfgSkillInfo.TriggerParam and canCastByLimitCount
  if canCast then
    local skillConfigData = ConfigServiceHelper.GetSkillConfigData(skillID)
    canCast = InnerGameHelperRender.CanCastByExtraPower(skillConfigData)
  end
  return canCast
end

function UIWidgetTrapSkill:_IsSummonCountLimit(skillID)
  local cfgSkillInfo = BattleSkillCfg(skillID)
  local isLimit = false
  if cfgSkillInfo.Tag and table.icontains(cfgSkillInfo.Tag, PetSkillTag.SummonTrap) then
    isLimit = InnerGameHelperRender.IsTrapSummonCountLimit(self._entityID)
  end
  return isLimit
end

function UIWidgetTrapSkill:btnGoOnClick(go)
  if not self._canCast then
    if self._isSummonLimit then
      ToastManager.ShowToast(StringTable.Get("str_battle_trap_summon_limit"))
    end
    return
  end
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetTrapSkill",
    input = "btnGoOnClick",
    args = {}
  })
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self._skillId)
  local pickUpType = skillConfigData:GetSkillPickType()
  if pickUpType == SkillPickUpType.None then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CastActiveSkillNoPet, self._skillId, self._entityID)
  elseif pickUpType == SkillPickUpType.Instruction or pickUpType == SkillPickUpType.PickAndDirectionInstruction then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, self._skillId, self._entityID)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowActiveSkillChooseUI, self._skillId, pickUpType, self._entityID, self._canCast)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, self._skillId, self._entityID)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowActiveSkillChooseUI, self._skillId, pickUpType, self._entityID, self._canCast)
  end
  self:GetGameObject():SetActive(false)
end

function UIWidgetTrapSkill:btnCloseOnClick(go)
  if self._isAutoFighting then
    return
  end
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetTrapSkill",
    input = "btnCloseOnClick",
    args = {}
  })
  self:GetGameObject():SetActive(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowCanMoveArrow)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StopPreviewActiveSkill, false, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, -1)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TrapPowerVisible, true)
end

function UIWidgetTrapSkill:GetTrapSkillIcon(index)
  return self.items and self.items[index] and self.items[index]:GetGameObject("canCast")
end
