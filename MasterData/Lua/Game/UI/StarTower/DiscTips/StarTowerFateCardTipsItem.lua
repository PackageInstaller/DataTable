local StarTowerFateCardTipsItem = class("StarTowerFateCardTipsItem", BaseCtrl)
StarTowerFateCardTipsItem._mapNodeConfig = {
  itemTr = {
    sNodeName = "imgBg",
    sComponentName = "RectTransform"
  },
  imgFrame = {
    sNodeName = "imgSkillFrame",
    sComponentName = "Image"
  },
  imgSkillIcon = {
    sNodeName = "imgSkillIcon",
    sComponentName = "Image"
  },
  txtFateCard = {sComponentName = "TMP_Text"},
  imgBg = {sComponentName = "Image"}
}
StarTowerFateCardTipsItem._mapEventConfig = {}

function StarTowerFateCardTipsItem:Show(nFateCardId)
  local fateCardCfg = ConfigTable.GetData_Item(nFateCardId)
  NovaAPI.SetTMPText(self._mapNode.txtFateCard, orderedFormat(ConfigTable.GetUIText("StarTower_FateCard_Tips_1") or "", fateCardCfg.Title))
  self:SetPngSprite(self._mapNode.imgSkillIcon, fateCardCfg.Icon2)
  self:SetSprite_FrameColor(self._mapNode.imgBg, fateCardCfg.Rarity, "rare_vestige_obtain_", true)
  local sFrame = AllEnum.FrameType_New.FateCardS .. fateCardCfg.Rarity
  self:SetAtlasSprite(self._mapNode.imgFrame, "12_rare", sFrame)
  self._mapNode.itemTr.anchoredPosition = Vector2(0, 0)
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateTip_in"
  })
  self:AddTimer(1, nInAnimLen + 1, function()
    local handleTweener = self._mapNode.itemTr:DOAnchorPosY(60, 0.2):SetUpdate(true)
    handleTweener.onComplete = dotween_callback_handler(self, self.OnTipItemHide)
  end, true, true, true, nil)
end

function StarTowerFateCardTipsItem:OnTipItemHide()
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateTip_out"
  })
  self.animRoot:Play("TemplateTip_out")
  self:AddTimer(1, nInAnimLen, function()
    EventManager.Hit("StarTowerTipsShowEnd", self, AllEnum.StarTowerTipsType.FateCardTip)
  end, true, true, true, nil)
end

function StarTowerFateCardTipsItem:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

return StarTowerFateCardTipsItem
