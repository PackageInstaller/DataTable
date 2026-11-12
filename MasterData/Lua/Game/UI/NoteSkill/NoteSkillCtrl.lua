local NoteSkillCtrl = class("NoteSkillCtrl", BaseCtrl)
NoteSkillCtrl._mapNodeConfig = {
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
    sLanguageId = "Note_SkillTitle"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtSkillTitle = {sComponentName = "TMP_Text"},
  txtSkillDesc = {sComponentName = "TMP_Text"},
  txtSkillLevel = {sComponentName = "TMP_Text"},
  imgSkillIcon = {sComponentName = "Image"},
  btnPrev = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Prev"
  },
  btnNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Next"
  },
  imgPrevOn = {},
  imgPrevOff = {},
  imgNextOn = {},
  imgNextOff = {},
  sv = {
    sComponentName = "LoopScrollView"
  }
}
NoteSkillCtrl._mapEventConfig = {}

function NoteSkillCtrl:Open()
  self._mapNode.aniBlur.gameObject:SetActive(self.bBlur)
  self._mapNode.aniBlur2.gameObject:SetActive(not self.bBlur)
  self:InitData()
  self:PlayInAni()
  self:Refresh()
end

function NoteSkillCtrl:InitData()
  self.tbNoteId = {}
  local i = 1
  for nId, nCount in pairs(self.tbNote) do
    if 0 < nCount then
      table.insert(self.tbNoteId, nId)
      if nId == self.nSelectNote then
        self.nSelectIndex = i
      end
      i = i + 1
    end
  end
  self.nListCount = #self.tbNoteId
  self._mapNode.imgPrevOn:SetActive(1 < self.nListCount)
  self._mapNode.imgPrevOff:SetActive(1 >= self.nListCount)
  self._mapNode.imgNextOn:SetActive(1 < self.nListCount)
  self._mapNode.imgNextOff:SetActive(1 >= self.nListCount)
end

function NoteSkillCtrl:Refresh()
  local mapCfg = ConfigTable.GetData("SubNoteSkill", self.nSelectNote)
  if not mapCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtSkillTitle, mapCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.txtSkillDesc, mapCfg.BriefDesc)
  NovaAPI.SetTMPText(self._mapNode.txtSkillLevel, orderedFormat(ConfigTable.GetUIText("Note_Count"), self.tbNote[self.nSelectNote]))
  self:SetPngSprite(self._mapNode.imgSkillIcon, mapCfg.Icon)
  if self.nMaxLevel < 0 then
    return
  end
  self._mapNode.sv:Init(self.nMaxLevel, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function NoteSkillCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local rtGrid = goGrid.transform:Find("btnGrid/AnimRoot")
  local txtLevel = rtGrid.transform:Find("layout/txtLevel"):GetComponent("TMP_Text")
  local txtLevelDesc = rtGrid.transform:Find("layout/txtLevelDesc"):GetComponent("TMP_Text")
  local imgSelect = rtGrid.transform:Find("imgSelect").gameObject
  local imgOnBg = rtGrid.transform:Find("imgOnBg").gameObject
  local imgOffBg = rtGrid.transform:Find("imgOffBg").gameObject
  local imgOn = rtGrid.transform:Find("layout/imgOn").gameObject
  local imgOff = rtGrid.transform:Find("layout/imgOff").gameObject
  NovaAPI.SetTMPText(txtLevel, orderedFormat(ConfigTable.GetUIText("Note_Count"), nIndex))
  local bOn = nIndex == self.tbNote[self.nSelectNote]
  imgSelect:SetActive(bOn)
  imgOnBg:SetActive(bOn)
  imgOn:SetActive(bOn)
  imgOffBg:SetActive(not bOn)
  imgOff:SetActive(not bOn)
  local mapCfg = ConfigTable.GetData("SubNoteSkill", self.nSelectNote)
  if not mapCfg then
    return
  end
  NovaAPI.SetTMPText(txtLevelDesc, UTILS.ParseDesc(mapCfg, nil, nil, false, nIndex))
end

function NoteSkillCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
end

function NoteSkillCtrl:PlayInAni()
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function NoteSkillCtrl:PlayOutAni()
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

function NoteSkillCtrl:Close()
  self._mapNode.window:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.NoteSkill)
end

function NoteSkillCtrl:Awake()
  self._mapNode.window:SetActive(false)
  self.bBlur = true
  self.nMaxLevel = ConfigTable.GetConfigNumber("DiscSubNoteSkillMaxLevel")
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.tbNote = tbParam[1]
    self.nSelectNote = tbParam[2]
    if tbParam[3] ~= nil then
      self.bBlur = tbParam[3]
    end
  end
end

function NoteSkillCtrl:OnEnable()
  self:Open()
end

function NoteSkillCtrl:OnDisable()
end

function NoteSkillCtrl:OnDestroy()
end

function NoteSkillCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function NoteSkillCtrl:OnBtnClick_Prev()
  if self.nListCount <= 1 then
    return
  end
  self.nSelectIndex = self.nSelectIndex - 1
  if 1 > self.nSelectIndex then
    self.nSelectIndex = self.nListCount
  end
  self.nSelectNote = self.tbNoteId[self.nSelectIndex]
  self:Refresh()
end

function NoteSkillCtrl:OnBtnClick_Next()
  if self.nListCount <= 1 then
    return
  end
  self.nSelectIndex = self.nSelectIndex + 1
  if self.nSelectIndex > self.nListCount then
    self.nSelectIndex = 1
  end
  self.nSelectNote = self.tbNoteId[self.nSelectIndex]
  self:Refresh()
end

return NoteSkillCtrl
