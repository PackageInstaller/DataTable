local tableInsert = table.insert
local tableRemove = table.remove
local CardDataUtils = {
  formulaFunc = {}
}

function CardDataUtils.ResetAll()
  DataCenter.cardData.cardBag = {}
  DataCenter.cardData.eventCardUids = {}
  DataCenter.cardData.handCardCanUse = true
  DataCenter.cardData.realOrderShowCard = false
  DataCenter.cardData.dimensionCardNum = 0
end

function CardDataUtils.GetCardTemplate()
end

function CardDataUtils.CreateCard(cardInfo)
  local info = {}
  for key, value in pairs(cardInfo) do
    if "tid" ~= key and "time" ~= key then
      info[key] = type(value) == "table" and table.deepclone(value) or value
    end
  end
  info.configId = info.configId or cardInfo.tid
  info.timeStamp = info.timeStamp or cardInfo.time
  info.runes = info.runes or {}
  info.cardCfg = DT.Skill[info.configId]
  return info
end

function CardDataUtils.AddCard(cardInfo)
  for index, card in ipairs(DataCenter.cardData.cardBag) do
    if card.uid == cardInfo.uid then
      CardDataUtils.UpdateCard(cardInfo.uid, CardDataUtils.CreateCard(cardInfo))
      return
    end
  end
  local card = CardDataUtils.CreateCard(cardInfo)
  tableInsert(DataCenter.cardData.cardBag, card)
  return card
end

function CardDataUtils.RemoveCard(uid)
  for index, card in ipairs(DataCenter.cardData.cardBag) do
    if card.uid == uid then
      tableRemove(DataCenter.cardData.cardBag, index)
      Logger.Debug("CardDataUtils.RemoveCard: ", uid)
      return
    end
  end
  Logger.Debug("CardDataUtils.RemoveCard() failed: uid not found")
end

function CardDataUtils.UpdateCard(uid, updateInfo)
  local card = CardDataUtils.GetCardFromBag(uid)
  if card then
    local ignoreUpdateFieldList = {
      "isEternalCantChoose"
    }
    local isInCopy = SceneMgr.Instance:IsInCopies()
    if isInCopy then
      do
        local oldRune = card.runes or {}
        local newRunes = updateInfo.runes or {}
        for index, rune in ipairs(newRunes) do
          if rune ~= oldRune[index] then
            card.isShowUpdate = true
          end
        end
        local nCost = tonumber(updateInfo.cost or 0)
        local oCost = tonumber(card.cost or 0)
        if nCost ~= oCost and nCost < oCost then
          card.isShowUpdate = true
        end
        if updateInfo.lock == false and true == card.lock then
          card.isShowUpdate = true
        end
      end
    end
    for _, key in ipairs(ignoreUpdateFieldList) do
      if card[key] ~= updateInfo[key] then
        card.isShowUpdate = false
        card.isForbidShowAdd = true
        break
      end
    end
    for key, value in pairs(updateInfo) do
      card[key] = value
    end
  end
end

function CardDataUtils.ClearCardDisplayInfo(uid)
  if not uid then
    return
  end
  local card = CardDataUtils.GetCardInfo(uid)
  if card then
    card.isShowUpdate = nil
    card.isForbidShowAdd = nil
    card.playAnim = 0
  end
end

function CardDataUtils.GetCopyCards()
  local cards = {}
  for i, card in ipairs(DataCenter.cardData.cardBag) do
    if not CardDataUtils.IsInHideDeck(card) then
      table.insert(cards, card)
    end
  end
  return cards
end

function CardDataUtils.IsInHideDeck(card)
  if not card.deck then
    return false
  end
  return card.deck ~= bc.CardDeck.DrawDeck
end

function CardDataUtils.GetCardInfo(uid)
  if 0 == uid then
    return
  end
  if bg.battleScene then
    local card = bg.battleRender.cardMgr:GetCardByUid(uid)
    if card then
      return card
    end
  end
  do return CardDataUtils.GetCardFromBag end
  return CardDataUtils.GetCardFromBag, uid, uid
end

function CardDataUtils.GetCardFromBag(uid)
  for idx, card in ipairs(DataCenter.cardData.cardBag) do
    if card.uid == uid then
      return card, idx
    end
  end
end

function CardDataUtils.GetCardOwner(uid)
  if bg.battleScene then
    local card = bg.battleRender.cardMgr:GetCardByUid(uid)
    if card then
      local role = bg.battleScene:GetRole(card.ownerUid)
      return role and role.roleDataModel
    end
  end
  local card = CardDataUtils.GetCardInfo(uid)
  if card then
    local awaker = card.cardCfg.AwakerID
    local role = CopyAwakerDataUtils.GetBattleAwakerData(awaker)
    return role
  end
end

function CardDataUtils.GetCardInfoByConfigId(configId)
  for _, card in ipairs(DataCenter.cardData.cardBag) do
    if card.configId == configId and not CardDataUtils.IsInHideDeck(card) then
      return card
    end
  end
end

function CardDataUtils.GetAbilityCards()
  local bag = DataCenter.cardData.cardBag
  local cards = {}
  for _, card in ipairs(bag) do
    if card.cardCfg.CardTypes == CommonDefine.CardType.Ability then
      tableInsert(cards, card)
    end
  end
  return cards
end

function CardDataUtils.GetCardBag()
  return DataCenter.cardData.cardBag
end

function CardDataUtils.RemoveAllCard()
  DataCenter.cardData.cardBag = {}
end

function CardDataUtils.GetAllCardUid()
  local list = {}
  for _, value in ipairs(DataCenter.cardData.cardBag) do
    if not CardDataUtils.IsInHideDeck(value) then
      tableInsert(list, value.uid)
    end
  end
  return list
end

function CardDataUtils.GetEventCardsData()
  return DataCenter.cardData.eventCardUids
end

function CardDataUtils.GetEventCardDataByUid(uid)
  for _, value in ipairs(DataCenter.cardData.eventCardUids) do
    if value.uid == uid then
      return value
    end
  end
  return nil
end

function CardDataUtils.AddEventCardsData(data)
  tableInsert(DataCenter.cardData.eventCardUids, {
    tid = data.tid,
    uid = data.uid
  })
end

function CardDataUtils.RemoveEventCardsData(uid)
  if #DataCenter.cardData.eventCardUids <= 0 then
    return
  end
  for index, data in ipairs(DataCenter.cardData.eventCardUids) do
    if data.uid == uid then
      tableRemove(DataCenter.cardData.eventCardUids, index)
      return
    end
  end
end

function CardDataUtils.ClearEventCardsData()
  DataCenter.cardData.eventCardUids = {}
end

function CardDataUtils.GetHandCardCanUse()
  return DataCenter.cardData.handCardCanUse
end

function CardDataUtils.SetHandCardCanUse(canUse)
  DataCenter.cardData.handCardCanUse = canUse
end

function CardDataUtils.GetRealOrderShowCard()
  return DataCenter.cardData.realOrderShowCard
end

function CardDataUtils.SetRealOrderShowCard(realOrderShowCard)
  DataCenter.cardData.realOrderShowCard = realOrderShowCard
end

function CardDataUtils.GetAllCanSaleCard()
  local list = {}
  for _, value in ipairs(DataCenter.cardData.cardBag) do
    if not table.findvalue(DT.Item[value.configId].CardSpecialAttrs, "CantRemove") and not value.lock then
      tableInsert(list, {
        uid = value.uid,
        configId = value.configId
      })
    end
  end
  return list
end

function CardDataUtils.ShowBattleCardPanel(params, maskClickClose)
  UIManager.Instance:Reopen(Urls.BattleCardPanel, params, maskClickClose)
end

function CardDataUtils.CloseCardRemovePanel()
  UIManager.Instance:CloseByUrl(Urls.CardRemovePanel)
end

function CardDataUtils.ReopneShopCardChoosePanel(data)
  UIManager.Instance:Reopen(Urls.ShopChooseCardPanel, data)
end

function CardDataUtils.CloseShopCardChoosePanel()
  UIManager.Instance:CloseByUrl(Urls.ShopChooseCardPanel)
end

function CardDataUtils.ShowCardGainAnim(tid, callback, source)
  UIManager.Instance:Reopen(Urls.CardGainAnimPanel, tid, callback, source)
end

function CardDataUtils.ShowCardFeatureInfoView(cardUid, cardTid, root, cost, params)
  local panelData = {
    cardUid = cardUid,
    cardTid = cardTid,
    gameObject = root,
    cost = cost,
    params = params
  }
  UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
end

function CardDataUtils.ReplaceDescArgs(desc, descArgs, cnDesc)
  descArgs = descArgs or {
    curValues = {},
    baseValues = {}
  }
  if not cnDesc or type(cnDesc) ~= "string" then
    cnDesc = desc
  end
  desc = LT.Text(desc) or ""
  local slots = SkillUtils.ParseCnDescSlots(cnDesc)
  local replaceParam = SkillUtils.BuildDescArgsReplaceParam(slots, descArgs.curValues)
  desc = SkillUtils.ReplaceDescArgPlaceholders(desc, slots, replaceParam)
  do return StateDataUtils.ReplacePosAwakerNameText end
  return StateDataUtils.ReplacePosAwakerNameText, desc, slots, replaceParam
end

function CardDataUtils.GetCardKeywordTips(cardTid, uid, cardLevel, stateList, awakerData)
  local keyWordTips = {}
  local cardData = CardDataUtils.GetCardInfo(uid)
  local owner = CardDataUtils.GetCardOwner(uid)
  if nil == uid then
    owner = awakerData
  end
  local stateDataList = {}
  local parserEnv = {
    card = cardData,
    awaker = owner,
    skillId = cardTid,
    skillLevel = cardLevel
  }
  local cmdParser = BattleCmdParserClient(parserEnv)
  if bg.battleData and bg.battleData.isMock and bg.battleScene then
    stateDataList = bg.battleDataCenter:GetCardStateList(uid)
  elseif not WorldStageManager.Instance:IsInStage() and not bg.battleScene then
    if stateList and #stateList > 0 then
      for _, state in ipairs(stateList) do
        local stateCfg = type(state.stateId) == "number" and DT.State[state.stateId]
        if not stateCfg then
        else
          local stateCompute = OuterStateCompute(state.stateId, owner, state.layer or 1, state.stateParams, state)
          local desc = stateCompute:GetDesc()
          local name = stateCompute:GetBuffName()
          local icon
          if nil ~= stateCfg.Icon then
            icon = bc.ICON_PATH_PERFIX .. stateCfg.Icon
          end
          if stateCompute:ShowJudgement() then
            local stateInfo = {
              stateId = state.stateId,
              icon = icon,
              name = name,
              desc = desc,
              source = state.source
            }
            table.insert(stateDataList, stateInfo)
          end
        end
      end
    else
      stateDataList = SkillUtils.GetSkillExistStateInfo(owner, cardTid, cardLevel) or {}
    end
  elseif bg.battleScene then
    stateDataList = bg.battleDataCenter:GetCardStateList(uid)
  elseif WorldStageManager.Instance:IsInStage() then
    local runtimeList = StateDataUtils.GetStateListByOwner(uid)
    stateDataList = SkillUtils.MergeCardExistAndRuntimeStates(owner, cardTid, cardLevel, runtimeList, cardData)
  end
  local bgStateDataModel = bg.battleDataCenter and bg.battleDataCenter.stateData
  for _, stateData in ipairs(stateDataList) do
    local stateCfg = DT.State[stateData.stateId]
    cmdParser:SetParserEnv("state", stateData)
    if stateCfg.ShowJudgement and not cmdParser:GetValueByCmd(stateCfg.ShowJudgement) then
    elseif stateCfg.ShowType ~= CommonDefine.StateShowType.Normal and stateCfg.ShowType ~= CommonDefine.StateShowType.Affix then
    else
      local icon
      if stateCfg.Icon then
        icon = bc.ICON_PATH_PERFIX .. stateCfg.Icon
      end
      local desc = stateData.desc or LT.Text(stateCfg.Desc)
      if bgStateDataModel and stateData.stateUid then
        local battleStateDesc = bgStateDataModel:GetStateDesc(stateData.stateUid)
        if not string.isempty(battleStateDesc) then
          desc = battleStateDesc
        end
      elseif stateData.descArgs then
        desc = CardDataUtils.ReplaceDescArgs(LT.Text(stateCfg.Desc), stateData.descArgs)
      end
      local name = stateData.name or LT.Text(stateCfg.Name)
      if stateData.nameArgs then
        name = CardDataUtils.ReplaceDescArgs(LT.Text(stateCfg.Name), stateData.nameArgs, stateCfg.Name)
      end
      table.insert(keyWordTips, {
        icon = icon,
        desc = desc,
        name = name,
        isYellow = false,
        source = stateData.source and stateData.source[1]
      })
    end
  end
  if #(cardData and cardData.composeCardUids or {}) > 0 then
    local things = {}
    for _, cardUid in ipairs(cardData.composeCardUids) do
      local cardInfo = CardDataUtils.GetCardInfo(cardUid)
      if cardInfo then
        local skillId = CardDataUtils.GetCardTid(cardInfo) or 0
        local skillCfg = DT.Skill[skillId]
        if skillCfg and skillCfg.ConjunctiveConstant then
          table.insert(things, skillCfg.ConjunctiveConstant)
        end
      end
    end
    table.insert(keyWordTips, {
      isPoem = true,
      name = LT.Text("Poem"),
      desc = CardPoemGenUtils.GenPoem(things, cardData.randomseed)
    })
  end
  return keyWordTips
end

function CardDataUtils.GetCardKeywordTipsByTid(tid, awakerData)
  local keywordTips = {}
  local hasOwnedAwaker = awakerData.state == CommonDefine.AwakerState.Owned
  local skillLevel = 1
  if hasOwnedAwaker then
    for _, slotData in ipairs(awakerData.skills) do
      if slotData and slotData.tid == tid then
        skillLevel = slotData.level
        break
      end
    end
  end
  local stateInfoList = SkillUtils.GetSkillDescStateInfo(awakerData, tid, skillLevel)
  local parserEnv = {
    awaker = awakerData,
    skillId = tid,
    skillLevel = skillLevel
  }
  local cmdParser = BattleCmdParserClient(parserEnv)
  if stateInfoList then
    for _, tipInfo in ipairs(stateInfoList) do
      local stateConfig = StateDataUtils.GetConfig(tipInfo.stateId)
      if not stateConfig then
      elseif stateConfig.ShowJudgement and not cmdParser:GetValueByCmd(stateConfig.ShowJudgement) then
      elseif stateConfig.ShowType ~= CommonDefine.StateShowType.Affix and stateConfig.ShowType ~= CommonDefine.StateShowType.Normal then
      else
        table.insert(keywordTips, tipInfo)
      end
    end
  end
  return keywordTips
end

function CardDataUtils.GetCardEffectGroupList(cardTid, cardUid, cardLevel, stateList, awakerData)
  local tipList = CardDataUtils.GetCardKeywordTips(cardTid, cardUid, cardLevel, stateList, awakerData)
  local PoemGroup = {
    name = LT.Text("Poem"),
    descList = {}
  }
  local EnchantDescGroup = {
    name = LT.Text("EnchantDesc"),
    descList = {}
  }
  local DerivedCardDescGroup = {
    name = LT.Text("DerivedCardDesc"),
    descList = {}
  }
  local WordItemDescGroup = {
    name = LT.Text("WordItemDesc"),
    descList = {}
  }
  for _, tip in ipairs(tipList) do
    local desc = {}
    desc.icon = tip.icon
    desc.name = tip.name
    desc.desc = tip.desc
    desc.subDesc = tip.subDesc
    desc.layerCountList = {}
    if tip.source and tip.source.sourceType == "Enchant" then
      desc.useBigIcon = true
      table.insert(EnchantDescGroup.descList, desc)
    elseif desc.isPoem then
      table.insert(PoemGroup.descList, desc)
    else
      table.insert(WordItemDescGroup.descList, desc)
    end
  end
  local list = {}
  if #PoemGroup.descList > 0 then
    table.insert(list, PoemGroup)
  end
  if #EnchantDescGroup.descList > 0 then
    table.insert(list, EnchantDescGroup)
  end
  if #DerivedCardDescGroup.descList > 0 then
    table.insert(list, DerivedCardDescGroup)
  end
  if #WordItemDescGroup.descList > 0 then
    table.insert(list, WordItemDescGroup)
  end
  return list
end

function CardDataUtils.CheckEffectDescGroupEmpty(effectDescGroup)
  for _, descGroup in pairs(effectDescGroup) do
    if #descGroup.descList > 0 then
      return false
    end
  end
  return true
end

function CardDataUtils.GetRuneEffectDescGroup(runeCfg)
  local rst = {
    name = LT.Text("EnchantDesc"),
    descList = {}
  }
  local enchantTypeMap = {
    Orange = LT.Text("OrangeEnchantConfigTypeName"),
    White = LT.Text("WhiteEnchantConfigTypeName"),
    Red = LT.Text("RedEnchantConfigTypeName")
  }
  local desc = {}
  desc.icon = runeCfg.SmallIcon
  desc.useBigIcon = true
  desc.name = LT.Text(runeCfg.Name)
  desc.desc = SkillUtils.GetEnchantDesc(runeCfg.ID)
  desc.subDesc = enchantTypeMap[runeCfg.Quality]
  desc.layerCountList = {}
  table.insert(rst.descList, desc)
  return rst
end

function CardDataUtils.GetWordEffectSkillName(wordEffectKey, wordEffectValue, awakerTid, isPVP)
  if "SkillSlot" ~= wordEffectKey then
    return ""
  end
  local slotName = wordEffectValue
  for _, skillCfg in pairs(DT.Skill) do
    if skillCfg.AwakerID == tonumber(awakerTid) and skillCfg.IsPVP == isPVP and skillCfg.Slot == slotName then
      local tSkillName = type(skillCfg.Name)
      if "string" == tSkillName then
        return LT.Text(skillCfg.Name)
      end
      if "table" == tSkillName and skillCfg.Name[1] and type(skillCfg.Name[1]) == "table" and type(skillCfg.Name[1][2]) == "string" then
        return LT.Text(skillCfg.Name[1][2])
      end
    end
  end
end

function CardDataUtils.HasDynamicArgs(desc)
  do return string.find, desc end
  return string.find, desc, "%b[]"
end

function CardDataUtils.ReplaceDynamicArgsInDesc(desc, replaceFunc)
  local result = desc
  for argName in string.gmatch(desc, "%b[]") do
    local numStr = string.match(argName, "%[(.+)]")
    local value = replaceFunc(numStr)
    result = string.gsub(result, "%b[]", value, 1)
  end
  return result
end

function CardDataUtils.GetValueOfCardArg(card, argName)
  if "critical" == argName then
    return string.format("%d", math.floor(card:GetCritChance())) .. "%%"
  elseif "critical_damage" == argName then
    return string.format("%d", math.floor(card:GetCritDamage())) .. "%%"
  end
end

function CardDataUtils.GetCardAwakerData(cardUid, cardCfg)
  local card = cardUid and CardDataUtils.GetCardInfo(cardUid)
  local cardAwaker = card and card.awaker
  local awakerData
  if type(cardAwaker) == "table" then
    awakerData = cardAwaker
  elseif type(cardAwaker) == "number" then
    awakerData = CopyAwakerDataUtils.GetBattleAwakerData(cardAwaker) or AwakerDataUtils.GetAwakerData(cardAwaker)
  end
  awakerData = awakerData or CardDataUtils.GetCardOwner(cardUid)
  if not awakerData then
    cardCfg = cardCfg or card and (card.configData or card.cardCfg)
    if cardCfg and cardCfg.AwakerID then
      awakerData = CopyAwakerDataUtils.GetBattleAwakerData(cardCfg.AwakerID) or AwakerDataUtils.GetAwakerData(cardCfg.AwakerID)
    end
  end
  return awakerData
end

function CardDataUtils.GetCardSkillBreakLevels(awakerData)
  if type(awakerData) == "table" and awakerData.GetProperty then
    local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(awakerData)
    return BattleSkillUtils.GetBreakSkillLevel(awakerData), potencyLevel
  end
  local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awakerData)
  return AwakerDataUtils.GetBreakSkillLevel(awakerData), potencyLevel
end

function CardDataUtils.GetCardName(configId, cardUid)
  local cardCfg = DT.Skill[configId]
  local card = cardUid and CardDataUtils.GetCardInfo(cardUid)
  local awakerData = CardDataUtils.GetCardAwakerData(cardUid, cardCfg)
  local breakSkillLevel, potencyLevel = CardDataUtils.GetCardSkillBreakLevels(awakerData)
  local skillName = BattleSkillUtils.GetSkillName(cardCfg, breakSkillLevel, potencyLevel, {awaker = awakerData, card = card})
  do return LT.Text end
  return LT.Text, skillName, potencyLevel, {awaker = awakerData, card = card}
end

function CardDataUtils.GetSkillCfg(skillId)
  if not skillId then
    return
  end
  return DT.Skill[skillId]
end

function CardDataUtils.GetSkillCfgByField(field, skillId)
  local cfg = CardDataUtils.GetSkillCfg(skillId)
  if not cfg then
    return
  end
  return cfg[field]
end

function CardDataUtils.GetCardIcon(skillId, skillLevel, cardUid, curSkin)
  local cardCfg = DT.Skill[skillId]
  local awakerTid = cardCfg.AwakerID
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(awakerTid) or AwakerDataUtils.GetAwakerData(awakerTid)
  local parserEnv = {
    awaker = awakerData,
    skillId = skillId,
    skillLevel = skillLevel
  }
  local cmdParser = BattleCmdParserClient(parserEnv)
  local stateDataList
  if bg.battleScene then
    stateDataList = bg.battleDataCenter:GetCardStateList(cardUid)
  else
    stateDataList = StateDataUtils.GetStateListByOwner(cardUid)
  end
  local skin = curSkin
  skin = skin or awakerData and awakerData.curSkin
  local skinResNum = AwakerSkinUtils.GetSkinResNum(skin)
  for _, stateData in ipairs(stateDataList) do
    local stateCfg = DT.State[stateData.stateId]
    if stateCfg and stateCfg.CardBgState then
      cmdParser:SetParserEnv("state", stateData)
      if stateCfg.ShowJudgement and cmdParser:GetValueByCmd(stateCfg.ShowJudgement) then
        return AwakerDataUtils.ReplaceSkinRes(stateCfg.CardBgState, awakerTid, skinResNum)
      end
    end
  end
  local cfg = CardDataUtils.GetCardConfig(skillId)
  local card = cardUid and CardDataUtils.GetCardInfo(cardUid)
  local resPath = BattleSkillUtils.GetSkillIcon(cfg, {
    awaker = awakerData,
    card = card,
    skillId = skillId,
    skillLevel = skillLevel
  })
  if not cfg.AwakerID then
    return resPath
  end
  do return AwakerDataUtils.ReplaceSkinRes, resPath, awakerTid end
  return AwakerDataUtils.ReplaceSkinRes, resPath, awakerTid, skinResNum, AwakerDataUtils.ReplaceSkinRes(stateCfg.CardBgState, awakerTid, skinResNum)
end

function CardDataUtils.GetCardConfig(configId)
  local cfg = DT.Skill[configId]
  if not cfg and ApplicationUtils.is_editor_mode() then
    Alert.ShowStr("找不到卡牌 id:" .. tostring(configId))
  end
  return cfg
end

function CardDataUtils.GetCardLevelDesc(cardLv)
  assert(cardLv, "cardLv 为空")
  do return LT.Textf, "CardLevel" end
  return LT.Textf, "CardLevel", cardLv
end

function CardDataUtils.IsShowCardLevel(configId)
  local config = DT.Item[configId]
  assert(DT.config[configId], "卡牌道具不存在, config Id:" .. (configId or "nil"))
  return config.CardTypes ~= CommonDefine.CardType.Ability
end

function CardDataUtils.GetCardDescription(skillId, skillLevel, cardUid, awakerData, stateList, ignoreStateDesc, useBattleDesc)
  local cardArgs, card
  if cardUid then
    card = CardDataUtils.GetCardInfo(cardUid)
    cardArgs = card and card.descArgs
    if #(card and card.composeCardUids or {}) > 0 then
      do return CardDataUtils.GetCardComposeDesc, card, card.composeCardUids, skillLevel, awakerData end
      return CardDataUtils.GetCardComposeDesc, card, card.composeCardUids, skillLevel, awakerData, useBattleDesc, nil, nil, nil, nil
    end
  end
  local skillCfg = DT.Skill[skillId]
  awakerData = awakerData or {}
  if not table.next(awakerData) then
    if SceneMgr.Instance:IsInCopies() then
      if skillCfg.AwakerID then
        awakerData = CopyAwakerDataUtils.GetBattleAwakerData(skillCfg.AwakerID)
      end
    else
      awakerData = AwakerDataUtils.GetAwakerData(skillCfg.AwakerID)
    end
  end
  if ignoreStateDesc then
    card = table.clone(card or {})
    card.ignoreStateDesc = true
  end
  local desc = SkillUtils.GetAwakerSkillDesc(awakerData, skillId, skillLevel, cardArgs, card, stateList, nil, useBattleDesc)
  do return LT.Text end
  return LT.Text, desc, skillLevel, cardArgs, card, stateList, nil, useBattleDesc
end

function CardDataUtils.GetCardComposeDesc(card, composeCardUids, skillLevel, awakerData, useBattleDesc)
  local cardDescs = {}
  for _, cardUid in ipairs(composeCardUids) do
    local cardInfo = CardDataUtils.GetCardInfo(cardUid)
    if cardInfo then
      local desc = CardDataUtils.GetCardDescription(CardDataUtils.GetCardTid(cardInfo), skillLevel, cardUid, awakerData, nil, true, useBattleDesc)
      table.insert(cardDescs, desc)
    end
  end
  local parserEnv = {awaker = awakerData, card = card}
  local cmdParser = BattleCmdParserClient(parserEnv)
  local stateDesc = SkillUtils.__ApendCardStateDesc(awakerData, nil, nil, "", card, cmdParser)
  if stateDesc and "" ~= stateDesc then
    table.insert(cardDescs, stateDesc)
  end
  do return table.concat, cardDescs, LangTable.GetDescJoinSeparator() end
  return table.concat, cardDescs, LangTable.GetDescJoinSeparator()
end

function CardDataUtils.GetCardTid(card)
  return card.tid or card.configId
end

function CardDataUtils.GetCardBattleDescription(configId, showWordEffect)
  if nil == showWordEffect then
    showWordEffect = true
  end
  assert(DT.Item[configId], "卡牌道具不存在, config Id:" .. configId)
  local desc = LT.Text(DT.Item[configId].Desc)
  if showWordEffect then
    desc = CardDataUtils.SetGainCardTips(desc)
  end
  return desc
end

function CardDataUtils.SetGainCardTips(str)
  local showIdList = {}
  for gainStr in string.gmatch(str, "%b{}") do
    local nameStr = ""
    local gainCardIds = string.match(gainStr, "%{(.+)}")
    local idArr = string.split(gainCardIds, ",")
    for index, id in ipairs(idArr) do
      nameStr = nameStr .. CardDataUtils.GetCardName(tonumber(id))
      if index ~= #idArr then
        nameStr = nameStr .. ","
      end
      tableInsert(showIdList, tonumber(id))
    end
    str = string.gsub(str, gainStr, nameStr)
  end
  return str, showIdList
end

function CardDataUtils.GetQualityNum(quality)
  local num = 1
  local cfg = DT.ItemQuality[quality]
  return cfg and cfg.Sort or num
end

function CardDataUtils.GetQualityIconAsset(quality)
  assert(DT.ItemQuality[quality].CardColor, string.format("CardDataUtils.GetQualityIconAsset: DT.ItemQuality[%s].CardColor is nil", quality))
  return DT.ItemQuality[quality].CardColor
end

function CardDataUtils.GetCardTypeCfg(cardTid)
  local skillCfg = DT.Skill[cardTid] or {}
  local awakerData = AwakerDataUtils.GetAwakerData(skillCfg.AwakerID)
  local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awakerData)
  local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awakerData)
  local skillTypes = BattleSkillUtils.GetSkillType(skillCfg, breakSkillLevel, potencyLevel)
  local cardTypeCfg = DT.CardType
  local skillType = skillTypes and skillTypes[1]
  for _, cfg in pairs(cardTypeCfg) do
    if cfg.CnID == skillType then
      return cfg
    end
  end
  if skillType == bc.SkillType.Keeper_Skill then
    for _, cfg in pairs(cardTypeCfg) do
      if cfg.CnID == bc.SkillType.Card_KeeperSkill then
        return cfg
      end
    end
  end
end

function CardDataUtils.GetIconFrame(cardTid)
  local cardCfg = DT.Skill[cardTid] or {}
  local quality = cardCfg.Quality
  local qualityNum = CardDataUtils.GetQualityNum(quality)
  local cardTypeCfg = CardDataUtils.GetCardTypeCfg(cardTid)
  local frameKey = string.format("QualityFrame%s", qualityNum)
  if cardTypeCfg then
    return cardTypeCfg[frameKey]
  end
end

function CardDataUtils.GetTypeIconAsset(cardTid)
  local cfg = DT.Item[cardTid]
  return cfg and DT.GetConstant("Actor_Card_Icon_" .. cfg.SlotID)
end

local CardTypeSortVal = {
  Attack = 1,
  Defense = 2,
  Skill = 3,
  Ability = 4,
  Condition = 5,
  Curse = 6
}

function CardDataUtils.GetCardTypeSort(tid)
  return CardTypeSortVal[DT.Item[tid].CardTypes]
end

function CardDataUtils.CompareCardType(tidA, tidB, isAscend)
  local sortValA = CardTypeSortVal[DT.Item[tidA].CardTypes]
  local sortValB = CardTypeSortVal[DT.Item[tidB].CardTypes]
  if isAscend then
    return sortValA < sortValB
  end
  return sortValA > sortValB
end

function CardDataUtils.GetCanInlayRuneCards()
  local ret = {}
  local canEnchatType = DT.GetOriginalConstant("Enchant_CardType")
  for _, card in ipairs(DataCenter.cardData.cardBag) do
    if CardDataUtils.IsInHideDeck(card) then
    else
      print("-----------------card isEternalCantChoose", card.isEternalCantChoose)
      if card.isEternalCantChoose then
      else
        local awakerData = AwakerDataUtils.GetAwakerData(card.cardCfg.AwakerID)
        local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awakerData)
        local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awakerData)
        local skillTypes = BattleSkillUtils.GetSkillType(card.cardCfg, breakSkillLevel, potencyLevel)
        local skillType = skillTypes[1]
        if card.runes and #card.runes >= 1 then
        elseif not table.contains(canEnchatType, skillType) then
        else
          table.insert(ret, {
            uid = card.uid,
            configId = card.configId,
            cardCfg = card.cardCfg
          })
        end
      end
    end
  end
  return ret
end

function CardDataUtils.GetInlayedRuneCards()
  local ret = {}
  for _, card in ipairs(DataCenter.cardData.cardBag) do
    if card.runes and #card.runes > 0 then
      table.insert(ret, {
        uid = card.uid,
        configId = card.configId
      })
    end
  end
  return ret
end

function CardDataUtils.SortCardsByActorOrder(cards, order)
  order = order or CommonDefine.SortOrder.Ascend
  if not cards then
    return
  end
  if #cards <= 1 then
    return cards
  end
  local teamDic = {}
  local teamData = TeamDataUtils.GetTeamData()
  if not teamData or not teamData.awakerTids then
    Logger.Info("找不到teamData, curSelectTeamTid:", debug.traceback())
    return cards
  end
  for index, roleTid in pairs(teamData.awakerTids) do
    teamDic[roleTid] = index
  end
  local cardDic = {}
  for _, card in pairs(cards) do
    if card then
      local tid = card.configId or card.tid
      local cardCfg = card.cardCfg or DT.Item[tid]
      if cardCfg.ActorID then
        if not cardDic[cardCfg.ActorID] then
          cardDic[cardCfg.ActorID] = {}
        end
        local slot = CardDataUtils.GetCardInfo(card.uid).slot
        cardDic[cardCfg.ActorID][tid] = slot or 99
      end
    end
  end
  local actorCard = order == CommonDefine.SortOrder.Ascend and 0 or 1
  local notActorCard = order == CommonDefine.SortOrder.Ascend and 1 or 0
  
  local function compare(a, b)
    if order == CommonDefine.SortOrder.Ascend then
      return a < b
    end
    return b < a
  end
  
  local function sortFunc(a, b)
    local aTid = a.configId or a.tid
    local bTid = b.configId or b.tid
    local cardCfgA = a.cardCfg or DT.Item[aTid]
    local cardCfgB = b.cardCfg or DT.Item[bTid]
    local roleA = cardCfgA.ActorID
    local roleB = cardCfgB.ActorID
    local roleIndexA = teamDic[roleA]
    local roleIndexB = teamDic[roleB]
    local roleSortA = roleA and roleIndexA and actorCard or notActorCard
    local roleSortB = roleB and roleIndexB and actorCard or notActorCard
    if roleSortA == roleSortB and roleSortA == actorCard then
      if roleIndexA == roleIndexB then
        local slotA = cardDic[roleA][aTid]
        local slotB = cardDic[roleB][bTid]
        if slotA == slotB then
          do return compare, a.uid end
          return compare, a.uid, b.uid
        end
        do return compare, slotA end
        return compare, slotA, slotB
      end
      do return compare, roleIndexA end
      return compare, roleIndexA, roleIndexB, slotA, slotB
    else
      if roleSortA == roleSortB and roleSortA == notActorCard then
        do return compare, a.uid end
        return compare, a.uid, b.uid, slotA, slotB
      end
      do return compare, roleSortA end
      return compare, roleSortA, roleSortB, slotA, slotB
    end
  end
  
  table.sort(cards, sortFunc)
  return cards
end

function CardDataUtils.SetDimensionCardNum(num)
  DataCenter.cardData.dimensionCardNum = num
end

function CardDataUtils.GetDimensionCardNum()
  return DataCenter.cardData.dimensionCardNum
end

function CardDataUtils.SetDimensionCardMax(reachMax)
  DataCenter.cardData.dimensionCardMax = reachMax
end

function CardDataUtils.GetDimensionCardMax()
  return DataCenter.cardData.dimensionCardMax
end

function CardDataUtils.GetCardCostWithState(cost, cardUid)
  if not cardUid or not cost then
    return cost
  end
  local card_cost = "card_cost"
  local stateList = StateDataUtils.GetStateListByOwner(cardUid)
  for _, state in ipairs(stateList) do
    local stateCfg = DT.State[state.stateId]
    if stateCfg.ExistProperty and stateCfg.ExistProperty[card_cost] then
      local cmdParser = BattleCmdParserClient({state = state})
      cost = cost + cmdParser:GetValueByCmd(stateCfg.ExistProperty[card_cost])
    end
  end
  do return math.max, 0 end
  return math.max, 0, cost, ipairs(stateList)
end

return CardDataUtils
