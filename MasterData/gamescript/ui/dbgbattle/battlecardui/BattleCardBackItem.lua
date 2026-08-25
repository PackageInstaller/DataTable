local UIAnimationController = CS.Z1Client.UIAnimationController
local Vector2 = CS.UnityEngine.Vector2
local Vector2_Zero = Vector2.zero
local BattleCardBackItem, Super = System.NewClass("BattleCardBackItem", BattleCardItem)

function BattleCardBackItem:ctor(uiNode, battleCardClient, isCardDisplay)
  self.card = Vue.ref(battleCardClient)
  self.ui = Item_Battle_Card_Back_1Resource(uiNode)
  self.rootRectTransform = self.ui.uiNode.transform
  self.cardAniCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.interactable = Vue.ref(true)
  self.isInserting = Vue.ref(false)
  self.isFingerPressing = false
  self.isShowLight = Vue.ref(true)
  self.cardFaceVfxMap = {}
end

function BattleCardBackItem:OnBind(binder)
  self.binder = binder
  self.animMgr = BattleCardAnimMgr(self, nil, bg.battleRender.cardMgr)
  self.animMgr:OnBind(binder)
  binder:BindToRaw(function(cbinder, cardValue)
    if cardValue then
      cbinder:BindEvent(cardValue.onCardChangedEvent, System.fn(self, self.OnCardChanged))
    end
  end, function()
    return self.card.value
  end)
  binder:BindToVisible(self.ui.Effect_Card_BianYuan_Lan_yzw_vx, System.fn(self, self.CheckIsBlueEffect))
  binder:BindToVisible(self.ui.Root_Effect_BianYuan, function()
    local isBlue = self:CheckIsBlueEffect()
    local isYellow = self:CheckIsYellowEffect()
    local isRed = self:CheckIsRedEffect()
    return isBlue or isYellow or isRed
  end)
  binder:BindToVisible(self.ui.Effect_Card_BianYuan_Huang_yzw_vx, System.fn(self, self.CheckIsYellowEffect))
  binder:BindToVisible(self.ui.Effect_Card_BianYuan_Hong_yzw_vx, System.fn(self, self.CheckIsRedEffect))
end

function BattleCardBackItem:GetUid()
  local cardData = self.card.value
  return cardData and cardData.uid
end

function BattleCardBackItem:SetShowLight(isShow)
end

function BattleCardBackItem:SetHighDescPos()
end

function BattleCardBackItem:SetNormalDescPos()
end

function BattleCardBackItem:ShowCardDetailItem(isReverse)
  if not self.detailCard then
    local cardRes = Item_Battle_Card_1Resource
    self.detailCard = self.binder:BindNewComponent(self.ui.uiNode, BattleCardItem, cardRes, self.card)
    local tf = self.detailCard.ui.uiNode.transform
    tf.anchoredPosition = Vector2_Zero
    self.binder:SetActive(self.ui.Image_Card_Back, false)
    if isReverse then
      tf.localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, 180)
    end
  end
end

function BattleCardBackItem:HideCardDetailItem()
  if self.detailCard then
    self.detailCard.binder:teardown()
    self.detailCard = nil
  end
  self.binder:SetActive(self.ui.Image_Card_Back, true)
end

function BattleCardBackItem:PlayState(anim, callback)
  self.cardAniCtr:PlayState(anim, function()
    if callback then
      callback()
    end
  end)
end

function BattleCardBackItem:OnUnbind()
  Super.OnUnbind(self)
end

function BattleCardBackItem:Init(card, _, callback)
  if self.card.value == card then
    self.card.value = nil
  end
  self.card.value = card
  self.configData = card.configData
end

return BattleCardBackItem
