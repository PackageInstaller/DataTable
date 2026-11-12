local BuildModifierNoteListGridCtrl = class("BuildModifierNoteListGridCtrl", BaseCtrl)
BuildModifierNoteListGridCtrl._mapNodeConfig = {
  imgMusicIcon = {sComponentName = "Image"},
  txtQuestDesc1 = {sComponentName = "TMP_Text"},
  txtQuestDesc2 = {sComponentName = "TMP_Text"},
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
BuildModifierNoteListGridCtrl._mapEventConfig = {
  BuildModifier_GridRangeChange = "OnEvent_GridRangeChange"
}
BuildModifierNoteListGridCtrl._mapRedDotConfig = {}

function BuildModifierNoteListGridCtrl:Awake()
  self.nMaxCount = 999
  self.nMinCount = 0
end

function BuildModifierNoteListGridCtrl:FadeIn()
end

function BuildModifierNoteListGridCtrl:FadeOut()
end

function BuildModifierNoteListGridCtrl:OnEnable()
  local function callback(nCount)
    self:RefreshNoteCount(nCount)
  end
  
  self:SetCallback(callback)
end

function BuildModifierNoteListGridCtrl:OnDisable()
end

function BuildModifierNoteListGridCtrl:OnDestroy()
end

function BuildModifierNoteListGridCtrl:OnRelease()
end

function BuildModifierNoteListGridCtrl:Refresh(nNoteId, nOriginCount, nCurCount)
  self.nNoteId = nNoteId
  self.nCurCount = nCurCount
  self.nOriginCount = nOriginCount
  local mapNote = ConfigTable.GetData("SubNoteSkill", nNoteId)
  if mapNote ~= nil then
    local sNoteIconPath = mapNote.Icon .. AllEnum.DiscSkillIconSurfix.Small
    self:SetPngSprite(self._mapNode.imgMusicIcon, sNoteIconPath)
    NovaAPI.SetTMPText(self._mapNode.txtQuestDesc1, mapNote.Name)
    self:SetNoteEffect()
  end
  self:Init(nCurCount, nOriginCount)
end

function BuildModifierNoteListGridCtrl:SetNoteEffect()
  local mapNote = ConfigTable.GetData("SubNoteSkill", self.nNoteId)
  if mapNote ~= nil then
    if self.nCurCount == 0 then
      NovaAPI.SetTMPText(self._mapNode.txtQuestDesc2, mapNote.BriefDesc)
    else
      local sDesc = UTILS.ParseDesc(mapNote, nil, nil, false, self.nCurCount)
      NovaAPI.SetTMPText(self._mapNode.txtQuestDesc2, sDesc)
    end
  end
end

function BuildModifierNoteListGridCtrl:RefreshNoteCount(nCount)
  if self.nCurCount == nCount then
    return
  end
  self.nCurCount = nCount
  EventManager.Hit("BuildModifier_NoteCountChange", self.nNoteId, self.nCurCount)
  self:SetNoteEffect()
end

function BuildModifierNoteListGridCtrl:OnEvent_GridRangeChange(nTotalFixableCount, nCurAdd, nCurReduce)
  local nSelfSub = self.nCurCount - self.nOriginCount
  local nCurFreePoint = nCurReduce - nCurAdd
  local nMax = math.min(99, self.nCurCount + nCurFreePoint)
  local nMin = self.nOriginCount - (nTotalFixableCount - (nCurReduce - (nSelfSub < 0 and math.abs(nSelfSub) or 0)))
  self:SetRange(nMax, math.max(0, nMin))
end

function BuildModifierNoteListGridCtrl:Init(nCurCount, nDefaultCount)
  self.nDefaultCount = nDefaultCount
  self.nCount = nCurCount
  self.nMaxCount = nCurCount
  self.nMinCount = nCurCount
  self:RefreshCount()
end

function BuildModifierNoteListGridCtrl:SetCallback(callback)
  self.callback = callback
end

function BuildModifierNoteListGridCtrl:RefreshCount()
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
  self:RefreshReduceButton(self.nCount > math.max(self.nMinCount, 0))
end

function BuildModifierNoteListGridCtrl:RefreshAddButton(bAble)
  self._mapNode.btnAdd.gameObject:SetActive(bAble)
  self._mapNode.btnGrayAdd2.gameObject:SetActive(not bAble)
end

function BuildModifierNoteListGridCtrl:RefreshReduceButton(bAble)
  self._mapNode.btnReduce.gameObject:SetActive(bAble)
  self._mapNode.btnGrayReduce1.gameObject:SetActive(not bAble)
end

function BuildModifierNoteListGridCtrl:SetValue(nCount)
  self.nCount = nCount
  self:RefreshCount()
end

function BuildModifierNoteListGridCtrl:SetRange(nMaxCount, nMinCount)
  self.nMaxCount = nMaxCount
  self.nMinCount = nMinCount
  self:RefreshCount()
end

function BuildModifierNoteListGridCtrl:OnBtnClick_Add(btn)
  if self.nCount >= self.nMaxCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("QuantitySelector_Max"))
    return
  end
  self.nCount = math.floor(self.nCount + 2 ^ btn.CurrentGear)
  if self.nCount > self.nMaxCount then
    self.nCount = self.nMaxCount
  end
  self:RefreshCount()
  self.callback(self.nCount)
end

function BuildModifierNoteListGridCtrl:OnBtnClick_Reduce(btn)
  if self.nCount <= self.nMinCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("QuantitySelector_Min"))
    return
  end
  self.nCount = math.floor(self.nCount - 2 ^ btn.CurrentGear)
  if self.nCount < self.nMinCount then
    self.nCount = self.nMinCount
  end
  self:RefreshCount()
  self.callback(self.nCount)
end

function BuildModifierNoteListGridCtrl:OnBtnClick_GrayReduce()
  local sTips
  if self.nCount <= 0 then
    sTips = ConfigTable.GetUIText("BuildModifier_NoteCountTips1")
  else
    sTips = ConfigTable.GetUIText("BuildModifier_NoteCountTips2")
  end
  EventManager.Hit(EventId.OpenMessageBox, sTips)
end

function BuildModifierNoteListGridCtrl:OnBtnClick_GrayAdd()
  local sTips
  if self.nCount >= 99 then
    sTips = ConfigTable.GetUIText("BuildModifier_NoteCountTips3")
  else
    sTips = ConfigTable.GetUIText("BuildModifier_NoteCountTips4")
  end
  EventManager.Hit(EventId.OpenMessageBox, sTips)
end

return BuildModifierNoteListGridCtrl
