require("battle_enter_system")
_class("ClientBattleEnterSystem_Render", BattleEnterSystem)
ClientBattleEnterSystem_Render = ClientBattleEnterSystem_Render

function ClientBattleEnterSystem_Render:_DoRenderShowBattleEnter(TT, teamEntity)
  local battleSvcR = self._world:GetService("RenderBattle")
  battleSvcR:SetGlobalOutLine(false)
  local goEffRuchangActorpoint = UnityEngine.GameObject.Find(GameResourceConst.EffRuchangActorpoint)
  if goEffRuchangActorpoint then
    self.world:MainCamera():SetGoEffRuchangActorpoint(goEffRuchangActorpoint)
    goEffRuchangActorpoint:SetActive(false)
    local camera = goEffRuchangActorpoint:GetComponentInChildren(typeof(UnityEngine.Camera), true)
    if camera then
      local fov = camera.fieldOfView
      local defaultAspect = BattleConst.CameraDefaultAspect
      local aspect = UnityEngine.Screen.width / UnityEngine.Screen.height
      if defaultAspect > aspect then
        fov = fov + (defaultAspect - aspect) * BattleConst.BattleEnterIntroPresentation_CameraFovMultiplier
      end
      camera.fieldOfView = fov
    end
  elseif self._world:IsDevelopEnv() then
    local testRobot = GameGlobal.GetModule(TestRobotModule)
    if testRobot and testRobot.m_bEnableRobot then
      YIELD(TT, 1000)
      goEffRuchangActorpoint = UnityEngine.GameObject.Find(GameResourceConst.EffRuchangActorpoint)
      if not goEffRuchangActorpoint then
        Log.exception("没有找到入场运镜动画节点：eff_ruchang_actorpoint，需要美术检查对应的场景资源")
      end
    else
      Log.exception("没有找到入场运镜动画节点：eff_ruchang_actorpoint，需要美术检查对应的场景资源")
    end
  end
  local cRenderBoard = self._world:GetRenderBoardEntity():RenderBoard()
  local sceneRoot = GameObjectHelper.Find("SceneRoot")
  cRenderBoard:SetSceneGO(sceneRoot)
  if teamEntity then
    self:BlinkMainCamera(false)
  end
  if self._world:MatchType() ~= MatchType.MT_Chess then
    local cHP = teamEntity:HP()
    cHP:SetHPPosDirty(true)
    cHP:SetHPBarTempHide(true)
  end
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local team = self._world:Player():GetRemoteTeamEntity()
    team:HP():SetHPPosDirty(true)
    team:HP():SetHPBarTempHide(true)
  end
  local darkParamName = "H3DDarkLevel"
  UnityEngine.Shader.SetGlobalFloat(darkParamName, 0)
  local pieceService = self._world:GetService("Piece")
  pieceService:Initialize()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  self:_InitRoundCountUI(levelConfigData:GetLevelRoundCount())
  self._isStoryEnd = false
  local gameStartType = UIHelper.GameStartType()
  if gameStartType == EGameStartType.SkillEditor then
    self._isStoryEnd = true
    self:_DoPostStory(TT)
    return
  end
  local match = GameGlobal.GetModule(MatchModule)
  local story, isActive, isStage1, isStage1Fail = self:_GetStoryByEnterData(match:GetMatchEnterData())
  if story and not isStage1 and not isActive then
    GameGlobal.UIStateManager():ShowDialog("UIStoryController", story.id, function()
      local login_module = GameGlobal.GetModule(LoginModule)
      if login_module:IsInFirstStory() then
        GameGlobal.ReportCustomEvent("CreateRole", "ContinueEnterGame")
      end
      self._isStoryEnd = true
      self:ActiveStory()
      self:_PlayEnterBgm()
      GameGlobal.UIStateManager():SetBlackSideVisible(false)
    end, false, false)
  else
    self:_PlayEnterBgm()
    self._isStoryEnd = true
  end
  self:_DoPostStory(TT)
end

function ClientBattleEnterSystem_Render:_PlayTerrainAbyssAppearSkill(TT)
  local group = self.world:GetGroup(self.world.BW_WEMatchers.Trap)
  local eTraps = group:GetEntities()
  local terrainAbyssEntityList = {}
  for k, entity in pairs(eTraps) do
    local trapRenderComponent = entity:TrapRender()
    if trapRenderComponent:GetTrapType() == TrapType.TerrainAbyss then
      table.insert(terrainAbyssEntityList, entity)
    end
  end
  local trapServiceRender = self._world:GetService("TrapRender")
  local taskID = GameGlobal.TaskManager():CoreGameStartTask(trapServiceRender.ShowTraps, trapServiceRender, terrainAbyssEntityList)
  return taskID
end

function ClientBattleEnterSystem_Render:_PlayEnterBgm()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local bgmID = levelConfigData:GetBgmID()
  if bgmID == 0 then
    Log.fatal("关卡 id:" .. levelConfigData:GetLevelID() .. " 未配置BGM!")
    return
  end
  AudioHelperController.PlayBGMById(bgmID)
end

function ClientBattleEnterSystem_Render:_InitializeGuide()
  local sEntity = self._world:GetService("RenderEntity")
  sEntity:CreateRenderEntity(EntityConfigIDRender.GuideFinger)
end

function ClientBattleEnterSystem_Render:_GetStoryByEnterData(enterData)
  local story
  local isActive = false
  local isStage1 = false
  local isStage1Fail = false
  if MatchType.MT_Mission == enterData._match_type then
    local mission = GameGlobal.GetModule(MissionModule)
    local missionID = enterData:GetMissionCreateInfo().mission_id
    isStage1 = Cfg.cfg_global.stage_1_id.IntValue == missionID
    isStage1Fail = mission:GetCurMissionID() == 0
    local discoveryData = mission:GetDiscoveryData()
    story = discoveryData:GetStoryByStageIdStoryType(missionID, StoryTriggerType.BeforeFight)
    isActive = mission:IsMissionStoryActive(missionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
  elseif MatchType.MT_ExtMission == enterData._match_type then
    local extTaskID = enterData:GetMissionCreateInfo().m_nExtTaskID
    local cfg_extra_mission_story = Cfg.cfg_extra_mission_story({ExtMissionTaskID = extTaskID})[1]
    if cfg_extra_mission_story then
      for i = 1, table.count(cfg_extra_mission_story.StoryID) do
        if cfg_extra_mission_story.StoryActiveType[i] == StoryTriggerType.BeforeFight then
          local extMissionStory = DiscoveryStory:New()
          extMissionStory:Init(cfg_extra_mission_story.StoryID[i], cfg_extra_mission_story.StoryActiveType[i])
          local extMissionModule = GameGlobal.GetModule(ExtMissionModule)
          isActive = extMissionModule:IsMissionStoryActive(extTaskID, ActiveStoryType.ActiveStoryType_BeforeBattle)
          story = extMissionStory
          break
        end
      end
    end
  elseif MatchType.MT_Campaign == enterData._match_type then
    local mission = GameGlobal.GetModule(MissionModule)
    local missionID = enterData:GetCampaignMissionInfo().nCampaignMissionId
    story = {}
    story.id = mission:GetStoryByStageIdStoryType(missionID, StoryTriggerType.BeforeFight)
    if not story.id then
      story = nil
    end
    isActive = mission:IsMissionStoryActive(missionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
  elseif MatchType.MT_TalePet == enterData._match_type then
    local mission = GameGlobal.GetModule(MissionModule)
    local info = enterData:GetTalePetMissionInfo()
    local missionID = info.nId
    story = {}
    story.id = mission:GetStoryByStageIdStoryType(missionID, StoryTriggerType.BeforeFight)
    if not story.id then
      story = nil
    end
    isActive = mission:IsMissionStoryActive(missionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
  elseif MatchType.MT_Season == enterData._match_type then
    local mission = GameGlobal.GetModule(MissionModule)
    local missionID = enterData:GetSeasonMissionInfo().mission_id
    story = {}
    story.id = mission:GetStoryByStageIdStoryType(missionID, StoryTriggerType.BeforeFight)
    if not story.id then
      story = nil
    end
    isActive = mission:IsMissionStoryActive(missionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
  end
  return story, isActive, isStage1, isStage1Fail
end

function ClientBattleEnterSystem_Render:ActiveStory()
  local match = GameGlobal.GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  if enterData._match_type == MatchType.MT_Mission then
    local mission = GameGlobal.GetModule(MissionModule)
    local missionID = enterData:GetMissionCreateInfo().mission_id
    GameGlobal.TaskManager():CoreGameStartTask(function()
      mission:SetMissionStoryActive(self, missionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
    end)
  elseif enterData._match_type == MatchType.MT_ExtMission then
    local exrMissionModule = GameGlobal.GetModule(ExtMissionModule)
    local extTaskID = enterData:GetMissionCreateInfo().m_nExtTaskID
    GameGlobal.TaskManager():CoreGameStartTask(function()
      exrMissionModule:SetMissionStoryActive(self, extTaskID, ActiveStoryType.ActiveStoryType_BeforeBattle)
    end)
  elseif enterData._match_type == MatchType.MT_Campaign then
    local mission = GameGlobal.GetModule(MissionModule)
    local missionID = enterData:GetCampaignMissionInfo().nCampaignMissionId
    GameGlobal.TaskManager():CoreGameStartTask(function()
      mission:SetMissionStoryActive(self, missionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
    end)
  elseif enterData._match_type == MatchType.MT_TalePet then
    local mission = GameGlobal.GetModule(MissionModule)
    local info = enterData:GetTalePetMissionInfo()
    local missionID = info.nId
    GameGlobal.TaskManager():CoreGameStartTask(function()
      mission:SetMissionStoryActive(self, missionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
    end)
  elseif enterData._match_type == MatchType.MT_Season then
    local mission = GameGlobal.GetModule(MissionModule)
    local missionID = enterData:GetSeasonMissionInfo().mission_id
    local useMissionCfg = Cfg.cfg_season_mission[missionID]
    local secondMissionId
    if useMissionCfg then
      local secondMissionCfg
      local missionGroupId = useMissionCfg.GroupID
      local missionGroupCfgs = Cfg.cfg_season_mission({GroupID = missionGroupId})
      if 0 < #missionGroupCfgs then
        for index, value in ipairs(missionGroupCfgs) do
          if value.OrderID ~= useMissionCfg.OrderID then
            secondMissionCfg = value
            secondMissionId = value.ID
            break
          end
        end
      end
    end
    GameGlobal.TaskManager():CoreGameStartTask(function()
      mission:SetMissionStoryActive(self, missionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
      if secondMissionId then
        mission:SetMissionStoryActive(self, secondMissionId, ActiveStoryType.ActiveStoryType_BeforeBattle)
      end
    end)
  end
end

function ClientBattleEnterSystem_Render:_DoPostStory(TT)
  local collector = GameGlobal:GetInstance():GetCollector("CoreGameLoading")
  while self._isStoryEnd == false do
    YIELD(TT)
  end
  local role = GameGlobal.GetModule(RoleModule)
  local success = role:OnEndStory(TT, 0, 0, 0, 0, 0, 1)
  if not GameSingle and not success then
    return
  end
  collector:Sample("ClientBattleEnterSystem_Render:_DoPostStory() begin")
  local match = GameGlobal.GetModule(MatchModule)
  if GameGlobal.UIStateManager():IsShow("UIBattle") then
    local uiBattle = GameGlobal.UIStateManager():GetController("UIBattle")
    if uiBattle then
      uiBattle:ResetLayout(TT)
    end
  end
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIBattle)
  while GameGlobal.UIStateManager():IsShow("UIBattle") == false do
    YIELD(TT)
  end
  GameGlobal.UIStateManager():SetBlackSideVisible(true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, false)
  collector:Sample("ClientBattleEnterSystem_Render:ShowUIBattle()")
  collector:Dump()
  local guideService = self._world:GetService("Guide")
  local guideTaskId = guideService:Trigger(GameEventType.GuideBattleStart)
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
  local innerStoryService = self._world:GetService("InnerStory")
  if innerStoryService:CheckStoryBanner(StoryShowType.BeginAfterCreateScene) then
    self:BlinkMainCamera(true)
    InnerGameHelperRender:GetInstance():IsUIBannerComplete(TT)
  end
end

function ClientBattleEnterSystem_Render:_CreateFinalAttackEffect()
  local sEntity = self._world:GetService("RenderEntity")
  local effectEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.FinalAttackEffect)
  local resPath = "eff_finalatk.prefab"
  effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(resPath, false))
end

function ClientBattleEnterSystem_Render:_InitRoundCountUI(waveRoundCount)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.InitRoundCount, waveRoundCount)
end

function ClientBattleEnterSystem_Render:_DoRenderShowBoard(TT, pieceRefreshType, fallingDir)
  self:_BoardShow(TT)
  YIELD(TT)
  if pieceRefreshType == PieceRefreshType.FallingDown then
    local utilDataSvc = self._world:GetService("UtilData")
    local curMaxX = utilDataSvc:GetCurBoardMaxX()
    local curMaxY = utilDataSvc:GetCurBoardMaxY()
    local curCenterPos = utilDataSvc:GetBoardCenterPos()
    local effPosGroup = {
      [1] = {
        curMaxX + 1,
        curCenterPos.y
      },
      [2] = {
        curCenterPos.x,
        0
      },
      [3] = {
        curMaxX + 1,
        curCenterPos.y
      },
      [4] = {
        curCenterPos.x,
        0
      }
    }
    local sEffect = self._world:GetService("Effect")
    local effId = BattleConst.FallGridDirDefaultEffectId
    local effPos = Vector2(0, 0)
    local dir = Vector2(fallingDir.x, fallingDir.y)
    if dir.x == 0 and dir.y == 1 then
      local cfgPos = effPosGroup[1]
      effPos = Vector2(cfgPos[1], cfgPos[2])
    elseif dir.x == 1 and dir.y == 0 then
      local cfgPos = effPosGroup[2]
      effPos = Vector2(cfgPos[1], cfgPos[2])
    elseif dir.x == 0 and dir.y == -1 then
      local cfgPos = effPosGroup[3]
      effPos = Vector2(cfgPos[1], cfgPos[2])
    elseif dir.x == -1 and dir.y == 0 then
      local cfgPos = effPosGroup[4]
      effPos = Vector2(cfgPos[1], cfgPos[2])
    end
    sEffect:CreateWorldPositionDirectionEffect(effId, effPos, dir)
  end
end

function ClientBattleEnterSystem_Render:_BoardShow(TT)
  local innerStoryService = self._world:GetService("InnerStory")
  if innerStoryService:CheckStoryBanner(StoryShowType.BeginAfterBoardShow) then
    self:BlinkMainCamera(true)
    InnerGameHelperRender:GetInstance():IsUIBannerComplete(TT)
    self:BlinkMainCamera(false)
  end
end

function ClientBattleEnterSystem_Render:UnloadEffect(poolSvc, effSvc, effectid)
  local effResPath = effSvc:GetEffectResPath(effectid)
  if effResPath then
    poolSvc:DestroyCache(effResPath)
  end
end

function ClientBattleEnterSystem_Render:_DoRenderShowPet(TT, teamEntity)
  local utilDataSvc = self._world:GetService("UtilData")
  local boardServiceRender = self._world:GetService("BoardRender")
  local sCamera = self._world:GetService("Camera")
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  if teamEntity then
    self._teamLeader = teamEntity:GetTeamLeaderPetEntity()
    self._petEntities = teamEntity:Team():GetTeamPetEntities()
    self._posLeader = boardServiceRender:GetRealEntityGridPos(self._teamLeader)
    self._dirLeader = self._teamLeader:Location():GetDirection():Clone()
    local matchType = self._world:MatchType()
    if matchType == MatchType.MT_EightPets or self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
      self._arrPos = {
        Vector2(2, 1),
        Vector2(3, 1),
        Vector2(4, 1),
        Vector2(5, 1),
        Vector2(6, 1),
        Vector2(7, 1),
        Vector2(8, 1)
      }
    else
      self._arrPos = {
        Vector2(6, 1),
        Vector2(4, 1),
        Vector2(7, 1),
        Vector2(3, 1)
      }
    end
    for index, arrPos in ipairs(self._arrPos) do
      if arrPos == self._posLeader then
        self._arrPos[index] = Vector2(5, 1)
        break
      end
    end
    self._ePets = self:GetTeamMember(teamEntity)
    local tplID = self:GetPetEntityTemplateID(self._teamLeader)
    local pm = GameGlobal.GetModule(PetAudioModule)
    InnerGameHelperRender.InnerGamePlayPetUIVoice("TeamLeaderAppear", tplID)
    local matchModule = GameGlobal.GetModule(MatchModule)
    if matchType == MatchType.MT_EightPets or self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze or matchModule:IsQuickReStartMatch() then
      self._teamLeader:SetViewVisible(true)
      for i, entity in ipairs(self._ePets) do
        entity:SetViewVisible(true)
      end
    else
      self:PlayBattleEnterSkillView(TT)
      self:PlayPetFaceAnim(teamEntity)
      self:PlayFocus(TT)
      self:HideStageEffect(TT)
    end
  end
  sMonsterShowRender:PullDownNotLoadHighMonsters()
  self:_PlayTerrainAbyssAppearSkill(TT)
  if teamEntity then
    self:PetsStandBy()
    sCamera:BlinkMainCamera(true)
    self:PlayDarkEffect()
    self:PlayCameraAnimation(TT)
  end
  local spawnPieceServiceRender = self._world:GetService("SpawnPieceRender")
  spawnPieceServiceRender:PlayBoardShow(TT)
  if teamEntity then
    local gridLocCmpt = self._teamLeader:GridLocation()
    local playerPos = gridLocCmpt:GetGridPos()
    local utilDataSvc = self._world:GetService("UtilData")
    if utilDataSvc:CanChangePieceToGray() then
      boardServiceRender:ReCreateGridEntity(PieceType.None, playerPos)
    end
  end
  self:CheckStoryTips(TT)
  if teamEntity then
    local isArchived = utilDataSvc:IsArchivedBattle()
    if not isArchived or table.count(self._ePets) > 0 then
      self:PlayLightBallFly(TT)
      self:ResetPetsPos(TT)
    end
  end
  local cameraCmpt = self._world:MainCamera()
  cameraCmpt:_MoveCameraToNormal()
  if teamEntity then
    self:ShowHPSlider(TT, teamEntity)
  end
  if self._world:MatchType() == MatchType.MT_BlackFist then
    self:ShowRemotePlayer(TT)
  elseif self._world:MatchType() == MatchType.MT_Chess then
    self:ShowChessPet(TT)
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayAutoAddBuff()
end

function ClientBattleEnterSystem_Render:ShowRemotePlayer(TT)
  local boardServiceRender = self._world:GetService("BoardRender")
  local remoteTeamEntity = self._world:Player():GetRemoteTeamEntity()
  local gridLocCmpt = remoteTeamEntity:GridLocation()
  local playerPos = gridLocCmpt:GetGridPos()
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:CanChangePieceToGray() then
    boardServiceRender:ReCreateGridEntity(PieceType.None, playerPos)
  end
  self:ShowHPSlider(TT, remoteTeamEntity)
  local pets = remoteTeamEntity:Team():GetTeamPetEntities()
  local leader = remoteTeamEntity:Team():GetTeamLeaderEntity()
  local posLeader = boardServiceRender:GetRealEntityGridPos(leader)
  local dirLeader = leader:Location():GetDirection():Clone()
  for i, v in ipairs(pets) do
    v:SetLocation(posLeader, dirLeader)
    if v == leader then
      v:SetViewVisible(true)
    else
      v:SetViewVisible(false)
    end
  end
  local matchPet = leader:MatchPet():GetMatchPet()
  local bossIds = SortedArray:New()
  bossIds:Insert({
    HPBarType = HPBarType.BlackFist,
    pstId = remoteTeamEntity:GetID(),
    tplId = matchPet:GetTemplateID(),
    isVice = false,
    matchPet = matchPet,
    hpEnergyVal = 0,
    maxHPEnergyVal = 0
  })
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowBossHp, bossIds)
end

function ClientBattleEnterSystem_Render:ShowChessPet(TT)
  local group = self.world:GetGroup(self.world.BW_WEMatchers.ChessPetRender)
  local chessPetEntitys = group:GetEntities()
  for i, v in ipairs(chessPetEntitys) do
    v:SetViewVisible(true)
    self:ShowHPSlider(TT, v)
    v:ReplaceHPComponent()
  end
end

function ClientBattleEnterSystem_Render:PlayBattleEnterSkillView(TT)
  local sPlaySkill = self._world:GetService("PlaySkill")
  for id, entity in ipairs(self._petEntities) do
    local viewCmpt = entity:View()
    if viewCmpt == nil or viewCmpt:GetGameObject() == nil then
      local assetCmpt = entity:Asset()
      local resPath = assetCmpt:GetResPath()
      Log.exception("Pet resource load failed:", resPath)
    end
    local goName = entity:View():GetGameObject().name
    local cfgBattleEnterSkillId = Cfg.cfg_pet_battle_enter_skill[goName]
    local battleEnterSkillId
    if entity:GetID() == self._teamLeader:GetID() then
      if cfgBattleEnterSkillId then
        battleEnterSkillId = cfgBattleEnterSkillId.TeamLeaderSkillID
      else
        battleEnterSkillId = Cfg.cfg_pet_battle_enter_skill["0"].TeamLeaderSkillID
      end
    elseif cfgBattleEnterSkillId then
      battleEnterSkillId = cfgBattleEnterSkillId.TeamMemberSkillID
    end
    if battleEnterSkillId then
      sPlaySkill:PlaySkillView(entity, battleEnterSkillId)
    end
  end
end

local function _createV4FromV3(v3)
  local v4 = Vector4.zero
  v4.x = v3.x
  v4.y = v3.y
  v4.z = v3.z
  v4.w = 1
  return v4
end

function ClientBattleEnterSystem_Render:PlayFocus(TT)
  local match = GameGlobal.GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  if enterData._match_type == MatchType.MT_Mission then
    local missionID = enterData:GetMissionCreateInfo().mission_id
    if missionID and self._ePets then
      local l_pet_array = "" .. self._teamLeader:PetPstID():GetTemplateID()
      for key, value in pairs(self._ePets) do
        l_pet_array = l_pet_array .. "," .. value:PetPstID():GetTemplateID()
      end
      GameGlobal.UAReportForceGuideEvent("MissionShowPet", {missionID, l_pet_array})
    end
  end
  local goEffRuchangActorpoint = self.world:MainCamera():GetGoEffRuchangActorpoint()
  if not goEffRuchangActorpoint then
    Log.fatal("Can not find actor point.")
    return
  end
  local goRenderSetting = UnityEngine.GameObject.Find("[H3DRenderSetting]")
  local csRenderSetting = goRenderSetting:GetComponent("H3DRenderSetting")
  if csRenderSetting.CustomLight and csRenderSetting.CustomShadow then
    csRenderSetting.CustomLight.forward = csRenderSetting.CustomLightForwardIntro
    csRenderSetting.CustomShadow.forward = csRenderSetting.CustomShadowForwardIntro
    UnityEngine.Shader.SetGlobalVector("_H3D_CustomLightDir", _createV4FromV3(csRenderSetting.CustomLightForwardIntro))
    UnityEngine.Shader.SetGlobalVector("_H3D_CustomShadowDir", _createV4FromV3(csRenderSetting.CustomShadowForwardIntro))
  end
  goEffRuchangActorpoint:SetActive(true)
  local anim = goEffRuchangActorpoint:GetComponent("Animation")
  anim:Play()
  local trans = {}
  local tranLeader = self._teamLeader:View():GetGameObject().transform
  table.insert(trans, tranLeader)
  for i, e in ipairs(self._ePets) do
    if e then
      local tranPet = e:View():GetGameObject().transform
      table.insert(trans, tranPet)
    end
  end
  for index, tran in ipairs(trans) do
    local tranChild = GameObjectHelper.FindChild(goEffRuchangActorpoint.transform, tostring(index))
    tran:SetParent(tranChild)
    tran.localPosition = Vector3.zero
    tran.localRotation = Quaternion.identity
  end
  YIELD(TT, GameResourceConst.AnimRuchangCameratempLen)
  for index, tran in ipairs(trans) do
    tran:SetParent(goEffRuchangActorpoint.transform.parent)
    tran.localPosition = Vector3.zero
    tran.localRotation = Quaternion.identity
  end
  goEffRuchangActorpoint:SetActive(false)
  if csRenderSetting.CustomLight and csRenderSetting.CustomShadow then
    csRenderSetting.CustomLight.forward = csRenderSetting.CustomLightForwardBattle
    csRenderSetting.CustomShadow.forward = csRenderSetting.CustomShadowForwardBattle
    UnityEngine.Shader.SetGlobalVector("_H3D_CustomLightDir", _createV4FromV3(csRenderSetting.CustomLightForwardBattle))
    UnityEngine.Shader.SetGlobalVector("_H3D_CustomShadowDir", _createV4FromV3(csRenderSetting.CustomShadowForwardBattle))
  end
end

function ClientBattleEnterSystem_Render:PlayDarkEffect()
  local sEffect = self._world:GetService("Effect")
  sEffect:CreateScreenEffPointEffect(GameResourceConst.EffRuchangBlackboard)
end

function ClientBattleEnterSystem_Render:PetsStandBy()
  self._teamLeader:SetLocation(self._posLeader, self._dirLeader)
  local arrDir = {
    Vector2(0, 1),
    Vector2(0, 1),
    Vector2(0, 1),
    Vector2(0, 1)
  }
  for i, e in ipairs(self._ePets) do
    if e then
      e:SetLocation(self._arrPos[i], arrDir[i])
    end
  end
end

function ClientBattleEnterSystem_Render:CheckStoryTips(TT)
  local innerStoryService = self._world:GetService("InnerStory")
  innerStoryService:CheckStoryTips(StoryShowType.BeginAfterMasterShowBeginTeamShow)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuidePlayerShow)
end

function ClientBattleEnterSystem_Render:HideStageEffect(TT)
  local goStageEffect = GameObjectHelper.Find("StageEffect")
  if goStageEffect then
    local tran = GameObjectHelper.FindChild(goStageEffect.transform, "ruchang_eff")
    if tran then
      tran.gameObject:SetActive(false)
    else
      Log.fatal("### ruchang_eff is not under StageEffect.")
    end
  else
    Log.warn("### no GameObject named [StageEffect] in scene.")
  end
  self._world:RenderBattleStat():SetActorOutLineState(true)
  local battleSvcR = self._world:GetService("RenderBattle")
  battleSvcR:SetGlobalOutLine(true)
  battleSvcR:SetAllViewOutLine()
end

function ClientBattleEnterSystem_Render:ResetPetsPos(TT)
  for i, v in ipairs(self._ePets) do
    if v then
      v:SetPosition(self._posLeader)
    end
  end
end

function ClientBattleEnterSystem_Render:GetTeamMember(teamEntity)
  local teamMember = {}
  local teamLeaderPetPstID = teamEntity:Team():GetTeamLeaderPetPstID()
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, e in ipairs(pets) do
    local petPstIDCmpt = e:PetPstID()
    if petPstIDCmpt:GetPstID() ~= teamLeaderPetPstID then
      teamMember[#teamMember + 1] = e
    end
  end
  return teamMember
end

function ClientBattleEnterSystem_Render:PlayLightBallFly(TT)
  local entityService = self._world:GetService("RenderEntity")
  local effectService = self._world:GetService("Effect")
  local boardServiceRender = self._world:GetService("BoardRender")
  for i, v in ipairs(self._ePets) do
    effectService:CreateWorldPositionEffect(GameResourceConst.EffRuchuangPetBao, self._arrPos[i])
  end
  YIELD(TT, 50)
  for i, v in ipairs(self._ePets) do
    if v then
      v:SetViewVisible(false)
    end
  end
  local eBalls = {}
  for i, v in ipairs(self._ePets) do
    if not v then
      return
    end
    local gridLoc = v:GridLocation()
    if not gridLoc then
      return
    end
    local position = boardServiceRender:GetRealEntityGridPos(v)
    local eBall = entityService:CreateRenderEntity(EntityConfigIDRender.Projectile)
    eBall:ReplaceAsset(NativeUnityPrefabAsset:New("eff_ruchuang_guiji.prefab", false))
    eBall:SetPosition(position)
    table.insert(eBalls, eBall)
  end
  local tranLeader = self._teamLeader:View():GetGameObject().transform
  local flyDuration = 400
  local arrCtrlNode = {
    [1] = {
      Vector3(0.1, 0.3, 0.2)
    },
    [2] = {
      Vector3(0, 0.1, 0)
    },
    [3] = {
      Vector3(0, 0.1, 0)
    },
    [4] = {
      Vector3(-0.1, 0.1, -0.1),
      Vector3(0.2, 0.2, 0.2)
    }
  }
  local height = Vector3(0, 0.6, 0)
  for i, v in ipairs(eBalls) do
    v:SetViewVisible(true)
    local view = v:View()
    if not view then
      return
    end
    local tranBall = view.ViewWrapper.GameObject.transform
    tranBall.position = tranBall.position + height
    local path = {
      tranBall.position
    }
    if arrCtrlNode[i] then
      for j, vj in ipairs(arrCtrlNode[i]) do
        table.insert(path, tranBall.position + height + vj)
      end
    end
    table.insert(path, tranLeader.position + height)
    tranBall:DOPath(path, flyDuration * 0.001, DG.Tweening.PathType.CatmullRom, DG.Tweening.PathMode.Full3D, 10, Color.red):SetEase(DG.Tweening.Ease.InCubic):OnComplete(function()
      self._world:DestroyEntity(v)
    end)
  end
  YIELD(TT, flyDuration)
  effectService:CreateWorldPositionEffect(GameResourceConst.EffRuchuangHeti, self._posLeader)
end

function ClientBattleEnterSystem_Render:ShowHPSlider(TT, teamEntity)
  local cHP = teamEntity:HP()
  local hpSliderEntityID = cHP:GetHPSliderEntityID()
  local eHPBar = self._world:GetEntityByID(hpSliderEntityID)
  if not eHPBar then
    return
  end
  cHP:SetHPPosDirty(true)
  cHP:SetHPBarTempHide(false)
  local go = eHPBar:View():GetGameObject()
  local uiview = go:GetComponent("UIView")
  local buffRootPath = uiview:GetUIComponent("UISelectObjectPath", "buffRoot")
  if buffRootPath then
    local buffRoot = UICustomWidgetPool:New(self, buffRootPath)
    buffRoot:SpawnObjects("UIHPBuffInfo", 1)
    local uiHPBuffInfo = buffRoot:GetAllSpawnList()[1]
    uiHPBuffInfo:SetData(teamEntity:GetID())
    cHP:SetUIHpBuffInfoWidget(buffRoot)
  end
end

function ClientBattleEnterSystem_Render:PlayCameraAnimation(TT)
  local match = GameGlobal.GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  if enterData._match_type == MatchType.MT_Mission then
    local missionID = enterData:GetMissionCreateInfo().mission_id
    GameGlobal.UAReportForceGuideEvent("MissionRefreshRoad", {missionID})
  end
  local levelID = self._world.BW_WorldInfo.level_id
  local levelConfig = Cfg.cfg_level[levelID]
  local themeID = levelConfig.Theme
  local cfgThemeData = Cfg.cfg_theme[themeID]
  if not cfgThemeData then
    Log.error("关卡theme配置无效: ", tostring(themeID))
    return
  end
  local camera = self._world:MainCamera():Camera()
  if cfgThemeData.BoardShowCameraAnimationMode and cfgThemeData.BoardShowCameraAnimationMode == 1 then
    local configService = self._world:GetService("Config")
    local levelConfigData = configService:GetLevelConfigData()
    local cameraParam = levelConfigData:GetCameraParam()
    local originalCameraPos = cameraParam:GetCameraPosition()
    local tweener = camera.gameObject.transform:DOMove(originalCameraPos, BattleConst.BoardShowCameraAnimationByScript_TweenTime):SetEase(DG.Tweening.Ease.OutExpo)
    YIELD(TT, BattleConst.BoardShowCameraAnimationByScript_TweenTime * 1000)
  else
    local animation = camera.gameObject:GetComponent(typeof(UnityEngine.Animation))
    if animation and animation.clip then
      animation:Play()
      YIELD(TT, animation.clip.length * 1000)
    else
      Log.fatal("### no animation on camera.")
    end
  end
end

function ClientBattleEnterSystem_Render:GetPetEntityTemplateID(petEntity)
  return petEntity:PetPstID():GetTemplateID()
end

local DirType = {Row = 1, Col = 2}

function ClientBattleEnterSystem_Render:SortGridList(gridList, dir)
  local tmp = {}
  for k, v in pairs(gridList) do
    tmp[#tmp + 1] = v:GetGridPosition():Clone()
  end
  
  local function CmpRow(a, b)
    return a.y > b.y
  end
  
  local function CmpCol(a, b)
    return a.x > b.x
  end
  
  if dir == DirType.Row then
    table.sort(tmp, CmpCol)
  end
  if dir == DirType.Col then
    table.sort(tmp, CmpRow)
  end
  return tmp
end

function ClientBattleEnterSystem_Render:GetGridSizeAndCenterPos(gridEntityList, dir)
  local gridCount = table.count(gridEntityList)
  local numberType = gridCount % 2
  local gridList = self:SortGridList(gridEntityList, dir)
  local centerIndex = math.floor(gridCount / 2)
  if numberType == 1 then
    centerIndex = centerIndex + 1
  end
  local centerPos = gridList[centerIndex]
  if numberType == 0 then
    if dir == DirType.Col then
      centerPos = Vector2(centerPos.x, centerPos.y - 0.5)
    elseif dir == DirType.Row then
      centerPos = Vector2(centerPos.x - 0.5, centerPos.y)
    end
  end
  return gridCount, centerPos
end

function ClientBattleEnterSystem_Render:PlayPetFaceAnim(teamEntity)
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  for i, petEntity in ipairs(petEntityList) do
    GameGlobal.TaskManager():CoreGameStartTask(self._PlayFace, self, petEntity)
  end
end

function ClientBattleEnterSystem_Render:_PlayFace(TT, petEntity)
  local duration = 0
  local faceSeq = {}
  local waitTime = 0
  local faceId = GameResourceConst.EnterFaceAnimCfgID
  local isAutoTest = false
  if EDITOR then
    local autoTestMd = GameGlobal.GetModule(AutoTestModule)
    if autoTestMd:IsAutoTest() then
      isAutoTest = true
    end
  end
  if not isAutoTest then
    local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
    local isTeamLeader = false
    if teamEntity then
      isTeamLeader = teamEntity:Team():IsTeamLeaderByEntityId(petEntity:GetID())
    end
    if isTeamLeader then
      local petPstID = petEntity:PetPstID():GetPstID()
      local pet = GameGlobal.GetModule(PetModule):GetPet(petPstID)
      if pet then
        local skin_id = pet:GetSkinId()
        local cfg_pet_skin = Cfg.cfg_pet_skin[skin_id]
        if not cfg_pet_skin then
          Log.error("###[ClientBattleEnterSystem_Render] cfg_pet_skin is nil ! id --> ", skin_id)
        elseif cfg_pet_skin.EnterBattleFaceCfgID then
          faceId = cfg_pet_skin.EnterBattleFaceCfgID
        end
      end
    end
  end
  local cfg = Cfg.cfg_aircraft_pet_face[faceId]
  if not cfg then
    Log.fatal("###找不到配置表情配置：", faceId)
    return
  end
  local preTime = 0
  preTime = preTime + waitTime
  if cfg.FaceSeq then
    for i, value in ipairs(cfg.FaceSeq) do
      local face = {}
      face.frame = value[1]
      local time = value[2]
      face.time = preTime + time
      preTime = preTime + time
      duration = duration + time
      faceSeq[#faceSeq + 1] = face
    end
  end
  local timeService = self._world:GetService("Time")
  waitTime = duration + duration
  local runTime = 0
  local faceIdx = 1
  local mat = self:GetPetFaceMat(petEntity)
  while duration > runTime do
    if faceIdx <= #faceSeq then
      local nowFace = faceSeq[faceIdx]
      if runTime > nowFace.time then
        faceIdx = faceIdx + 1
        if mat and faceIdx <= #faceSeq then
          nowFace = faceSeq[faceIdx]
          mat:SetInt("_Frame", nowFace.frame)
        end
      end
    end
    local deltaTimeMS = timeService:GetDeltaTimeMs()
    runTime = deltaTimeMS + runTime
    YIELD(TT)
  end
end

function ClientBattleEnterSystem_Render:GetPetFaceMat(petEntity)
  local viewComponent = petEntity:View()
  local petGo = viewComponent:GetGameObject()
  local resID = petEntity:PetPstID():GetResID()
  local faceMat
  local face_name = resID .. "_face"
  local face = GameObjectHelper.FindChild(petGo.transform, face_name)
  if face then
    local render = face.gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))
    if not render then
      Log.fatal("面部表情节点上找不到SkinnedMeshRenderer：", face_name)
    else
      faceMat = render.material
    end
  end
  return faceMat
end

function ClientBattleEnterSystem_Render:_DoRenderAssembleFeature(TT)
  local featureRender = self._world:GetService("FeatureRender")
  if featureRender then
    featureRender:OnBattleEnter(TT)
  end
end

function ClientBattleEnterSystem_Render:_DoRenderInitAutoBead(TT)
  local autoBeadServiceRender = self._world:GetService("AutoBeadRender")
  autoBeadServiceRender:InitAutoBead()
end
