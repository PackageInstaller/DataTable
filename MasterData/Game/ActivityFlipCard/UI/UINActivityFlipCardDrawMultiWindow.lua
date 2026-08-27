local UINActivityFlipCardDrawMultiWindow = class("UINActivityFlipCardDrawMultiWindow", UIBaseNode)
local base = UIBaseNode

function UINActivityFlipCardDrawMultiWindow:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Sub, self, self.OnClickBtnSub)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnClickBtnAdd)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.OnClickBtnCancle)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickBtnConfirm)
  self.ui.Slider.onValueChanged:AddListener(BindCallback(self, self.OnSliderValueChanged))
end

function UINActivityFlipCardDrawMultiWindow:InitFlipCardDrawMultiWindow(flipCardData, confirmCallback, backFunc)
  UIUtil.SetTopStatus(self, self.BackAction)
  UIUtil.SetTopStatusBtnShow(false, false)
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return
  end
  if flipCardData == nil then
    return
  end
  self._flipCardData = flipCardData
  self._confirmCallback = confirmCallback
  self._backFunc = backFunc
  local freeItemHaveNum = flipCardData:GetFlipCardFreeItemRemain()
  local paidItemHaveNum = flipCardData:GetFlipCardPaidItemRemain()
  local canGetRewardIdx = flipCardData:GetFlipCardNotGetRewardIdx()
  local haveNum = paidItemHaveNum
  if 0 < freeItemHaveNum then
    haveNum = freeItemHaveNum
  end
  local canGetNum = #canGetRewardIdx
  self._maxHaveCount = haveNum
  self._maxCanGetCount = math.min(canGetNum, haveNum)
  self.ui.Slider.minValue = 0 < self._maxHaveCount and 0 < self._maxCanGetCount and 1 or 0
  self.ui.Slider.maxValue = self._maxCanGetCount
  self.ui.Slider.value = self._maxCanGetCount
  local paidItemId = flipCardData:GetFlipCardPaidCost()
  local freeItemId = flipCardData:GetFlipCardFreeCost()
  local itemCfg = ConfigData.item[paidItemId]
  if 0 < freeItemHaveNum then
    itemCfg = ConfigData.item[freeItemId]
  end
  self.ui.img_Icon.sprite = CRH:GetSprite(itemCfg.small_icon)
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.tex_Before.text = tostring(haveNum)
  self.ui.tex_After.text = tostring(haveNum - self._maxCanGetCount)
  self.ui.tex_FlipTimes.text = tostring(self._maxCanGetCount)
  self.ui.text_Tip:SetIndex(0, LanguageUtil.GetLocaleText(itemCfg.name))
end

function UINActivityFlipCardDrawMultiWindow:OnClickBtnSub()
  local curValue = self.ui.Slider.value
  curValue = math.max(curValue - 1, 1)
  self.ui.Slider.value = curValue
end

function UINActivityFlipCardDrawMultiWindow:OnClickBtnAdd()
  local curValue = self.ui.Slider.value
  curValue = math.min(curValue + 1, self._maxCanGetCount)
  self.ui.Slider.value = curValue
end

function UINActivityFlipCardDrawMultiWindow:OnClickBtnCancle()
  self:BackAction()
end

function UINActivityFlipCardDrawMultiWindow:OnClickBtnConfirm()
  if self._confirmCallback ~= nil then
    self._confirmCallback(self._chooseCount)
  end
  self:BackAction()
end

function UINActivityFlipCardDrawMultiWindow:OnSliderValueChanged(value)
  self:RefreshChooseCount(value)
end

function UINActivityFlipCardDrawMultiWindow:RefreshChooseCount(value)
  self._chooseCount = value
  self.ui.tex_FlipTimes.text = tostring(math.modf(value))
  self.ui.tex_After.text = tostring(math.modf(self._maxHaveCount - value))
end

function UINActivityFlipCardDrawMultiWindow:BackAction()
  if self._backFunc ~= nil then
    self._backFunc()
  end
  self.gameObject:SetActive(false)
  UIUtil.PopFromBackStackByUiTab(self)
  UIUtil.SetTopStatusBtnShow(true, true)
end

function UINActivityFlipCardDrawMultiWindow:OnDelete()
  base.OnDelete(self)
end

return UINActivityFlipCardDrawMultiWindow
