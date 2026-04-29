require("pop_star_battle_enter_system")
_class("PopStarBattleEnterSystem_Render", PopStarBattleEnterSystem)
PopStarBattleEnterSystem_Render = PopStarBattleEnterSystem_Render

function PopStarBattleEnterSystem_Render:_DoRenderShowBattleEnter(TT, teamEntity)
  local goEffRuChangActorPoint = UnityEngine.GameObject.Find(GameResourceConst.EffRuchangActorpoint)
  if goEffRuChangActorPoint then
    goEffRuChangActorPoint:SetActive(false)
  end
  local cRenderBoard = self._world:GetRenderBoardEntity():RenderBoard()
  local sceneRoot = GameObjectHelper.Find("SceneRoot")
  cRenderBoard:SetSceneGO(sceneRoot)
  local cHP = teamEntity:HP()
  cHP:SetHPPosDirty(true)
  cHP:SetHPBarTempHide(true)
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  local locationCmpt = teamEntity:Location()
  local pets = teamEntity:Team():GetTeamPetEntities()
  for i, e in ipairs(pets) do
    if e:GetID() ~= teamLeaderEntity:GetID() then
      e:SetLocation(locationCmpt:GetPosition(), locationCmpt:GetDirection())
    end
  end
  local darkParamName = "H3DDarkLevel"
  UnityEngine.Shader.SetGlobalFloat(darkParamName, 0)
  local pieceService = self._world:GetService("Piece")
  pieceService:Initialize()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  self:_InitRoundCountUI(levelConfigData:GetLevelRoundCount())
  self:_PlayEnterBgm()
  self:_DoPostStory(TT)
end

function PopStarBattleEnterSystem_Render:_InitRoundCountUI(waveRoundCount)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.InitRoundCount, waveRoundCount)
end

function PopStarBattleEnterSystem_Render:_PlayEnterBgm()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local bgmID = levelConfigData:GetBgmID()
  if bgmID == 0 then
    Log.fatal("关卡 id:" .. levelConfigData:GetLevelID() .. " 未配置BGM!")
    return
  end
  AudioHelperController.PlayBGMById(bgmID)
end

function PopStarBattleEnterSystem_Render:_DoPostStory(TT)
  local collector = GameGlobal:GetInstance():GetCollector("CoreGameLoading")
  collector:Sample("PopStarBattleEnterSystem_Render:_DoPostStory() begin")
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIBattle)
  while GameGlobal.UIStateManager():IsShow("UIBattle") == false do
    YIELD(TT)
  end
  GameGlobal.UIStateManager():SetBlackSideVisible(true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, false)
  collector:Sample("PopStarBattleEnterSystem_Render:ShowUIBattle()")
  collector:Dump()
  local guideService = self._world:GetService("Guide")
  local guideTaskId = guideService:Trigger(GameEventType.GuideBattleStart)
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
end

function PopStarBattleEnterSystem_Render:_DoRenderShowBoard(TT, pieceRefreshType, fallingDir)
  self:_BoardShow(TT)
  YIELD(TT)
  if pieceRefreshType == PieceRefreshType.FallingDown then
    local utilDataSvc = self._world:GetService("UtilData")
    local curMaxX = utilDataSvc:GetCurBoardMaxX()
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

function PopStarBattleEnterSystem_Render:_BoardShow(TT)
  self:_PlayTerrainAbyssAppearSkill(TT)
  local spawnPieceServiceRender = self._world:GetService("SpawnPieceRender")
  spawnPieceServiceRender:PlayBoardShow(TT)
  local cameraCmpt = self._world:MainCamera()
  cameraCmpt:_MoveCameraToNormal()
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayAutoAddBuff()
end

function PopStarBattleEnterSystem_Render:_PlayTerrainAbyssAppearSkill(TT)
  local group = self.world:GetGroup(self.world.BW_WEMatchers.Trap)
  local eTraps = group:GetEntities()
  local terrainAbyssEntityList = {}
  for _, entity in pairs(eTraps) do
    local trapRenderComponent = entity:TrapRender()
    if trapRenderComponent:GetTrapType() == TrapType.TerrainAbyss then
      table.insert(terrainAbyssEntityList, entity)
    end
  end
  local trapRSvc = self._world:GetService("TrapRender")
  local taskID = GameGlobal.TaskManager():CoreGameStartTask(trapRSvc.ShowTraps, trapRSvc, terrainAbyssEntityList)
  return taskID
end

function PopStarBattleEnterSystem_Render:_DoRenderAssembleFeature(TT)
  local featureRender = self._world:GetService("FeatureRender")
  if featureRender then
    featureRender:OnBattleEnter(TT)
  end
end
