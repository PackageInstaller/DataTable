local DormInteractiveAffinityCharGridCtrl = class("DormInteractiveAffinityCharGridCtrl", BaseCtrl)
DormInteractiveAffinityCharGridCtrl._mapNodeConfig = {
  tc_head = {
    sCtrlName = "Game.UI.TemplateEx.TemplateHeadCtrl"
  },
  TMPFovor = {sComponentName = "TMP_Text"},
  TMPGift = {sComponentName = "TMP_Text"},
  imgIconGift = {sComponentName = "Image"}
}
DormInteractiveAffinityCharGridCtrl._mapEventConfig = {}
DormInteractiveAffinityCharGridCtrl._mapRedDotConfig = {}

function DormInteractiveAffinityCharGridCtrl:Awake()
end

function DormInteractiveAffinityCharGridCtrl:FadeIn()
end

function DormInteractiveAffinityCharGridCtrl:FadeOut()
end

function DormInteractiveAffinityCharGridCtrl:OnEnable()
end

function DormInteractiveAffinityCharGridCtrl:OnDisable()
end

function DormInteractiveAffinityCharGridCtrl:OnDestroy()
end

function DormInteractiveAffinityCharGridCtrl:OnRelease()
end

function DormInteractiveAffinityCharGridCtrl:Refresh(nCharId, nAffinity, nGiftId)
  local mapChar = ConfigTable.GetData_Character(nCharId)
  if mapChar == nil then
    return
  end
  local nSkinId = mapChar.DefaultSkinId
  self._mapNode.tc_head:SetCharHead(nSkinId)
  NovaAPI.SetTMPText(self._mapNode.TMPFovor, orderedFormat(ConfigTable.GetUIText("Dorm_AffinityUp"), nAffinity))
  if nGiftId == 0 then
    self._mapNode.TMPGift.gameObject:SetActive(false)
  else
    local mapGiftItemCfgData = ConfigTable.GetData_Item(nGiftId)
    if mapGiftItemCfgData ~= nil then
      self._mapNode.TMPGift.gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.TMPGift, mapGiftItemCfgData.Title)
      self:SetPngSprite(self._mapNode.imgIconGift, mapGiftItemCfgData.Icon)
    else
      self._mapNode.TMPGift.gameObject:SetActive(false)
    end
  end
end

return DormInteractiveAffinityCharGridCtrl
