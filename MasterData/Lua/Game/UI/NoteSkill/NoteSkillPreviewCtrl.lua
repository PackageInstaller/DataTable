local NoteSkillPreviewCtrl = class("NoteSkillPreviewCtrl", BaseCtrl)
NoteSkillPreviewCtrl._mapNodeConfig = {
  aniBlur = {sComponentName = "Animator"},
  aniBlur2 = {sComponentName = "Animator"},
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnBlur2 = {
    sNodeName = "snapshot2",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Note_GrowthPreviewTitle"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnNote = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Note"
  },
  imgNoteCount = {nCount = 3, sComponentName = "Image"},
  imgNoteIcon = {nCount = 3, sComponentName = "Image"},
  txtNoteName = {nCount = 3, sComponentName = "TMP_Text"},
  txtNoteLv = {nCount = 3, sComponentName = "TMP_Text"},
  txtNoteDesc = {nCount = 3, sComponentName = "TMP_Text"},
  ScrollView = {
    sComponentName = "LoopScrollView"
  },
  Content = {sComponentName = "Transform"},
  txtNeedLv = {sComponentName = "TMP_Text"}
}
NoteSkillPreviewCtrl._mapEventConfig = {}

function NoteSkillPreviewCtrl:Open()
  self._mapNode.aniBlur.gameObject:SetActive(self.bBlur)
  self._mapNode.aniBlur2.gameObject:SetActive(not self.bBlur)
  self:InitData()
  self:PlayInAni()
  self:Refresh()
end

function NoteSkillPreviewCtrl:InitData()
  local nGroupId = ConfigTable.GetData("SubNoteSkillPromoteGroup", self.nSubNoteSkillId).GroupId
  local tbGroup = CacheTable.GetData("_SubNoteSkillPromoteGroup", nGroupId)
  if not tbGroup then
    return
  end
  self.tbGroup = {}
  for _, v in pairs(tbGroup) do
    table.insert(self.tbGroup, v)
  end
  table.sort(self.tbGroup, function(a, b)
    return a.Phase < b.Phase
  end)
  for k, v in ipairs(self.tbGroup) do
    if v.Id == self.nSubNoteSkillId then
      self.nSelect = k
      self.nCurPhase = v.Phase
    end
  end
  self.tbLevel = {}
  self.tbLevel[0] = 1
  
  local function foreachDiscPromoteLimit(mapData)
    if mapData.Rarity == self.nRarity then
      self.tbLevel[tonumber(mapData.Phase) + 1] = tonumber(mapData.MaxLevel)
    end
  end
  
  ForEachTableLine(DataTable.DiscPromoteLimit, foreachDiscPromoteLimit)
end

function NoteSkillPreviewCtrl:Refresh()
  self:RefreshNote(self.nSelect, self.nPhase)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  local nMaxLevel = #self.tbGroup
  if nMaxLevel < 0 then
    return
  end
  self._mapNode.ScrollView:Init(nMaxLevel, self, self.OnGridRefresh, self.OnGridBtnClick)
  local movePos = 0 < self.nSelect - 2 and self.nSelect - 2 or 0
  self._mapNode.ScrollView:SetScrollGridPos(movePos, 0.05)
end

function NoteSkillPreviewCtrl:RefreshNote(nIndex, nPhase)
  local mapData = self.tbGroup[nIndex]
  local tbSubNoteSkills = {}
  local tbNote = decodeJson(mapData.SubNoteSkills)
  for k, v in pairs(tbNote) do
    local nNoteId = tonumber(k)
    local nNoteCount = tonumber(v)
    if nNoteId then
      table.insert(tbSubNoteSkills, {nId = nNoteId, nCount = nNoteCount})
    end
  end
  self.tbSubNoteSkills = tbSubNoteSkills
  for i = 1, 3 do
    self._mapNode.btnNote[i].gameObject:SetActive(tbSubNoteSkills[i])
    if tbSubNoteSkills[i] then
      local nImgCount = 2
      self:SetPngSprite(self._mapNode.imgNoteCount[i], "UI/big_sprites/zs_outfit_lv_" .. nImgCount)
      NovaAPI.SetImageNativeSize(self._mapNode.imgNoteCount[i])
      local mapNote = ConfigTable.GetData("SubNoteSkill", tbSubNoteSkills[i].nId)
      if mapNote then
        self:SetPngSprite(self._mapNode.imgNoteIcon[i], mapNote.Icon)
        NovaAPI.SetTMPText(self._mapNode.txtNoteName[i], mapNote.Name)
        NovaAPI.SetTMPText(self._mapNode.txtNoteDesc[i], mapNote.BriefDesc)
        NovaAPI.SetTMPText(self._mapNode.txtNoteLv[i], orderedFormat(ConfigTable.GetUIText("Note_Count"), tbSubNoteSkills[i].nCount))
      end
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtNeedLv, orderedFormat(ConfigTable.GetUIText("Advance_Need_Level"), self.tbLevel[nPhase]))
end

function NoteSkillPreviewCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbGroup[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.NoteSkill.NotePreviewNodeCtrl")
  end
  self.tbGridCtrl[nInstanceID]:RefreshNode(mapData.Phase, self.nCurPhase, nIndex == self.nSelect)
end

function NoteSkillPreviewCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if nIndex == self.nSelect then
    return
  end
  local nInstanceID = goGrid:GetInstanceID()
  local rtItemBefore = self._mapNode.Content:Find(tostring(self.nSelect - 1))
  if rtItemBefore ~= nil then
    local nId = rtItemBefore.gameObject:GetInstanceID()
    if self.tbGridCtrl[nId] ~= nil then
      self.tbGridCtrl[nId]:SetSelect(false)
    end
  end
  if self.tbGridCtrl[nInstanceID] ~= nil then
    self.tbGridCtrl[nInstanceID]:SetSelect(true)
  end
  self.nSelect = nIndex
  self:RefreshNote(self.nSelect, self.tbGroup[nIndex].Phase)
end

function NoteSkillPreviewCtrl:PlayInAni()
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function NoteSkillPreviewCtrl:PlayOutAni()
  if self.bBlur then
    self._mapNode.aniWindow:Play("t_window_04_t_out")
    self._mapNode.aniBlur:SetTrigger("tOut")
    self:AddTimer(1, 0.2, "Close", true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  else
    self._mapNode.aniBlur2.gameObject:SetActive(false)
    self:Close()
  end
end

function NoteSkillPreviewCtrl:Close()
  self._mapNode.window:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.NoteSkillPreview)
end

function NoteSkillPreviewCtrl:Awake()
  self._mapNode.window:SetActive(false)
  self.bBlur = true
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nSubNoteSkillId = tbParam[1]
    self.nPhase = tbParam[2]
    self.nRarity = tbParam[3]
    if tbParam[4] ~= nil then
      self.bBlur = tbParam[4]
    end
  end
end

function NoteSkillPreviewCtrl:OnEnable()
  self.tbGridCtrl = {}
  self:Open()
end

function NoteSkillPreviewCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function NoteSkillPreviewCtrl:OnDestroy()
end

function NoteSkillPreviewCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function NoteSkillPreviewCtrl:OnBtnClick_Note(btn, nIndex)
  local mapNote = self.tbSubNoteSkills[nIndex]
  if not mapNote then
    return
  end
  local tbNote = {}
  for _, v in ipairs(self.tbSubNoteSkills) do
    tbNote[v.nId] = v.nCount
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.NoteSkill, tbNote, mapNote.nId, false)
end

return NoteSkillPreviewCtrl
