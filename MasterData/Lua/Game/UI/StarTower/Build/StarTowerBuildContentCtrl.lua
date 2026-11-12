local StarTowerBuildContentCtrl = class("StarTowerBuildContentCtrl", BaseCtrl)
StarTowerBuildContentCtrl._mapNodeConfig = {
  btnPotentialTab = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Potential"
  },
  btnDiscTab = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Disc"
  },
  txtPotential = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "StarTower_Build_Potential_Btn"
  },
  txtDisc = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "StarTower_Build_Disc_Btn"
  },
  imgOn = {nCount = 2},
  imgOff = {nCount = 2},
  svPotential = {},
  PotentialList = {
    nCount = 3,
    sCtrlName = "Game.UI.StarTower.Build.PotentialListItemCtrl"
  },
  rtPotentialContent = {
    sComponentName = "RectTransform"
  },
  goEmptyPotential = {},
  goPotentialList = {},
  svDisc = {},
  txtNoteLine = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_NoteSkill_Title"
  },
  txtSkillLine = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_DiscSkill_Title"
  },
  imgNote = {nCount = 13, sComponentName = "Image"},
  txtNoteCount = {nCount = 13, sComponentName = "TMP_Text"},
  imgSkillEmpty = {},
  rtSkill = {},
  txtSkillEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_DiscSkill_Empty"
  },
  btnNoteInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NoteInfo"
  },
  btnSkill = {
    nCount = 6,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  goSkillEmpty = {nCount = 6},
  imgSkillIconBg = {nCount = 6, sComponentName = "Image"},
  imgSkillIcon = {nCount = 6, sComponentName = "Image"},
  txtSkillName = {nCount = 6, sComponentName = "TMP_Text"},
  txtSkillLevel = {nCount = 6, sComponentName = "TMP_Text"},
  txtSkillUnactive1_ = {
    nCount = 6,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_DiscSkill_NotActivated"
  },
  txtSkillUnactive2_ = {
    nCount = 6,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_DiscSkill_NotActivated"
  },
  imgLock1_ = {nCount = 6},
  imgLock2_ = {nCount = 6},
  PotentialDepotItem = {},
  goEmptyDisc = {},
  txt_Empty = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Disc_Skill_Empty"
  },
  txt_EmptyPotential = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Potential_Empty"
  },
  scPotential = {
    sNodeName = "svPotential",
    sComponentName = "UIScrollToClick"
  },
  scDisc = {
    sNodeName = "svDisc",
    sComponentName = "UIScrollToClick"
  }
}
StarTowerBuildContentCtrl._mapEventConfig = {
  SelectDepotPotential = "OnEvent_SelectDepotPotential"
}
StarTowerBuildContentCtrl._mapRedDotConfig = {}

function StarTowerBuildContentCtrl:Refresh(mapBuild, nDefaultTab)
  self.mapBuild = mapBuild
  self:InitDisc()
  self:InitPotential()
  if nDefaultTab == nil then
    nDefaultTab = 1
  end
  self:SetDefaultTab(nDefaultTab)
end

function StarTowerBuildContentCtrl:SetDefaultTab(nDefaultTab)
  self.nCurTab = nDefaultTab
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == self.nCurTab)
    self._mapNode.imgOff[i]:SetActive(i ~= self.nCurTab)
  end
  self._mapNode.svPotential:SetActive(self.nCurTab == 1)
  self._mapNode.svDisc:SetActive(self.nCurTab == 2)
end

function StarTowerBuildContentCtrl:InitPotential()
  local tbPotential = self.mapBuild.tbPotentials
  local tbChar = self.mapBuild.tbChar
  local bEmpty = true
  for k, v in ipairs(self._mapNode.PotentialList) do
    local nCount = tbChar[k].nPotentialCount
    v.gameObject:SetActive(0 < nCount)
    if 0 < nCount then
      bEmpty = false
      v:Init(tbChar[k].nTid, tbChar[k].nPotentialCount, tbPotential[tbChar[k].nTid], self._mapNode.PotentialDepotItem, k == 1, self.mapBuild.bRankPreview)
    end
  end
  self._mapNode.goEmptyPotential.gameObject:SetActive(bEmpty)
  self._mapNode.goPotentialList.gameObject:SetActive(not bEmpty)
end

function StarTowerBuildContentCtrl:InitDisc()
  local tbNote = {}
  if self.mapBuild.nTowerId ~= nil then
    local mapTowerCfg = ConfigTable.GetData("StarTower", self.mapBuild.nTowerId)
    if mapTowerCfg ~= nil then
      local nDropGroup = mapTowerCfg.SubNoteSkillDropGroupId
      local tbNoteDrop = CacheTable.GetData("_SubNoteSkillDropGroup", nDropGroup)
      if tbNoteDrop ~= nil then
        for _, v in ipairs(tbNoteDrop) do
          table.insert(tbNote, v.SubNoteSkillId)
        end
      end
    end
  end
  table.sort(tbNote)
  local exNote = {}
  for nNoteId, _ in pairs(self.mapBuild.tbNotes) do
    if table.indexof(tbNote, nNoteId) < 1 then
      table.insert(exNote, nNoteId)
    end
  end
  table.sort(exNote)
  for _, nNoteId in ipairs(exNote) do
    table.insert(tbNote, nNoteId)
  end
  local nNoteCount = #tbNote
  self.tbShowNote = {}
  for i = 1, 13 do
    self._mapNode.imgNote[i].gameObject:SetActive(i <= nNoteCount)
    if i <= nNoteCount then
      self.tbShowNote[tbNote[i]] = self.mapBuild.tbNotes[tbNote[i]] or 0
      NovaAPI.SetTMPText(self._mapNode.txtNoteCount[i], self.mapBuild.tbNotes[tbNote[i]] or 0)
      local mapNoteSkillCfg = ConfigTable.GetData("SubNoteSkill", tbNote[i])
      if mapNoteSkillCfg then
        self:SetPngSprite(self._mapNode.imgNote[i], mapNoteSkillCfg.Icon)
      end
    end
  end
  self.tbSkill = {}
  local tbDisc = self.mapBuild.tbDisc
  for k, nId in ipairs(tbDisc) do
    if k <= 3 then
      local mapDisc = PlayerData.Build:GetBuildDiscByData(self.mapBuild, nId)
      if mapDisc ~= nil then
        local tbSubSkill = mapDisc:GetAllSubSkill(self.mapBuild.tbNotes)
        for nSkillIndex, v in ipairs(tbSubSkill) do
          table.insert(self.tbSkill, {
            nSkillId = v,
            nDiscIndex = k,
            nSkillIndex = nSkillIndex
          })
        end
      end
    end
  end
  
  local function sort(a, b)
    if a.nDiscIndex ~= b.nDiscIndex then
      return a.nDiscIndex < b.nDiscIndex
    elseif a.nSkillIndex ~= b.nSkillIndex then
      return a.nSkillIndex < b.nSkillIndex
    end
  end
  
  table.sort(self.tbSkill, sort)
  local bSkillEmpty = next(self.tbSkill) == nil
  self._mapNode.rtSkill:SetActive(not bSkillEmpty)
  self._mapNode.imgSkillEmpty:SetActive(bSkillEmpty)
  if bSkillEmpty then
    return
  end
  for i = 1, 6 do
    local mapSkill = self.tbSkill[i]
    self._mapNode.btnSkill[i].gameObject:SetActive(mapSkill)
    self._mapNode.goSkillEmpty[i]:SetActive(not mapSkill)
    if mapSkill then
      local nId = mapSkill.nSkillId
      local bActive = 0 < table.indexof(self.mapBuild.tbSecondarySkill, nId)
      self._mapNode.imgLock1_[i]:SetActive(not bActive)
      self._mapNode.imgLock2_[i]:SetActive(not bActive)
      self._mapNode.txtSkillUnactive1_[i].gameObject:SetActive(not bActive)
      self._mapNode.txtSkillLevel[i].gameObject:SetActive(bActive)
      local mapCfg = ConfigTable.GetData("SecondarySkill", nId)
      if mapCfg then
        self:SetPngSprite(self._mapNode.imgSkillIcon[i], mapCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
        self:SetPngSprite(self._mapNode.imgSkillIconBg[i], mapCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
        NovaAPI.SetTMPText(self._mapNode.txtSkillName[i], mapCfg.Name)
        NovaAPI.SetTMPText(self._mapNode.txtSkillLevel[i], orderedFormat(ConfigTable.GetUIText("Build_DiscSkill_Sub_Level"), mapCfg.Level))
      end
    end
  end
end

function StarTowerBuildContentCtrl:ChangeTab(nIndex)
  if self.nCurTab == nIndex then
    return
  end
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == nIndex)
    self._mapNode.imgOff[i]:SetActive(i ~= nIndex)
  end
  self.nCurTab = nIndex
  self._mapNode.svPotential:SetActive(self.nCurTab == 1)
  self._mapNode.svDisc:SetActive(self.nCurTab == 2)
  EventManager.Hit("StarTowerBuildContent_ChangeTab", nIndex)
end

function StarTowerBuildContentCtrl:Awake()
  self._mapNode.PotentialDepotItem.gameObject:SetActive(false)
end

function StarTowerBuildContentCtrl:OnDisable()
end

function StarTowerBuildContentCtrl:OnBtnClick_Potential()
  self:ChangeTab(1)
end

function StarTowerBuildContentCtrl:OnBtnClick_Disc()
  self:ChangeTab(2)
end

function StarTowerBuildContentCtrl:OnEvent_SelectDepotPotential(nPotentialId, nLevel, nPotentialAdd, btn)
  if btn == nil or PanelManager.CheckPanelOpen(PanelId.CharBgTrialPanel) then
    return
  end
  
  local function tip()
    EventManager.Hit(EventId.OpenPanel, PanelId.PotentialDetail, nPotentialId, nLevel, nPotentialAdd)
  end
  
  self._mapNode.scPotential:ScrollToClick(btn.gameObject, 0.1)
  self:AddTimer(1, 0.1, tip, true, true, true)
end

function StarTowerBuildContentCtrl:OnEvent_BuildClickDiscSkill(btn, callback)
  self._mapNode.scDisc:ScrollToClick(btn.gameObject, 0.1)
  self:AddTimer(1, 0.1, callback, true, true, true)
end

function StarTowerBuildContentCtrl:OnBtnClick_NoteInfo()
  EventManager.Hit(EventId.OpenPanel, PanelId.NoteSkillInfo, self.tbShowNote)
end

function StarTowerBuildContentCtrl:OnBtnClick_Skill(btn, nIndex)
  local mapData = {
    nSkillId = self.tbSkill[nIndex].nSkillId
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSkillTips, btn.transform, mapData)
end

return StarTowerBuildContentCtrl
