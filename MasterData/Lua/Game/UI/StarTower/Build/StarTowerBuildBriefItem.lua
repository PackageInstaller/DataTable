local StarTowerBuildBriefItem = class("StarTowerBuildBriefItem", BaseCtrl)
local PanelState = {
  Normal = 1,
  Delete = 2,
  Preference = 3
}
StarTowerBuildBriefItem._mapNodeConfig = {
  img_SelectDelete = {},
  img_SelectPreference = {},
  btn_LockIcon = {sComponentName = "Button"},
  btn_grid = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Grid"
  },
  btn_Lock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  btn_Detail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  btn_Preference = {
    sComponentName = "Button",
    callback = "OnBtnClick_Preference"
  },
  imgRareFrame = {sComponentName = "Image"},
  imgRareScore = {sComponentName = "Image"},
  txtBuildName = {sComponentName = "TMP_Text"},
  imgLike = {},
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Sub"
  },
  imgCharIcon = {nCount = 3, sComponentName = "Image"},
  imgCharFrame = {nCount = 3, sComponentName = "Image"},
  txtPotentialCount = {nCount = 3, sComponentName = "TMP_Text"},
  imgCharElement = {nCount = 3, sComponentName = "Image"},
  txtChar = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Char_Title"
  },
  txtDisc = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_MainDisc_Title"
  },
  goDiscItem = {
    nCount = 3,
    sCtrlName = "Game.UI.StarTower.Build.BuildSimpleDiscItem"
  },
  btnExport = {sComponentName = "UIButton"},
  objUnavailable = {},
  imgUnavailableMask = {
    sNodeName = "objUnavailable",
    sComponentName = "Image"
  },
  objUnavailableIcon = {sComponentName = "Image"},
  imgRareScoreMask = {sComponentName = "Image"},
  texUnavailable = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Build_NotAvailable"
  },
  imgUnavailable = {},
  imgBuildUsed = {},
  txtBuildUsed = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Build_Used"
  },
  imgCharUsed = {},
  txtCharUsed = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Build_Char_Used"
  },
  imgLabel2 = {},
  txtReTrial = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_BDTrialPreview_BDLabel"
  }
}
StarTowerBuildBriefItem._mapEventConfig = {}

function StarTowerBuildBriefItem:RefreshGrid(mapData, nPanelState, bSelectDelete, bCheckOut, bCheckIn, nType)
  self._mapData = mapData
  self._nType = nType
  self._bLimitedTrialBuild = mapData.nBuildSource == AllEnum.BuildSource.LimitedTrial
  self._bLimitedTrialBuildLocked = self._bLimitedTrialBuild and not PlayerData.Build:IsLimitedTrialBuildAllowedType(self._nType)
  self:RefreshInfo()
  self:RefreshChar()
  self:RefreshDisc()
  self._mapNode.imgLabel2:SetActive(self._bLimitedTrialBuild)
  if nPanelState == PanelState.Delete then
    self._mapNode.img_SelectDelete:SetActive(bSelectDelete)
    self._mapNode.img_SelectPreference:SetActive(false)
  elseif nPanelState == PanelState.Preference then
    if bCheckOut then
      self._mapNode.img_SelectPreference:SetActive(false)
    elseif bCheckIn then
      self._mapNode.img_SelectPreference:SetActive(true)
    else
      self._mapNode.img_SelectPreference:SetActive(mapData.bPreference)
    end
    self._mapNode.img_SelectDelete:SetActive(false)
  else
    self._mapNode.img_SelectPreference:SetActive(false)
    self._mapNode.img_SelectDelete:SetActive(false)
  end
  self._mapNode.btnExport.gameObject:SetActive(false)
  EventManager.Hit("BuildItemExport", self._mapNode.btnExport, self._mapData.nBuildId)
  if self._nType and self._nType == AllEnum.RegionBossFormationType.InfinityTower or self._nType == AllEnum.RegionBossFormationType.Vampire or self._nType == AllEnum.RegionBossFormationType.JointDrill or self._nType == AllEnum.RegionBossFormationType.JointDrill_2 then
    local sScore = "Icon/BuildRank/BuildRank_" .. self._mapData.mapRank.Id
    self:SetPngSprite(self._mapNode.imgRareScoreMask, sScore)
    local bShowUnavailable = false
    if self._nType == AllEnum.RegionBossFormationType.InfinityTower or self._nType == AllEnum.RegionBossFormationType.Vampire then
      bShowUnavailable = not self._mapData.isCanUse
    else
      bShowUnavailable = self._mapData.bBuildUsed or self._mapData.bCharUsed
    end
    self._mapNode.objUnavailable:SetActive(bShowUnavailable)
    self._mapNode.imgUnavailable:SetActive(false)
    self._mapNode.imgBuildUsed:SetActive(self._mapData.bBuildUsed)
    self._mapNode.imgCharUsed:SetActive(self._mapData.bCharUsed and not self._mapData.bBuildUsed)
    local sKey = self._nType == AllEnum.RegionBossFormationType.InfinityTower and "InfinityTower_Build_NotAvailable" or "VampireFormation_Unable"
    NovaAPI.SetTMPText(self._mapNode.texUnavailable, ConfigTable.GetUIText(sKey))
  else
    self._mapNode.objUnavailable:SetActive(false)
  end
  if self._bLimitedTrialBuildLocked then
    self._mapNode.objUnavailable:SetActive(true)
    self._mapNode.imgUnavailable:SetActive(true)
    self._mapNode.imgBuildUsed:SetActive(false)
    self._mapNode.imgCharUsed:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.texUnavailable, ConfigTable.GetUIText("LimitedTrialBuild_UnableTip"))
  end
end

function StarTowerBuildBriefItem:RefreshInfo()
  local sScore = "Icon/BuildRank/BuildRank_" .. self._mapData.mapRank.Id
  local sFrame = AllEnum.FrameType_New.BuildRankDB .. AllEnum.FrameColor_New[self._mapData.mapRank.Rarity]
  self:SetPngSprite(self._mapNode.imgRareScore, sScore)
  self:SetAtlasSprite(self._mapNode.imgRareFrame, "12_rare", sFrame)
  local nBuildRank = self._mapData.mapRank.Id
  local nMaskIndex = 1
  if 31 <= nBuildRank then
    nMaskIndex = 5
  elseif 21 <= nBuildRank then
    nMaskIndex = 4
  elseif 11 <= nBuildRank then
    nMaskIndex = 3
  elseif 6 <= nBuildRank then
    nMaskIndex = 2
  end
  self:SetAtlasSprite(self._mapNode.imgUnavailableMask, "08_db", "db_common_bd_mask_0" .. nMaskIndex)
  if self._mapData.sName == "" or self._mapData.sName == nil then
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, ConfigTable.GetUIText("RoguelikeBuild_EmptyBuildName"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, self._mapData.sName)
  end
  self._mapNode.imgLike:SetActive(self._mapData.bPreference)
  self._mapNode.btn_LockIcon.interactable = self._mapData.bLock
end

function StarTowerBuildBriefItem:RefreshChar()
  for i = 1, 3 do
    local nCharTid = self._mapData.tbChar[i].nTid
    local nCharSkinId = PlayerData.Char:GetCharSkinId(nCharTid)
    local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
    local mapCharCfg = ConfigTable.GetData_Character(nCharTid)
    local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
    self:SetPngSprite(self._mapNode.imgCharIcon[i], mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
    self:SetAtlasSprite(self._mapNode.imgCharFrame[i], "12_rare", sFrame)
    NovaAPI.SetTMPText(self._mapNode.txtPotentialCount[i], self._mapData.tbChar[i].nPotentialCount)
    self:SetAtlasSprite(self._mapNode.imgCharElement[i], "12_rare", AllEnum.Char_Element[mapCharCfg.EET].icon)
  end
end

function StarTowerBuildBriefItem:RefreshDisc()
  local tbDisc = self._mapData.tbDisc
  local nIndex = 1
  for _, nId in ipairs(tbDisc) do
    if nil ~= self._mapNode.goDiscItem[nIndex] and nIndex <= 3 then
      self._mapNode.goDiscItem[nIndex]:Init(nId)
    end
    nIndex = nIndex + 1
  end
end

function StarTowerBuildBriefItem:Init(parentCtrl)
  self._parentCtrl = parentCtrl
end

function StarTowerBuildBriefItem:SetLockState(bLock)
  self._mapNode.btn_LockIcon.interactable = bLock
end

function StarTowerBuildBriefItem:SetPreferenceState(bPreference)
  self._mapNode.imgLike:SetActive(bPreference)
end

function StarTowerBuildBriefItem:SetSelectDeleteState(bSelect)
  self._mapNode.img_SelectDelete:SetActive(bSelect)
end

function StarTowerBuildBriefItem:SetSelectPreferenceState(bSelect)
  self._mapNode.img_SelectPreference:SetActive(bSelect)
end

function StarTowerBuildBriefItem:Awake()
end

function StarTowerBuildBriefItem:OnEnable()
end

function StarTowerBuildBriefItem:OnDisable()
end

function StarTowerBuildBriefItem:OnDestroy()
end

function StarTowerBuildBriefItem:OnRelease()
end

function StarTowerBuildBriefItem:OnBtnClick_Grid(btn)
  if self._bLimitedTrialBuildLocked then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("LimitedTrialBuild_UnableTip"))
    return
  end
  if self._nType then
    if self._nType == AllEnum.RegionBossFormationType.InfinityTower or self._nType == AllEnum.RegionBossFormationType.Vampire then
      if not self._mapData.isCanUse then
        local sKey = self._nType == AllEnum.RegionBossFormationType.InfinityTower and "InfinityTower_Build_NotMeetingCond" or "VampireFormation_UnableTips"
        local strTips = ConfigTable.GetUIText(sKey)
        EventManager.Hit(EventId.OpenMessageBox, strTips)
        return
      end
    elseif (self._nType == AllEnum.RegionBossFormationType.JointDrill or self._nType == AllEnum.RegionBossFormationType.JointDrill_2) and (self._mapData.bCharUsed or self._mapData.bBuildUsed) then
      local sKey = "JointDrill_Build_NotMeetingCond"
      local strTips = ConfigTable.GetUIText(sKey)
      EventManager.Hit(EventId.OpenMessageBox, strTips)
      return
    end
  end
  if self._nType and self._nType == AllEnum.RegionBossFormationType.InfinityTower or self._nType == AllEnum.RegionBossFormationType.Vampire then
  end
  local nIndex = tonumber(self.gameObject.name) + 1
  self._parentCtrl:OnBtnClickGrid(nIndex, self)
end

function StarTowerBuildBriefItem:OnBtnClick_Lock(btn)
  local nIndex = tonumber(self.gameObject.name) + 1
  self._parentCtrl:OnBuildGridLock(nIndex, self)
end

function StarTowerBuildBriefItem:OnBtnClick_Detail(btn)
  local nIndex = tonumber(self.gameObject.name) + 1
  self._parentCtrl:OnBuildGridDetail(nIndex, self)
end

function StarTowerBuildBriefItem:OnBtnClick_Preference(btn)
  local nIndex = tonumber(self.gameObject.name) + 1
  self._parentCtrl:OnBuildGridPreference(nIndex, self)
end

return StarTowerBuildBriefItem
