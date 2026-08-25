local BP = bc.BattleProperty
local BattleCmdParserClient, Super = System.NewClass("BattleCmdParserClient")

function BattleCmdParserClient:ctor(parserEnv)
  Super.ctor(self)
  self.memberValues = {}
  self.cmdFuncs = {}
  self.parserEnv = parserEnv or {}
  self:InitMemberValue()
end

function BattleCmdParserClient:InitMemberValue()
  if not self.parserEnv.skillId then
    return
  end
  self:SetMemberValue("SkillLevel", self.parserEnv.skillLevel or 1)
  self.parserEnv.skillTypeInsideHealPer = 1
  local skillCfg = DT.Skill[self.parserEnv.skillId]
  if skillCfg then
    local formula = self:GetSkillConfigTQList("CoefficientTypelist")
    for i, f in ipairs(formula or {}) do
      local originalArgValue = 1
      local originalCoefficient = self:GetSkillConfigTQList("OriginalCoefficient")
      originalArgValue = originalCoefficient and originalCoefficient[i] or originalArgValue
      self:SetMemberValue("GrowArgValue", originalArgValue)
      local formulaValue = self:GetValueByCmd(formula[i])
      self:SetMemberValue("GrowArgValue" .. i, formulaValue)
    end
  end
end

function BattleCmdParserClient:GetSkillConfigTQText(colName)
  if not self.parserEnv.skillId then
    return
  end
  local skillCfg = DT.Skill[self.parserEnv.skillId]
  local tqText = skillCfg[colName]
  if not tqText then
    return
  end
  if not self.parserEnv.awaker then
    return
  end
  local bLv, pLv = BattleSkillUtils.GetBreakAndPotencyLevel(self.parserEnv.awaker)
  local breakSkillLevel = self.parserEnv.breakSkillLevel or bLv
  local potencyLevel = self.parserEnv.potencyLevel or pLv
  local params = {
    breakSkillLevel = breakSkillLevel,
    potencyLevel = potencyLevel,
    cmdParserClient = self
  }
  local text = BattleSkillUtils.GetMatchTQ(tqText, params)
  return text
end

function BattleCmdParserClient:GetSkillConfigTQList(colName)
  if not self.parserEnv.skillId then
    return
  end
  if not self.parserEnv.awaker then
    return
  end
  local skillCfg = DT.Skill[self.parserEnv.skillId]
  local tqList = skillCfg[colName]
  local bLv, pLv = BattleSkillUtils.GetBreakAndPotencyLevel(self.parserEnv.awaker)
  local breakSkillLevel = self.parserEnv.breakSkillLevel or bLv
  local potencyLevel = self.parserEnv.potencyLevel or pLv
  local list = BattleUtilServer.GetTQList(tqList, breakSkillLevel, potencyLevel)
  return list
end

function BattleCmdParserClient:__GetValueByCmd(cmdStr)
  if type(cmdStr) == "table" then
    return cmdStr
  end
  local value = tonumber(cmdStr)
  if value then
    return value
  end
  local cmdFunc = self.cmdFuncs[cmdStr]
  if not cmdFunc then
    local mt = {
      __index = System.fn(self, self.EnvMetaFunc)
    }
    local fenv = {}
    setmetatable(fenv, mt)
    cmdStr = cmdStr or "nil"
    
    function cmdFunc()
      do return (LoadFuncUtils.GetFunc(cmdStr)) end
      return LoadFuncUtils.GetFunc(cmdStr), fenv
    end
    
    if not cmdFunc then
      Logger:Error("语法错误:%s", cmdStr)
      return 0
    end
    self.cmdFuncs[cmdStr] = cmdFunc
  end
  return cmdFunc
end

function BattleCmdParserClient:GetValueByCmd(cmdStr)
  local cmdFunc = self:__GetValueByCmd(cmdStr)
  if type(cmdFunc) ~= "function" then
    return cmdFunc
  end
  local _, v = xpcall(cmdFunc, function(error)
    local str = string.format("指令运行错误 %s. error: %s", cmdStr, error)
    Logger:Warn(str)
  end)
  return v
end

function BattleCmdParserClient:GetValueByCmdList(cmdList)
  local ret = {}
  for _, cmdStr in ipairs(cmdList or {}) do
    table.insert(ret, self:GetValueByCmd(cmdStr))
  end
  return ret
end

function BattleCmdParserClient:GetValueListByCmd(cmdStr)
  if not cmdStr then
    return {}
  end
  local value = tonumber(cmdStr)
  if value then
    return {value}
  end
  local cmdFunc = self.cmdFuncs[cmdStr]
  if not cmdFunc then
    local mt = {
      __index = System.fn(self, self.EnvMetaFunc)
    }
    local fenv = {}
    setmetatable(fenv, mt)
    
    function cmdFunc()
      do return (LoadFuncUtils.GetFunc(cmdStr)) end
      return LoadFuncUtils.GetFunc(cmdStr), fenv
    end
    
    assert(cmdFunc, string.format("语法错误:%s", cmdStr))
    self.cmdFuncs[cmdStr] = cmdFunc
  end
  local ret = table.pack(xpcall(cmdFunc, function(error)
    local str = string.format("指令运行错误 %s. error: %s", cmdStr, error)
    Logger:Warn(str)
  end))
  if not ret[1] then
    return {0}
  end
  local values = {}
  for i, v in ipairs(ret) do
    if 1 ~= i then
      table.insert(values, v)
    end
  end
  return values
end

function BattleCmdParserClient:EnvMetaFunc(_, key)
  if _G[key] then
    return _G[key]
  end
  local DT = bg.DT
  if DT.CommonID[key] then
    return key
  end
  if not DT.BattleApi[key] then
    return key
  end
  local apiCfg = DT.BattleApi[key]
  if apiCfg.ApiType == bc.ApiType.TARGET then
    do return self.GenerateTargetsExp, self end
    return self.GenerateTargetsExp, self, key, nil
  elseif apiCfg.ApiType == bc.ApiType.FORMULA then
    local formulaStr = apiCfg.Data
    do return self.GetValueByCmd, self end
    return self.GetValueByCmd, self, formulaStr
  elseif apiCfg.ApiType == bc.ApiType.CMD_MEMBER then
    do return self.GetMemberValue, self end
    return self.GetMemberValue, self, key, formulaStr
  elseif apiCfg.ApiType == bc.ApiType.CARD then
    do return self.GenerateTargetsExp, self end
    return self.GenerateTargetsExp, self, key, formulaStr
  elseif apiCfg.ApiType == bc.ApiType.GLOBAL_FUNC then
    do return System.fn, self end
    return System.fn, self, self[key], formulaStr
  elseif apiCfg.ApiType == bc.ApiType.FUNC then
    do return System.fn, self end
    return System.fn, self, self[key], formulaStr
  elseif apiCfg.ApiType == bc.ApiType.GLOBAL_VALUE then
    do return self.GetGlobalValue, self end
    return self.GetGlobalValue, self, key, formulaStr
  elseif apiCfg.ApiType == bc.ApiType.STASTICS then
    do return self.GenerateStasticsExp, self end
    return self.GenerateStasticsExp, self, key, formulaStr
  elseif apiCfg.ApiType == bc.ApiType.CARD_DECK then
    do return self.GenerateCardDeckExp, self end
    return self.GenerateCardDeckExp, self, key, formulaStr
  else
    Logger.Warn("GetCmdValue failed: " .. key .. apiCfg.ApiType)
    return key
  end
end

local function GetAvgAttr(attrName)
  if bg.battleScene then
    local awakerList = bg.battleScene:GetPlayerAwakerList()
    local totalValue = 0
    for _, awaker in ipairs(awakerList) do
      local value = awaker:GetProperty(attrName)
      totalValue = value + totalValue
    end
    if #awakerList > 0 then
      totalValue = math.ceil(totalValue / #awakerList)
    end
    return totalValue
  end
  if WorldStageManager.Instance:IsInStage() then
    do return WorldStageManager.Instance.GetAwakerAvgAttr, WorldStageManager.Instance end
    return WorldStageManager.Instance.GetAwakerAvgAttr, WorldStageManager.Instance, attrName, totalValue / #awakerList, ipairs(awakerList)
  end
end

local GlobalValueFunc = {
  Layer = function(parser)
    if not parser.parserEnv.state then
      return 0
    end
    local state = parser.parserEnv.state
    return state.layer
  end,
  ChangedLayer = function(parser)
    if not parser.parserEnv.state then
      return 0
    end
    local state = parser.parserEnv.state
    return state.changedLayer or state.layer
  end,
  PVPTeam1 = function(_)
    return bc.BattleCamp.Camp1
  end,
  PVPTeam2 = function(_)
    return bc.BattleCamp.Camp2
  end,
  CurBoutNum = function(parser)
    if not bg.battleRender then
      return 0
    end
    do return bg.battleRender.boutMgr.GetBoutNum end
    return bg.battleRender.boutMgr.GetBoutNum, bg.battleRender.boutMgr
  end,
  MonsterNum = function(parser)
    if not bg.battleScene then
      return 0
    end
    local camp = bg.battleDataCenter:GetMyCamp()
    local enemyCamp = bc.BattleCamp:GetEnemyCamp(camp)
    local roleList = bg.battleScene:GetAliveRoleListByCamp(enemyCamp)
    return #roleList
  end,
  BattleType = function(parser)
    if not bg.battleScene then
      return
    end
    local battleTid = bg.battleScene.battleId
    local battleCfg = DT.BattleConfig[battleTid]
    return battleCfg.BattleType
  end,
  TeamLevel = function(parser)
    if not bg.battleScene then
      do return end
      return TeamDataUtils.GetCurTeamLevel, nil, nil, nil, nil, nil, nil, nil, nil
    end
    local awakerList = bg.battleScene:GetPlayerAwakerList()
    local lv = 0
    for _, awaker in ipairs(awakerList) do
      lv = awaker.level + lv
    end
    if #awakerList > 0 then
      lv = math.ceil(lv / #awakerList)
    end
    return lv
  end,
  IsDimensionBout = function(parser)
    if not bg.battleRender then
      return 0
    end
    do return bg.battleRender.boutMgr.GetIsExtraBout end
    return bg.battleRender.boutMgr.GetIsExtraBout, bg.battleRender.boutMgr
  end,
  money = function(parser)
    if not bg.battleDataCenter or not bg.battleDataCenter.playerDataModel then
      return 0
    end
    return bg.battleDataCenter.playerDataModel.money or 0
  end,
  TeamAtk = function(parser)
    if bg.battleScene then
      local awakerList = bg.battleScene:GetPlayerAwakerList()
      local totalAtk = 0
      for _, awaker in ipairs(awakerList) do
        local atk = awaker:GetProperty(BP.atk)
        local atk_per = awaker:GetProperty(BP.atk_per)
        local final_atk = math.ceil(atk * (1 + atk_per / 100))
        totalAtk = final_atk + totalAtk
      end
      if #awakerList > 0 then
        totalAtk = math.ceil(totalAtk / #awakerList)
      end
      return totalAtk
    end
    if WorldStageManager.Instance:IsInStage() then
      do return WorldStageManager.Instance.GetTeamAtk end
      return WorldStageManager.Instance.GetTeamAtk, WorldStageManager.Instance, math.ceil(totalAtk / #awakerList), totalAtk / #awakerList, ipairs(awakerList)
    end
    do return end
    return TeamDataUtils.GetCurTeamAtk, WorldStageManager.Instance, math.ceil(totalAtk / #awakerList), totalAtk / #awakerList, ipairs(awakerList)
  end,
  AvgCrit = function(parser)
    do return GetAvgAttr end
    return GetAvgAttr, BP.crit
  end,
  AvgCritDamage = function(parser)
    do return GetAvgAttr end
    return GetAvgAttr, BP.crit_damage
  end,
  AvgDefence = function(parser)
    do return GetAvgAttr end
    return GetAvgAttr, BP.def
  end,
  AvgPhysique = function(parser)
    do return GetAvgAttr end
    return GetAvgAttr, BP.physique
  end,
  BoutNum = function(parser)
    if not bg.battleRender then
      return 0
    end
    do return bg.battleRender.boutMgr.GetBoutNum end
    return bg.battleRender.boutMgr.GetBoutNum, bg.battleRender.boutMgr
  end,
  TeamOccMaster = function(parser)
    if bg.battleScene then
      local awakerList = bg.battleScene:GetPlayerAwakerList()
      local totalAtk = 0
      for _, awaker in ipairs(awakerList) do
        local atk = awaker:GetProperty(BP.atk)
        local atk_per = awaker:GetProperty(BP.atk_per)
        local final_atk = math.ceil(atk * (1 + atk_per / 100))
        totalAtk = final_atk + totalAtk
      end
      if #awakerList > 0 then
        totalAtk = math.ceil(totalAtk / #awakerList)
      end
      return totalAtk
    end
    if WorldStageManager.Instance:IsInStage() then
      do return WorldStageManager.Instance.GetAwakerAvgAttr, WorldStageManager.Instance end
      return WorldStageManager.Instance.GetAwakerAvgAttr, WorldStageManager.Instance, BP.occupation_master, totalAtk / #awakerList, ipairs(awakerList)
    end
    do return end
    return TeamDataUtils.GetTeamOccMaster, WorldStageManager.Instance, BP.occupation_master, totalAtk / #awakerList, ipairs(awakerList)
  end,
  StageStar = function(parser)
    return 0
  end,
  CurCamp = function(parser)
    if not bg.battleRender then
      return
    end
    do return bg.battleRender.boutMgr.GetCamp end
    return bg.battleRender.boutMgr.GetCamp, bg.battleRender.boutMgr
  end,
  CurrentCmdTargetCount = function(parser)
    return 0
  end,
  IsOutofStage = function(_)
    return not WorldStageManager.Instance:IsInStage()
  end,
  IsInStage = function(_)
    return WorldStageManager.Instance:IsInStage() and bg.battleScene == nil
  end,
  IsInBattle = function(_)
    return bg.battleScene ~= nil
  end,
  GetAwakerByID = function(parser, awakerTid)
    do return parser.GetAwakerByID, parser end
    return parser.GetAwakerByID, parser, awakerTid
  end
}

function BattleCmdParserClient:GetGlobalValue(key)
  local sub = string.sub(key, 1, 3)
  if "Arg" == sub then
    local argIndex = tonumber(string.replace(key, "Arg", "", true))
    if self.params[argIndex] then
      return self.params[argIndex] or 0
    else
      local params = self:GetValueListByCmd(self.configPara)
      return params[argIndex] or 0
    end
  end
  sub = string.sub(key, 1, 8)
  if "StateArg" == sub then
    local argIndex = tonumber(string.replace(key, "StateArg", "", true))
    if self.state then
      return self:GetValueByCmd(self.state.stateParams[argIndex]) or 0
    else
      return 0
    end
  end
  if GlobalValueFunc[key] then
    do return GlobalValueFunc[key] end
    return GlobalValueFunc[key], self, self, self.state.stateParams[argIndex], string.replace(key, "StateArg", "", true)
  end
end

local TargetFunc = {
  PlayerRole = function(parser)
    do return parser.GetPlayerRole end
    return parser.GetPlayerRole, parser
  end,
  CmdCaster = function(parser)
    local target = parser:GetAwaker() or parser:GetPlayerRole()
    return target
  end,
  TargetCmdOwner = function(parser)
    return parser:GetAwaker() or parser:GetPlayerRole()
  end,
  CurCard = function(parser)
    do return parser.GetCard end
    return parser.GetCard, parser
  end,
  OwnerCard = function(parser)
    do return parser.GetCard end
    return parser.GetCard, parser
  end,
  CurCaster = function(parser)
    return parser:GetAwaker() or parser:GetPlayerRole()
  end,
  StateOwner = function(parser)
    do return parser.GetStateOwner end
    return parser.GetStateOwner, parser
  end,
  StateCaster = function(parser)
    do return parser.GetStateCaster end
    return parser.GetStateCaster, parser
  end
}

function BattleCmdParserClient:GetStateOwner()
  local state = self.parserEnv.state
  if not state then
    if self.parserEnv.card then
      do return self.GetCard, self end
      return self.GetCard, self, self.parserEnv.card, nil, nil, nil, nil
    end
    local skillConfig = DT.Skill[self.parserEnv.skillId]
    if not skillConfig then
      return
    end
    if string.find(skillConfig.Type[1], "Card") then
      do return self.VirtualObj, self end
      return self.VirtualObj, self, {
        awaker = self:GetAwaker()
      }, self:GetAwaker(), self, nil
    end
    return self:GetAwaker() or self:GetPlayerRole()
  end
  if bg.battleScene then
    local ownerUid = state.ownerUid
    if state.stateType == bc.StateType.Awaker or state.stateType == bc.StateType.Role then
      do return bg.battleDataCenter.GetRoleDataModel, bg.battleDataCenter end
      return bg.battleDataCenter.GetRoleDataModel, bg.battleDataCenter, ownerUid, self:GetAwaker(), self, nil
    end
    if state.stateType == bc.StateType.Card then
      do return bg.battleRender.cardMgr.GetCardByUid, bg.battleRender.cardMgr end
      return bg.battleRender.cardMgr.GetCardByUid, bg.battleRender.cardMgr, ownerUid, self:GetAwaker(), self, nil
    end
  elseif state.ownerData then
    local ownerUid = state.ownerData.uid
    local ownerTid = state.ownerData.tid
    local ownerType = state.ownerData.targetType
    if "Card" == ownerType then
      local cardData = CardDataUtils.GetCardInfo(ownerUid)
      local o = self:GetCard(cardData)
      return o
    end
    if "Awaker" == ownerType then
      local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(ownerTid)
      do return self.GetAwaker, self end
      return self.GetAwaker, self, awakerData
    end
    if "PlayerRole" == ownerType then
      do return self.GetPlayerRole end
      return self.GetPlayerRole, self, self, awakerData
    end
  else
    if self.parserEnv.card then
      do return self.GetCard, self end
      return self.GetCard, self, self.parserEnv.card, self.GetPlayerRole, self, self, awakerData
    end
    local skillConfig = DT.Skill[self.parserEnv.skillId]
    if not skillConfig then
      return
    end
    if string.find(skillConfig.Type[1], "Card") then
      do return self.VirtualObj, self end
      return self.VirtualObj, self, {
        awaker = self:GetAwaker()
      }, self:GetAwaker(), self, awakerData
    end
    return self:GetAwaker() or self:GetPlayerRole()
  end
end

function BattleCmdParserClient:GetStateCaster()
  if bg.battleScene then
    local state = self.parserEnv.state
    if not state then
      return
    end
    do return bg.battleDataCenter.GetRoleDataModel, bg.battleDataCenter end
    return bg.battleDataCenter.GetRoleDataModel, bg.battleDataCenter, state.castRoleUid, nil
  else
    local stateData = self.parserEnv.state
    if not stateData then
      return
    end
    local awaker = CopyAwakerDataUtils.GetBattleAwakerData(stateData.castRoleUid)
    if not awaker then
      self:GetPlayerRole()
    end
    do return self.GetAwaker, self end
    return self.GetAwaker, self, awaker
  end
end

function BattleCmdParserClient:GenerateTargets(targetType)
  if TargetFunc[targetType] then
    do return TargetFunc[targetType] end
    return TargetFunc[targetType], self, nil
  end
  Logger.Warn("GenerateTargets failed: " .. targetType)
  do return self.GetAwaker end
  return self.GetAwaker, self, targetType
end

function BattleCmdParserClient:GenerateTargetsExp(targetType)
  local target = self:GenerateTargets(targetType)
  local targetsExp = BattleTargetExpClient(self, {target})
  return targetsExp
end

function BattleCmdParserClient:GenerateCardDeckExp(deckName)
  local exp = BattleCardDeckExpClient(self, deckName)
  return exp
end

function BattleCmdParserClient:GenerateStasticsExp(statsType)
  local exp = BattleStatsExpClient(self, statsType)
  return exp
end

function BattleCmdParserClient:SetMemberValue(key, value)
  self.memberValues[key] = value
end

function BattleCmdParserClient:GetMemberValue(key)
  return self.memberValues[key]
end

function BattleCmdParserClient:VirtualObj(obj, exFunc, attrFunc)
  local getter = {
    __index = function(_, key)
      if "GetProperty" == key then
        if obj[key] then
          return obj[key]
        end
        return function(_, propertyName)
          if not propertyName then
            return 0
          end
          if not obj.attrs then
            return 0
          end
          if attrFunc and attrFunc[propertyName] then
            do return end
            return attrFunc[propertyName]
          end
          return obj.attrs[propertyName] or 0
        end
      end
      if "awaker" == key then
        if obj[key] then
          return obj[key]
        end
        do return self.GetAwaker end
        return self.GetAwaker, self
      end
      if exFunc and exFunc[key] then
        return exFunc[key]
      end
      if attrFunc and attrFunc[key] then
        do return end
        return attrFunc[key], self
      end
      return obj[key]
    end
  }
  do return setmetatable, {} end
  return setmetatable, {}, getter
end

function BattleCmdParserClient:GetAwaker(originAwaker)
  originAwaker = originAwaker or self.parserEnv.awaker
  if not self.parserEnv.awaker and self.parserEnv.skillId and bg.battleDataCenter then
    local skillCfg = DT.Skill[self.parserEnv.skillId]
    if skillCfg and skillCfg.AwakerID then
      local awakerBySkill = bg.battleDataCenter:GetAwakerDataModelByCfgId(skillCfg.AwakerID)
      if awakerBySkill then
        originAwaker = awakerBySkill
      end
    end
  end
  if not originAwaker then
    return
  end
  if not originAwaker.GetProperty then
    local exFunc = {
      IsRoleType = function(_, roleType, orRoleType)
        return roleType == bc.RoleType.Awaker or orRoleType == bc.RoleType.Awaker
      end
    }
    originAwaker = self:VirtualObj(originAwaker, exFunc)
  end
  return originAwaker
end

function BattleCmdParserClient:IsHaveAwaker(awakerTid)
  if bg.battleScene then
    local awakerList = bg.battleScene:GetPlayerAwakerList()
    for _, awaker in ipairs(awakerList) do
      if awaker.tid == awakerTid then
        return true
      end
    end
  end
  if WorldStageManager.Instance:IsInStage() and CopyAwakerDataUtils.GetBattleAwakerData(awakerTid) then
    return true
  end
  return false
end

function BattleCmdParserClient:GetSpecialSchoolAwakerNum(constantKey)
  local constantCfg = DT.Constant[constantKey]
  if not constantCfg or not constantCfg.Data then
    return 0
  end
  local specialAwakerList = constantCfg.Data
  local count = 0
  if bg.battleScene then
    local awakerList = bg.battleScene:GetPlayerAwakerList()
    for _, awaker in ipairs(awakerList) do
      if table.contains(specialAwakerList, awaker.tid) then
        count = count + 1
      end
    end
  elseif WorldStageManager.Instance:IsInStage() then
    for _, awakerTid in ipairs(specialAwakerList) do
      if CopyAwakerDataUtils.GetBattleAwakerData(awakerTid) then
        count = count + 1
      end
    end
  else
    local teamAwakerTids = TeamDataUtils.GetTeamAwakerTids()
    for _, awakerTid in ipairs(specialAwakerList) do
      if table.contains(teamAwakerTids, awakerTid) then
        count = count + 1
      end
    end
  end
  return count
end

function BattleCmdParserClient:GetCard(originCard)
  originCard = originCard or self.parserEnv.card
  if not originCard then
    return
  end
  originCard = self:VirtualObj(originCard)
  return originCard
end

function BattleCmdParserClient:GetAwakerByID(awakerTid)
  if bg.battleDataCenter then
    local awaker = bg.battleDataCenter:GetAwakerDataModelByCfgId(awakerTid)
    do return BattleTargetExpClient, self end
    return BattleTargetExpClient, self, {awaker}, awaker
  end
  do return BattleTargetExpClient, self end
  return BattleTargetExpClient, self, {}, {awaker}, awaker
end

function BattleCmdParserClient:GetPlayerRole()
  if bg.battleDataCenter then
    do return bg.battleDataCenter.GetPlayerRoleDataModel end
    return bg.battleDataCenter.GetPlayerRoleDataModel, bg.battleDataCenter, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local playerInfo = DataCenter.playerData.DRole
  local exFunc = {
    IsRoleType = function(_, roleType, orRoleType)
      return roleType == bc.RoleType.Player or orRoleType == bc.RoleType.Player
    end
  }
  local attrFunc = {
    TeamAtk = function()
      do return GlobalValueFunc.TeamAtk end
      return GlobalValueFunc.TeamAtk, self
    end,
    AvgPhysique = function()
      do return GlobalValueFunc.AvgPhysique end
      return GlobalValueFunc.AvgPhysique, self
    end,
    AvgDefence = function()
      do return GlobalValueFunc.AvgDefence end
      return GlobalValueFunc.AvgDefence, self
    end,
    AvgCrit = function()
      do return GlobalValueFunc.AvgCrit end
      return GlobalValueFunc.AvgCrit, self
    end,
    AvgCritDamage = function()
      do return GlobalValueFunc.AvgCritDamage end
      return GlobalValueFunc.AvgCritDamage, self
    end
  }
  local stageData = WorldStageManager.Instance:GetCurStageData()
  local isMainScene = SceneMgr.Instance:IsInTown()
  if stageData and stageData.role and not isMainScene then
    playerInfo = table.clone(stageData.role)
    for k, v in pairs(playerInfo.roleAttrsList[0] or {}) do
      playerInfo.attrs[k] = v
    end
    
    function exFunc.GetSchoolConfigId()
      return playerInfo.school
    end
  end
  
  function exFunc.GetStateLayer(_, stateId)
    do return StateDataUtils.GetLayer end
    return StateDataUtils.GetLayer, stateId
  end
  
  local originPlayer = self:VirtualObj(playerInfo, exFunc, attrFunc)
  return originPlayer
end

function BattleCmdParserClient:GetSkillType()
  local card = self:GetCard()
  if card and card.GetType then
    do return card.GetType end
    return card.GetType, card, nil
  end
  return self:GetSkillConfigTQList("Type") or {}
end

function BattleCmdParserClient:IsCardTypeMatch(card, cardTypes)
  if not card or type(cardTypes) ~= "table" then
    return false
  end
  if card.CardTypeMatch then
    do return card.CardTypeMatch, card end
    return card.CardTypeMatch, card, cardTypes, nil, nil, nil, nil, nil, nil, nil
  end
  local curTypes
  if card.GetType then
    curTypes = card:GetType()
  else
    curTypes = card.Type
  end
  if type(curTypes) ~= "table" then
    curTypes = curTypes and {curTypes} or {}
  end
  for _, t in ipairs(curTypes) do
    if table.contains(cardTypes, t) then
      return true
    end
  end
  return false
end

function BattleCmdParserClient:GetSkillArgsPlus(paraPlusName)
  local skillArgsPlus = 0
  local paraPlus = self:GetSkillConfigTQText("ParaPlus")
  if paraPlus and paraPlusName then
    local valueList = self:GetValueListByCmd(paraPlus)
    local idx = tonumber(string.sub(paraPlusName, 9)) or 0
    skillArgsPlus = valueList[idx] or skillArgsPlus
  end
  return skillArgsPlus
end

function BattleCmdParserClient:ShouldSkipNewChaosKeeperskillForStateTag()
  local env = self.parserEnv or {}
  return env.isTrigger or env.noDirectCmd
end

function BattleCmdParserClient:GetNewChaosKeeperskillParams()
  local player = self:GetPlayerRole()
  if not player then
    return 0, 0, 0
  end
  local is_chaos_type2 = player:GetProperty(BP.is_chaos_type2) or 0
  if 0 == is_chaos_type2 then
    return 0, 0, 0
  end
  local skillTypes = self:GetSkillType()
  for _, skillType in ipairs(skillTypes) do
    if skillType == bc.SkillType.Card_Potion then
      return 0, 0, is_chaos_type2
    end
  end
  local keeperskillAtkPer = player:GetProperty(BP.keeperskill_atk_per) or 0
  local keeperskillDefPer = player:GetProperty(BP.keeperskill_def_per) or 0
  return keeperskillAtkPer, keeperskillDefPer, is_chaos_type2
end

function BattleCmdParserClient:IsStateTriggerAdd()
  local env = self.parserEnv or {}
  return env.isTrigger
end

function BattleCmdParserClient:GetUnitFromExp(targetExp)
  if not targetExp then
    return nil
  end
  if not targetExp.GetTarget then
    return nil
  end
  do return targetExp.GetTarget end
  return targetExp.GetTarget, targetExp
end

function BattleCmdParserClient:GetTargetBeDmgPerMul(target, skillTypes, card)
  local multi = 1
  if not target or not target.GetProperty then
    return multi
  end
  local keys = {
    BP.be_damage_per,
    BP.be_damage_per2,
    BP.be_damage_per3
  }
  for _, key in ipairs(keys) do
    multi = multi * (1 + (target:GetProperty(key) or 0) / 100)
  end
  if self:IsStateTriggerAdd() then
    return multi
  end
  skillTypes = skillTypes or self:GetSkillType() or {}
  if table.contains(skillTypes, bc.SkillType.Ulti_Skill) then
    local per4 = target:GetProperty(BP.be_damage_per4) or 0
    if 0 ~= per4 then
      multi = multi * (1 + per4 / 100)
    end
  end
  if card and self:IsCardTypeMatch(card, bc.CardTypeInstruction) then
    local per5 = target:GetProperty(BP.be_damage_per5) or 0
    if 0 ~= per5 then
      multi = multi * (1 + per5 / 100)
    end
  end
  return multi
end

function BattleCmdParserClient:GetCurCmdShowDamage(value, paraPlusName, casterExp, targetExp)
  if casterExp and not self:GetUnitFromExp(casterExp) then
    return 0
  end
  local showDamage = self:__GetShowDamage(value, paraPlusName)
  if not targetExp then
    return showDamage
  end
  local target = self:GetUnitFromExp(targetExp)
  if not target then
    return 0
  end
  local mul = self:GetTargetBeDmgPerMul(target, self:GetSkillType(), self:GetCard())
  do return math.max, (math.ceil(showDamage * mul)) end
  return math.max, math.ceil(showDamage * mul), 1, self:GetCard()
end

function BattleCmdParserClient:__GetShowDamage(value, paraPlusName)
  local caster = self:GetAwaker() or self:GetPlayerRole()
  local player = self:GetPlayerRole()
  local card = self:GetCard()
  local skillTypes = self:GetSkillType()
  local roleWeakPer, basicDamagePer, roleEnhancePer
  local strength = 0
  local isPVE = SceneMgr.Instance and SceneMgr.Instance:IsInCopies() or bg.isPVE
  if (not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker)) and isPVE then
    roleWeakPer = player:GetProperty(BP.weak_per)
    basicDamagePer = player:GetProperty(BP.basic_damage_per)
    roleEnhancePer = player:GetProperty(BP.enhance_per)
    strength = player:GetProperty(BP.damage_plus)
  elseif isPVE or bg.isPVP then
    roleWeakPer = caster:GetProperty(BP.weak_per)
    roleEnhancePer = caster:GetProperty(BP.enhance_per)
    basicDamagePer = caster:GetProperty(BP.basic_damage_per)
  else
    roleWeakPer = 0
    roleEnhancePer = 0
    basicDamagePer = 0
  end
  local playerOutsideDamagePer = 0
  local playerInsideDamagePer = 0
  if bg.isPVP then
    playerOutsideDamagePer = player:GetProperty(BP.o_damage_per)
    playerInsideDamagePer = player:GetProperty(BP.i_damage_per)
  end
  local skillArgsPlus = self:GetSkillArgsPlus(paraPlusName)
  local awakerOutsideDamagePer = 0
  local awakerInsideDamagePer = 0
  local awakerStrengthMultiple = 0
  local skillTypeOutsideDmgPer = 1
  local skillTypeInsideDmgPer = 1
  local skillTypeDmgPer = 1
  local cardOutsideDmgPer = 0
  local cardInsideDmgPer = 0
  local ultiDamgePlus = 0
  local cardStrengthMultiple = 0
  local ultiStrengthMultiple = 0
  local strikecard_damage_plus = 0
  local awakerInsideDamagePer1 = 0
  local awakerInsideDamagePer2 = 0
  local awakerInsideDamagePer3 = 0
  local awakerInsideDamagePer4 = 0
  local awakerInsideDamagePer5 = 0
  local awakerInsideDamagePer6 = 0
  local awakerInsideDamagePer7 = 0
  local awakerInsideDamagePer8 = 0
  local awakerInsideBasicDamagePer = 0
  local awaker_CmdCard_dmg_per = 0
  local awaker_ulti_dmg_per = 0
  local dimension_fix_per = 0
  local cardDamagePer2 = 0
  local cardDamagePer3 = 0
  local awakerDamagePlus = 0
  if not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awakerOutsideDamagePer = caster:GetProperty(BP.o_damage_per)
    awakerInsideDamagePer = caster:GetProperty(BP.i_damage_per)
    awakerInsideDamagePer1 = caster:GetProperty(BP.i_damage_per1)
    awakerInsideDamagePer2 = caster:GetProperty(BP.i_damage_per2)
    awakerInsideDamagePer3 = caster:GetProperty(BP.i_damage_per3)
    awakerInsideDamagePer4 = caster:GetProperty(BP.i_damage_per4)
    awakerInsideDamagePer5 = caster:GetProperty(BP.i_damage_per5)
    awakerInsideDamagePer6 = caster:GetProperty(BP.i_damage_per6)
    awakerInsideDamagePer7 = caster:GetProperty(BP.i_damage_per7)
    awakerInsideDamagePer8 = caster:GetProperty(BP.i_damage_per8)
    awakerInsideBasicDamagePer = caster:GetProperty(BP.i_basic_damage_per)
    awakerDamagePlus = awakerDamagePlus + caster:GetProperty(BP.only_damage_plus)
    strength = strength + caster:GetProperty(BP.damage_plus)
    awaker_CmdCard_dmg_per = caster:GetProperty(BP.awaker_CmdCard_dmg_per) or 0
    for _, skillType in ipairs(skillTypes) do
      skillTypeInsideDmgPer = skillTypeInsideDmgPer * (1 + caster:GetProperty(bc.SkillType2InsideDamagePer[skillType]) / 100)
      skillTypeOutsideDmgPer = skillTypeOutsideDmgPer * (1 + caster:GetProperty(bc.SkillType2OutsideDamagePer[skillType]) / 100)
      skillTypeDmgPer = skillTypeDmgPer * (1 + caster:GetProperty(bc.SkillType2DamagePer[skillType]) / 100)
      if skillType == bc.SkillType.Ulti_Skill then
        ultiDamgePlus = ultiDamgePlus + caster:GetProperty(BP.ulti_damage_plus)
        ultiStrengthMultiple = ultiStrengthMultiple + caster:GetProperty(BP.ulti_strength_multiple)
        awaker_ulti_dmg_per = caster:GetProperty(BP.awaker_ulti_dmg_per) or 0
      end
      if skillType == bc.SkillType.Card_Strike then
        strikecard_damage_plus = strikecard_damage_plus + caster:GetProperty(BP.strikecard_damage_plus)
      end
    end
    awakerStrengthMultiple = caster:GetProperty(BP.awaker_strength_multiple)
    if card then
      cardInsideDmgPer = caster:GetProperty(BP.i_damage_per_card)
      cardOutsideDmgPer = caster:GetProperty(BP.o_damage_per_card)
    end
  end
  local curCardDamagePer = 0
  local cardDamagePlus = 0
  if card then
    curCardDamagePer = card:GetProperty(BP.card_damage_per)
    cardDamagePlus = card:GetProperty(BP.card_damage_plus)
    cardStrengthMultiple = card:GetProperty(BP.card_strength_multiple)
    cardDamagePer2 = card:GetProperty(BP.card_damage_per2)
    cardDamagePer3 = card:GetProperty(BP.card_damage_per3)
  end
  dimension_fix_per = player and player:GetProperty(BP.dimension_fix_per) or caster and caster:GetProperty(BP.dimension_fix_per) or 0
  if strength > 0 then
    strength = strength * (1 + awakerStrengthMultiple / 100 + cardStrengthMultiple / 100 + ultiStrengthMultiple / 100)
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local data = {
    value = value,
    awakerOutsideDamagePer = awakerOutsideDamagePer,
    awakerInsideBasicDamagePer = awakerInsideBasicDamagePer,
    playerOutsideDamagePer = playerOutsideDamagePer,
    cardOutsideDmgPer = cardOutsideDmgPer,
    curCardDamagePer = curCardDamagePer,
    basicDamagePer = basicDamagePer,
    skillTypeOutsideDmgPer = skillTypeOutsideDmgPer,
    skillTypeDmgPer = skillTypeDmgPer,
    roleEnhancePer = roleEnhancePer,
    roleWeakPer = roleWeakPer,
    awakerInsideDamagePer = awakerInsideDamagePer,
    awakerInsideDamagePer1 = awakerInsideDamagePer1,
    awakerInsideDamagePer2 = awakerInsideDamagePer2,
    awakerInsideDamagePer3 = awakerInsideDamagePer3,
    awakerInsideDamagePer4 = awakerInsideDamagePer4,
    awakerInsideDamagePer5 = awakerInsideDamagePer5,
    awakerInsideDamagePer6 = awakerInsideDamagePer6,
    awakerInsideDamagePer7 = awakerInsideDamagePer7,
    awakerInsideDamagePer8 = awakerInsideDamagePer8,
    playerInsideDamagePer = playerInsideDamagePer,
    dimension_fix_per = dimension_fix_per,
    cardInsideDmgPer = cardInsideDmgPer,
    cardDamagePer2 = cardDamagePer2,
    cardDamagePer3 = cardDamagePer3,
    awaker_CmdCard_dmg_per = awaker_CmdCard_dmg_per,
    awaker_ulti_dmg_per = awaker_ulti_dmg_per,
    skillTypeInsideDmgPer = skillTypeInsideDmgPer,
    cardDamagePlus = cardDamagePlus,
    strength = strength,
    ultiDamgePlus = ultiDamgePlus,
    strikecard_damage_plus = strikecard_damage_plus,
    skillArgsPlus = skillArgsPlus,
    awakerDamagePlus = awakerDamagePlus,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2
  }
  do return BattleUtilServer.ShowDamageFormula end
  return BattleUtilServer.ShowDamageFormula, data, BP.strikecard_damage_plus
end

function BattleCmdParserClient:__GetShowBlock(value, paraPlusName)
  local caster = self:GetAwaker() or self:GetPlayerRole()
  local player = self:GetPlayerRole()
  local awakerOutsideBlockPer = 0
  local playerOutsideBlockPer = 0
  local awakerInsideBlockPer = 0
  local playerInsideBlockPer = 0
  local skillTypeBlockPer = 1
  local skillTypeInsideBlockPer = 1
  local cardBlockPer = 0
  local curCardBlockPer = 0
  local cardBlockPlus = 0
  local awakerFrailPer
  local awakerBlockPlus = 0
  local ultiBlockPer = 0
  local instructcardFinalBlockPer = 0
  local cardBlockPer2 = 0
  local awaker_CmdCard_block_per = 0
  local awaker_ulti_block_per = 0
  local dimension_fix_per = 0
  local isPVE = SceneMgr.Instance and SceneMgr.Instance:IsInCopies() or bg.isPVE
  if (not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker)) and isPVE then
    awakerFrailPer = player:GetProperty(BP.frail_per)
    awakerBlockPlus = player:GetProperty(BP.block_plus)
  elseif bg.isPVP then
    awakerFrailPer = caster:GetProperty(BP.frail_per)
  end
  if bg.isPVP then
    playerInsideBlockPer = player:GetProperty(BP.i_block_per)
    playerOutsideBlockPer = player:GetProperty(BP.o_block_per)
  end
  local card = self:GetCard()
  local skillTypes = self:GetSkillType()
  if not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awakerOutsideBlockPer = caster:GetProperty(BP.o_block_per)
    awakerInsideBlockPer = caster:GetProperty(BP.i_block_per)
    awakerBlockPlus = awakerBlockPlus + caster:GetProperty(BP.block_plus)
    instructcardFinalBlockPer = caster:GetProperty(BP.instructcard_final_block_per)
    awaker_CmdCard_block_per = caster:GetProperty(BP.awaker_CmdCard_block_per) or 0
    for _, skillType in ipairs(skillTypes) do
      skillTypeBlockPer = skillTypeBlockPer * (1 + caster:GetProperty(bc.SkillType2BlockPer[skillType]) / 100)
      skillTypeInsideBlockPer = skillTypeInsideBlockPer * (1 + caster:GetProperty(bc.SkillType2InsideBlockPer[skillType]) / 100)
      if skillType == bc.SkillType.Ulti_Skill then
        ultiBlockPer = caster:GetProperty(BP.ulti_block_per)
        awaker_ulti_block_per = caster:GetProperty(BP.awaker_ulti_block_per)
      end
    end
    if card then
      cardBlockPer = caster:GetProperty(BP.block_per_card)
    end
  end
  if card then
    curCardBlockPer = card:GetProperty(BP.card_block_per)
    cardBlockPlus = card:GetProperty(BP.card_block_plus)
    cardBlockPer2 = card:GetProperty(BP.card_block_per2)
  end
  dimension_fix_per = player and player:GetProperty(BP.dimension_fix_per) or caster and caster:GetProperty(BP.dimension_fix_per) or 0
  local skillArgsPlus = self:GetSkillArgsPlus(paraPlusName)
  local _, keeperskillDefPer, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local data = {
    value = value,
    awakerOutsideBlockPer = awakerOutsideBlockPer,
    playerOutsideBlockPer = playerOutsideBlockPer,
    curCardBlockPer = curCardBlockPer,
    cardBlockPer = cardBlockPer,
    ultiBlockPer = ultiBlockPer,
    skillTypeBlockPer = skillTypeBlockPer,
    awakerBlockPlus = awakerBlockPlus,
    cardBlockPlus = cardBlockPlus,
    skillArgsPlus = skillArgsPlus,
    awakerFrailPer = awakerFrailPer,
    awakerInsideBlockPer = awakerInsideBlockPer,
    playerInsideBlockPer = playerInsideBlockPer,
    instructcardFinalBlockPer = instructcardFinalBlockPer,
    dimension_fix_per = dimension_fix_per,
    skillTypeInsideBlockPer = skillTypeInsideBlockPer,
    cardBlockPer2 = cardBlockPer2,
    awaker_CmdCard_block_per = awaker_CmdCard_block_per,
    awaker_ulti_block_per = awaker_ulti_block_per,
    keeperskill_def_per = keeperskillDefPer,
    is_chaos_type2 = is_chaos_type2
  }
  do return BattleUtilServer.ShowBlockFormula end
  return BattleUtilServer.ShowBlockFormula, data, caster, BP.awaker_ulti_block_per
end

function BattleCmdParserClient:__GetShowHeal(value, paraPlusName)
  local caster = self:GetAwaker() or self:GetPlayerRole()
  local player = self:GetPlayerRole()
  local card = self:GetCard()
  local skillTypes = self:GetSkillType()
  local awakerOutsideHealPer = 0
  local awakerInsideHealPer = 0
  local playerOutsideHealPer = 0
  local playerInsideHealPer = 0
  local awakerHealPlus = 0
  local curCardHealPer = 0
  local cardHealPlus = 0
  local skillTypeHealPer = 1
  local cardInsideHealPer = 0
  local cardOutsideHealPer = 0
  local skillTypeInsideHealPer = 1
  local allDealHealPer = 0
  local dying_per = 0
  local dying_per2 = 0
  local cardHealPer2 = 0
  local awaker_CmdCard_heal_per = 0
  local awaker_ulti_heal_per = 0
  local dimension_fix_per = 0
  if bg.isPVP then
    playerOutsideHealPer = player:GetProperty(BP.o_heal_per)
    playerInsideHealPer = player:GetProperty(BP.i_heal_per)
  end
  allDealHealPer = player and player:GetProperty(BP.all_deal_heal_per) or 0
  if not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awakerOutsideHealPer = caster:GetProperty(BP.o_heal_per)
    awakerInsideHealPer = caster:GetProperty(BP.i_heal_per)
    awakerHealPlus = caster:GetProperty(BP.heal_plus)
    awaker_CmdCard_heal_per = caster:GetProperty(BP.awaker_CmdCard_heal_per) or 0
    for _, skillType in ipairs(skillTypes) do
      for _, healPer in ipairs(bc.SkillType2HealPer[skillType] or {}) do
        skillTypeHealPer = skillTypeHealPer * (1 + caster:GetProperty(healPer) / 100)
      end
      skillTypeInsideHealPer = skillTypeInsideHealPer * (1 + caster:GetProperty(bc.SkillType2InsideHealPer[skillType]) / 100)
      if skillType == bc.SkillType.Ulti_Skill then
        awaker_ulti_heal_per = caster:GetProperty(BP.awaker_ulti_heal_per)
      end
    end
    if card then
      cardInsideHealPer = caster:GetProperty(BP.i_heal_per_card)
      cardOutsideHealPer = caster:GetProperty(BP.o_heal_per_card)
    end
  end
  if card then
    curCardHealPer = card:GetProperty(BP.card_heal_per)
    cardHealPlus = card:GetProperty(BP.card_heal_plus)
    cardHealPer2 = card:GetProperty(BP.card_heal_per2)
  end
  dimension_fix_per = player and player:GetProperty(BP.dimension_fix_per) or caster and caster:GetProperty(BP.dimension_fix_per) or 0
  local skillArgsPlus = self:GetSkillArgsPlus(paraPlusName)
  local _, keeperskillDefPer, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local data = {
    value = value,
    awakerOutsideHealPer = awakerOutsideHealPer,
    playerOutsideHealPer = playerOutsideHealPer,
    curCardHealPer = curCardHealPer,
    cardOutsideHealPer = cardOutsideHealPer,
    skillTypeHealPer = skillTypeHealPer,
    awakerHealPlus = awakerHealPlus,
    cardHealPlus = cardHealPlus,
    skillArgsPlus = skillArgsPlus,
    dying_per = dying_per,
    dying_per2 = dying_per2,
    awakerInsideHealPer = awakerInsideHealPer,
    dimension_fix_per = dimension_fix_per,
    playerInsideHealPer = playerInsideHealPer,
    cardInsideHealPer = cardInsideHealPer,
    allDealHealPer = allDealHealPer,
    cardHealPer2 = cardHealPer2,
    awaker_CmdCard_heal_per = awaker_CmdCard_heal_per,
    awaker_ulti_heal_per = awaker_ulti_heal_per,
    skillTypeInsideHealPer = skillTypeInsideHealPer,
    keeperskill_def_per = keeperskillDefPer,
    is_chaos_type2 = is_chaos_type2
  }
  do return BattleUtilServer.ShowHealFormula end
  return BattleUtilServer.ShowHealFormula, data, caster, BP.awaker_ulti_heal_per, ipairs(bc.SkillType2HealPer[skillType] or {})
end

function BattleCmdParserClient:__GetShowUltiEnergy(value)
  local awakerUltiEnergyPer = 0
  local awakerUltiEnergyEff = 0
  local skillTypeEnergyPer = 1
  local awakerUltiEnergyPlus = 0
  local awakerUltiEnergyPlus2 = 0
  local curCardUltiEnergyPer = 0
  local cardUltiEnergyPlus = 0
  local i_awakerUltiEnergyPer = 0
  local outUltiEnergyPer = 0
  local dimension_fix_per = 0
  local caster = self:GetAwaker() or self:GetPlayerRole()
  local player = self:GetPlayerRole()
  local card = self:GetCard()
  if card then
    curCardUltiEnergyPer = card:GetProperty(BP.card_ulti_per)
    cardUltiEnergyPlus = card:GetProperty(BP.card_ulti_plus)
  end
  local skillTypes = self:GetSkillType()
  if not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awakerUltiEnergyPer = caster:GetProperty(BP.ulti_energy_per)
    awakerUltiEnergyEff = caster:GetProperty(BP.ulti_energy_efficiency)
    awakerUltiEnergyPlus = caster:GetProperty(BP.ulti_energy_plus)
    awakerUltiEnergyPlus2 = caster:GetProperty(BP.ulti_energy_plus2) or 0
    i_awakerUltiEnergyPer = caster:GetProperty(BP.i_awaker_ulti_energy_per) or 0
    outUltiEnergyPer = caster:GetProperty(BP.out_ulti_energy_per) or 0
    for _, skillType in ipairs(skillTypes) do
      skillTypeEnergyPer = skillTypeEnergyPer * (1 + caster:GetProperty(bc.SkillType2UltiPer[skillType]) / 100)
    end
  end
  dimension_fix_per = player and player:GetProperty(BP.dimension_fix_per) or caster and caster:GetProperty(BP.dimension_fix_per) or 0
  local data = {
    value = value,
    awakerUltiEnergyPer = awakerUltiEnergyPer,
    i_awakerUltiEnergyPer = i_awakerUltiEnergyPer,
    outUltiEnergyPer = outUltiEnergyPer,
    awakerUltiEnergyEff = awakerUltiEnergyEff,
    curCardUltiEnergyPer = curCardUltiEnergyPer,
    dimension_fix_per = dimension_fix_per,
    skillTypeEnergyPer = skillTypeEnergyPer,
    awakerUltiEnergyPlus = awakerUltiEnergyPlus,
    awakerUltiEnergyPlus2 = awakerUltiEnergyPlus2,
    cardUltiEnergyPlus = cardUltiEnergyPlus
  }
  do return BattleUtilServer.ShowUltiEnergyFormula end
  return BattleUtilServer.ShowUltiEnergyFormula, data, ipairs(skillTypes)
end

function BattleCmdParserClient:__GetShowPoison(value)
  local caster = self:GetAwaker() or self:GetPlayerRole()
  if not caster then
    return value, value
  end
  local card = self:GetCard()
  local card_state_layer_per_poison = 0
  local awaker_CmdCard_state_layer_per_poison = 0
  local awaker_ulti_state_layer_per_poison = 0
  if card then
    card_state_layer_per_poison = card:GetProperty(BP.card_state_layer_per_poison) or 0
  end
  if not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awaker_CmdCard_state_layer_per_poison = caster:GetProperty(BP.awaker_CmdCard_state_layer_per_poison) or 0
    local skillTypes = self:GetSkillType()
    for _, skillType in ipairs(skillTypes) do
      if skillType == bc.SkillType.Ulti_Skill then
        awaker_ulti_state_layer_per_poison = caster:GetProperty(BP.awaker_ulti_state_layer_per_poison) or awaker_ulti_state_layer_per_poison
        break
      end
    end
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local skipNewChaosKeeperskill = self:ShouldSkipNewChaosKeeperskillForStateTag()
  local data = {
    value = value,
    card_state_layer_per_poison = card_state_layer_per_poison,
    awaker_CmdCard_state_layer_per_poison = awaker_CmdCard_state_layer_per_poison,
    awaker_ulti_state_layer_per_poison = awaker_ulti_state_layer_per_poison,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2,
    skipNewChaosKeeperskill = skipNewChaosKeeperskill
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      return v
    end
  })
  do return BattleUtilServer.PoisonFormula end
  return BattleUtilServer.PoisonFormula, env, function(t, key)
    local v = caster:GetProperty(BP[key])
    return v
  end, BP.awaker_ulti_state_layer_per_poison
end

function BattleCmdParserClient:__GetShowCounterattack(value)
  local caster = self:GetAwaker() or self:GetPlayerRole()
  if not caster then
    return value, value
  end
  local card = self:GetCard()
  local card_state_layer_per_counterattack = 0
  local awaker_CmdCard_state_layer_per_counterattack = 0
  local awaker_ulti_state_layer_per_counterattack = 0
  if card then
    card_state_layer_per_counterattack = card:GetProperty(BP.card_state_layer_per_counterattack) or 0
  end
  if not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awaker_CmdCard_state_layer_per_counterattack = caster:GetProperty(BP.awaker_CmdCard_state_layer_per_counterattack) or 0
    local skillTypes = self:GetSkillType()
    for _, skillType in ipairs(skillTypes) do
      if skillType == bc.SkillType.Ulti_Skill then
        awaker_ulti_state_layer_per_counterattack = caster:GetProperty(BP.awaker_ulti_state_layer_per_counterattack) or awaker_ulti_state_layer_per_counterattack
        break
      end
    end
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local skipNewChaosKeeperskill = self:ShouldSkipNewChaosKeeperskillForStateTag()
  local data = {
    value = value,
    card_state_layer_per_counterattack = card_state_layer_per_counterattack,
    awaker_CmdCard_state_layer_per_counterattack = awaker_CmdCard_state_layer_per_counterattack,
    awaker_ulti_state_layer_per_counterattack = awaker_ulti_state_layer_per_counterattack,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2,
    skipNewChaosKeeperskill = skipNewChaosKeeperskill
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      return v
    end
  })
  do return BattleUtilServer.CounterattackFormula end
  return BattleUtilServer.CounterattackFormula, env, function(t, key)
    local v = caster:GetProperty(BP[key])
    return v
  end, BP.awaker_ulti_state_layer_per_counterattack, "awaker_ulti_state_layer_per_counterattack"
end

function BattleCmdParserClient:__GetShowExhaustion(value)
  local caster = self:GetAwaker() or self:GetPlayerRole()
  if not caster then
    return value, value
  end
  local card = self:GetCard()
  local card_state_layer_per_exhaustion = 0
  local awaker_CmdCard_state_layer_per_exhaustion = 0
  local awaker_ulti_state_layer_per_exhaustion = 0
  if card then
    card_state_layer_per_exhaustion = card:GetProperty(BP.card_state_layer_per_exhaustion) or 0
  end
  if not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awaker_CmdCard_state_layer_per_exhaustion = caster:GetProperty(BP.awaker_CmdCard_state_layer_per_exhaustion) or 0
    local skillTypes = self:GetSkillType()
    for _, skillType in ipairs(skillTypes) do
      if skillType == bc.SkillType.Ulti_Skill then
        awaker_ulti_state_layer_per_exhaustion = caster:GetProperty(BP.awaker_ulti_state_layer_per_exhaustion) or awaker_ulti_state_layer_per_exhaustion
        break
      end
    end
  end
  local _, keeperskillDefPer, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local data = {
    value = value,
    card_state_layer_per_exhaustion = card_state_layer_per_exhaustion,
    awaker_CmdCard_state_layer_per_exhaustion = awaker_CmdCard_state_layer_per_exhaustion,
    awaker_ulti_state_layer_per_exhaustion = awaker_ulti_state_layer_per_exhaustion,
    keeperskill_def_per = keeperskillDefPer,
    is_chaos_type2 = is_chaos_type2
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      return v
    end
  })
  do return BattleUtilServer.ExhaustionFormula end
  return BattleUtilServer.ExhaustionFormula, env, function(t, key)
    local v = caster:GetProperty(BP[key])
    return v
  end, caster, BP.awaker_ulti_state_layer_per_exhaustion
end

function BattleCmdParserClient:__GetShowPower(value)
  local caster = self:GetAwaker() or self:GetPlayerRole()
  if not caster then
    return value, value
  end
  local card = self:GetCard()
  local o_state_layer_per_power_bycmd = 0
  local card_state_layer_per_power = 0
  local awaker_CmdCard_state_layer_per_power = 0
  local awaker_ulti_state_layer_per_power = 0
  local skillTypes = self:GetSkillType()
  for _, skillType in ipairs(skillTypes) do
    if skillType == bc.SkillType.Ulti_Skill then
      awaker_ulti_state_layer_per_power = caster:GetProperty(BP.awaker_ulti_state_layer_per_power) or awaker_ulti_state_layer_per_power
      break
    end
  end
  if not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awaker_CmdCard_state_layer_per_power = caster:GetProperty(BP.awaker_CmdCard_state_layer_per_power) or 0
  end
  if card then
    if caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) and self:IsCardTypeMatch(card, {
      bc.SkillType.Card_Skill,
      bc.SkillType.Card_Defend,
      bc.SkillType.Card_Extend,
      bc.SkillType.Card_Strike
    }) then
      o_state_layer_per_power_bycmd = caster:GetProperty(BP.o_state_layer_per_power_bycmd)
    end
    card_state_layer_per_power = card:GetProperty(BP.card_state_layer_per_power)
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local data = {
    value = value,
    o_state_layer_per_power_bycmd = o_state_layer_per_power_bycmd,
    card_state_layer_per_power = card_state_layer_per_power,
    awaker_CmdCard_state_layer_per_power = awaker_CmdCard_state_layer_per_power,
    awaker_ulti_state_layer_per_power = awaker_ulti_state_layer_per_power,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      return v
    end
  })
  do return BattleUtilServer.PowerFormula end
  return BattleUtilServer.PowerFormula, env, function(t, key)
    local v = caster:GetProperty(BP[key])
    return v
  end, BP.awaker_ulti_state_layer_per_power
end

function BattleCmdParserClient:__GetShowFateCut(value)
  local caster = self:GetAwaker() or self:GetPlayerRole()
  if not caster then
    return value, value
  end
  local card = self:GetCard()
  local card_fixed_state_layer_per_fatecut = 0
  local awaker_ulti_fixed_state_layer_per_fatecut = 0
  local awaker_CmdCard_fixed_state_layer_per_fatecut = 0
  if card then
    card_fixed_state_layer_per_fatecut = card:GetProperty(BP.card_fixed_state_layer_per_fatecut) or 0
  end
  if not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    local skillTypes = self:GetSkillType()
    for _, skillType in ipairs(skillTypes) do
      if skillType == bc.SkillType.Ulti_Skill then
        awaker_ulti_fixed_state_layer_per_fatecut = caster:GetProperty(BP.awaker_ulti_fixed_state_layer_per_fatecut) or awaker_ulti_fixed_state_layer_per_fatecut
        break
      end
    end
    if card and self:IsCardTypeMatch(card, {
      bc.SkillType.Card_Skill,
      bc.SkillType.Card_Defend,
      bc.SkillType.Card_Extend,
      bc.SkillType.Card_Strike
    }) then
      awaker_CmdCard_fixed_state_layer_per_fatecut = caster:GetProperty(BP.awaker_CmdCard_fixed_state_layer_per_fatecut) or 0
    end
  end
  local data = {
    value = value,
    card_fixed_state_layer_per_fatecut = card_fixed_state_layer_per_fatecut,
    awaker_ulti_fixed_state_layer_per_fatecut = awaker_ulti_fixed_state_layer_per_fatecut,
    awaker_CmdCard_fixed_state_layer_per_fatecut = awaker_CmdCard_fixed_state_layer_per_fatecut
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      return v
    end
  })
  do return BattleUtilServer.CutFormula end
  return BattleUtilServer.CutFormula, env, function(t, key)
    local v = caster:GetProperty(BP[key])
    return v
  end, bc.SkillType.Card_Skill, bc.SkillType.Card_Defend, bc.SkillType.Card_Extend, bc.SkillType.Card_Strike, BP.awaker_ulti_fixed_state_layer_per_fatecut, "awaker_ulti_fixed_state_layer_per_fatecut"
end

function BattleCmdParserClient:__GetShowTentaclePower(value)
  local isPVE = SceneMgr.Instance and SceneMgr.Instance:IsInCopies() or bg.isPVE
  if not isPVE and not bg.isPVP then
    return value
  end
  local caster = self:GetAwaker() or self:GetPlayerRole()
  if not caster then
    return value, value
  end
  local card = self:GetCard()
  local instructcard_basic_state_layer_per_tentacle_dmg = 0
  local ulti_basic_state_layer_per_tentacle_dmg = 0
  local card_basic_state_layer_per_tentacle_dmg = 0
  local instructcard_final_state_layer_per_tentacle_dmg = 0
  local ulti_final_state_layer_per_tentacle_dmg = 0
  local card_state_layer_per_tentacle_dmg = 0
  local card_state_layer_per_TentaclePower = 0
  local awaker_CmdCard_state_layer_per_TentaclePower = 0
  local awaker_ulti_state_layer_per_TentaclePower = 0
  local skillTypes = self:GetSkillType()
  for _, skillType in ipairs(skillTypes) do
    if skillType == bc.SkillType.Ulti_Skill then
      awaker_ulti_state_layer_per_TentaclePower = caster:GetProperty(BP.awaker_ulti_state_layer_per_TentaclePower) or awaker_ulti_state_layer_per_TentaclePower
      break
    end
  end
  if not caster.IsRoleType or caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awaker_CmdCard_state_layer_per_TentaclePower = caster:GetProperty(BP.awaker_CmdCard_state_layer_per_TentaclePower) or 0
  end
  if card then
    if caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) and self:IsCardTypeMatch(card, {
      bc.SkillType.Card_Skill,
      bc.SkillType.Card_Defend,
      bc.SkillType.Card_Extend,
      bc.SkillType.Card_Strike
    }) then
      instructcard_basic_state_layer_per_tentacle_dmg = caster:GetProperty(BP.instructcard_basic_state_layer_per_tentacle_dmg)
      instructcard_final_state_layer_per_tentacle_dmg = caster:GetProperty(BP.instructcard_final_state_layer_per_tentacle_dmg)
      card_state_layer_per_tentacle_dmg = card:GetProperty(BP.card_state_layer_per_tentacle_dmg)
    end
    if caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) and self:IsCardTypeMatch(card, {
      bc.SkillType.Ulti_Skill
    }) then
      ulti_basic_state_layer_per_tentacle_dmg = caster:GetProperty(BP.ulti_basic_state_layer_per_tentacle_dmg)
      card_basic_state_layer_per_tentacle_dmg = card:GetProperty(BP.card_basic_state_layer_per_tentacle_dmg)
      ulti_final_state_layer_per_tentacle_dmg = caster:GetProperty(BP.ulti_final_state_layer_per_tentacle_dmg)
    end
    card_state_layer_per_TentaclePower = card:GetProperty(BP.card_state_layer_per_TentaclePower) or 0
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local data = {
    value = value,
    instructcard_basic_state_layer_per_tentacle_dmg = instructcard_basic_state_layer_per_tentacle_dmg,
    ulti_basic_state_layer_per_tentacle_dmg = ulti_basic_state_layer_per_tentacle_dmg,
    card_basic_state_layer_per_tentacle_dmg = card_basic_state_layer_per_tentacle_dmg,
    instructcard_final_state_layer_per_tentacle_dmg = instructcard_final_state_layer_per_tentacle_dmg,
    ulti_final_state_layer_per_tentacle_dmg = ulti_final_state_layer_per_tentacle_dmg,
    card_state_layer_per_tentacle_dmg = card_state_layer_per_tentacle_dmg,
    card_state_layer_per_TentaclePower = card_state_layer_per_TentaclePower,
    awaker_CmdCard_state_layer_per_TentaclePower = awaker_CmdCard_state_layer_per_TentaclePower,
    awaker_ulti_state_layer_per_TentaclePower = awaker_ulti_state_layer_per_TentaclePower,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      return v
    end
  })
  do return BattleUtilServer.TentacleShowFormula end
  return BattleUtilServer.TentacleShowFormula, env, function(t, key)
    local v = caster:GetProperty(BP[key])
    return v
  end, BP.awaker_ulti_state_layer_per_TentaclePower, "awaker_ulti_state_layer_per_TentaclePower"
end

function BattleCmdParserClient:__GetShowBleed(value)
  local caster = self:GetAwaker() or self:GetPlayerRole()
  if not caster then
    return value, value
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local skipNewChaosKeeperskill = self:ShouldSkipNewChaosKeeperskillForStateTag()
  local data = {
    value = value,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2,
    skipNewChaosKeeperskill = skipNewChaosKeeperskill
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      return v
    end
  })
  do return BattleUtilServer.BleedFormula end
  return BattleUtilServer.BleedFormula, env, function(t, key)
    local v = caster:GetProperty(BP[key])
    return v
  end
end

function BattleCmdParserClient:GetAccountPower()
  do return self.__GetAccountLevelArgByAccoutLevel, self end
  return self.__GetAccountLevelArgByAccoutLevel, self, "AccountPower"
end

function BattleCmdParserClient:GetAccountDamagePower()
  do return self.__GetAccountLevelArgByAccoutLevel, self end
  return self.__GetAccountLevelArgByAccoutLevel, self, "AccountDamagePower"
end

function BattleCmdParserClient:GetSilverKey()
  do return end
  return KeeperSkillUtils.GetOwnedSkillCount
end

function BattleCmdParserClient:Archivenotch()
  local stageData = WorldStageManager.Instance:GetCurStageData() or self:__GetOutSideStageData()
  if not stageData or not stageData.stageId then
    return 0
  end
  local stageCfg = CopyDataUtils.GetStageCfg(stageData.stageId)
  if not stageCfg then
    return 0
  end
  local stageGroupCfg = CopyDataUtils.GetStageGroupCfgByStage(stageData.stageId)
  if not stageGroupCfg or stageGroupCfg.StageChapterText ~= cd.StageChapterName.StageChapterStarsCameRight then
    return 0
  end
  local silverKey = self:GetSilverKey() or 0
  do return math.min, silverKey end
  return math.min, silverKey, 50
end

function BattleCmdParserClient:GetAccountStageGrow()
  do return self.__GetAccountLevelArgByAccoutLevel, self end
  return self.__GetAccountLevelArgByAccoutLevel, self, "StageGrow"
end

function BattleCmdParserClient:GetAccountMethysisPower()
  do return self.__GetAccountLevelArgByAccoutLevel, self end
  return self.__GetAccountLevelArgByAccoutLevel, self, "AccountMethysisPower"
end

function BattleCmdParserClient:GetAccountLevelArgByAccoutLevel(name)
  do return self.__GetAccountLevelArgByAccoutLevel, self end
  return self.__GetAccountLevelArgByAccoutLevel, self, name
end

function BattleCmdParserClient:__GetAccountLevelArgByAccoutLevel(name)
  local level = 1
  local stageData = WorldStageManager.Instance:GetCurStageData()
  local awakerTidList = {}
  local awakerLevelDict = {}
  local playerLevel
  if stageData and stageData.role then
    for _, awakerInfo in pairs(stageData.role.awakerInfos) do
      table.insert(awakerTidList, awakerInfo.tid)
      awakerLevelDict[awakerInfo.tid] = awakerInfo.level
    end
    playerLevel = stageData.role.level
  end
  level = AttrUtils.GetAwakersAccountLvBattleCurve(awakerTidList, awakerLevelDict, playerLevel) or 1
  local levelCfg = DT.AcountLevelConfig[level]
  if not levelCfg then
    return 0
  end
  local cfgVal = levelCfg[name] or 0
  if "StageGrow" == name then
    local propertyValue = 0
    local battleDataCenter = bg and bg.battleDataCenter
    if battleDataCenter then
      propertyValue = battleDataCenter and battleDataCenter:GetPlayerRoleProperty(bc.BattleProperty.ModifyGrowthStrength) or 0
    elseif stageData and stageData.role then
      propertyValue = stageData.role.ModifyGrowthStrength or 0
    end
    cfgVal = cfgVal * (1 + propertyValue / 100)
  end
  return cfgVal
end

function BattleCmdParserClient:GetAwakerLevelArgByStageLevel(name)
  do return self.__GetAwakerLevelArgByStageLevel, self end
  return self.__GetAwakerLevelArgByStageLevel, self, name
end

function BattleCmdParserClient:__GetOutSideStageData()
  local memberValue = self:GetMemberValue(CommonDefine.OutsideStageMemberField)
  if not memberValue then
    return
  end
  return {stageId = memberValue}
end

function BattleCmdParserClient:__GetAwakerLevelArgByStageLevel(name)
  local stageData = WorldStageManager.Instance:GetCurStageData() or self:__GetOutSideStageData()
  if not stageData or not stageData.stageId then
    return 0
  end
  local stageId = stageData.stageId
  local stageCfg = DT.Stage[stageId]
  if not stageCfg then
    return 0
  end
  local difficultyId = MainCopyDataUtils.GetDymicDifficultyId(stageId)
  local StageLevelKey = "StageLevel"
  local stageLevel = stageCfg and stageCfg[StageLevelKey] or 0
  if difficultyId and difficultyId > 0 then
    local difficultyCfg = DT.StageDifficulty[difficultyId]
    stageLevel = difficultyCfg and difficultyCfg[StageLevelKey] or stageLevel
  end
  local cfg = DT.AwakerUpgrade[stageLevel]
  if not cfg then
    return 0
  end
  return cfg[name]
end

function BattleCmdParserClient:GetStagePower()
  do return self.__GetAwakerLevelArgByStageLevel, self end
  return self.__GetAwakerLevelArgByStageLevel, self, "StagePower"
end

function BattleCmdParserClient:GetStageAtkPower()
  do return self.__GetAwakerLevelArgByStageLevel, self end
  return self.__GetAwakerLevelArgByStageLevel, self, "StageAtkPower"
end

function BattleCmdParserClient:GetStageHpPower()
  do return self.__GetAwakerLevelArgByStageLevel, self end
  return self.__GetAwakerLevelArgByStageLevel, self, "StageHpPower"
end

function BattleCmdParserClient:GetStageDefPower()
  do return self.__GetAwakerLevelArgByStageLevel, self end
  return self.__GetAwakerLevelArgByStageLevel, self, "StageDefPower"
end

function BattleCmdParserClient:GetResonanceLevel(resonaceId)
  do return ResonanceDataUtils.GetResonanceLevel end
  return ResonanceDataUtils.GetResonanceLevel, resonaceId
end

function BattleCmdParserClient:GetTeamSkillMultiplier()
  do return self.__GetAwakerLevelArgByAwakerAvgLevel, self end
  return self.__GetAwakerLevelArgByAwakerAvgLevel, self, "SkillMultiplier"
end

function BattleCmdParserClient:GetAwakerNormalUltiCost(awakerId)
  local awaker = self.parserEnv.awaker
  if not awakerId or not DT.AwakerConfig[awakerId] then
    awakerId = awaker and awaker.ID or awaker and awaker.tid
  end
  local awakerCfg = awakerId and DT.AwakerConfig[awakerId]
  if not awakerCfg then
    return 0
  end
  local breakSkillLevel = self.parserEnv.breakSkillLevel
  local potencyLevel = self.parserEnv.potencyLevel
  if not breakSkillLevel then
    if not awaker then
      return 0
    end
    local bLv, pLv = BattleSkillUtils.GetBreakAndPotencyLevel(awaker)
    if not bLv then
      return 0
    end
    breakSkillLevel = bLv
    potencyLevel = potencyLevel or pLv
  end
  potencyLevel = potencyLevel or 0
  for _, skillId in ipairs(awakerCfg.SkillList or {}) do
    local skillCfg = DT.Skill[skillId]
    local skillType = BattleSkillUtils.GetSkillType(skillCfg, breakSkillLevel, potencyLevel)
    for _, typeName in ipairs(skillType or {}) do
      if typeName == bc.SkillType.Ulti_Skill or "Ulti_Skill" == typeName then
        return BattleSkillUtils.GetSkillCost(skillCfg, breakSkillLevel, potencyLevel) or 0
      end
    end
  end
  return 0
end

function BattleCmdParserClient:GetAwakerLevelArgByAwakerAvgLevel(name)
  do return self.__GetAwakerLevelArgByAwakerAvgLevel, self end
  return self.__GetAwakerLevelArgByAwakerAvgLevel, self, name
end

function BattleCmdParserClient:__GetAwakerLevelArgByAwakerAvgLevel(name)
  local level = AttrUtils.GetAwakersAccountLvBattleCurve(DataCenter.teamData.Team.awakerTids) or 1
  local cfg = DT.AwakerUpgrade[level]
  if not cfg then
    return 0
  end
  return cfg[name] or 0
end

function BattleCmdParserClient:GetAwakerPotencyPower()
  if not self.awakerData then
    return 0
  end
  local awakerPotencyPowerList = DT.GetOriginalConstant("AwakerLevelStrength")
  local awakerConfig = DT.AwakerConfig[self.awakerData.tid]
  local addLevelKey = "AwakerUpgradeLevel_" .. awakerConfig.Quality
  local qualityAddLevel = DT.GetConstant(addLevelKey)
  local level = self.awakerData.level + qualityAddLevel
  if level > #awakerPotencyPowerList then
    Logger.Warn("唤醒体等级超出启灵强度配置长度")
    return 0
  end
  return awakerPotencyPowerList[level]
end

function BattleCmdParserClient:GetAwakerLevelPower()
  if not self.awakerData then
    return 0
  end
  local level = self.awakerData.level
  local cfg = DT.AwakerUpgrade[level]
  if not cfg then
    return 0
  end
  return cfg.AwakerLevelPower or 0
end

function BattleCmdParserClient:GetTeamSkillMultiplier()
  do return self.__GetAwakerLevelArgByAwakerAvgLevel, self end
  return self.__GetAwakerLevelArgByAwakerAvgLevel, self, "SkillMultiplier"
end

function BattleCmdParserClient:GetAwakerLevelArgByAwakerAvgLevel(name)
  do return self.__GetAwakerLevelArgByAwakerAvgLevel, self end
  return self.__GetAwakerLevelArgByAwakerAvgLevel, self, name
end

function BattleCmdParserClient:__GetAwakerLevelArgByAwakerAvgLevel(name)
  local level = TeamDataUtils.GetCurTeamLevel()
  local cfg = DT.AwakerUpgrade[level]
  if not cfg then
    return 0
  end
  return cfg[name]
end

function BattleCmdParserClient:GetRefiningLevel()
  return self.memberValues.RefiningLevel
end

function BattleCmdParserClient:GetMyCamp()
  local camp = bg.battleDataCenter:GetMyCamp()
  return camp
end

function BattleCmdParserClient:__GetAttackTimes(value)
  local caster = self:GetAwaker() or self:GetPlayerRole()
  local data = {
    value = value,
    damagetimes_plus = caster:GetProperty(BP.damagetimes_plus),
    damagetimes_per = caster:GetProperty(BP.damagetimes_per)
  }
  do return BattleUtilServer.AttackTimesFormula end
  return BattleUtilServer.AttackTimesFormula, data, BP.damagetimes_per
end

function BattleCmdParserClient:SetParserEnv(key, value)
  self.parserEnv[key] = value
end

function BattleCmdParserClient:GetAwakerList(campTag, aliveTag)
  local targets = {}
  if bg.battleScene then
    local camp = bg.battleDataCenter:GetMyCamp()
    if campTag == bc.PVPTargetTag.EnemyAwaker then
      camp = bc.BattleCamp:GetEnemyCamp(camp)
    end
    local roleList = bg.battleScene:GetRoleListByCamp(camp, true)
    for _, role in ipairs(roleList) do
      if aliveTag == bc.PVPTargetTag.AliveOnly and role.dead.value == false then
        table.insert(targets, role)
      elseif aliveTag == bc.PVPTargetTag.DeathOnly and role.dead.value == true then
        table.insert(targets, role)
      elseif aliveTag == bc.PVPTargetTag.DeadOrAlive then
        table.insert(targets, role)
      end
    end
  end
  do return BattleTargetExpClient, self end
  return BattleTargetExpClient, self, targets, ipairs(roleList)
end

function BattleCmdParserClient:GetAwakerCountBySchool(schoolType)
  local awakerMap = CopyAwakerDataUtils.Get_battleAwakerMap()
  local count = 0
  for tid in pairs(awakerMap) do
    local awakerCfg = DT.AwakerConfig[tid]
    if awakerCfg and awakerCfg.School == schoolType then
      count = count + 1
    end
  end
  return count
end

function BattleCmdParserClient:Random(l, r)
  do return math.random, l end
  return math.random, l, r
end

return BattleCmdParserClient
