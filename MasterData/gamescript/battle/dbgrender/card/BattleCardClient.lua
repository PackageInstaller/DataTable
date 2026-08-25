local BP = bc.BattleProperty
local X_COST_LOGIC_VALUE = -1
local BattleCardClient, Super = System.NewClass("BattleCardClient", BattleEntity)

function BattleCardClient:ctor(config)
  Super.ctor(self)
  self.uid = config.uid
  self.deck = bc.CardDeck.NoneDeck
  self.config = table.clone(config)
  self.srcConfigId = config.configId
  self.usable = Vue.ref(false)
  self.highlightEffect = Vue.ref(false)
  self.onCostChangedEvent = Event()
  self.onCardChangedEvent = Event()
  self.camp = config.camp or bc.BattleCamp.Camp1
  self.ownerUid = config.ownerUid
  self.composeCardUids = config.composeCardUids
  self.randomseed = config.randomseed
  self.orginalOwnerUid = self.ownerUid
  self._handDeckTime = math.maxinteger
  self.vueConfigId = Vue.ref(config.configId)
  self.level = config.level
  self.description = Vue.ref("")
  self.cardArgs = Vue.ref(config.cardArgs)
  self.descArgs = Vue.ref(config.descArgs)
  self.runes = Vue.ref(config.runes or {})
  self:ResetByConfigId(config.configId, true)
  self.ownerRoleDataMode = bg.battleDataCenter:GetAwakerDataModelByCfgId(self.configData.AwakerID)
  if config.ownerUid then
    self.ownerRoleDataMode = bg.battleDataCenter:GetAwakerDataModel(config.ownerUid)
  end
  self.awaker = self.ownerRoleDataMode
  self.property = self:AddBattleComponent(BattlePropertyClient, config.properties)
  if config.deck then
    self:ChangeCardDeck(config.deck)
  end
end

function BattleCardClient:ResetByConfigId(configId, isInit, level)
  if not isInit then
    self.runes.value = nil
  end
  self.vueConfigId.value = configId
  if level then
    self.level = level
  end
  local DT = bg.DT
  self.configId = configId
  self.configData = DT.Skill[configId]
  self.srcConfigData = DT.Skill[configId]
  if nil == self.configData then
    print("没有找到卡牌配置 %s", configId)
    return
  end
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(self.ownerRoleDataMode)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(self.ownerRoleDataMode)
  local cmdList = BattleSkillUtils.GetSkillCmdList(self.configData, breakSkillLevel, potencyLevel)
  self.skillId = cmdList and tonumber(cmdList) or nil
  self.isDeleted = false
end

function BattleCardClient:IsFreeCost()
  if bg.isPVP and not self.configData.Cost then
    return true
  end
end

function BattleCardClient:GetFixedCost()
  for fixedCostIndex, propertyName in ipairs(bc.CardFixedCostKeys) do
    local switchValue = self.property:GetProperty(propertyName)
    if switchValue and switchValue > 0 then
      return fixedCostIndex - 1
    end
  end
  return nil
end

function BattleCardClient:GetResolvedCostText()
  local cfgCost = self.configData.Cost
  if not cfgCost then
    return nil
  end
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(self.ownerRoleDataMode)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(self.ownerRoleDataMode)
  local params = {
    breakSkillLevel = breakSkillLevel,
    potencyLevel = potencyLevel,
    skillId = self.vueConfigId.value,
    awaker = self.ownerRoleDataMode
  }
  do return BattleSkillUtils.GetMatchTQ, cfgCost end
  return BattleSkillUtils.GetMatchTQ, cfgCost, params
end

function BattleCardClient:IsXCost()
  do return BattleSkillUtils.IsXCostText, self:GetResolvedCostText() end
  return BattleSkillUtils.IsXCostText, self:GetResolvedCostText()
end

function BattleCardClient:IsHandKeeperSkillCard()
  do return self.CardTypeMatch, self end
  return self.CardTypeMatch, self, bc.SkillType.Keeper_Skill
end

function BattleCardClient:GetBaseCost()
  if self:IsHandKeeperSkillCard() then
    return self:GetProperty(BP.card_origin_cost) or 0
  end
  local fixedCost = self:GetFixedCost()
  if nil ~= fixedCost then
    return fixedCost
  end
  if self:IsXCost() then
    return X_COST_LOGIC_VALUE
  end
  if not self.configData.Cost then
    return 0
  end
  local originCost = self:GetProperty(BP.card_origin_cost) or 0
  do return math.max, 0 end
  return math.max, 0, originCost + self:GetCostDelta(), self
end

function BattleCardClient:GetCostDelta()
  local cardCostDelta = self.property:GetProperty(BP.card_cost) or 0
  local awakerCostFix = 0
  local cardTypes = self:GetType()
  local roleDataModel = self.ownerRoleDataMode
  if roleDataModel:IsRoleType(bc.RoleType.Awaker) then
    for _, cardType in ipairs(cardTypes) do
      local fixAttrName = bc.CardType2Fix[cardType]
      if fixAttrName then
        awakerCostFix = awakerCostFix + (roleDataModel:GetProperty(fixAttrName) or 0)
      end
    end
    if self:IsCmdCard() then
      awakerCostFix = awakerCostFix + (roleDataModel:GetProperty(BP.awaker_card_cost_fix) or 0)
    end
    local matchSkillType = true
    local limitSkillTypes = {
      bc.SkillType.Card_Strike,
      bc.SkillType.Card_Defend,
      bc.SkillType.Card_Skill
    }
    for _, cardType in ipairs(cardTypes) do
      if not table.contains(limitSkillTypes, cardType) then
        matchSkillType = false
        break
      end
    end
    if matchSkillType then
      awakerCostFix = awakerCostFix + (roleDataModel:GetProperty(BP.awaker_cmdcard_notextend_cost_fix) or 0)
    end
  end
  return cardCostDelta + awakerCostFix
end

function BattleCardClient:GetCostHarmonize()
  local costHarmonize = 0
  local roleDataModel = self.ownerRoleDataMode
  if roleDataModel:IsRoleType(bc.RoleType.Awaker) then
    if self:IsCmdCard() then
      costHarmonize = costHarmonize + (roleDataModel:GetProperty(BP.Awaker_slow_cmd_card_cost_fix) or 0)
    end
    costHarmonize = costHarmonize + (roleDataModel:GetProperty(BP.Awaker_slow_card_cost_fix) or 0)
  end
  return costHarmonize
end

function BattleCardClient:GetCurCost()
  do return self.GetBaseCost end
  return self.GetBaseCost, self
end

function BattleCardClient:IsCmdCard()
  local cardTypes = self:GetType()
  for _, cardType in ipairs(cardTypes or {}) do
    if cardType == bc.SkillType.Card_Strike or cardType == bc.SkillType.Card_Defend or cardType == bc.SkillType.Card_Extend or cardType == bc.SkillType.Card_Skill then
      return true
    end
  end
  return false
end

function BattleCardClient:GetCost()
  if self:IsXCost() then
    return X_COST_LOGIC_VALUE
  end
  if self:IsFreeCost() then
    return
  end
  if self.config.showCost then
    return self.config.showCost
  end
  local baseCost = self:GetBaseCost()
  if -1 == baseCost then
    return -1
  end
  if self:IsHandKeeperSkillCard() then
    return baseCost
  end
  do return math.max, 0 end
  return math.max, 0, baseCost + self:GetCostHarmonize(), self
end

function BattleCardClient:GetCostText()
  if self:IsXCost() then
    return "X"
  end
  do return self.GetCost end
  return self.GetCost, self
end

function BattleCardClient:GetConfigCost()
  if not self.configData.Cost or self:IsXCost() then
    return nil
  end
  return self.property:GetProperty(BP.card_origin_cost) or 0
end

function BattleCardClient:GetType()
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(self.ownerRoleDataMode)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(self.ownerRoleDataMode)
  local configData = DT.Skill[self.vueConfigId.value] or {}
  local cardTypes = BattleUtilServer.GetTQList(configData.Type, breakSkillLevel, potencyLevel) or {}
  local cardTypeFix = self:GetProperty(BP.card_type_strike)
  if cardTypeFix and cardTypeFix > 0 and not table.contains(cardTypes, bc.SkillType.Card_Strike) then
    table.insert(cardTypes, bc.SkillType.Card_Strike)
  end
  return cardTypes
end

function BattleCardClient:CardTypeMatch(cardTypes)
  if type(cardTypes) ~= "table" then
    cardTypes = {cardTypes}
  end
  local myTypes = self:GetType()
  for _, myType in ipairs(myTypes) do
    for _, cardType in ipairs(cardTypes) do
      if myType == cardType then
        return true
      end
    end
  end
  return false
end

function BattleCardClient:SetCost(value, forceChange)
end

function BattleCardClient:SetHighlightEffect(value)
  self.highlightEffect.value = value
end

function BattleCardClient:IsInHand()
  return self.deck == bc.CardDeck.HandDeck
end

function BattleCardClient:CanUseHandKeeperSkill()
  local myCost = self:GetCost() or 0
  if myCost <= 0 then
    return true
  end
  local playerRole = bg.battleDataCenter:GetPlayerRoleDataModel()
  local keeperEnergy = playerRole:GetProperty(BP.keeper_energy) or 0
  if myCost > keeperEnergy then
    return false, bc.CardFailedReason.NoEnergy
  end
  local addTimes = self.property:GetProperty(BP.keeper_skill_card_add_times_on_use) or 0
  if addTimes > 0 then
    local keeperSkillInCd
    if bg.battleDataCenter:IsNewChaosSchool() then
      keeperSkillInCd = bg.battleDataCenter:CheckChaosType2Skill2InCD()
    else
      keeperSkillInCd = bg.battleDataCenter:CheckKeeperSkillInCD()
    end
    if keeperSkillInCd then
      return false, bc.CardFailedReason.LimitUse
    end
  end
  return true
end

function BattleCardClient:CanUse()
  if bg.battleRender and bg.battleRender.battleFinished then
    return false
  end
  if not self.skillId then
    return false, bc.CardFailedReason.Useless
  end
  local myCost = self:GetCost()
  local isUseless = self.property:GetProperty(BP.useless)
  if not self.configData.Cost and bg.isPVE and not self:IsHandKeeperSkillCard() then
    return false
  end
  local camp = bg.battleDataCenter:GetRealCamp()
  local myCamp = bg.battleDataCenter:GetMyCamp()
  local cardCamp = self.camp
  local playerRole = bg.battleDataCenter:GetPlayerRoleDataModel()
  local forbitUseCard = playerRole:GetProperty(BP.forbit_use_card) or 0
  local curEnergy = playerRole:GetProperty(BP.energy)
  if bg.isPVE and bg.battleDataCenter.boutData.phase == bc.BoutPhase.Action then
    curEnergy = bg.battleDataCenter:GetRealEnergy()
  end
  local hpForEnergy = playerRole:GetProperty(BP.hp_for_energy) or 0
  local ownerRole = self.ownerUid and bg.battleDataCenter:GetRoleDataModel(self.ownerUid)
  if not ownerRole and self.configData.AwakerID then
    ownerRole = bg.battleDataCenter:GetRoleDataModelByTid(self.configData.AwakerID)
  end
  if ownerRole then
    forbitUseCard = forbitUseCard + (playerRole:GetProperty(BP.forbit_use_card) or 0)
  end
  local forbidStrikeCard = ownerRole and ownerRole:GetProperty(BP.forbit_strike_card) or 0
  local PVPComa = ownerRole and ownerRole:GetProperty(BP.PVPComa) or 0
  local PVPImmue_Coma = ownerRole and ownerRole:GetProperty(BP.PVPImmue_Coma) or 0
  if isUseless and isUseless > 0 then
    return false, bc.CardFailedReason.Useless
  end
  if camp ~= myCamp then
    return false
  end
  if cardCamp ~= myCamp then
    return false
  end
  if self.deck ~= bc.CardDeck.HandDeck then
    return false, bc.CardFailedReason.NotInHand
  end
  if forbitUseCard and forbitUseCard > 0 then
    return false, bc.CardFailedReason.LimitUse
  end
  if forbidStrikeCard > 0 and self:CardTypeMatch(CommonDefine.AwakerSkillType.Card_Strike) then
    return false, LT.Text(DT.TipsType[10901].Desc)
  end
  if PVPComa > 0 and 0 == PVPImmue_Coma then
    return false, LT.Text(DT.TipsType[10902].Desc)
  end
  if self:IsHandKeeperSkillCard() then
    do return self.CanUseHandKeeperSkill end
    return self.CanUseHandKeeperSkill, self, LT.Text(DT.TipsType[10902].Desc)
  end
  if bg.isPVE and not myCost then
    return false, bc.CardFailedReason.Useless
  end
  if not self:IsXCost() then
    if bg.isPVP and not myCost then
      return true
    end
    if myCost > curEnergy then
      local isAllowIgnoreCost, reason = self:IsAllowIgnoreCost()
      local isCanUseInLessEnergy = hpForEnergy > 0 or isAllowIgnoreCost
      if not isCanUseInLessEnergy then
        return false, reason or bc.CardFailedReason.NoEnergy
      end
    end
  end
  return true
end

function BattleCardClient:IsAllowIgnoreCost()
  if not self.configData.AllowIgnoreCost then
    return false
  end
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(self.ownerRoleDataMode)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(self.ownerRoleDataMode)
  local costText = BattleUtilServer.GetTQList(self.configData.AllowIgnoreCost, breakSkillLevel, potencyLevel)
  local condition, reason
  if type(costText) == "string" then
    condition, reason = table.unpack(string.split(costText, ","))
  elseif type(costText) == "table" then
    condition, reason = table.unpack(costText)
  end
  if 1 == condition then
    return true
  end
  if type(condition) == "string" then
    local parserEnv = {
      awaker = self.ownerRoleDataMode,
      skillId = self.skillId,
      skillLevel = self.skillLevel
    }
    local cmdParser = BattleCmdParserClient(parserEnv)
    if cmdParser:GetValueByCmd(condition) then
      return true
    else
      return false, reason
    end
  end
end

function BattleCardClient:CostHp()
  local role = bg.battleScene:GetPlayerRole()
  if not role then
    return false
  end
  local curEnergy = role:GetEnergy() or 0
  local curCost = self:GetCurCost()
  local hpForEnergy = bg.battleDataCenter:GetPlayerRoleProperty(BP.hp_for_energy) or 0
  if curEnergy < curCost and hpForEnergy and hpForEnergy > 0 then
    return true
  end
  return false
end

function BattleCardClient:CheckUsable()
  local usable = self:CanUse()
  self.usable.value = usable
  return usable
end

function BattleCardClient:IsBlessingCard()
  do return BattleSkillUtils.IsBlessingCard end
  return BattleSkillUtils.IsBlessingCard, self.uid
end

function BattleCardClient:Dispose()
  self.onCostChangedEvent:RemoveAllEvents()
  self.onCardChangedEvent:RemoveAllEvents()
  Super.Dispose(self)
end

function BattleCardClient:Tick(deltaTime)
  Super.Tick(self, deltaTime)
end

function BattleCardClient:GetCritChance()
  do return self.property.GetProperty, self.property end
  return self.property.GetProperty, self.property, BP.crit
end

function BattleCardClient:GetCritDamage()
  do return self.property.GetProperty, self.property end
  return self.property.GetProperty, self.property, BP.crit_damage
end

function BattleCardClient:UpdateCardArgs(args)
  self.cardArgs.value = args.cardArgs
  self.descArgs.value = args.descArgs
end

function BattleCardClient:GetProperty(propertyName)
  if not self.property then
    return 0
  end
  do return self.property.GetProperty, self.property end
  return self.property.GetProperty, self.property, propertyName
end

function BattleCardClient:IsConfuse()
  local ErosionColorInk = self:GetProperty(bc.BattleProperty.ErosionColorInk)
  if ErosionColorInk <= 0 and self.configData and (self.configData.Slot == "Slot_Super" or self.configData.Slot == "UtlSkill_Promote") and self.awaker then
    ErosionColorInk = self.awaker:GetProperty(bc.BattleProperty.ErosionColorInk) or 0
  end
  if ErosionColorInk <= 0 then
    return false
  end
  if bg.isPVP then
    local myCamp = bg.battleDataCenter:GetMyCamp()
    return self.camp == myCamp
  end
  return true
end

function BattleCardClient:ChangeCardDeck(newDeck, config)
  self.deck = newDeck
  if newDeck == bc.CardDeck.HandDeck then
    self._handDeckTime = TimeUtils.GetServerTime()
  end
  self:CheckUsable()
  if newDeck ~= bc.CardDeck.HandDeck then
    self.highlightEffect.value = false
  end
end

function BattleCardClient:GetHandDeckTime()
  return self._handDeckTime
end

function BattleCardClient:Use()
end

function BattleCardClient:GetConfigData()
  return self.configData
end

function BattleCardClient:GetCardIcon()
  local parserEnv = {
    awaker = self.ownerRoleDataMode,
    skillId = self.skillId,
    skillLevel = self.skillLevel
  }
  local cmdParser = BattleCmdParserClient(parserEnv)
  local stateDataList = bg.battleDataCenter:GetCardStateList(self.uid)
  if #stateDataList > 0 then
    for _, stateData in ipairs(stateDataList) do
      local stateCfg = stateData.configData
      if stateCfg and stateCfg.CardBgState then
        cmdParser:SetParserEnv("state", stateData)
        if stateCfg.ShowJudgement and cmdParser:GetValueByCmd(stateCfg.ShowJudgement) then
          local stateCardBg = DT.State[stateData.stateId].CardBgState
          return bg.battleDataCenter:ReplaceSkinPath(stateCardBg, self.ownerUid)
        end
      end
    end
  end
  local icon = BattleSkillUtils.GetSkillIcon(self.configData, {
    awaker = self.ownerRoleDataMode,
    card = self,
    skillId = self.skillId,
    skillLevel = self.skillLevel
  })
  do return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, icon end
  return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, icon, self.ownerUid, nil, stateData.configData, DT.State[stateData.stateId].CardBgState, bg.battleDataCenter:ReplaceSkinPath(stateCardBg, self.ownerUid)
end

function BattleCardClient:GetCardDescription()
  if #(self.composeCardUids or {}) > 0 then
    do return self.GetCardComposeDesc, self end
    return self.GetCardComposeDesc, self, self.composeCardUids, nil, nil
  end
  local desc = self:GetCardSkillDesc()
  local stateDesc = bg.battleDataCenter.stateData:GetCardStateListDesc(self.uid)
  if stateDesc and "" ~= stateDesc then
    if LangTable.NeedJoinSpaceBetweenDesc() then
      desc = LangTable.JoinWesternDescSegment(desc, stateDesc)
    else
      desc = desc .. stateDesc
    end
  end
  do return LT.Text end
  return LT.Text, desc, stateDesc
end

function BattleCardClient:GetCardSkillDesc()
  local awaker = self.ownerRoleDataMode or bg.battleScene:GetAwakerByTid(self.configData.AwakerID, self.camp)
  awaker = awaker or bg.battleScene:GetPlayerRoleByCamp(self.camp)
  do return BattleSkillUtils.GetCardDesc, self.configId, awaker, self.skillLevel or 1, self.descArgs.value end
  return BattleSkillUtils.GetCardDesc, self.configId, awaker, self.skillLevel or 1, self.descArgs.value, self
end

function BattleCardClient:GetCardComposeDesc(composeCardUids)
  if not bg.battleRender then
    return ""
  end
  local cardDescs = {}
  for _, cardUid in ipairs(composeCardUids) do
    local card = bg.battleRender.cardMgr:GetCardByUid(cardUid)
    if card then
      table.insert(cardDescs, card:GetCardSkillDesc())
    end
  end
  local stateDesc = bg.battleDataCenter.stateData:GetCardStateListDesc(self.uid, table.unpack(composeCardUids))
  if stateDesc and "" ~= stateDesc then
    table.insert(cardDescs, stateDesc)
  end
  do return table.concat, cardDescs, LangTable.GetDescJoinSeparator() end
  return table.concat, cardDescs, LangTable.GetDescJoinSeparator()
end

function BattleCardClient:SetLeftUseCount(leftUseCount)
end

function BattleCardClient:OnPropertyChanged(data)
  if data.uid ~= self.uid then
    return
  end
  self.property:SetProperty(data.propertyType, data.value)
  self:CheckUsable()
  self:NotifyCostChanged()
end

function BattleCardClient:NotifyCostChanged()
  self.onCostChangedEvent:Dispatch()
end

function BattleCardClient:NotifyCardChanged()
  self.onCardChangedEvent:Dispatch()
end

function BattleCardClient:ChangeCardId(data)
  self.cardArgs.value = data.cardArgs
  self.descArgs.value = data.descArgs
  self.property = self:AddBattleComponent(BattlePropertyClient, data.properties)
  self.runes.value = data.runes
  self.vueConfigId.value = data.configId
  if data.level then
    self.level = data.level
  end
  local DT = bg.DT
  self.configId = data.configId
  self.configData = DT.Skill[data.configId]
  if self.configData == nil then
    assert(false, "没有找到卡牌配置 " .. data.configId)
  end
  self.ownerRoleDataMode = bg.battleDataCenter:GetAwakerDataModelByCfgId(self.configData.AwakerID)
  if data.ownerUid then
    self.ownerUid = data.ownerUid
    self.ownerRoleDataMode = bg.battleDataCenter:GetAwakerDataModel(data.ownerUid)
  end
  self.awaker = self.ownerRoleDataMode
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(self.ownerRoleDataMode)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(self.ownerRoleDataMode)
  local skillId = BattleSkillUtils.GetSkillCmdList(self.configData, breakSkillLevel, potencyLevel)
  self.skillId = skillId and tonumber(skillId)
  self.isDeleted = false
  self:CheckUsable()
  self:NotifyCostChanged()
  self:NotifyCardChanged()
end

function BattleCardClient:ChangeCardBg(cardItem, vfx)
  local binder = cardItem.binder
  local vfxPrefab = DT.BattleSfxConfig[vfx].FileName .. ".prefab"
  local asset = binder:LoadAsset(vfxPrefab)
  local changeEffGo = binder:Instantiate(asset, cardItem.rootRectTransform)
  UIUtils.RemoveCloneName(changeEffGo)
  cardItem:PlayState("UI_Vx_Card_ChangeAppear_C06")
end

function BattleCardClient:GetConfigName()
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(self.ownerRoleDataMode)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(self.ownerRoleDataMode)
  do return BattleSkillUtils.GetSkillName, self.srcConfigData, breakSkillLevel, potencyLevel end
  return BattleSkillUtils.GetSkillName, self.srcConfigData, breakSkillLevel, potencyLevel, {
    awaker = self.ownerRoleDataMode,
    card = self
  }, self.ownerRoleDataMode
end

return BattleCardClient
