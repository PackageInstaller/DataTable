_class("UIN12AwardItem", UICustomWidget)
UIN12AwardItem = UIN12AwardItem

function UIN12AwardItem:OnShow(uiParams)
  self:_GetComponent()
end

function UIN12AwardItem:_GetComponent()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRaw = self:GetUIComponent("RawImage", "icon")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
end

function UIN12AwardItem:OnHide()
  if self._icon then
    self._icon:DestoryLastImage()
  end
end

function UIN12AwardItem:SetData(award, curScore, date, callback, setColorCallback)
  self._callback = callback
  self._curScore = curScore
  self._date = date
  self._setColorCallback = setColorCallback
  self:Refresh(award)
end

function UIN12AwardItem:Refresh(award)
  self._award = award
  local cfgItem = Cfg.cfg_item[award.assetid]
  if cfgItem then
    self._icon:LoadImage(cfgItem.Icon)
    self._txtCount:SetText("x" .. award.count)
  else
    Log.warn("### no data in cfg_item. assetid=", award.assetid)
  end
  if not self._date.gotState then
    return
  end
  if self._date.gotState == N12IntegralState.Got then
    self:RefGray(1)
  else
    self:RefGray(0)
  end
end

function UIN12AwardItem:RefGray(gray)
  if self._setColorCallback then
    self._setColorCallback(gray)
    UIN12ChallengesContorl.SetIconGrey({
      self._iconRaw
    }, gray)
  end
end

function UIN12AwardItem:iconOnClick(go)
  if self._callback then
    local tr = go.transform
    local pos = tr.position
    self._callback(self._award.assetid, pos)
  end
end
