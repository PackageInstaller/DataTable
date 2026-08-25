local UIAnimationController = CS.Z1Client.UIAnimationController
local PvPReplaceCardItem, Super = System.NewComponent("PvPReplaceCardItem")

function PvPReplaceCardItem:ctor(uiNode, cardUid, selected, parentView)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_CardResource(uiNode)
  self.cardUid = cardUid
  self.selected = Vue.ref(selected)
  self.parentView = parentView
end

function PvPReplaceCardItem:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.Group_Selected, function()
    return self.selected.value
  end)
  local cardClient = bg.battleRender.cardMgr:GetCardByUid(self.cardUid)
  if cardClient then
    self:OnSelectBack()
    local battlePanel = self:GetBattlePanel()
    self.battleCardItem = battlePanel:GetCardItemByUid(self.cardUid, true)
    if not self.battleCardItem then
      return
    end
    self.battleCardItem:SetIsNeedHighDescMode(false)
    self.battleCardItem:SetSkipAutoKeywordTips(true)
    local tf = self.battleCardItem.rootRectTransform
    tf:SetParent(self.ui.Item_Battle_Card.transform)
    tf.anchoredPosition = CS.UnityEngine.Vector2(0, 0)
    binder:BindButtonClick(self.ui.Btn_Select, function()
      if bg.isReplay then
        return
      end
      AudioManager.Instance:PostSoundEvent("Play_UI_Poker_PVP_Gamestart_Replacecard_Select")
      self.selected.value = not self.selected.value
      if self.parentView and self.parentView.OnCardSelected then
        self.parentView:OnCardSelected()
      end
    end)
  else
    Logger.Warn("找不到卡牌 cardUid = %s", self.cardUid)
  end
end

function PvPReplaceCardItem:GetBattlePanel()
  local cardClient = bg.battleRender.cardMgr:GetCardByUid(self.cardUid)
  if cardClient.camp == bg.battleDataCenter:GetMyCamp() then
    do return UIManager.Instance.GetWindow, UIManager.Instance end
    return UIManager.Instance.GetWindow, UIManager.Instance, Urls.PvPBattleMainPanel
  else
    do return UIManager.Instance.GetWindow, UIManager.Instance end
    return UIManager.Instance.GetWindow, UIManager.Instance, Urls.PvPBattleOppsiteMainPanel
  end
end

function PvPReplaceCardItem:OnSelectBack()
  if not self.battleCardItem then
    return
  end
  local cardUI = self.battleCardItem.cardUI
  cardUI:OnSelectBack(self.battleCardItem)
  self.battleCardItem = nil
end

function PvPReplaceCardItem:OnSelectCancel()
  if not self.battleCardItem then
    return
  end
  local cardUI = self.battleCardItem.cardUI
  cardUI:OnSelectCancel(self.battleCardItem)
  self.battleCardItem = nil
end

function PvPReplaceCardItem:PlayDisappearAnim()
  if not (self.battleCardItem and self.battleCardItem.ui) or IsNil(self.battleCardItem.ui.uiNode) then
    return
  end
  local cardAniCtr = self.battleCardItem.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:EnterUnClickState()
  cardAniCtr:PlayState("UI_Vx_Battle_Common_CardDisappear", function()
    self:OnSelectCancel()
    self.binder:teardown()
  end)
  local rootAniCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  if rootAniCtr then
    rootAniCtr:PlayState("UI_Pvp_Item_Card_Close")
  end
end

function PvPReplaceCardItem:EnterUnClickState()
end

function PvPReplaceCardItem:OnUnbind()
  self:OnSelectCancel()
  Super.OnUnbind(self)
end

return PvPReplaceCardItem
