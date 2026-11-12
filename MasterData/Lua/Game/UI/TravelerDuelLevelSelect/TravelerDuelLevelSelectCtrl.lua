local TravelerDuelLevelSelectCtrl = class("TravelerDuelLevelSelectCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Path = require("path")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local typeof = _ENV.typeof
local mapToggle = {
  [0] = "Challenge",
  [1] = GameEnum.diffculty.Diffculty_1,
  [2] = GameEnum.diffculty.Diffculty_2,
  [3] = GameEnum.diffculty.Diffculty_3,
  [4] = GameEnum.diffculty.Diffculty_4
}
TravelerDuelLevelSelectCtrl._mapNodeConfig = {
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  bgLevelInfo = {sNodeName = "----Bg----"},
  rt_TravelerDuelSelect = {},
  rt_TravelerDuelInfo = {},
  RImagChar = {sComponentName = "RawImage"},
  rt_ChallengeInfo = {
    sCtrlName = "Game.UI.TravelerDuelLevelSelect.TravelerDuelChallengeInfoCtrl"
  },
  Skill = {
    sCtrlName = "Game.UI.TemplateEx.TemplateSkillCtrl",
    nCount = 5
  },
  btnSkill = {
    sNodeName = "Skill",
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_Skill"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  svTravelerDuel = {
    sComponentName = "LoopScrollView"
  },
  imgElementInfo = {sComponentName = "Image", nCount = 3},
  TMPTravelerDesc = {sComponentName = "TMP_Text"},
  TMPTravelerLevelNameNormal = {sComponentName = "TMP_Text"},
  TMPRecommendBuildTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  imgReconmendBuild = {sComponentName = "Image"},
  txtRecommendLevel = {sComponentName = "TMP_Text"},
  TMPRewardCount = {sComponentName = "TMP_Text"},
  TMPDuelLevel = {sComponentName = "TMP_Text"},
  TMPDuelExp = {sComponentName = "TMP_Text"},
  imgExpBarFillMask = {
    sComponentName = "RectTransform"
  },
  item = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 5
  },
  ItemBtn = {
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_RewardItem"
  },
  tog = {
    sComponentName = "UIButton",
    nCount = 4,
    callback = "OnBtnClick_Tog"
  },
  imgLockMask = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TogTips",
    nCount = 4
  },
  togCtrl = {
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl",
    nCount = 4
  },
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goEnemyInfo = {
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  goRewardList = {
    sCtrlName = "Game.UI.MainlineEx.RewardListCtrl"
  },
  btnAllReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardList"
  },
  txtEnergyCount = {sComponentName = "TMP_Text"},
  TMPTitleShop = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_ShopTitle"
  },
  TMPTitleQuest = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TD_QusetTitle"
  },
  TMPDuelLevelTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_LevelTitle"
  },
  TMPRewardHint = {sComponentName = "TMP_Text"},
  rt_LevelInfo = {
    sCtrlName = "Game.UI.TravelerDuelLevelSelect.TravelerDuelLevelInfoCtrl"
  },
  btnLevel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Level"
  },
  btnDuelQuestMain = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  btnDuelShopMain = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Shop"
  },
  btnEnemyInfoChallenge = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EnemyInfo"
  },
  rtCoverRoot = {sComponentName = "Transform"},
  redDotDuelQuest1 = {},
  btnRankingDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenRankingInfo"
  },
  TDRankingPanel = {
    sCtrlName = "Game.UI.TravelerDuelLevelSelect.TravelerDuelRanking.TravelerDuelRankingCtrl"
  },
  TMPNpcName = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_NPC2"
  },
  TMPSubTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_NPC1"
  },
  TMPSubName = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_NPC3"
  },
  TMPNpcTime = {sComponentName = "TMP_Text"},
  TMPNpcDate = {sComponentName = "TMP_Text"},
  TMPTitleChallenge = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_ChallengeTitle"
  },
  TMPTitleChallengel = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_NormalTitle"
  },
  OffScreen3DCameraNpc = {sComponentName = "Camera"},
  rimgNpc = {sComponentName = "RawImage"},
  goNpcPos = {},
  SpriteNpc = {
    sComponentName = "SpriteRenderer"
  },
  SpriteNpcFace = {
    sComponentName = "SpriteRenderer"
  },
  rtOffscreen = {
    sNodeName = "----Actor2D_OffScreen_Renderer----",
    sComponentName = "Transform"
  },
  txtRecommendLevelTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  txtTitleSkill = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegusBoss_Enemy_Skill"
  },
  txtTitleReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Level_Award"
  },
  txtBtnAllReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Btn_All"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Maninline_Btn_Go"
  }
}
TravelerDuelLevelSelectCtrl._mapEventConfig = {
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UpdateWorldClass] = "OnEvent_UpdateWorldClass"
}
TravelerDuelLevelSelectCtrl._mapRedDotConfig = {
  [RedDotDefine.Map_TravelerDuel] = {
    sNodeName = "redDotDuelQuest1"
  }
}

function TravelerDuelLevelSelectCtrl:Awake()
  self.mapLevelGrid = {}
  self.mapBossDefaultHard = {}
  self.mapBossMaxHard = {}
end

function TravelerDuelLevelSelectCtrl:FadeIn()
end

function TravelerDuelLevelSelectCtrl:FadeOut()
  EventManager.Hit(EventId.SetTransition)
end

function TravelerDuelLevelSelectCtrl:OnEnable()
  local month = os.date("%m")
  local day = os.date("%d")
  local hour = os.date("%H")
  local min = os.date("%M")
  NovaAPI.SetTMPText(self._mapNode.TMPNpcDate, string.format("%s/%s", month, day))
  NovaAPI.SetTMPText(self._mapNode.TMPNpcTime, string.format("%s:%s", hour, min))
  if nil == self.npcTimer then
    self.npcTimer = self:AddTimer(0, 1, function()
      local month = os.date("%m")
      local day = os.date("%d")
      local hour = os.date("%H")
      local min = os.date("%M")
      NovaAPI.SetTMPText(self._mapNode.TMPNpcDate, string.format("%s/%s", month, day))
      NovaAPI.SetTMPText(self._mapNode.TMPNpcTime, string.format("%s:%s", hour, min))
    end, true, true, true)
  end
  local windowResolution = CS.ClientManager.Instance.currentWindowResolution
  local scaleFactor = math.min(windowResolution.x / 2160, windowResolution.y / 1080)
  local fixedScale = windowResolution.x / scaleFactor * windowResolution.y / scaleFactor / 2332800
  self._mapNode.rtOffscreen.localScale = Vector3(fixedScale, fixedScale, fixedScale)
  self._mapNode.rimgNpc.gameObject:GetComponent("RectTransform").sizeDelta = Vector2(Settings.CURRENT_CANVAS_FULL_RECT_WIDTH, Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT)
  self._mapNode.OffScreen3DCameraNpc.orthographicSize = Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT / 200
  local nW = math.floor(Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * Settings.RENDERTEXTURE_SIZE_FACTOR)
  local nH = math.floor(Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT * Settings.RENDERTEXTURE_SIZE_FACTOR)
  self._NpcRenderTexture = GameUIUtils.GenerateRenderTextureFor2D(nW, nH)
  self._NpcRenderTexture.name = "TravelerDuelLevelSelect"
  self._mapNode.OffScreen3DCameraNpc.targetTexture = self._NpcRenderTexture
  NovaAPI.SetTexture(self._mapNode.rimgNpc, self._NpcRenderTexture)
  if self.goNpc ~= nil then
    destroy(self.goNpc)
  end
  self.goNpc = nil
  local mapSkinData = ConfigTable.GetData("NPCSkin", 917202)
  if mapSkinData ~= nil then
    if LocalSettingData.mapData.UseLive2D then
      self.goNpc = self:CreatePrefabInstance(mapSkinData.L2D, self._mapNode.goNpcPos.transform)
      self.goNpc.transform:SetLayerRecursively(CS.UnityEngine.LayerMask.NameToLayer("Cam_Layer_4"))
      Actor2DManager.PlayL2DAnim(self.goNpc.transform, "idle", true, true)
    else
      local sFileFullName = Path.basename(mapSkinData.Portrait)
      local sFileExtName = Path.extension(mapSkinData.Portrait)
      local sFileName = string.gsub(sFileFullName, sFileExtName, "")
      sFileName = string.gsub(sFileName, "_a", "")
      local sBodyName = string.format("%s_%s", sFileName, "001")
      local sFaceName = string.format("%s_%s", sFileName, "002")
      
      local function LoadSprite(sPath, sName)
        local _sPath = string.format("%s/atlas_png/a/%s.png", Path.dirname(sPath), sName)
        return self:LoadAsset(_sPath, typeof(Sprite))
      end
      
      NovaAPI.SetSpriteRendererSprite(self._mapNode.SpriteNpc, LoadSprite(mapSkinData.Portrait, sBodyName))
      NovaAPI.SetSpriteRendererSprite(self._mapNode.SpriteNpcFace, LoadSprite(mapSkinData.Portrait, sFaceName))
    end
  end
  
  local function GetRankingCallback()
    EventManager.Hit(EventId.SetTransition)
    local mapSelfRankingData, _, LastRankingRefreshTime, _ = PlayerData.TravelerDuel:GetTDRankingData()
    self.mapSelfRankingData = mapSelfRankingData
    local nNextRefreshTime = LastRankingRefreshTime + PlayerData.TravelerDuel.rankingRefreshTime
    if self.rankingRefrehTimer ~= nil then
      self.rankingRefrehTimer:Cancel()
      self.rankingRefrehTimer = nil
    end
    local nCountTime = nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
    if 0 < nCountTime then
      self.rankingRefrehTimer = self:AddTimer(1, nCountTime, "OnTimer_RefreshRanking", true, true, true, nil)
    else
    end
  end
  
  local _, _, LastRefreshTime, _ = PlayerData.TravelerDuel:GetTDRankingData()
  if LastRefreshTime == 0 then
    PlayerData.TravelerDuel:SendMsg_GetTravelerDuelRanking(GetRankingCallback)
  else
    local curTimeStamp = CS.ClientManager.Instance.serverTimeStamp
    local sum = curTimeStamp - LastRefreshTime
    if sum < PlayerData.TravelerDuel.rankingRefreshTime then
      GetRankingCallback()
    else
      PlayerData.TravelerDuel:SendMsg_GetTravelerDuelRanking(GetRankingCallback)
    end
  end
  self._mapNode.rt_TravelerDuelSelect:SetActive(true)
  self._mapNode.TopBarPanel:SetCoinVisible(true)
  self._mapNode.rt_TravelerDuelInfo:SetActive(false)
  self.nCurSkinId = nil
  Actor2DManager.UnsetActor2D()
  self._mapNode.rt_ChallengeInfo.gameObject:SetActive(false)
  self.nDuelLevel, self.nDuelExp = PlayerData.TravelerDuel:GetTravelerDuelLevel()
  self.mapChallenge = PlayerData.TravelerDuel:GetTravelerDuelChallenge()
  local nTotalExp = 0
  if ConfigTable.GetData("TravelerDuelLevel", self.nDuelLevel + 1) ~= nil then
    nTotalExp = ConfigTable.GetData("TravelerDuelLevel", self.nDuelLevel + 1).LevelUpExp
  end
  self.nCurChallengeBossId = 0
  if self.mapChallenge.nIdx == 0 then
    self.nCurChallengeBossId = 0
  else
    self.nCurChallengeBossId = ConfigTable.GetData("TravelerDuelChallengeSeason", self.mapChallenge.nIdx).BossId
  end
  NovaAPI.SetTMPText(self._mapNode.TMPDuelLevel, self.nDuelLevel)
  local nFullLength = 514
  local nFullHeight = 38
  if 0 < nTotalExp then
    NovaAPI.SetTMPText(self._mapNode.TMPDuelExp, string.format("<color=#3b62ae>%d</color>/%d", self.nDuelExp, nTotalExp))
    self._mapNode.imgExpBarFillMask.sizeDelta = Vector2(nFullLength * (self.nDuelExp / nTotalExp), nFullHeight)
  else
    NovaAPI.SetTMPText(self._mapNode.TMPDuelExp, "Max")
    self._mapNode.imgExpBarFillMask.sizeDelta = Vector2(nFullLength, nFullHeight)
  end
  local tbParam = self:GetPanelParam()
  if 0 < #tbParam then
    if tbParam[3] == nil then
    end
    self.bJumpto = tbParam[3]
    self.nJumptoHard = tbParam[1] == nil and 0 or tbParam[1]
    self.nJumptoGroup = tbParam[2] == nil and 0 or tbParam[2]
  end
  local tbCachedAffix, nCachedBossId = PlayerData.TravelerDuel:GetCacheAffixids()
  if nCachedBossId ~= nil and nCachedBossId ~= 0 then
    self.bJumpto = false
    self.nJumptoHard = 0
    self.nJumptoGroup = 0
  end
  self._mapNode.rt_TravelerDuelInfo:SetActive(false)
  self.nCurSkinId = nil
  Actor2DManager.UnsetActor2D()
  self._mapNode.rt_ChallengeInfo.gameObject:SetActive(false)
  self._mapNode.bgLevelInfo:SetActive(false)
  self.curState = 1
  self.curSelectHard = GameEnum.diffculty.Diffculty_1
  self.nCurGroupId = 0
  self.mapAllTravelerDuel = {}
  self.tbTravelerGroup = {}
  
  local function forEachTravelerDuel(mapData)
    if self.mapAllTravelerDuel[mapData.BossId] == nil then
      if mapData.Difficulty ~= 0 or mapData.BossId == self.nCurChallengeBossId then
        self.mapAllTravelerDuel[mapData.BossId] = {}
        if mapData.BossId ~= self.nCurChallengeBossId then
          table.insert(self.tbTravelerGroup, mapData.BossId)
        end
      else
        return
      end
    end
    self.mapAllTravelerDuel[mapData.BossId][mapData.Difficulty] = mapData
  end
  
  ForEachTableLine(DataTable.TravelerDuelBossLevel, forEachTravelerDuel)
  self:InitBossMaxHard()
  
  local function sortBoss(a, b)
    local mapBossA = ConfigTable.GetData("TravelerDuelBoss", a)
    local mapBossB = ConfigTable.GetData("TravelerDuelBoss", b)
    if mapBossA.TravelerDuelBossType ~= mapBossB.TravelerDuelBossType then
      return mapBossA.TravelerDuelBossType < mapBossB.TravelerDuelBossType
    end
    return mapBossA.Id < mapBossB.Id
  end
  
  table.sort(self.tbTravelerGroup, sortBoss)
  self._mapNode.svTravelerDuel:Init(#self.tbTravelerGroup, self, self.RefreshGrid, self.OnBtnClick_Grid)
  if self.nCurChallengeBossId ~= 0 then
    self._mapNode.rtCoverRoot.gameObject:SetActive(true)
    local mapLevelCfgData = ConfigTable.GetData("TravelerDuelBoss", self.nCurChallengeBossId)
    local nLevelId = self.mapAllTravelerDuel[self.nCurChallengeBossId][0].Id
    local coverPrefab = self:LoadAsset(string.format("%s.prefab", mapLevelCfgData.Cover))
    local goCover = instantiate(coverPrefab, self._mapNode.rtCoverRoot)
    local ctrlCover = self:BindCtrlByNode(goCover, "Game.UI.TravelerDuelLevelSelect.TDCoverCtrl")
    ctrlCover:Refresh(self.mapChallenge, nLevelId, function()
      self:OnBtnClick_Challenge()
    end, false)
  else
    self._mapNode.rtCoverRoot.gameObject:SetActive(true)
    local mapLevelCfgData = ConfigTable.GetData("TravelerDuelBoss", 1001)
    local nLevelId = 1001
    local coverPrefab = self:LoadAsset(string.format("%s.prefab", mapLevelCfgData.Cover))
    local goCover = instantiate(coverPrefab, self._mapNode.rtCoverRoot)
    local ctrlCover = self:BindCtrlByNode(goCover, "Game.UI.TravelerDuelLevelSelect.TDCoverCtrl")
    ctrlCover:Refresh(self.mapChallenge, nLevelId, function()
      self:OnBtnClick_Challenge()
    end, false)
  end
  if self.nJumptoGroup ~= 0 and self.nJumptoGroup ~= nil then
    if self.nJumptoHard ~= 0 and self.nJumptoHard ~= nil then
      self:OpenJumptoHard()
    else
      self:OpenJumptoGroup()
    end
  end
  if nCachedBossId ~= nil and nCachedBossId ~= 0 then
    self.curState = 2
    self.nCurGroupId = nCachedBossId
    local nLevelId = self.mapAllTravelerDuel[self.nCurGroupId][0].Id
    self._mapNode.rt_ChallengeInfo:Refresh(nLevelId)
    self._mapNode.rt_TravelerDuelSelect:SetActive(false)
    self._mapNode.TopBarPanel:SetCoinVisible(false)
    self._mapNode.rt_TravelerDuelInfo:SetActive(false)
    self.nCurSkinId = nil
    Actor2DManager.UnsetActor2D()
    self._mapNode.rt_ChallengeInfo.gameObject:SetActive(true)
    self._mapNode.bgLevelInfo:SetActive(true)
  end
  local totalRewardCount = ConfigTable.GetConfigValue("TravelerDuelWeeklyAwardLimit")
  local nRewardCount = PlayerData.TravelerDuel:GetTravelerDuelLevelRewardCount()
  nRewardCount = -1 < nRewardCount and totalRewardCount - nRewardCount or totalRewardCount
  if nRewardCount == nil then
    nRewardCount = 0
  end
  if nRewardCount < 0 then
    nRewardCount = 0
  end
  NovaAPI.SetTMPText(self._mapNode.TMPRewardCount, orderedFormat(ConfigTable.GetUIText("TD_WeekRewardTimes"), math.floor(nRewardCount), totalRewardCount))
  self._mapNode.aniRoot:Play("TravelerDuelSelect_in")
end

function TravelerDuelLevelSelectCtrl:OnDisable()
  self:UnbindAllGrids()
  if self.rankingRefrehTimer ~= nil then
    self.rankingRefrehTimer:Cancel()
    self.rankingRefrehTimer = nil
  end
  if nil ~= self.npcTimer then
    self.npcTimer:Cancel()
    self.npcTimer = nil
  end
  self._mapNode.OffScreen3DCameraNpc.targetTexture = nil
  NovaAPI.SetTexture(self._mapNode.rimgNpc, nil)
  if self._NpcRenderTexture ~= nil then
    GameUIUtils.ReleaseRenderTexture(self._NpcRenderTexture)
    self._NpcRenderTexture = nil
  end
  if self.goNpc ~= nil then
    destroy(self.goNpc)
    self.goNpc = nil
  end
end

function TravelerDuelLevelSelectCtrl:OnDestroy()
end

function TravelerDuelLevelSelectCtrl:OnRelease()
end

function TravelerDuelLevelSelectCtrl:RefreshGrid(goGrid, gridIndex)
  if self.mapLevelGrid[goGrid] == nil then
    self.mapLevelGrid[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.TravelerDuelLevelSelect.TravelerDuelLevelGridCtrl")
  end
  local nIdx = gridIndex + 1
  local nBossId = self.tbTravelerGroup[nIdx]
  local nLevelId = self.mapAllTravelerDuel[nBossId][mapToggle[1]].Id
  self.mapLevelGrid[goGrid]:Refresh(nBossId, nLevelId)
end

function TravelerDuelLevelSelectCtrl:UnbindAllGrids()
  for go, mapCtrl in ipairs(self.mapLevelGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapLevelGrid = {}
  delChildren(self._mapNode.rtCoverRoot)
end

function TravelerDuelLevelSelectCtrl:OpenJumptoGroup()
  self.curState = 2
  self.nCurGroupId = self.nJumptoGroup
  local mapBossCfgData = ConfigTable.GetData("TravelerDuelBoss", self.nCurGroupId)
  if mapBossCfgData == nil then
    printError("TravelerDuelBoss Data Missing:" .. self.nCurGroupId)
    return
  end
  if mapBossCfgData.TravelerDuelBossType == GameEnum.travelerDuelBossType.NORMAL then
    local nHard = self:GetMaxTravelerDuelHard(self.nCurGroupId)
    self:RefreshTravelerDuelInfo(self.nCurGroupId, nHard)
    self._mapNode.rt_TravelerDuelInfo:SetActive(true)
    self._mapNode.rt_TravelerDuelSelect:SetActive(false)
    self._mapNode.TopBarPanel:SetCoinVisible(false)
    self._mapNode.rt_ChallengeInfo.gameObject:SetActive(false)
    self._mapNode.bgLevelInfo:SetActive(true)
  else
    local nLevelId = self.mapAllTravelerDuel[self.nCurGroupId][0].Id
    self._mapNode.rt_ChallengeInfo:Refresh(nLevelId)
    self._mapNode.rt_TravelerDuelInfo:SetActive(false)
    self._mapNode.TopBarPanel:SetCoinVisible(false)
    self.nCurSkinId = nil
    Actor2DManager.UnsetActor2D()
    self._mapNode.rt_ChallengeInfo.gameObject:SetActive(true)
    self._mapNode.bgLevelInfo:SetActive(true)
  end
end

function TravelerDuelLevelSelectCtrl:OpenJumptoHard()
  self.curState = 2
  self.nCurGroupId = self.nJumptoGroup
  local nJumptoDuelId = self.mapAllTravelerDuel[self.nCurGroupId][self.nJumptoHard].Id
  if not PlayerData.TravelerDuel:GetTravelerDuelLevelUnlock(nJumptoDuelId) then
    self.nJumptoHard = GameEnum.diffculty.Diffculty_1
  end
  self:RefreshTravelerDuelInfo(self.nCurGroupId, self.nJumptoHard)
  self._mapNode.rt_TravelerDuelInfo:SetActive(true)
  self._mapNode.rt_TravelerDuelSelect:SetActive(false)
  self._mapNode.TopBarPanel:SetCoinVisible(false)
  self._mapNode.bgLevelInfo:SetActive(true)
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_Grid(goGrid, gridIndex)
  local nIdx = gridIndex + 1
  local nBossId = self.tbTravelerGroup[nIdx]
  self.curState = 2
  self.nCurGroupId = nBossId
  self._panel._tbParam[2] = nBossId
  self.mapBossDefaultHard = {}
  local nHard = self:GetMaxTravelerDuelHard(nBossId)
  local mapBosslevel = self.mapAllTravelerDuel[self.nCurGroupId][mapToggle[1]]
  local nBossLevelId = mapBosslevel.Id
  local bUnlock, sTip = PlayerData.TravelerDuel:GetTravelerDuelLevelUnlock(nBossLevelId)
  if not bUnlock then
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  self:RefreshTravelerDuelInfo(nBossId, nHard)
  self._mapNode.rt_TravelerDuelInfo:SetActive(true)
  self:AddTimer(1, 0.6, function()
    self._mapNode.rt_ChallengeInfo.gameObject:SetActive(false)
  end, true, true, true)
  self._mapNode.TopBarPanel:SetCoinVisible(false)
  self._mapNode.bgLevelInfo:SetActive(true)
  self._mapNode.aniRoot:Play("TravelerDuelInfo_in")
  EventManager.Hit("TDLevelSelectOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.6)
end

function TravelerDuelLevelSelectCtrl:RefreshLevelUnlock()
  for index, hardBtn in ipairs(self._mapNode.tog) do
    local bActive = self.mapAllTravelerDuel[self.nCurGroupId][mapToggle[index]] ~= nil
    hardBtn.gameObject:SetActive(bActive)
    if bActive then
      local nBossId = self.mapAllTravelerDuel[self.nCurGroupId][mapToggle[index]].Id
      local bLock = PlayerData.TravelerDuel:GetTravelerDuelLevelUnlock(nBossId)
      hardBtn.interactable = bLock
      self._mapNode.imgLockMask[index].gameObject:SetActive(not bLock)
      self._mapNode.imgLockMask[index].interactable = not bLock
      local tmpTitle = self._mapNode.togCtrl[index].gameObject.transform:Find("AnimRoot/AnimSwitch/txt_Select"):GetComponent("TMP_Text")
      local tmpTitle1 = self._mapNode.togCtrl[index].gameObject.transform:Find("AnimRoot/AnimSwitch/txt_unSelect"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(tmpTitle, ConfigTable.GetUIText("Diffculty_" .. index))
      NovaAPI.SetTMPText(tmpTitle1, ConfigTable.GetUIText("Diffculty_" .. index))
      for j = 1, 3 do
        local btnStar = self._mapNode.togCtrl[index].gameObject.transform:Find("rtLockInfo/rt_Targets/btnTarget" .. j):GetComponent("Button")
        btnStar.gameObject:SetActive(false)
      end
    end
  end
end

function TravelerDuelLevelSelectCtrl:RefreshTravelerDuelInfo(nGroupId, nHard)
  self:RefreshLevelUnlock()
  for i = 1, 4 do
    self._mapNode.togCtrl[i]:SetDefault(i == nHard)
  end
  self.curSelectHard = nHard
  self._panel._tbParam[1] = 0
  local mapTravelerDuelData = self.mapAllTravelerDuel[nGroupId][nHard]
  self.TravelerDuel = mapTravelerDuelData.Id
  if mapTravelerDuelData == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPTravelerLevelNameNormal, mapTravelerDuelData.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPTravelerDesc, mapTravelerDuelData.Desc)
  local rBuildRank = mapTravelerDuelData.RecommendBuildRank
  local sScore = "Icon/BuildRank/BuildRank_" .. rBuildRank
  self:SetPngSprite(self._mapNode.imgReconmendBuild, sScore)
  local nCharId = math.floor(mapTravelerDuelData.SkinId / 100)
  if self.nCurSkinId ~= mapTravelerDuelData.SkinId then
    self.nCurSkinId = mapTravelerDuelData.SkinId
    local bSuc, nType, nAnimLen = Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.RImagChar, nCharId, mapTravelerDuelData.SkinId)
  end
  for i = 1, 3 do
    if mapTravelerDuelData.EET == nil or mapTravelerDuelData.EET[i] == nil then
      self._mapNode.imgElementInfo[i].gameObject:SetActive(false)
    else
      self._mapNode.imgElementInfo[i].gameObject:SetActive(true)
      self:SetAtlasSprite(self._mapNode.imgElementInfo[i], "12_rare", AllEnum.ElementIconType.Icon .. mapTravelerDuelData.EET[i])
    end
  end
  local tbReward = decodeJson(mapTravelerDuelData.BaseAwardPreview)
  self.tbReward = tbReward
  local tbShowReward = {}
  local curLevelStar = PlayerData.TravelerDuel:GetTravelerDuelLevelStar(self.TravelerDuel)
  for _, tbValue in ipairs(tbReward) do
    local nLastIndex = #tbValue
    if not (0 < curLevelStar) or tbValue[nLastIndex] ~= 1 and tbValue[nLastIndex] ~= 2 then
      table.insert(tbShowReward, tbValue)
    end
  end
  for index = 1, 4 do
    self._mapNode.ItemBtn[index].interactable = tbShowReward[index] ~= nil
    if tbShowReward[index] ~= nil then
      local nLastIndex = #tbShowReward[index]
      self._mapNode.item[index]:SetItem(tbShowReward[index][1], nil, UTILS.ParseRewardItemCount(tbShowReward[index]), nil, false, tbShowReward[index][nLastIndex] == 1, tbShowReward[index][nLastIndex] == 2, true)
    else
      self._mapNode.item[index]:SetItem(nil)
    end
  end
  self.tbExtraDropReward = {}
  self._mapNode.ItemBtn[5].interactable = mapTravelerDuelData.ExtraDropPreview ~= nil and 0 < #mapTravelerDuelData.ExtraDropPreview
  if mapTravelerDuelData.ExtraDropPreview ~= nil and 0 < #mapTravelerDuelData.ExtraDropPreview then
    self._mapNode.item[5]:SetItem(mapTravelerDuelData.ExtraDropPreview[1], nil, nil, nil, false, false, false, false, false, false, true)
    local countTxt = ""
    if mapTravelerDuelData.ExtraDropPreview[2] == mapTravelerDuelData.ExtraDropPreview[3] then
      countTxt = mapTravelerDuelData.ExtraDropPreview[2]
    else
      countTxt = mapTravelerDuelData.ExtraDropPreview[2] .. "~" .. mapTravelerDuelData.ExtraDropPreview[3]
    end
    local txtCount = self._mapNode.item[5].gameObject.transform:Find("--Common--/txtCount"):GetComponent("TMP_Text")
    local txtX = txtCount.transform:Find("txtX")
    txtCount.gameObject:SetActive(0 < mapTravelerDuelData.ExtraDropPreview[2])
    txtX.gameObject:SetActive(mapTravelerDuelData.ExtraDropPreview[2] == mapTravelerDuelData.ExtraDropPreview[3])
    self.tbExtraDropReward = mapTravelerDuelData.ExtraDropPreview
    NovaAPI.SetTMPText(txtCount, countTxt)
  else
    self._mapNode.item[5]:SetItem(nil)
  end
  local tbSkill = mapTravelerDuelData.SkillShow
  for i = 1, 5 do
    if i <= #tbSkill then
      self._mapNode.Skill[i].gameObject:SetActive(true)
      self._mapNode.Skill[i]:SetTravelerDuelSkill(tbSkill[i])
    else
      self._mapNode.Skill[i].gameObject:SetActive(false)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtRecommendLevel, mapTravelerDuelData.SuggestedPower)
  local totalRewardCount = ConfigTable.GetConfigValue("TravelerDuelWeeklyAwardLimit")
  local nRewardCount = PlayerData.TravelerDuel:GetTravelerDuelLevelRewardCount(nGroupId)
  if curLevelStar <= 0 then
    NovaAPI.SetTMPText(self._mapNode.TMPRewardHint, ConfigTable.GetUIText("TD_FreeReward"))
  else
    local nShowCount = totalRewardCount - nRewardCount
    if 0 < nShowCount then
      NovaAPI.SetTMPText(self._mapNode.TMPRewardHint, string.format("%s %d/%d", ConfigTable.GetUIText("TD_WeekRewardTimes_Title"), nShowCount, totalRewardCount))
    else
      NovaAPI.SetTMPText(self._mapNode.TMPRewardHint, string.format("%s <color=#BD3059>%d</color>/<color=#264278>%d</color>", ConfigTable.GetUIText("TD_WeekRewardTimes_Title"), 0, totalRewardCount))
    end
  end
end

function TravelerDuelLevelSelectCtrl:GetMaxTravelerDuelHard(nBossId)
  local retHard = 1
  if self.mapAllTravelerDuel[nBossId] == nil then
    printError("BossId Error:" .. nBossId)
    return 1
  end
  if self.mapBossDefaultHard[nBossId] ~= nil then
    return self.mapBossDefaultHard[nBossId]
  end
  for nHard, mapBossLevel in pairs(self.mapAllTravelerDuel[nBossId]) do
    if PlayerData.TravelerDuel:GetTravelerDuelLevelUnlock(mapBossLevel.Id) then
      retHard = math.max(nHard, retHard)
    end
  end
  return retHard
end

function TravelerDuelLevelSelectCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  self._mapNode.rt_ChallengeInfo:CacheAffixes()
  PlayerData.TravelerDuel:SetCacheAffixids(nil, nil)
  if self.bJumpto then
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  if self.curState == 1 then
    EventManager.Hit(EventId.CloesCurPanel)
  else
    self.curSelectHard = GameEnum.diffculty.Diffculty_1
    self.nCurGroupId = 0
    self.curState = 1
    self._panel._tbParam[2] = 0
    self._panel._tbParam[1] = 0
    self:AddTimer(1, 0.5, function()
      self._mapNode.rt_TravelerDuelInfo:SetActive(false)
      self._mapNode.rt_TravelerDuelSelect:SetActive(true)
      self.nCurSkinId = nil
      Actor2DManager.UnsetActor2D()
      self._mapNode.rt_ChallengeInfo.gameObject:SetActive(false)
      self._mapNode.rt_ChallengeInfo:ClearListGrids(false)
      self._mapNode.bgLevelInfo:SetActive(false)
      self._mapNode.aniRoot:Play("TravelerDuelSelect_in")
      self._mapNode.TopBarPanel:SetCoinVisible(true)
      EventManager.Hit("TDLevelSelectIn", 1)
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 1.2)
  end
end

function TravelerDuelLevelSelectCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  self._mapNode.rt_ChallengeInfo:CacheAffixes()
  PlayerData.TravelerDuel:SetCacheAffixids(nil, nil)
  PanelManager.Home()
end

function TravelerDuelLevelSelectCtrl:OnEvent_UpdateWorldClass()
  self:RefreshLevelUnlock()
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_Go()
  self.mapBossDefaultHard[self.nCurGroupId] = self.curSelectHard
  
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.TravelerDuel, self.TravelerDuel, {})
  end
  
  EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_Tog(btn)
  local nHard = table.indexof(self._mapNode.tog, btn:GetComponent("UIButton"))
  local togIdx = table.indexof(self._mapNode.tog, btn)
  if nHard == nil then
    return
  end
  if self.curSelectHard ~= nHard then
    for idx, value in pairs(mapToggle) do
      if value == self.curSelectHard then
        self._mapNode.togCtrl[idx]:SetTrigger(false)
      end
    end
    self._mapNode.togCtrl[togIdx]:SetTrigger(true)
    self:RefreshTravelerDuelInfo(self.nCurGroupId, nHard)
  end
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_RewardList(btn)
  local mapLevel = ConfigTable.GetData("TravelerDuelBossLevel", self.TravelerDuel)
  local tbReward = decodeJson(mapLevel.BaseAwardPreview)
  local curLevelStar = PlayerData.TravelerDuel:GetTravelerDuelLevelStar(self.TravelerDuel)
  for _, tbValue in ipairs(tbReward) do
    local nLastIndex = #tbValue
    if 0 < curLevelStar and tbValue[nLastIndex] == 1 or curLevelStar == 3 and tbValue[nLastIndex] == 2 then
      table.insert(tbValue, true)
    end
  end
  self._mapNode.goRewardList:OpenPanel(tbReward, self.tbExtraDropReward)
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_RewardItem(btn)
  local nIdx = table.indexof(self._mapNode.ItemBtn, btn)
  if nIdx == 5 then
    if self.tbExtraDropReward == nil then
      return
    end
    local nTid = self.tbExtraDropReward[1]
    if nTid == nil then
      return
    end
    local rtBtn = btn.transform
    UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
    return
  end
  local mapLevel = ConfigTable.GetData("TravelerDuelBossLevel", self.TravelerDuel)
  local tbReward = decodeJson(mapLevel.BaseAwardPreview)
  local tbShowReward = {}
  local curLevelStar = PlayerData.TravelerDuel:GetTravelerDuelLevelStar(self.TravelerDuel)
  for _, tbValue in ipairs(tbReward) do
    local nLastIndex = #tbValue
    if not (0 < curLevelStar) or tbValue[nLastIndex] ~= 1 and tbValue[nLastIndex] ~= 2 then
      table.insert(tbShowReward, tbValue)
    end
  end
  tbReward = tbShowReward
  local rtBtn = btn.transform
  if tbReward[nIdx] ~= nil then
    local nTid = tbReward[nIdx][1]
    UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
  end
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_TogTips(btn, nidx)
  local nBossId = self.mapAllTravelerDuel[self.nCurGroupId][mapToggle[nidx]].Id
  local bUnLock, sMsg = PlayerData.TravelerDuel:GetTravelerDuelLevelUnlock(nBossId)
  if not bUnLock then
    EventManager.Hit(EventId.OpenMessageBox, sMsg)
  end
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_Skill(btn, nidx)
  local mapTravelerDuelData = self.mapAllTravelerDuel[self.nCurGroupId][self.curSelectHard]
  local nSkillId = mapTravelerDuelData.SkillShow[nidx]
  if nSkillId ~= 0 then
    local mapData = {nSkillId = nSkillId, bTravelerDuel = true}
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillTips, btn.transform, mapData)
  end
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_Level(btn)
  self._mapNode.rt_LevelInfo:Show()
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_Quest(btn)
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.OpenPanel, PanelId.TravelerDuelLevelQuestPanel)
    self._panel._nFadeInType = 2
  end, true, true, true)
  self._mapNode.aniRoot:Play("TravelerDuelTask")
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_Shop(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.ShopPanel, 2)
  self._panel._nFadeInType = 2
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_EnemyInfo()
  local nLevelId = self.mapAllTravelerDuel[self.nCurGroupId][0].Id
  EventManager.Hit("OpenTravelerDuelMonsterInfo", nLevelId)
end

function TravelerDuelLevelSelectCtrl:OnTimer_RefreshRanking()
  local function callback()
    local mapSelfRankingData, _, LastRankingRefreshTime, _ = PlayerData.TravelerDuel:GetTDRankingData()
    
    self.mapSelfRankingData = mapSelfRankingData
    local nNextRefreshTime = LastRankingRefreshTime + PlayerData.TravelerDuel.rankingRefreshTime
    if self.rankingRefrehTimer ~= nil then
      self.rankingRefrehTimer:Cancel()
      self.rankingRefrehTimer = nil
    end
    self.rankingRefrehTimer = self:AddTimer(1, nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp, "OnTimer_RefreshRanking", true, true, true, nil)
  end
  
  PlayerData.TravelerDuel:SendMsg_GetTravelerDuelRanking(callback)
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_Challenge(btn)
  self.curState = 2
  self.nCurGroupId = self.nCurChallengeBossId
  self._panel._tbParam[2] = self.nCurChallengeBossId
  local nLevelId = self.mapAllTravelerDuel[self.nCurGroupId][0].Id
  self._mapNode.rt_ChallengeInfo:Refresh(nLevelId)
  self._mapNode.rt_ChallengeInfo.gameObject:SetActive(true)
  self:AddTimer(1, 0.6, function()
    self._mapNode.rt_TravelerDuelInfo:SetActive(false)
    self.nCurSkinId = nil
    Actor2DManager.UnsetActor2D()
  end, true, true, true)
  self._mapNode.bgLevelInfo:SetActive(true)
  self._mapNode.aniRoot:Play("ChallengeInfo_in")
  self._mapNode.TopBarPanel:SetCoinVisible(false)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.6)
end

function TravelerDuelLevelSelectCtrl:OnBtnClick_OpenRankingInfo(btn)
  self._mapNode.TDRankingPanel:OpenPanel()
end

function TravelerDuelLevelSelectCtrl:InitBossMaxHard()
  for nBossId, mapLevels in pairs(self.mapAllTravelerDuel) do
    local nNewHard = 0
    for nHard, mapBossLevel in pairs(mapLevels) do
      if PlayerData.TravelerDuel:GetTravelerDuelLevelUnlock(mapBossLevel.Id) then
        nNewHard = math.max(nHard, nNewHard)
      end
    end
    if self.mapBossMaxHard ~= nil and self.mapBossMaxHard[nBossId] ~= nNewHard then
      self.mapBossMaxHard[nBossId] = nNewHard
      self.mapBossDefaultHard[nBossId] = nNewHard
    end
  end
end

return TravelerDuelLevelSelectCtrl
