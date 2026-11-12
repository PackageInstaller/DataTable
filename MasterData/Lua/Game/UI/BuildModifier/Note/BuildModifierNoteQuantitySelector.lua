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

function BuildModifierNoteQuantitySelector:Init(nCurCount, nDefaultCount)
  self.nDefaultCount = nDefaultCount
  self.nCount = nCurCount
  self.nMaxCount = nCurCount
  self.nMinCount = nCurCount
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
  self:RefreshReduceButton(self.nCount > 0)
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

function BuildModifierNoteQuantitySelector:OnBtnClick_GrayReduce()
  local sTips
  if self.nCount <= 0 then
    sTips = ConfigTable.GetUIText("BuildModifier_NoteCountTips1")
  else
    sTips = ConfigTable.GetUIText("BuildModifier_NoteCountTips2")
  end
  EventManager.Hit(EventId.OpenMessageBox, sTips)
end

function BuildModifierNoteQuantitySelector:OnBtnClick_GrayAdd()
  local sTips
  if self.nCount >= 99 then
    sTips = ConfigTable.GetUIText("BuildModifier_NoteCountTips3")
  else
    sTips = ConfigTable.GetUIText("BuildModifier_NoteCountTips4")
  end
  EventManager.Hit(EventId.OpenMessageBox, sTips)
end

function BuildModifierNoteQuantitySelector:OnInputEndEdit()
end

return BuildModifierNoteQuantitySelector
