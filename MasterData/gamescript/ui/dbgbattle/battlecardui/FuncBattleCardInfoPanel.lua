local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local SaveAndReload = CS.Z1Client.SaveAndReload
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local FuncBattleCardInfoPanel, Super = System.NewClass("FuncBattleCardInfoPanel", UIBasePanel)
FuncBattleCardInfoPanel.uiResCls = Func_Battle_CardInfoResource

function FuncBattleCardInfoPanel:ctor(battleCardClient, battleTouchPos, extraParams)
  self.battleCard = Vue.ref(battleCardClient)
  self.battleTouchPos = battleTouchPos
  self.extraParams = extraParams or {}
  self.cardYTw = nil
  self.cardXTw = nil
  self._keywordSide = nil
  self._cardInfoTransform = nil
  self.displayCardItem = nil
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function FuncBattleCardInfoPanel:OnBind(binder)
  self.binder = binder
  self.ui.Btn_Mask:SetActive(not self.extraParams.hideMask)
  AudioManager.Instance:PostSoundEvent("SET_STATE_A_FT_CARDVIEW")
  binder:onDestroy(function()
    AudioManager.Instance:PostSoundEvent("SET_STATE_A_FT_CARDVIEW_END")
  end)
  if self.battleTouchPos then
    self.ui.Image_Bg:SetActive(false)
  else
    self.ui.Image_Bg:SetActive(true)
  end
  self:BindCardComponent()
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  self:_OnBindGroupKeyWord(binder)
  self:SavePosition()
  if self.battleTouchPos then
    self:UpdateBattleTouchPos(self.battleCard.value, self.battleTouchPos, true)
  end
  self.binder:onDestroy(function()
    self:ReloadPosition()
  end)
end

function FuncBattleCardInfoPanel:_OnBindGroupKeyWord(binder)
  binder:BindToRaw(function(childBinder, battleCard)
    if not battleCard or battleCard:IsConfuse() then
      self.ui.Group_Keyword:SetActive(false)
      return
    end
    local cardUid = battleCard.uid
    local cardTid = battleCard.configId
    local list = CardDataUtils.GetCardEffectGroupList(cardTid, cardUid)
    local awakerData = CardDataUtils.GetCardOwner(cardUid)
    self.ui.Group_Keyword:SetActive(true)
    childBinder:BindComponent(CommonKeyWordDescGroup(self.ui.Group_Keyword, {
      self.battleCard.value:GetCardDescription()
    }, list, nil, {
      needAutoScroll = true,
      needDelayAdjustLayout = true,
      awakerData = awakerData,
      card = battleCard,
      skillLevel = battleCard.level
    }))
  end, function()
    return self.battleCard.value
  end, true)
end

function FuncBattleCardInfoPanel:BindCardComponent()
  local card = self.battleCard.value
  local myCamp = card and card.camp or bg.battleDataCenter and bg.battleDataCenter:GetMyCamp() or bc.BattleCamp.Camp1
  local cardComp = self.binder:BindComponent(BattleCardItem(self.ui.Item_Battle_Card_1, card, true, myCamp))
  cardComp:SetSkipAutoKeywordTips(true)
  self.displayCardItem = cardComp
end

function FuncBattleCardInfoPanel:RefreshDisplayCardItem()
  local cardItem = self.displayCardItem
  local card = self.battleCard and self.battleCard.value
  if not cardItem or not card then
    return
  end
  cardItem:Init(card, nil, cardItem.gestureCallbacks)
end

function FuncBattleCardInfoPanel:SavePosition()
  local saveAndReload = self.ui.uiNode:GetComponent(typeof(SaveAndReload))
  if not IsNil(saveAndReload) then
    saveAndReload:Save()
  end
end

function FuncBattleCardInfoPanel:ReloadPosition()
  local saveAndReload = self.ui.uiNode:GetComponent(typeof(SaveAndReload))
  if saveAndReload then
    saveAndReload:Reload()
  end
end

function FuncBattleCardInfoPanel:GetCardInfoTargetPosY()
  return self.extraParams.targetPosY or -20
end

function FuncBattleCardInfoPanel:GetCardInfoTransform()
  if not self._cardInfoTransform then
    self._cardInfoTransform = self.ui.Group_Card_Info.transform
  end
  return self._cardInfoTransform
end

function FuncBattleCardInfoPanel:KillCardInfoTween()
  if self.cardXTw then
    self.cardXTw:Kill()
    self.cardXTw = nil
  end
  if self.cardYTw then
    self.cardYTw:Kill()
    self.cardYTw = nil
  end
end

function FuncBattleCardInfoPanel:UpdateBattleTouchPos(battleCardClient, cardPosition, isInit)
  local curCard = self.battleCard.value
  local isCardChanged
  if curCard and battleCardClient and curCard.uid and battleCardClient.uid then
    isCardChanged = curCard.uid ~= battleCardClient.uid
  else
    isCardChanged = curCard ~= battleCardClient
  end
  if isCardChanged then
    self.battleCard.value = battleCardClient
  end
  if isInit or isCardChanged then
    self:RefreshDisplayCardItem()
  end
  self.lastTouchPos = cardPosition
  local localPos = self.ui.uiNode.transform:InverseTransformPoint(cardPosition)
  local targetPosY = self:GetCardInfoTargetPosY()
  self:RevertKeyWord(localPos.x)
  local transform = self:GetCardInfoTransform()
  if self.extraParams.forbidTw then
    self:KillCardInfoTween()
    transform.localPosition = Vector3(localPos.x, targetPosY, 0)
    return
  end
  if isInit then
    self:KillCardInfoTween()
    transform.localPosition = Vector3(localPos.x, targetPosY, 0)
  elseif isCardChanged then
    self:TweenCardInfoX(transform, localPos.x)
  end
  if isInit or isCardChanged then
    self:TweenCardInfoY(transform, targetPosY)
  end
end

function FuncBattleCardInfoPanel:TweenCardInfoX(transform, posX)
  if self.cardXTw then
    self.cardXTw:Kill()
    self.cardXTw = nil
  end
  self.cardXTw = transform:DOLocalMoveX(posX, 0.1):OnComplete(function()
    self.cardXTw = nil
  end)
end

function FuncBattleCardInfoPanel:TweenCardInfoY(transform, targetPosY)
  if self.cardYTw then
    self.cardYTw:Kill()
    self.cardYTw = nil
  end
  local localPosition = transform.localPosition
  transform.localPosition = Vector3(localPosition.x, targetPosY, localPosition.z)
  self.cardYTw = transform:DOLocalMoveY(targetPosY + 15, 0.3):OnComplete(function()
    self.cardYTw = nil
  end)
end

function FuncBattleCardInfoPanel:UpdateKeywordSide(posX, leftX, rightX, posY)
  local keywordSide = posX > 70 and 1 or 2
  if self._keywordSide == keywordSide then
    return
  end
  self._keywordSide = keywordSide
  local pos = 1 == keywordSide and Vector2(leftX, posY) or Vector2(rightX, posY)
  self.ui.Group_Keyword.transform.anchoredPosition = pos
end

function FuncBattleCardInfoPanel:RevertKeyWord(posX)
  self:UpdateKeywordSide(posX, -540, 550, 245)
end

function FuncBattleCardInfoPanel:ShowEffect()
  self.ui.Effect_Card_Glow:SetActive(true)
  local uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  local clipsToPlay = ""
  uiAnimController:PlayMultiState(AddClipToPlay(clipsToPlay, "Func_Battle_CardInfo_Floating"), nil)
end

function FuncBattleCardInfoPanel:OnUnbind()
  Super.OnUnbind(self)
  self.displayCardItem = nil
  self:KillCardInfoTween()
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

return FuncBattleCardInfoPanel
