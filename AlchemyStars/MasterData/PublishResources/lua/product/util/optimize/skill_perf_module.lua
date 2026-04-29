require("game_module")
_class("SkillPerfModule", GameModule)
SkillPerfModule = SkillPerfModule

function SkillPerfModule:Constructor()
  self._scale = 0.001
  self._effectEntity = {}
  self:TestData()
  self._perfIsRun = false
end

function SkillPerfModule:GetMaxAwakeningLevel(petID)
  local cfgs = Cfg.cfg_pet_awakening({PetID = petID})
  local max = 0
  if cfgs ~= nil then
    for _, c in ipairs(cfgs) do
      if max < c.Awakening then
        max = c.Awakening
      end
    end
  end
  return max
end

function SkillPerfModule:GetMaxEquipLevel(petID)
  local ret = 0
  for k, v in pairs(Cfg.cfg_pet_equip()) do
    if v.PetID == petID and ret < v.Level then
      ret = v.Level
    end
  end
  return ret
end

function SkillPerfModule:GetMaxGradeLevel(petID)
  local ret = 0
  local gradeConfig = Cfg.cfg_pet_grade({PetID = petID})
  table.sort(gradeConfig, function(a, b)
    if a.Grade ~= b.Grade then
      return a.Grade > b.Grade
    else
      return a.ID > b.ID
    end
  end)
  ret = gradeConfig[1].Grade
  return ret
end

function SkillPerfModule:GetMaxLevel(petID, grade)
  local ret = 0
  local levelConfig = Cfg["cfg_pet_level_" .. petID .. "_" .. grade]()
  for k, v in pairs(levelConfig) do
    if v.PetID == petID and ret < v.Level then
      ret = v.Level
    end
  end
  return ret
end

function SkillPerfModule:StopStat()
  self._stop = true
end

function SkillPerfModule:TestData()
  self._petIDList = {}
end

function SkillPerfModule:AddPet(petID)
  self._petList[petID] = {}
end

function SkillPerfModule:AddCalcSkill(petID, skillID)
  table.insert(self._petList[petID], skillID)
end

function SkillPerfModule:AddActiveSkillLog(log)
  if not self._activeSkillLog then
    if EDITOR then
      self._activeSkillLog = {
        "PetID,PetName,SkillID,DefaultFPSNumber,FPSNumber,DiffFPS,Index,DrawCalls,Batches,SetPassCalls,Triangles,Vertices,BonesCount"
      }
    else
      self._activeSkillLog = {
        "PetID,PetName,SkillID,DefaultFPSNumber,FPSNumber,DiffFPS,Index"
      }
    end
  end
  table.insert(self._activeSkillLog, log)
end

function SkillPerfModule:WriteActiveSkillLog()
  local dir = EngineGameHelper.StoragePath .. "PerformanceLog/"
  App.MakeDir(dir)
  local filePath = dir .. "CoreGamePetActiveSkillStatsDataLog" .. os.date("%y%m%d%H%M%S") .. ".csv"
  local file = io.open(filePath, "w")
  for i, log in ipairs(self._activeSkillLog) do
    file:write(log)
    file:write("\n")
  end
  io.close(file)
  self._activeSkillLog = nil
end

function SkillPerfModule:GetFPSNumber()
  if not self._uiCoreGameSkillPerfController then
    self._uiCoreGameSkillPerfController = GameGlobal.UIStateManager():GetController("UICoreGameSkillPerfController")
  end
  local fpsNumber
  for s in string.gmatch(self._uiCoreGameSkillPerfController._fpsText.text, "%d+") do
    fpsNumber = s
  end
  return tonumber(fpsNumber)
end

function SkillPerfModule:ActiveSkillStat()
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    local defaultFPSNumber = self:GetFPSNumber()
    self:WriteLog("Wait ActiveSkill Stat ID:", self._petID, " SkillID:", self._skillID, "TaskID", TaskManager:GetInstance().curTask.id)
    while not self:IsSkillPlaying() do
      YIELD(TT)
      if defaultFPSNumber < self:GetFPSNumber() then
        defaultFPSNumber = self:GetFPSNumber()
      end
    end
    self:WriteLog("BeforeFPSNumber:", defaultFPSNumber)
    self:WriteLog("Begin ActiveSkill Stat ID:", self._petID, " SkillID:", self._skillID, "TaskID", TaskManager:GetInstance().curTask.id)
    local fpsNumber
    local minFPSNumber = 1000
    local dc = -1
    local log
    while self:IsSkillPlaying() do
      YIELD(TT)
      fpsNumber = self:GetFPSNumber()
      local petName = StringTable.Get(self._petData:GetPetName())
      if EDITOR then
        if minFPSNumber > fpsNumber then
          minFPSNumber = fpsNumber
          local curDC = UnityEditor.UnityStats.drawCalls
          local curBT = UnityEditor.UnityStats.batches
          local curSetPassCalls = UnityEditor.UnityStats.setPassCalls
          local curTri = UnityEditor.UnityStats.triangles
          local curVer = UnityEditor.UnityStats.vertices
          dc = UnityEditor.UnityStats.drawCalls
          log = tostring(self._petID) .. "," .. petName .. "," .. tostring(self._skillID) .. "," .. tostring(defaultFPSNumber) .. "," .. tostring(fpsNumber) .. "," .. tostring(defaultFPSNumber - fpsNumber) .. "," .. tostring(self._count) .. "," .. curDC .. "," .. curBT .. "," .. curSetPassCalls .. "," .. curTri .. "," .. curVer
        end
      elseif minFPSNumber > tonumber(fpsNumber) then
        minFPSNumber = tonumber(fpsNumber)
        log = tostring(self._petID) .. "," .. petName .. "," .. tostring(self._skillID) .. "," .. tostring(defaultFPSNumber) .. "," .. tostring(fpsNumber) .. "," .. tostring(defaultFPSNumber - fpsNumber) .. "," .. tostring(self._count)
      end
    end
    self:WriteLog("Finish ActiveSkill Stat ID:", self._petID, " SkillID:", self._skillID, "TaskID", TaskManager:GetInstance().curTask.id, "MinFPS:", fpsNumber)
    self:AddActiveSkillLog(log)
  end)
end

function SkillPerfModule:SaveAlreadyCache()
  self._skillEffectCacheName = {}
  local poolSvc = self._world:GetService("ResourcesPool")
  self._skillEffectCacheName[1] = {}
  self._skillEffectCacheName[2] = {}
  self._skillEffectCacheName[3] = {}
  for name, v in pairs(poolSvc._cacheTable) do
    table.insert(self._skillEffectCacheName[1], name)
  end
  for name, v in pairs(poolSvc._assetTable) do
    table.insert(self._skillEffectCacheName[2], name)
  end
  for name, v in pairs(poolSvc._materialTable) do
    table.insert(self._skillEffectCacheName[3], name)
  end
end

function SkillPerfModule:CastActiveSkill(petID, skillID)
  if self._perfIsRun then
    return
  end
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    for k, v in pairs(Cfg.cfg_pet()) do
      if v.ID == petID then
        self._skillID = skillID
        self:SetAppointSkill(skillID)
        self:InitBeforeSkill()
        self:AddPet(v.ID)
        self:ClearCurPetData(TT)
        self._petID = v.ID
        self:CreateTeamMember(TT, v.ID, self._count)
        YIELD(TT, 1200)
        self:AutoFightActiveSkill(TT)
        YIELD(TT, 500)
      end
    end
    self:AfterSkill()
    self:SetAppointSkill(nil)
  end)
end

function SkillPerfModule:SetAppointSkill(skillID)
  self._appointSkill = skillID
end

function SkillPerfModule:HasAppointSkill()
  return self._appointSkill ~= nil
end

function SkillPerfModule:IsAppointSkill(skillID)
  return self._appointSkill and self._appointSkill == skillID
end

function SkillPerfModule:InitBeforeSkill()
  self._sourceLogLevel = Log.loglevel
  Log.loglevel = ELogLevel.None
  self._noDisposeRes = {}
  self:ControlUIBattle(true)
  self:SetGridScale()
  self._stop = false
  self._count = 1
  self:MonsterGetSourcePos()
  self._petList = {}
  self._skillEffectCacheName = {}
  self._effectEntity = {}
  self._sourceState = LocalDB.GetInt("SkillAnimationSettingKey", SkillAnimationPermissionType.Open)
  LocalDB.SetInt("SkillAnimationSettingKey", SkillAnimationPermissionType.Close)
  self._perfIsRun = true
  self:SaveAlreadyCache()
end

function SkillPerfModule:AfterSkill()
  self._perfIsRun = false
  LocalDB.SetInt("SkillAnimationSettingKey", self._sourceState)
  self:ControlUIBattle(false)
  Log.loglevel = self._sourceLogLevel
  for k, v in pairs(self._petList) do
    if #v == 0 then
      Log.fatal("Can't Cast ActiveSkill Pet:", k)
    end
  end
  self:RevertGridScale()
end

function SkillPerfModule:WriteLog(...)
  Log.loglevel = self._sourceLogLevel
  Log.fatal(...)
  Log.loglevel = ELogLevel.None
end

function SkillPerfModule:BeginActiveSkillStat()
  self:InitBeforeSkill()
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    for k, v in pairs(Cfg.cfg_pet()) do
      if self._stop then
        break
      end
      if v.Formal == 1 and (#self._petIDList == 0 or table.intable(self._petIDList, v.ID)) then
        self:WriteLog("Begin ActiveSkill Perf ID:", v.ID, " count:", self._count)
        self:AddPet(v.ID)
        self:ClearAllTrap(TT)
        self:MonsterRefresh(TT)
        self:ClearCurPetData(TT)
        self._petID = v.ID
        local petEntity = self:CreateTeamMember(TT, v.ID, self._count, SkillType.Active)
        YIELD(TT, 2000)
        if petEntity:HasView() and petEntity:View().ViewWrapper and petEntity:View().ViewWrapper.GameObject then
          self:WriteLog(" BeforeActive AfterCache Perf ID:", v.ID, " count:", self._count)
          self:SetSkillState(false)
          self:ActiveSkillStat()
          YIELD(TT, 100)
          self:AutoFightActiveSkill(TT)
          YIELD(TT, 100)
          self:SetSkillState(false)
          YIELD(TT, 1000)
          self._count = self._count + 1
        end
      end
    end
    YIELD(TT, 500)
    self:AfterSkill()
    for k, v in pairs(self._petList) do
      if #v == 0 then
        Log.fatal("Can't Cast ActiveSkill Pet:", k)
      end
    end
    self:WriteActiveSkillLog()
    for k, v in pairs(self._noDisposeRes) do
      if #v == 0 then
        Log.fatal("No Dispose ResName:", k)
      end
    end
  end)
end

function SkillPerfModule:ClearChainSkillEnv()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  for i, e in ipairs(teamMembers) do
    local skillPetData = e:SkillPetAttackData()
    skillPetData:ClearPetAttackData()
  end
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  logicChainPathCmpt:ClearLogicChainPath()
end

function SkillPerfModule:BuildChainSkillEnv(TT)
end

function SkillPerfModule:PlayChainSkill(TT)
end

function SkillPerfModule:BeginChainSkillStat()
  self:InitBeforeSkill()
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    for k, v in pairs(Cfg.cfg_pet()) do
      if self._stop then
        break
      end
      if v.Formal == 1 and (#self._petIDList == 0 or table.intable(self._petIDList, v.ID)) then
        Log.loglevel = self._sourceLogLevel
        Log.fatal("Begin ActiveSkill Perf ID:", v.ID, " count:", self._count)
        Log.loglevel = ELogLevel.None
        self:AddPet(v.ID)
        self:ClearAllTrap(TT)
        self:MonsterRefresh(TT)
        self:ClearCurPetData(TT)
        self._petID = v.ID
        self:CreateTeamMember(TT, v.ID, self._count, SkillType.Chain)
        YIELD(TT, 2000)
        Log.loglevel = self._sourceLogLevel
        Log.fatal(" BeforeActive AfterCache Perf ID:", v.ID, " count:", self._count)
        Log.loglevel = ELogLevel.None
        self:SetSkillState(false)
        self:ActiveSkillStat()
        YIELD(TT, 100)
        self:AutoFightActiveSkill(TT)
        YIELD(TT, 100)
        self:SetSkillState(false)
        YIELD(TT, 1000)
        self._count = self._count + 1
      end
    end
    YIELD(TT, 500)
    self:AfterSkill()
    for k, v in pairs(self._petList) do
      if #v == 0 then
        Log.fatal("Can't Cast ActiveSkill Pet:", k)
      end
    end
    self:WriteActiveSkillLog()
    for k, v in pairs(self._noDisposeRes) do
      if #v == 0 then
        Log.fatal("No Dispose ResName:", k)
      end
    end
  end)
end

function SkillPerfModule:MonsterGetSourcePos()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local cheatHp = 9999999
  self._monsterPosData = {}
  for _, e in ipairs(group:GetEntities()) do
    local gridPos = e:GridLocation():GetGridPos():Clone()
    local gridDir = e:GridLocation():GetGridDir():Clone()
    self._monsterPosData[e:GetID()] = {gridPos, gridDir}
  end
end

function SkillPerfModule:IsSkillPlaying()
  return self._skillState
end

function SkillPerfModule:SetSkillState(isPlay, skillID)
  self._skillState = isPlay
  if isPlay then
    self._skillID = skillID
  end
  Log.fatal("SetSkillState:", isPlay, " SkillID:", skillID)
end

function SkillPerfModule:ControlUIBattle(hide)
  local uiBattleGO = GameGlobal.UIStateManager():GetController("UIBattle"):GetGameObject()
  uiBattleGO:SetActive(not hide)
  local hudCamera = self._world:MainCamera():HUDCamera()
  hudCamera.enabled = not hide
end

function SkillPerfModule:MonsterRefresh()
  local sBoard = self._world:GetService("BoardLogic")
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local cheatHp = 9999999
  for _, e in ipairs(group:GetEntities()) do
    e:Attributes():Modify("HP", cheatHp)
    e:Attributes():Modify("MaxHP", cheatHp)
    if self._world:RunAtClient() then
      e:ReplaceRedAndMaxHP(cheatHp, cheatHp)
    end
    local posOld = e:GridLocation():GetGridPos():Clone()
    local bodyArea, blockFlag = sBoard:RemoveEntityBlockFlag(e, posOld)
    e:SetGridLocation(self._monsterPosData[e:GetID()][1]:Clone(), self._monsterPosData[e:GetID()][2]:Clone())
    sBoard:SetEntityBlockFlag(e, self._monsterPosData[e:GetID()][1]:Clone(), blockFlag)
  end
end

function SkillPerfModule:ClearAllTrap(TT, petID)
  Log.fatal("BeginClearTrap CurPet:", petID)
  local boardService = self._world:GetService("BoardLogic")
  local group = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  local battleFlags = self._world:BattleFlags()
  local trapSvc = self._world:GetService("TrapLogic")
  local trapRender = self._world:GetService("TrapRender")
  for _, entity in ipairs(group:GetEntities()) do
    if not entity:HasDeadMark() then
      entity:AddDeadMark()
      local trapCmpt = entity:Trap()
      local entityIDList = battleFlags:GetSummonMeantimeLimitEntityID(trapCmpt:GetTrapID())
      if table.intable(entityIDList, entity:GetID()) then
        table.removev(entityIDList, entity:GetID())
        battleFlags:SetSummonMeantimeLimitEntityID(trapCmpt:GetTrapID(), entityIDList)
      end
      local trapIDList = battleFlags:GetSummonOnFixPosLimitEntityID(trapCmpt:GetTrapID())
      if table.intable(trapIDList, entity:GetID()) then
        table.removev(trapIDList, entity:GetID())
        battleFlags:SetSummonOnFixPosLimitEntityID(trapCmpt:GetTrapID(), trapIDList)
      end
      local pos = entity:GetGridPosition()
      boardService:RemoveEntityBlockFlag(entity, pos)
      local needCalcTrapDieSkill = false
      if trapCmpt:IsPrismGrid() then
        needCalcTrapDieSkill = true
      end
      trapSvc:CalcTrapDieSkill({entity})
      entity:BuffComponent():SetActive(false)
    end
  end
  local taskIds = trapRender:PlayTrapDieSkill(TT, group:GetEntities())
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
    YIELD(TT)
  end
  for _, entity in ipairs(group:GetEntities()) do
    self._world:DestroyEntity(entity)
  end
  Log.fatal("Finish ClearTrap CurPet:", petID)
end

function SkillPerfModule:AddSkillEffectCacheName(type, name)
  if not self._skillEffectCacheName[type] then
    self._skillEffectCacheName[type] = {}
  end
  table.insert(self._skillEffectCacheName[type], name)
end

function SkillPerfModule:ClearCacheTable(TT, cacheTable, needSaveName)
  local destroyName = {}
  for resName, resCacheInfo in pairs(cacheTable) do
    if resCacheInfo ~= nil and not table.intable(needSaveName, resName) then
      Log.fatal("ResourceNot Dispose:", resName)
      table.insert(self._noDisposeRes, resName)
      resCacheInfo:SetEnableCache(false)
      local resList = resCacheInfo.reslist
      if resList:Size() ~= 0 then
        for idx = 1, resList:Size() do
          local res = resList:GetAt(idx)
          res:Dispose()
        end
        resList:Clear()
      end
      table.insert(destroyName, resName)
    end
  end
  for k, name in pairs(destroyName) do
    table.removev(cacheTable, name)
  end
end

function SkillPerfModule:ClearSkillEffectCache(TT)
  local poolSvc = self._world:GetService("ResourcesPool")
  self:ClearCacheTable(TT, poolSvc._cacheTable, self._skillEffectCacheName[1])
  collectgarbage("collect")
  App.ClearMemory()
  YIELD(TT)
  self:ClearCacheTable(TT, poolSvc._assetTable, self._skillEffectCacheName[2])
  collectgarbage("collect")
  App.ClearMemory()
  YIELD(TT)
  self:ClearCacheTable(TT, poolSvc._materialTable, self._skillEffectCacheName[3])
  collectgarbage("collect")
  App.ClearMemory()
  YIELD(TT)
end

function SkillPerfModule:ClearCurPetData(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  local buffLogicService = self._world:GetService("BuffLogic")
  for i, petEntity in ipairs(petEntityList) do
    local buffSource = BuffSource:New(BuffSourceType.PassiveSkill, petEntity:PetPstID():GetPstID())
    local skillBuffSource = BuffSource:New(BuffSourceType.Skill, petEntity:GetID())
    local buffBuffSource = BuffSource:New(BuffSourceType.Buff, petEntity:GetID())
    local buffEntityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.Buff)
    for _, buffEntity in ipairs(buffEntityList) do
      local buffComponent = buffEntity:BuffComponent()
      buffComponent:UnLoadBuff(buffSource)
      buffComponent:UnLoadBuff(skillBuffSource)
      buffComponent:UnLoadBuff(buffBuffSource)
    end
    buffLogicService:RemoveAllBuffInstance(petEntity)
  end
  local sEffect = self._world:GetService("Effect")
  for i, petEntity in ipairs(petEntityList) do
    sEffect:ClearEntityEffect(petEntity)
    sEffect:DestroyStaticEffect(petEntity)
    self._world:DestroyEntity(petEntity)
  end
  self._world:GetService("PlayBuff"):PlayAutoRemoveBuff(TT, NTBuffUnload:New())
  local teamPos = teamEntity:GetGridPosition()
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local index = math.random(1, 4)
  boardCmpt:SetPieceElement(teamPos, index)
  local boardServiceRender = self._world:GetService("BoardRender")
  boardServiceRender:ReCreateGridEntity(index, teamPos, false, false, true)
  buffLogicService:RemoveAllBuffInstance(teamEntity)
  teamEntity:Team():ClearTeamPetEntities()
  self._world.BW_WorldInfo.localMatchPetDict = {}
  self._world.BW_WorldInfo.localMatchPets = {}
  self._world:BattleStat()._exChangeBuffMap = {}
  self:DestoryEffectEntity()
  self:ClearSkillEffectCache(TT)
  collectgarbage("collect")
  App.ClearMemory()
  collectgarbage("collect")
  App.ClearMemory()
  collectgarbage("collect")
  App.ClearMemory()
  YIELD(TT, 100)
end

function SkillPerfModule:RevertGridScale()
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, pieceEntity in ipairs(pieceGroup:GetEntities()) do
    local viewCmpt = pieceEntity:View()
    local gameObj = viewCmpt:GetGameObject()
    gameObj.transform.localScale = Vector3(1, 1, 1)
  end
end

function SkillPerfModule:SetGridEntityScale(entity)
  local viewCmpt = entity:View()
  local gameObj = viewCmpt:GetGameObject()
  gameObj:SetActive(false)
  gameObj.transform.localScale = Vector3(self._scale, self._scale, self._scale)
end

function SkillPerfModule:SetGridScale()
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, pieceEntity in ipairs(pieceGroup:GetEntities()) do
    self:SetGridEntityScale(pieceEntity)
  end
end

function SkillPerfModule:CreatePetInfo(templateID, count)
  local petInfo = MatchPetInfo:New()
  local tmpPstid = 999000000 + count
  petInfo.pet_pstid = tmpPstid
  petInfo.pet_power = -1
  petInfo.template_id = templateID
  petInfo.grade = self:GetMaxGradeLevel(templateID) or 0
  petInfo.level = self:GetMaxLevel(templateID, petInfo.grade) or 1
  petInfo.awakening = self:GetMaxAwakeningLevel(templateID) or 0
  petInfo.affinity_level = 1
  petInfo.team_slot = 1
  petInfo.attack = 1
  petInfo.defense = 1
  petInfo.max_hp = 1
  petInfo.cur_hp = 1
  petInfo.after_damage = 0
  petInfo.equip_lv = 10
  petInfo.m_nHelpPetKey = 0
  petInfo.uuid = 1
  return petInfo
end

function SkillPerfModule:CreateTeamMember(TT, templateID, count, skillType)
  local petInfo = self:CreatePetInfo(templateID, count)
  self:SetMatchEnterData(petInfo)
  local petPstID = petInfo.pet_pstid
  local matchPet = MatchPet:New(petInfo)
  self._petData = matchPet
  self:CachePet(TT, matchPet, skillType)
  local listMatchPet = self._world:GetLocalMatchPetList()
  table.insert(listMatchPet, matchPet)
  self._world.BW_WorldInfo.localMatchPetDict[petPstID] = matchPet
  self:SetTeamLogic()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local petEntity = teamEntity:Team():GetTeamPetEntities()[1]
  self:SetPetRender(petEntity)
  self:SetTeamRender()
  return petEntity, petInfo, matchPet
end

function SkillPerfModule:SetTeamLogic()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self._world:DestroyEntity(teamEntity)
  local entityService = self._world:GetService("LogicEntity")
  entityService:CreateBattleTeamLogic()
  teamEntity = self._world:Player():GetCurrentTeamEntity()
  self._world:Player():SetPreviewTeamEntity(teamEntity)
end

function SkillPerfModule:GetFsmStateID()
  local gameFsmCmpt = self._world:GameFSM()
  if gameFsmCmpt then
    return gameFsmCmpt:CurStateID()
  end
  return GameStateID.Invalid
end

function SkillPerfModule:AutoFightActiveSkill(TT)
  Log.fatal("Active Begin")
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local uiBattle = GameGlobal.UIStateManager():GetController("UIBattle")
  uiBattle._petAreaWidget:SetData(uiBattle)
  local widget = uiBattle._petAreaWidget
  self:PetPowerFull(teamEntity)
  local autoFightService = self._world:GetService("AutoFight")
  autoFightService:_BuildMoveEnv(teamEntity)
  autoFightService:Handle_CastActiveSkill(TT)
  autoFightService:OnAutoFight_End()
  while GameStateID.WaitInput ~= self:GetFsmStateID() do
    YIELD(TT, 100)
  end
  Log.fatal("Active Finish")
end

function SkillPerfModule:SetPetRender(petEntity)
  local matchPet = petEntity:MatchPet():GetMatchPet()
  local firstElement = matchPet:GetPetFirstElement()
  local secondElement = matchPet:GetPetSecondElement()
  local petPrefab = matchPet:GetPetPrefab(PetSkinEffectPath.MODEL_INGAME)
  local gridLocCmpt = petEntity:GridLocation()
  local gridPos = gridLocCmpt:GetGridPos()
  local gridDir = gridLocCmpt:GetGridDir()
  local attrCmpt = petEntity:Attributes()
  local hp = attrCmpt:GetCurrentHP()
  local maxHP = attrCmpt:CalcMaxHp()
  petEntity:SetLocation(gridPos, gridDir)
  local id = string.gsub(petPrefab, ".prefab", "")
  petEntity:ReplaceAsset(NativeUnityPrefabAsset:New(petPrefab, true))
  petEntity:PetPstID():SetResID(tonumber(id))
  local attrCmpt = petEntity:Attributes()
  local hp = attrCmpt:GetCurrentHP()
  local maxHP = attrCmpt:CalcMaxHp()
  petEntity:ReplaceRedAndMaxHP(hp, maxHP)
  local hpOffset = matchPet:GetHPOffset()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local hpCmpt = teamEntity:HP()
  hpCmpt:SetHPOffset(hpOffset)
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  petEntity:Attributes():Modify("Power", 0)
  self._world:EventDispatcher():Dispatch(GameEventType.PetPowerChange, petPstID, 0)
  petEntity:Attributes():Modify("Ready", 1)
  self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, true, false)
end

function SkillPerfModule:SetTeamRender()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local attributesComponent = teamEntity:Attributes()
  local hp = attributesComponent:GetCurrentHP()
  local maxHP = attributesComponent:CalcMaxHp()
  teamEntity:ReplaceRedAndMaxHP(hp, maxHP)
  local teamPos = teamEntity:GetGridPosition()
  local teamRotation = teamEntity:GridLocation():GetGridDir()
  teamEntity:SetLocation(teamPos, teamRotation)
end

function SkillPerfModule:_ReAddTeamBuffOnPartnerJoin(petEntity)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoCreateIntensifyBuffMap(petEntity)
  local team = teamEntity:Team()
  local order = team:GetTeamOrder()
  table.insert(order, petEntity:PetPstID():GetPstID())
  team:SetTeamOrder(order)
  local petEntitys = team:GetTeamPetEntities()
  table.insert(petEntitys, petEntity)
  team:SetTeamPetEntities(petEntitys)
  local configServer = self._world:GetService("Config")
  self._buffLogic:_BuildPetPassiveSkill(petEntity, configServer)
  self._buffLogic:_BuildPetIntensifyBuff(petEntity)
end

function SkillPerfModule:UnLoadTmpTeamBuff(tmpTeamEntity)
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:RemoveAllBuffInstance(tmpTeamEntity)
end

function SkillPerfModule:_DoCreateIntensifyBuffMap(petEntity)
  local battleStatCmpt = self._world:BattleStat()
  local equipIntensifyParams = petEntity:SkillInfo():GetEquipIntensifyParam()
  if equipIntensifyParams then
    battleStatCmpt:AddBuffIntensifyParam(equipIntensifyParams)
  end
end

function SkillPerfModule:PetPowerFull(teamEntity)
  teamEntity = teamEntity or self._world:Player():GetLocalTeamEntity()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  local buffLogicService = self._world:GetService("BuffLogic")
  local playBuffService = self._world:GetService("PlayBuff")
  local configService = self._world:GetService("Config")
  local utilData = self._world:GetService("UtilData")
  for _, e in ipairs(teamMembers) do
    local petPstIDComponent = e:PetPstID()
    local petPstID = petPstIDComponent:GetPstID()
    local activeSkillID = e:SkillInfo():GetActiveSkillID()
    local skillConfigData = configService:GetSkillConfigData(activeSkillID)
    if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
      local curLegendPower = e:Attributes():GetAttribute("LegendPower")
      local newLegendPower = curLegendPower + 10
      if newLegendPower > BattleConst.LegendPowerMax then
        newLegendPower = BattleConst.LegendPowerMax
      end
      e:Attributes():Modify("LegendPower", newLegendPower)
      self._world:EventDispatcher():Dispatch(GameEventType.PetLegendPowerChange, petPstID, newLegendPower)
    elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
      local costLayer = skillConfigData:GetSkillTriggerParam()
      local extraParam = skillConfigData:GetSkillTriggerExtraParam()
      local buffEffectType = extraParam.buffEffectType
      local blsvc = self._world:GetService("BuffLogic")
      local currentVal = blsvc:GetBuffLayer(e, buffEffectType)
      blsvc:SetBuffLayer(e, buffEffectType, costLayer, true)
      self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, true)
    else
      e:Attributes():Modify("Power", 0)
      self._world:EventDispatcher():Dispatch(GameEventType.PetPowerChange, petPstID, 0)
    end
    e:Attributes():Modify("Ready", 1)
    self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, true, false)
    local extraSkillList = e:SkillInfo():GetExtraActiveSkillIDList()
    if extraSkillList then
      for _, extraSkillID in ipairs(extraSkillList) do
        local extraSkillConfigData = configService:GetSkillConfigData(extraSkillID)
        if extraSkillConfigData then
          if extraSkillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
            local curLegendPower = e:Attributes():GetAttribute("LegendPower")
            local newLegendPower = curLegendPower + 10
            if newLegendPower > BattleConst.LegendPowerMax then
              newLegendPower = BattleConst.LegendPowerMax
            end
            e:Attributes():Modify("LegendPower", newLegendPower)
            self._world:EventDispatcher():Dispatch(GameEventType.PetLegendPowerChange, petPstID, newLegendPower)
          else
            utilData:SetPetPowerAttr(e, 0, extraSkillID)
            self._world:EventDispatcher():Dispatch(GameEventType.PetExtraPowerChange, petPstID, extraSkillID, 0, true)
          end
          utilData:SetPetSkillReadyAttr(e, 1, extraSkillID)
          self._world:EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillGetReady, petPstID, extraSkillID, true, false)
        end
      end
    end
  end
  if playBuffService and self._world:RunAtClient() then
    TaskManager:GetInstance():CoreGameStartTask(playBuffService.PlayAutoAddBuff, playBuffService)
  end
end

function SkillPerfModule:CachePet(TT, matchPet, skillType)
  self._petPrefabList = {}
  self._petMatList = {}
  local respool = self._world.BW_Services.ResourcesPool
  local loadingSvc = self._world:GetService("Loading")
  local restable = {}
  local heroPrefab = matchPet:GetPetPrefab(PetSkinEffectPath.MODEL_INGAME)
  local heroAncName = HelperProxy:GetInstance():GetPetAnimatorControllerName(heroPrefab, PetAnimatorControllerType.Battle)
  table.appendArray(restable, {
    {heroAncName, 1}
  })
  local skillIds
  local skinId = matchPet:GetSkinId()
  if skillType == SkillType.Active then
    local activeSkill = matchPet:GetPetActiveSkill()
    skillIds = {activeSkill}
  elseif skillType == SkillType.Chain then
    self._petChainInfo = matchPet:GetChainSkillInfo()
    skillIds = {
      table.unpack(table.select(self._petChainInfo, "Skill"))
    }
  end
  local t = loadingSvc:_GetSkillCacheTable(skillIds, skinId)
  table.appendArray(restable, t)
  local passiveSkillID = matchPet:GetPetPassiveSkill()
  if passiveSkillID and 0 < passiveSkillID then
    local cfg = Cfg.cfg_passive_skill[passiveSkillID]
    local t = loadingSvc:_GetBuffCacheTable(cfg.BuffID)
    table.appendArray(restable, t)
  end
  local shaderEffect = matchPet:GetPetShaderEffect()
  if shaderEffect then
    loadingSvc:_CacheEachShaderEffectsAssetFile(shaderEffect)
  end
  for k, v in pairs(restable) do
    local resname = v[1]
    local count = v[2]
    if string.endwith(resname, ".mat") then
      respool:CacheMaterial(resname, count)
    else
      respool:Cache(resname, count)
    end
  end
  YIELD(TT, 200)
end

function SkillPerfModule:DoPetPassiveSkill(petEntity)
  local buffLogic = self._world:GetService("BuffLogic")
  local configServer = self._world:GetService("Config")
  local passiveSkillID = petEntity:SkillInfo():GetPassiveSkillID()
  local equipIntensifyParams = petEntity:SkillInfo():GetEquipIntensifyParam()
  if passiveSkillID and passiveSkillID ~= 0 then
    local config = configServer:GetPetPassiveSkill(passiveSkillID)
    if config and config.BuffID then
      local buffSource = BuffSource:New(BuffSourceType.PassiveSkill, petEntity:PetPstID():GetPstID())
      for _, buffID in ipairs(config.BuffID) do
        buffLogic:AddBuffByTargetType(buffID, config.BuffTargetType, config.BuffTargetParam, {casterEntity = petEntity}, buffSource, equipIntensifyParams, petEntity)
      end
    end
  end
end

function SkillPerfModule:_DoLogicSetNewPetPassiveSkill(teamEntity, tmpTeamEntity)
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:BuildNewPartnerPassiveSkill(teamEntity, tmpTeamEntity)
end

function SkillPerfModule:_DoLogicSetPetIntensifyBuff(tmpTeamEntity)
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:BuildPetIntensifyBuff(tmpTeamEntity)
end

function SkillPerfModule:LoadPetSkillEffect(petEntity)
end

function SkillPerfModule:StartCoreGame()
  self._coreGameIsRun = true
end

function SkillPerfModule:IsPerfCoreGame()
  return self._coreGameIsRun
end

function SkillPerfModule:SetWorld(world)
  self._world = world
  self._buffLogic = self._world:GetService("BuffLogic")
  self._configService = self._world:GetService("Config")
  GameGlobal.UIStateManager():ShowDialog("UICoreGameSkillPerfController")
end

function SkillPerfModule:IsBeginPerf()
  return self._perfIsRun
end

function SkillPerfModule:SetMatchEnterData(petInfo)
  local pstid = self:GetModule(RoleModule):GetPstId()
  local createInfo = self:CreateMatchCreateInfo()
  local playerList = self:CreateMatchPlayerList(petInfo)
  local enterData = MatchEnterData:New(pstid, createInfo, playerList)
  if petInfo then
    enterData:CreateWorldInfo(MainWorldCreationContextType.Client)
  end
  local enterPreferenceData = MatchEnterPreFerenceData:New(playerList)
  self:GetModule(MatchModule):SetMatchEnterData(enterData, enterPreferenceData)
end

function SkillPerfModule:EnterCoreGame(config)
  self:StartCoreGame()
  GameGlobal:GetInstance():SetOfflineMatch(true)
  self:SetMatchEnterData()
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Battle_Loading)
end

function SkillPerfModule:CreateMatchCreateInfo(petEntity)
  local createInfo = MatchCreateInfo:New()
  createInfo.match_type = MatchType.MT_Mission
  createInfo.creator_id = 0
  createInfo.level_id = 1000205
  createInfo.formation_id = 0
  createInfo.seed = 1234567
  createInfo.m_time = os.time()
  createInfo.match_logic_flags = 0
  createInfo.sync_mode = 0
  createInfo.server_auto_fight = false
  createInfo.guide_info = GuideInfo:New()
  createInfo.word_ids = {}
  createInfo.client_create_info = self:CreateClientMatchCreateInfo(petEntity)
  createInfo.level_is_pass = false
  createInfo.assign_wave_refresh_probability = 0
  createInfo.m_nHelpPetKey = 0
  createInfo.tale_pet_buffs = {}
  createInfo.normal_pet_buffs = {}
  createInfo.trail_buff_level_id = 0
  createInfo.affixList = {}
  return createInfo
end

function SkillPerfModule:CreateClientMatchCreateInfo(petEntity)
  local clientInfo = ClientMatchCreateInfo:New()
  clientInfo.mission_info = {}
  clientInfo.m_extMissionInfo = {}
  clientInfo.maze_info = {}
  clientInfo.resdungeon_info = {}
  clientInfo.tower_info = {}
  clientInfo.lost_area_mission_info = {}
  clientInfo.campaign_mission_info = {}
  clientInfo.tale_pet_info = {}
  clientInfo.black_fist_info = {}
  local info = MissionCreateInfo:New()
  info.mission_id = 4008020
  clientInfo.mission_info[1] = info
  return clientInfo
end

function SkillPerfModule:CreateMatchPlayerList(petInfo)
  local luainfo = LuaMatchPlayerInfo:New()
  luainfo.blood = 1
  luainfo.nick = ""
  luainfo.pstid = self:GetModule(RoleModule):GetPstId()
  luainfo.nLevel = 1
  luainfo.pet_list = {}
  if not petInfo then
    petInfo = MatchPetInfo:New()
    petInfo.pet_pstid = 1
    petInfo.pet_power = -1
    petInfo.template_id = 1600011
    petInfo.level = 50
    petInfo.grade = 3
    petInfo.awakening = 6
    petInfo.affinity_level = 1
    petInfo.team_slot = 1
    petInfo.attack = 0
    petInfo.defense = 0
    petInfo.max_hp = 0
    petInfo.cur_hp = 0
    petInfo.after_damage = 0
    petInfo.equip_lv = 10
    petInfo.equip_refine_lv = 0
    petInfo.m_nHelpPetKey = 0
  end
  table.insert(luainfo.pet_list, petInfo)
  return {
    [luainfo.pstid] = luainfo
  }
end

function SkillPerfModule:PerfClose()
  self._perfIsRun = false
  self._coreGameIsRun = false
  GameGlobal:GetInstance():StopCoreGame()
  GameGlobal.TaskManager():KillCoreGameTasks()
  GameGlobal:GetInstance():ExitCoreGame()
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
end

function SkillPerfModule:AddEffectEntity(entity)
  if not self._effectEntity then
    self._effectEntity = {}
  end
  table.insert(self._effectEntity, entity)
end

function SkillPerfModule:DestoryEffectEntity()
  for k, entity in pairs(self._effectEntity) do
    if not entity:HasPiece() and not entity:HasSkillRangeOutline() then
      self._world:DestroyEntity(entity)
    end
  end
end

function SkillPerfModule:EnterCoreGameSingleReStart()
  self:EnterCoreGameSingle(self.restartmatchType, self.restartlevelID, self.restartmission_id, self.restartpetList, self.restartparent_mission_id, true)
end

function SkillPerfModule:EnterCoreGameSingle(matchType, levelID, mission_id, petList, parent_mission_id, isrestart)
  self.restartmatchType = matchType
  self.restartlevelID = levelID
  self.restartmission_id = mission_id
  self.restartpetList = petList
  self.restartparent_mission_id = parent_mission_id
  local havePet = false
  for i = 1, #petList do
    if petList[i] ~= 0 then
      havePet = true
    end
  end
  if not havePet then
    ToastManager.ShowToast(StringTable.Get("str_discovery_no_leader_no_fight"))
    return
  end
  GameGlobal:GetInstance():SetOfflineMatch(true)
  local clientInfo = ClientMatchCreateInfo:New()
  clientInfo.mission_info = {}
  clientInfo.m_extMissionInfo = {}
  clientInfo.maze_info = {}
  clientInfo.resdungeon_info = {}
  clientInfo.tower_info = {}
  clientInfo.lost_area_mission_info = {}
  clientInfo.campaign_mission_info = {}
  clientInfo.tale_pet_info = {}
  clientInfo.black_fist_info = {}
  local info = MissionCreateInfo:New()
  info.mission_id = mission_id
  clientInfo.mission_info[1] = info
  local diffinfo = DifficultyMissionCreateInfo:New()
  diffinfo.sub_mission_id = mission_id
  diffinfo.parent_mission_id = parent_mission_id
  clientInfo.difficulty_mission_info[1] = diffinfo
  local createInfo = MatchCreateInfo:New()
  createInfo.match_type = matchType
  createInfo.creator_id = 0
  createInfo.level_id = levelID
  createInfo.formation_id = 0
  createInfo.seed = 1234567
  createInfo.m_time = os.time()
  createInfo.match_logic_flags = 0
  createInfo.sync_mode = 0
  createInfo.server_auto_fight = false
  createInfo.guide_info = GuideInfo:New()
  createInfo.word_ids = {}
  createInfo.client_create_info = clientInfo
  createInfo.level_is_pass = false
  createInfo.assign_wave_refresh_probability = 0
  createInfo.m_nHelpPetKey = 0
  createInfo.tale_pet_buffs = {}
  createInfo.normal_pet_buffs = {}
  createInfo.trail_buff_level_id = 0
  createInfo.affixList = {}
  local luainfo = LuaMatchPlayerInfo:New()
  luainfo.blood = 1
  luainfo.nick = ""
  luainfo.pstid = self:GetModule(RoleModule):GetPstId()
  luainfo.nLevel = 1
  luainfo.pet_list = {}
  local petModule = self:GetModule(PetModule)
  for i, petid in ipairs(petList) do
    if petid ~= 0 then
      local v = petModule:GetPet(petid)._data
      local petInfo = MatchPetInfo:New()
      petInfo.pet_pstid = v.template_id
      petInfo.pet_power = -1
      petInfo.template_id = v.template_id
      petInfo.level = v.level
      petInfo.grade = v.grade
      petInfo.awakening = v.awakening
      petInfo.affinity_level = 1
      petInfo.team_slot = i
      petInfo.attack = 0
      petInfo.defense = 0
      petInfo.max_hp = 0
      petInfo.cur_hp = 0
      petInfo.after_damage = 0
      petInfo.equip_lv = v.equip_lv
      petInfo.equip_refine_lv = v.equip_Refine_Lv or 0
      petInfo.m_nHelpPetKey = 0
      table.insert(luainfo.pet_list, petInfo)
    end
  end
  local playerList = {
    [luainfo.pstid] = luainfo
  }
  local enterData = MatchEnterData:New(self:GetModule(RoleModule):GetPstId(), createInfo, playerList)
  local enterPreferenceData = MatchEnterPreFerenceData:New(playerList)
  local matchModule = self:GetModule(MatchModule)
  local GameMatchModule = self:GetModule(GameMatchModule)
  matchModule:SetMatchEnterData(enterData)
  GameMatchModule._quickReStartCreateInfo = createInfo
  local ctx = self:GetModule(MissionModule):TeamCtx()
  local curTeamId = ctx:GetCurrTeamId()
  GameMatchModule._quickReStartTeamId = curTeamId
  GameMatchModule._quickReStartMatchType = matchType
  if isrestart then
    return
  end
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Battle_Loading)
end
