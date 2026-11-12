local TemplateCoinCtrl = class("TemplateCoinCtrl", BaseCtrl)
TemplateCoinCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  txtCount = {sComponentName = "TMP_Text"}
}
TemplateCoinCtrl._mapEventConfig = {}

function TemplateCoinCtrl:SetCoin(nTid, nCount, bThousands, nMaxCount)
  if nTid then
    self:SetSprite_Coin(self._mapNode.imgIcon, nTid)
  end
  if nCount then
    if bThousands then
      if nMaxCount < nCount then
        NovaAPI.SetTMPText(self._mapNode.txtCount, self:ThousandsNumber(nMaxCount) .. "+")
      else
        NovaAPI.SetTMPText(self._mapNode.txtCount, self:ThousandsNumber(nCount))
      end
    else
      NovaAPI.SetTMPText(self._mapNode.txtCount, nCount)
    end
  end
end

function TemplateCoinCtrl:SetCoinWithColor(nTid, nCount, bThousands, bEnough)
  if nTid then
    self:SetSprite_Coin(self._mapNode.imgIcon, nTid)
  end
  if nCount then
    local txt = bThousands and self:ThousandsNumber(nCount) or nCount
    NovaAPI.SetTMPText(self._mapNode.txtCount, txt)
    if not bEnough then
      NovaAPI.SetTMPColor(self._mapNode.txtCount, Red_Unable)
    end
  end
end

return TemplateCoinCtrl
