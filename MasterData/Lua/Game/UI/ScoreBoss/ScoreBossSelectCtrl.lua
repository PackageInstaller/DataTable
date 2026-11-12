local ScoreBossSelectCtrl = class("ScoreBossSelectCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local totalNodeLength = 800
local totalHeight = 20
local totalProLength = 948
local totalProHeight = 22
local bgPath = "Image/UIBG/bg_bossrush"
local NpcId = 9159
ScoreBossSelectCtrl._mapNodeConfig = {
  btnActor = {
    sComponentName = "Button",
    callback = "OnBtnClick_Actor"
  },
  goBubbleRoot = {
    sNodeName = "----fixed_bubble----"
  },
  bgImageCover = {},
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  objBg = {sNodeName = "----Bg----"},
  bgImage = {sNodeName = "----Bg----", sComponentName = "Image"},
  InfoBgObj = {
    sNodeName = "----InfoBg----"
  },
  InfoBg = {sComponentName = "Image"},
  SCBossList = {},
  gridTemp = {},
  ContentTemp = {sComponentName = "Transform"},
  goRefresh = {},
  texRefreshCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Remain_Time"
  },
  texRefreshTime = {sComponentName = "TMP_Text"},
  goSettlement = {},
  txtSettlement = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Settlement"
  },
  btnRank = {
    sComponentName = "UIButton",
    callback = "OnClickRank"
  },
  texBtnRank = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Rank_Title"
  },
  btnStar = {
    sComponentName = "UIButton",
    callback = "OnClickStar"
  },
  redStar = {},
  txtBtnReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Reward"
  },
  SCBossInfo = {},
  card = {},
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnClickBtnGo"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Maninline_Btn_Go"
  },
  btnGoSettlement = {
    sComponentName = "UIButton",
    callback = "OnClickBtnSettlement"
  },
  txtBtnSettlement = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Settlement_Btn"
  },
  info_ImgBoss = {sComponentName = "Image"},
  info_ImgBoss_extra = {sComponentName = "Image"},
  imgLevelInfo = {sComponentName = "Image"},
  info_BossName = {sComponentName = "TMP_Text"},
  rtElements = {sComponentName = "Transform"},
  info_rtAntiElements = {sComponentName = "Transform"},
  rtAntiElements = {sComponentName = "Transform"},
  info_texCurRecord = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Cur_Record"
  },
  info_texScore = {sComponentName = "TMP_Text"},
  infoRecordProgress = {
    sComponentName = "RectTransform"
  },
  FullPower = {},
  btnNodeItem = {nCount = 7, sComponentName = "Button"},
  schedule = {nCount = 7},
  notSchedule = {nCount = 7},
  txtRecordScore = {nCount = 7, sComponentName = "TMP_Text"},
  skillInfoIcon1 = {sComponentName = "Image"},
  skillInfoName1 = {sComponentName = "TMP_Text"},
  skillInfoDes1 = {sComponentName = "TMP_Text"},
  info_texDamageScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_DamageScore"
  },
  info_texSkillScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_SkillScore"
  },
  info_texDamageScoreCount = {sComponentName = "TMP_Text"},
  info_texSkillScoreCount = {sComponentName = "TMP_Text"},
  skillInfoRect = {sComponentName = "ScrollRect"},
  skillInfoIcon2 = {sComponentName = "Image"},
  skillInfoName2 = {sComponentName = "TMP_Text"},
  skillInfoDes2 = {sComponentName = "TMP_Text"},
  texLockChar = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Lock_Char"
  },
  char = {nCount = 3},
  charTeam = {nCount = 3},
  charTeamEmpty = {nCount = 3},
  imgItemIcon_ = {nCount = 3, sComponentName = "Image"},
  imgItemRare_ = {nCount = 3, sComponentName = "Image"},
  txtLeader = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSub = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goRewardView = {},
  t_window_04 = {},
  animRewardWindow = {
    sNodeName = "t_window_04",
    sComponentName = "Animator"
  },
  txt_Reward_Title = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Reward_Title"
  },
  RewardSc = {
    sComponentName = "LoopScrollView"
  },
  btnCloseReward = {
    sComponentName = "NaviButton",
    callback = "CloseRewardView"
  },
  RewardMaskClose = {
    sComponentName = "NaviButton",
    callback = "CloseRewardView"
  },
  texRewardStarTotal = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Reward_TotalStar"
  },
  texOneKeyReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mail_OneKeyReceive"
  },
  texRewardStar = {sComponentName = "TMP_Text"},
  btnRewardOneKey = {
    sComponentName = "UIButton",
    callback = "OnClickRewardOneKey"
  },
  svRankingReward = {
    sComponentName = "LoopScrollView"
  },
  rtStarReward = {},
  rtRankingReward = {},
  btnRewardTabOn = {nCount = 2},
  btnRewardTabOff = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtn_RewardTab"
  },
  txtRewardTabLeft = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Star_Reward"
  },
  txtRewardTabRight = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Ranking_Reward"
  },
  txtRefreshTimeReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "STRanking_Refresh_Tips"
  }
}
ScoreBossSelectCtrl._mapEventConfig = {
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  Get_ScoreBoss_InfoReq = "OnEvent_GetScoreBossInfoReq",
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText"
}
ScoreBossSelectCtrl._mapRedDotConfig = {
  [RedDotDefine.Map_ScoreBossStar] = {sNodeName = "redStar"}
}

function ScoreBossSelectCtrl:Awake()
  self.infoAni = self.gameObject:GetComponent("Animator")
end

function ScoreBossSelectCtrl:OnEnable()
  if PlayerData.ScoreBoss:GetInitInfoState() then
    self:OnInitPanelInfo()
  end
  self.isPlayNPCVoice = false
  self:RefreshNPC2D()
  self._mapRewardGrid = {}
  if self.ChooseLevelId ~= nil then
    self:SetBossInfo(self.ChooseLevelId, false)
    self:PlayBossOpenAni(self.ChooseLevelId)
  end
end

function ScoreBossSelectCtrl:PlayBossOpenAni(nLevelId)
  local bossLevelData = ConfigTable.GetData("ScoreBossLevel", nLevelId)
  local sOpenAniName = "ScoreBossSelect_Info_open"
  if bossLevelData.ExtraImageAni ~= nil and bossLevelData.ExtraImageAni ~= "" then
    sOpenAniName = string.gsub(bossLevelData.ExtraImageAni, "_in", "_open", 1)
  end
  self.infoAni:Play(sOpenAniName)
end

function ScoreBossSelectCtrl:OnEvent_GetScoreBossInfoReq()
  self:OnInitPanelInfo()
end

function ScoreBossSelectCtrl:OnInitPanelInfo()
  local openLevelGroup = PlayerData.ScoreBoss.OpenLevelGroup
  self.tabGridAni = {}
  for i = 1, #openLevelGroup do
    local objItem
    if i > self._mapNode.ContentTemp.childCount then
      objItem = instantiate(self._mapNode.gridTemp, self._mapNode.ContentTemp)
    else
      objItem = self._mapNode.ContentTemp:GetChild(i - 1).gameObject
    end
    objItem:SetActive(true)
    self:OnRefreshGrid(objItem, openLevelGroup[i], i)
  end
  self:SetTimes()
  if self.pageType == nil or self.pageType == 1 then
    self._mapNode.SCBossList:SetActive(true)
    self._mapNode.SCBossInfo:SetActive(false)
    self:SetBgActive(1)
  else
    self._mapNode.SCBossList:SetActive(false)
    self._mapNode.SCBossInfo:SetActive(true)
    self:SetBgActive(2)
    if self.ChooseLevelId then
      self:SetBossInfo(self.ChooseLevelId, false)
    end
  end
end

function ScoreBossSelectCtrl:FadeIn()
  if self.pageType == nil or self.pageType == 1 then
    EventManager.Hit(EventId.SetTransition)
  end
end

function ScoreBossSelectCtrl:SetTimes()
  self.nRemainTime = PlayerData.ScoreBoss.EndTime == 0 and 0 or PlayerData.ScoreBoss.EndTime - CS.ClientManager.Instance.serverTimeStamp
  if self.timerCountDown then
    self.timerCountDown = nil
  end
  if self.timerCountDown == nil then
    self.timerCountDown = self:AddTimer(0, 1, "RefreshTime", false, true, false)
  end
  if self.nRemainTime > 0 then
    self._mapNode.goRefresh:SetActive(true)
    self._mapNode.goSettlement:SetActive(false)
    self:RefreshTime()
    self.timerCountDown:Pause(false)
  else
    self._mapNode.goRefresh:SetActive(false)
    self.timerCountDown:Pause(true)
    self._mapNode.goSettlement:SetActive(true)
  end
end

function ScoreBossSelectCtrl:RefreshTime()
  self.nRemainTime = self.nRemainTime - 1
  if self.nRemainTime > 0 then
    local sTime = ""
    if self.nRemainTime < 60 then
      local sec = math.floor(self.nRemainTime)
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Sec"), sec)
    elseif self.nRemainTime >= 60 and self.nRemainTime < 3600 then
      local min = math.floor(self.nRemainTime / 60)
      local sec = self.nRemainTime % 60
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Min"), min, sec)
    elseif self.nRemainTime >= 3600 and self.nRemainTime < 86400 then
      local hour = math.floor(self.nRemainTime / 3600)
      local min = math.floor(self.nRemainTime % 3600 / 60)
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Hour"), hour, min)
    elseif self.nRemainTime >= 86400 then
      local day = math.floor(self.nRemainTime / 86400)
      local hour = math.floor(self.nRemainTime % 86400 / 3600)
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Day"), day, hour)
    end
    NovaAPI.SetTMPText(self._mapNode.texRefreshTime, sTime)
  else
    self.timerCountDown:Pause(true)
  end
end

function ScoreBossSelectCtrl:OnDisable()
  for go, mapCtrl in pairs(self._mapRewardGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapRewardGrid = {}
  Actor2DManager.UnsetBoardNPC2D()
  PlayerData.Voice:ClearTimer()
  BubbleVoiceManager.StopBubbleAnim()
end

function ScoreBossSelectCtrl:OnRefreshGrid(goGrid, levelId, index)
  local bossLevelData = ConfigTable.GetData("ScoreBossLevel", levelId)
  local trans = goGrid.transform:Find("AnimRoot")
  self.tabGridAni[index] = trans:GetComponent("Animator")
  local goUnlock = trans:Find("goUnlock")
  local imgLevel = goUnlock:Find("imgLevel"):GetComponent("Image")
  local imgLevel_add = goUnlock:Find("imgLevel/imgLevel_add"):GetComponent("Image")
  local TMPBossName = goUnlock:Find("TMPBossName"):GetComponent("TMP_Text")
  local rtElements1 = goUnlock:Find("goElements/rtElements1")
  local mData = ConfigTable.GetData("Monster", bossLevelData.MonsterId)
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  local Adjust = ConfigTable.GetData("MonsterValueTempleteAdjust", mData.Templete)
  NovaAPI.SetTMPText(TMPBossName, mManual.Name)
  self:SetPngSprite(imgLevel, bossLevelData.Episode)
  self:SetPngSprite(imgLevel_add, bossLevelData.Episode)
  for i = 1, rtElements1.childCount do
    local imgElement = rtElements1:GetChild(i - 1):GetComponent("Image")
    if Adjust.WeakEET[i] ~= nil then
      self:SetAtlasSprite(imgElement, "12_rare", AllEnum.ElementIconType.Icon .. Adjust.WeakEET[i])
    end
    imgElement.gameObject:SetActive(Adjust.WeakEET[i] ~= nil)
  end
  local levelData = PlayerData.ScoreBoss:GetLevelData(levelId)
  local _star = levelData.Star
  for i = 1, 7 do
    local tmpBtn = trans:Find("rt_Targets/star" .. i):GetComponent("Button")
    tmpBtn.interactable = i <= _star
  end
  self.tabGridAni[index]:Play("ScoreBossSelect_Card_in")
  local btnGrid = trans:Find("btnGrid"):GetComponent("UIButton")
  btnGrid.onClick:RemoveAllListeners()
  btnGrid.onClick:AddListener(function()
    WwiseAudioMgr:PlaySound("ui_bossRush_boss_select")
    self.ChooseLevelId = levelId
    self._mapNode.SCBossInfo:SetActive(true)
    self.pageType = 2
    self:SetBgActive(2)
    self:SetBossInfo(levelId, true)
    for i, v in pairs(self.tabGridAni) do
      if i ~= index then
        v:Play("ScoreBossSelect_Card_out")
      else
        trans.gameObject:SetActive(false)
      end
    end
    self:AddTimer(1, 1.667, function()
      trans.gameObject:SetActive(true)
    end, true, true, true)
  end)
end

function ScoreBossSelectCtrl:SetBossInfo(levelId, isPlayAin)
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.skillInfoRect, 1)
  local bossLevelData = ConfigTable.GetData("ScoreBossLevel", levelId)
  local getControlData = ConfigTable.GetData("ScoreBossGetControl", bossLevelData.NonDamageScoreGet)
  local mData = ConfigTable.GetData("Monster", bossLevelData.MonsterId)
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  local Adjust = ConfigTable.GetData("MonsterValueTempleteAdjust", mData.Templete)
  NovaAPI.SetTMPText(self._mapNode.info_BossName, mManual.Name)
  self:SetPngSprite(self._mapNode.info_ImgBoss, bossLevelData.Image)
  if bossLevelData.ExtraImage ~= nil and bossLevelData.ExtraImage ~= "" then
    self:SetPngSprite(self._mapNode.info_ImgBoss_extra, bossLevelData.ExtraImage)
    self._mapNode.info_ImgBoss_extra.gameObject:SetActive(true)
  else
    self._mapNode.info_ImgBoss_extra.gameObject:SetActive(false)
  end
  self:SetPngSprite(self._mapNode.imgLevelInfo, bossLevelData.Episode)
  self:SetPngSprite(self._mapNode.InfoBg, bossLevelData.BG)
  for i = 1, self._mapNode.rtElements.childCount do
    local imgElement = self._mapNode.rtElements:GetChild(i - 1):GetComponent("Image")
    if Adjust.WeakEET[i] ~= nil then
      self:SetAtlasSprite(imgElement, "12_rare", AllEnum.ElementIconType.Icon .. Adjust.WeakEET[i])
    end
    imgElement.gameObject:SetActive(Adjust.WeakEET[i] ~= nil)
  end
  local tbEET = Adjust.ResistEET
  if tbEET == nil or #tbEET == 0 then
    self._mapNode.info_rtAntiElements.gameObject:SetActive(false)
  else
    for i = 1, self._mapNode.rtAntiElements.childCount do
      local imgElement = self._mapNode.rtAntiElements:GetChild(i - 1):GetComponent("Image")
      if tbEET[i] ~= nil then
        self:SetAtlasSprite(imgElement, "12_rare", AllEnum.ElementIconType.Icon .. tbEET[i])
      end
      imgElement.gameObject:SetActive(tbEET[i] ~= nil)
    end
    self._mapNode.info_rtAntiElements.gameObject:SetActive(true)
  end
  local levelData = PlayerData.ScoreBoss:GetLevelData(levelId)
  local _Score = levelData.Score
  local _skillCount = levelData.SkillScore
  NovaAPI.SetTMPText(self._mapNode.info_texScore, _Score)
  NovaAPI.SetTMPText(self._mapNode.info_texDamageScoreCount, _Score - _skillCount)
  local OnceControlScore = getControlData.OnceScore
  local OnceControlScoreCount = math.floor(_skillCount / OnceControlScore)
  NovaAPI.SetTMPText(self._mapNode.info_texSkillScoreCount, string.format("%sx%s", OnceControlScore, OnceControlScoreCount))
  local tmpL = 0
  local tmpPre = 0
  local isThanMaxNeed = true
  local tmpLastScore = 0
  for i, v in pairs(PlayerData.ScoreBoss.tabScoreNeed) do
    if isThanMaxNeed then
      if _Score >= v then
        tmpLastScore = v
        tmpPre = tmpPre + 0.125
      else
        local tmpScore = _Score - tmpLastScore
        if 0 < v - tmpLastScore then
          tmpPre = tmpPre + tmpScore / (v - tmpLastScore) * 0.125
        end
        isThanMaxNeed = false
      end
    end
    self._mapNode.btnNodeItem[i].interactable = _Score >= v
    self._mapNode.schedule[i]:SetActive(_Score >= v)
    self._mapNode.notSchedule[i]:SetActive(_Score < v)
    local result = v / 1000
    if result == math.floor(result) then
      result = math.floor(result)
    else
      result = string.format("%.1f", result)
    end
    local tmpK = result .. "k"
    NovaAPI.SetTMPText(self._mapNode.txtRecordScore[i], tmpK)
  end
  if isThanMaxNeed then
    tmpPre = 1
  end
  tmpL = math.floor(tmpPre * totalNodeLength)
  self._mapNode.infoRecordProgress.sizeDelta = Vector2(tmpL, totalHeight)
  self._mapNode.FullPower:SetActive(isThanMaxNeed)
  local getControl = ConfigTable.GetData("ScoreBossGetControl", bossLevelData.NonDamageScoreGet)
  NovaAPI.SetTMPText(self._mapNode.skillInfoName1, getControl.Name)
  NovaAPI.SetTMPText(self._mapNode.skillInfoDes1, UTILS.ParseDesc(getControl))
  self:SetPngSprite(self._mapNode.skillInfoIcon1, getControl.IconSource)
  local bossAbility = ConfigTable.GetData("ScoreBossAbility", bossLevelData.ScoreBossAbility)
  NovaAPI.SetTMPText(self._mapNode.skillInfoName2, bossAbility.Name)
  NovaAPI.SetTMPText(self._mapNode.skillInfoDes2, UTILS.ParseDesc(bossAbility))
  self:SetPngSprite(self._mapNode.skillInfoIcon2, bossAbility.IconSource)
  local tmpCharId = levelData.CharId
  if tmpCharId[1] == 0 then
    for i = 1, 3 do
      self._mapNode.char[i]:SetActive(false)
      self._mapNode.charTeam[i]:SetActive(false)
      self._mapNode.charTeamEmpty[i]:SetActive(true)
    end
  else
    for i = 1, 3 do
      self._mapNode.char[i]:SetActive(true)
      self._mapNode.charTeam[i]:SetActive(true)
      self._mapNode.charTeamEmpty[i]:SetActive(false)
      local mapChar = ConfigTable.GetData_Character(tmpCharId[i])
      local mapCharData = PlayerData.Char:GetCharDataByTid(tmpCharId[i])
      local nCharSkinId = mapCharData.nSkinId
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
      self:SetPngSprite(self._mapNode.imgItemIcon_[i], mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
      local nRarity = mapChar.Grade
      local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapChar.Grade]
      self:SetAtlasSprite(self._mapNode.imgItemRare_[i], "12_rare", sFrame, true)
    end
  end
  if isPlayAin then
    if bossLevelData.ExtraImageAni ~= nil and bossLevelData.ExtraImageAni ~= "" then
      self.infoAni:Play(bossLevelData.ExtraImageAni)
    else
      self.infoAni:Play("ScoreBossSelect_Info_in")
    end
    EventManager.Hit(EventId.TemporaryBlockInput, 1.5)
    self:AddTimer(1, 1.667, function()
      self._mapNode.SCBossList:SetActive(false)
    end, true, true, true)
  end
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  if nCurTime > PlayerData.ScoreBoss.EndTime then
    self._mapNode.btnGo.gameObject:SetActive(false)
    self._mapNode.btnGoSettlement.gameObject:SetActive(true)
  else
    self._mapNode.btnGo.gameObject:SetActive(true)
    self._mapNode.btnGoSettlement.gameObject:SetActive(false)
  end
end

function ScoreBossSelectCtrl:OnClickRank()
  EventManager.Hit(EventId.OpenPanel, PanelId.ScoreBossRankingPanel)
end

function ScoreBossSelectCtrl:OnClickStar()
  self._mapNode.t_window_04:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.texRewardStar, orderedFormat("{0}/{1}", PlayerData.ScoreBoss.Star, PlayerData.ScoreBoss.maxStarNeed))
  self._mapNode.goRewardView:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.t_window_04:SetActive(true)
    self._mapNode.animRewardWindow:Play("t_window_04_t_in")
    if self._mapNode.RewardSc.gameObject.activeInHierarchy then
      self._mapNode.RewardSc:SetAnim(0.1)
    end
    PlayerData.ScoreBoss:SendScoreBossApplyReq(function()
      self._mapRewardGrid = {}
      self._mapNode.RewardSc:Init(#PlayerData.ScoreBoss.tabScoreBossReward, self, self.RefreshRewardGrid)
      self.mapSelfRankingData = PlayerData.ScoreBoss:GetRankSelfMsg()
      self._mapNode.svRankingReward:Init(PlayerData.ScoreBoss.maxRankCount, self, self.OnGridRankingRewardRefresh)
      self:InitRewardTab()
    end)
  end
  
  cs_coroutine.start(wait)
end

function ScoreBossSelectCtrl:OnGridRankingRewardRefresh(grid)
  if self._mapRewardGrid[grid] == nil then
    local mapCtrl = self:BindCtrlByNode(grid, "Game.UI.ScoreBoss.ScoreBossRanking.ScoreBossRewardGridCtrl")
    self._mapRewardGrid[grid] = mapCtrl
  end
  local nIdx = tonumber(grid.name)
  if nIdx == nil then
    return
  end
  nIdx = nIdx + 1
  local rankPlayerCount = 0
  local nSelfIdx = -1.0
  if self.mapSelfRankingData ~= nil then
    rankPlayerCount = PlayerData.ScoreBoss:GetRankPlayerCount()
    if 0 < rankPlayerCount and rankPlayerCount <= 100 then
      nSelfIdx = self.mapSelfRankingData.Rank / 100
    elseif 100 < rankPlayerCount then
      nSelfIdx = self.mapSelfRankingData.Rank / rankPlayerCount
    end
    nSelfIdx = nSelfIdx * 10000
  end
  self._mapRewardGrid[grid]:Refresh(nIdx, nSelfIdx)
end

function ScoreBossSelectCtrl:InitRewardTab()
  self:OnBtn_RewardTab(nil, -1)
end

function ScoreBossSelectCtrl:CloseRewardView()
  local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animRewardWindow, {
    "t_window_04_t_out"
  })
  self._mapNode.animRewardWindow:Play("t_window_04_t_out")
  self:AddTimer(1, nAnimLength, function()
    self._mapNode.t_window_04:SetActive(false)
    self._mapNode.goRewardView:SetActive(false)
  end, true, true, true)
end

function ScoreBossSelectCtrl:RefreshRewardGrid(goGrid, gridIndex)
  local texTitle = goGrid.transform:Find("AnimRoot/texTitle"):GetComponent("TMP_Text")
  local itemCtrl = self:BindCtrlByNode(goGrid.transform:Find("AnimRoot/item1/AniRoot/item").gameObject, "Game.UI.TemplateEx.TemplateItemCtrl")
  local btnGetReward = goGrid.transform:Find("AnimRoot/btnGetReward"):GetComponent("UIButton")
  local txt_GetReward = btnGetReward.transform:Find("AnimRoot/txt_GetReward"):GetComponent("TMP_Text")
  local txt_RewardDontComplete = goGrid.transform:Find("AnimRoot/txt_RewardDontComplete"):GetComponent("TMP_Text")
  local obj_RewardGet = goGrid.transform:Find("AnimRoot/obj_RewardGet")
  local txtProgress = goGrid.transform:Find("AnimRoot/imgProgressBar/txtProgress"):GetComponent("TMP_Text")
  local imgProgress = goGrid.transform:Find("AnimRoot/imgProgressBar/rtProgressFill/imgProgress"):GetComponent("RectTransform")
  local nIndex = gridIndex + 1
  local scoreBossReward = self.SortScoreBossRewardData()
  local scRewardData = scoreBossReward[nIndex]
  local scStarNeed = scRewardData.StarNeed
  local totalTmpStar = PlayerData.ScoreBoss.Star
  NovaAPI.SetTMPText(txt_GetReward, ConfigTable.GetUIText("Mail_Receive"))
  NovaAPI.SetTMPText(txt_RewardDontComplete, ConfigTable.GetUIText("PerActivity_Quest_UnComplete"))
  NovaAPI.SetTMPText(texTitle, orderedFormat(ConfigTable.GetUIText("ScoreBoss_Reward_Star"), scStarNeed))
  local isGet = table.indexof(PlayerData.ScoreBoss.tabStarRewards, scStarNeed) ~= 0
  local isComplete = scStarNeed <= totalTmpStar
  itemCtrl:SetItem(scRewardData.RewardItemId1, nil, scRewardData.RewardNum1, nil, isGet, false, false, true)
  local btnItem = goGrid.transform:Find("AnimRoot/item1"):GetComponent("UIButton")
  btnItem.onClick:RemoveAllListeners()
  btnItem.onClick:AddListener(function()
    local mapData = {
      nTid = scRewardData.RewardItemId1,
      bShowDepot = true
    }
    if self.bStartSnap ~= true then
      EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btnItem, mapData)
    end
  end)
  btnGetReward.gameObject:SetActive(isComplete and not isGet)
  obj_RewardGet.gameObject:SetActive(isGet)
  txt_RewardDontComplete.gameObject:SetActive(not isComplete and not isGet)
  if not isGet then
    NovaAPI.SetTMPText(txtProgress, orderedFormat("{0}/{1}", scStarNeed <= totalTmpStar and scStarNeed or totalTmpStar, scStarNeed))
  else
    NovaAPI.SetTMPText(txtProgress, orderedFormat("{0}/{1}", scStarNeed, scStarNeed))
  end
  local lengthPre = 0
  if scStarNeed < totalTmpStar or isGet then
    lengthPre = 1
  else
    lengthPre = totalTmpStar / scStarNeed
  end
  imgProgress.sizeDelta = Vector2(lengthPre * totalProLength, totalProHeight)
  btnGetReward.onClick:RemoveAllListeners()
  
  local function cbRead()
    self:OnClickGetAward(scStarNeed)
  end
  
  btnGetReward.onClick:AddListener(cbRead)
end

function ScoreBossSelectCtrl:SortScoreBossRewardData()
  local scoreReward = {}
  local totalTmpStar = PlayerData.ScoreBoss.Star
  
  local function SortRewardData(a, b)
    local aAchieved = a.StarNeed <= totalTmpStar
    local bAchieved = b.StarNeed <= totalTmpStar
    local isGet_a = table.indexof(PlayerData.ScoreBoss.tabStarRewards, a.StarNeed) ~= 0
    local isGet_b = table.indexof(PlayerData.ScoreBoss.tabStarRewards, b.StarNeed) ~= 0
    local aTop = aAchieved and not isGet_a
    local bTop = bAchieved and not isGet_b
    if aTop and not bTop then
      return true
    elseif not aTop and bTop then
      return false
    elseif aTop and bTop then
      return a.StarNeed < b.StarNeed
    end
    if aAchieved ~= bAchieved then
      return not aAchieved
    end
    return a.StarNeed < b.StarNeed
  end
  
  if PlayerData.ScoreBoss.tabScoreBossReward ~= nil then
    for _, scoreBossReward in pairs(PlayerData.ScoreBoss.tabScoreBossReward) do
      table.insert(scoreReward, scoreBossReward)
    end
    if 0 < #scoreReward then
      table.sort(scoreReward, SortRewardData)
    end
  end
  return scoreReward
end

function ScoreBossSelectCtrl:OnClickGetAward(star)
  local function cb()
    self._mapNode.RewardSc:SetAnim(0.1)
    
    self._mapNode.RewardSc:Init(#PlayerData.ScoreBoss.tabScoreBossReward, self, self.RefreshRewardGrid)
  end
  
  PlayerData.ScoreBoss:SendScoreBossStarRewardReceiveReq(cb, star)
end

function ScoreBossSelectCtrl:OnClickRewardOneKey()
  if not PlayerData.ScoreBoss.isHave then
    local sTip = ConfigTable.GetUIText("InfinityTower_Reward_Tips")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  self:OnClickGetAward(0)
end

function ScoreBossSelectCtrl:OnClickBtnGo()
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  if nCurTime > PlayerData.ScoreBoss.EndTime then
    local sTip = ConfigTable.GetUIText("ScoreBoss_Settlement_Tips")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.ScoreBoss, self.ChooseLevelId, {})
end

function ScoreBossSelectCtrl:OnClickBtnSettlement()
  local sTip = ConfigTable.GetUIText("ScoreBoss_Settlement_Tips")
  EventManager.Hit(EventId.OpenMessageBox, sTip)
end

function ScoreBossSelectCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  self.pageType = 1
  PanelManager.Home()
end

function ScoreBossSelectCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.pageType == 2 then
    local function func()
      EventManager.Hit(EventId.SetTransition)
      
      self._mapNode.SCBossList:SetActive(true)
      self._mapNode.SCBossInfo:SetActive(false)
      self:SetBgActive(1)
      for i, v in pairs(self.tabGridAni) do
        v.gameObject:SetActive(true)
        v:Play("ScoreBossSelect_Card_in")
      end
    end
    
    EventManager.Hit(EventId.SetTransition, 25, func)
    self.pageType = 1
    if not self.isPlayNPCVoice then
      self.isPlayNPCVoice = true
      self:PlayGreetVoice()
    end
  else
    EventManager.Hit(EventId.CloesCurPanel)
  end
end

function ScoreBossSelectCtrl:SetBgActive(index)
  self._mapNode.bgImageCover:SetActive(index == 1)
  self._mapNode.rawImgActor2D.gameObject:SetActive(index == 1)
  self._mapNode.InfoBgObj:SetActive(index ~= 1)
  if index == 1 then
    self:SetPngSprite(self._mapNode.bgImage, bgPath)
    self.nRemainTime = PlayerData.ScoreBoss.EndTime == 0 and 0 or PlayerData.ScoreBoss.EndTime - CS.ClientManager.Instance.serverTimeStamp
    if self.nRemainTime > 0 then
      self._mapNode.goRefresh:SetActive(true)
      self._mapNode.goSettlement:SetActive(false)
    else
      self._mapNode.goRefresh:SetActive(false)
      self._mapNode.goSettlement:SetActive(true)
    end
    self._mapNode.btnStar.gameObject:SetActive(true)
    self._mapNode.btnRank.gameObject:SetActive(true)
    self:ChangeBtnActorState(true)
  else
    self._mapNode.goRefresh:SetActive(false)
    self._mapNode.goSettlement:SetActive(false)
    self._mapNode.btnStar.gameObject:SetActive(false)
    self._mapNode.btnRank.gameObject:SetActive(false)
    self:ChangeBtnActorState(false)
  end
end

function ScoreBossSelectCtrl:RefreshNPC2D()
  local bUseL2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.rawImgActor2D.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
  self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
  if bUseL2D == true then
    Actor2DManager.SetBoardNPC2D(self:GetPanelId(), self._mapNode.rawImgActor2D, NpcId)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, self:GetPanelId(), NpcId)
  end
  if self.pageType == nil or self.pageType == 1 then
    self.isPlayNPCVoice = true
    self:PlayGreetVoice()
  end
end

function ScoreBossSelectCtrl:PlayGreetVoice()
  local isFirst, sKey = PlayerData.ScoreBoss:GetVoiceKey()
  if isFirst then
    PlayerData.Voice:StopCharVoice()
    local sVoiceRes = PlayerData.Voice:PlayCharVoice(sKey, NpcId, nil, true)
  else
    local tab = {"greet_npc", sKey}
    if PlayerData.ScoreBoss.isLevelClear then
      tab = {"clear"}
      PlayerData.ScoreBoss.isLevelClear = false
    end
    PlayerData.Voice:PlayCharVoice(tab, NpcId, nil, true)
  end
  PlayerData.Voice:StartBoardFreeTimer(NpcId)
end

function ScoreBossSelectCtrl:OnBtnClick_Actor()
  PlayerData.Voice:PlayBoardNPCClickVoice(NpcId)
end

function ScoreBossSelectCtrl:OnBtn_RewardTab(btn, idx)
  if self.nRewardTabIdx == idx then
    return
  end
  if idx == -1 then
    idx = 1
  end
  self.nRewardTabIdx = idx
  for i = 1, #self._mapNode.btnRewardTabOn do
    self._mapNode.btnRewardTabOn[i].gameObject:SetActive(i == idx)
    self._mapNode.btnRewardTabOff[i].gameObject:SetActive(i ~= idx)
  end
  self._mapNode.rtStarReward:SetActive(idx == 1)
  self._mapNode.rtRankingReward:SetActive(idx == 2)
end

function ScoreBossSelectCtrl:OnEvent_ShowBubbleVoiceText(nNpcId, nId)
  if nNpcId ~= NpcId then
    return
  end
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRoot, mapVoDirectoryData.voResource)
end

function ScoreBossSelectCtrl:ChangeBtnActorState(isShow)
  self._mapNode.btnActor.gameObject:SetActive(isShow)
  if not isShow then
    PlayerData.Voice:StopCharVoice()
    BubbleVoiceManager.StopBubbleAnim()
    PlayerData.Voice:ClearTimer()
  end
end

return ScoreBossSelectCtrl
