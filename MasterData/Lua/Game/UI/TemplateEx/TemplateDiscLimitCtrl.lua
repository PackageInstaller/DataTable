local TemplateDiscLimitCtrl = class("TemplateDiscLimitCtrl", BaseCtrl)
TemplateDiscLimitCtrl._mapNodeConfig = {
  tbCurrentLimit = {
    sNodeName = "imgDiscLimit",
    nCount = 6,
    sComponentName = "Image"
  },
  tbNextLimit = {
    sNodeName = "imgDiscUpgrade",
    nCount = 6,
    sComponentName = "RectTransform"
  }
}
TemplateDiscLimitCtrl._mapEventConfig = {}

function TemplateDiscLimitCtrl:SetLimit(nCurrentLimit, nNextLimit, nDiscRarity)
  if nNextLimit <= nCurrentLimit then
    nNextLimit = 0
  end
  for i = 1, 6 do
    self._mapNode.tbCurrentLimit[i].gameObject:SetActive(i <= nCurrentLimit or i == 1)
    self:SetAtlasSprite(self._mapNode.tbCurrentLimit[i], "12_rare", AllEnum.FrameType_New.DiscLimitL .. AllEnum.FrameColor_New[nDiscRarity])
    local imgDiscUpgrade = self._mapNode.tbNextLimit[i]:GetChild(0):GetComponent("Image")
    imgDiscUpgrade.gameObject:SetActive(nCurrentLimit < i and i <= nNextLimit)
    self:SetAtlasSprite(imgDiscUpgrade, "12_rare", AllEnum.FrameType_New.DiscLimitL .. AllEnum.FrameColor_New[nDiscRarity])
  end
end

return TemplateDiscLimitCtrl
