local Vector3 = CS.UnityEngine.Vector3
local UIAnimationController = CS.Z1Client.UIAnimationController
local FIRSTANIM_DURATION = 1.5
local MAX_CARD_NUM = 5
local CARD_ORI_SCALE = 0.1
local CARD_NORMAL_SCALE = 1
local DRAW_CARD_DURATION = 0.5
local SORT_CARD_ANIM_DURATION = 1
local PUT_CARD_TO_HAND = 0.5
local DRAW_CARD_PADDING_TIME = 0.3
local BG_DISAPPEAR_DURATION = 1
local PvPSelectInitCardPanel, Super = System.NewClass("PvPSelectInitCardPanel", UIBasePanel)
PvPSelectInitCardPanel.uiResCls = UI_Pvp_Popup_ReplacementResource

function PvPSelectInitCardPanel:ctor(data, isPlayActionOrderAnim)
  Super.ctor(self)
  self.data = data
  self.isPlayActionOrderAnim = isPlayActionOrderAnim
  self.cardUids = data.targetUids
  self.camp = bg.battleDataCenter:GetRoleCamp(data.roleUid)
  self.cardMgr = bg.battleRender.cardMgr:GetCardMgrByCamp(self.camp)
  self.playerId = bg.battleDataCenter:GetPlayerIdByCamp(self.camp)
  self.isChangedBout = false
  self.isSwitchFinish = true
  self.isSwitchAnimDone = true
  AudioManager.Instance:PostSoundEvent("Play_UI_Poker_PVP_Gamestart_Dealcard")
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function PvPSelectInitCardPanel:OnBind(binder)
  self.binder = binder
  self:Init(binder)
  self:OnBindFrist(binder)
  self:OnBindUI()
  self:OnBindEvent()
  self:PlayFristAnim()
  self:HideGameObjInReplay()
  binder:BindComponent(BtnBlockWindow(self.ui.Btn_Block_Window, self.ui.Group_Content))
  binder:BindEvent(EventMgr.Instance.PVPViewChange, System.fn(self, self.OnPVPViewChange))
  EventMgr.Instance.BattleReplayPauseTime:Dispatch(3)
end

function PvPSelectInitCardPanel:HideGameObjInReplay()
  if bg.isReplay then
    self.binder:SetActive(self.ui.Btn_Block_Window, false)
    self.binder:SetActive(self.ui.UI_Common_Item_Btn_2, false)
  end
end

function PvPSelectInitCardPanel:OnPVPViewChange(viewCamp)
  self:SetRendered(viewCamp == self.camp)
end

function PvPSelectInitCardPanel:Init(binder)
  self.binder = binder
  self.spawnPos = self.ui.Group_Card_Spawn.transform.position
  self.cardsPos = {}
  for idx = 1, MAX_CARD_NUM do
    self.cardsPos[idx] = self.ui["UI_Pvp_Item_Card_" .. idx].transform.position
  end
  self.oriScale = Vector3(CARD_ORI_SCALE, CARD_ORI_SCALE, CARD_ORI_SCALE)
  self.normalScale = Vector3(CARD_NORMAL_SCALE, CARD_NORMAL_SCALE, CARD_NORMAL_SCALE)
  self.awakerSortWeightMap = {}
  self.cardInfoGroup = {}
  for idx, uid in pairs(self.cardUids) do
    table.insert(self.cardInfoGroup, self:_CreateCardInfo(uid))
  end
  self:_SortCardInfoGroup()
  for idx, cardInfo in ipairs(self.cardInfoGroup) do
    cardInfo.oriIdx = idx
  end
end

function PvPSelectInitCardPanel:OnBindUI()
  local binder = self.binder
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_2, System.fn(self, self.OnBtnConfirm), nil, function()
    do return LT.Text end
    return LT.Text, "Common_Button_Confirm"
  end)
  binder:BindToText(self.ui.Text_C_First, function()
    return self.camp == bg.battleDataCenter.initCamp and LT.Text("PvPPlayOrderFirst") or LT.Text("PvPPlayOrderSecond")
  end)
  binder:BindToVisible(self.ui.Image_First_Small, function()
    return self.camp == bg.battleDataCenter.initCamp
  end)
  binder:BindToVisible(self.ui.Image_Back_Small, function()
    return self.camp ~= bg.battleDataCenter.initCamp
  end)
end

function PvPSelectInitCardPanel:OnBindEvent()
  self.binder:BindEvent(self.cardMgr.cardsChangeDeckEvent, System.fn(self, self.OnCardChangeDeck))
  local eventMgr = bg.battleRender.eventMgr
  eventMgr:RegisterEvent(BattleRenderEvent.ChangeBoutPhase, self.OnChangeBoutPhase, self)
  eventMgr:RegisterEvent(BattleRenderEvent.PlayOpeningDialogue, self.OnPlayOpeningDialogue, self)
end

function PvPSelectInitCardPanel:OnChangeBoutPhase()
  self.isChangedBout = true
  if self._isInSwitchCardsStage then
    return
  end
  if bg.isReplay then
    self.isSwitchFinish = true
    self.isSwitchAnimDone = true
    self:EndStage()
  end
end

function PvPSelectInitCardPanel:OnPlayOpeningDialogue()
  if bg.isReplay then
    self:OnChangeBoutPhase()
  end
end

function PvPSelectInitCardPanel:OnBindFrist(binder)
  binder:BindToText(self.ui.Text_Position, function()
    return self.camp == bg.battleDataCenter.initCamp and LT.Text("PvPPlayOrderFirst") or LT.Text("PvPPlayOrderSecond")
  end)
  binder:BindToVisible(self.ui.Image_First, function()
    return self.camp == bg.battleDataCenter.initCamp
  end)
  binder:BindToVisible(self.ui.Image_Back, function()
    return self.camp ~= bg.battleDataCenter.initCamp
  end)
end

function PvPSelectInitCardPanel:PlayFristAnim()
  self.ui.Image_Black:SetActive(true)
  local anim = ""
  if self.camp == bg.battleDataCenter.initCamp then
    anim = "UI_Pvp_Popup_First"
  else
    anim = "UI_Pvp_Popup_Back"
  end
  if not string.isempty(anim) then
    local uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
    uiAnimController:PlayState(anim)
    bg.battleRender:PerformWithDelay(FIRSTANIM_DURATION, function()
      uiAnimController:PlayState("UI_Pvp_Popup_First_Close")
      self:LoadOriCardsStage()
    end, self)
  else
    self:LoadOriCardsStage()
  end
end

function PvPSelectInitCardPanel:LoadOriCardsStage()
  EventMgr.Instance.SelectInitCardAnimStart:Dispatch()
  self.binder:SetActive(self.ui.UI_Common_Item_Btn_2, false)
  for idx = 1, MAX_CARD_NUM do
    bg.battleRender:PerformWithDelay(DRAW_CARD_PADDING_TIME * idx, function()
      local cardInfo = self.cardInfoGroup[idx]
      local cardUid = cardInfo.uid
      local cardItem = self:_BindNewCardComp(cardUid, idx)
      cardInfo.pvpReplaceCard = cardItem
      cardItem.ui.uiNode.transform.position = self.spawnPos
      cardItem.ui.uiNode.transform.localScale = self.oriScale
      cardItem.ui.uiNode:SetActive(false)
      self:PlayDrawCardAnim(cardItem, self.cardsPos[idx], self.normalScale, DRAW_CARD_DURATION)
    end, self)
  end
  local lastTime = DRAW_CARD_PADDING_TIME * MAX_CARD_NUM + DRAW_CARD_DURATION
  Awaiter.Dispatch("PVPSelectInitCard_LoadOriCardsStage", lastTime, true)
  bg.battleRender:PerformWithDelay(lastTime, function()
    if not bg.isReplay then
      self.binder:SetActive(self.ui.UI_Common_Item_Btn_2, true)
    end
  end, self)
  EventMgr.Instance.OnReplayExtraScale:Dispatch(3)
end

function PvPSelectInitCardPanel:EnterSwitchCardsStage()
  self.binder:SetActive(self.ui.UI_Common_Item_Btn_2, false)
  local switchCardNum = 0
  for index, info in ipairs(self.cardInfoGroup) do
    local replaceCardItem = self.cardInfoGroup[index].pvpReplaceCard
    if info.selected.value then
      switchCardNum = switchCardNum + 1
      if replaceCardItem then
        replaceCardItem:PlayDisappearAnim()
      end
    end
  end
  self:DeleteSelectedCard()
  self.ui.Image_Prompt:SetActive(false)
  if 0 == switchCardNum then
    self:EndStage()
    return
  end
  local stageTime = 3
  EventMgr.Instance.BattleReplayPauseTime:Dispatch(stageTime)
  self._isInSwitchCardsStage = true
  self.binder:BindTimer(stageTime, 0, nil, function()
    self._isInSwitchCardsStage = false
  end)
end

function PvPSelectInitCardPanel:PlaySwitchedCardsAnim(newCardUids)
  self.isSwitchAnimDone = false
  for _, uid in pairs(newCardUids) do
    for idx = 1, MAX_CARD_NUM do
      if not self.cardInfoGroup[idx] then
        self.cardInfoGroup[idx] = self:_CreateCardInfo(uid, idx)
        local cardItem = self:_BindNewCardComp(uid, idx)
        cardItem:EnterUnClickState()
        self.cardInfoGroup[idx].pvpReplaceCard = cardItem
        cardItem.ui.uiNode.transform.position = self.spawnPos
        cardItem.ui.uiNode.transform.localScale = self.oriScale
        cardItem.ui.uiNode:SetActive(false)
        self.cardInfoGroup[idx].playDrawCardAnim = true
        break
      end
    end
  end
  self:_SortCardInfoGroup()
  local isChangePos = false
  for idx, cardInfo in ipairs(self.cardInfoGroup) do
    if cardInfo.oriIdx ~= idx and not cardInfo.playDrawCardAnim then
      isChangePos = true
      self:PlayCardMoveAnim(cardInfo.pvpReplaceCard, self.cardsPos[idx], SORT_CARD_ANIM_DURATION)
    end
  end
  local awaiter = Awaiter.Dispatch("PlaySwitchedCardsAnim", 3)
  bg.battleRender:PerformWithDelay(isChangePos and SORT_CARD_ANIM_DURATION or 0, function()
    local drawNum = 0
    for idx, cardInfo in ipairs(self.cardInfoGroup) do
      if cardInfo.playDrawCardAnim then
        drawNum = drawNum + 1
        bg.battleRender:PerformWithDelay(DRAW_CARD_PADDING_TIME * drawNum, function()
          AudioManager.Instance:PostSoundEvent("Play_UI_Poker_PVP_Gamestart_Replacecard_Getcard")
          self:PlayDrawCardAnim(cardInfo.pvpReplaceCard, self.cardsPos[idx], self.normalScale, DRAW_CARD_DURATION)
        end, self)
      end
    end
    bg.battleRender:PerformWithDelay(DRAW_CARD_DURATION + drawNum * DRAW_CARD_PADDING_TIME, function()
      awaiter:SetCompleted()
      self.isSwitchAnimDone = true
      self:EndStage()
    end, self)
  end, self)
end

function PvPSelectInitCardPanel:EndStage()
  EventMgr.Instance.OnReplayExtraScale:Dispatch(1)
  local tickTime = 20
  local setAlpha = 1
  if not self.timer then
    self.timer = self.binder:BindTimer(BG_DISAPPEAR_DURATION / tickTime, tickTime, function()
      setAlpha = setAlpha - 1 / tickTime
      if self.ui.Group_Bg then
        self.binder:SetCanvasGroup(self.ui.Group_Bg, setAlpha)
      end
    end, function()
      self.ui.Group_Bg:SetActive(false)
    end)
  end
  if self.isSwitchAnimDone and self.isSwitchFinish then
    local cardUI = self:GetBattlePanel():GetCardUI(self.camp)
    if cardUI then
      cardUI:OnBeginSelectBack()
    end
    for idx, cardInfo in ipairs(self.cardInfoGroup) do
      if cardInfo.pvpReplaceCard then
        cardInfo.pvpReplaceCard:OnSelectBack()
      end
    end
    self.ui.uiNode:SetActive(false)
    bg.battleRender:PerformWithDelay(PUT_CARD_TO_HAND, function()
      EventMgr.Instance.SelectInitCardAnimEnd:Dispatch()
      self:RestartRecord()
      self:Close()
    end, self)
  end
  Awaiter.Dispatch("PVPSelectInitCard_EndStage", 2, true)
end

function PvPSelectInitCardPanel:OnUnbind()
  self.stopAllAwaiter = nil
  if self.countTimer then
    TimerManager.Instance:StopTimer(self.countTimer)
  end
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
  if bg.battleRender then
    bg.battleRender:UnperformWithAllDelaysByTarget(self)
  end
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function PvPSelectInitCardPanel:PlayDrawCardAnim(pvpReplaceCard, tarPos, tarScale, duration)
  pvpReplaceCard.ui.uiNode:SetActive(true)
  pvpReplaceCard.ui.uiNode.transform:DOMove(tarPos, duration)
  pvpReplaceCard.ui.uiNode.transform:DOScale(tarScale, duration)
end

function PvPSelectInitCardPanel:PlayCardMoveAnim(pvpReplaceCard, targetPos, duration)
  pvpReplaceCard.ui.uiNode.transform:DOMove(targetPos, duration)
end

function PvPSelectInitCardPanel:PlayCardPutHandGroup(pvpReplaceCard, targetPos, targetAngle, targetScale, duration)
end

function PvPSelectInitCardPanel:OnCardSelected()
  local selectUids = {}
  for index, info in ipairs(self.cardInfoGroup) do
    if info.selected.value then
      table.insert(selectUids, self.cardInfoGroup[index].uid)
    end
  end
  bg.battleRender:SendCommand(BattleCommand.lg_ClickInitCard, {
    playerId = self.playerId,
    selectUids = selectUids
  })
end

function PvPSelectInitCardPanel:OnBtnConfirm()
  if self.isChangedBout then
    self:ForceClose()
    return
  end
  UIManager.Instance:Show(Urls.UIMaskPanel)
  local selectUids = {}
  for index, info in ipairs(self.cardInfoGroup) do
    if info.selected.value then
      table.insert(selectUids, self.cardInfoGroup[index].uid)
    end
  end
  bg.battleRender:SendCommand(BattleCommand.lg_SelectInitCard, {
    playerId = self.playerId,
    selectUids = selectUids
  })
  AudioManager.Instance:PostSoundEvent("Play_UI_Poker_PVP_Gamestart_Replacecard_Confirm")
end

function PvPSelectInitCardPanel:ForceClose()
  bg.battleRender:UnperformWithAllDelaysByTarget(self)
  for idx, cardInfo in ipairs(self.cardInfoGroup) do
    local replaceCardItem = cardInfo.pvpReplaceCard
    replaceCardItem = replaceCardItem or self:_BindNewCardComp(cardInfo.uid, idx)
    if replaceCardItem then
      replaceCardItem:OnSelectBack()
    end
  end
  EventMgr.Instance.SelectInitCardAnimEnd:Dispatch()
  self:RestartRecord()
  self:Close()
end

function PvPSelectInitCardPanel:OnCardChangeDeck(cards, oldDeck, newDeck)
  if bg.isReplay then
    self:OnRePlayCardChangeDeck(cards, oldDeck, newDeck)
    return
  end
  self:DoCardChangeDeck(cards, oldDeck, newDeck)
end

function PvPSelectInitCardPanel:DoCardChangeDeck(cards, oldDeck, newDeck)
  if oldDeck == bc.CardDeck.SelectInitDeck and newDeck == bc.CardDeck.HandDeck then
    self:StopRecord()
    local delay = self.isSwitchAnimDone and 0.1 or 2
    self.isSwitchFinish = true
    bg.battleRender:PerformWithDelay(delay, function()
      self:EndStage()
    end, self)
    return
  end
  local newCardUids = {}
  if newDeck == bc.CardDeck.SelectInitDeck and oldDeck == bc.CardDeck.DrawDeck then
    self:EnterSwitchCardsStage()
    for _, card in pairs(cards) do
      table.insert(newCardUids, card.uid)
    end
    local cardUI = self:GetBattlePanel():GetCardUI(self.camp)
    if cardUI then
      cardUI:CreateSelectedCard()
      self:PlaySwitchedCardsAnim(newCardUids)
    end
  end
  UIManager.Instance:CloseByUrl(Urls.UIMaskPanel)
end

function PvPSelectInitCardPanel:OnRePlayCardChangeDeck(cards, oldDeck, newDeck)
  self._replayCardsChange = self._replayCardsChange or {}
  if oldDeck ~= bc.CardDeck.SelectInitDeck and newDeck ~= bc.CardDeck.SelectInitDeck then
    return
  end
  if oldDeck == bc.CardDeck.DrawDeck or newDeck == bc.CardDeck.DrawDeck then
    table.insert(self._replayCardsChange, {
      cards,
      oldDeck,
      newDeck
    })
    if 2 == #self._replayCardsChange then
      for i = 1, 2 do
        local changeCards, changeOldDeck, changeNewDeck = table.unpack(self._replayCardsChange[i])
        if changeOldDeck == bc.CardDeck.SelectInitDeck and changeNewDeck == bc.CardDeck.DrawDeck then
          self:MarkReplaySelectCards(changeCards, changeOldDeck, changeNewDeck)
        end
        if changeOldDeck == bc.CardDeck.DrawDeck and changeNewDeck == bc.CardDeck.SelectInitDeck then
          bg.battleRender:PerformWithDelay(0.1, function()
            self:DoCardChangeDeck(changeCards, changeOldDeck, changeNewDeck)
          end, self)
        end
      end
    end
  else
    bg.battleRender:PerformWithDelay(1, function()
      self:DoCardChangeDeck(cards, oldDeck, newDeck)
    end, self)
  end
end

function PvPSelectInitCardPanel:MarkReplaySelectCards(cards, oldDeck, newDeck)
  for index, info in ipairs(self.cardInfoGroup) do
    local replaceCardItem = self.cardInfoGroup[index].pvpReplaceCard
    local uid = replaceCardItem and replaceCardItem.cardUid or 0
    if table.findvalue(cards, uid, "uid") then
      self.cardInfoGroup[index].selected.value = true
    end
  end
end

function PvPSelectInitCardPanel:StopRecord()
  if self.stopAllAwaiter then
    self.stopAllAwaiter:SetCompleted()
  end
  self.stopAllAwaiter = Awaiter:Get()
  EventMgr.Instance.AnimAwaiterArise:Dispatch(self.stopAllAwaiter, "SelectInitCard", nil, true)
end

function PvPSelectInitCardPanel:RestartRecord()
  if self.stopAllAwaiter then
    self.stopAllAwaiter:SetCompleted()
  end
end

function PvPSelectInitCardPanel:DeleteSelectedCard()
  for idx = #self.cardInfoGroup, 1, -1 do
    if self.cardInfoGroup[idx].selected.value then
      self.cardInfoGroup[idx] = nil
    end
  end
end

function PvPSelectInitCardPanel:GetBattlePanel()
  do return UIManager.Instance.GetWindow, UIManager.Instance end
  return UIManager.Instance.GetWindow, UIManager.Instance, Urls.PvPBattleMainPanel
end

function PvPSelectInitCardPanel:_SortCardInfoGroup()
  local cardInfoGroup = table.clone(self.cardInfoGroup)
  if not table.next(self.awakerSortWeightMap) then
    local awakerList = bg.battleScene:GetPlayerAwakerList()
    for idx, awakerData in ipairs(awakerList) do
      self.awakerSortWeightMap[awakerData.configData.ID] = idx
    end
  end
  table.sort(cardInfoGroup, function(a, b)
    if not a then
      return true
    end
    if not b then
      return false
    end
    do return self.cardMgr.CompareCardUid, self.cardMgr, a.uid end
    return self.cardMgr.CompareCardUid, self.cardMgr, a.uid, b.uid
  end)
  self.cardInfoGroup = cardInfoGroup
end

function PvPSelectInitCardPanel:_CreateCardInfo(uid, idx)
  local cardInfo = {
    uid = uid,
    pvpReplaceCard = nil,
    selected = Vue.ref(false),
    oriIdx = idx
  }
  return cardInfo
end

function PvPSelectInitCardPanel:_BindNewCardComp(uid, idx)
  do return self.binder.BindNewComponent, self.binder, self.ui.Group_Card, PvPReplaceCardItem, UI_Pvp_Item_CardResource, uid, self.cardInfoGroup[idx].selected end
  return self.binder.BindNewComponent, self.binder, self.ui.Group_Card, PvPReplaceCardItem, UI_Pvp_Item_CardResource, uid, self.cardInfoGroup[idx].selected, self
end

return PvPSelectInitCardPanel
