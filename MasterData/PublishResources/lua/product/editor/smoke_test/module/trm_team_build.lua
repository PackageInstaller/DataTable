require("test_robot_module")
require("team_build_seat_info")

function TestRobotModule:BuildRandomTeam(runData, petPoolOptions)
  runData:ResetCurrentTeamBuild()
  local queryCfg = Cfg.cfg_level_test_team_build({
    MissionID = runData:GetMissionID()
  })
  if not queryCfg or #queryCfg == 0 then
    queryCfg = Cfg.cfg_level_test_team_build({MissionID = -1})
  end
  if not queryCfg or #queryCfg == 0 then
    self:Panic("required test team build is missing: ", runData:GetMissionID())
    return false
  end
  if not runData:GetCurrentTestTeamBuildID() then
    self:Log("select test team build ID: ", queryCfg[1].ID)
    runData:ChangeCurrentTestTeamBuildID(queryCfg[1].ID)
  end
  if #runData:GetUntestedPets() == 0 then
    runData:MarkCurrentTestTeamBuildIDFinished()
    for _, conf in ipairs(queryCfg) do
      if not runData:IsTestBuildIDFinished(conf.ID) then
        self:Log("select test team build ID: ", queryCfg[1].ID)
        runData:ChangeCurrentTestTeamBuildID(conf.ID)
        runData:ClearPetInfo()
        break
      end
    end
    if #runData:GetUntestedPets() == 0 then
      return false
    end
  end
  local teamBuildConfID = runData:GetCurrentTestTeamBuildID()
  local leaderMainElement
  local mapPetTemplateID = {}
  local petCount = queryCfg[1].PetCount
  for seatIndex = 1, petCount do
    local seatInfo = SmokeTestTeamBuildSeatInfo.ExplainSeat(teamBuildConfID, seatIndex)
    local tid
    if seatInfo.enabled then
      tid = self:FetchOnePermanentlyTestPetID(runData, mapPetTemplateID)
      if not tid then
        local pool = self:GetRandomPetPoolForOnce(runData, seatIndex, leaderMainElement, petPoolOptions)
        if #pool == 0 then
          pool = self:GetBackupRandomPetPool(runData, petPoolOptions)
        end
        local lottery = math.random(1, #pool)
        local luckyPet = pool[lottery]
        tid = luckyPet.ID
      end
      local conf = Cfg.cfg_pet[tid]
      if petPoolOptions.leaderElementWeightEnabled then
        leaderMainElement = conf.FirstElement
      end
      mapPetTemplateID[tid] = true
      local petBuildData = TestRobotPetBuildData.GenerateForSeat(tid, seatInfo)
      runData:AddPet(petBuildData)
      self:Log("pet[", tostring(petBuildData), "]. seat[", tostring(seatInfo), "]")
    end
  end
  return true
end

function TestRobotModule:FetchOnePermanentlyTestPetID(runData, filter)
  local tPermanentlyTestPetTemplateID = runData:GetPermanentlyRequiredPetList()
  for _, tid in ipairs(tPermanentlyTestPetTemplateID) do
    if not filter[tid] then
      return tid
    end
  end
end

function TestRobotModule:GetRandomPetPoolForOnce(runData, seatIndex, leaderMainElement, petPoolOptions)
  local pool = {}
  local tUntested = runData:GetUntestedPets()
  for _, conf in ipairs(tUntested) do
    local weight = petPoolOptions.seatStarWeight[seatIndex][conf.Star]
    if leaderMainElement and leaderMainElement == conf.FirstElement then
      weight = weight * petPoolOptions.sameElementWeight
    end
    if weight == 0 then
      self:Panic("GetRandomPetPoolForOnce: pet weight == 0")
    end
    for i = 1, weight do
      table.insert(pool, conf)
    end
  end
  for i = #pool, 2, -1 do
    local j = math.random(i)
    pool[i], pool[j] = pool[j], pool[i]
  end
  return pool
end

function TestRobotModule:GetBackupRandomPetPool(runData, petPoolOptions)
  local pool = {}
  local currentTemplateID = runData:GetCurrentTeamBuildFormationTemplateID()
  local queryCondition = {Formal = 1}
  if petPoolOptions.forcePetMainElement then
    queryCondition.FirstElement = petPoolOptions.forcePetMainElement
  end
  local tConf = Cfg.cfg_pet(queryCondition)
  local bindGroupInfo = {}
  local currentTeamBuild = runData:GetCurrentTeamBuild()
  for _, data in ipairs(currentTeamBuild) do
    local tid = data:GetTemplateID()
    local conf = Cfg.cfg_pet[tid]
    if conf.BinderPetID then
      bindGroupInfo[conf.BinderPetID] = {
        conf.BinderIndex
      }
    end
  end
  for _, conf in ipairs(tConf) do
    if not runData:IsPetDisabled(conf.ID) and not table.icontains(currentTemplateID, conf.ID) then
      if conf.BinderPetID then
        if bindGroupInfo[conf.BinderPetID] then
          goto lbl_70
        end
        bindGroupInfo[conf.BinderPetID] = {
          conf.BinderIndex
        }
      end
      table.insert(pool, conf)
    end
    ::lbl_70::
  end
  for i = #pool, 2, -1 do
    local j = math.random(i)
    pool[i], pool[j] = pool[j], pool[i]
  end
  return pool
end

function TestRobotModule:AsyncBuildTeamByRunData(TT, teamIndex, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local runData = self:GetMissionRunData()
  local teamIndex = TestConst.MissionTeamIndex
  local currentTeamBuild = runData:GetCurrentTeamBuild()
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  for _, petData in ipairs(currentTeamBuild) do
    local cmdAddPet = string.format("add_asset %s %d 1", LocalDB.GetString("OpenIdTest"), petData:GetTemplateID())
    self:Log(self, "GMCommand: ", cmdAddPet)
    local addPetResult = gmproxy:SendCmdTask(TT, cmdAddPet)
    if addPetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
    local cmdChangePet = petData:GenerateGMCommand()
    self:Log(self, "GMCommand: ", cmdChangePet)
    local changePetResult = gmproxy:SendCmdTask(TT, cmdChangePet)
    if changePetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
  end
  local petPetIDs = runData:GeneratePetPstID()
  local missionModule = GameGlobal.GetModule(MissionModule)
  local formationInfoResult, petPstIDs = missionModule:UpdateMainFormationInfo(TT, teamIndex, TestConst.MissionTeamName, petPetIDs)
  if not formationInfoResult:GetResult() then
    Log.exception(self._className, "UpdateMainFormationInfo failed. ")
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
end

function TestRobotModule:AsyncBuildTowerTeamByRunData(TT, teamIndex, status, towerElementType)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local runData = self:GetMissionRunData()
  local teamIndex = TestConst.MissionTeamIndex
  local currentTeamBuild = runData:GetCurrentTeamBuild()
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  for _, petData in ipairs(currentTeamBuild) do
    local cmdAddPet = string.format("add_asset %s %d 1", LocalDB.GetString("OpenIdTest"), petData:GetTemplateID())
    self:Log(self, "GMCommand: ", cmdAddPet)
    local addPetResult = gmproxy:SendCmdTask(TT, cmdAddPet)
    if addPetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
    local cmdChangePet = petData:GenerateGMCommand()
    self:Log(self, "GMCommand: ", cmdChangePet)
    local changePetResult = gmproxy:SendCmdTask(TT, cmdChangePet)
    if changePetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
  end
  local petPetIDs = runData:GeneratePetPstID()
  local missionModule = GameGlobal.GetModule(MissionModule)
  local formationInfoResult, petPstIDs = missionModule:UpdateMainFormationInfo(TT, teamIndex, TestConst.MissionTeamName, petPetIDs)
  if not formationInfoResult:GetResult() then
    Log.exception(self._className, "UpdateMainFormationInfo failed. ")
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
end

function TestRobotModule:AsyncBuildRandomMazeTeamByRunData(TT, _teamIndex, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local runData = self:GetMissionRunData()
  runData:ResetCurrentTeamBuild()
  local rawEnabledPets = Cfg.cfg_pet({Formal = 1})
  local enabledPets = {}
  for _, petConfig in ipairs(rawEnabledPets) do
    if not runData:GetPetBuildData(petConfig.ID) then
      if TestConst.TemperoryDisabledPet[petConfig.ID] then
        self:Log(self, "Pet [", petConfig.ID, "] disabled. ")
      else
        table.insert(enabledPets, petConfig)
      end
    end
  end
  if #enabledPets == 0 then
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
    return
  end
  local petModule = GameGlobal.GetModule(PetModule)
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  local mapPetTemplateID = {}
  local petPstIds = {}
  for i = 1, 5 do
    local petConfig
    for _, templateID in ipairs(TestConst.PermanentlyTestPet) do
      if not mapPetTemplateID[templateID] then
        for index, cfgInArray in ipairs(enabledPets) do
          if templateID == cfgInArray.ID then
            petConfig = table.remove(enabledPets, index)
          end
        end
        if not petConfig then
          petConfig = Cfg.cfg_pet({ID = templateID})[1]
        end
        break
      end
    end
    if not petConfig then
      if 0 < #enabledPets then
        local rand = math.random(1, #enabledPets)
        petConfig = table.remove(enabledPets, rand)
      else
        local rand = math.random(1, #rawEnabledPets)
        petConfig = table.remove(rawEnabledPets, rand)
      end
    end
    local templateID = petConfig.ID
    local petBuildData = TestRobotPetBuildData:New(templateID, TestConst.MazePetMaxLevel, TestConst.MazePetMaxAwakening, TestConst.MazePetMaxGrade, TestConst.MazePetMaxIntimacy, TestConst.MazePetMaxEquip)
    runData:AddPet(petBuildData)
    self:Log(self, "Selected pet: Slot index: ", i, ", data: ", tostring(petBuildData))
    local cmdAddPet = string.format("add_asset %s %d 1", LocalDB.GetString("OpenIdTest"), templateID)
    self:Log(self, "GMCommand: ", cmdAddPet)
    local addPetResult = gmproxy:SendCmdTask(TT, cmdAddPet)
    if addPetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
    local cmdChangePet = petBuildData:GenerateGMCommand()
    self:Log(self, "GMCommand: ", cmdChangePet)
    local changePetResult = gmproxy:SendCmdTask(TT, cmdChangePet)
    if changePetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
    local matchPet = petModule:GetPetByTemplateId(templateID)
    local pstId = matchPet:GetPstID()
    table.insert(petPstIds, pstId)
    local strcmd = petBuildData:GenerateGMCommand()
    self:Log(self, "GMCommand: ", strcmd)
    self:SendCheatCommand(strcmd)
    mapPetTemplateID[templateID] = true
  end
  runData:SetCurrentTeamPstIDList(petPstIds)
  local missionModule = GameGlobal.GetModule(MissionModule)
  local teamCtx = missionModule:TeamCtx()
  local mazeTeam = teamCtx:GetMazeTeam()
  local mazeModule = GameGlobal.GetModule(MazeModule)
  local formationInfoResult = mazeModule:UpdateMazeFormationInfo(TT, teamCtx.mazeTeamId, mazeTeam.name, petPstIds)
  if not formationInfoResult:GetResult() then
    Log.exception(self._className, "UpdateMainFormationInfo failed. ")
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
  status:SetCustomData("PetPstIDs", petPstIds)
end

function TestRobotModule:AsyncBuildMazeTeamByRunData(TT, teamIndex, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local runData = self:GetMissionRunData()
  local teamIndex = TestConst.MissionTeamIndex
  local currentTeamBuild = runData:GetCurrentTeamBuild()
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  for _, petData in ipairs(currentTeamBuild) do
    local cmdAddPet = string.format("add_asset %s %d 1", LocalDB.GetString("OpenIdTest"), petData:GetTemplateID())
    self:Log(self, "GMCommand: ", cmdAddPet)
    local addPetResult = gmproxy:SendCmdTask(TT, cmdAddPet)
    if addPetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
    local cmdChangePet = petData:GenerateGMCommand()
    self:Log(self, "GMCommand: ", cmdChangePet)
    local changePetResult = gmproxy:SendCmdTask(TT, cmdChangePet)
    if changePetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
  end
  local petPetIDs = runData:GeneratePetPstID()
  local missionModule = GameGlobal.GetModule(MissionModule)
  local teamCtx = missionModule:TeamCtx()
  local mazeModule = GameGlobal.GetModule(MazeModule)
  local formationInfoResult, petPstIDs = mazeModule:UpdateMazeFormationInfo(TT, teamCtx.mazeTeamId, TestConst.MissionTeamName, petPetIDs)
  if not formationInfoResult:GetResult() then
    Log.exception(self._className, "UpdateMazeFormationInfo failed. ")
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  status:SetCustomData("PetPstIDs", petPetIDs)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
  status:SetCustomData("PetPstIDs", petPetIDs)
end

function TestRobotModule:AsyncBuildWorldBossTeamByRunData(TT, teamIndex, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local runData = self:GetMissionRunData()
  local teamIndex = TestConst.MissionTeamIndex
  local currentTeamBuild = runData:GetCurrentTeamBuild()
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  for _, petData in ipairs(currentTeamBuild) do
    local cmdAddPet = string.format("add_asset %s %d 1", LocalDB.GetString("OpenIdTest"), petData:GetTemplateID())
    self:Log(self, "GMCommand: ", cmdAddPet)
    local addPetResult = gmproxy:SendCmdTask(TT, cmdAddPet)
    if addPetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
    local cmdChangePet = petData:GenerateGMCommand()
    self:Log(self, "GMCommand: ", cmdChangePet)
    local changePetResult = gmproxy:SendCmdTask(TT, cmdChangePet)
    if changePetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
  end
  local petPetIDs = runData:GeneratePetPstID()
  local worldBossModule = GameGlobal.GetModule(WorldBossModule)
  local formationInfoResult = worldBossModule:ReqWorldBossChangeFormationInfo(TT, petPetIDs)
  if not formationInfoResult:GetResult() then
    Log.exception(self._className, "UpdateMainFormationInfo failed. ")
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
end

function TestRobotModule:PrebuildRandomTeamForRunData(runData)
  local teamIndex = TestConst.MissionTeamIndex
  runData:ResetCurrentTeamBuild()
  local queryCfg = Cfg.cfg_level_test_team_build({
    MissionID = runData:GetMissionID()
  })
  if not queryCfg or #queryCfg == 0 then
    queryCfg = Cfg.cfg_level_test_team_build({MissionID = -1})
  end
  if not queryCfg or #queryCfg == 0 then
    Log.exception(self._className, "required test team build is missing: ", runData:GetMissionID())
    self:Log("required test team build is missing: ", runData:GetMissionID())
    return
  end
  local config = Cfg.cfg_level_test_team_build[runData:GetCurrentTestTeamBuildID()]
  config = config or Cfg.cfg_level_test_team_build[-1]
  local enabledPets = runData:GetUntestedPets()
  if #enabledPets == 0 then
    runData:MarkCurrentTestTeamBuildIDFinished()
    for _, conf in ipairs(queryCfg) do
      if not runData:GetCurrentTestTeamBuildID() or not runData:IsTestBuildIDFinished(conf.ID) then
        runData:ChangeCurrentTestTeamBuildID(conf.ID)
        runData:ClearPetInfo()
        enabledPets = runData:GetUntestedPets()
        break
      end
    end
  end
  self:Log("Team build config ID: ", runData:GetCurrentTestTeamBuildID())
  if #enabledPets == 0 then
    return false
  end
  local rawPets = Cfg.cfg_pet({Formal = 1})
  local rawEnabledPets = {}
  for _, c in ipairs(rawPets) do
    if not TestConst.TemperoryDisabledPet[c.ID] then
      table.insert(rawEnabledPets, c)
    end
  end
  local leaderMainElement
  local args_f = {
    "P%dEnabled",
    "P%dLevel",
    "P%dAwakening",
    "P%dGrade",
    "P%dIntimacy",
    "P%dEquip"
  }
  local petModule = GameGlobal.GetModule(PetModule)
  local mapPetTemplateID = {}
  for petIndex = 1, 5 do
    local pets = runData:GetUntestedPets()
    enabledPets = {}
    for _, petConfig in ipairs(pets) do
      if not table.icontains(mapPetTemplateID, petConfig.ID) then
        table.insert(enabledPets, petConfig)
      end
    end
    local enabled = config[string.format(args_f[1], petIndex)]
    local level = config[string.format(args_f[2], petIndex)]
    local awakening = config[string.format(args_f[3], petIndex)]
    local grade = config[string.format(args_f[4], petIndex)]
    local intimacy = config[string.format(args_f[5], petIndex)]
    local equip = config[string.format(args_f[6], petIndex)]
    local refine = config[string.format(args_f[7], petIndex)]
    self:Log("Slot config: index: ", petIndex, " enabled: ", enabled, " level: ", level, " awakening: ", awakening, " grade: ", grade, " intimacy: ", intimacy, " equip: ", equip, " refine: ", refine)
    if enabled then
      local templateID
      for _, tid in ipairs(TestConst.PermanentlyTestPet) do
        if not mapPetTemplateID[tid] then
          local petConfig
          for index, cfgInArray in ipairs(enabledPets) do
            if tid == cfgInArray.ID then
              petConfig = table.remove(enabledPets, index)
              break
            end
          end
          petConfig = petConfig or Cfg.cfg_pet({ID = tid})[1]
          templateID = petConfig.ID
          break
        end
      end
      if not templateID then
        local pool = {}
        local mapIndex = {}
        for enabledIndex, petConfig in ipairs(enabledPets) do
          local weight = TestConst.MissionRandomWeightByStar[petIndex][petConfig.Star]
          if leaderMainElement == petConfig.FirstElement then
            weight = weight * TestConst.MissionSameElementWeight
          end
          for i = 1, weight do
            table.insert(pool, petConfig)
            mapPetTemplateID[petConfig.ID] = true
          end
          mapIndex[petConfig.ID] = enabledIndex
        end
        if #pool == 0 then
          local tBinderGroupID = {}
          for id, _ in pairs(mapPetTemplateID) do
            local cfgPet = Cfg.cfg_pet({ID = id})
            if cfgPet.BinderPetID then
              table.insert(tBinderGroupID, cfgPet.BinderPetID)
            end
          end
          repeat
            local rand = math.random(1, #rawEnabledPets)
            local configPet = rawEnabledPets[rand]
            if not mapPetTemplateID[configPet.ID] then
              if TestConst.TemperoryDisabledPet[configPet.ID] then
                self:Log("Pet [", configPet.ID, "] disabled. ")
              elseif table.icontains(tBinderGroupID, configPet.BinderPetID) then
                self:Log("Pet [", configPet.ID, "] already has binder in team: ", configPet.BinderPetID)
              else
                table.insert(pool, configPet)
                mapPetTemplateID[configPet.ID] = true
              end
            end
          until 0 < #pool
          self:Log("Testing pool is empty. Pick a pet for team build: ", pool[#pool].ID)
        end
        local luckyNum = math.random(1, #pool)
        local configLuckyPet = pool[luckyNum]
        templateID = configLuckyPet.ID
        table.remove(enabledPets, mapIndex[templateID])
        leaderMainElement = leaderMainElement or configLuckyPet.FirstElement
      end
      local petBuildData = TestRobotPetBuildData:New(templateID, level, awakening, grade, intimacy, equip, refine)
      runData:AddPet(petBuildData)
    end
  end
  return true
end

function TestRobotModule:AsyncBuildRandomAniPopStarTeamByRunData(TT, _teamIndex, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local runData = self:GetMissionRunData()
  runData:ResetCurrentTeamBuild()
  local rawEnabledPets = Cfg.cfg_pet({Formal = 1})
  local enabledPets = {}
  for _, petConfig in ipairs(rawEnabledPets) do
    if not runData:GetPetBuildData(petConfig.ID) then
      if TestConst.TemperoryDisabledPet[petConfig.ID] then
        self:Log(self, "Pet [", petConfig.ID, "] disabled. ")
      else
        table.insert(enabledPets, petConfig)
      end
    end
  end
  if #enabledPets == 0 then
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
    return
  end
  local petModule = GameGlobal.GetModule(PetModule)
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  local mapPetTemplateID = {}
  local petPstIds = {}
  for i = 1, 5 do
    local petConfig
    for _, templateID in ipairs(TestConst.PermanentlyTestPet) do
      if not mapPetTemplateID[templateID] then
        for index, cfgInArray in ipairs(enabledPets) do
          if templateID == cfgInArray.ID then
            petConfig = table.remove(enabledPets, index)
          end
        end
        if not petConfig then
          petConfig = Cfg.cfg_pet({ID = templateID})[1]
        end
        break
      end
    end
    if not petConfig then
      if 0 < #enabledPets then
        local rand = math.random(1, #enabledPets)
        petConfig = table.remove(enabledPets, rand)
      else
        local rand = math.random(1, #rawEnabledPets)
        petConfig = table.remove(rawEnabledPets, rand)
      end
    end
    local templateID = petConfig.ID
    local petBuildData = TestRobotPetBuildData:New(templateID, TestConst.MazePetMaxLevel, TestConst.MazePetMaxAwakening, TestConst.MazePetMaxGrade, TestConst.MazePetMaxIntimacy, TestConst.MazePetMaxEquip)
    runData:AddPet(petBuildData)
    self:Log(self, "Selected pet: Slot index: ", i, ", data: ", tostring(petBuildData))
    local cmdAddPet = string.format("add_asset %s %d 1", LocalDB.GetString("OpenIdTest"), templateID)
    self:Log(self, "GMCommand: ", cmdAddPet)
    local addPetResult = gmproxy:SendCmdTask(TT, cmdAddPet)
    if addPetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
    local cmdChangePet = petBuildData:GenerateGMCommand()
    self:Log(self, "GMCommand: ", cmdChangePet)
    local changePetResult = gmproxy:SendCmdTask(TT, cmdChangePet)
    if changePetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
    local matchPet = petModule:GetPetByTemplateId(templateID)
    local pstId = matchPet:GetPstID()
    table.insert(petPstIds, pstId)
    local strcmd = petBuildData:GenerateGMCommand()
    self:Log(self, "GMCommand: ", strcmd)
    self:SendCheatCommand(strcmd)
    mapPetTemplateID[templateID] = true
  end
  runData:SetCurrentTeamPstIDList(petPstIds)
  local petPetIDs = runData:GeneratePetPstID()
  local missionModule = GameGlobal.GetModule(MissionModule)
  local teamCtx = missionModule:TeamCtx()
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local res, info = anipopModule:UpdateAnipopFormationInfo(TT, teamCtx.aniPopStarTeamId, TestConst.MissionTeamName, petPetIDs)
  if not res:GetResult() then
    Log.exception(self._className, "UpdateMazeFormationInfo failed. ")
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
  status:SetCustomData("PetPstIDs", petPstIds)
end

function TestRobotModule:AsyncBuildAniPopStarTeamByRunData(TT, teamIndex, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local runData = self:GetMissionRunData()
  local teamIndex = TestConst.MissionTeamIndex
  local currentTeamBuild = runData:GetCurrentTeamBuild()
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  for _, petData in ipairs(currentTeamBuild) do
    local cmdAddPet = string.format("add_asset %s %d 1", LocalDB.GetString("OpenIdTest"), petData:GetTemplateID())
    self:Log(self, "GMCommand: ", cmdAddPet)
    local addPetResult = gmproxy:SendCmdTask(TT, cmdAddPet)
    if addPetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
    local cmdChangePet = petData:GenerateGMCommand()
    self:Log(self, "GMCommand: ", cmdChangePet)
    local changePetResult = gmproxy:SendCmdTask(TT, cmdChangePet)
    if changePetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
      return
    end
  end
  local petPetIDs = runData:GeneratePetPstID()
  local missionModule = GameGlobal.GetModule(MissionModule)
  local teamCtx = missionModule:TeamCtx()
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local res, info = anipopModule:UpdateAnipopFormationInfo(TT, teamCtx.aniPopStarTeamId, TestConst.MissionTeamName, petPetIDs)
  if not res:GetResult() then
    Log.exception(self._className, "UpdateMazeFormationInfo failed. ")
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  status:SetCustomData("PetPstIDs", petPetIDs)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
  status:SetCustomData("PetPstIDs", petPetIDs)
end
