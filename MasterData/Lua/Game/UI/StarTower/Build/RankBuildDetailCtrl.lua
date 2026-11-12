local RankBuildDetailCtrl = class("RankBuildDetailCtrl", BaseCtrl)
RankBuildDetailCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  TMPBuildSaveTime = {sComponentName = "TMP_Text"},
  ani_root = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  BuildDetail = {
    sCtrlName = "Game.UI.StarTower.Build.StarTowerBuildDetailItemCtrl"
  },
  ContentList = {
    sCtrlName = "Game.UI.StarTower.Build.StarTowerBuildContentCtrl"
  },
  btnSave = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Save"
  },
  txtBtnSave = {
    sComponentName = "TMP_Text",
    sLanguageId = "Rank_Build_Save_Preselection"
  }
}
RankBuildDetailCtrl._mapEventConfig = {}

function RankBuildDetailCtrl:InitPanel()
  if self.mapBuild == nil then
    return
  end
  local mapBuildData = {
    sName = ConfigTable.GetUIText("Rank_Build_Detail_Name"),
    tbChar = {},
    nScore = self.mapBuild.BuildScore,
    mapRank = PlayerData.Build:CalBuildRank(self.mapBuild.BuildScore),
    bLock = false,
    bPreference = false,
    bDetail = false,
    tbDisc = {},
    tbSecondarySkill = {},
    tbPotentials = {},
    tbNotes = {},
    bRankPreview = true
  }
  for i = 1, 3 do
    local nCharId = self.mapBuild.Chars[i].Id
    local nPotentialCount = 0
    for _, v in ipairs(self.mapBuild.Potentials) do
      local mapPotentialCfg = ConfigTable.GetData("Potential", v.PotentialId)
      if mapPotentialCfg ~= nil and mapPotentialCfg.CharId == nCharId then
        nPotentialCount = nPotentialCount + v.Level
      end
    end
    table.insert(mapBuildData.tbChar, {
      nTid = self.mapBuild.Chars[i].Id,
      nPotentialCount = nPotentialCount
    })
  end
  for _, v in ipairs(self.mapBuild.Potentials) do
    local potentialCfg = ConfigTable.GetData("Potential", v.PotentialId)
    if potentialCfg then
      local nCharId = potentialCfg.CharId
      if nil == mapBuildData.tbPotentials[nCharId] then
        mapBuildData.tbPotentials[nCharId] = {}
      end
      table.insert(mapBuildData.tbPotentials[nCharId], {
        nPotentialId = v.PotentialId,
        nLevel = v.Level
      })
    end
  end
  local tbNotes = {}
  for _, v in pairs(self.mapBuild.Notes) do
    tbNotes[v.Tid] = v.Qty
  end
  mapBuildData.tbNotes = tbNotes
  mapBuildData.tbDisc = self.mapBuild.Discs
  mapBuildData.tbSecondarySkill = self.mapBuild.ActiveSecondaryIds
  self._mapNode.BuildDetail:Refresh(mapBuildData)
  self._mapNode.ContentList:Refresh(mapBuildData)
end

function RankBuildDetailCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapBuild = tbParam[1]
  end
end

function RankBuildDetailCtrl:OnEnable()
  self:InitPanel()
end

function RankBuildDetailCtrl:OnDisable()
end

function RankBuildDetailCtrl:OnDestroy()
end

function RankBuildDetailCtrl:OnRelease()
end

function RankBuildDetailCtrl:OnBtnClick_Save()
  local tbAllPreselectionList = PlayerData.PotentialPreselection:GetPreselectionList()
  local nAllCount = ConfigTable.GetConfigNumber("PotentialPreselectionMaxCount")
  if nAllCount <= #tbAllPreselectionList then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Build_Max"))
    return
  end
  local tbCharPotential = {}
  for k, v in ipairs(self.mapBuild.Chars) do
    local nCharId = v.Id
    local tbPotential = {}
    for _, data in ipairs(self.mapBuild.Potentials) do
      local mapPotentialCfg = ConfigTable.GetData("Potential", data.PotentialId)
      if mapPotentialCfg ~= nil and mapPotentialCfg.CharId == nCharId then
        table.insert(tbPotential, {
          Id = data.PotentialId,
          Level = data.Level
        })
      end
    end
    table.insert(tbCharPotential, {CharId = nCharId, Potentials = tbPotential})
  end
  local sName = ConfigTable.GetUIText("Potential_Preselection_Name_Init")
  
  local function callback()
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Save_Form_Rank"))
  end
  
  PlayerData.PotentialPreselection:SavePreselectionFromRank(sName, false, tbCharPotential, callback)
end

return RankBuildDetailCtrl
