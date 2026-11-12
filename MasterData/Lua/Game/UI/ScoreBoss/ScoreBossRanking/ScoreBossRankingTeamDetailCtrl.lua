local ScoreBossRankingTeamDetailCtrl = class("ScoreBossRankingTeamDetailCtrl", BaseCtrl)
ScoreBossRankingTeamDetailCtrl._mapNodeConfig = {
  AnimRootTeamDetail = {sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnScreenClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtTeam = {nCount = 2, sComponentName = "TMP_Text"},
  tcChar1_ = {nCount = 3},
  imgItemIcon1_ = {nCount = 3, sComponentName = "Image"},
  imgItemRare1_ = {nCount = 3, sComponentName = "Image"},
  txtRank1_ = {nCount = 3, sComponentName = "TMP_Text"},
  imgScoreIcon_1 = {sComponentName = "Image"},
  tcChar2_ = {nCount = 3},
  imgItemIcon2_ = {nCount = 3, sComponentName = "Image"},
  imgItemRare2_ = {nCount = 3, sComponentName = "Image"},
  txtRank2_ = {nCount = 3, sComponentName = "TMP_Text"},
  imgScoreIcon_2 = {sComponentName = "Image"},
  txtLeaderCn_ = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSubCn1_ = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  txtSubCn2_ = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  TMPBuildTitle_ = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Template_Score"
  },
  txtScore = {nCount = 2, sComponentName = "TMP_Text"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBossRankingDetail"
  },
  txtHighScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBossRankingHighScore"
  },
  txtHighScoreNum = {sComponentName = "TMP_Text"},
  imgTeamBG = {nCount = 2},
  btnPotentialDetail = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_PotentialDetail"
  }
}

function ScoreBossRankingTeamDetailCtrl:OnEnable()
end

function ScoreBossRankingTeamDetailCtrl:Refresh(mapRanking)
  self._mapNode.AnimRootTeamDetail:Play("t_window_04_t_in")
  self._mapNode.txtScore[1].gameObject:SetActive(false)
  self._mapNode.imgScoreIcon_1.gameObject:SetActive(false)
  self._mapNode.txtScore[2].gameObject:SetActive(false)
  self._mapNode.imgScoreIcon_2.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtHighScoreNum, string.formatnumberthousands(mapRanking.Score))
  for k = 1, 3 do
    self._mapNode.tcChar1_[k]:SetActive(false)
  end
  local tbCurLevelGroups = ConfigTable.GetData("ScoreBossControl", PlayerData.ScoreBoss.ControlId)
  self.mapRankingSwitched = {
    mapRanking.Teams[1],
    mapRanking.Teams[2]
  }
  if tbCurLevelGroups ~= nil and next(tbCurLevelGroups) ~= nil then
    local nFirstLevelId = tbCurLevelGroups.LevelGroup[1]
    if mapRanking.Teams ~= nil and mapRanking.Teams[1] ~= nil and mapRanking.Teams[2] ~= nil and mapRanking.Teams[1].LevelId ~= nil and mapRanking.Teams[1].LevelId ~= nFirstLevelId then
      self.mapRankingSwitched = {
        mapRanking.Teams[2],
        mapRanking.Teams[1]
      }
    end
  end
  self.mapRanking = mapRanking
  if self.mapRankingSwitched[1] ~= nil then
    if self.mapRankingSwitched[1].LevelId ~= nil and self.mapRankingSwitched[1].LevelId > 0 then
      local bossLevelData = ConfigTable.GetData("ScoreBossLevel", self.mapRankingSwitched[1].LevelId)
      local mData = ConfigTable.GetData("Monster", bossLevelData.MonsterId)
      local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
      local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
      NovaAPI.SetTMPText(self._mapNode.txtTeam[1], mManual.Name)
    else
      NovaAPI.SetTMPText(self._mapNode.txtTeam[1], ConfigTable.GetUIText("ScoreBossRankingTeamOne"))
    end
    self._mapNode.imgTeamBG[1]:SetActive(true)
    local rank = PlayerData.Build:CalBuildRank(self.mapRankingSwitched[1].BuildScore)
    local sScore = "Icon/BuildRank/BuildRank_" .. rank.Id
    self:SetPngSprite(self._mapNode.imgScoreIcon_1, sScore)
    local txtLevelScore = string.formatnumberthousands(self.mapRankingSwitched[1].LevelScore)
    local txtLevelScoreTitle = ConfigTable.GetUIText("Vampire_Score_Title")
    NovaAPI.SetTMPText(self._mapNode.txtScore[1], txtLevelScoreTitle .. ":" .. txtLevelScore)
    self._mapNode.txtScore[1].gameObject:SetActive(true)
    self._mapNode.imgScoreIcon_1.gameObject:SetActive(true)
    if self.mapRankingSwitched[1].Chars ~= nil then
      for k = 1, 3 do
        if self.mapRankingSwitched[1].Chars[k] ~= nil then
          self._mapNode.tcChar1_[k]:SetActive(true)
          local nCharId = self.mapRankingSwitched[1].Chars[k].Id
          local mapChar = ConfigTable.GetData_Character(nCharId)
          NovaAPI.SetTMPText(self._mapNode.txtRank1_[k], self.mapRankingSwitched[1].Chars[k].Level)
          local nCharSkinId = mapChar.DefaultSkinId
          local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
          self:SetPngSprite(self._mapNode.imgItemIcon1_[k], mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
          local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapChar.Grade]
          self:SetAtlasSprite(self._mapNode.imgItemRare1_[k], "12_rare", sFrame, true)
        end
      end
    end
  else
    self._mapNode.imgTeamBG[1]:SetActive(false)
  end
  for k = 1, 3 do
    self._mapNode.tcChar2_[k]:SetActive(false)
  end
  if self.mapRankingSwitched[2] ~= nil then
    if self.mapRankingSwitched[2].LevelId ~= nil and self.mapRankingSwitched[2].LevelId > 0 then
      local bossLevelData = ConfigTable.GetData("ScoreBossLevel", self.mapRankingSwitched[2].LevelId)
      local mData = ConfigTable.GetData("Monster", bossLevelData.MonsterId)
      local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
      local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
      NovaAPI.SetTMPText(self._mapNode.txtTeam[2], mManual.Name)
    else
      NovaAPI.SetTMPText(self._mapNode.txtTeam[2], ConfigTable.GetUIText("ScoreBossRankingTeamTwo"))
    end
    self._mapNode.imgTeamBG[2]:SetActive(true)
    local rank = PlayerData.Build:CalBuildRank(self.mapRankingSwitched[2].BuildScore)
    local sScore = "Icon/BuildRank/BuildRank_" .. rank.Id
    self:SetPngSprite(self._mapNode.imgScoreIcon_2, sScore)
    local txtLevelScore = string.formatnumberthousands(self.mapRankingSwitched[2].LevelScore)
    local txtLevelScoreTitle = ConfigTable.GetUIText("Vampire_Score_Title")
    NovaAPI.SetTMPText(self._mapNode.txtScore[2], txtLevelScoreTitle .. ":" .. txtLevelScore)
    self._mapNode.txtScore[2].gameObject:SetActive(true)
    self._mapNode.imgScoreIcon_2.gameObject:SetActive(true)
    if self.mapRankingSwitched[2].Chars ~= nil then
      for k = 1, 3 do
        if self.mapRankingSwitched[2].Chars[k] ~= nil then
          self._mapNode.tcChar2_[k]:SetActive(true)
          local nCharId = self.mapRankingSwitched[2].Chars[k].Id
          local mapChar = ConfigTable.GetData_Character(nCharId)
          NovaAPI.SetTMPText(self._mapNode.txtRank2_[k], self.mapRankingSwitched[2].Chars[k].Level)
          local nCharSkinId = mapChar.DefaultSkinId
          local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
          self:SetPngSprite(self._mapNode.imgItemIcon2_[k], mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
          local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapChar.Grade]
          self:SetAtlasSprite(self._mapNode.imgItemRare2_[k], "12_rare", sFrame, true)
        end
      end
    end
  else
    self._mapNode.imgTeamBG[2]:SetActive(false)
  end
end

function ScoreBossRankingTeamDetailCtrl:OnBtnClick_Close()
  self._mapNode.AnimRootTeamDetail:Play("t_window_04_t_out")
  
  local function close()
    self.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 0.2, close, true, true, true)
end

function ScoreBossRankingTeamDetailCtrl:OnBtnClick_PotentialDetail(btn, nIndex)
  if self.mapRankingSwitched ~= nil then
    local mapRanking = self.mapRankingSwitched[nIndex]
    if mapRanking.Discs == nil or #mapRanking.Discs == 0 then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Rank_Build_Detail_Unavailable"))
      return
    end
    self.gameObject:SetActive(false)
    EventManager.Hit("OpenRankBuildDetail")
    EventManager.Hit(EventId.OpenPanel, PanelId.RankBuildDetail, mapRanking)
  end
end

return ScoreBossRankingTeamDetailCtrl
