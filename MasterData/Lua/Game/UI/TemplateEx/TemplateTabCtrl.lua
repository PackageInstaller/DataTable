local TemplateTabCtrl = class("TemplateTabCtrl", BaseCtrl)
local State = {
  First = 1,
  Middle = 2,
  Last = 3
}
TemplateTabCtrl._mapNodeConfig = {
  txtTabOn = {sComponentName = "TMP_Text"},
  txtTabOff = {sComponentName = "TMP_Text"},
  imgLine = {},
  imgOn = {nCount = 3}
}
TemplateTabCtrl._mapEventConfig = {}

function TemplateTabCtrl:SetText(sText)
  NovaAPI.SetTMPText(self._mapNode.txtTabOn, sText)
  NovaAPI.SetTMPText(self._mapNode.txtTabOff, sText)
end

function TemplateTabCtrl:SetSelect(bOn, nState)
  self._mapNode.txtTabOn.gameObject:SetActive(bOn)
  self._mapNode.txtTabOff.gameObject:SetActive(not bOn)
  if nState == State.Last then
    self._mapNode.imgLine:SetActive(false)
  else
    self._mapNode.imgLine:SetActive(not bOn)
  end
  for i = 1, 3 do
    if bOn then
      self._mapNode.imgOn[i]:SetActive(i == nState)
    else
      self._mapNode.imgOn[i]:SetActive(false)
    end
  end
end

function TemplateTabCtrl:SetLine(bOn)
  self._mapNode.imgLine:SetActive(bOn)
end

return TemplateTabCtrl
