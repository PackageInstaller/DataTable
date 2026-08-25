local UIAnimationController = CS.Z1Client.UIAnimationController
local DOTween = CS.DG.Tweening.DOTween
local Tweening = CS.DG.Tweening
local TrailRenderer = CS.UnityEngine.TrailRenderer
local Vector3 = CS.UnityEngine.Vector3
local WORLD_INSERTCARD_ANITIME = 0.45
local WorldStageCardFlyPanel, Super = System.NewClass("WorldStageCardFlyPanel", UIBasePanel)
WorldStageCardFlyPanel.uiResCls = UI_Dbgcopy_Popup_CardFlyResource

function WorldStageCardFlyPanel:ctor(cardTidList, cardUidList, destWorldPos)
  Super.ctor(self)
  self.cardTidList = cardTidList
  self.cardUidList = cardUidList
  self.destWorldPos = destWorldPos or Vector3.zero
end

function WorldStageCardFlyPanel:OnBind(binder)
  self.binder = binder
  self:EnableLayout(true)
  self.ui.Item_Battle_Card_1:SetActive(false)
  self.ui.Item_Battle_Card_2:SetActive(false)
  self.ui.Item_Battle_Card_3:SetActive(false)
  for index, cardTid in ipairs(self.cardTidList) do
    local cardUid = self.cardUidList[index] or 0
    self.binder:BindTimer((index - 1) * WORLD_INSERTCARD_ANITIME, 0, nil, function()
      self:PlayCardFly(index, cardUid, cardTid)
    end)
  end
  binder:BindTimer(1, 0, nil, function()
    self:EnableLayout(false)
  end)
  AudioManager.Instance:PostSoundEvent("EXPLORE_DECK_CARDENTRY")
end

function WorldStageCardFlyPanel:OnUnbind()
  for _, uid in ipairs(self.cardUidList or {}) do
    CardDataUtils.ClearCardDisplayInfo(uid)
  end
  Super.OnUnbind(self)
end

function WorldStageCardFlyPanel:EnableLayout(isEnable)
  local layoutGroup = self.ui.Group_Card:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
  layoutGroup.enabled = isEnable
end

function WorldStageCardFlyPanel:PushNewCardId(cardUid, cardTid)
  table.insert(self.cardUidList, cardUid)
  table.insert(self.cardTidList, cardTid)
  self.binder:BindTimer(#self.cardTidList * WORLD_INSERTCARD_ANITIME, 0, nil, function()
    self:PlayCardFly(#self.cardTidList, cardUid, cardTid)
  end)
end

function WorldStageCardFlyPanel:PlayCardFly(index, cardUid, cardTid)
  local cardUINode = self.ui["Item_Battle_Card_" .. index]
  if not cardUINode then
    return
  end
  cardUINode:SetActive(true)
  local cardUI = Item_Battle_Card_1Resource(cardUINode)
  self.binder:BindComponent(CardBaseComponent(cardUI.Item_Card_Base, cardUid, cardTid))
  self:PlayAnim(cardUI, function()
    self:TweenToDestPoint(cardUI)
  end, function()
    if index == #self.cardTidList then
      self:Close()
    end
  end)
end

function WorldStageCardFlyPanel:PlayAnim(cardUI, middleCb, finishCb)
  local aniCtr = cardUI.uiNode:GetComponent(typeof(UIAnimationController))
  aniCtr:PlayState("Item_Battle_Card_1_vx_WorldStage", -1, 0)
  self.binder:BindTimer(1.85, 0, nil, function()
    if middleCb then
      middleCb()
    end
  end)
  self.binder:BindTimer(1.9 + WORLD_INSERTCARD_ANITIME, 0, nil, function()
    if finishCb then
      finishCb()
    end
  end)
end

function WorldStageCardFlyPanel:TweenToDestPoint(cardUI)
  local sequence = DOTween.Sequence(self)
  local transformSequence = DOTween.Sequence(self)
  local trailRender = cardUI.Root_Effect_Trail:GetComponentInChildren(typeof(TrailRenderer))
  local cardTransform = cardUI.uiNode.transform
  transformSequence:Insert(0, cardTransform:DOMove(self.destWorldPos, WORLD_INSERTCARD_ANITIME):SetEase(Tweening.Ease.OutSine))
  sequence:Insert(0, DOTween.To(function()
    return trailRender.widthMultiplier
  end, function(v)
    trailRender.widthMultiplier = v
  end, 0.5, 0.1, self))
  sequence:Append(transformSequence)
end

return WorldStageCardFlyPanel
