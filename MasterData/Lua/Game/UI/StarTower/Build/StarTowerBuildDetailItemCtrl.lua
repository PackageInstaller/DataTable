local StarTowerBuildDetailItemCtrl = class("StarTowerBuildDetailItemCtrl", BaseCtrl)
StarTowerBuildDetailItemCtrl._mapNodeConfig = {
  imgRareFrame = {sComponentName = "Image"},
  imgRareScore = {sComponentName = "Image"},
  txtScoreCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Score"
  },
  txtScore = {sComponentName = "TMP_Text"},
  txtChar = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Char_Title"
  },
  btnLeader = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Leader"
  },
  btnSub = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Sub"
  },
  imgCharIcon = {nCount = 3, sComponentName = "Image"},
  imgCharFrame = {nCount = 3, sComponentName = "Image"},
  txtPotentialCount = {nCount = 3, sComponentName = "TMP_Text"},
  txtBuildName = {sComponentName = "TMP_Text"},
  txtDisc = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_MainDisc_Title"
  },
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Sub"
  },
  imgCharElement = {nCount = 3, sComponentName = "Image"},
  btnDiscItem = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Disc"
  },
  goDiscItem = {
    nCount = 3,
    sCtrlName = "Game.UI.StarTower.Build.BuildSimpleDiscItem"
  },
  btnDiscDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DiscDetail"
  },
  btnAttr = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Attr"
  },
  txtAttr = {sComponentName = "TMP_Text"}
}
StarTowerBuildDetailItemCtrl._mapEventConfig = {}
StarTowerBuildDetailItemCtrl._mapRedDotConfig = {}

function StarTowerBuildDetailItemCtrl:Refresh(mapData)
  self.mapBuild = mapData
  local nBuildSource = PlayerData.Build:GetBuildSourceByData(mapData)
  self.bTrialBuild = nBuildSource == AllEnum.BuildSource.Trial or nBuildSource == AllEnum.BuildSource.LimitedTrial or mapData.bTrial == true
  local bInteractable = self.mapBuild.bTrial ~= true
  self._mapNode.btnLeader.interactable = not self.bTrialBuild
  for _, btnSub in pairs(self._mapNode.btnSub) do
    btnSub.interactable = not self.bTrialBuild
  end
  for _, btnDiscItem in pairs(self._mapNode.btnDiscItem) do
    btnDiscItem.interactable = bInteractable
  end
  self:RefreshInfo()
  self:RefreshChar()
  self:RefreshDisc()
end

function StarTowerBuildDetailItemCtrl:RefreshInfo()
  local sScore = "Icon/BuildRank/BuildRank_" .. self.mapBuild.mapRank.Id
  local sFrame = AllEnum.FrameType_New.BuildRankDB .. AllEnum.FrameColor_New[self.mapBuild.mapRank.Rarity]
  self:SetPngSprite(self._mapNode.imgRareScore, sScore)
  self:SetAtlasSprite(self._mapNode.imgRareFrame, "12_rare", sFrame)
  NovaAPI.SetTMPText(self._mapNode.txtScore, self.mapBuild.nScore)
  if self.mapBuild.sName == "" or self.mapBuild.sName == nil then
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, ConfigTable.GetUIText("RoguelikeBuild_EmptyBuildName"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, self.mapBuild.sName)
  end
  NovaAPI.SetTMPText(self._mapNode.txtAttr, UTILS.ParseParamDesc(ConfigTable.GetUIText(self.mapBuild.mapRank.Desc), self.mapBuild.mapRank))
end

function StarTowerBuildDetailItemCtrl:RefreshChar()
  for i = 1, 3 do
    local nCharTid = self.mapBuild.tbChar[i].nTid
    local mapCharCfg = ConfigTable.GetData_Character(nCharTid)
    if mapCharCfg ~= nil then
      local nCharSkinId = PlayerData.Char:GetCharSkinId(nCharTid)
      if self.mapBuild.bRankPreview then
        nCharSkinId = mapCharCfg.DefaultSkinId
      end
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
      local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
      self:SetPngSprite(self._mapNode.imgCharIcon[i], mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
      self:SetAtlasSprite(self._mapNode.imgCharFrame[i], "12_rare", sFrame, true)
      NovaAPI.SetTMPText(self._mapNode.txtPotentialCount[i], self.mapBuild.tbChar[i].nPotentialCount)
      self:SetAtlasSprite(self._mapNode.imgCharElement[i], "12_rare", AllEnum.Char_Element[mapCharCfg.EET].icon)
    end
  end
end

function StarTowerBuildDetailItemCtrl:RefreshDisc()
  local nIndex = 1
  for _, nId in ipairs(self.mapBuild.tbDisc) do
    if nil ~= self._mapNode.goDiscItem[nIndex] and nIndex <= 3 then
      self._mapNode.goDiscItem[nIndex]:Init(nId)
    end
    nIndex = nIndex + 1
  end
  self._mapNode.btnDiscDetail.gameObject:SetActive(self.mapBuild.bTrial ~= true and not self.mapBuild.bRankPreview)
end

function StarTowerBuildDetailItemCtrl:SetName(sName)
  NovaAPI.SetTMPText(self._mapNode.txtBuildName, sName)
end

function StarTowerBuildDetailItemCtrl:Awake()
end

function StarTowerBuildDetailItemCtrl:FadeIn()
end

function StarTowerBuildDetailItemCtrl:FadeOut()
end

function StarTowerBuildDetailItemCtrl:OnEnable()
end

function StarTowerBuildDetailItemCtrl:OnDisable()
end

function StarTowerBuildDetailItemCtrl:OnDestroy()
end

function StarTowerBuildDetailItemCtrl:OnRelease()
end

function StarTowerBuildDetailItemCtrl:OnBtnClick_Attr()
  EventManager.Hit(EventId.OpenPanel, PanelId.BuildAttrPreview, self.mapBuild.mapRank.Id, self.mapBuild.nScore)
end

function StarTowerBuildDetailItemCtrl:OnBtnClick_Disc(btn, nIndex)
  local nDiscId = self.mapBuild.tbDisc[nIndex]
  if nDiscId == nil or nDiscId == 0 then
    return
  end
  if self.mapBuild.bRankPreview == true then
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, nDiscId)
  elseif self.bTrialBuild then
    self:OnBtnClick_DiscDetail(btn, nIndex)
  elseif PlayerData.Disc:GetDiscById(nDiscId) ~= nil then
    EventManager.Hit(EventId.OpenPanel, PanelId.Disc, nDiscId, self.mapBuild.tbDisc)
  end
end

function StarTowerBuildDetailItemCtrl:OpenCharDetail(nIndex)
  if self.bTrialBuild then
    return
  end
  local nCharTid = self.mapBuild.tbChar[nIndex].nTid
  if self.mapBuild.bRankPreview == true then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, nCharTid)
  else
    local tbCharId = {}
    for _, mapChar in ipairs(self.mapBuild.tbChar) do
      table.insert(tbCharId, mapChar.nTid)
    end
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharInfo, nCharTid, tbCharId, true)
  end
end

function StarTowerBuildDetailItemCtrl:OnBtnClick_Leader()
  self:OpenCharDetail(1)
end

function StarTowerBuildDetailItemCtrl:OnBtnClick_Sub(btn, nIndex)
  self:OpenCharDetail(nIndex + 1)
end

function StarTowerBuildDetailItemCtrl:OnBtnClick_DiscDetail(btn, nIndex)
  local tbDisc = {}
  local mapDiscData = {}
  for nDiscIndex = 1, 6 do
    local nDiscId = self.mapBuild.tbDisc[nDiscIndex] or 0
    tbDisc[nDiscIndex] = nDiscId
    if nDiscId ~= 0 then
      local mapDisc = PlayerData.Build:GetBuildDiscByData(self.mapBuild, nDiscId)
      if mapDisc == nil then
        printError("Build disc data missing: " .. tostring(self.mapBuild.nBuildId) .. ", " .. nDiscId)
        return
      end
      mapDiscData[nDiscId] = mapDisc
    end
  end
  local nSelectedDiscId = nIndex and tbDisc[nIndex] or nil
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSkill, tbDisc, self.mapBuild.tbNotes, mapDiscData, nSelectedDiscId)
end

return StarTowerBuildDetailItemCtrl
