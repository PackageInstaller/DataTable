local TemplateSimpleQuantitySelectorCtrl = class("TemplateSimpleQuantitySelectorCtrl", BaseCtrl)
TemplateSimpleQuantitySelectorCtrl._mapNodeConfig = {
  btnReduce = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reduce"
  },
  txtReduce = {sComponentName = "TMP_Text"},
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  txtAdd = {sComponentName = "TMP_Text"},
  btnReduceGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Gray"
  },
  txtReduceGray = {sComponentName = "TMP_Text"},
  btnAddGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Gray"
  },
  txtAddGray = {sComponentName = "TMP_Text"},
  inputCount = {
    sComponentName = "TMP_InputField"
  },
  Placeholder = {sComponentName = "TMP_Text"}
}
TemplateSimpleQuantitySelectorCtrl._mapEventConfig = {}
local MAX_COUNT = 999999

function TemplateSimpleQuantitySelectorCtrl:Init(nDefaultCount, nDiffAmount, callback, sGrayText)
  self.nCount = nDefaultCount
  self.nDiffAmount = nDiffAmount
  self.sGrayText = sGrayText or ""
  NovaAPI.SetTMPText(self._mapNode.txtReduce, "-" .. self.nDiffAmount)
  NovaAPI.SetTMPText(self._mapNode.txtReduceGray, "-" .. self.nDiffAmount)
  NovaAPI.SetTMPText(self._mapNode.txtAdd, "+" .. self.nDiffAmount)
  NovaAPI.SetTMPText(self._mapNode.txtAddGray, "+" .. self.nDiffAmount)
  self:RefreshCount()
  self.callback = callback
  self:SetGray(false)
end

function TemplateSimpleQuantitySelectorCtrl:RefreshCount()
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputCount, self.nCount)
  NovaAPI.SetTMPInputFieldPlaceholderText(self._mapNode.inputCount, self.nCount)
  self:RefreshAddButton(self.nCount < MAX_COUNT)
  self:RefreshReduceButton(self.nCount > 0)
end

function TemplateSimpleQuantitySelectorCtrl:RefreshAddButton(bAble)
  self._mapNode.btnAdd.interactable = bAble
end

function TemplateSimpleQuantitySelectorCtrl:RefreshReduceButton(bAble)
  self._mapNode.btnReduce.interactable = bAble
end

function TemplateSimpleQuantitySelectorCtrl:SetValue(nCount)
  self.nCount = nCount
  self:RefreshCount()
end

function TemplateSimpleQuantitySelectorCtrl:SetGray(bGray)
  self._mapNode.btnReduceGray.gameObject:SetActive(bGray)
  self._mapNode.btnAddGray.gameObject:SetActive(bGray)
  self._mapNode.inputCount.interactable = not bGray
end

function TemplateSimpleQuantitySelectorCtrl:Awake()
end

function TemplateSimpleQuantitySelectorCtrl:OnEnable()
  self.handler = ui_handler(self, self.OnInputEndEdit, self._mapNode.inputCount)
  NovaAPI.AddTMPEndEditListener(self._mapNode.inputCount, self.handler)
end

function TemplateSimpleQuantitySelectorCtrl:OnDisable()
  NovaAPI.RemoveTMPEndEditListener(self._mapNode.inputCount, self.handler)
end

function TemplateSimpleQuantitySelectorCtrl:OnDestroy()
end

function TemplateSimpleQuantitySelectorCtrl:OnBtnClick_Add(btn)
  if self.nCount >= MAX_COUNT then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("QuantitySelector_Max"))
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    return
  end
  self.nCount = self.nCount + self.nDiffAmount
  if self.nCount > MAX_COUNT then
    self.nCount = MAX_COUNT
  end
  self:RefreshCount()
  self.callback(self.nCount)
end

function TemplateSimpleQuantitySelectorCtrl:OnBtnClick_Reduce(btn)
  if self.nCount <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("QuantitySelector_Min"))
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    return
  end
  self.nCount = self.nCount - self.nDiffAmount
  if self.nCount < 0 then
    self.nCount = 0
  end
  self:RefreshCount()
  self.callback(self.nCount)
end

function TemplateSimpleQuantitySelectorCtrl:OnBtnClick_Gray(btn)
  EventManager.Hit(EventId.OpenMessageBox, self.sGrayText)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function TemplateSimpleQuantitySelectorCtrl:OnInputEndEdit()
  local nValue = tonumber(NovaAPI.GetTMPInputFieldText(self._mapNode.inputCount))
  if not nValue then
    nValue = self.nCount
  elseif nValue < 0 then
    nValue = 0
  elseif nValue > MAX_COUNT then
    nValue = MAX_COUNT
  end
  self.nCount = nValue
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputCount, nValue)
  NovaAPI.SetTMPInputFieldPlaceholderText(self._mapNode.inputCount, nValue)
  self:RefreshCount()
  self.callback(self.nCount)
end

return TemplateSimpleQuantitySelectorCtrl
