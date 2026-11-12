local RegionBossFormationCtrl = class("RegionBossFormationCtrl", BaseCtrl)
local CustomModelMaterialVariantComponent = CS.CustomModelMaterialVariantComponent
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local LocalData = require("GameCore.Data.LocalData")
local typeof = _ENV.typeof
local GameCameraStackManager = CS.GameCameraStackManager
local ResType = GameResourceLoader.ResType
local Animator = CS.UnityEngine.Animator
RegionBossFormationCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goNoneTeam = {sNodeName = "---None---"},
  txtNoneTeam = {
    sComponentName = "TMP_Text",
    sLanguageId = "RogueBoss_SelectTeam_NoneTeam"
  },
  txtSelectTeam = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegionBoss_Manage_Title"
  },
  btnAddBuild = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AddBuild"
  },
  goHaveTeam = {sNodeName = "---Team---"},
  goChar = {
    nCount = 3,
    sCtrlName = "Game.UI.RegionBossFormationEx.RegionBossFormationCharCtrl"
  },
  btnStartBattle = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Start"
  },
  txtStartBattle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegionBoss_SelectTeam_GoWar"
  },
  aniBuildDetail = {
    sNodeName = "BuildDetail",
    sComponentName = "Animator"
  },
  btnChangeTeam = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeTeam"
  },
  txtChangeTeam = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegionBoss_SelectTeam_Change"
  },
  btnTeamDetails = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TeamDetails"
  },
  txtTeamDetails = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegionBoss_SelectTeam_Details"
  },
  btnAttr = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Attr"
  },
  txtAttr = {sComponentName = "TMP_Text"},
  imgRareFrame = {sComponentName = "Image"},
  imgRareScore = {sComponentName = "Image"},
  txtScoreCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Score"
  },
  txtBuildScore = {sComponentName = "TMP_Text"},
  txtBuildName = {sComponentName = "TMP_Text"},
  UIParallax3DStage = {
    sComponentName = "UIParallaxStageCameraController"
  },
  BGbackup = {
    sNodeName = "----BGbackup----"
  },
  goLoadMask = {},
  txtStoryModel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_StoryModel"
  },
  txtBasicModel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_BasicModel"
  },
  txtStoryTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_StoryTip"
  },
  btnSwitch = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_StorySwitch"
  },
  imgStoryModel = {},
  imgBasicModel = {}
}
RegionBossFormationCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome",
  [EventId.OpenMessageBox] = "OnEvent_OpenMessageBox",
  [EventId.IsNewDay] = "OnEvent_NewDay"
}

function RegionBossFormationCtrl:ClearSelectedBuild()
  if self.nType == AllEnum.RegionBossFormationType.RegionBoss or self.nType == AllEnum.RegionBossFormationType.WeeklyCopies then
    PlayerData.RogueBoss:SetSelBuildId(0)
  elseif self.nType == AllEnum.RegionBossFormationType.TravelerDuel then
    local activityLevelsData = PlayerData.Activity:GetActivityDataById(self.Other[1])
    activityLevelsData:SetCachedBuildId(0)
  elseif self.nType == AllEnum.RegionBossFormationType.DailyInstance then
    PlayerData.DailyInstance:SetSelBuildId(0)
  elseif self.nType == AllEnum.RegionBossFormationType.InfinityTower then
    PlayerData.InfinityTower:SetSelBuildId(0, self.selLvId)
  elseif self.nType == AllEnum.RegionBossFormationType.EquipmentInstance then
    PlayerData.EquipmentInstance:SetSelBuildId(0)
  elseif self.nType == AllEnum.RegionBossFormationType.Story then
    PlayerData.Avg:SetSelBuildId(0)
  elseif self.nType == AllEnum.RegionBossFormationType.ScoreBoss or self.nType == AllEnum.RegionBossFormationType.ScoreBoss_GM then
    PlayerData.ScoreBoss:SetSelBuildId(0, self.selLvId)
  elseif self.nType == AllEnum.RegionBossFormationType.TraceHunt then
    PlayerData.TraceHunt:SetSelBuildId(0)
  elseif self.nType == AllEnum.RegionBossFormationType.SkillInstance then
    PlayerData.SkillInstance:SetSelBuildId(0)
  elseif self.nType == AllEnum.RegionBossFormationType.ActivityLevels then
    local activityLevelsData = PlayerData.Activity:GetActivityDataById(self.Other[1])
    activityLevelsData:SetCachedSelBuildId(0, self.selLvId)
  elseif self.nType == AllEnum.RegionBossFormationType.ActivityStory then
    local storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
    storyData:SetSelBuildId(0, self.nActId)
  end
  self.mbuildId = 0
  self.isHaveTeam = false
  self._mapNode.goHaveTeam.transform.localScale = Vector3.zero
  self._mapNode.goNoneTeam.transform.localScale = Vector3.one
  self._mapNode.btnStartBattle.gameObject:SetActive(false)
  self:UnbindAllChar()
end

function RegionBossFormationCtrl:CheckSelectedLimitedTrialBuild(bShowTips)
  if self.bTrial or not self.isHaveTeam then
    return true
  end
  local mapBuildData = self._mapAllBuild and self._mapAllBuild[self.mbuildId] or PlayerData.Build:GetBuildData(self.mbuildId)
  if mapBuildData == nil or mapBuildData.nBuildSource ~= AllEnum.BuildSource.LimitedTrial then
    return true
  end
  if PlayerData.Build:IsLimitedTrialBuildValid(self.mbuildId, self.nType) then
    return true
  end
  self:ClearSelectedBuild()
  if bShowTips then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = ConfigTable.GetUIText("Reengagement_BuildInvalid")
    })
  end
  return false
end

function RegionBossFormationCtrl:Refresh()
  if not self:CheckSelectedLimitedTrialBuild(false) then
    self._mapNode.goLoadMask:SetActive(false)
    return
  end
  if self.isHaveTeam then
    local function GetDataCallback(tbBuildData, mapAllBuild)
      self._mapAllBuild = mapAllBuild
      
      self._tbAllBuild = tbBuildData
      if self._mapAllBuild[self.mbuildId] then
        self._mapNode.goNoneTeam.transform.localScale = Vector3.zero
        self._mapNode.goHaveTeam.transform.localScale = Vector3.one
        self._mapNode.aniBuildDetail:Play("BuildDetail_in", 0, 0)
        self._mapNode.btnStartBattle.gameObject:SetActive(true)
        self:RefreshChar()
      else
        self:ClearSelectedBuild()
        local sTip = ConfigTable.GetUIText("RegionBoss_Team_Delete")
        EventManager.Hit(EventId.OpenMessageBox, sTip)
      end
      self._mapNode.goLoadMask:SetActive(false)
    end
    
    if self.bTrial then
      local mapAllBuild = {}
      mapAllBuild[self.mapTrialBuild.nBuildId] = self.mapTrialBuild
      GetDataCallback({
        self.mapTrialBuild
      }, mapAllBuild)
    else
      self._mapNode.goLoadMask:SetActive(true)
      PlayerData.Build:GetSelectableBuildBriefData(GetDataCallback, self.nType)
    end
  else
    self._mapNode.goHaveTeam.transform.localScale = Vector3.zero
    self._mapNode.goNoneTeam.transform.localScale = Vector3.one
    self._mapNode.btnStartBattle.gameObject:SetActive(false)
    self:UnbindAllChar()
  end
end

function RegionBossFormationCtrl:UnbindAllChar()
  for i, mapModel in pairs(self.mapCurModel) do
    if mapModel.model ~= nil then
      NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, i - 1)
      destroy(mapModel.model)
    end
  end
  self.mapCurModel = {}
end

function RegionBossFormationCtrl:RefreshChar()
  if self.nType == AllEnum.RegionBossFormationType.RegionBoss or self.nType == AllEnum.RegionBossFormationType.WeeklyCopies then
    PlayerData.RogueBoss:SetSelBuildId(self.mbuildId)
  end
  local mapData = self._mapAllBuild[self.mbuildId]
  for i = 1, 3 do
    self._mapNode.goChar[i]:OnRender(mapData.tbChar, i, mapData.nBuildSource)
    if mapData.tbChar[i] and mapData.tbChar[i] ~= 0 then
      if self.mapCurModel[i] == nil or self.mapCurModel[i].nCharId ~= mapData.tbChar[i] then
        self:LoadCharacter(mapData.tbChar[i].nTid, i)
      end
    elseif self.mapCurModel[i] ~= nil then
      NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, i - 1)
      destroy(self.mapCurModel[i].model)
      self.mapCurModel[i] = nil
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtBuildScore, mapData.nScore)
  if mapData.sName == "" or mapData.sName == nil then
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, ConfigTable.GetUIText("RoguelikeBuild_EmptyBuildName"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, mapData.sName)
  end
  local sScore = "Icon/BuildRank/BuildRank_" .. mapData.mapRank.Id
  local sFrame = AllEnum.FrameType_New.BuildFormation .. AllEnum.FrameColor_New[mapData.mapRank.Rarity]
  self:SetPngSprite(self._mapNode.imgRareScore, sScore)
  self:SetAtlasSprite(self._mapNode.imgRareFrame, "12_rare", sFrame)
  NovaAPI.SetTMPText(self._mapNode.txtAttr, UTILS.ParseParamDesc(ConfigTable.GetUIText(mapData.mapRank.Desc), mapData.mapRank))
  if PlayerData.Guide:GetGuideState() then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit("Guide_RegionBossFormationCtrl_RefreshChar")
    end
    
    cs_coroutine.start(wait)
  end
end

function RegionBossFormationCtrl:LoadCharacter(nCharId, idx)
  local mapSkin = ConfigTable.GetData_CharacterSkin(PlayerData.Char:GetCharSkinId(nCharId))
  if not mapSkin then
    printLog("没有找到皮肤配置" .. nCharId)
    return
  end
  local sFullPath = string.format("%s.prefab", mapSkin.Model_Show)
  
  local function LoadModelCallback(obj)
    if self._mapNode == nil then
      return
    end
    self._panel.nLoadProcess = self._panel.nLoadProcess - 1
    if not self.isHaveTeam then
      return
    end
    if 0 < idx then
      if self.mapCurModel[idx] ~= nil then
        NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, idx - 1)
        destroy(self.mapCurModel[idx].model)
        self.mapCurModel[idx] = nil
      end
      local go = instantiate(obj, self.rtSceneOriginPos)
      self.mapCurModel[idx] = {nCharId = nCharId, model = go}
      NovaAPI.BindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, idx - 1, go, true)
      if self.rtSceneOriginPos ~= nil then
        go.transform.position = self.rtSceneOriginPos.position
        go.transform.localEulerAngles = Vector3(0, 180, 0)
        go.transform.localScale = Vector3.one * (mapSkin.ModelShowScale / 10000)
        local animator = go:GetComponent(typeof(Animator))
        if animator ~= nil and animator:IsNull() == false then
          animator:SetBool("standby", true)
        end
        GameUIUtils.SetCustomModelMaterialVariant(go, CS.CustomModelMaterialVariantComponent.VariantNames.FormationView)
      end
      if PlayerData.Guide:GetGuideState() and not self.bSendGuide then
        self.bSendGuide = true
        EventManager.Hit("Guide_LoadCharacterSuccess")
      end
    end
  end
  
  self._panel.nLoadProcess = self._panel.nLoadProcess + 1
  self:LoadAssetAsync(sFullPath, typeof(GameObject), LoadModelCallback)
end

function RegionBossFormationCtrl:SetModelPos(nCharId, objModel, nPos)
  local mapSkin = ConfigTable.GetData_CharacterSkin(PlayerData.Char:GetCharSkinId(nCharId))
  if not mapSkin then
    printLog("没有找到皮肤配置" .. nCharId)
    return
  end
  if self.mapCurModel[nPos] ~= nil then
    NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, nPos - 1)
    destroy(self.mapCurModel[nPos].model)
    self.mapCurModel[nPos] = nil
  end
  self.mapCurModel[nPos] = {nCharId = nCharId, model = objModel}
  if self.rtSceneOriginPos ~= nil then
    objModel.transform.position = self.rtSceneOriginPos.position
    objModel.transform.localScale = Vector3.one * (mapSkin.ModelShowScale / 10000)
    local animator = objModel:GetComponent(typeof(Animator))
    if animator ~= nil then
      animator:SetBool("standby", true)
    end
    local matVariantComp = objModel:GetComponent(typeof(CustomModelMaterialVariantComponent))
    if matVariantComp ~= nil then
      matVariantComp:SetVariant(CS.CustomModelMaterialVariantComponent.VariantNames.FormationView)
    end
  end
end

function RegionBossFormationCtrl:OpenRegionBoss()
  if self.isHaveTeam then
    local islock = true
    local worldClass = PlayerData.Base:GetWorldClass()
    local tempData = ConfigTable.GetData("RegionBossLevel", self.selLvId)
    if worldClass >= tempData.NeedWorldClass then
      if tempData.PreLevelId ~= 0 then
        local cachePreData = PlayerData.RogueBoss:GetCacheBossLevelMsg(tempData.PreLevelId)
        if cachePreData and cachePreData.maxStar and cachePreData.maxStar >= tempData.PreLevelStar then
          islock = false
        end
      else
        islock = false
      end
    else
      islock = true
    end
    if islock then
      return
    end
    
    local function CheckItemCountExceededLimitCb(isExceeded)
      if not isExceeded then
        local function func_cbRegionBossLevelApplyAck(_, msgChangeInfo)
          local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(msgChangeInfo)
          
          HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
        end
        
        local mapSendMsg = {}
        local mapBuildData = PlayerData.Build:GetBuildData(self.mbuildId)
        local bTrial = mapBuildData.nBuildSource == AllEnum.BuildSource.Trial or mapBuildData.nBuildSource == AllEnum.BuildSource.LimitedTrial
        local nBuildType = bTrial and 2 or 1
        mapSendMsg.Id = self.selLvId
        mapSendMsg.Build = {
          Type = nBuildType,
          BuildId = self.mbuildId
        }
        HttpNetHandler.SendMsg(NetMsgId.Id.region_boss_level_apply_req, mapSendMsg, nil, func_cbRegionBossLevelApplyAck)
      end
    end
    
    PlayerData.Item:CheckItemCountExceededLimit(CheckItemCountExceededLimitCb)
  else
    local sTip = ConfigTable.GetUIText("RegionBoss_NoneTeam")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
end

function RegionBossFormationCtrl:OpenWeeklyCopies()
  if self.isHaveTeam then
    local islock = true
    local worldClass = PlayerData.Base:GetWorldClass()
    local tempData = ConfigTable.GetData("WeekBossLevel", self.selLvId)
    if worldClass >= tempData.NeedWorldClass then
      if tempData.PreLevelId ~= 0 then
        local cachePreData = PlayerData.RogueBoss:GetCacheWeeklyBossMsg(tempData.PreLevelId)
        if cachePreData ~= nil then
          islock = false
        end
      else
        islock = false
      end
    else
      islock = true
    end
    if islock then
      print("未解锁")
      return
    end
    
    local function CheckItemCountExceededLimitCb(isExceeded)
      if not isExceeded then
        local function func_cbRegionBossLevelApplyAck(_, msgChangeInfo)
        end
        
        local mapSendMsg = {}
        local mapBuildData = PlayerData.Build:GetBuildData(self.mbuildId)
        local bTrial = mapBuildData.nBuildSource == AllEnum.BuildSource.Trial or mapBuildData.nBuildSource == AllEnum.BuildSource.LimitedTrial
        local nBuildType = bTrial and 2 or 1
        mapSendMsg.Id = self.selLvId
        mapSendMsg.Build = {
          Type = nBuildType,
          BuildId = self.mbuildId
        }
        HttpNetHandler.SendMsg(NetMsgId.Id.week_boss_apply_req, mapSendMsg, nil, func_cbRegionBossLevelApplyAck)
      end
    end
    
    PlayerData.Item:CheckItemCountExceededLimit(CheckItemCountExceededLimitCb)
  else
    local sTip = ConfigTable.GetUIText("RegionBoss_NoneTeam")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
end

function RegionBossFormationCtrl:OpenDailyInstance()
  PlayerData.DailyInstance:SetSelBuildId(0)
  if self.isHaveTeam then
    local function CheckItemCountExceededLimitCb(isExceeded)
      if not isExceeded then
        PlayerData.DailyInstance:MsgEnterDailyInstance(self.selLvId, self.mbuildId)
      end
    end
    
    PlayerData.Item:CheckItemCountExceededLimit(CheckItemCountExceededLimitCb)
  end
end

function RegionBossFormationCtrl:OpenTravelerDuel()
  if self.isHaveTeam then
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    local activityLevelsData = PlayerData.Activity:GetActivityDataById(self.Other[1])
    if nCurTime > activityLevelsData.nEndTime then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_End_Notice"))
      return
    end
    activityLevelsData:EnterTrekkerVersus(self.Other[1], self.selLvId, self.mbuildId, self.Other[2])
  end
end

function RegionBossFormationCtrl:OpenInfinityTower()
  if self.isHaveTeam then
    local mapData = self._mapAllBuild[self.mbuildId]
    local tbC = mapData.tbChar
    local tmpTab = {}
    for i, v in pairs(tbC) do
      table.insert(tmpTab, v.nTid)
    end
    if not PlayerData.InfinityTower:JudgeInfinityTowerBuildCanUse(tmpTab, self.selLvId) then
      local strTips = ConfigTable.GetUIText("InfinityTower_Build_NotMeetingCond")
      EventManager.Hit(EventId.OpenMessageBox, strTips)
      return
    end
    
    local function CheckItemCountExceededLimitCb(isExceeded)
      if not isExceeded then
        PlayerData.InfinityTower:EnterITApplyReq(self.selLvId, self.mbuildId, true)
      end
    end
    
    PlayerData.Item:CheckItemCountExceededLimit(CheckItemCountExceededLimitCb)
  end
end

function RegionBossFormationCtrl:OpenEquipmentInstance()
  PlayerData.EquipmentInstance:SetSelBuildId(0)
  if self.isHaveTeam then
    local function CheckItemCountExceededLimitCb(isExceeded)
      if not isExceeded then
        PlayerData.EquipmentInstance:MsgEnterEquipmentInstance(self.selLvId, self.mbuildId)
      end
    end
    
    PlayerData.Item:CheckItemCountExceededLimit(CheckItemCountExceededLimitCb)
  end
end

function RegionBossFormationCtrl:OpenSkillInstance()
  PlayerData.SkillInstance:SetSelBuildId(0)
  if self.isHaveTeam then
    local function CheckItemCountExceededLimitCb(isExceeded)
      if not isExceeded then
        PlayerData.SkillInstance:MsgEnterSkillInstance(self.selLvId, self.mbuildId)
      end
    end
    
    PlayerData.Item:CheckItemCountExceededLimit(CheckItemCountExceededLimitCb)
  end
end

function RegionBossFormationCtrl:OpenStoryBattle()
  if self.isHaveTeam then
    local nBuildId = self.bTrial and 0 or self.mbuildId
    PlayerData.Avg:SendMsg_STORY_ENTER(self.Other, nBuildId)
  end
end

function RegionBossFormationCtrl:OpenScoreBossBattle()
  if self.isHaveTeam then
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    if nCurTime > PlayerData.ScoreBoss.EndTime then
      return
    end
    PlayerData.ScoreBoss:SendEnterScoreBossApplyReq(self.selLvId, self.mbuildId)
  end
end

function RegionBossFormationCtrl:OpenScoreBossBattle_GM()
  if self.isHaveTeam then
    PlayerData.ScoreBoss:SendEnterScoreBossGM(self.selLvId, self.mbuildId)
  end
end

function RegionBossFormationCtrl:OpenTraceHuntBattle()
  if self.isHaveTeam then
    if PlayerData.TraceHunt:GetControlLeftTime() <= 0 then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TraceHunt_Tips_ControlInterrupt"))
      return
    end
    if 0 < self.Other[2] then
      local nCurTime = CS.ClientManager.Instance.serverTimeStamp
      local nLeft = self.Other[2] + ConfigTable.GetConfigNumber("TraceHuntBossHuntLimitTime") - nCurTime
      if nLeft <= 0 then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TraceHunt_Tips_HuntInterrupt"))
        return
      end
    end
    PlayerData.TraceHunt:SendTraceHuntApplyReq(self.Other[1], self.selLvId, self.mbuildId, self.Other[2], self.Other[3])
  end
end

function RegionBossFormationCtrl:OpenActivityLevelsBattle()
  if self.isHaveTeam then
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    local activityLevelsData = PlayerData.Activity:GetActivityDataById(self.Other[1])
    if nCurTime > activityLevelsData.nEndTime then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_End_Notice"))
      return
    end
    activityLevelsData:SendEnterActivityLevelsApplyReq(self.Other[1], self.selLvId, self.mbuildId)
  end
end

function RegionBossFormationCtrl:OpenActivityStoryBattle()
  if self.isHaveTeam then
    local nBuildId = self.bTrial and 0 or self.mbuildId
    local storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
    storyData:SendMsg_STORY_ENTER(self.nActId, self.Other, nBuildId)
  end
end

function RegionBossFormationCtrl:SwitchStoryType(bTrial)
  self._mapNode.imgStoryModel:SetActive(bTrial)
  self._mapNode.imgBasicModel:SetActive(not bTrial)
  self._mapNode.txtStoryTip.gameObject:SetActive(bTrial)
  self._mapNode.btnChangeTeam.gameObject:SetActive(not bTrial)
  self._mapNode.btnTeamDetails.gameObject:SetActive(not bTrial)
  for i = 1, 3 do
    self._mapNode.goChar[i]:RefreshDetailVisible(bTrial)
  end
end

function RegionBossFormationCtrl:Awake()
  self._panel.nLoadProcess = 0
end

function RegionBossFormationCtrl:OnEnable()
  self._panel.nLoadProcess = 0
  self.bStartBattle = false
  local tbParam = self:GetPanelParam()
  self.nType = tbParam[1]
  self.selLvId = tbParam[2]
  self.Other = tbParam[3]
  if tbParam[4] ~= nil then
    self.nActId = tbParam[4]
  end
  self.bReview = tbParam[5] == true
  self._mapNode.goLoadMask:SetActive(true)
  self._mapNode.btnSwitch.gameObject:SetActive(false)
  self:SwitchStoryType(false)
  if self.nType == AllEnum.RegionBossFormationType.RegionBoss then
    self.selLvId = PlayerData.RogueBoss:GetSelLvId()
    self.cacheData = PlayerData.RogueBoss:GetCacheBossLevelMsg(self.selLvId)
    self.isHaveTeam = false
    local tempBuildId = PlayerData.RogueBoss:GetSelBuildId()
    self.mbuildId = 0
    if tempBuildId ~= 0 then
      self.mbuildId = tempBuildId
    elseif self.cacheData then
      self.mbuildId = self.cacheData.BuildId
    elseif self.cacheData == nil then
      local tempTab = ConfigTable.GetData("RegionBossLevel", self.selLvId)
      if 1 < tempTab.Difficulty then
        local tempCacheData = PlayerData.RogueBoss:GetCacheBossLevelMsg(tempTab.PreLevelId)
        if tempCacheData then
          self.mbuildId = tempCacheData.BuildId
        end
      end
    end
    if self.cacheData or tempBuildId ~= 0 or self.mbuildId ~= 0 then
      self.isHaveTeam = true
    end
  elseif self.nType == AllEnum.RegionBossFormationType.TravelerDuel then
    local activityLevelsData = PlayerData.Activity:GetActivityDataById(self.Other[1])
    self.mbuildId = activityLevelsData:GetCachedBuildId()
    if self.mbuildId ~= 0 then
      self.isHaveTeam = true
    end
  elseif self.nType == AllEnum.RegionBossFormationType.DailyInstance then
    self.mbuildId = PlayerData.DailyInstance:GetCachedBuildId(self.selLvId)
    if self.mbuildId == 0 then
      local tempTab = ConfigTable.GetData("DailyInstance", self.selLvId)
      if 1 < tempTab.Difficulty then
        local tempId = PlayerData.DailyInstance:GetCachedBuildId(tempTab.PreLevelId)
        if tempId then
          self.mbuildId = tempId
        end
      end
    end
    if self.mbuildId ~= 0 then
      self.isHaveTeam = true
    end
    if not self.bSendGuideMsg then
      EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenDailyInstanceFormation")
      self.bSendGuideMsg = true
    end
  elseif self.nType == AllEnum.RegionBossFormationType.InfinityTower then
    self.mbuildId = 0
    local tempBuildId = PlayerData.InfinityTower:GetCachedBuildId(self.selLvId)
    if tempBuildId ~= 0 then
      self.mbuildId = tempBuildId
    else
      self.mbuildId = PlayerData.InfinityTower:GetSaveBuildId(self.selLvId)
    end
    if self.mbuildId == 0 then
    end
    if self.mbuildId ~= 0 then
      self.isHaveTeam = true
    end
  elseif self.nType == AllEnum.RegionBossFormationType.EquipmentInstance then
    self.mbuildId = PlayerData.EquipmentInstance:GetCachedBuildId(self.selLvId)
    if self.mbuildId == 0 then
      local tempTab = ConfigTable.GetData("CharGemInstance", self.selLvId)
      if 1 < tempTab.Difficulty then
        local tempId = PlayerData.EquipmentInstance:GetCachedBuildId(tempTab.PreLevelId)
        if tempId then
          self.mbuildId = tempId
        end
      end
    end
    if self.mbuildId ~= 0 then
      self.isHaveTeam = true
    end
  elseif self.nType == AllEnum.RegionBossFormationType.Story then
    local mapStoryCfg = PlayerData.Avg:GetStoryCfgData(self.Other)
    local bHasTrial = 0 < mapStoryCfg.TrialBuild
    self.bTrial = LocalData.GetPlayerLocalData("StoryTrialModel")
    if self.bTrial == nil then
      self.bTrial = true
    end
    if bHasTrial == false then
      self.bTrial = false
    end
    LocalData.SetPlayerLocalData("StoryTrialModel", self.bTrial)
    self._mapNode.btnSwitch.gameObject:SetActive(bHasTrial)
    self:SwitchStoryType(self.bTrial)
    if bHasTrial and self.bTrial then
      self.mapTrialBuild = PlayerData.Build:CreateTrialBuild(mapStoryCfg.TrialBuild)
    end
    if self.bTrial then
      self.mbuildId = self.mapTrialBuild.nBuildId
    else
      self.mbuildId = PlayerData.Avg:GetCachedBuildId()
    end
    if self.mbuildId and self.mbuildId ~= 0 then
      self.isHaveTeam = true
    else
      self.isHaveTeam = false
    end
  elseif self.nType == AllEnum.RegionBossFormationType.ScoreBoss then
    self.mbuildId = 0
    local tempBuildId = PlayerData.ScoreBoss:GetCachedBuild(self.selLvId)
    if tempBuildId ~= 0 then
      self.mbuildId = tempBuildId
    else
      self.mbuildId = PlayerData.ScoreBoss:GetLevelBuild(self.selLvId)
    end
    if self.mbuildId == 0 then
    end
    if self.mbuildId ~= 0 then
      self.isHaveTeam = true
    end
  elseif self.nType == AllEnum.RegionBossFormationType.ScoreBoss_GM then
    self.mbuildId = 0
    local tempBuildId = PlayerData.ScoreBoss:GetCachedBuild(self.selLvId)
    if tempBuildId ~= 0 then
      self.mbuildId = tempBuildId
    end
    if self.mbuildId == 0 then
    end
    if self.mbuildId ~= 0 then
      self.isHaveTeam = true
    end
  elseif self.nType == AllEnum.RegionBossFormationType.TraceHunt then
    self.mbuildId = 0
    local tempBuildId = PlayerData.TraceHunt:GetCachedBuild()
    if tempBuildId ~= 0 then
      self.mbuildId = tempBuildId
    end
    if self.mbuildId ~= 0 then
      self.isHaveTeam = true
    end
  elseif self.nType == AllEnum.RegionBossFormationType.SkillInstance then
    self.mbuildId = PlayerData.SkillInstance:GetCachedBuildId(self.selLvId)
    if self.mbuildId == 0 then
      local tempTab = ConfigTable.GetData("SkillInstance", self.selLvId)
      if 1 < tempTab.Difficulty then
        local tempId = PlayerData.SkillInstance:GetCachedBuildId(tempTab.PreLevelId)
        if tempId then
          self.mbuildId = tempId
        end
      end
    end
    if self.mbuildId ~= 0 then
      self.isHaveTeam = true
    end
  elseif self.nType == AllEnum.RegionBossFormationType.WeeklyCopies then
    self.selLvId = PlayerData.RogueBoss:GetSelLvId()
    self.cacheData = PlayerData.RogueBoss:GetCacheWeeklyBuildID(self.selLvId)
    self.isHaveTeam = false
    local tempBuildId = PlayerData.RogueBoss:GetSelBuildId()
    self.mbuildId = 0
    if tempBuildId ~= 0 then
      self.mbuildId = tempBuildId
    elseif self.cacheData then
      self.mbuildId = self.cacheData
    elseif self.cacheData == nil then
      local tempTab = ConfigTable.GetData("WeekBossLevel", self.selLvId)
      if 1 < tempTab.Difficulty then
        local tempCacheData = PlayerData.RogueBoss:GetCacheWeeklyBuildID(tempTab.PreLevelId)
        if tempCacheData then
          self.mbuildId = tempCacheData
        end
      end
    end
    if self.cacheData or tempBuildId ~= 0 or self.mbuildId ~= 0 then
      self.isHaveTeam = true
    end
  elseif self.nType == AllEnum.RegionBossFormationType.ActivityLevels then
    local activityLevelsData = PlayerData.Activity:GetActivityDataById(self.Other[1])
    self.mbuildId = 0
    local tempBuildId = activityLevelsData:GetCachedBuildId(self.selLvId)
    if tempBuildId ~= 0 then
      self.mbuildId = tempBuildId
    else
      self.mbuildId = activityLevelsData:GetLevelBuild(self.selLvId)
    end
    if self.mbuildId == 0 then
    end
    if self.mbuildId ~= 0 then
      self.isHaveTeam = true
    end
  elseif self.nType == AllEnum.RegionBossFormationType.ActivityStory then
    local storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
    local mapStoryCfg = storyData:GetStoryCfgData(self.Other)
    local bHasTrial = 0 < mapStoryCfg.TrialBuild
    self.bTrial = LocalData.GetPlayerLocalData("StoryTrialModel")
    if self.bTrial == nil then
      self.bTrial = true
    end
    if bHasTrial == false then
      self.bTrial = false
    end
    LocalData.SetPlayerLocalData("StoryTrialModel", self.bTrial)
    self._mapNode.btnSwitch.gameObject:SetActive(bHasTrial)
    self:SwitchStoryType(self.bTrial)
    if self.bTrial then
      if self.mapTrialBuild == nil then
        self.mapTrialBuild = PlayerData.Build:CreateTrialBuild(mapStoryCfg.TrialBuild)
        self.mbuildId = self.mapTrialBuild.nBuildId
      else
        self.mbuildId = self.mapTrialBuild.nBuildId
      end
    else
      self.mbuildId = storyData:GetCachedBuildId(self.nActId)
    end
    if self.mbuildId and self.mbuildId ~= 0 then
      self.isHaveTeam = true
    else
      self.isHaveTeam = false
    end
  end
  self.mapCurModel = {}
  local sSceneName = ConfigTable.GetConfigValue("SelectRole_Main")
  if self.nType == AllEnum.RegionBossFormationType.InfinityTower then
    local mapInfLevel = ConfigTable.GetData("InfinityTowerLevel", self.selLvId)
    if mapInfLevel ~= nil then
      local mapDifficuly = ConfigTable.GetData("InfinityTowerDifficulty", mapInfLevel.DifficultyId)
      if mapDifficuly ~= nil then
        local mapInfTower = ConfigTable.GetData("InfinityTower", mapDifficuly.TowerId)
        if mapInfTower ~= nil then
          sSceneName = mapInfTower.FormationSceneName
        end
      end
    end
  end
  
  local function callbak(bSuccess)
    if bSuccess == true then
      local sceneRoot = CS.MainMenuModuleHelper.GetMainMenuSceneRoot(sSceneName)
      self.rtSceneOriginPos = sceneRoot.transform:Find("==== Scene ====")
      self.goSelectRolePrefab = self:CreatePrefabInstance("UI/MainlineFormationEx/SelectRolePrefab.prefab", self.rtSceneOriginPos)
      local goSelectRoleCam = self.goSelectRolePrefab.transform:Find("Camera"):GetComponent("Camera")
      NovaAPI.SetupUIParallaxStageCameraControllerForModelView(self._mapNode.UIParallax3DStage, goSelectRoleCam)
      self._mapNode.goLoadMask:SetActive(false)
      self:Refresh()
    else
      self._mapNode.goLoadMask:SetActive(false)
      self._mapNode.UIParallax3DStage.gameObject:SetActive(false)
      self._mapNode.BGbackup:SetActive(true)
    end
    EventManager.Hit(EventId.SetTransition)
  end
  
  CS.MainMenuModuleHelper.GetActiveScene(sSceneName, callbak)
end

function RegionBossFormationCtrl:OnDisable()
  local sSceneName = ConfigTable.GetConfigValue("SelectRole_Main")
  if self.nType == AllEnum.RegionBossFormationType.InfinityTower then
    local mapInfLevel = ConfigTable.GetData("InfinityTowerLevel", self.selLvId)
    if mapInfLevel ~= nil then
      local mapDifficuly = ConfigTable.GetData("InfinityTowerDifficulty", mapInfLevel.DifficultyId)
      if mapDifficuly ~= nil then
        local mapInfTower = ConfigTable.GetData("InfinityTower", mapDifficuly.TowerId)
        if mapInfTower ~= nil then
          sSceneName = mapInfTower.FormationSceneName
        end
      end
    end
  end
  
  local function callback()
    EventManager.Hit(EventId.SetTransition)
  end
  
  CS.MainMenuModuleHelper.DeActiveScene(sSceneName, callback)
  self:UnbindAllChar()
  if self.goSelectRolePrefab ~= nil then
    destroy(self.goSelectRolePrefab)
  end
end

function RegionBossFormationCtrl:OnDestroy()
end

function RegionBossFormationCtrl:OnBtnClick_AddBuild()
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossBuildBrief, self.nType, self.selLvId, 1, self.Other, self.nActId, self.bReview)
end

function RegionBossFormationCtrl:OnBtnClick_ChangeTeam()
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossBuildBrief, self.nType, self.selLvId, 1, self.Other, self.nActId, self.bReview)
end

function RegionBossFormationCtrl:OnBtnClick_TeamDetails()
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  
  local function callback(mapData)
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildDetail, mapData)
  end
  
  PlayerData.Build:GetBuildDetailData(callback, self.mbuildId)
end

function RegionBossFormationCtrl:OnBtnClick_Attr()
  local mapBuild = self._mapAllBuild[self.mbuildId]
  EventManager.Hit(EventId.OpenPanel, PanelId.BuildAttrPreview, mapBuild.mapRank.Id, mapBuild.nScore)
end

function RegionBossFormationCtrl:OnBtnClick_StorySwitch()
  self.bTrial = not self.bTrial
  LocalData.SetPlayerLocalData("StoryTrialModel", self.bTrial)
  self:SwitchStoryType(self.bTrial)
  if not self.bTrial and self.mapTrialBuild then
    PlayerData.Build:DeleteTrialBuild()
    self.mapTrialBuild = nil
  else
    local mapStoryCfg
    if self.nType == AllEnum.RegionBossFormationType.Story then
      mapStoryCfg = PlayerData.Avg:GetStoryCfgData(self.Other)
    elseif self.nType == AllEnum.RegionBossFormationType.ActivityStory then
      local storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
      mapStoryCfg = storyData:GetStoryCfgData(self.Other)
    end
    if mapStoryCfg then
      self.mapTrialBuild = PlayerData.Build:CreateTrialBuild(mapStoryCfg.TrialBuild)
    end
  end
  if self.bTrial then
    self.mbuildId = self.mapTrialBuild.nBuildId
  elseif self.nType == AllEnum.RegionBossFormationType.Story then
    self.mbuildId = PlayerData.Avg:GetCachedBuildId()
  else
    local storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
    self.mbuildId = storyData:GetCachedBuildId(self.nActId)
  end
  if self.mbuildId and self.mbuildId ~= 0 then
    self.isHaveTeam = true
  else
    self.isHaveTeam = false
  end
  self:Refresh()
end

function RegionBossFormationCtrl:OnBtnClick_Start(btn)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  if self.bStartBattle == true then
    return
  end
  if not self:CheckSelectedLimitedTrialBuild(true) then
    return
  end
  if not self.isHaveTeam or self.mbuildId == nil or self.mbuildId == 0 then
    return
  end
  self.bStartBattle = true
  if self.nType == AllEnum.RegionBossFormationType.RegionBoss then
    self:OpenRegionBoss()
  elseif self.nType == AllEnum.RegionBossFormationType.TravelerDuel then
    self:OpenTravelerDuel()
  elseif self.nType == AllEnum.RegionBossFormationType.DailyInstance then
    self:OpenDailyInstance()
  elseif self.nType == AllEnum.RegionBossFormationType.InfinityTower then
    self:OpenInfinityTower()
  elseif self.nType == AllEnum.RegionBossFormationType.EquipmentInstance then
    self:OpenEquipmentInstance()
  elseif self.nType == AllEnum.RegionBossFormationType.Story then
    self:OpenStoryBattle()
  elseif self.nType == AllEnum.RegionBossFormationType.ScoreBoss then
    local function callBack(otherLevelId)
      if #otherLevelId == 0 then
        self:OpenScoreBossBattle()
        
        NovaAPI.SetEntryLevelFade(true)
      else
        local function ConfirmCb()
          self:OpenScoreBossBattle()
          
          NovaAPI.SetEntryLevelFade(true)
        end
        
        local function CancelCb()
          self.bStartBattle = false
        end
        
        EventManager.Hit(EventId.OpenPanel, PanelId.ScoreBossClearBD, otherLevelId, ConfirmCb, CancelCb)
        return
      end
    end
    
    PlayerData.ScoreBoss:JudgeOtherLevelHaveSameChar(self.selLvId, self.mbuildId, callBack)
  elseif self.nType == AllEnum.RegionBossFormationType.ScoreBoss_GM then
    self:OpenScoreBossBattle_GM()
  elseif self.nType == AllEnum.RegionBossFormationType.TraceHunt then
    self:OpenTraceHuntBattle()
  elseif self.nType == AllEnum.RegionBossFormationType.SkillInstance then
    self:OpenSkillInstance()
  elseif self.nType == AllEnum.RegionBossFormationType.WeeklyCopies then
    self:OpenWeeklyCopies()
  elseif self.nType == AllEnum.RegionBossFormationType.ActivityLevels then
    self:OpenActivityLevelsBattle()
  elseif self.nType == AllEnum.RegionBossFormationType.ActivityStory then
    self:OpenActivityStoryBattle()
  end
  NovaAPI.SetEntryLevelFade(true)
end

function RegionBossFormationCtrl:OnEvent_Back(nPanelId)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PlayerData.DailyInstance:SetSelBuildId(0)
  if self.mapTrialBuild then
    PlayerData.Build:DeleteTrialBuild()
  end
  
  local function OpenCallback()
    EventManager.Hit(EventId.CloesCurPanel)
  end
  
  EventManager.Hit(EventId.SetTransition, 5, OpenCallback)
end

function RegionBossFormationCtrl:OnEvent_BackHome(nPanelId)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.nType == AllEnum.RegionBossFormationType.InfinityTower then
    PlayerData.InfinityTower:SetPageState(1)
  end
  PlayerData.DailyInstance:SetSelBuildId(0)
  if self.mapTrialBuild then
    PlayerData.Build:DeleteTrialBuild()
  end
  
  local function OpenCallback()
    PanelManager.Home()
  end
  
  EventManager.Hit(EventId.SetTransition, 5, OpenCallback)
end

function RegionBossFormationCtrl:OnEvent_NewDay()
  if not self.bStartBattle then
    self:CheckSelectedLimitedTrialBuild(true)
  end
end

function RegionBossFormationCtrl:OnEvent_OpenMessageBox()
  self.bStartBattle = false
end

return RegionBossFormationCtrl
