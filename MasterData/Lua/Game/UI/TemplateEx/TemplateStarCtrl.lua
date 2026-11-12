local TemplateStarCtrl = class("TemplateStarCtrl", BaseCtrl)
TemplateStarCtrl._mapNodeConfig = {
  tbStar = {
    sNodeName = "btnStar",
    nCount = 5,
    sComponentName = "Button"
  }
}
TemplateStarCtrl._mapEventConfig = {}

function TemplateStarCtrl:SetStar(nStar, nMaxStar)
  if nStar ~= nil and nMaxStar ~= nil then
    self.gameObject:SetActive(true)
    for i = 1, 5 do
      self._mapNode.tbStar[i].interactable = i <= nStar
      self._mapNode.tbStar[i].gameObject:SetActive(i <= nMaxStar)
    end
  else
    self.gameObject:SetActive(false)
  end
end

return TemplateStarCtrl
