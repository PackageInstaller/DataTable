local MainViewCornerMarkCtrl = class("MainViewCornerMarkCtrl", BaseCtrl)
MainViewCornerMarkCtrl._mapNodeConfig = {
  imgRedDotBg = {},
  txtRedDot = {sComponentName = "TMP_Text"},
  imgRedDot = {},
  imgNew = {}
}
MainViewCornerMarkCtrl._mapEventConfig = {}

function MainViewCornerMarkCtrl:Refresh(bOpen, nRedCount, bSimpleRed, bNew)
  if bOpen then
    self.gameObject:SetActive(true)
    self._mapNode.imgRedDotBg:SetActive(false)
    self._mapNode.imgRedDot:SetActive(false)
    self._mapNode.imgNew:SetActive(false)
    if nRedCount then
      self._mapNode.imgRedDotBg:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtRedDot, nRedCount)
    elseif bSimpleRed then
      self._mapNode.imgRedDot:SetActive(true)
    elseif bNew then
      self._mapNode.imgNew:SetActive(true)
    end
  else
    self.gameObject:SetActive(false)
  end
end

return MainViewCornerMarkCtrl
