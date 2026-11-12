local CharPotentialPresetCtrl = class("CharPotentialPresetCtrl", BaseCtrl)
CharPotentialPresetCtrl._mapNodeConfig = {
  t_window = {},
  goBlur = {},
  aniWindow = {sNodeName = "t_window", sComponentName = "Animator"},
  txtPresetWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_System_Preset_WindowTitle"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnScreenClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  },
  goContent = {},
  goEmpty = {},
  txtPresetEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_System_Preset_Empty"
  },
  PresetItem = {nCount = 3},
  txtPresetName = {nCount = 3, sComponentName = "TMP_Text"},
  txtPresetDesc = {nCount = 3, sComponentName = "TMP_Text"},
  PotentialPreselectionItem = {
    nCount = 3,
    sCtrlName = "Game.UI.PotentialPreselection.PotentialPreselectionItemCtrl"
  },
  btnDetail = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  btnSave = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Save"
  },
  txtBtnSave = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "Rank_Build_Save_Preselection"
  }
}
CharPotentialPresetCtrl._mapEventConfig = {}
CharPotentialPresetCtrl._mapRedDotConfig = {}

local function convertUnpackData(tbUnpackData)
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

local function convertToNetPotential(tbCharPotential)
  local tbNetPotential = {}
  for _, mapCharData in ipairs(tbCharPotential or {}) do
    local tbPotential = {}
    for _, mapPotential in ipairs(mapCharData.tbPotential or {}) do
      table.insert(tbPotential, {
        Id = mapPotential.nId,
        Level = mapPotential.nLevel
      })
    end
    table.insert(tbNetPotential, {
      CharId = mapCharData.nCharId,
      Potentials = tbPotential
    })
  end
  return tbNetPotential
end

function CharPotentialPresetCtrl:SetCharId(nCharId)
  self._nCharId = nCharId
end

function CharPotentialPresetCtrl:Refresh(nCharId)
  self._nCharId = nCharId or self._nCharId
  self._tbPresetList = {}
  local tbPotentialPreset = ConfigTable.Get("PotentialPreset")
  ForEachTableLine(tbPotentialPreset, function(mapCfg)
    if mapCfg.CharacterId == self._nCharId then
      local tbUnpackData = PlayerData.PotentialPreselection:UnPackPotentialData(mapCfg.ShareCode)
      if tbUnpackData ~= nil then
        local mapData = {
          nId = mapCfg.Id,
          sName = mapCfg.Name,
          sDescription = mapCfg.Description,
          sShareCode = mapCfg.ShareCode,
          bPreference = false,
          tbCharPotential = convertUnpackData(tbUnpackData)
        }
        table.insert(self._tbPresetList, mapData)
      end
    end
  end)
  table.sort(self._tbPresetList, function(a, b)
    return a.nId < b.nId
  end)
  self:RefreshList()
end

function CharPotentialPresetCtrl:RefreshList()
  local bHavePreset = false
  for i = 1, 3 do
    local mapData = self._tbPresetList[i]
    self._mapNode.PresetItem[i]:SetActive(mapData ~= nil)
    if mapData ~= nil then
      bHavePreset = true
      NovaAPI.SetTMPText(self._mapNode.txtPresetName[i], mapData.sName)
      NovaAPI.SetTMPText(self._mapNode.txtPresetDesc[i], mapData.sDescription)
      self._mapNode.PotentialPreselectionItem[i]:RefreshItem(mapData, false, false, true)
    end
  end
  self._mapNode.goContent:SetActive(bHavePreset)
  self._mapNode.goEmpty:SetActive(not bHavePreset)
end

function CharPotentialPresetCtrl:OpenPanel(nCharId)
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    self._mapNode.goBlur:SetActive(true)
    self._mapNode.t_window:SetActive(true)
    self:Refresh(nCharId)
    self:PlayInAni()
  end
  
  cs_coroutine.start(wait)
end

function CharPotentialPresetCtrl:PlayInAni()
  if self._mapNode.aniWindow ~= nil then
    self._mapNode.aniWindow:Play("t_window_04_t_in")
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function CharPotentialPresetCtrl:PlayOutAni(callback)
  if self._mapNode.aniWindow ~= nil then
    self._mapNode.aniWindow:Play("t_window_04_t_out")
  end
  self:AddTimer(1, 0.2, callback, true, true, true)
end

function CharPotentialPresetCtrl:Close()
  local function callback()
    EventManager.Hit(EventId.ClosePanel, PanelId.CharSystemPresetPotentialPanel)
  end
  
  self:PlayOutAni(callback)
end

function CharPotentialPresetCtrl:GetPresetData(nIndex)
  if self._tbPresetList == nil then
    return
  end
  return self._tbPresetList[nIndex]
end

function CharPotentialPresetCtrl:Awake()
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.t_window:SetActive(false)
  self._tbPresetList = {}
  local tbParam = self:GetPanelParam()
  if tbParam ~= nil then
    self._nCharId = tbParam[1]
  end
end

function CharPotentialPresetCtrl:OnEnable()
  self:OpenPanel(self._nCharId)
end

function CharPotentialPresetCtrl:OnDisable()
end

function CharPotentialPresetCtrl:OnDestroy()
end

function CharPotentialPresetCtrl:OnBtnClick_Close()
  self:Close()
end

function CharPotentialPresetCtrl:OnBtnClick_Detail(btn, nIndex)
  local mapData = self:GetPresetData(nIndex)
  if mapData == nil then
    return
  end
  if #mapData.tbCharPotential < 3 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Import_Error"))
    return
  end
  local sName = self._tbPresetList[nIndex].sName
  EventManager.Hit(EventId.ClosePanel, PanelId.CharSystemPresetPotentialPanel)
  EventManager.Hit(EventId.OpenPanel, PanelId.PotentialPreselectionEdit, AllEnum.PreselectionPanelType.SystemPreview, mapData, {}, 0, sName)
end

function CharPotentialPresetCtrl:OnBtnClick_Save(btn, nIndex)
  local mapData = self:GetPresetData(nIndex)
  if mapData == nil then
    return
  end
  local tbAllPreselectionList = PlayerData.PotentialPreselection:GetPreselectionList()
  local nAllCount = ConfigTable.GetConfigNumber("PotentialPreselectionMaxCount")
  if nAllCount <= #tbAllPreselectionList then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Build_Max"))
    return
  end
  local sName = self._tbPresetList[nIndex].sName
  local tbCharPotential = convertToNetPotential(mapData.tbCharPotential)
  
  local function callback()
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Save_Form_Rank"))
    EventManager.Hit("RefreshPreselectionList")
  end
  
  PlayerData.PotentialPreselection:SavePreselectionFromRank(sName, false, tbCharPotential, callback)
end

return CharPotentialPresetCtrl
