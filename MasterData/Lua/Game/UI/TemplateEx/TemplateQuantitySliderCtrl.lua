local TemplateQuantitySliderCtrl = class("TemplateQuantitySliderCtrl", BaseCtrl)
TemplateQuantitySliderCtrl._mapNodeConfig = {
  imgCountSlider = {
    sComponentName = "Slider",
    callback = "OnSliderValueChange"
  },
  btnReduce = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reduce"
  },
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  btnMax = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Max"
  },
  btnMin = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Min"
  },
  btnGrayAdd = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_MaxGray"
  },
  btnGrayReduce = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_MinGray"
  }
}
TemplateQuantitySliderCtrl._mapEventConfig = {}

function TemplateQuantitySliderCtrl:Init(funcRefresh, nDefaultCount, nMax, bHideSide)
  self.callback = funcRefresh
  self.nMax = nMax
  self._mapNode.imgCountSlider.maxValue = nMax
  self.nBuyCount = nDefaultCount
  self.bAble = nDefaultCount ~= 0
  self.bHideSide = bHideSide
  self:RefreshCount()
end

function TemplateQuantitySliderCtrl:RefreshCount()
  NovaAPI.SetSliderValue(self._mapNode.imgCountSlider, self.nBuyCount)
  self:RefreshAddButton(self.nBuyCount < self.nMax and self.bAble)
  self:RefreshReduceButton(self.nBuyCount > 1 and self.bAble)
end

function TemplateQuantitySliderCtrl:RefreshAddButton(bAble)
  self._mapNode.btnGrayAdd[1].gameObject:SetActive(not bAble and not self.bHideSide)
  self._mapNode.btnGrayAdd[2].gameObject:SetActive(not bAble)
  self._mapNode.btnAdd.gameObject:SetActive(bAble)
  self._mapNode.btnMax.gameObject:SetActive(bAble and not self.bHideSide)
end

function TemplateQuantitySliderCtrl:RefreshReduceButton(bAble)
  self._mapNode.btnGrayReduce[1].gameObject:SetActive(not bAble)
  self._mapNode.btnGrayReduce[2].gameObject:SetActive(not bAble and not self.bHideSide)
  self._mapNode.btnReduce.gameObject:SetActive(bAble)
  self._mapNode.btnMin.gameObject:SetActive(bAble and not self.bHideSide)
end

function TemplateQuantitySliderCtrl:Awake()
end

function TemplateQuantitySliderCtrl:OnEnable()
end

function TemplateQuantitySliderCtrl:OnDisable()
end

function TemplateQuantitySliderCtrl:OnDestroy()
end

function TemplateQuantitySliderCtrl:OnBtnClick_Add(btn)
  local nRemain = self.nMax - self.nBuyCount
  if nRemain <= 0 then
    return
  end
  if btn.Operate_Type == 0 then
    self.nBuyCount = self.nBuyCount + 1
  elseif btn.Operate_Type == 3 then
    local nAdd = 2 ^ btn.CurrentGear
    local nAfterRemain = nRemain - nAdd
    if nAfterRemain < 0 then
      nAdd = nRemain
    end
    self.nBuyCount = math.floor(self.nBuyCount + nAdd)
  end
  self:RefreshCount()
  self.callback(self.nBuyCount)
end

function TemplateQuantitySliderCtrl:OnBtnClick_Reduce(btn)
  if self.nBuyCount <= 1 then
    return
  end
  if btn.Operate_Type == 0 then
    self.nBuyCount = self.nBuyCount - 1
  elseif btn.Operate_Type == 3 then
    self.nBuyCount = math.floor(self.nBuyCount - 2 ^ btn.CurrentGear)
  end
  if self.nBuyCount < 1 then
    self.nBuyCount = 1
  end
  self:RefreshCount()
  self.callback(self.nBuyCount)
end

function TemplateQuantitySliderCtrl:OnBtnClick_Max()
  if self.nBuyCount == self.nMax then
    return
  end
  self.nBuyCount = self.nMax
  self:RefreshCount()
  self.callback(self.nBuyCount)
end

function TemplateQuantitySliderCtrl:OnBtnClick_Min()
  if self.nBuyCount <= 1 then
    return
  end
  self.nBuyCount = 1
  self:RefreshCount()
  self.callback(self.nBuyCount)
end

function TemplateQuantitySliderCtrl:OnSliderValueChange(_, value)
  self.nBuyCount = math.ceil(value)
  self:RefreshCount()
  self.callback(self.nBuyCount)
end

function TemplateQuantitySliderCtrl:OnBtnClick_MinGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("QuantitySelector_Min"))
end

function TemplateQuantitySliderCtrl:OnBtnClick_MaxGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("QuantitySelector_Max"))
end

return TemplateQuantitySliderCtrl
