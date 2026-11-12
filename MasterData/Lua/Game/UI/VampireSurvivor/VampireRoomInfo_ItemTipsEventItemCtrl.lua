local VampireRoomInfo_ItemTipsEventItemCtrl = class("VampireRoomInfo_ItemTipsEventItemCtrl", BaseCtrl)
VampireRoomInfo_ItemTipsEventItemCtrl._mapNodeConfig = {
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
  img_ItemIcon = {sComponentName = "Image"}
}
VampireRoomInfo_ItemTipsEventItemCtrl._mapEventConfig = {}

function VampireRoomInfo_ItemTipsEventItemCtrl:Show(nType, nMonsterId)
  local str = ConfigTable.GetUIText("VampireEventTips_" .. nType)
  if nMonsterId ~= nil then
    local mapMonsterCfg = ConfigTable.GetData("Monster", nMonsterId)
    if mapMonsterCfg ~= nil then
      local nFAId = mapMonsterCfg.FAId
      local mapMonsterFACfg = ConfigTable.GetData("MonsterSkin", nFAId)
      if mapMonsterFACfg ~= nil then
        local nMId = mapMonsterFACfg.MonsterManual
        local mapManualCfg = ConfigTable.GetData("MonsterManual", nMId)
        if mapManualCfg ~= nil then
          local sIcon = mapManualCfg.Icon
          self:SetPngSprite(self._mapNode.img_ItemIcon, sIcon)
        end
      end
    end
  end
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

function VampireRoomInfo_ItemTipsEventItemCtrl:OnTipItemHide()
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateTip_out"
  })
  self.animRoot:Play("TemplateTip_out")
  self:AddTimer(1, nInAnimLen, function()
    EventManager.Hit("StarTowerTipsShowEnd", self, 2)
  end, true, true, true, nil)
end

function VampireRoomInfo_ItemTipsEventItemCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

return VampireRoomInfo_ItemTipsEventItemCtrl
