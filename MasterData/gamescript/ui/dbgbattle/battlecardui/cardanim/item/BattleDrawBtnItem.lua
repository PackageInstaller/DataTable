local UIAnimationController = CS.Z1Client.UIAnimationController
local BattleDrawBtnItem, Super = System.NewComponent("BattleDrawBtnItem")

function BattleDrawBtnItem:ctor(uiNode, cardMgr, deckCardNum, graveyardNum, deck, myCamp)
  Super.ctor(self)
  self.ui = Btn_Battle_DbgResource(uiNode)
  self.deckCardNum = Vue.ref(deckCardNum)
  self.deck = deck
  self.graveyardNum = Vue.ref(graveyardNum)
  self.cardMgr = cardMgr
  self.myCamp = myCamp
  self.isMyCamp = cardMgr.camp == myCamp
end

function BattleDrawBtnItem:OnBind(binder)
  self.binder = binder
  if self.cardMgr.camp == self.myCamp then
    self.binder:BindButtonClick(self.ui.uiNode, function()
      self:OpenDeckPanel()
    end)
  end
  self.binder:BindToText(self.ui.Text_Count, function()
    if BattleManager.Instance:IsInBattle() then
      if self.deck == bc.CardDeck.HandDeck then
        do return LT.Textf, "Battle_Cards_Number", self.deckCardNum.value, self.cardMgr:GetMaxHandDeckNum() end
        return LT.Textf, "Battle_Cards_Number", self.deckCardNum.value, self.cardMgr:GetMaxHandDeckNum()
      end
      do return tostring end
      return tostring, self.deckCardNum.value, self.deckCardNum.value, self.cardMgr:GetMaxHandDeckNum()
    else
      do return tostring end
      return tostring, self.deckCardNum.value + self.graveyardNum.value, self.graveyardNum.value, self.cardMgr:GetMaxHandDeckNum()
    end
  end)
  if self.deck == bc.CardDeck.DrawDeck then
    bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ShuffleCard, System.fn(self, self.PlayDrawEffect), self)
  end
  if self.deck == bc.CardDeck.HandDeck and self.isMyCamp then
    self:BindHandDeckAnim()
    self.binder:BindButtonClick(self.ui.uiNode, function()
      UIManager.Instance:Reopen(Urls.AlertToolTipsPanel, {
        title = "",
        desc = LT.Textf("PVPBattle_Tips_NumberOfCards", self.deckCardNum.value)
      }, self.ui.uiNode)
    end)
    binder:BindEvent(EventMgr.Instance.CardBlowUp, System.fn(self, self.PlayCardBlowUp))
  end
  if self.isMyCamp and self.deck == bc.CardDeck.DrawDeck then
    local uName = "KeyBtnDraw"
    binder:BindComponent(ShortCutComp(self.ui.Text_ShortCut, uName, function()
      self:OpenDeckPanel()
    end))
  end
end

function BattleDrawBtnItem:OpenDeckPanel()
  if self.deck == bc.CardDeck.HandDeck then
    return
  end
  if bg.battlePanel then
    local cardUI = bg.battlePanel.GetCardUI and bg.battlePanel:GetCardUI(self.cardMgr.camp) or bg.battlePanel.cardUI
    if cardUI and cardUI.PutBackPreviewCard then
      cardUI:PutBackPreviewCard()
    end
  end
  AudioManager.Instance:PostSoundEvent("Play_UI_Deck_PVP_Btn_Open")
  local drawCards = self.cardMgr:GetCardListByDeck(bc.CardDeck.DrawDeck)
  local dropCards = self.cardMgr:GetCardListByDeck(bc.CardDeck.GraveyardDeck)
  local params = {
    drawCards = drawCards,
    dropCards = dropCards,
    needOrder = true,
    showDeck = self.deck
  }
  if bg.isPVP then
    params.dropCards = nil
  end
  CardDataUtils.ShowBattleCardPanel(params, true)
end

function BattleDrawBtnItem:PlayDrawEffect(data)
  local aniCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  if aniCtr then
    aniCtr:PlayState("UI_Battle_Extraction_Btn_Mix")
  end
end

function BattleDrawBtnItem:PlayCardBlowUp(camp, _cards, isFakeBurn)
  if isFakeBurn then
    return
  end
  if camp ~= self.cardMgr.camp then
    return
  end
  local aniCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  if not aniCtr then
    return
  end
  local textGoName = "Image_insufficient/Text_C_Insufficient"
  if bg.isPVP then
    textGoName = "Image_insufficient/Text_Insufficient"
  end
  local textGo = CS.Framework.GameObjectUtil.FindChildByPath(self.ui.uiNode, textGoName)
  if textGo then
    local tipsInfo = DT.TipsType[10911]
    self.binder:SetText(textGo, LT.Text(tipsInfo.Desc))
  end
  aniCtr:PlayState("UI_Vx_Battle_Handdeck_Insufficient_Open")
end

function BattleDrawBtnItem:BindHandDeckAnim()
  local aniCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  if not aniCtr then
    return
  end
  self.binder:BindToRaw(function(_, anim)
    aniCtr:PlayState(anim)
  end, function()
    local handNum = self.deckCardNum.value
    local redCount = self.cardMgr:GetMaxHandDeckNum()
    local yellowCount = math.max(0, redCount - 5)
    if handNum >= redCount then
      return "UI_Pvp_Panel_Battle_Handdeck_Red_Open"
    elseif handNum > yellowCount then
      return "UI_Pvp_Panel_Battle_Handdeck_Yellow_Open"
    else
      return "UI_Pvp_Panel_Battle_Handdeck_White_Open"
    end
  end)
end

function BattleDrawBtnItem:OnUnbind()
  if bg.battleRender then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
end

return BattleDrawBtnItem
