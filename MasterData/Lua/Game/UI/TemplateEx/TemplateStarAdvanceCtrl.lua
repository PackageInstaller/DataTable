local TemplateStarAdvanceCtrl = class("TemplateStarAdvanceCtrl", BaseCtrl)
TemplateStarAdvanceCtrl._mapNodeConfig = {
  star = {nCount = 8},
  imgStarOn = {nCount = 8},
  imgStarOff = {nCount = 8},
  imgStarCur = {nCount = 8}
}
TemplateStarAdvanceCtrl._mapEventConfig = {}

function TemplateStarAdvanceCtrl:SetStar(nStar, nMaxStar, nCurStar)
  if nStar ~= nil and nMaxStar ~= nil then
    self.gameObject:SetActive(true)
    for i = 1, 8 do
      self._mapNode.star[i]:SetActive(i <= nMaxStar)
      if nCurStar and nCurStar == i then
        self._mapNode.imgStarCur[i]:SetActive(true)
        self._mapNode.imgStarOff[i]:SetActive(false)
        self._mapNode.imgStarOn[i]:SetActive(false)
      else
        self._mapNode.imgStarCur[i]:SetActive(false)
        self._mapNode.imgStarOff[i]:SetActive(nStar < i)
        self._mapNode.imgStarOn[i]:SetActive(i <= nStar)
      end
    end
  else
    self.gameObject:SetActive(false)
  end
end

return TemplateStarAdvanceCtrl
