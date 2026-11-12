local BuildBriefItem = class("BuildBriefItem", BaseCtrl)
local PanelState = {
  Normal = 1,
  Delete = 2,
  Preference = 3
}
BuildBriefItem._mapNodeConfig = {
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
    sLanguageId = "Build_Leader"
  },
  txtSubCn = {sComponentName = "TMP_Text", sLanguageId = "Build_Sub"},
  imgCharIcon = {nCount = 3, sComponentName = "Image"},
  imgCharFrame = {nCount = 3, sComponentName = "Image"},
  txtCharCount = {nCount = 3, sComponentName = "TMP_Text"},
  imgTheme = {nCount = 4, sComponentName = "Image"},
  imgMask = {nCount = 4, sComponentName = "Image"},
  txtThemeCount = {nCount = 4, sComponentName = "TMP_Text"},
  imgEnhance = {nCount = 4},
  btnExport = {sComponentName = "UIButton"}
}
BuildBriefItem._mapEventConfig = {}

function BuildBriefItem:RefreshGrid(mapData, nPanelState, bSelectDelete, bCheckOut, bCheckIn)
  self._mapData = mapData
  self:RefreshInfo()
  self:RefreshChar()
  self:RefreshPerk()
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
end

function BuildBriefItem:RefreshInfo()
  local sScore = AllEnum.FrameType_New.BuildRank .. self._mapData.mapRank.Id
  self:SetAtlasSprite(self._mapNode.imgRareScore, "12_rare", sScore)
  if self._mapData.sName == "" or self._mapData.sName == nil then
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, ConfigTable.GetUIText("RoguelikeBuild_EmptyBuildName"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, self._mapData.sName)
  end
  self._mapNode.imgLike:SetActive(self._mapData.bPreference)
  self._mapNode.btn_LockIcon.interactable = self._mapData.bLock
end

function BuildBriefItem:RefreshChar()
  for i = 1, 3 do
    local nCharTid = self._mapData.tbChar[i].nTid
    local nCharSkinId = PlayerData.Char:GetCharSkinId(nCharTid)
    local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
    local mapCharCfg = ConfigTable.GetData_Character(nCharTid)
    local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
    self:SetPngSprite(self._mapNode.imgCharIcon[i], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
    self:SetAtlasSprite(self._mapNode.imgCharFrame[i], "12_rare", sFrame)
  end
end

function BuildBriefItem:RefreshPerk()
  for i = 1, 3 do
    NovaAPI.SetTMPText(self._mapNode.txtCharCount[i], self._mapData.tbChar[i].nExclusiveCount)
  end
  table.sort(self._mapData.tbTheme, function(a, b)
    if a.Count ~= b.Count then
      return a.Count > b.Count
    elseif a.Strengthen ~= b.Strengthen then
      return a.Strengthen and not b.Strengthen
    else
      return a.Theme < b.Theme
    end
  end)
  for i = 1, 4 do
    local nTheme = self._mapData.tbTheme[i].Theme
    local mapTheme = ConfigTable.GetData("PresentsTheme", nTheme)
    if self._mapData.tbTheme[i].Count > 0 then
      NovaAPI.SetTMPText(self._mapNode.txtThemeCount[i], self._mapData.tbTheme[i].Count)
      self._mapNode.imgMask[i].gameObject:SetActive(false)
    else
      NovaAPI.SetTMPText(self._mapNode.txtThemeCount[i], 0)
      self:SetPngSprite(self._mapNode.imgMask[i], mapTheme.ThemeItemIcon)
      self._mapNode.imgMask[i].gameObject:SetActive(true)
    end
    self:SetPngSprite(self._mapNode.imgTheme[i], mapTheme.ThemeItemIcon)
    self._mapNode.imgEnhance[i]:SetActive(self._mapData.tbTheme[i].Strengthen)
  end
end

function BuildBriefItem:Init(parentCtrl)
  self._parentCtrl = parentCtrl
end

function BuildBriefItem:SetLockState(bLock)
  self._mapNode.btn_LockIcon.interactable = bLock
end

function BuildBriefItem:SetPreferenceState(bPreference)
  self._mapNode.imgLike:SetActive(bPreference)
end

function BuildBriefItem:SetSelectDeleteState(bSelect)
  self._mapNode.img_SelectDelete:SetActive(bSelect)
end

function BuildBriefItem:SetSelectPreferenceState(bSelect)
  self._mapNode.img_SelectPreference:SetActive(bSelect)
end

function BuildBriefItem:Awake()
end

function BuildBriefItem:OnEnable()
end

function BuildBriefItem:OnDisable()
end

function BuildBriefItem:OnDestroy()
end

function BuildBriefItem:OnRelease()
end

function BuildBriefItem:OnBtnClick_Grid(btn)
  local nIndex = tonumber(self.gameObject.name) + 1
  self._parentCtrl:OnBtnClickGrid(nIndex, self)
end

function BuildBriefItem:OnBtnClick_Lock(btn)
  local nIndex = tonumber(self.gameObject.name) + 1
  self._parentCtrl:OnBuildGridLock(nIndex, self)
end

function BuildBriefItem:OnBtnClick_Preference(btn)
  local nIndex = tonumber(self.gameObject.name) + 1
  self._parentCtrl:OnBuildGridPreference(nIndex, self)
end

return BuildBriefItem
