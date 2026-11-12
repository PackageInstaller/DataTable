local VampireRoomInfo_ItemTipsItemCtrl = class("VampireRoomInfo_ItemTipsItemCtrl", BaseCtrl)
VampireRoomInfo_ItemTipsItemCtrl._mapNodeConfig = {
  imgBg = {sComponentName = "Image"},
  itemTr = {
    sNodeName = "imgBg",
    sComponentName = "RectTransform"
  },
  canvasGroup = {
    sNodeName = "imgBg",
    sComponentName = "CanvasGroup"
  },
  txtItemName = {
    sNodeName = "txt_ItemName",
    sComponentName = "TMP_Text"
  },
  goFateCardItem = {
    sCtrlName = "Game.UI.VampireSurvivor.Depot.DepotFateCardItemCtrl"
  }
}
VampireRoomInfo_ItemTipsItemCtrl._mapEventConfig = {}

function VampireRoomInfo_ItemTipsItemCtrl:Show(nFateCardId, nCount)
  local mapFateCardCfgData = ConfigTable.GetData("FateCard", nFateCardId)
  if mapFateCardCfgData == nil then
    self:OnTipItemHide()
    return
  end
  self._mapNode.goFateCardItem:InitFateCard(nFateCardId, 1)
  local str = string.format("%s %s", mapFateCardCfgData.Name, ConfigTable.GetUIText("StarTower_FateCard_Unable"))
  NovaAPI.SetTMPText(self._mapNode.txtItemName, str)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 0)
  self._mapNode.itemTr.anchoredPosition = Vector2(0, 0)
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateTip_in"
  })
  self:AddTimer(1, nInAnimLen + 1, function()
    self:OnTipItemHide()
  end, true, true, true, nil)
end

function VampireRoomInfo_ItemTipsItemCtrl:OnTipItemHide()
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateTip_out"
  })
  self.animRoot:Play("TemplateTip_out")
  self:AddTimer(1, nInAnimLen, function()
    EventManager.Hit("StarTowerTipsShowEnd", self, 1)
  end, true, true, true, nil)
end

function VampireRoomInfo_ItemTipsItemCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

return VampireRoomInfo_ItemTipsItemCtrl
