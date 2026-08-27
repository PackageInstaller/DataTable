local UINADCRewardItem = class("UINADCRewardItem", UIBaseNode)
local base = UIBaseNode

function UINADCRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_icon, self, self.OnClickAwardItem)
end

function UINADCRewardItem:InitADCRewardItem(adcData, index, callback)
  local awardCfgList = adcData:GetADCAwardCfg()
  self._adcData = adcData
  self._awardCfg = awardCfgList[index]
  self._callback = callback
  if 1 < index then
    local lastPoint = awardCfgList[index - 1].need_point
    self._startPoint = lastPoint + (self._awardCfg.need_point - lastPoint) / 2
  else
    self._startPoint = 0
  end
  if awardCfgList[index + 1] ~= nil then
    local nextPoint = awardCfgList[index + 1].need_point
    self._endPoint = self._awardCfg.need_point + (nextPoint - self._awardCfg.need_point) / 2
  else
    local sizeDelta = self.ui.tr_ProgressSlider.sizeDelta
    sizeDelta.x = sizeDelta.x * 0.7
    self.ui.tr_ProgressSlider.transform.sizeDelta = sizeDelta
    self._endPoint = self._awardCfg.need_point
    self._isFinal = true
  end
  self.ui.tex_Progress.text = tostring(self._awardCfg.need_point)
  self:RefreshADCRewardItem()
end

function UINADCRewardItem:RefreshADCRewardItem()
  local curPoint = self._adcData:GetADCTotalPoint()
  local sliderVal = 0
  if not self._isFinal then
    if curPoint < self._awardCfg.need_point then
      sliderVal = (curPoint - self._startPoint) / (self._awardCfg.need_point - self._startPoint) / 2
    else
      sliderVal = 0.5 + (curPoint - self._awardCfg.need_point) / (self._endPoint - self._awardCfg.need_point) / 2
    end
  elseif curPoint >= self._endPoint then
    sliderVal = 1
  elseif curPoint <= self._startPoint then
    sliderVal = 0
  else
    local rate = (curPoint - self._startPoint) / (self._endPoint - self._startPoint)
    sliderVal = rate * 0.7142857142857143
  end
  sliderVal = math.clamp(sliderVal, 0, 1)
  self.ui.img_SliderHandle.fillAmount = sliderVal
  local unlock = self._adcData:GetADCTotalPoint() >= self._awardCfg.need_point
  local canReward = self._adcData:IsCanADCFixedReward(self._awardCfg.need_point)
  if not unlock then
    self.ui.img_icon:SetIndex(1)
    local color = self.ui.img_icon.image.color
    color.a = 1
    self.ui.img_icon.image.color = color
    self.ui.img_Received:SetActive(false)
    self.ui.img_Available:SetActive(false)
  elseif canReward then
    self.ui.img_icon:SetIndex(0)
    local color = self.ui.img_icon.image.color
    color.a = 1
    self.ui.img_icon.image.color = color
    self.ui.img_Received:SetActive(false)
    self.ui.img_Available:SetActive(true)
  else
    self.ui.img_icon:SetIndex(1)
    local color = self.ui.img_icon.image.color
    color.a = 0.6
    self.ui.img_icon.image.color = color
    self.ui.img_Received:SetActive(true)
    self.ui.img_Available:SetActive(false)
  end
end

function UINADCRewardItem:OnClickAwardItem()
  if self._callback ~= nil then
    self._callback(self._awardCfg, self)
  end
end

return UINADCRewardItem
