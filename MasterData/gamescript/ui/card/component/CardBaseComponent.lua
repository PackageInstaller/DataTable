local TextAlignmentOptions = CS.TMPro.TextAlignmentOptions
local TempVector2 = CS.UnityEngine.Vector2(0, 0)
local CardBaseComponent, Super = System.NewComponent("CardBaseComponent")
local textEmptyStr = ""
local CARD_DESC_VIEW_HEIGHT_NO_RUNE = 454
local CARD_DESC_VIEW_HEIGHT_WITH_RUNE = 366
local CARD_DESC_VIEW_HEIGHT_CN_NO_RUNE = 298

function CardBaseComponent:ctor(uiNode, uid, configId, selected, cost, battleDesc, offCostColor, showUpgradeTip, cardLv, extraParam)
  Super.ctor(self)
  self.ui = Item_Card_BaseResource(uiNode)
  self.uid = Vue.ref(uid)
  self.configId = Vue.ref(configId)
  self.selected = selected or false
  self.battleDesc = Vue.ref(battleDesc)
  self.cost = Vue.ref(cost)
  self.useCfgDesc = Vue.ref(false)
  self.offCostColor = offCostColor
  self.showUpgradeTip = showUpgradeTip
  self.cardLv = Vue.ref(cardLv)
  if not self.cardLv.value or 0 == self.cardLv.value then
    self.cardLv.value = AwakerDataUtils.GetDBGCardLevel(configId)
  end
  self.runeList = Vue.ref({})
  if extraParam then
    self.awakerData = extraParam.awakerData
    self.runeList.value = {
      extraParam.runeTid
    }
    self.stateList = extraParam.stateList
    self.withoutForwardPanel = extraParam.withoutForwardPanel
    self.shortCutUName = extraParam.shortCutUName
    self.curSkin = extraParam.curSkin
    self.ignoreUnknowImage = extraParam.ignoreUnknowImage
    self.useBattleDesc = extraParam.useBattleDesc
  end
  self.autoAdaptionTextComp = nil
end

function CardBaseComponent:GetCardTypeCfg()
  local card = CardDataUtils.GetCardInfo(self.uid.value)
  if card then
    local cardTye = card.cardType
    local cardTypeCfg = DT.CardType
    for _, cfg in pairs(cardTypeCfg) do
      if cfg.CnID == cardTye then
        return cfg
      end
    end
  end
  do return CardDataUtils.GetCardTypeCfg end
  return CardDataUtils.GetCardTypeCfg, self.configId.value, pairs(cardTypeCfg)
end

function CardBaseComponent:_GetCardFaceAwakerData(awakerTid)
  if self.awakerData then
    return self.awakerData
  end
  return CopyAwakerDataUtils.GetBattleAwakerData(awakerTid) or AwakerDataUtils.GetAwakerData(awakerTid)
end

function CardBaseComponent:OnBind(binder)
  self.binder = binder
  self:_OnBindShortCutComps(binder)
  self.binder:UpdateLocalizedTextAndResouce(self.ui.uiNode)
  self:GetRuneList()
  self.binder:SetActive(self.ui.Image_Select, false)
  self:BindCardName()
  binder:BindToText(self.ui.Text_Positioning, function()
    if not self:CheckConfigValid() then
      return ""
    end
    local typeCfg = self:GetCardTypeCfg()
    return typeCfg and typeCfg.TypeName or ""
  end)
  binder:BindToRaw(function(_, htmlColor)
    if htmlColor then
      binder:SetTextColorByHtml(self.ui.Text_Expenses, htmlColor)
    end
  end, function()
    if not self:CheckConfigValid() then
      return
    end
    local typeCfg = self:GetCardTypeCfg()
    return (typeCfg and typeCfg.CostColorList or {})[1]
  end)
  binder:BindToRaw(function(_, desc)
    if desc then
      local card = CardDataUtils.GetCardInfo(self.uid.value)
      local isConfuse = card and card.IsConfuse and card:IsConfuse()
      self:SetCardDesc(desc, isConfuse)
    end
  end, System.fn(self, self.GetCardDesc))
  binder:BindToRaw(function(_, _, _)
    local cardTypeCfg = self:GetCardTypeCfg()
    if cardTypeCfg then
      binder:SetTextColorByHtml(self.ui.Text_Name, cardTypeCfg.CardNameColor)
      binder:SetTextColorByHtml(self.ui.Text_Desc, cardTypeCfg.CardDescColor)
    end
  end, function()
    if not self:CheckConfigValid() then
      return
    end
    return self.configId.value
  end)
  binder:BindLongPressButton(self.ui.Btn_Mask, System.fn(self, self.onLongPressedCallback), System.fn(self, self.OnCallBack), 0.2)
  binder:BindToRawText(self.ui.Text_Expenses, function()
    self.ui.Text_Expenses:SetActive(true)
    local cfg = CardDataUtils.GetCardConfig(self.configId.value)
    local awakerData = AwakerDataUtils.GetAwakerData(cfg.AwakerID)
    local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awakerData)
    local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awakerData)
    local costCfg = BattleSkillUtils.GetSkillCost(cfg, breakSkillLevel, potencyLevel)
    if not cfg or nil == costCfg then
      self.ui.Text_Expenses:SetActive(false)
      return ""
    end
    if not self:CheckConfigValid() then
      return ""
    end
    if BattleSkillUtils.IsXCostText(costCfg) then
      return "X"
    end
    if self.cost.value then
      local cost = self.cost.value
      if not cost then
        return textEmptyStr
      end
      if tonumber(cost) then
        do return math.max, (tonumber(cost)) end
        return math.max, tonumber(cost), 0, nil, nil, nil
      else
        return cost
      end
    end
    if self.uid.value then
      local cardInfo = CardDataUtils.GetCardInfo()
      if cardInfo and cardInfo.cost then
        return cardInfo.cost
      end
    end
    if nil == tonumber(costCfg) then
      local cardInfo = self.uid.value and CardDataUtils.GetCardInfo(self.uid.value)
      local awaker = CardDataUtils.GetCardAwakerData(self.uid.value, cfg)
      local parserEnv = {
        awaker = awaker,
        card = cardInfo,
        skillId = self.configId.value
      }
      local cmdParser = BattleCmdParserClient(parserEnv)
      do return cmdParser.GetValueByCmd, cmdParser end
      return cmdParser.GetValueByCmd, cmdParser, costCfg
    end
    do return CardDataUtils.GetCardCostWithState, (tonumber(costCfg)) end
    return CardDataUtils.GetCardCostWithState, tonumber(costCfg), self.uid.value, BattleCmdParserClient(parserEnv), cmdParser.GetValueByCmd, cmdParser, costCfg
  end)
  binder:BindToImageSync(self.ui.Image_NameBg, function()
    if not self:CheckConfigValid() then
      return ""
    end
    local cardCfg = CardDataUtils.GetCardConfig(self.configId.value)
    local awakerTid = cardCfg and cardCfg.AwakerID
    if awakerTid and FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(awakerTid, self:_GetCardFaceAwakerData(awakerTid)) then
      local cardTypeCfg = CardDataUtils.GetCardTypeCfg(self.configId.value)
      local favorRes = FavorabilityVisualUtils.GetPremiumCardFaceRes(awakerTid, cardTypeCfg and cardTypeCfg.CnID)
      if favorRes then
        return favorRes
      end
    end
    do return CardDataUtils.GetIconFrame end
    return CardDataUtils.GetIconFrame, self.configId.value, awakerTid, cardTypeCfg and cardTypeCfg.CnID, self:_GetCardFaceAwakerData(awakerTid)
  end)
  binder:BindToImageSync(self.ui.Image_Icon, function()
    if not self:CheckConfigValid() then
      return ""
    end
    local cardIcon = CardDataUtils.GetCardIcon(self.configId.value, self.cardLv.value, self.uid.value, self.curSkin)
    if bg.battleRender then
      local cardUid = self.uid.value
      local card = bg.battleRender.cardMgr:GetCardByUid(cardUid)
      if card then
        local ownerUid = card.ownerUid
        local owner = bg.battleDataCenter:GetAwakerDataModel(ownerUid)
        if owner.tid ~= card.configData.AwakerID then
          local awakerCfg = DT.AwakerConfig[owner.tid]
          if awakerCfg and awakerCfg.PVPCardIcon then
            do return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, awakerCfg.PVPCardIcon end
            return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, awakerCfg.PVPCardIcon, owner.uid
          end
        end
      end
    end
    local cardCfg = CardDataUtils.GetCardConfig(self.configId.value)
    local needShowUnknownIcon = not self.ignoreUnknowImage and table.contains(cardCfg.Type, "Card_KeeperSkill") and not ItemDataUtils.IsPlayerHasKeeperSkill(self.configId.value)
    if needShowUnknownIcon then
      return cardCfg.UnknownIcon
    end
    return cardIcon
  end)
  if self.ui.Image_CardFaceBorder then
    binder:BindToVisible(self.ui.Image_CardFaceBorder, function()
      if not self:CheckConfigValid() then
        return false
      end
      local cardCfg = CardDataUtils.GetCardConfig(self.configId.value)
      if not cardCfg or not cardCfg.AwakerID then
        return false
      end
      local awakerTid = cardCfg.AwakerID
      do return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid, self:_GetCardFaceAwakerData(awakerTid) end
      return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid, self:_GetCardFaceAwakerData(awakerTid)
    end)
    binder:BindToImageSync(self.ui.Image_CardFaceBorder, function()
      local cardCfg = CardDataUtils.GetCardConfig(self.configId.value)
      local awakerTid = cardCfg and cardCfg.AwakerID
      local cardTypeCfg = CardDataUtils.GetCardTypeCfg(self.configId.value)
      do return FavorabilityVisualUtils.GetPremiumCardFaceRes, awakerTid end
      return FavorabilityVisualUtils.GetPremiumCardFaceRes, awakerTid, cardTypeCfg and cardTypeCfg.CnID
    end)
  end
  binder:BindToRaw(function(cbinder, lastRuneId)
    local sizeDelta = self.ui.DescView.gameObject.transform.sizeDelta
    TempVector2.x = sizeDelta.x
    local hNoRune = Utils.IsLangChinese() and CARD_DESC_VIEW_HEIGHT_CN_NO_RUNE or CARD_DESC_VIEW_HEIGHT_NO_RUNE
    local hWithRune = Utils.IsLangChinese() and CARD_DESC_VIEW_HEIGHT_CN_NO_RUNE or CARD_DESC_VIEW_HEIGHT_WITH_RUNE
    if lastRuneId then
      self.ui.Item_Card_Rune:SetActive(true)
      TempVector2.y = hWithRune
      cbinder:BindComponent(CardRuneTypeComponent(self.ui.Item_Card_Rune, lastRuneId, self.uid.value))
    else
      self.ui.Item_Card_Rune:SetActive(false)
      TempVector2.y = hNoRune
    end
    self.ui.DescView.gameObject.transform.sizeDelta = TempVector2
    if self.autoAdaptionTextComp then
      self.autoAdaptionTextComp:ForceMeshUpdate()
    end
  end, function()
    local lastRuneId = self.runeList.value[#self.runeList.value]
    return lastRuneId
  end)
end

function CardBaseComponent:_OnBindShortCutComps(binder)
  if not self.shortCutUName then
    return
  end
  local extraParam = {
    withoutForwardPanel = self.withoutForwardPanel
  }
  binder:BindComponent(ShortCutComp(self.ui.Text_ShortCut, self.shortCutUName, System.fn(self, self.OnCallBack), extraParam))
end

function CardBaseComponent:BindCardName()
  self.binder:BindToRaw(function(cbinder, name)
    cbinder:BindToRaw(function(_, isConfuse)
      if isConfuse then
        math.randomseed(#name)
        name = name:sub(1, math.random(2, 8))
      elseif DataCenter.gameData.CurrTextLanguage == cd.Lang.EN then
        name = StrUtils.CapitalizeFirstLetter(name)
      end
      self.binder:SetText(self.ui.Text_Name, name, nil, nil, {OpenConfuseText = isConfuse})
      if self.ui.Text_Name then
        local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name)
        if comp and self.ui.Btn_Mask then
          comp:SetBtn(self.ui.Btn_Mask)
        end
        if comp and self.OnDrag and self.OnBeginDrag then
          comp:SetDragDelegate(self)
        end
      end
    end, function()
      local card = CardDataUtils.GetCardInfo(self.uid.value)
      return card and card.IsConfuse and card:IsConfuse()
    end)
  end, System.fn(self, self.GetCardName))
end

function CardBaseComponent:GetCardName()
  if not self.configId.value or 0 == self.configId.value then
    return ""
  end
  local card = CardDataUtils.GetCardInfo(self.uid.value)
  if card then
    local cardCfg = card.configData or card.cardCfg
    if not cardCfg then
      local skillId = card.configId or self.configId.value
      cardCfg = DT.Skill[skillId]
    end
    if cardCfg then
      local skillId = cardCfg.ID
      local cardType = cardCfg.Type
      if table.contains(cardType, "Card_KeeperSkill") and not ItemDataUtils.IsPlayerHasKeeperSkill(skillId) then
        do return LT.Text end
        return LT.Text, cardCfg.UnknownName, "Card_KeeperSkill", nil, nil, nil, nil, nil
      end
      local awakerData = CardDataUtils.GetCardAwakerData(self.uid.value, cardCfg)
      local breakSkillLevel, potencyLevel = CardDataUtils.GetCardSkillBreakLevels(awakerData)
      do return BattleSkillUtils.GetSkillName, cardCfg, breakSkillLevel, potencyLevel end
      return BattleSkillUtils.GetSkillName, cardCfg, breakSkillLevel, potencyLevel, {awaker = awakerData, card = card}
    end
  end
  local cardCfg = CardDataUtils.GetCardConfig(self.configId.value)
  if table.contains(cardCfg.Type, "Card_KeeperSkill") and not ItemDataUtils.IsPlayerHasKeeperSkill(self.configId.value) then
    do return LT.Text end
    return LT.Text, cardCfg.UnknownName, "Card_KeeperSkill", CardDataUtils.GetCardSkillBreakLevels(awakerData)
  end
  do return CardDataUtils.GetCardName, self.configId.value end
  return CardDataUtils.GetCardName, self.configId.value, self.uid.value, CardDataUtils.GetCardSkillBreakLevels(awakerData)
end

function CardBaseComponent:GetCardDesc()
  if not self:CheckConfigValid() then
    return ""
  end
  if self.battleDesc.value then
    return self.battleDesc.value
  else
    local desc = CardDataUtils.GetCardDescription(self.configId.value, self.cardLv.value, self.uid.value, self.awakerData, self.stateList, nil, self.useBattleDesc)
    return desc
  end
end

function CardBaseComponent:SetClickCallback(callback)
  self.callback = callback
end

function CardBaseComponent:SetSkipAutoKeywordTips(skip)
  self.skipAutoKeywordTips = skip and true or false
end

function CardBaseComponent:OnCallBack()
  print("CardBaseComponent:tid uid", self.configId.value, self.uid.value or "nil", self.callback)
  if self.callback then
    self.callback()
  end
  if self.skipAutoKeywordTips then
    return
  end
  local cardDesc = self:GetCardDesc()
  if StrUtils.CheckContainsEffectLink(cardDesc) then
    local cardCfg = CardDataUtils.GetCardConfig(self.configId.value)
    local awakerData = self.awakerData or CardDataUtils.GetCardAwakerData(self.uid.value, cardCfg)
    local card = self.uid.value and CardDataUtils.GetCardInfo(self.uid.value) or nil
    UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, {cardDesc}, self.ui.Text_Desc, {
      OpenConfuseText = self.isOpenConfuseText,
      awakerData = awakerData,
      skillTid = self.configId.value,
      skillLevel = self.cardLv and self.cardLv.value or 1,
      card = card
    })
  end
end

function CardBaseComponent:SetLongPressedCallback(callback)
  self.longPressedCallback = callback
end

function CardBaseComponent:onLongPressedCallback()
  if self.longPressedCallback then
    self.longPressedCallback()
  end
end

function CardBaseComponent:SetSelectShow(bool)
  self.binder:SetActive(self.ui.Image_Select, bool)
  self.selected = bool
  if bool then
    AudioManager.Instance:PostSoundEvent("Audio_UI_Com_Selec_Card")
  end
end

function CardBaseComponent:SetSelectFunc()
  local function onClickSelect()
    if self.selected then
      EventMgr.Instance.SelectedCard:Dispatch(false, self.uid.value, self.configId.value)
    else
      EventMgr.Instance.SelectedCard:Dispatch(true, self.uid.value, self.configId.value)
    end
  end
  
  self:SetClickCallback(onClickSelect)
end

function CardBaseComponent:ResetCardId(configId)
  self.configId.value = configId
  self:UpdateCardLevel(AwakerDataUtils.GetDBGCardLevel(configId))
end

function CardBaseComponent:UpdateCardLevel(level)
  if not level then
    return
  end
  self.cardLv.value = level
end

function CardBaseComponent:SetCardDesc(desc, isOpenConfuseText)
  if not self.ui or IsNil(self.ui.Text_Desc) then
    return
  end
  if isOpenConfuseText then
    math.randomseed(#desc)
    desc = desc:sub(1, math.random(50, 70))
  end
  self.isOpenConfuseText = isOpenConfuseText
  desc = LT.ReplaceSpecialChineseChar(desc)
  if not isOpenConfuseText then
    desc = StrUtils.SafeSetWordEffectStr(desc)
    desc = LT.EnsureDescEndsWithPeriod(desc)
  end
  local isRebuildAutoAdaptionText = self.isCardDisplay or self:CheckNeedRebuildAutoAdaptionText(desc)
  local setOk, setErr = pcall(function()
    self.binder:SetText(self.ui.Text_Desc, desc, false, nil, {OpenConfuseText = isOpenConfuseText, banKeywordBtn = true})
  end)
  if not setOk then
    Logger.Warn("CardBaseComponent.SetCardDesc SetText failed configId=%s err=%s", tostring(self.configId and self.configId.value), tostring(setErr))
    self.binder:SetRawText(self.ui.Text_Desc, desc or "")
  end
  self.binder:RemoveUnderline(self.ui.Text_Desc)
  if self.ui.Text_Desc and isRebuildAutoAdaptionText then
    self:RebuildDescAutoAdaption()
  end
end

function CardBaseComponent:RebuildDescAutoAdaption()
  if not self.ui or IsNil(self.ui.Text_Desc) then
    return
  end
  self:RemoveDescAutoAdaption()
  self.autoAdaptionTextComp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Desc, 2, 0, 10, nil, nil, Utils.IsLangChinese())
  if self.autoAdaptionTextComp and self.ui.Btn_Mask then
    self.autoAdaptionTextComp:SetBtn(self.ui.Btn_Mask)
  end
  if self.autoAdaptionTextComp then
    local cfg_adaption = {
      fontSize = 32,
      autoSizeCN = true,
      autoSizeOther = false,
      alignmentCN = TextAlignmentOptions.Center,
      alignmentOther = TextAlignmentOptions.Center,
      widthCN = 338,
      widthOther = 338,
      height = 150,
      x = 0,
      y = -157,
      pivotX = 0.5,
      pivotY = 0.5,
      anchorX = 0.5,
      anchorY = 0.5,
      contentSize = 470
    }
    local cfg_init = {
      fontSize = 34,
      autoSizeCN = true,
      autoSizeOther = false,
      alignmentCN = TextAlignmentOptions.Bottom,
      alignmentOther = TextAlignmentOptions.Bottom,
      widthCN = 358,
      widthOther = 358,
      height = 298,
      x = 0,
      y = 0,
      pivotX = 0.5,
      pivotY = 0,
      anchorX = 0.5,
      anchorY = 0,
      endWaitTime = 2
    }
    if self.OnDrag and self.OnBeginDrag then
      self.autoAdaptionTextComp:SetDragDelegate(self)
    end
    self.autoAdaptionTextComp:ForceUpdate({
      limitPercent = 0.8,
      lineLimit = 4,
      miniFontSize = 30,
      maxFontSize = 34,
      initCfg = cfg_init,
      adaptionCfg = cfg_adaption
    })
  end
end

function CardBaseComponent:RestartDescScroll()
  if not self.ui or IsNil(self.ui.Text_Desc) then
    return
  end
  self:RebuildDescAutoAdaption()
end

function CardBaseComponent:CheckNeedRebuildAutoAdaptionText(desc)
  if not self.prevDesc then
    self.prevDesc = desc
    return true
  end
  if math.abs(self.prevDesc:len() - desc:len()) > 5 then
    self.prevDesc = desc
    return true
  end
  self.prevDesc = desc
  return false
end

function CardBaseComponent:CheckConfigValid()
  if not self.configId.value or 0 == self.configId.value then
    return false
  end
  return true
end

function CardBaseComponent:ShowCardLevel()
end

function CardBaseComponent:EnableRuneList(runeTid)
  self.runeList.value = {runeTid}
end

function CardBaseComponent:SetAblCardLock(isLocked)
end

function CardBaseComponent:SetCardLock(card)
  local isLock = card.lock
  local isCountZero = 0 == card.leftUseCount
  self.binder:SetActive(self.ui.Group_Mask, isLock or isCountZero)
  if isLock then
    self.binder:SetActive(self.ui.Text_Mask_Desc, true)
  end
  if isCountZero then
    self.binder:SetActive(self.ui.Text_Mask_Desc, false)
  end
end

function CardBaseComponent:GetRuneList()
  if table.next(self.runeList.value) then
    return
  end
  if not self.uid.value or 0 == self.uid.value then
    self.runeList.value = {}
    return
  end
  local runes = {}
  if bg.battleRender then
    local card = bg.battleRender.cardMgr:GetCardByUid(self.uid.value)
    if card then
      runes = card.runes or runes
    end
  else
    local cardInfo = CardDataUtils.GetCardInfo(self.uid.value)
    runes = cardInfo and cardInfo.runes or runes
  end
  self.runeList.value = runes
end

function CardBaseComponent:GetTipsList(runeTid)
  local returnList = {}
  if not self.uid.value or 0 == self.uid.value then
    return {}
  end
  local enchantTypeMap = {
    Orange = LT.Text("OrangeEnchantConfigTypeName"),
    White = LT.Text("WhiteEnchantConfigTypeName"),
    Red = LT.Text("RedEnchantConfigTypeName")
  }
  local newRuneConfig = DT.EnchantConfig[runeTid]
  table.insert(returnList, {
    name = LT.Text(newRuneConfig.Name),
    desc = SkillUtils.GetEnchantDesc(runeTid),
    icon = newRuneConfig.Icon,
    label = enchantTypeMap[newRuneConfig.Quality]
  })
  local cardInfo = CardDataUtils.GetCardInfo(self.uid.value)
  for _, tid in pairs(cardInfo.runes) do
    local runeConfig = DT.EnchantConfig[tid]
    table.insert(returnList, {
      name = runeConfig.Name,
      desc = SkillUtils.GetEnchantDesc(runeTid),
      icon = runeConfig.SmallIcon,
      label = enchantTypeMap[runeConfig.Quality]
    })
  end
  local tipList = CardDataUtils.GetCardKeywordTips(self.configId.value, self.uid.value)
  for _, data in pairs(tipList) do
    table.insert(returnList, {
      name = data.name,
      desc = data.desc,
      icon = nil
    })
  end
  return returnList
end

function CardBaseComponent:SetDescByCfgValue(useConfig)
  self.useCfgDesc.value = useConfig
end

function CardBaseComponent:RemoveDescAutoAdaption()
  if self.ui and self.ui.Text_Desc then
    RemoveLuaComp(self.ui.Text_Desc, AutoAdaptionText)
  end
  self.autoAdaptionTextComp = nil
end

function CardBaseComponent:OnUnbind()
  Super.OnUnbind(self)
  FrameWaiter.RemoveWaiter(self.frameTicker)
  self:RemoveDescAutoAdaption()
end

return CardBaseComponent
