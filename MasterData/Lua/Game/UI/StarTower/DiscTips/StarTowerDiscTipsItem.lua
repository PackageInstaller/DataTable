local StarTowerDiscTipsItem = class("StarTowerDiscTipsItem", BaseCtrl)
StarTowerDiscTipsItem._mapNodeConfig = {
  itemTr = {
    sNodeName = "imgBg",
    sComponentName = "RectTransform"
  },
  canvasGroup = {
    sNodeName = "imgBg",
    sComponentName = "CanvasGroup"
  },
  imgDiscIcon = {sComponentName = "Image"},
  imgSkillIcon = {sComponentName = "Image"},
  txtDisc = {sComponentName = "TMP_Text"}
}
StarTowerDiscTipsItem._mapEventConfig = {}

function StarTowerDiscTipsItem:Show(nSkillId)
  local mapSkillCfg
  mapSkillCfg = ConfigTable.GetData("SecondarySkill", nSkillId)
  if mapSkillCfg == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtDisc, orderedFormat(ConfigTable.GetUIText("StarTower_DiscTips"), mapSkillCfg.Name))
  self:SetPngSprite(self._mapNode.imgDiscIcon, mapSkillCfg.IconBg)
  self:SetPngSprite(self._mapNode.imgSkillIcon, mapSkillCfg.Icon)
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

function StarTowerDiscTipsItem:OnTipItemHide()
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateTip_out"
  })
  self.animRoot:Play("TemplateTip_out", 0, 0)
  self:AddTimer(1, nInAnimLen, function()
    EventManager.Hit("StarTowerTipsShowEnd", self, AllEnum.StarTowerTipsType.DiscTip)
  end, true, true, true, nil)
end

function StarTowerDiscTipsItem:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

return StarTowerDiscTipsItem
