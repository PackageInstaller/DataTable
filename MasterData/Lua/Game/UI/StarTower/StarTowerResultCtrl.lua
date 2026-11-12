local StarTowerResultCtrl = class("StarTowerResultCtrl", BaseCtrl)
local ModuleManager = require("GameCore.Module.ModuleManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
StarTowerResultCtrl._mapNodeConfig = {
  normalBg = {sNodeName = "NormalBg"},
  imgBlurredBg = {},
  goComplete = {sComponentName = "GameObject"},
  goFailed = {sComponentName = "GameObject"},
  goSweep = {sComponentName = "GameObject"},
  Mask = {
    sComponentName = "CanvasGroup"
  },
  txtFloorProcess = {nCount = 3, sComponentName = "TMP_Text"},
  txtPerkCount = {nCount = 3, sComponentName = "TMP_Text"},
  txtTimeValue = {nCount = 2, sComponentName = "TMP_Text"},
  ButtonClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txt_RogueLevelName = {nCount = 3, sComponentName = "TMP_Text"},
  FixedRoguelikeRewardGachaPanel = {
    sCtrlName = "Game.UI.FixedRoguelikeEx.FixedRoguelikeRewardGachaCtrl"
  },
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  uiEffectBg = {sComponentName = "GameObject"},
  txtFloorTitle = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "FixedRoguelike_RoomCount"
  },
  txtPerkTitle = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "FixedRoguelike_PerkCount"
  },
  txtTimeTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Result_Time_Title"
  },
  goRelicListSuc = {},
  goRankList = {},
  TMPHardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Result_Difficulty_Title"
  },
  TMPHard = {sComponentName = "TMP_Text"},
  imgNewRecord = {},
  TMPFinalScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Result_FinalScore_Title"
  },
  TMPFinalScore = {sComponentName = "TMP_Text"},
  TMPTimeScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Result_TimeScore_Title"
  },
  TMPTimeScore = {sComponentName = "TMP_Text"},
  TMPHardScore = {sComponentName = "TMP_Text"},
  TMPHardScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Result_BaseScore_Title"
  },
  txtRankTimeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Battle_Time"
  },
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Result_Fail_Tip"
  },
  txtTipShadow = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Result_Fail_Tip"
  },
  txtRankTime = {sComponentName = "TMP_Text"},
  goMainlineNameSuc = {},
  imgSweepResult = {sComponentName = "Image"},
  UIParticle_Sweep = {},
  txtClickToContinue = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  imgSweepResultTitle = {}
}
StarTowerResultCtrl._mapEventConfig = {
  CloseRewardGacha = "OnEvent_CloseGacha"
}

function StarTowerResultCtrl:Refresh(teamMemberid, mapResult)
  local curFloor = 1
  if mapResult.nFloor then
    curFloor = mapResult.nFloor
  end
  local nStage = 1
  if mapResult.nStage then
    nStage = mapResult.nStage
  end
  local nTime = mapResult.nTime or 0
  for _, v in ipairs(self._mapNode.txtTimeValue) do
    NovaAPI.SetTMPText(v, orderedFormat(ConfigTable.GetUIText("StarTower_Result_Time") or "", nTime))
  end
  local perkCount = mapResult.nPerkCount
  local nRoguelikeId = mapResult.nRoguelikeId
  self.tbBonus = mapResult.tbBonus
  for k, v in pairs(mapResult.tbPresents) do
    mapResult.tbPresents[k] = {nTid = v, nCount = 1}
  end
  for k, v in pairs(mapResult.tbOutfit) do
    mapResult.tbOutfit[k] = {nTid = v, nCount = 1}
  end
  self.mapDisplayChangeInfo = {
    tbRes = mapResult.tbRes,
    tbPresents = mapResult.tbPresents,
    tbOutfit = mapResult.tbOutfit,
    tbItem = mapResult.tbItem,
    tbRarityCount = mapResult.tbRarityCount
  }
  self.mapChangeInfo = mapResult.mapChangeInfo
  local mapRoguelike = ConfigTable.GetData("StarTower", nRoguelikeId)
  self.nDifficulty = mapRoguelike.Difficulty
  local sName = orderedFormat(ConfigTable.GetUIText("Dungeon_Difficulty") or "", mapRoguelike.Name, ConfigTable.GetUIText("Diffculty_" .. self.nDifficulty))
  self:SetLevelName(sName)
  local sProcess = orderedFormat(ConfigTable.GetUIText("StarTower_Level_Title_Layer") or "", curFloor)
  self:SetFloorProcess(sProcess)
  self:SetPerkCount(tostring(perkCount))
  if teamMemberid == nil then
    teamMemberid = {103}
  end
  self._mapNode.goRelicListSuc.gameObject:SetActive(not self.bRanking)
  self._mapNode.goRankList:SetActive(self.bRanking)
  if self.bRanking then
  else
    NovaAPI.SetTMPText(self._mapNode.txtTimeTitle[2], ConfigTable.GetUIText("StarTower_Result_Time_Title"))
  end
  WwiseAudioMgr:PostEvent("ui_loading_combatSFX_mute", nil, false)
  WwiseAudioMgr:PostEvent("char_common_all_pause")
  WwiseAudioMgr:PostEvent("mon_common_all_pause")
  WwiseAudioMgr:PostEvent("rouguelike_outfit_resetVV")
  WwiseAudioMgr:SetState("level", "None")
  PlayerData.Voice:PlayBattleResultVoice(teamMemberid, self.bSuccess)
  self.tbTeamMemberList = teamMemberid
  local nAnimTime
  if self.bSweep then
    self._mapNode.imgSweepResultTitle.gameObject:SetActive(self.bSuccess)
    if self.bSuccess then
      self:SetAtlasSprite(self._mapNode.imgSweepResult, "05_language", "zs_result_win_2")
      self._mapNode.UIParticle_Sweep:SetActive(true)
      WwiseAudioMgr:SetState("system", "victory2")
    else
      WwiseAudioMgr:StopDiscMusic()
      WwiseAudioMgr:SetState("system", "defeat")
      self:SetAtlasSprite(self._mapNode.imgSweepResult, "05_language", "zs_battle_result_4")
      self._mapNode.UIParticle_Sweep:SetActive(false)
    end
    NovaAPI.SetImageNativeSize(self._mapNode.imgSweepResult)
    self._mapNode.goRoot:SetActive(true)
    self._mapNode.goFailed:SetActive(false)
    self._mapNode.goComplete:SetActive(false)
    self._mapNode.goSweep:SetActive(true)
    nAnimTime = 3
  elseif self.bSuccess then
    self._mapNode.goRoot:SetActive(true)
    self._mapNode.goFailed:SetActive(false)
    self._mapNode.goComplete:SetActive(true)
    self._mapNode.goSweep:SetActive(false)
    WwiseAudioMgr:PlaySound("ui_roguelike_victory")
    WwiseAudioMgr:SetState("system", "victory2")
    nAnimTime = 4
  else
    WwiseAudioMgr:StopDiscMusic()
    WwiseAudioMgr:SetState("system", "defeat")
    PanelManager.InputDisable()
    self._mapNode.imgBlurredBg:SetActive(true)
    self._mapNode.goRoot:SetActive(false)
    self._mapNode.goFailed:SetActive(true)
    self._mapNode.goComplete:SetActive(false)
    self._mapNode.goSweep:SetActive(false)
    nAnimTime = 3
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self._mapNode.goRoot:SetActive(true)
    end
    
    cs_coroutine.start(wait)
  end
  self._mapNode.Mask.gameObject:SetActive(false)
  self:AddTimer(1, nAnimTime, "PlayAnim", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  if mapResult.tbAffinities ~= nil and 0 < #mapResult.tbAffinities and mapResult.tbAffinities ~= nil then
    for k, v in pairs(mapResult.tbAffinities) do
      PlayerData.Char:ChangeCharAffinityValue(v)
    end
  end
  self.tbNpcAffinity = {}
  local tbAffinity = mapResult.mapNPCAffinity
  if tbAffinity ~= nil then
    for _, mapReward in ipairs(tbAffinity) do
      local nNpcId = mapReward.Change.NPCId
      local mapCurNpcAffinity = PlayerData.StarTower:GetNpcAffinityData(nNpcId)
      local nBeforExp = mapCurNpcAffinity.nTotalExp - mapReward.Change.Increase
      local nBeforeLevel = 0
      local mapNpc = ConfigTable.GetData("StarTowerNPC", nNpcId)
      if mapNpc ~= nil then
        local nGroupId = mapNpc.AffinityGroupId
        for i = 0, mapCurNpcAffinity.nMaxLevel do
          local nId = nGroupId * 100 + i
          local mapAffinityCfgData = ConfigTable.GetData("NPCAffinityGroup", nId)
          if mapAffinityCfgData ~= nil and nBeforExp >= mapAffinityCfgData.AffinityValue then
            nBeforeLevel = mapAffinityCfgData.Level
          end
        end
        if mapCurNpcAffinity.Level ~= nBeforeLevel then
          table.insert(self.tbNpcAffinity, {
            NPCId = nNpcId,
            affinityLevel = mapCurNpcAffinity.Level,
            affinityLevelBefore = nBeforeLevel,
            Items = mapReward.Items
          })
        end
      end
    end
  end
end

function StarTowerResultCtrl:ProcessResult(mapResult)
  local tbReward = {}
  for _, mapInfo in ipairs(mapResult.tbRes) do
    table.insert(tbReward, {
      id = mapInfo.nTid,
      count = mapInfo.nCount
    })
  end
  for _, mapInfo in ipairs(mapResult.tbItem) do
    table.insert(tbReward, {
      id = mapInfo.nTid,
      count = mapInfo.nCount
    })
  end
  return tbReward
end

function StarTowerResultCtrl:Awake()
  EventManager.Hit(EventId.AvgBubbleShutDown)
  self._mapNode.goRoot:SetActive(false)
end

function StarTowerResultCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local mapResult = tbParam[1]
  local teamMemberid = tbParam[2]
  self.bSuccess = mapResult.bSuccess
  self.mapBuild = mapResult.mapBuild
  self.bRanking = mapResult.bRanking
  self.bSweep = mapResult.bSweep
  self.tbTowerRewards = mapResult.tbRewards
  self._mapNode.imgBlurredBg.gameObject:SetActive(false)
  if not ModuleManager.GetIsAdventure() then
    self._mapNode.goRoot:SetActive(false)
    self._mapNode.normalBg:SetActive(true)
    self._mapNode.imgBlurredBg:SetActive(true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.BlockInput, false)
      self._mapNode.goRoot:SetActive(true)
      self:Refresh(teamMemberid, mapResult)
    end
    
    cs_coroutine.start(wait)
    EventManager.Hit(EventId.BlockInput, true)
  else
    self._mapNode.normalBg.gameObject:SetActive(false)
    self:Refresh(teamMemberid, mapResult)
  end
  self.bProcessingClose = false
end

function StarTowerResultCtrl:OnDisable()
end

function StarTowerResultCtrl:PlayAnim()
  PlayerData.SideBanner:TryOpenSideBanner()
  
  local function rankUpCallback()
    local function callback()
      self:OpenReward()
    end
    
    self.bOpenUpgrade = self.bOpenUpgrade or PlayerData.Base:TryOpenWorldClassUpgrade(callback)
  end
  
  rankUpCallback()
end

function StarTowerResultCtrl:SetLevelName(sName)
  for _, v in ipairs(self._mapNode.txt_RogueLevelName) do
    NovaAPI.SetTMPText(v, sName)
  end
end

function StarTowerResultCtrl:SetFloorProcess(sProcess)
  for _, v in ipairs(self._mapNode.txtFloorProcess) do
    NovaAPI.SetTMPText(v, sProcess)
  end
end

function StarTowerResultCtrl:SetPerkCount(sPerk)
  for _, v in ipairs(self._mapNode.txtPerkCount) do
    NovaAPI.SetTMPText(v, sPerk)
  end
end

function StarTowerResultCtrl:ClosePanel()
  if self.bProcessingClose then
    return
  end
  self.bProcessingClose = true
  if not self.bSuccess and not self.bSweep then
    PanelManager.InputEnable(nil, true)
  end
  if self.mapBuild ~= nil then
    if self.mapBuild.BuildCoin ~= nil and self.mapBuild.BuildCoin > 0 then
      local nLimit = PlayerData.StarTower:GetStarTowerRewardLimit()
      local nCur = PlayerData.StarTower:GetStarTowerTicket()
      if nLimit < self.mapBuild.BuildCoin + nCur then
        local sTip = ConfigTable.GetUIText("BUILD_12")
        EventManager.Hit(EventId.OpenMessageBox, sTip)
      else
        EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildSave, self.bSuccess, self.mapBuild.BuildCoin, nil, self.bSweep)
        return
      end
    elseif self.mapBuild.Brief ~= nil then
      PlayerData.Build:CacheRogueBuild(self.mapBuild)
      
      local function buildDetailcallback(mapBuild)
        EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildSave, self.bSuccess, mapBuild, self.tbBonus, self.bSweep)
      end
      
      PlayerData.Build:GetBuildDetailData(buildDetailcallback, self.mapBuild.Brief.Id)
      return
    end
  end
  if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
    EventManager.Hit(EventId.CloesCurPanel)
    EventManager.Hit("CloseRoguelikeResultCtrlEx")
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.Mask, 0)
    self._mapNode.Mask.gameObject:SetActive(true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    local sequence = DOTween.Sequence()
    sequence:Append(self._mapNode.Mask:DOFade(1, 0.5):SetUpdate(true))
    sequence:AppendCallback(function()
      if self.bSuccess then
        NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
      else
        local function levelEndCallback()
          EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
          
          NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
        end
        
        EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
      end
    end)
    sequence:SetUpdate(true)
  end
end

function StarTowerResultCtrl:OpenReward()
  self._mapNode.uiEffectBg:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if PlayerData.nCurGameType ~= AllEnum.WorldMapNodeType.FixedRoguelike then
      self:OnEvent_CloseGacha()
    else
      self._mapNode.FixedRoguelikeRewardGachaPanel:ShowReward(self.mapDisplayChangeInfo)
    end
  end
  
  cs_coroutine.start(wait)
end

function StarTowerResultCtrl:OnBtnClick_Close(btn)
  local function AffiniftyCallback()
    if self.bOpenUpgrade then
      self:ClosePanel()
    else
      self:OpenReward()
    end
  end
  
  if #self.tbNpcAffinity > 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.NPCAffinityLevelUp, self.tbNpcAffinity, AffiniftyCallback)
  else
    AffiniftyCallback()
  end
end

function StarTowerResultCtrl:OnEvent_CloseGacha()
  local function callback()
    self:ClosePanel()
  end
  
  UTILS.OpenReceiveByDisplayItem(self.tbTowerRewards, self.mapChangeInfo, callback)
end

return StarTowerResultCtrl
