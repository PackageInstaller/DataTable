local BuildModifierNoteQuantitySelector = class("BuildModifierNoteQuantitySelector", BaseCtrl)
BuildModifierNoteQuantitySelector._mapNodeConfig = {
  btnReduce = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reduce"
  },
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  inputCount = {sComponentName = "TMP_Text"},
  btnGrayAdd2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GrayAdd"
  },
  btnGrayReduce1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GrayReduce"
  }
}
BuildModifierNoteQuantitySelector._mapEventConfig = {}

function BuildModifierNoteQuantitySelector:Init(nDefaultCount, nCurCount, nMaxCount, nMinCount, nAddLevel, bSpecial)
  self.nDefaultCount = nDefaultCount
  if bSpecial == nil then
  end
  self.bSpecial = bSpecial
  self.nCount = nCurCount
  self.nMaxCount = nMaxCount
  self.nMinCount = nMinCount
  self.nAddLevel = nAddLevel
  self:RefreshCount()
end

function BuildModifierNoteQuantitySelector:SetCallback(callback)
  self.callback = callback
end

function BuildModifierNoteQuantitySelector:RefreshCount()
  local sValue
  if self.nCount > self.nDefaultCount then
    sValue = orderedFormat("<color=#b7d65d>{0}</color>", self.nCount)
  elseif self.nCount < self.nDefaultCount then
    sValue = orderedFormat("<color=#fa4e6c>{0}</color>", self.nCount)
  else
    sValue = orderedFormat("{0}", self.nCount)
  end
  NovaAPI.SetTMPText(self._mapNode.inputCount, sValue)
  self:RefreshAddButton(self.nCount < self.nMaxCount)
  self:RefreshReduceButton(self.nCount > self.nMinCount)
end

function BuildModifierNoteQuantitySelector:RefreshAddButton(bAble)
  self._mapNode.btnAdd.gameObject:SetActive(bAble)
  self._mapNode.btnGrayAdd2.gameObject:SetActive(not bAble)
end

function BuildModifierNoteQuantitySelector:RefreshReduceButton(bAble)
  self._mapNode.btnReduce.gameObject:SetActive(bAble)
  self._mapNode.btnGrayReduce1.gameObject:SetActive(not bAble)
end

function BuildModifierNoteQuantitySelector:SetValue(nCount)
  self.nCount = nCount
  self:RefreshCount()
end

function BuildModifierNoteQuantitySelector:SetRange(nMaxCount, nMinCount)
  self.nMaxCount = nMaxCount
  self.nMinCount = nMinCount
  self:RefreshCount()
end

function BuildModifierNoteQuantitySelector:Awake()
  self.nMaxCount = 999
  self.nMinCount = 0
end

function BuildModifierNoteQuantitySelector:OnEnable()
end

function BuildModifierNoteQuantitySelector:OnDisable()
end

function BuildModifierNoteQuantitySelector:OnDestroy()
end

function BuildModifierNoteQuantitySelector:OnBtnClick_Add(btn)
  if self.nCount >= self.nMaxCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("QuantitySelector_Max"))
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    return
  end
  self.nCount = math.floor(self.nCount + 2 ^ btn.CurrentGear)
  if self.nCount > self.nMaxCount then
    self.nCount = self.nMaxCount
  end
  self:RefreshCount()
  self.callback(self.nCount)
end

function BuildModifierNoteQuantitySelector:OnBtnClick_GrayAdd(btn)
  local sTips
  if self.bSpecial then
    sTips = ConfigTable.GetUIText("BuildModifier_PotentialPopupTitle3")
  elseif self.nCount - self.nAddLevel == 6 then
    sTips = ConfigTable.GetUIText("BuildModifier_PotentialCountTips3")
  else
    sTips = ConfigTable.GetUIText("BuildModifier_PotentialCountTips4")
  end
  EventManager.Hit(EventId.OpenMessageBox, sTips)
end

function BuildModifierNoteQuantitySelector:OnBtnClick_GrayReduce(btn)
  local sTips
  if self.bSpecial then
    sTips = ConfigTable.GetUIText("BuildModifier_PotentialPopupTitle3")
  elseif self.nCount - self.nAddLevel == 1 then
    sTips = ConfigTable.GetUIText("BuildModifier_PotentialCountTips1")
  else
    sTips = ConfigTable.GetUIText("BuildModifier_PotentialCountTips2")
  end
  EventManager.Hit(EventId.OpenMessageBox, sTips)
end

function BuildModifierNoteQuantitySelector:OnBtnClick_Reduce(btn)
  if self.nCount <= self.nMinCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("QuantitySelector_Min"))
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    return
  end
  self.nCount = math.floor(self.nCount - 2 ^ btn.CurrentGear)
  if self.nCount < self.nMinCount then
    self.nCount = self.nMinCount
  end
  self:RefreshCount()
  self.callback(self.nCount)
end

function BuildModifierNoteQuantitySelector:OnInputEndEdit()
end

return BuildModifierNoteQuantitySelector
