local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local RectTransform = CS.UnityEngine.RectTransform
local Vector3 = CS.UnityEngine.Vector3
local CardFeatureInfoPanel, Super = System.NewClass("CardFeatureInfoPanel", UIBasePanel)
CardFeatureInfoPanel.uiResCls = Func_Battle_CardInfoResource

function CardFeatureInfoPanel:ctor(data)
  self.cardUid = Vue.ref(data.cardUid)
  self.cardTid = Vue.ref(data.cardTid)
  self.imageBgHideFlag = data.imageBgHideFlag
  self.cardDesc = Vue.ref(data.cardDesc)
  self.cost = Vue.ref(data.cost)
  self.cardLevel = Vue.ref(data.cardLevel)
  self.params = data.params
  self.gameObject = data.gameObject
  self.closeCallBack = data.closeCallBack
  self.battleTouchPos = data.battleTouchPos
  self.awakerData = data.awakerData
  self.runeTid = data.runeTid
  self.stateList = data.stateList
  self.ignoreUnknowImage = data.ignoreUnknowImage
  if self.gameObject then
    local uiCamera = CameraManager:GetUICamera()
    local posVec2 = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(self.gameObject.transform.position, CS.UnityEngine.GameObject.Find("UIRoot/SafeArea/TipPopRoot"):GetComponent(typeof(RectTransform)), uiCamera)
    self.pos = {
      posVec2.x,
      posVec2.y
    }
  end
end

function CardFeatureInfoPanel:OnBind(binder)
  self.binder = binder
  binder:onDestroy(function()
    if self.params and self.params.closeAudio then
      AudioManager.Instance:PostSoundEvent(self.params.closeAudio)
    end
  end)
  self.cardRectTransform = self.ui.Group_Card_Info:GetComponent(typeof(RectTransform))
  if self.params and self.params.audio then
    AudioManager.Instance:PostSoundEvent(self.params.audio)
  else
    self.audio.Play_UI_Com_Show_Card_Info = "Audio_UI_Com_Show_Card_Info"
    AudioManager.Instance:PostSoundEvent(self.audio.Play_UI_Com_Show_Card_Info)
  end
  if self.imageBgHideFlag then
    self.ui.Image_Bg:SetActive(false)
  else
    self.ui.Image_Bg:SetActive(true)
  end
  binder:BindToText(self.ui.Text_Enchant_Success, function()
    do return LT.Text end
    return LT.Text, "EnchantmentAwardLevelUp"
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  local cardComp = binder:BindComponent(require("UI.Card.Component.CardBaseComponent")(self.ui.Item_Card_Base, self.cardUid, self.cardTid, nil, self.cost, self.cardDesc, nil, nil, self.cardLevel, {
    awakerData = self.awakerData,
    runeTid = self.runeTid,
    ignoreUnknowImage = self.ignoreUnknowImage
  }))
  cardComp:SetSkipAutoKeywordTips(true)
  local card = CardDataUtils.GetCardInfo(self.cardUid.value)
  local isConfuse = card and card.IsConfuse and card:IsConfuse()
  if not isConfuse then
    local list = CardDataUtils.GetCardEffectGroupList(self.cardTid.value, self.cardUid.value, self.cardLevel.value, self.stateList, self.awakerData)
    local exParam = {
      awakerData = self.awakerData or CardDataUtils.GetCardOwner(self.cardUid.value),
      skillLevel = self.cardLevel.value,
      skillTid = self.cardTid.value
    }
    binder:BindComponent(CommonKeyWordDescGroup(self.ui.Group_Keyword, {
      cardComp:GetCardDesc()
    }, list, nil, exParam))
  else
    self.ui.Group_Keyword:SetActive(false)
  end
  if self.pos then
    local screenWidth = self.ui.uiNode:GetComponent(typeof(RectTransform)).rect.width / 2
    local x = screenWidth < self.pos[1] + self.cardRectTransform.rect.width / 2 and screenWidth - self.cardRectTransform.rect.width / 2 or self.pos[1]
    self.cardRectTransform.anchoredPosition = CS.UnityEngine.Vector2(x, self.pos[2])
  end
  if self.battleTouchPos then
    self:UpdateBattleTouchPos(self.battleTouchPos)
  end
end

function CardFeatureInfoPanel:OnUnbind()
  Super.OnUnbind(self)
  CardDataUtils.ClearCardDisplayInfo(self.cardUid.value)
end

function CardFeatureInfoPanel:Close()
  if self.closeCallBack then
    self.closeCallBack()
  end
  Super.Close(self)
end

local function ScreenToLocalPos(screenPos, parentTransform, transform)
  local rectTransformUtility = CS.UnityEngine.RectTransformUtility
  local uiCamera = UIRootMgr.GetUICamera()
  local _, localPos = rectTransformUtility.ScreenPointToLocalPointInRectangle(parentTransform, screenPos, uiCamera)
  local parentPivot = parentTransform.pivot
  local pivot = transform.pivot
  local deltaX = (parentPivot.x - pivot.x) * parentTransform.sizeDelta.x
  local deltaY = (parentPivot.y - pivot.y) * parentTransform.sizeDelta.y
  localPos.x = localPos.x + deltaX
  localPos.y = localPos.y + deltaY
  return localPos
end

function CardFeatureInfoPanel:UpdateBattleTouchPos(touchPos)
  if self.lastTouchPos and math.abs(touchPos.x - self.lastTouchPos.x) < 10 then
    return
  end
  self.lastTouchPos = touchPos
  local localPos = ScreenToLocalPos(touchPos, self.ui.uiNode.transform, self.ui.Group_Card_Info.transform)
  local targetPosY = -20
  if self.cardXTw then
    self.cardXTw:Kill()
    self.cardXTw = self.ui.Group_Card_Info.transform:DOLocalMoveX(localPos.x, 0.1):OnComplete(function()
      self.cardXTw = nil
    end)
  else
    self.ui.Group_Card_Info.transform.localPosition = Vector3(localPos.x, targetPosY, 0)
  end
  if self.cardYTw then
    self.cardYTw:Kill()
  end
  self.cardYTw = self.ui.Group_Card_Info.transform:DOLocalMoveY(targetPosY + 15, 3)
end

function CardFeatureInfoPanel:ShowEffect()
  self.ui.Effect_Card_Glow:SetActive(true)
  local uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  local clipsToPlay = ""
  uiAnimController:PlayMultiState(AddClipToPlay(clipsToPlay, "Func_Battle_CardInfo_Floating"), nil)
end

function CardFeatureInfoPanel:OnUnbind()
  Super.OnUnbind(self)
  if self.cardYTw then
    self.cardYTw:Kill()
  end
  if self.cardXTw then
    self.cardXTw:Kill()
  end
end

return CardFeatureInfoPanel
