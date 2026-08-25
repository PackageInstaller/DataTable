local BattleHandCardLogUtils = {}
local LOG_TAG = "[PVPHandCard]"

function BattleHandCardLogUtils.IsEnabled()
  return bg and bg.isPVP
end

function BattleHandCardLogUtils.GetPhaseName(phase)
  if phase == bc.BoutPhase.None then
    return "None"
  elseif phase == bc.BoutPhase.Begin then
    return "Begin"
  elseif phase == bc.BoutPhase.Action then
    return "Action"
  elseif phase == bc.BoutPhase.End then
    return "End"
  end
  do return tostring end
  return tostring, phase
end

function BattleHandCardLogUtils.FormatDeck(deck)
  do return tostring end
  return tostring, deck
end

function BattleHandCardLogUtils.FormatCardUidList(cards)
  if not cards or 0 == #cards then
    return "-"
  end
  local parts = {}
  for _, card in ipairs(cards) do
    if card then
      table.insert(parts, string.format("%s/%s", tostring(card.uid), tostring(card.configId)))
    end
  end
  do return table.concat, parts end
  return table.concat, parts, ",", ipairs(cards)
end

function BattleHandCardLogUtils.CountHandMapEntries(cardUI)
  if not cardUI or not cardUI.cardItemMap then
    return 0, 0
  end
  local handMapCount = 0
  local totalMapCount = 0
  for cardData, _ in pairs(cardUI.cardItemMap) do
    totalMapCount = totalMapCount + 1
    if cardData and cardData.deck == bc.CardDeck.HandDeck then
      handMapCount = handMapCount + 1
    end
  end
  return handMapCount, totalMapCount
end

function BattleHandCardLogUtils.BuildContext(cardUI, cardMgr)
  cardMgr = cardMgr or cardUI and cardUI.cardMgr
  local camp = cardMgr and cardMgr.camp or "?"
  local myCamp = (not cardUI or not cardUI.myCamp) and bg.battleDataCenter and bg.battleDataCenter:GetMyCamp()
  local boutData = bg.battleDataCenter and bg.battleDataCenter.boutData
  local phase = boutData and boutData.phase
  local handDataCount = 0
  if cardMgr then
    local handList = cardMgr:GetHandCardList()
    handDataCount = handList and #handList or 0
  end
  local handMapCount, totalMapCount = BattleHandCardLogUtils.CountHandMapEntries(cardUI)
  return {
    camp = camp,
    myCamp = myCamp,
    isMyCamp = cardUI and cardUI:IsMyCamp() or camp == myCamp,
    phase = BattleHandCardLogUtils.GetPhaseName(phase),
    isPVPSelecting = cardUI and cardUI.isPVPSelecting and cardUI.isPVPSelecting.value or false,
    uiVisible = bg.battlePanel and bg.battlePanel:GetUIVisible() or false,
    isReplay = bg.isReplay,
    handDataCount = handDataCount,
    handMapCount = handMapCount,
    totalMapCount = totalMapCount,
    boutCamp = boutData and boutData.camp
  }
end

function BattleHandCardLogUtils.FormatCardItemBrief(cardItem)
  if not cardItem then
    return "nil"
  end
  local uid = cardItem.GetUid and cardItem:GetUid()
  local handIndex = cardItem.GetHandIndex and cardItem:GetHandIndex()
  local hasTf = cardItem.rootRectTransform and not IsNil(cardItem.rootRectTransform)
  local inAnim = cardItem.IsInAnyAnimState and cardItem:IsInAnyAnimState()
  do return string.format, "uid=%s idx=%s tf=%s anim=%s", tostring(uid), tostring(handIndex), tostring(hasTf), tostring(inAnim) end
  return string.format, "uid=%s idx=%s tf=%s anim=%s", tostring(uid), tostring(handIndex), tostring(hasTf), tostring(inAnim)
end

function BattleHandCardLogUtils.Emit(action, cardUI, detail, cardMgr, reportApus)
  if not BattleHandCardLogUtils.IsEnabled() then
    return
  end
  local ctx = BattleHandCardLogUtils.BuildContext(cardUI, cardMgr)
  local msg = string.format("%s %s camp=%s my=%s phase=%s boutCamp=%s selecting=%s uiVisible=%s replay=%s hand=%d/mapHand=%d/mapAll=%d %s", LOG_TAG, action, tostring(ctx.camp), tostring(ctx.isMyCamp), ctx.phase, tostring(ctx.boutCamp), tostring(ctx.isPVPSelecting), tostring(ctx.uiVisible), tostring(ctx.isReplay), ctx.handDataCount, ctx.handMapCount, ctx.totalMapCount, detail or "")
  if reportApus then
    Logger.Warn(msg)
    Logger.ReportApusInfo("[PVPHandCard] {action} camp={camp} hand={handCount} mapHand={mapHand} mapAll={mapAll} detail={detail}", action, tostring(ctx.camp), ctx.handDataCount, ctx.handMapCount, ctx.totalMapCount, detail or "-")
  else
    Logger.Info(msg)
  end
end

function BattleHandCardLogUtils.LogInfo(action, cardUI, detail, cardMgr)
  BattleHandCardLogUtils.Emit(action, cardUI, detail, cardMgr, false)
end

function BattleHandCardLogUtils.LogAnomaly(action, cardUI, detail, cardMgr)
  BattleHandCardLogUtils.Emit(action, cardUI, detail, cardMgr, true)
end

function BattleHandCardLogUtils.IsHandDeckRelated(oldDeck, newDeck)
  return oldDeck == bc.CardDeck.HandDeck or newDeck == bc.CardDeck.HandDeck
end

function BattleHandCardLogUtils.LogDeckChangeData(cardMgr, cardList, oldDeck, newDeck, reason, show)
  if not BattleHandCardLogUtils.IsEnabled() then
    return
  end
  if not BattleHandCardLogUtils.IsHandDeckRelated(oldDeck, newDeck) then
    return
  end
  local cardUI = bg.battlePanel and bg.battlePanel:GetCardUI(cardMgr.camp)
  local detail = string.format("data old=%s new=%s reason=%s show=%s uids=%s", BattleHandCardLogUtils.FormatDeck(oldDeck), BattleHandCardLogUtils.FormatDeck(newDeck), tostring(reason), tostring(show), BattleHandCardLogUtils.FormatCardUidList(cardList))
  BattleHandCardLogUtils.LogInfo("DeckChangeData", cardUI, detail, cardMgr)
end

function BattleHandCardLogUtils.LogDeckChangeUI(cardUI, cards, oldDeck, newDeck, reason, show, tag)
  if not BattleHandCardLogUtils.IsEnabled() then
    return
  end
  if not BattleHandCardLogUtils.IsHandDeckRelated(oldDeck, newDeck) then
    return
  end
  local detail = string.format("%s old=%s new=%s reason=%s show=%s uids=%s", tag or "UI", BattleHandCardLogUtils.FormatDeck(oldDeck), BattleHandCardLogUtils.FormatDeck(newDeck), tostring(reason), tostring(show), BattleHandCardLogUtils.FormatCardUidList(cards))
  BattleHandCardLogUtils.LogInfo("DeckChangeUI", cardUI, detail)
end

function BattleHandCardLogUtils.LogMissingCardItems(cardUI, handCardDataList)
  if not BattleHandCardLogUtils.IsEnabled() or not cardUI then
    return
  end
  local missingParts = {}
  for index, cardData in ipairs(handCardDataList or {}) do
    local cardItem = cardUI.cardItemMap[cardData]
    if not cardItem then
      table.insert(missingParts, string.format("#%d uid=%s cfg=%s noItem", index, tostring(cardData.uid), tostring(cardData.configId)))
    elseif IsNil(cardItem.rootRectTransform) then
      table.insert(missingParts, string.format("#%d uid=%s cfg=%s nilTf", index, tostring(cardData.uid), tostring(cardData.configId)))
    end
  end
  if 0 == #missingParts then
    return
  end
  BattleHandCardLogUtils.LogAnomaly("MissingCardItem", cardUI, table.concat(missingParts, "; "))
end

function BattleHandCardLogUtils.LogStaleHandUI(cardUI, removeCards)
  if not (BattleHandCardLogUtils.IsEnabled() and removeCards) or 0 == #removeCards then
    return
  end
  local parts = {}
  for _, cardData in ipairs(removeCards) do
    local cardItem = cardUI.cardItemMap[cardData]
    table.insert(parts, string.format("uid=%s cfg=%s item=%s", tostring(cardData.uid), tostring(cardData.configId), BattleHandCardLogUtils.FormatCardItemBrief(cardItem)))
  end
  BattleHandCardLogUtils.LogAnomaly("RemoveStaleHandUI", cardUI, table.concat(parts, "; "))
end

function BattleHandCardLogUtils.LogRecoverHandUI(cardUI, handCardDataList)
  if not BattleHandCardLogUtils.IsEnabled() then
    return
  end
  BattleHandCardLogUtils.LogAnomaly("RecoverHandUI", cardUI, string.format("recreate uids=%s", BattleHandCardLogUtils.FormatCardUidList(handCardDataList)))
end

function BattleHandCardLogUtils.LogRemoveCards(cardUI, cards, isDispose, source)
  if not (BattleHandCardLogUtils.IsEnabled() and cards) or 0 == #cards then
    return
  end
  local handCards = {}
  for _, card in ipairs(cards) do
    if card and card.deck == bc.CardDeck.HandDeck then
      table.insert(handCards, card)
    end
  end
  if 0 == #handCards then
    return
  end
  local detail = string.format("source=%s dispose=%s uids=%s", tostring(source), tostring(isDispose), BattleHandCardLogUtils.FormatCardUidList(handCards))
  BattleHandCardLogUtils.LogInfo("RemoveCards", cardUI, detail)
end

function BattleHandCardLogUtils.LogForceRecycle(cardUI, cardItem, source)
  if not BattleHandCardLogUtils.IsEnabled() or not cardItem then
    return
  end
  local cardData = cardItem.card and cardItem.card.value
  if not cardData then
    return
  end
  local handMap = cardUI.cardMgr:GetCardMapByDeck(bc.CardDeck.HandDeck)
  if not handMap[cardData.uid] and cardData.deck ~= bc.CardDeck.HandDeck then
    return
  end
  local detail = string.format("source=%s card=%s dataDeck=%s inHandMap=%s", tostring(source), BattleHandCardLogUtils.FormatCardItemBrief(cardItem), BattleHandCardLogUtils.FormatDeck(cardData.deck), tostring(handMap[cardData.uid] ~= nil))
  BattleHandCardLogUtils.LogAnomaly("ForceRecycle", cardUI, detail)
end

return BattleHandCardLogUtils
