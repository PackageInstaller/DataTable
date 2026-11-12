local StarTowerNoteTipsItem = class("StarTowerNoteTipsItem", BaseCtrl)
StarTowerNoteTipsItem._mapNodeConfig = {
  itemTr = {
    sNodeName = "imgBg",
    sComponentName = "RectTransform"
  },
  canvasGroup = {
    sNodeName = "imgBg",
    sComponentName = "CanvasGroup"
  },
  imgNoteIcon = {sComponentName = "Image"},
  txtNote = {sComponentName = "TMP_Text"}
}
StarTowerNoteTipsItem._mapEventConfig = {}

function StarTowerNoteTipsItem:Show(nNoteId, nCount)
  local mapNoteCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
  if mapNoteCfg == nil then
    return
  end
  local sName = mapNoteCfg.Name
  local sTip = orderedFormat(ConfigTable.GetUIText("StarTower_Note_Reduce_Tip") or "", math.abs(nCount), sName)
  NovaAPI.SetTMPText(self._mapNode.txtNote, sTip)
  self:SetPngSprite(self._mapNode.imgNoteIcon, mapNoteCfg.Icon)
  self._mapNode.itemTr.anchoredPosition = Vector2(0, 0)
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateTip_in"
  })
  self.animRoot:Play("TemplateTip_in", 0, 0)
  self:AddTimer(1, nInAnimLen + 1, function()
    local handleTweener = self._mapNode.itemTr:DOAnchorPosY(60, 0.2):SetUpdate(true)
    handleTweener.onComplete = dotween_callback_handler(self, self.OnTipItemHide)
  end, true, true, true, nil)
end

function StarTowerNoteTipsItem:OnTipItemHide()
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateTip_out"
  })
  self.animRoot:Play("TemplateTip_out", 0, 0)
  self:AddTimer(1, nInAnimLen, function()
    EventManager.Hit("StarTowerTipsShowEnd", self, AllEnum.StarTowerTipsType.NoteTip)
  end, true, true, true, nil)
end

function StarTowerNoteTipsItem:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

return StarTowerNoteTipsItem
