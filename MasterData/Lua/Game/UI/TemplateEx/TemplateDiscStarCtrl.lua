local TemplateDiscStarCtrl = class("TemplateDiscStarCtrl", BaseCtrl)
TemplateDiscStarCtrl._mapNodeConfig = {
  tbStar = {
    sNodeName = "btnStar",
    nCount = 6,
    sComponentName = "Image"
  }
}
TemplateDiscStarCtrl._mapEventConfig = {}

function TemplateDiscStarCtrl:SetStar(nStar, nRare)
  if nStar ~= nil then
    self.gameObject:SetActive(true)
    for i = 1, 6 do
      self._mapNode.tbStar[i].gameObject:SetActive(i <= nStar + 1)
      if i <= nStar + 1 then
        self:SetAtlasSprite(self._mapNode.tbStar[i], "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[nRare])
      end
    end
  else
    self.gameObject:SetActive(false)
  end
end

return TemplateDiscStarCtrl
