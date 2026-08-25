local UIAnimationController = CS.Z1Client.UIAnimationController
local TypeScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local TypeNotDrawImage = typeof(CS.UnityEngine.UI.NotDrawImage)
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local DragGesture = CS.Z1Client.General.DragGesture
local DOTween = CS.DG.Tweening.DOTween
local TrailRenderer = CS.UnityEngine.TrailRenderer
local CanvasGroup = CS.UnityEngine.CanvasGroup
local Valid_Touch_ScreenHeight = 0
local CARD_DESC_VIEW_HEIGHT_NO_RUNE = 454
local CARD_DESC_VIEW_HEIGHT_WITH_RUNE = 366
local CARD_DESC_VIEW_HEIGHT_CN_NO_RUNE = 260
local BATTLE_DESC_VIEW_HIGH_OFFSET = 64
local DescNormalPos = Vector2(0, 0)
local DescHighPos = Vector2(0, 0)
local BattleCardItem, Super = System.NewComponent("BattleCardItem", CardBaseComponent)
BattleCardItem.OutOfScreenPos = Vector2(-10000, 0)

function BattleCardItem:ctor(uiNode, battleCardClient, isCardDisplay, myCamp)
  Super.ctor(self)
  self.card = Vue.ref(battleCardClient)
  self.ui = Item_Battle_Card_1Resource(uiNode)
  self.cardBaseUI = Item_Card_BaseResource(self.ui.Item_Card_Base)
  self.outsideEffect = nil
  self.isCardDisplay = isCardDisplay
  self.rootRectTransform = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  if not battleCardClient then
    self.rootRectTransform.anchoredPosition = BattleCardItem.OutOfScreenPos
  end
  self.canvasGroup = self.ui.uiNode:GetComponent(typeof(CanvasGroup))
  self.interactable = Vue.ref(true)
  self.myCamp = myCamp or bc.BattleCamp.Camp1
  local trailRender = self.ui.Root_Effect_Trail:GetComponentInChildren(typeof(TrailRenderer))
  self.initTrailRenderSize = trailRender.widthMultiplier
  trailRender.enabled = false
  self.cardAniCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.cardBaseAniCtr = self.cardBaseUI.uiNode:GetComponent(typeof(UIAnimationController))
  self.isInserting = Vue.ref(false)
  self.isFingerPressing = false
  self.isShowLight = Vue.ref(true)
  self.isDescHigh = not self.isCardDisplay
  DescNormalPos = self.cardBaseUI.DescView.transform.anchoredPosition
  DescHighPos = Vector2(DescNormalPos.x, -178)
  self.cardFaceVfxMap = {}
  self.autoAdaptionTextComp = nil
end

function BattleCardItem:OnBind(binder)
  self.binder = binder
  self.animMgr = BattleCardAnimMgr(self, nil, bg.battleRender.cardMgr)
  self.animMgr:OnBind(binder)
  self:BindCardName()
  binder:BindToRaw(function(_, cardTypeCfg, _)
    if cardTypeCfg then
      binder:SetTextColorByHtml(self.cardBaseUI.Text_Name, cardTypeCfg.CardNameColor)
      binder:SetTextColorByHtml(self.cardBaseUI.Text_Desc, cardTypeCfg.CardDescColor)
      self:OnCostChanged()
    end
  end, function()
    if self.card.value then
      do return CardDataUtils.GetCardTypeCfg end
      return CardDataUtils.GetCardTypeCfg, self.card.value.configId
    end
  end)
  self.ui.Text_Desc = self.cardBaseUI.Text_Desc
  binder:BindToRaw(function(cbinder, desc)
    if not desc then
      return
    end
    cbinder:BindToRaw(function()
      self:SetCardDesc(desc)
      self:UpdateDescPos()
    end, function()
      return self.card.value and self.card.value:IsConfuse()
    end)
  end, function()
    if not self.card.value then
      return
    end
    do return self.card.value.GetCardDescription end
    return self.card.value.GetCardDescription, self.card.value
  end)
  binder:BindToRaw(function(cbinder, cardValue)
    if cardValue then
      if not self.inited then
        self:Init(cardValue, nil, self.gestureCallbacks)
      end
      cbinder:BindEvent(cardValue.onCostChangedEvent, System.fn(self, self.OnCostChanged))
      cbinder:BindEvent(cardValue.onCardChangedEvent, System.fn(self, self.OnCardChanged))
      cbinder:BindEvent(EventMgr.Instance.BattleRecordFinish, System.fn(self, self.OnCostChanged))
      self:OnCostChanged()
    end
  end, function()
    return self.card.value
  end)
  binder:BindToText(self.cardBaseUI.Text_Positioning, function()
    if self.card.value == nil then
      return ""
    else
      local config = CardDataUtils.GetCardTypeCfg(self.card.value.configId)
      return config and config.TypeName or ""
    end
  end)
  binder:BindToImageSync(self.cardBaseUI.Image_Icon, function()
    if self.card.value == nil then
      return nil
    else
      local card = self.card.value
      local skillId = card.configData.ID
      if table.contains(card.configData.Type, "Card_KeeperSkill") and not ItemDataUtils.IsPlayerHasKeeperSkill(skillId) then
        local skillConfig = DT.Skill[skillId]
        if skillConfig then
          return skillConfig.UnknownIcon
        end
      end
      local ownerUid = card.ownerUid
      local owner = bg.battleDataCenter:GetAwakerDataModel(ownerUid)
      if card.configData.AwakerID and owner.tid ~= card.configData.AwakerID then
        local awakerCfg = DT.AwakerConfig[owner.tid]
        if awakerCfg and awakerCfg.PVPCardIcon then
          do return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, awakerCfg.PVPCardIcon end
          return bg.battleDataCenter.ReplaceSkinPath, bg.battleDataCenter, awakerCfg.PVPCardIcon, ownerUid
        end
      end
      do return self.card.value.GetCardIcon end
      return self.card.value.GetCardIcon, self.card.value, bg.battleDataCenter, awakerCfg.PVPCardIcon, ownerUid
    end
  end)
  binder:BindToVisible(self.ui.Effect_Card_BianYuan_Lan_yzw_vx, System.fn(self, self.CheckIsBlueEffect))
  binder:BindToVisible(self.ui.Root_Effect_BianYuan, function()
    local isBlue = self:CheckIsBlueEffect()
    local isYellow = self:CheckIsYellowEffect()
    local isRed = self:CheckIsRedEffect()
    local isShow = isBlue or isYellow or isRed
    return isShow
  end)
  binder:BindToRaw(function(_, newVfxList, oldVfxList)
    newVfxList = newVfxList or {}
    oldVfxList = oldVfxList or {}
    local deleteList = {}
    local addList = {}
    for _, vfxId in ipairs(oldVfxList) do
      if not table.contains(newVfxList, vfxId) then
        deleteList[vfxId] = true
      end
    end
    for _, vfxId in ipairs(newVfxList) do
      if not table.contains(oldVfxList, vfxId) then
        addList[vfxId] = true
      end
    end
    for vfxId in pairs(deleteList) do
      if self.cardFaceVfxMap[vfxId] then
        self:FreeSfx(self.cardFaceVfxMap[vfxId])
        self.cardFaceVfxMap[vfxId] = nil
      end
    end
    if not self:CanMountCardFaceVfx() then
      return
    end
    for newVfxId in pairs(addList or {}) do
      if not self.cardFaceVfxMap[newVfxId] then
        local FaceVFX = self:PlaySfx(newVfxId)
        if FaceVFX then
          FaceVFX.rootNode.transform.localPosition = Vector3(0, 0, 0)
          self.cardFaceVfxMap[newVfxId] = FaceVFX
        end
      end
    end
  end, function()
    if self.card.value == nil then
      return nil
    else
      local card = self.card.value
      do return bg.battleDataCenter.stateData.GetCardFaceVFXList, bg.battleDataCenter.stateData end
      return bg.battleDataCenter.stateData.GetCardFaceVFXList, bg.battleDataCenter.stateData, card.uid
    end
  end)
  binder:BindToVisible(self.ui.Effect_Card_BianYuan_Huang_yzw_vx, System.fn(self, self.CheckIsYellowEffect))
  binder:BindToVisible(self.ui.Effect_Card_BianYuan_Hong_yzw_vx, System.fn(self, self.CheckIsRedEffect))
  binder:BindToImageSync(self.cardBaseUI.Image_NameBg, function()
    if self.card.value == nil then
      return nil
    end
    local awakerTid = self.card.value.configData and self.card.value.configData.AwakerID
    if awakerTid then
      local battleAwakerData = self.card.value.ownerRoleDataMode
      local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(awakerTid) or battleAwakerData and battleAwakerData.likeLevel and battleAwakerData or self:IsMyCamp() and AwakerDataUtils.GetAwakerData(awakerTid) or battleAwakerData
      if not self:IsMyCamp() and nil == awakerData then
        awakerData = {likeLevel = 0}
      end
      if FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(awakerTid, awakerData) then
        local cardTypeCfg = CardDataUtils.GetCardTypeCfg(self.card.value.configId)
        local favorRes = FavorabilityVisualUtils.GetPremiumCardFaceRes(awakerTid, cardTypeCfg and cardTypeCfg.CnID)
        if favorRes then
          return favorRes
        end
      end
    end
    do return CardDataUtils.GetIconFrame end
    return CardDataUtils.GetIconFrame, self.card.value.configId, CardDataUtils.GetCardTypeCfg(self.card.value.configId), FavorabilityVisualUtils.GetPremiumCardFaceRes(awakerTid, cardTypeCfg and cardTypeCfg.CnID), awakerTid, cardTypeCfg and cardTypeCfg.CnID
  end)
  binder:BindToRaw(function(cbinder, runeId)
    if runeId then
      cbinder:SetActive(self.cardBaseUI.Item_Card_Rune, true)
      cbinder:BindComponent(CardRuneTypeComponent(self.cardBaseUI.Item_Card_Rune, runeId, self.card.value.uid))
    else
      cbinder:SetActive(self.cardBaseUI.Item_Card_Rune, false)
    end
    self:UpdateDescPos()
    self.autoAdaptionTextComp:ForceMeshUpdate()
  end, function()
    local card = self.card.value
    local runes = card and card.runes.value
    return runes and runes[#runes]
  end)
  binder:SetActive(self.ui.Root_Effect_Trail, false)
  self:BindGesture(self.ui.Btn_Mask)
  self:BindCardNameGesture(self.ui.NameView)
  self:RegisterEvents()
end

function BattleCardItem:RegisterEvents()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.AddState, self.DelayUpdateStateList, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.DelState, self.DelayUpdateStateList, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeStateLayer, self.DelayUpdateStateList, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.UpdateStateArgs, self.DelayUpdateStateList, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeBoutPhase, self.OnChangeBoutPhase, self)
  self.binder:BindEvent(EventMgr.Instance.BattleEndTurnClicked, System.fn(self, self.OnBattleEndTurnClicked))
end

function BattleCardItem:OnBattleEndTurnClicked(camp)
  if camp ~= self.myCamp then
    return
  end
  self:SetShowLight(false)
end

function BattleCardItem:OnChangeBoutPhase()
  self:SetShowLight(true)
end

function BattleCardItem:BindGesture(gameObj)
  local gesture = gameObj:GetComponent(typeof(DragGesture))
  gesture.longPressTime = 0.066
  gesture:onBeginDrag("+", System.fn(self, self.OnBeginDrag))
  gesture:onDrag("+", System.fn(self, self.OnDrag))
  gesture:onPointerDown("+", System.fn(self, self.OnPointerDown))
  gesture:onPointerUp("+", System.fn(self, self.OnPointerUp))
  gesture:onPointerClick("+", System.fn(self, self.OnPointerClick))
  gesture:onPointerLong("+", System.fn(self, self.OnPointerLong))
  self.binder:onDestroy(function()
    gesture:onBeginDrag("-", System.fn(self, self.OnBeginDrag))
    gesture:onDrag("-", System.fn(self, self.OnDrag))
    gesture:onPointerDown("-", System.fn(self, self.OnPointerDown))
    gesture:onPointerUp("-", System.fn(self, self.OnPointerUp))
    gesture:onPointerClick("-", System.fn(self, self.OnPointerClick))
    gesture:onPointerLong("-", System.fn(self, self.OnPointerLong))
  end)
end

function BattleCardItem:BindCardNameGesture(gameObj)
  local gesture = gameObj:GetComponent(typeof(DragGesture))
  gesture.longPressTime = 0.066
  gesture:onBeginDrag("+", System.fn(self, self.OnBeginDragCardName))
  gesture:onDrag("+", System.fn(self, self.OnDragCardName))
  gesture:onPointerDown("+", System.fn(self, self.OnPointerDownCardName))
  gesture:onPointerUp("+", System.fn(self, self.OnPointerUp))
  gesture:onPointerClick("+", System.fn(self, self.OnPointerClick))
  self.binder:onDestroy(function()
    gesture:onBeginDrag("-", System.fn(self, self.OnBeginDragCardName))
    gesture:onDrag("-", System.fn(self, self.OnDragCardName))
    gesture:onPointerDown("-", System.fn(self, self.OnPointerDownCardName))
    gesture:onPointerUp("-", System.fn(self, self.OnPointerUp))
    gesture:onPointerClick("-", System.fn(self, self.OnPointerClick))
  end)
end

function BattleCardItem:BindCardName()
  self.binder:BindToRaw(function(cbinder, name)
    cbinder:BindToRaw(function(_, isConfuse)
      local showName = name
      if isConfuse then
        math.randomseed(#name)
        showName = name:sub(1, math.random(2, 8))
      end
      self.binder:SetText(self.cardBaseUI.Text_Name, showName, nil, nil, {OpenConfuseText = isConfuse})
      self.autoAdaptionTextComp = AutoAdaptionText.StartAutoAdaptionText(self.cardBaseUI.Text_Name)
      if self.autoAdaptionTextComp and self.ui.Btn_Mask then
        self.autoAdaptionTextComp:SetBtn(self.ui.Btn_Mask)
      end
      if self.autoAdaptionTextComp and self.OnDrag and self.OnBeginDrag then
        self.autoAdaptionTextComp:SetDragDelegate(self)
      end
    end, function()
      return self.card.value and self.card.value:IsConfuse()
    end)
  end, System.fn(self, self.GetCardName))
end

function BattleCardItem:GetCardName()
  local cardName = ""
  if self.card.value then
    local skillId = self.card.value.configData.ID
    local cardType = self.card.value.configData.Type
    if table.contains(cardType, "Card_KeeperSkill") and not ItemDataUtils.IsPlayerHasKeeperSkill(skillId) then
      local skillConfig = DT.Skill[skillId]
      if skillConfig then
        cardName = LT.Text(skillConfig.UnknownName)
        return cardName
      end
    end
    local cardValue = self.card.value
    local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(cardValue.awaker)
    local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(cardValue.awaker)
    cardName = BattleSkillUtils.GetSkillName(cardValue.configData, breakSkillLevel, potencyLevel, {
      awaker = cardValue.awaker,
      card = cardValue
    })
  end
  return cardName
end

function BattleCardItem:RefreshCardName()
  if not (self.binder and self.cardBaseUI) or IsNil(self.cardBaseUI.Text_Name) or not self.card.value then
    return
  end
  local name = self:GetCardName()
  local isConfuse = self.card.value:IsConfuse()
  local showName = name
  if isConfuse then
    math.randomseed(#name)
    showName = name:sub(1, math.random(2, 8))
  end
  self.binder:SetText(self.cardBaseUI.Text_Name, showName, nil, nil, {OpenConfuseText = isConfuse})
end

function BattleCardItem:GetName()
  if self.card.value then
    return self.card.value.configData.Name, self.card.value.camp
  end
end

function BattleCardItem:GetBaseCardNode()
  if self.cardBaseUI then
    return self.cardBaseUI.uiNode
  end
  return self.ui.uiNode
end

function BattleCardItem:DelayUpdateStateList()
  if self._updateStateTick then
    return
  end
  self._updateStateTick = bg.battleRender:PerformWithDelay(0.1, function()
    self._updateStateTick = nil
    if not self.card.value then
      return
    end
    if self.isBlessingDisplay and self._lockedDisplayDesc then
      self:SetCardDesc(self._lockedDisplayDesc)
      return
    end
    local cardDesc = self.card.value:GetCardDescription()
    self:SetCardDesc(cardDesc)
    self:RefreshCardName()
    if self.card.value.configData and self.card.value.configData.tempIcon then
      self:SetCardChangeBg(self.card.value:GetCardIcon())
    end
  end, self)
end

function BattleCardItem:IsMyCamp()
  if self.card.value then
    return self.card.value.camp == self.myCamp
  end
end

function BattleCardItem:CheckIsYellowEffect()
  local card = self.card.value
  local phase = bg.battleDataCenter.boutData.phase
  local actionCamp = bg.battleDataCenter:GetRealCamp()
  local myCamp = self.myCamp
  local interactable = self.interactable.value
  local usable = card and card:CheckUsable()
  local highlightEffect = card and card.highlightEffect.value
  local isShowStateYellow = card and bg.battleDataCenter.stateData:GetIsCardYellowState(card.uid)
  local isShowStateRed = card and bg.battleDataCenter.stateData:GetIsCardRedState(card.uid)
  local isShowLight = self.isShowLight.value
  if not isShowLight then
    return
  end
  if not card then
    return false
  end
  if actionCamp ~= myCamp then
    return false
  end
  if isShowStateRed then
    return false
  end
  if phase == bc.BoutPhase.End or phase == bc.BoutPhase.None then
    return false
  end
  if not interactable or not usable then
    return false
  end
  return highlightEffect or isShowStateYellow
end

function BattleCardItem:CheckIsBlueEffect()
  local card = self.card.value
  local phase = bg.battleDataCenter.boutData.phase
  local actionCamp = bg.battleDataCenter:GetRealCamp()
  local myCamp = self.myCamp
  local isShow = card and card:CheckUsable()
  if card and card.highlightEffect.value then
    isShow = false
  end
  if card and card:CostHp() then
    isShow = false
  end
  local interactable = self.interactable.value
  local inserting = self.isInserting.value
  local isRedShow = card and bg.battleDataCenter.stateData:GetIsCardRedState(card.uid)
  local isYellowShow = card and bg.battleDataCenter.stateData:GetIsCardYellowState(card.uid)
  local isShowLight = self.isShowLight.value
  if not isShowLight then
    return
  end
  if not card then
    return false
  end
  if actionCamp ~= myCamp then
    return false
  end
  if phase == bc.BoutPhase.End or phase == bc.BoutPhase.None then
    return false
  end
  if isRedShow or isYellowShow then
    return false
  end
  if not interactable then
    return false
  end
  if inserting then
    return false
  end
  return isShow
end

function BattleCardItem:CheckIsRedEffect()
  local actionCamp = bg.battleDataCenter:GetRealCamp()
  local myCamp = self.myCamp
  local phase = bg.battleDataCenter.boutData.phase
  local interactable = self.interactable.value
  local card = self.card.value
  local isShowStateRed = card and bg.battleDataCenter.stateData:GetIsCardRedState(card.uid)
  local isCostHp = card and card:CostHp()
  local usable = card and card:CheckUsable()
  local isShowLight = self.isShowLight.value
  if not isShowLight then
    return
  end
  if actionCamp ~= myCamp then
    return false
  end
  if phase == bc.BoutPhase.End or phase == bc.BoutPhase.None then
    return false
  end
  if not card then
    return false
  end
  if not interactable or not usable then
    return false
  end
  if isShowStateRed then
    return true
  end
  return isCostHp
end

function BattleCardItem:IsBlessingCard()
  local card = self.card and self.card.value
  if not card then
    return false
  end
  do return card.IsBlessingCard end
  return card.IsBlessingCard, card
end

function BattleCardItem:ShouldPlayConsumeCardEffect()
  return self:IsConsumeCard() and not self:IsBlessingCard()
end

function BattleCardItem:ApplyDisplaySkillTid(skillTid, displayData)
  local card = self.card and self.card.value
  if not card or not skillTid then
    return false
  end
  if not self.binder or self.binder:isDestroyed() then
    return false
  end
  local skillCfg = DT.Skill[skillTid]
  if not skillCfg then
    Logger.Warn("ApplyDisplaySkillTid 技能配置不存在", skillTid)
    return false
  end
  card:ResetByConfigId(skillTid)
  if displayData then
    if displayData.skillArgs then
      card.cardArgs.value = displayData.skillArgs
    end
    if displayData.descArgs then
      card.descArgs.value = displayData.descArgs
    end
  end
  if card.onCardChangedEvent then
    card.onCardChangedEvent:Dispatch()
  end
  local condList = displayData and displayData.condList
  local nameFromCond = BattleSkillUtils.GetCondListValueByIndex(skillCfg.tempName, condList and condList.name)
  if nameFromCond then
    if self.cardBaseUI and self.cardBaseUI.Text_Name and not IsNil(self.cardBaseUI.Text_Name) then
      self.binder:SetText(self.cardBaseUI.Text_Name, LT.Text(nameFromCond) or "")
    else
      self:RefreshCardName()
    end
  else
    self:RefreshCardName()
  end
  local desc = BattleSkillUtils.BuildDisplayBattleDesc(skillTid, condList, displayData and displayData.skillArgs, displayData and displayData.descArgs)
  if not desc or "" == desc then
    desc = card:GetCardDescription()
  end
  self:SetCardDesc(desc)
  self._lockedDisplayDesc = desc
  local iconFromCond = BattleSkillUtils.GetCondListValueByIndex(skillCfg.tempIcon, condList and condList.icon)
  local icon = iconFromCond or card:GetCardIcon()
  if iconFromCond and card.ownerUid and bg.battleDataCenter then
    icon = bg.battleDataCenter:ReplaceSkinPath(iconFromCond, card.ownerUid) or iconFromCond
  end
  if icon and self.cardBaseUI and self.cardBaseUI.Image_Icon then
    self.binder:SetImage(self.cardBaseUI.Image_Icon, icon)
  end
  self:SetIsNeedHighDescMode(false)
  return true
end

function BattleCardItem:GotoState(animState, ...)
  if self:IsInState(CommonDefine.CardAnim.CardBlessingUse) and animState ~= CommonDefine.CardAnim.CardPutBack and animState ~= CommonDefine.CardAnim.CardUseBack then
    return
  end
  self.animMgr:GotoState(animState, ...)
end

function BattleCardItem:ExitState(animState)
  self.animMgr:ExitState(animState)
end

function BattleCardItem:IsInState(animState)
  do return self.animMgr.IsInState, self.animMgr end
  return self.animMgr.IsInState, self.animMgr, animState
end

function BattleCardItem:UpdateState(animState, ...)
  self.animMgr:UpdateState(animState, ...)
end

function BattleCardItem:IsInAnyAnimState(exceptMap)
  do return self.animMgr.IsInAnyAnimState, self.animMgr end
  return self.animMgr.IsInAnyAnimState, self.animMgr, exceptMap
end

function BattleCardItem:GetUid()
  local cardData = self.card.value
  return cardData and cardData.uid
end

function BattleCardItem:SetCardDesc(desc)
  local isOpenConfuseText = self.card.value and self.card.value:IsConfuse()
  Super.SetCardDesc(self, desc, isOpenConfuseText)
  if not self.isCardDisplay and not IsNil(self.cardBaseUI.DescView) then
    local notDrawImage = self.cardBaseUI.DescView:GetComponent(TypeNotDrawImage)
    if notDrawImage then
      notDrawImage.raycastTarget = false
    end
  end
end

function BattleCardItem:SetShowLight(isShow)
  self.isShowLight.value = isShow
end

function BattleCardItem:SetPos(pos)
  self._cachedPos = pos
  if IsNil(self.rootRectTransform) or not pos then
    return
  end
  self.rootRectTransform.anchoredPosition = Vector2(pos.x, pos.y)
end

function BattleCardItem:GetPos()
  return self._cachedPos or self.rootRectTransform.anchoredPosition
end

function BattleCardItem:SetSectorAngle(angle)
  if IsNil(self.rootRectTransform) then
    return
  end
  self.rootRectTransform.eulerAngles = Vector3(0, 0, -angle)
end

function BattleCardItem:GetSectorAngle()
  return -self.rootRectTransform.eulerAngles.z
end

function BattleCardItem:GetHandIndex()
  return self.handIndex
end

function BattleCardItem:SetHandIndex(index)
  if not self.ui or IsNil(self.ui.uiNode) then
    return
  end
  self.handIndex = index
  if not self.ui.Text_ShortcutKey then
    return
  end
  local uName = "KeyCard" .. index
  if not self._shortCutComp then
    self._uName = Vue.ref(uName)
    self._shortCutComp = self.binder:BindComponent(ShortCutComp(self.ui.Text_ShortcutKey, self._uName, System.fn(self, self.OnShortCutKeyClick)))
  else
    self._uName.value = uName
  end
end

function BattleCardItem:OnShortCutKeyClick()
  if self.cardUI and self.cardUI:IsCardShortCutBlocked() then
    return
  end
  if self:IsShowCardSelector() then
    self:ShortCutUse()
    return
  end
  if BattleCardShotcutDragDropMgr.Instance:IsMouseButtonDown() then
    return
  end
  self.cardUI:PutBackPreviewCard()
  if self.cardUI.checkCard then
    self.cardUI:DealPreCheckCard(self.cardUI.checkCard, self)
  end
  BattleCardShotcutDragDropMgr.Instance:BeginDragCard(self)
end

function BattleCardItem:IsShowCardSelector()
  local cmdTargetMgr = bg.battleRender.cmdTargetMgr
  if cmdTargetMgr and cmdTargetMgr:IsShowCardSelector(self.card.value) then
    return true
  end
end

function BattleCardItem:ShortCutUse()
  if not self.card.value then
    return
  end
  local cardPanelUI = bg.battlePanel:GetCardUI(self.card.value.camp)
  if not cardPanelUI:CanUseCard(self.card.value) then
    return
  end
  if cardPanelUI then
    cardPanelUI:UseCard(self)
  end
end

function BattleCardItem:SetIsShowDesc(isShow)
  if IsNil(self.cardBaseUI.Text_Desc) then
    return
  end
  self.binder:SetActive(self.cardBaseUI.Text_Desc, isShow)
end

function BattleCardItem:_GetDescViewHeight(hasRune, isDescHigh)
  local hNoRune = Utils.IsLangChinese() and CARD_DESC_VIEW_HEIGHT_CN_NO_RUNE or CARD_DESC_VIEW_HEIGHT_NO_RUNE
  local hWithRune = Utils.IsLangChinese() and CARD_DESC_VIEW_HEIGHT_CN_NO_RUNE or CARD_DESC_VIEW_HEIGHT_WITH_RUNE
  local h = hasRune and hWithRune or hNoRune
  if isDescHigh then
    h = h - BATTLE_DESC_VIEW_HIGH_OFFSET
  end
  return h
end

function BattleCardItem:UpdateDescPos()
  self:SetIsNeedHighDescMode(self.isDescHigh)
end

function BattleCardItem:SetIsNeedHighDescMode(isHigh)
  self.isDescHigh = isHigh
  if not isHigh then
    self:SetNormalDescPos()
  else
    self:SetHighDescPos()
  end
end

function BattleCardItem:SetHighDescPos()
  if IsNil(self.cardBaseUI.Text_Desc) then
    return
  end
  if not self.card.value then
    return
  end
  local height = StrUtils.GetPreferredHeight(self.cardBaseUI.Text_Desc)
  if height > 196 then
    self.isDescHigh = false
    self:SetNormalDescPos()
    return
  end
  self.cardBaseUI.DescView.transform.anchoredPosition = DescHighPos
  local card = self.card.value
  local runes = card and card.runes.value
  local hasRune = runes and runes[#runes]
  self:_SetDescPos(self:_GetDescViewHeight(hasRune, true))
end

function BattleCardItem:SetNormalDescPos()
  if IsNil(self.cardBaseUI.Text_Desc) then
    return
  end
  self.cardBaseUI.DescView.transform.anchoredPosition = DescNormalPos
  local card = self.card.value
  local runes = card and card.runes.value
  local hasRune = runes and runes[#runes]
  self:_SetDescPos(self:_GetDescViewHeight(hasRune, false))
end

function BattleCardItem:_SetDescPos(height)
  if IsNil(self.cardBaseUI.Text_Desc) then
    return
  end
  local sizeDelta = self.cardBaseUI.DescView.transform.sizeDelta
  sizeDelta.y = height
  self.cardBaseUI.DescView.transform.sizeDelta = sizeDelta
end

function BattleCardItem:IsInHand()
  return self.handIndex ~= nil
end

function BattleCardItem:StopAnim()
  if self.cardAniCtr and not IsNil(self.cardAniCtr) then
    self.cardAniCtr:StopPlayableGraph()
  end
end

function BattleCardItem:PlayState(anim, callback)
  if not self.cardAniCtr or IsNil(self.cardAniCtr) then
    if callback then
      callback()
    end
    return
  end
  self.cardAniCtr:PlayState(anim, function()
    if callback then
      callback()
    end
  end)
end

function BattleCardItem:CancelInsertAnim()
  self.isInserting.value = false
  if bg.battleRender then
    bg.battleRender:UnperformWithDelay(self.insertMiddleimer)
    bg.battleRender:UnperformWithDelay(self.insertFinishTimer)
  end
  self.insertMiddleimer = nil
  self.insertFinishTimer = nil
  self:StopAnim()
  if self._shiftXTween then
    self._shiftXTween:Kill()
    self._shiftXTween = nil
  end
end

function BattleCardItem:PlayInsertAnim(insertAnim, startCb, middleCb, finishCb)
  if not (self.ui and not IsNil(self.ui.uiNode) and self.cardAniCtr) or IsNil(self.cardAniCtr) then
    if finishCb then
      finishCb()
    end
    return
  end
  self.isInserting.value = true
  insertAnim = insertAnim or "Item_Battle_Card_1_vx"
  self.cardAniCtr:PlayState(insertAnim)
  if startCb then
    startCb()
  end
  bg.battleRender:UnperformWithDelay(self.insertMiddleimer)
  bg.battleRender:UnperformWithDelay(self.insertFinishTimer)
  local middleTime = bg.isPVE and 1.85 or 0.9
  self.insertMiddleimer = bg.battleRender:PerformWithDelay(middleTime, function()
    if middleCb then
      middleCb()
    end
  end, self)
  local finishTime = bg.isPVE and 2 or 1.2
  self.insertFinishTimer = bg.battleRender:PerformWithDelay(finishTime, function()
    self.isInserting.value = false
    if finishCb then
      finishCb()
    end
  end, self)
end

function BattleCardItem:OnCostChanged()
  if not (self.binder and self.cardBaseUI) or IsNil(self.cardBaseUI.uiNode) then
    return
  end
  self.binder:SetActive(self.cardBaseUI.Image_Add, false)
  self.binder:SetActive(self.cardBaseUI.Image_Subtract, false)
  self.binder:SetActive(self.cardBaseUI.Text_Expenses, false)
  if self.card.value == nil then
    return
  end
  local costText = self.card.value:GetCostText()
  if nil == costText or "" == costText then
    return
  end
  local cardTypeCfg = CardDataUtils.GetCardTypeCfg(self.card.value.configId) or {}
  local costColorList = cardTypeCfg.CostColorList or {}
  local costColor = costColorList[1]
  if self.card.value:IsXCost() then
    self.binder:SetActive(self.cardBaseUI.Text_Expenses, true)
    self.binder:SetTextColorByHtml(self.cardBaseUI.Text_Expenses, costColor)
    self.binder:SetRawText(self.cardBaseUI.Text_Expenses, costText)
    return
  end
  local cfgCost = self.card.value:GetConfigCost()
  if not cfgCost then
    return
  end
  self.binder:SetActive(self.cardBaseUI.Text_Expenses, true)
  local newCost = self.card.value:GetCost()
  if self._cardCost and self._cardCost ~= newCost and not self.isCardDisplay then
    self.cardBaseAniCtr:PlayState("UI_Vx_Battle_Chaowei_Text_Expenses_01")
  end
  self._cardCost = newCost
  self.binder:SetRawText(self.cardBaseUI.Text_Expenses, costText)
  local isConfuse = self.card.value:IsConfuse()
  local newCostNum = tonumber(newCost)
  if newCostNum and cfgCost and newCostNum ~= cfgCost and not isConfuse then
    local isSubCost = cfgCost > newCostNum
    local isShowAdd = not isSubCost and newCostNum > 0
    if isSubCost then
      costColor = costColorList[2]
    elseif isShowAdd then
      costColor = costColorList[3]
    end
    self.binder:SetActive(self.cardBaseUI.Image_Add, isShowAdd)
    self.binder:SetActive(self.cardBaseUI.Image_Subtract, isSubCost)
  end
  if costColor then
    self.binder:SetTextColorByHtml(self.cardBaseUI.Text_Expenses, costColor)
  end
end

function BattleCardItem:OnUnbind()
  Super.OnUnbind(self)
  DOTweenUtils.KillAllTweensByTarget(self)
  if bg.battleRender then
    if bg.battleRender.eventMgr then
      bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
    end
    bg.battleRender:UnperformWithAllDelaysByTarget(self)
  end
  if self._shortCut then
    ShortCutKeyManager.Instance:UnRegister(self._shortCut, System.fn(self, self.ShortCutUse))
  end
  self:FreeCardFaceSfx()
  if not IsNil(self.cardAniCtr) then
    self.cardAniCtr:StopPlayableGraph()
    self.cardAniCtr = nil
  end
  if not IsNil(self.cardBaseAniCtr) then
    self.cardBaseAniCtr:StopPlayableGraph()
    self.cardBaseAniCtr = nil
  end
end

function BattleCardItem:Init(card, _, callback)
  if not self.ui or IsNil(self.ui.uiNode) then
    return
  end
  if self.card.value == card then
    self.card.value = nil
  end
  self.abortController = AbortController()
  self.card.value = card
  self.gestureCallbacks = callback
  self.configData = card.configData
  self:SetClickable(true)
  self.interactable.value = true
  self.binder:SetActive(self.ui.Image_insufficient, false)
  self.binder:SetActive(self.cardBaseUI.uiNode, true)
  self.inited = true
  if self.isBlessingDisplay or self.isCardDisplay then
    self.isDescHigh = false
  else
    self.isDescHigh = true
  end
  self:UpdateDescPos()
  if self.isCardDisplay then
    self:RestartDescScroll()
  end
  self:RefreshCardName()
  self:RefreshCardFaceVfx()
end

function BattleCardItem:CanMountCardFaceVfx()
  if not self.inited or not self.card.value then
    return false
  end
  do return self.card.value.IsInHand end
  return self.card.value.IsInHand, self.card.value
end

function BattleCardItem:RefreshCardFaceVfx()
  self:FreeCardFaceSfx()
  if not self:CanMountCardFaceVfx() then
    return
  end
  if not bg.battleDataCenter or not bg.battleDataCenter.stateData then
    return
  end
  local vfxList = bg.battleDataCenter.stateData:GetCardFaceVFXList(self.card.value.uid) or {}
  for _, vfxId in ipairs(vfxList) do
    if not self.cardFaceVfxMap[vfxId] then
      local FaceVFX = self:PlaySfx(vfxId)
      if FaceVFX and FaceVFX.rootNode then
        FaceVFX.rootNode.transform.localPosition = Vector3(0, 0, 0)
        self.cardFaceVfxMap[vfxId] = FaceVFX
      end
    end
  end
end

function BattleCardItem:SetClickable(isClickable)
  if not IsNil(self.canvasGroup) then
    self.canvasGroup.blocksRaycasts = isClickable
  end
end

function BattleCardItem:SetVxChooseShow(isShow)
  if not self.ui or IsNil(self.ui.UI_Vx_Card_Choose) then
    return
  end
  self.binder:SetActive(self.ui.UI_Vx_Card_Choose, isShow)
end

function BattleCardItem:FreeSfx(sfxObj)
  if bg.battleRender and bg.battleRender.sfxMgr then
    bg.battleRender.sfxMgr:FreeSfx(sfxObj)
  end
end

function BattleCardItem:PlaySfx(sfxConfigId)
  if not self.abortController or not self.ui.Root_VxEffect then
    return
  end
  do return bg.battleRender.sfxMgr.CreateSfx, bg.battleRender.sfxMgr, sfxConfigId, self.ui.Root_VxEffect.transform, Vector3(0, 0, 0), false, nil end
  return bg.battleRender.sfxMgr.CreateSfx, bg.battleRender.sfxMgr, sfxConfigId, self.ui.Root_VxEffect.transform, Vector3(0, 0, 0), false, nil, self.abortController.signal
end

function BattleCardItem:SetCardUI(cardUI, cardRootNode)
  if not self.ui then
    return
  end
  self.cardUI = cardUI
  self.myCamp = cardUI.myCamp
  self.ui.uiNode.transform:SetParent(cardRootNode.transform)
end

function BattleCardItem:OnRecycle()
  self.cardBaseAniCtr:StopPlayableGraph()
  self.cardAniCtr:StopPlayableGraph()
  self:SetHandIndex(nil)
  self.cardUI = nil
  self._cardCost = nil
  local trailRender = self.ui.Root_Effect_Trail:GetComponentInChildren(typeof(TrailRenderer))
  trailRender.widthMultiplier = self.initTrailRenderSize
  self.binder:SetActive(self.ui.Root_Effect_Trail, false)
  self.binder:SetCanvasGroup(self.ui.Root_Effect_BianYuan, 1)
  self.binder:SetCanvasGroup(self.cardBaseUI.bg, 1)
  self.binder:SetCanvasGroup(self.cardBaseUI.Image_Icon, 1)
  self.binder:SetActive(self.cardBaseUI.uiNode, true)
  self.cardBaseUI.Card_Content.transform.localScale = Vector3.one
  self.inAnimation = false
  self.rootRectTransform.anchoredPosition = BattleCardItem.OutOfScreenPos
  self.canvasGroup.alpha = 1
  self.rootRectTransform.localScale = Vector3(0.8, 0.8, 0.8)
  self:SetClickable(true)
  self.binder:SetActive(self.ui.Image_insufficient, false)
  self.binder:SetActive(self.ui.UI_Vx_Card_Red_Point, false)
  DOTween.Kill(self.ui.uiNode)
  self.inAnimation = nil
  self.inCheck = nil
  self.initPos = nil
  self.initIndex = nil
  self.rootRectTransform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, 0)
  if self.inited then
    self:FreeCardFaceSfx()
    self.abortController:Abort()
  end
  self.isDescHigh = not self.isCardDisplay
  self.inited = false
end

function BattleCardItem:ShowEclipseEffect(onCompleteFunc)
  if self:IsBlessingCard() then
    if onCompleteFunc then
      onCompleteFunc()
    end
    return
  end
  self.binder:SetActive(self.cardBaseUI.uiNode, false)
  self.interactable.value = false
  if onCompleteFunc then
    onCompleteFunc()
  end
end

function BattleCardItem:IsConsumeCard()
  return self.card.value.property:GetProperty(bc.CardProperty.consume) > 0
end

function BattleCardItem:SetVisible(visible)
  self.binder:SetActive(self.ui.uiNode, visible)
end

function BattleCardItem:OnBeginDrag(pointerData)
  if bg.battleData and bg.battleData.isMock and not bg.battlePanel:IsRendering() then
    self.cardUI:UseCard(self)
    return
  end
  if not self.isTouchValid then
    return
  end
  if not self.card.value:IsInHand() or not self.interactable.value then
    return
  end
  if self.gestureCallbacks ~= nil and self.gestureCallbacks.OnBeginDrag then
    self.gestureCallbacks.OnBeginDrag(self, pointerData)
  end
end

function BattleCardItem:OnBeginDragCardName(pointerData)
  if not self.isTouchValid then
    return
  end
end

function BattleCardItem:OnDragCardName(pointerData)
  if not self.isTouchValid then
    return
  end
  if self._cardNameDragTargetChange then
    self:OnDrag(pointerData)
    return
  end
  if pointerData.delta.y > 10 then
    self._cardNameDragTargetChange = true
    local scrollRect = self.ui.NameView:GetComponent(TypeScrollRect)
    scrollRect.movementType = 2
    self:OnDrag(pointerData)
  end
end

function BattleCardItem:OnDrag(pointerData)
  if not self.isTouchValid then
    return
  end
  if self.gestureCallbacks and self.gestureCallbacks.OnDrag then
    self.gestureCallbacks.OnDrag(self, pointerData)
  end
end

function BattleCardItem:OnEndDrag(pointerData)
  if not self.isTouchValid then
    return
  end
  if not self.card.value:IsInHand() or not self.interactable.value then
    return
  end
  if self.gestureCallbacks and self.gestureCallbacks.OnEndDrag then
    self.gestureCallbacks.OnEndDrag(self, pointerData)
  end
end

function BattleCardItem:OnPointerEnter(pointerData)
  self:OnPointerDown(pointerData)
  self:OnPointerLong(pointerData)
end

function BattleCardItem:OnPointerExit(pointerData)
  if ShortCutKeys.IsLeftMouseDown() then
    return
  end
  if self.gestureCallbacks and self.gestureCallbacks.OnPointerExit then
    self.gestureCallbacks.OnPointerExit(self, pointerData)
  end
end

function BattleCardItem:OnPointerDownCardName(pointerData)
  local scrollRect = self.ui.NameView:GetComponent(TypeScrollRect)
  scrollRect.movementType = 1
  self:OnPointerDown(pointerData)
end

function BattleCardItem:OnPointerDown(pointerData)
  if ApplicationUtils.IsWindowsOrEditor() and self.isFingerPressing then
    return
  end
  self._cardNameDragTargetChange = nil
  self.isTouchValid = false
  if pointerData.position.y < Valid_Touch_ScreenHeight then
    return
  end
  if not self.card.value:IsInHand() or not self.interactable.value then
    return
  end
  self.isTouchValid = true
  self.isFingerPressing = true
  if self.gestureCallbacks and self.gestureCallbacks.OnPointerDown then
    self.gestureCallbacks.OnPointerDown(self, pointerData)
  end
  return true
end

function BattleCardItem:OnPointerUp(pointerData, forceCancel)
  if not self.isTouchValid then
    return
  end
  self.isTouchValid = false
  self.isFingerPressing = false
  if self.gestureCallbacks and self.gestureCallbacks.OnPointerUp then
    self.gestureCallbacks.OnPointerUp(self, pointerData, forceCancel)
  end
end

function BattleCardItem:OnPointerLong(pointerData)
  if not self.isTouchValid then
    return
  end
  if not self.card.value:IsInHand() or not self.interactable.value then
    return
  end
  self.isFingerPressing = true
  if self.gestureCallbacks and self.gestureCallbacks.OnPointerLong then
    self.gestureCallbacks.OnPointerLong(self, pointerData)
  end
end

function BattleCardItem:OnPointerClick(pointerData)
  if not self.isTouchValid then
    return
  end
  if not self.card.value:IsInHand() or not self.interactable.value then
    return
  end
  if self.gestureCallbacks and self.gestureCallbacks.OnPointerClick then
    self.gestureCallbacks.OnPointerClick(self, pointerData)
  end
end

function BattleCardItem:ShowCannotReason(reason)
  reason = reason and LT.Text(reason)
  self.binder:SetActive(self.ui.Image_insufficient, true)
  self.binder:SetRawText(self.ui.Text_C_insufficient, reason)
  BattleVoiceController.Instance:OnPvpVoiceOperationImpossible(self.card.value.configData.AwakerID, self.card.value.camp)
  self.cardBaseAniCtr:PlayState("UI_Vx_Card_Base_Image_insufficient_Open")
end

function BattleCardItem:OnCardChanged()
  if not (self.binder and self.cardBaseUI) or IsNil(self.cardBaseUI.uiNode) then
    return
  end
  if not self.card.value then
    return
  end
  local cardValue = self.card.value
  self.card.value = nil
  self:Init(cardValue, nil, self.gestureCallbacks)
  self:OnCostChanged()
  self:RefreshCardName()
end

function BattleCardItem:SetCardChangeBg(name)
  self.binder:SetImage(self.cardBaseUI.Image_Icon, name)
end

function BattleCardItem:FreeCardFaceSfx()
  for _, vfx in pairs(self.cardFaceVfxMap) do
    self:FreeSfx(vfx)
  end
  table.clear(self.cardFaceVfxMap)
end

return BattleCardItem
