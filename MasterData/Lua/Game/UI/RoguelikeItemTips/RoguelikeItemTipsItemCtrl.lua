local RoguelikeItemTipsItemCtrl = class("RoguelikeItemTipsItemCtrl", BaseCtrl)
RoguelikeItemTipsItemCtrl._mapNodeConfig = {
  itemTr = {
    sNodeName = "img_Bg",
    sComponentName = "RectTransform"
  },
  canvasGroup = {
    sNodeName = "img_Bg",
    sComponentName = "CanvasGroup"
  },
  img_Bg = {sComponentName = "Image"},
  img_ItemIcon = {sComponentName = "Image"},
  txt_ItemName = {sComponentName = "TMP_Text"}
}
RoguelikeItemTipsItemCtrl._mapEventConfig = {}

function RoguelikeItemTipsItemCtrl:Show(nTid, nCount, callBack)
  local itemInfo = ConfigTable.GetData_Item(nTid)
  self:SetSprite_FrameColor(self._mapNode.img_Bg, itemInfo.Rarity, "rare_vestige_obtain_", true)
  NovaAPI.SetImageNativeSize(self._mapNode.img_Bg)
  if itemInfo.Type == GameEnum.itemType.Disc then
    self:SetPngSprite(self._mapNode.img_ItemIcon, itemInfo.Icon .. AllEnum.OutfitIconSurfix.Item)
  else
    self:SetPngSprite(self._mapNode.img_ItemIcon, itemInfo.Icon)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_ItemName, string.format("[%s]", itemInfo.Title) .. "×" .. nCount)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 0)
  self._mapNode.itemTr.anchoredPosition = Vector2(0, -30)
  DOTween.Kill(self.sequence)
  self.sequence = DOTween.Sequence()
  self.sequence:Append(self._mapNode.canvasGroup:DOFade(1, 0.5):SetUpdate(true))
  self.sequence:Join(self._mapNode.itemTr:DOLocalMoveY(-60, 0.5):SetUpdate(true))
  self.sequence:AppendInterval(3)
  self.sequence:Append(self._mapNode.canvasGroup:DOFade(0, 0.5):SetUpdate(true))
  self.sequence:Join(self._mapNode.itemTr:DOLocalMoveY(30, 0.5):SetUpdate(true))
  self.sequence:AppendCallback(function()
    EventManager.Hit("TipsShowEnd", self)
  end)
  self.sequence:SetAutoKill(true)
end

function RoguelikeItemTipsItemCtrl:FadeOut()
  print("3333")
  DOTween.Kill(self.sequence)
  self.sequenceFade = DOTween.Sequence()
  self.sequenceFade:Append(self._mapNode.canvasGroup:DOFade(0, 0.5):SetUpdate(true))
  self.sequenceFade:Join(self._mapNode.itemTr:DOLocalMoveY(30, 0.5):SetUpdate(true))
end

function RoguelikeItemTipsItemCtrl:Awake()
end

function RoguelikeItemTipsItemCtrl:OnEnable()
end

function RoguelikeItemTipsItemCtrl:OnDisable()
end

function RoguelikeItemTipsItemCtrl:OnDestroy()
end

return RoguelikeItemTipsItemCtrl
