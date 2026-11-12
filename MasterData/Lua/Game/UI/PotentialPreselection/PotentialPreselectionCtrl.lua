local LocalData = require("GameCore.Data.LocalData")
local PotentialPreselectionCtrl = class("PotentialPreselectionCtrl", BaseCtrl)
PotentialPreselectionCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  EmptyContent = {},
  txt_Empty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_List_Empty"
  },
  ExistContent = {},
  imgAllCount = {},
  txt_BuildCount = {sComponentName = "TMP_Text"},
  btn_DeleteBuild = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Delete"
  },
  txtBtnDelete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Delete"
  },
  btnImport = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Import"
  },
  txtBtnImport = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Import"
  },
  SystemRcmdSwitch = {},
  btnSwitch = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  txtSystemRcmdSwitch = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_System_Preset_Rcmd"
  },
  BuildList = {
    sComponentName = "LoopScrollView"
  },
  goFilterEmpty = {},
  txt_FilterEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_List_Empty_Filter"
  },
  btn_sort_time = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SortTime"
  },
  txt_sort_timeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_SortTime"
  },
  btnFilter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Filter"
  },
  btnRoot = {
    sComponentName = "RectTransform"
  },
  imgFilterChoose = {},
  btnCreate = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Create"
  },
  txtBtnCreate = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Create"
  },
  DeleteContent = {},
  btn_CloseDelete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseDelete"
  },
  txt_CloseDelete = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Common_BtnCancle"
  },
  txtDelete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Deleting"
  }
}
PotentialPreselectionCtrl._mapEventConfig = {
  [EventId.FilterConfirm] = "OnEvent_RefreshByFilter",
  DeletePotentialPreselection = "OnEvent_DeleteSuc",
  RefreshPreselectionList = "OnEvent_RefreshPreselectionList"
}
PotentialPreselectionCtrl._mapRedDotConfig = {}
local PanelState = {normal = 1, delete = 2}
local SortOrder = {Descending = true, Ascending = false}
local ShowSystemRcmdKey = "ShowSystemRecommend"

function PotentialPreselectionCtrl:ConvertUnpackData(tbUnpackData)
  local tbCharPotential = {}
  if tbUnpackData == nil then
    return tbCharPotential
  end
  for _, mapCharData in ipairs(tbUnpackData) do
    local tbPotential = {}
    for _, mapPotential in ipairs(mapCharData.Potentials or {}) do
      table.insert(tbPotential, {
        nId = mapPotential.Id,
        nLevel = mapPotential.Level
      })
    end
    table.insert(tbCharPotential, {
      nCharId = mapCharData.CharId,
      tbPotential = tbPotential
    })
  end
  return tbCharPotential
end

function PotentialPreselectionCtrl:RefreshSelectCharFromTeam()
  if self.nTeamIndex == nil or self.nTeamIndex <= 0 then
    return
  end
  local _, tbTeamMemberId = PlayerData.Team:GetTeamData(self.nTeamIndex)
  if tbTeamMemberId == nil then
    return
  end
  self.tbSelectChar = {}
  for i = 1, 3 do
    self.tbSelectChar[i] = tbTeamMemberId[i] or 0
  end
end

function PotentialPreselectionCtrl:GetSystemRecommendList()
  local tbList = {}
  if not self.bShowSystemRecommend or self.tbSelectChar == nil then
    return tbList
  end
  local mapTeamCharId = {}
  for i = 1, 3 do
    local nCharId = self.tbSelectChar[i]
    if nCharId ~= nil and 0 < nCharId then
      mapTeamCharId[nCharId] = true
    end
  end
  if next(mapTeamCharId) == nil then
    return tbList
  end
  local tbPotentialPreset = ConfigTable.Get("PotentialPreset")
  ForEachTableLine(tbPotentialPreset, function(mapCfg)
    if mapTeamCharId[mapCfg.CharacterId] == true then
      local tbUnpackData = PlayerData.PotentialPreselection:UnPackPotentialData(mapCfg.ShareCode)
      if tbUnpackData ~= nil then
        table.insert(tbList, {
          nId = mapCfg.Id,
          nSystemPresetId = mapCfg.Id,
          nTimestamp = 0,
          sName = mapCfg.Name,
          sDescription = mapCfg.Description,
          sShareCode = mapCfg.ShareCode,
          bPreference = false,
          bSystemRecommend = true,
          tbCharPotential = self:ConvertUnpackData(tbUnpackData)
        })
      end
    end
  end)
  table.sort(tbList, function(a, b)
    return a.nSystemPresetId < b.nSystemPresetId
  end)
  return tbList
end

function PotentialPreselectionCtrl:InitSort()
  self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = self.nSortOrder == SortOrder.Ascending
  self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = self.nSortOrder == SortOrder.Descending
end

function PotentialPreselectionCtrl:RefreshPanel()
  self._mapNode.DeleteContent.gameObject:SetActive(self.nPanelType == PanelState.delete)
  self:RefreshList()
end

function PotentialPreselectionCtrl:RefreshList()
  self:RefreshSelectCharFromTeam()
  self.tbAllPreselectionList = PlayerData.PotentialPreselection:GetPreselectionList()
  self.tbPreselectionList = {}
  local tbNormalPreselectionList = {}
  for _, v in pairs(self.tbAllPreselectionList) do
    local mapMainChar = v.tbCharPotential[1]
    local nCharId = mapMainChar.nCharId
    local isFilter = PlayerData.Filter:CheckFilterByCharAndOption(nCharId, self._panel.tbOption)
    if isFilter then
      table.insert(tbNormalPreselectionList, v)
    end
  end
  table.sort(tbNormalPreselectionList, function(a, b)
    if self.nSortOrder == SortOrder.Descending then
      return a.nTimestamp > b.nTimestamp
    else
      return a.nTimestamp < b.nTimestamp
    end
  end)
  local tbSystemRecommendList = self:GetSystemRecommendList()
  for _, mapData in ipairs(tbSystemRecommendList) do
    table.insert(self.tbPreselectionList, mapData)
  end
  for _, mapData in ipairs(tbNormalPreselectionList) do
    table.insert(self.tbPreselectionList, mapData)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_BuildCount, string.format("%d/%d", #self.tbAllPreselectionList, self.nAllBuildCount))
  local isDirty = PlayerData.Filter:IsDirtyByOption(self._panel.tbOption)
  self._mapNode.imgFilterChoose:SetActive(isDirty)
  local bEmpty = #self.tbAllPreselectionList == 0 and #tbSystemRecommendList == 0
  self._mapNode.EmptyContent.gameObject:SetActive(bEmpty)
  self._mapNode.ExistContent.gameObject:SetActive(not bEmpty)
  self._mapNode.btn_sort_time.gameObject:SetActive(not bEmpty)
  self._mapNode.btnFilter.gameObject:SetActive(not bEmpty)
  self._mapNode.imgAllCount.gameObject:SetActive(not bEmpty)
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.btnRoot)
  for nInstanceId, objCtrl in pairs(self.mapGridCtrl or {}) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapGridCtrl[nInstanceId] = nil
  end
  if bEmpty then
    return
  end
  self._mapNode.goFilterEmpty.gameObject:SetActive(#self.tbPreselectionList == 0)
  self._mapNode.BuildList.gameObject:SetActive(#self.tbPreselectionList > 0)
  if #self.tbPreselectionList == 0 then
    return
  end
  self._mapNode.BuildList:Init(#self.tbPreselectionList, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function PotentialPreselectionCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local objCtrl = self.mapGridCtrl[nInstanceId]
  if objCtrl == nil then
    objCtrl = self:BindCtrlByNode(goGrid, "Game.UI.PotentialPreselection.PotentialPreselectionItemCtrl")
    self.mapGridCtrl[nInstanceId] = objCtrl
  end
  local mapData = self.tbPreselectionList[nIndex]
  if mapData ~= nil then
    local bSelected = mapData.bSystemRecommend ~= true and mapData.nId == self.nSelectPreselectionId
    local bCharDiff = false
    if self.tbSelectChar ~= nil then
      local tbSelectChar = {}
      for i = 1, 3 do
        tbSelectChar[i] = self.tbSelectChar[i] or 0
      end
      for k, v in ipairs(mapData.tbCharPotential) do
        if k == 1 then
          if v.nCharId ~= tbSelectChar[k] then
            bCharDiff = true
            break
          end
        elseif table.indexof(tbSelectChar, v.nCharId) == 0 then
          bCharDiff = true
          break
        end
      end
    end
    local bSystemRecommend = mapData.bSystemRecommend == true
    objCtrl:RefreshItem(mapData, bCharDiff, bSelected, bSystemRecommend)
    objCtrl:ShowDelete(self.nPanelType == PanelState.delete and not bSystemRecommend)
  end
end

function PotentialPreselectionCtrl:OnGridBtnClick(goGrid, gridIndex)
  if self.nPanelType == PanelState.delete then
    return
  end
  local nIndex = gridIndex + 1
  local mapData = self.tbPreselectionList[nIndex]
  if mapData ~= nil then
    if mapData.bSystemRecommend == true then
      EventManager.Hit(EventId.OpenPanel, PanelId.PotentialPreselectionEdit, AllEnum.PreselectionPanelType.SystemPreview, mapData, self.tbSelectChar or {}, self.nTeamIndex or 0, mapData.sName)
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.PotentialPreselectionEdit, AllEnum.PreselectionPanelType.Preview, mapData, self.tbSelectChar, self.nTeamIndex)
    end
  end
end

function PotentialPreselectionCtrl:FadeIn()
  if self._panel._nFadeInType == 1 then
    EventManager.Hit(EventId.SetTransition)
    if #self.tbPreselectionList > 0 then
      EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
    end
  end
end

function PotentialPreselectionCtrl:Awake()
end

function PotentialPreselectionCtrl:OnEnable()
  if next(self._panel.mapCacheFilter) ~= nil then
    for fKey, data in pairs(self._panel.mapCacheFilter) do
      for sKey, value in pairs(data) do
        PlayerData.Filter:SetCacheFilterByKey(fKey, sKey, value)
      end
    end
    PlayerData.Filter:SyncFilterByCache()
  end
  self.tbSelectChar = nil
  self.nTeamIndex = nil
  self.bEnableSystemRecommend = false
  self.nSelectPreselectionId = nil
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.tbSelectChar = tbParam[1]
    self.nTeamIndex = tbParam[2]
    self.bEnableSystemRecommend = tbParam[3] == true
  end
  if self.nTeamIndex ~= nil then
    self.nSelectPreselectionId = PlayerData.Team:GetTeamPreselectionId(self.nTeamIndex)
  end
  self.mapGridCtrl = {}
  self.nPanelType = PanelState.normal
  self.nSortOrder = SortOrder.Descending
  self.nAllBuildCount = ConfigTable.GetConfigNumber("PotentialPreselectionMaxCount")
  local bHasTeamChar = false
  if self.tbSelectChar ~= nil then
    for i = 1, 3 do
      local nCharId = self.tbSelectChar[i]
      if nCharId ~= nil and 0 < nCharId then
        bHasTeamChar = true
        break
      end
    end
  end
  self.bEnableSystemRecommend = self.bEnableSystemRecommend and bHasTeamChar
  self.bShowSystemRecommend = self.bEnableSystemRecommend and (LocalData.GetPlayerLocalData(ShowSystemRcmdKey) == "1" or LocalData.GetPlayerLocalData(ShowSystemRcmdKey) == nil)
  self._mapNode.SystemRcmdSwitch.gameObject:SetActive(self.bEnableSystemRecommend)
  self._mapNode.btnSwitch[2].gameObject:SetActive(self.bShowSystemRecommend)
  self._mapNode.btnSwitch[1].gameObject:SetActive(not self.bShowSystemRecommend)
  self:InitSort()
  self:RefreshPanel()
end

function PotentialPreselectionCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.mapGridCtrl or {}) do
    self:UnbindCtrlByNode(objCtrl)
  end
  self.mapGridCtrl = {}
  self._panel.mapCacheFilter = {}
  for _, fKey in ipairs(self._panel.tbOption) do
    if self._panel.mapCacheFilter[fKey] == nil then
      self._panel.mapCacheFilter[fKey] = {}
    end
    local data = PlayerData.Filter:GetCacheFilter(fKey)
    if data ~= nil then
      for sKey, value in pairs(data) do
        self._panel.mapCacheFilter[fKey][sKey] = value
      end
    end
  end
  PlayerData.Filter:Reset(self._panel.tbOption)
end

function PotentialPreselectionCtrl:OnDestroy()
end

function PotentialPreselectionCtrl:OnRelease()
end

function PotentialPreselectionCtrl:OnBtnClick_Delete()
  if self.nPanelType == PanelState.delete then
    return
  end
  self.nPanelType = PanelState.delete
  self:RefreshPanel()
end

function PotentialPreselectionCtrl:OnBtnClick_Import()
  if self.nPanelType == PanelState.delete then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Import_Disable"))
    return
  end
  if #self.tbAllPreselectionList >= self.nAllBuildCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Build_Max"))
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.ImportPreselection)
end

function PotentialPreselectionCtrl:OnBtnClick_SortTime()
  self.nSortOrder = not self.nSortOrder
  self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_AsceIcon"):GetComponent("Button").interactable = self.nSortOrder == SortOrder.Ascending
  self._mapNode.btn_sort_time.transform:Find("AnimRoot/btn_DescIcon"):GetComponent("Button").interactable = self.nSortOrder == SortOrder.Descending
  self:RefreshList()
end

function PotentialPreselectionCtrl:OnBtnClick_Filter()
  EventManager.Hit(EventId.OpenPanel, PanelId.FilterPopupPanel, self._panel.tbOption)
end

function PotentialPreselectionCtrl:OnBtnClick_Create()
  if #self.tbAllPreselectionList >= self.nAllBuildCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Build_Max"))
    return
  end
  self._panel._nFadeInType = 2
  EventManager.Hit(EventId.OpenPanel, PanelId.PotentialPreselectionEdit, AllEnum.PreselectionPanelType.Create, {}, self.tbSelectChar, self.nTeamIndex)
end

function PotentialPreselectionCtrl:OnBtnClick_Switch(btn, nIndex)
  if not self.bEnableSystemRecommend then
    return
  end
  self.bShowSystemRecommend = not self.bShowSystemRecommend
  LocalData.SetPlayerLocalData(ShowSystemRcmdKey, self.bShowSystemRecommend and "1" or "0")
  self._mapNode.btnSwitch[2].gameObject:SetActive(self.bShowSystemRecommend)
  self._mapNode.btnSwitch[1].gameObject:SetActive(not self.bShowSystemRecommend)
  local sTip = self.bShowSystemRecommend and ConfigTable.GetUIText("Potential_Preselection_SystemRecommend_Show") or ConfigTable.GetUIText("Potential_Preselection_SystemRecommend_Hide")
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Tips,
    bPositive = true,
    sContent = sTip
  })
  self:RefreshList()
end

function PotentialPreselectionCtrl:OnBtnClick_CloseDelete()
  self.nPanelType = PanelState.normal
  self:RefreshPanel()
end

function PotentialPreselectionCtrl:OnEvent_RefreshByFilter()
  self._panel.mapCacheFilter = {}
  self:RefreshList()
end

function PotentialPreselectionCtrl:OnEvent_DeleteSuc()
  self:RefreshList()
end

function PotentialPreselectionCtrl:OnEvent_RefreshPreselectionList()
  if self.nTeamIndex ~= nil then
    self.nSelectPreselectionId = PlayerData.Team:GetTeamPreselectionId(self.nTeamIndex)
  end
  self:RefreshList()
end

return PotentialPreselectionCtrl
