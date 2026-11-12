local JointDrillRankItemCtrl = class("JointDrillRankItemCtrl", BaseCtrl)
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
JointDrillRankItemCtrl._mapNodeConfig = {
  btnTeamDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TeamDetail"
  },
  imgBtnMask = {},
  imgHead = {sComponentName = "Image"},
  txtPlayerName = {sComponentName = "TMP_Text"},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Player_Title"
  },
  txtPlayerTitle = {sComponentName = "TMP_Text"},
  goHonorTitle = {
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  goNormal = {},
  imgScoreBg = {},
  txtScore = {sComponentName = "TMP_Text"},
  imgRankWheat = {},
  imgRankIcon = {nCount = 3},
  imgRankValue = {},
  txtRankValue = {sComponentName = "TMP_Text"},
  goBuild = {},
  txtBuildScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Build_Score"
  },
  imgBuildScore = {sComponentName = "Image"},
  goCharItem = {nCount = 3},
  imgItemIcon = {nCount = 3, sComponentName = "Image"},
  imgItemRare = {nCount = 3, sComponentName = "Image"},
  txtRank = {nCount = 3, sComponentName = "TMP_Text"},
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  goEmpty = {},
  imgScoreBgEmpty = {},
  txtScoreEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Empty"
  },
  imgRankEmpty = {},
  txtRankEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Self_Rank_Empty"
  },
  imgBuildEmptyBg = {},
  txtBuildEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Empty"
  }
}
JointDrillRankItemCtrl._mapEventConfig = {}
JointDrillRankItemCtrl._mapRedDotConfig = {}

function JointDrillRankItemCtrl:RefreshRankItem(mapRankData)
  self.mapRankData = mapRankData
  self._mapNode.goNormal.gameObject:SetActive(true)
  self._mapNode.goEmpty.gameObject:SetActive(false)
  self._mapNode.imgBtnMask.gameObject:SetActive(false)
  self:RefreshBuild(mapRankData.Teams)
  NovaAPI.SetTMPText(self._mapNode.txtScore, mapRankData.Score)
  NovaAPI.SetTMPText(self._mapNode.txtPlayerName, mapRankData.NickName)
  local mapCfg = ConfigTable.GetData("PlayerHead", mapRankData.HeadIcon)
  if mapCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
  end
  self:RefreshHonorTitle(mapRankData.Honors)
  if mapRankData.TitlePrefix == 0 or mapRankData.TitleSuffix == 0 then
    NovaAPI.SetTMPText(self._mapNode.txtPlayerTitle, "")
  else
    local mapCfgTitle1 = ConfigTable.GetData("Title", mapRankData.TitlePrefix)
    local mapCfgTitle2 = ConfigTable.GetData("Title", mapRankData.TitleSuffix)
    if mapCfgTitle1 ~= nil and mapCfgTitle2 ~= nil then
      local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", mapCfgTitle1.Desc, mapCfgTitle2.Desc)
      NovaAPI.SetTMPText(self._mapNode.txtPlayerTitle, sTitle)
    end
  end
  if mapRankData.Rank <= 3 then
    self._mapNode.imgRankWheat.gameObject:SetActive(true)
    self._mapNode.imgRankValue.gameObject:SetActive(false)
    for k, v in ipairs(self._mapNode.imgRankIcon) do
      v.gameObject:SetActive(k == mapRankData.Rank)
    end
  else
    self._mapNode.imgRankWheat.gameObject:SetActive(false)
    self._mapNode.imgRankValue.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtRankValue, mapRankData.Rank)
  end
end

function JointDrillRankItemCtrl:RefreshHonorTitle(tbHonors)
  for i = 1, 3 do
    self._mapNode.goHonorTitle[i].gameObject:SetActive(false)
  end
  for k, v in pairs(tbHonors) do
    if v ~= nil and v.Id > 0 then
      local honorData = ConfigTable.GetData("Honor", v.Id)
      self._mapNode.goHonorTitle[k].gameObject:SetActive(honorData ~= nil)
      if honorData ~= nil then
        self._mapNode.goHonorTitle[k]:SetHonotTitle(honorData.Id, k == 1, v.AffinityLV)
      end
    end
  end
end

function JointDrillRankItemCtrl:GetBuildRank(nScore)
  local curIdx = -1
  
  local function forEachReward(mapData)
    if nScore >= mapData.MinGrade and curIdx < mapData.Id then
      curIdx = mapData.Id
    end
  end
  
  ForEachTableLine(DataTable.StarTowerBuildRank, forEachReward)
  if curIdx < 0 then
    curIdx = 1
  end
  return curIdx
end

function JointDrillRankItemCtrl:RefreshBuild(mapBuildList)
  if mapBuildList == nil or next(mapBuildList) == nil then
    return
  end
  local mapBuild = mapBuildList[1]
  for i = 1, 3 do
    local nCharId = mapBuild.Chars[i].Id
    local mapChar = ConfigTable.GetData_Character(nCharId)
    if mapChar ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtRank[i], mapBuild.Chars[i].Level)
      local nCharSkinId = mapChar.DefaultSkinId
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
      if mapCharSkin ~= nil then
        self:SetPngSprite(self._mapNode.imgItemIcon[i], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
      end
      local nRarity = mapChar.Grade
      local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[nRarity]
      self:SetAtlasSprite(self._mapNode.imgItemRare[i], "12_rare", sFrame, true)
    end
  end
  local nScore = self:GetBuildRank(mapBuild.BuildScore)
  self:SetPngSprite(self._mapNode.imgBuildScore, "Icon/BuildRank/BuildRank_" .. nScore)
end

function JointDrillRankItemCtrl:RefreshSelfRank(mapSelfRank)
  if mapSelfRank ~= nil and mapSelfRank.Rank > 0 then
    self:RefreshRankItem(mapSelfRank)
  else
    self._mapNode.goNormal.gameObject:SetActive(false)
    self._mapNode.goEmpty.gameObject:SetActive(true)
    self._mapNode.imgBtnMask.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtPlayerName, PlayerData.Base:GetPlayerNickName())
    local nHeadId = PlayerData.Base:GetPlayerHeadId()
    local mapCfg = ConfigTable.GetData("PlayerHead", nHeadId)
    if mapCfg ~= nil then
      self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
    end
    local tbCurHonorTitle = PlayerData.Base:GetPlayerHonorTitle()
    self:RefreshHonorTitle(tbCurHonorTitle)
    local nTitlePrefix, nTitleSuffix = PlayerData.Base:GetPlayerTitle()
    if nTitlePrefix == 0 or nTitleSuffix == 0 then
      NovaAPI.SetTMPText(self._mapNode.txtPlayerTitle, "")
    else
      local mapCfgTitle1 = ConfigTable.GetData("Title", nTitlePrefix)
      local mapCfgTitle2 = ConfigTable.GetData("Title", nTitleSuffix)
      if mapCfgTitle1 ~= nil and mapCfgTitle2 ~= nil then
        local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", mapCfgTitle1.Desc, mapCfgTitle2.Desc)
        NovaAPI.SetTMPText(self._mapNode.txtPlayerTitle, sTitle)
      end
    end
  end
end

function JointDrillRankItemCtrl:Awake()
end

function JointDrillRankItemCtrl:OnEnable()
end

function JointDrillRankItemCtrl:OnDisable()
end

function JointDrillRankItemCtrl:OnDestroy()
end

function JointDrillRankItemCtrl:OnBtnClick_TeamDetail()
  if self.mapRankData == nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Rank_Detail_Empty"))
    return
  end
  EventManager.Hit("ShowTeamDetail", self.mapRankData)
  EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(PlayerData.JointDrill_2.nActId, "RankDetail"), self.mapRankData)
end

return JointDrillRankItemCtrl
