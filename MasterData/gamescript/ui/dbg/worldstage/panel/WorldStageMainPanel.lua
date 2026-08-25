local UIAnimationController = CS.Z1Client.UIAnimationController
local typeof = _ENV.typeof
local Slider = CS.UnityEngine.UI.Slider
local Vector2, DOTween, Vector3, Tweening, CSAnimator, CSImage
local WorldStageMainPanel, Super = System.NewClass("WorldStageMainPanel", UIBasePanel)
WorldStageMainPanel.uiResCls = UI_Dbgcopy_Panel_Main_NewResource

function WorldStageMainPanel:ctor(stageGroupId, stageId)
  Super.ctor(self)
  Vector2 = CS.UnityEngine.Vector2
  Vector3 = CS.UnityEngine.Vector3
  DOTween = CS.DG.Tweening.DOTween
  Tweening = CS.DG.Tweening
  CSAnimator = CS.UnityEngine.Animator
  CSImage = CS.UnityEngine.UI.Image
  self.stageGroupId = stageGroupId
  self.stageGroupType = DT.StageGroup[self.stageGroupId].Type
  self.stageId = stageId
  self.stageData = WorldStageManager.Instance:GetStageData(self.stageGroupId)
  self.isTransfering = false
  self.isExiting = false
  self.settingVisible = false
  self.activeAwakers = {}
end

function WorldStageMainPanel:OnBind(binder)
  self.binder = binder
  self.settingGroup = binder:BindComponent(MapAndBattleSettingGroup(self.ui.Set_Bg, self.stageId, self.stageGroupId, true))
  binder:BindToVisible(self.ui.UI_Dbgcopy_Item_Stress_New, function()
    local banIdList = DT.Constant.PrologueStressBlock.Data
    return not table.contains(banIdList, self.stageId)
  end)
  binder:BindEvent(EventMgr.Instance.ShowAwakerVoice, System.fn(self, self.ShowAwakerVoice))
  binder:BindEvent(EventMgr.Instance.StageTransfer, System.fn(self, self.OnStageTransfer))
  binder:BindEvent(EventMgr.Instance.OnStoryStart, System.fn(self, self.OnStoryStart))
  binder:BindEvent(EventMgr.Instance.OnStoryEnd, System.fn(self, self.OnStoryEnd))
  binder:BindEvent(EventMgr.Instance.BattleBottomUI, System.fn(self, self.BottomAreaVisible))
  binder:BindEvent(EventMgr.Instance.OnExtendedRelicNum, System.fn(self, self.OnExtendedRelicNum))
  binder:BindButtonClick(self.ui.Group_Battle_Remain, System.fn(self, self.OnClickCard))
  binder:BindButtonClick(self.ui.Group_Blood, System.fn(self, self.OnClickBlood))
  self:RefreshView()
  self:RefreshRole()
  self:BindKeeperRole()
  self:BindRelicList()
  self:BindRelicKey()
  self:InitUIBothSidesUI(binder)
  self.ui.Group_Battle_Talent:SetActive(false)
  if self.stageGroupType == CommonDefine.StageGroupType.RailWay then
    if RailWayDataUtils.ConsumePendingSeasonSwitchTip() then
      Alert.Show("RailWaySeasonSwitchTips")
    else
      self._panelSeasonId = SeasonRotationCfgUtils.CalcCurrentRailWaySeasonId()
      self.monitoredSeasontimer = binder:BindTimer(5, -1, function()
        local curSeasonId = SeasonRotationCfgUtils.CalcCurrentRailWaySeasonId()
        if self._panelSeasonId and curSeasonId and curSeasonId ~= self._panelSeasonId then
          Alert.Show("RailWaySeasonSwitchTips")
          if self.monitoredSeasontimer then
            TimerManager.Instance:StopTimer(self.monitoredSeasontimer)
            self.monitoredSeasontimer = nil
          end
        end
      end)
    end
  end
  if CopyDataUtils.IsNewStageChapter(self.stageId) then
    self.binder:BindComponent(CopyChapterVueComp(self.ui.UI_Common_Btn_StageChapter, self.stageId, true))
  else
    self.binder:SetActive(self.ui.UI_Common_Btn_StageChapter)
  end
  binder:BindButtonClick(self.ui.Btn_Setting, function()
    self.settingGroup:SwitchVisible()
  end)
  binder:BindToVisible(self.ui.Btn_Setting, function()
    local stageData = WorldStageManager.Instance:GetCurStageData()
    if stageData and not stageData.isPrize then
      return true
    end
    local banIdList = DT.Constant.PrologueSettingButtonBlock.Data
    return not table.contains(banIdList, self.stageId)
  end)
  binder:BindToRaw(function(_, isRespawning)
    if isRespawning then
      self.stageData.isRespawing = false
      local animCtrl = self.ui.Group_Blood:GetComponent(typeof(UIAnimationController))
      animCtrl:PlayState("UI_Battle_Blood_Share_DeadResistance_01")
    end
  end, function()
    return self.stageData.isRespawing
  end)
  binder:BindRawTable(function()
    return self.stageData.role.awakerInfos
  end, function(_, _, _, index)
    self:RefreshRoleByIndex(index)
  end)
  binder:BindTimer(0.1, 0, nil, function()
    self:OpenCopyTaskPanel()
  end)
  binder:SetText(self.ui.Text_C_Setting, LT.Text("SettingPanelTitle"))
  
  local function func()
    self.settingGroup:SwitchVisible()
  end
  
  if IntroductionDataUtils.IsFinish() then
    UIManager.Instance:UpdateBackExpandFunc(func)
  end
end

function WorldStageMainPanel:RefreshView()
  local role = self.stageData.role
  local bloodReduceImg = self.ui.Slider_LifeBloor_Effect:GetComponent(typeof(CSImage))
  local bloodSlider = self.ui.Slider_LifeBloor:GetComponent(typeof(Slider))
  local bloodReduceTween, bloodTween
  self.binder:BindToRaw(function(childBinder, nowHpInfo, oldHpInfo)
    local hp = nowHpInfo[1]
    local maxHp = nowHpInfo[2]
    local oldHp = oldHpInfo and oldHpInfo[1]
    local oldMaxHp = oldHpInfo and oldHpInfo[2]
    if bloodReduceTween then
      bloodReduceTween:Kill(true)
    end
    if bloodTween then
      bloodTween:Kill(true)
    end
    if oldHp and oldHp <= 0 then
      self.binder:SetText(self.ui.Text_LifeBloor, string.format("%s/%s", hp, maxHp))
      self.binder:SetSliderCurValue(self.ui.Slider_LifeBloor, hp / maxHp)
      return
    end
    if oldHp then
      local changeHp = hp - oldHp
      local ChangeMaxHp = math.abs(oldMaxHp - maxHp)
      local num, totalNum = 0, math.min(math.abs(changeHp), 20)
      if 0 == totalNum then
        totalNum = ChangeMaxHp
      end
      childBinder:BindTimer(0.02, totalNum, function()
        num = num + 1
        local curHp = math.floor(oldHp + (hp - oldHp) * num / totalNum)
        self.binder:SetText(self.ui.Text_LifeBloor, string.format("%s/%s", curHp, maxHp))
      end)
      bloodTween = bloodSlider:DOValue(hp / maxHp, 1.2):OnComplete(function()
        if changeHp > 0 then
          bloodReduceImg.fillAmount = hp / maxHp
        end
      end)
      if changeHp < 0 then
        self.ui.Slider_LifeBloor_Effect:SetActive(true)
        bloodReduceTween = bloodReduceImg:DOFillAmount(hp / maxHp, 1.2):OnComplete(function()
          self.ui.Slider_LifeBloor_Effect:SetActive(false)
        end):SetDelay(0.2)
        self.ui.UI_Vx_Battle_Text_Normal_01:SetActive(true)
        local floatUI = UI_Vx_Battle_Text_Normal_01Resource(self.ui.UI_Vx_Battle_Text_Normal_01)
        local animCtrl = self.ui.UI_Vx_Battle_Text_Normal_01:GetComponentInChildren(typeof(UIAnimationController))
        self.binder:SetText(floatUI.Text, changeHp)
        animCtrl:PlayState("UI_Vx_Battle_Text_Normal_01")
      end
    else
      self.binder:SetText(self.ui.Text_LifeBloor, string.format("%s/%s", hp, maxHp))
      self.binder:SetSliderCurValue(self.ui.Slider_LifeBloor, hp / maxHp)
      bloodReduceImg.fillAmount = hp / maxHp
    end
    if not oldHpInfo then
      return
    end
    if hp > oldHp or maxHp > oldMaxHp then
      AudioManager.Instance:PostSoundEvent("EXPLORE_HEAL")
    elseif hp < oldHp or maxHp < oldMaxHp then
      AudioManager.Instance:PostSoundEvent("EXPLORE_HURT")
    end
  end, function()
    role = role or {}
    return {
      [1] = role.hp or 0,
      [2] = role.max_hp or 100
    }
  end)
  local deathResitRes = Btn_Battle_DbgResource(self.ui.Group_Dead)
  self.binder:SetActive(self.ui.Group_Dead, true)
  self.binder:BindToText(deathResitRes.Text_Count, function()
    local deathResist = role.death_resist or 0
    local deathResistTimes = role.death_resist_times or 0
    local coffPlus = role.death_resist_coefficient_plus or 0
    local cfgCoff = DT.GetConstant("Death_resist_coefficient", 0.5)
    local coff = 1 - (cfgCoff - coffPlus / 100)
    local num = math.ceil(deathResist * coff ^ deathResistTimes)
    do return string.format, "%d%%" end
    return string.format, "%d%%", num
  end)
  self.binder:SetText(deathResitRes.Text_Title, LT.Text("Battle_DeathResist"))
  local deathResistDesc = LT.Text("Battle_Tips_DeathResist", true)
  self.binder:BindButtonClick(deathResitRes.uiNode, function()
    local title = LT.Text("Battle_DeathResist")
    self:_ClickToShowTips(title, deathResistDesc, deathResitRes.uiNode)
  end)
  local blackcoin_upgrade_per = "blackcoin_upgrade_per"
  local enchantName = AwakerDataUtils.GetAttrCnName(blackcoin_upgrade_per)
  local luckyEnchantRes = Btn_Battle_DbgResource(self.ui.Group_Fortunate)
  self.binder:BindToText(luckyEnchantRes.Text_Count, function()
    local rate = role[blackcoin_upgrade_per] or 0
    local awakerRate = CopyAwakerDataUtils.GetAwakerAttrs(0, blackcoin_upgrade_per)
    do return string.format, "%s%%", math.ceil(rate + awakerRate) end
    return string.format, "%s%%", math.ceil(rate + awakerRate)
  end)
  self.binder:SetText(luckyEnchantRes.Text_Title, enchantName)
  self.binder:BindButtonClick(luckyEnchantRes.uiNode, function()
    self:_ClickToShowTips(enchantName, LT.Text("Battle_Tips_PhiloStoneDropBonusesTips", true), luckyEnchantRes.uiNode)
  end)
  self.ui.Group_Fortunate:SetActive(false)
  if self.stageGroupType == CommonDefine.StageGroupType.DailyChallenge or self.stageGroupType == CommonDefine.StageGroupType.RailWay then
    local totalRoundRes = Btn_Battle_DbgResource(self.ui.Group_Round)
    self.binder:BindToText(totalRoundRes.Text_Count, function()
      return self.stageData.stats.BoutCount or 0
    end)
    self.binder:SetText(totalRoundRes.Text_Title, LT.Text("Battle_BoutCount"))
    local boutCountDesc = LT.Text("Battle_Tips_BoutCount", true)
    self.binder:BindButtonClick(totalRoundRes.uiNode, function()
      local title = LT.Text("Battle_BoutCount")
      self:_ClickToShowTips(title, boutCountDesc, totalRoundRes.uiNode)
    end)
  end
  self.binder:BindToVisible(self.ui.Group_Round, function()
    return self.stageGroupType == CommonDefine.StageGroupType.DailyChallenge or self.stageGroupType == CommonDefine.StageGroupType.RailWay
  end)
  if self.stageGroupType == CommonDefine.StageGroupType.RailWay then
    local mileUIRes = Btn_Battle_DbgResource(self.ui.Btn_BattleReward)
    self.binder:BindToText(mileUIRes.Text_Count, function()
      local nowMileExp, totalMileExp = RailWayDataUtils.GetRailWayStageMileExpProgress(self.stageId, self.stageData)
      return nowMileExp .. "/" .. totalMileExp
    end)
    self.binder:SetText(mileUIRes.Text_Title, LT.Text("RailWayStageMileExpGetTitle"))
    self.binder:BindButtonClick(mileUIRes.uiNode, function()
      local nowMileExp, totalMileExp = RailWayDataUtils.GetRailWayStageMileExpProgress(self.stageId, self.stageData)
      local respawnedNum = self.stageData.respawnedNum or 0
      local isCrazy = RailWayDataUtils.IsMadnessDifficulty(self.stageId)
      local isSeasonSwitched = RailWayDataUtils.IsSeasonStageGroupSwitched(self.stageGroupId)
      local langKey = isCrazy and TaskDataUtils.GetTimeReplaceLanguageKey("RailWayStageCrazyMileExpGetDescV2", isSeasonSwitched) or "RailWayStageMileExpGetDesc"
      local mileDesc = LT.Textf(langKey, totalMileExp, nowMileExp, respawnedNum)
      local title = LT.Text("RailWayStageMileExpGetTitle")
      self:_ClickToShowTips(title, mileDesc, mileUIRes.uiNode)
    end)
    self.ui.Group_Btns.transform.localScale = Vector3(0.8, 0.8, 1)
  else
    self.ui.Group_Btns.transform.localScale = Vector3(1, 1, 1)
  end
  self.binder:BindToVisible(self.ui.Btn_BattleReward, function()
    return self.stageGroupType == CommonDefine.StageGroupType.RailWay
  end)
  local remainUI = Btn_Battle_DbgResource(self.ui.Group_Battle_Remain)
  self.binder:BindToText(remainUI.Text_Count, function()
    local cards = self:GetCards()
    local unlockNum = 0
    for _, card in ipairs(cards) do
      if not card.lock then
        unlockNum = unlockNum + 1
      end
    end
    return unlockNum
  end)
  self.binder:BindToRaw(function(_, nVal, oVal)
    if not nVal or not oVal then
      return
    end
    if nVal < oVal then
      AudioManager.Instance:PostSoundEvent("CARD_DELETED")
    end
    if oVal < nVal then
      AudioManager.Instance:PostSoundEvent("INGAME_GET_CARD")
      local remainUIAnimCtrl = self.ui.Group_Battle_Remain:GetComponent(typeof(UIAnimationController))
      remainUIAnimCtrl:PlayState("UI_Battle_Extraction_Btn_Mix_02")
    end
  end, function()
    local cards = self:GetCards()
    local unlockNum = 0
    for _, card in ipairs(cards) do
      if not card.showUnLock then
        unlockNum = unlockNum + 1
      end
    end
    return unlockNum
  end)
  self.binder:BindToRaw(function(_, nVal, oVal)
    if not nVal or not oVal then
      return
    end
    if nVal < oVal then
      AudioManager.Instance:PostSoundEvent("INGAME_CARD_SEALED")
    elseif oVal < nVal then
      AudioManager.Instance:PostSoundEvent("INGAME_AWAKER_AWAKEN")
    end
  end, function()
    local cards = self:GetCards()
    local awakenNum = 0
    for _, card in ipairs(cards) do
      if card.lock ~= nil and card.lock == false then
        awakenNum = awakenNum + 1
      end
    end
    return awakenNum
  end)
  local existsInitStates = StageInitialStateModel.Instance:ExistsInitialState(self.stageId)
  local isHide = StageInitialStateModel.Instance:IsHideStageInitState(self.stageId)
  self.binder:SetActive(self.ui.Group_Dissolution, existsInitStates and not isHide)
  self.binder:SetCanvasGroup(self.ui.Group_Dissolution, not (not existsInitStates or isHide) and 1 or 0)
  if existsInitStates then
    local btnIconPath = CommonRes.StageInitialStateBtnIcon.Debuff
    if StageInitialStateModel.Instance:HasPositiveInitialBuffState(self.stageId) then
      btnIconPath = CommonRes.StageInitialStateBtnIcon.Buff
    end
    self.binder:SetImage(self.ui.Image_Icon_Suppress, btnIconPath)
    self.binder:BindToText(self.ui.Text_Count, function()
      do return LT.Text, StageInitialStateModel.Instance:GetStageInitStateText(self.stageId) end
      return LT.Text, StageInitialStateModel.Instance:GetStageInitStateText(self.stageId)
    end)
    self.binder:BindButtonClick(self.ui.Group_Dissolution, function()
      UIManager.Instance:Reopen(Urls.StageInitialStateDetailView, self.stageId)
    end)
  end
  self.binder:BindToRaw(function(_, nVal, oVal)
    if not nVal or not oVal then
      return
    end
    if oVal < nVal then
      AudioManager.Instance:PostSoundEvent("INGAME_GET_CARD_CURSED")
    end
  end, function()
    local cards = self:GetCards()
    local curseCardNum = 0
    for _, card in ipairs(cards) do
      local config = card.cardCfg
      if config then
        local awakerConfigId = config.AwakerID
        local awaker
        if nil ~= awakerConfigId then
          awaker = CopyAwakerDataUtils.GetBattleAwakerData(awakerConfigId)
        end
        local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awaker)
        local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awaker)
        local skillTypes = BattleSkillUtils.GetSkillType(config, breakSkillLevel, potencyLevel)
        if skillTypes[1] == CommonDefine.SkillType.Card_Curse then
          curseCardNum = curseCardNum + 1
        end
      end
    end
    return curseCardNum
  end)
  local moneyRes = Btn_Battle_DbgResource(self.ui.Group_Coin)
  self.binder:SetText(moneyRes.Text_Title, LT.Text("Battle_Btn_GoldInfo"))
  self.binder:BindToText(moneyRes.Text_Count, function()
    return DataCenter.playerData.DMoney.gold or 0
  end)
  self.binder:BindToRaw(function(_, nVal, oVal)
    if not nVal or not oVal then
      return
    end
    if oVal < nVal and 0 ~= nVal then
      AudioManager.Instance:PostSoundEvent("INGAME_GET_COIN")
      local animCtrl = self.ui.Group_Coin:GetComponent(typeof(UIAnimationController))
      animCtrl:PlayState("UI_Dbgcopy_Panel_Main_New_Coin")
    end
  end, function()
    return DataCenter.playerData.DMoney.gold
  end)
  self.binder:BindToVisible(self.ui.Group_Coin, function()
    if not IntroductionDataUtils.IsFinish() then
      return false
    end
    local banIdList = DT.Constant.ProloguePhiloStoneBlock.Data
    return not table.contains(banIdList, self.stageId)
  end)
  self.binder:BindButtonClick(self.ui.Group_Coin, function()
    local data = {
      configId = CommonDefine.CurrencyType.CopiesMoney,
      isMonster = false,
      isItem = nil,
      itemType = CommonDefine.ItemType.CopiesItem,
      rootGameObject = self.ui.Group_Coin,
      autoAdjustPos = true
    }
    self.binder:BindNewComponent(UIManager.GetTipPopRoot(), ItemObjectTip, Item_Public_Object_TipResource, nil, data)
  end)
  self:_UpdateRightBtnSpacing()
end

function WorldStageMainPanel:_UpdateRightBtnSpacing()
  local activeCount = 0
  local transform = self.ui.Group_Dissolution.transform.parent
  for i = 1, transform.childCount do
    local go = transform:GetChild(i - 1).gameObject
    if go.activeSelf then
      activeCount = activeCount + 1
    end
  end
  local T_HorizontalLayoutGroup = typeof(CS.UnityEngine.UI.HorizontalLayoutGroup)
  local horizontalLayoutGroup = transform.gameObject:GetComponent(T_HorizontalLayoutGroup)
  horizontalLayoutGroup.spacing = activeCount > 4 and -17 or -9
end

function WorldStageMainPanel:_ClickToShowTips(title, desc, root)
  local tipsData = {title = title, desc = desc}
  Alert.ShowToolTipsByData(tipsData, root)
end

function WorldStageMainPanel:OnStoryStart()
  self.ui.uiNode:SetActive(false)
end

function WorldStageMainPanel:OnStoryEnd()
  self.ui.uiNode:SetActive(true)
end

function WorldStageMainPanel:BottomAreaVisible(isShow)
  local keeperSkillId = self.stageData.keeperSkillId or 0
  if 0 ~= keeperSkillId then
    self.ui.KeepRoleItem:SetActive(isShow)
  end
  self.ui.Group_Blood:SetActive(isShow)
  self.ui.Group_Battle_Remain:SetActive(isShow)
end

function WorldStageMainPanel:OnExtendedRelicNum(isExtended)
  self.ui.Image_D_Line:SetActive(not isExtended)
end

function WorldStageMainPanel:OpenCopyTaskPanel()
  local tasks = self.stageData.tasks or {}
  local panelData = {
    stageId = self.stageId,
    taskList = tasks,
    stageGroupId = self.stageGroupId
  }
  local stageGroupCfg = DT.StageGroup[self.stageGroupId]
  local url = Urls.WorldStageDescPanel
  if stageGroupCfg.Type == CommonDefine.StageGroupType.DailyChallenge then
    url = Urls.DailyChallengeDescPanel
  end
  UIManager.Instance:Reopen(url, panelData)
  self.binder:onDestroy(function()
    UIManager.Instance:CloseByUrl(url)
  end)
end

function WorldStageMainPanel:ShowAwakerVoice(voiceId, delay, duration)
  local voiceConfig = DT.Voice[voiceId]
  local awakerConfig = DT.AwakerConfig[voiceConfig.AwakerID]
  
  local function ShowVoice()
    self.ui.Image_Voice_Bg:SetActive(true)
    self.binder:SetText(self.ui.Text_Description, voiceConfig.AwakerVoiceContent)
    self.binder:SetText(self.ui.Text_Name, awakerConfig.Name)
    self.binder:SetImage(self.ui.Image_Avatar, AwakerDataUtils.GetLittleIcon(voiceConfig.AwakerID))
    if self.timer ~= nil then
      self.binder:StopTimer(self.timer)
      self.timer = nil
    end
    self.timer = self.binder:BindTimer(duration, 1, nil, function()
      self.ui.Image_Voice_Bg:SetActive(false)
    end)
  end
  
  if not delay then
    ShowVoice()
  else
    delay = delay and delay / 1000 or 1
    self.binder:BindTimer(delay, 1, nil, ShowVoice)
  end
end

function WorldStageMainPanel:OnStageTransfer()
  self.isTransfering = true
  self.ui.UI_Dbgcopy_Item_Effect_Transition:SetActive(true)
  local animator = self.ui.UI_Dbgcopy_Item_Effect_Transition:GetComponent(typeof(CSAnimator))
  AnimatorUtils.SetStateEndInBehavior(animator, nil, function()
    self.isTransfering = false
    self.ui.UI_Dbgcopy_Item_Effect_Transition:SetActive(false)
    EventMgr.Instance.StageTransferEnd:Dispatch()
  end)
end

function WorldStageMainPanel:BindKeeperRole()
  local keeperSkillId = self.stageData.keeperSkillId or 0
  if 0 == keeperSkillId then
    self.ui.KeepRoleItem:SetActive(false)
    return
  end
  self.ui.KeepRoleItem:SetActive(true)
  local roleInfo = {}
  roleInfo.name = PlayerDataUtils.GetName()
  roleInfo.gender = PlayerDataUtils.GetGender()
  roleInfo.keeperSkillId = self.stageData.keeperSkillId
  
  function roleInfo.GetKeeperSkillId()
    return self.stageData.keeperSkillId
  end
  
  function roleInfo.keeper_energy()
    return CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy") or 0
  end
  
  function roleInfo.GetLivesFunc()
    return self.stageData.lives - 1
  end
  
  function roleInfo.maxEnergy()
    local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
    local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
    return max_keeper_energy * (1 + keeper_energy_cost_per / 100)
  end
  
  function roleInfo.GetPercentFunc()
    local keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy") or 0
    local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
    local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
    local max_energy = max_keeper_energy * (1 + keeper_energy_cost_per / 100) or 0
    Logger.Debug("keeper_energy", keeper_energy, "max_energy", max_energy)
    if max_energy <= 0 then
      return 0
    end
    return keeper_energy / max_energy
  end
  
  function roleInfo.GetExtraEnergyPercentFunc()
    local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
    local max_keeper_energy_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy_per") or 0
    local keeper_energy = math.max(CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy") or 0, max_keeper_energy)
    local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
    local skill_keeper_energy = max_keeper_energy * (1 + keeper_energy_cost_per / 100)
    local max_keeper_enery_overlay = max_keeper_energy * (1 + max_keeper_energy_per / 100) * (1 + keeper_energy_cost_per / 100)
    if keeper_energy - skill_keeper_energy <= 0 or max_keeper_enery_overlay - skill_keeper_energy <= 0 then
      return 0
    end
    return (keeper_energy - skill_keeper_energy) / (max_keeper_enery_overlay - skill_keeper_energy)
  end
  
  self:AddViewComponentOnce(self.ui.KeepRoleItem, UIStageKeeperRoleItem, roleInfo)
end

function WorldStageMainPanel:BindRelicList()
  self.binder:SetActive(self.ui.UI_Dbgcopy_Item_RelicList, true)
  self.binder:BindComponent(WorldStageRelicListView(self.ui.UI_Dbgcopy_Item_RelicList))
  if self.ui.ScrollView_Battle_Relic then
    self.binder:SetActive(self.ui.ScrollView_Battle_Relic, false)
  end
end

function WorldStageMainPanel:BindRelicKey()
  local relicKeyTid = DT.GetConstant("RelicKey")
  self.binder:BindToRaw(function(_, nVal, oVal)
    if nVal then
      if self.eyeFXTimer then
        self.binder:StopTimer(self.eyeFXTimer)
        self.eyeFXTimer = nil
      end
      self.eyeFXTimer = self.binder:BindTimer(0.7, 0, nil, function()
        if self.ui then
          if false == oVal then
            AudioManager.Instance:PostSoundEvent("Play_Explore_VFX_GetKey_HUD")
          end
          self.ui.Group_eye:SetActive(nVal)
        end
        self.eyeFXTimer = nil
      end)
    else
      self.ui.Group_eye:SetActive(nVal)
    end
  end, function()
    if not self.stageData.specialItemBag then
      return false
    end
    for _, tbl in pairs(self.stageData.specialItemBag) do
      if tbl.tid == relicKeyTid then
        return true
      end
    end
    return false
  end)
  self.binder:BindButtonClick(self.ui.Group_eye, function()
    local item = self.binder:BindNewComponent(CS.UnityEngine.GameObject.Find("UIRoot/SafeArea/TipPopRoot"), RelicClickTips, UI_Common_Popup_Tips_6Resource, nil, Vue.ref({relicTid = relicKeyTid}), {
      stageId = DataCenter.playerData.DRole.level,
      isGrey = true
    })
    local pos = self.ui.Group_eye.transform.position
    item:SetItemPos2(pos)
  end)
end

function WorldStageMainPanel:RefreshRole()
  local awakerInfos = self.stageData.role.awakerInfos
  local maxNum = 4
  for index = #awakerInfos + 1, maxNum do
    self:RefreshRoleByIndex(index)
  end
end

function WorldStageMainPanel:RefreshRoleByIndex(index)
  self.abilityItemComps = self.abilityItemComps or {}
  local awakerInfos = self.stageData.role.awakerInfos
  local awakerInfo = awakerInfos[index]
  local awakerId = awakerInfo and awakerInfo.tid or 0
  local awakerIcon = self.ui["AwakerSkill_" .. index]
  if not awakerIcon then
    Logger.Warn("AwakerIcon isNil index " .. index)
    return
  end
  awakerIcon:SetActive(awakerId and 0 ~= awakerId)
  if awakerId and 0 ~= awakerId then
    if self.abilityItemComps[awakerIcon] then
      self.abilityItemComps[awakerIcon].binder:teardown()
    end
    self.abilityItemComps[awakerIcon] = self.binder:BindComponent(WorldStageRoleAbilityItem(awakerIcon, awakerId, self.stageData.role, index, self.ui.uiNode))
  end
end

function WorldStageMainPanel:RefreshCardNum()
  local btnUI = Btn_Battle_DbgResource(self.ui.Group_Battle_Remain)
  self.binder:SetText(btnUI.Text_Count, #self.stageData.cards)
end

function WorldStageMainPanel:OnClickCard()
  if UIManager.Instance:GetWindow(Urls.WorldStageCardPanelEx) then
    UIManager.Instance:CloseByUrl(Urls.WorldStageCardPanelEx)
    return
  end
  if WorldStageManager.Instance:IsBlockingMap() then
    return
  end
  local params = {
    title = LT.Text("Battle_CardGroup"),
    drawCards = self:GetCards(),
    needOrder = true
  }
  UIManager.Instance:Reopen(Urls.WorldStageCardPanelEx, params)
  AudioManager.Instance:PostSoundEvent("EXPLORE_DECK_BUTTON")
end

function WorldStageMainPanel:OnClickBlood()
  Alert.ShowToolTips(40001, self.ui.Group_Blood)
end

function WorldStageMainPanel:GetCards()
  do return end
  return CardDataUtils.GetCopyCards
end

function WorldStageMainPanel:OnRespawn(isRespawn)
end

function WorldStageMainPanel:GetCardBagWorldPos()
  return self.ui.Group_Battle_Remain.transform.position
end

function WorldStageMainPanel:FlyCardToDraw(cardTid)
  local cardItem = self.binder:BindComponent(CardBaseComponent(self.ui.uiNode, nil, cardTid, nil, nil, nil, true))
  local destWorldPos = self.ui.Group_Battle_Remain.transform.position
  local cardTransform = cardItem.rootRectTransform
  cardTransform.anchoredPosition = Vector2(0, 0)
  local sequence = DOTween.Sequence(self)
  local transformSequence = DOTween.Sequence(self)
  local totalTime = 0.3
  local firstRotaTime = 0.16
  destWorldPos.y = destWorldPos.y + 3.5
  cardItem.ui.Group_Effect:SetActive(true)
  local trailRender = cardItem.ui.Group_Effect:GetComponentInChildren(typeof(CS.UnityEngine.TrailRenderer))
  transformSequence:Insert(0, cardTransform:DORotate(Vector3(0, 0, 66), firstRotaTime))
  transformSequence:Insert(firstRotaTime, cardTransform:DORotate(Vector3(0, 0, 0), totalTime - firstRotaTime))
  transformSequence:Insert(0, cardTransform:DOMove(destWorldPos, totalTime):SetEase(Tweening.Ease.OutSine))
  sequence:Insert(DOTween.To(function()
    return trailRender.widthMultiplier
  end, function(v)
    trailRender.widthMultiplier = v
  end, 1, totalTime, self))
  sequence:Append(transformSequence)
  sequence:AppendCallback(function()
    Logger.Info("播放完毕，要删掉卡牌")
  end)
end

function WorldStageMainPanel:OnUnbind()
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
  UIManager.Instance:ClearBackExpandFuc()
end

function WorldStageMainPanel:InitUIBothSidesUI(_)
  local leftUIGroup = {
    [self.ui.Group_Left] = 0
  }
  local rightUIGroup = {
    [self.ui.Group_Right] = 0
  }
  leftUIGroup, rightUIGroup = UIManager.Instance:InitBothSidesUIOriPos(leftUIGroup, rightUIGroup)
  UIManager.Instance:UIBothSidesAdaptation(leftUIGroup, rightUIGroup, CommonDefine.BothSideUILimitDeltaLen.WorldStage)
end

return WorldStageMainPanel
