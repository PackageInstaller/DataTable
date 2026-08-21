_class("SeasonMazeService", BaseService)
SeasonMazeService = SeasonMazeService

function SeasonMazeService:Constructor(world)
  self._world = world
  self._buffLogicSvc = self._world:GetService("BuffLogic")
  self._getCountFunc = {}
  self._getCountFunc[BuffPopStarProModifyType.RelicCount] = self.GetRelicCount
end

function SeasonMazeService:AddRelicCounter(relicID)
  local cmpt = self:GetSeasonMazeLogicComponent()
  cmpt:AddRelicCount(relicID)
end

function SeasonMazeService:GetRelicCount()
  local cmpt = self:GetSeasonMazeLogicComponent()
  local count = cmpt:GetRelicsCount()
  return count
end

function SeasonMazeService:GetCountByModifyType(modifyType)
  local count = 0
  local func = self._getCountFunc[modifyType]
  if func then
    count = func(self)
  end
  return count
end

function SeasonMazeService:GetSeasonMazeLogicComponent()
  return self._world:SeasonMazeLogic()
end

function SeasonMazeService:GetAllRelic()
  local cmpt = self:GetSeasonMazeLogicComponent()
  return cmpt:GetAllRelic()
end

function SeasonMazeService:AddRewardGoldCoin(coin)
  local cmpt = self:GetSeasonMazeLogicComponent()
  cmpt:AddRewardGoldCoin(coin)
  Log.info("SeasonMaze Relic AddGoldCoin Count:", coin)
end

function SeasonMazeService:AddMsAndGoldCoin()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local com = teamEntity:BuffComponent()
  if com:GetBuffValue("SeasonMazeAddGoldCoin") then
    self:AddRewardGoldCoin(com:GetBuffValue("SeasonMazeAddGoldCoin"))
  end
  if com:GetBuffValue("SeasonMazeAddMS") then
    self:AddMS(com:GetBuffValue("SeasonMazeAddMS"))
  end
end

function SeasonMazeService:AddRewardMS(ms)
  local cmpt = self:GetSeasonMazeLogicComponent()
  local newMS = cmpt:AddMS(ms)
  Log.info("SeasonMaze Relic AddMS Count:", ms)
  local bs = self._world:BattleStat()
  bs:SetLevelRound(newMS)
  bs:SetCurWaveRound(newMS)
  bs:MazeAddLight(ms)
end

function SeasonMazeService:GetRoundCount()
  local cmpt = self:GetSeasonMazeLogicComponent()
  if self:IsSeasonMazeWorldBoss() then
    return cmpt:GetRoundCount()
  else
    return cmpt:GetMS()
  end
end

function SeasonMazeService:GetMS()
  local cmpt = self:GetSeasonMazeLogicComponent()
  return cmpt:GetMS()
end

function SeasonMazeService:UseMs()
  if not self:IsSeasonMazeWorldBoss() then
    local cmpt = self:GetSeasonMazeLogicComponent()
    cmpt:SubMS(1)
  end
end

function SeasonMazeService:GetAutoBeadEnergy()
  local cmpt = self:GetSeasonMazeLogicComponent()
  return cmpt:GetAutoBeadEnergy()
end

function SeasonMazeService:AddOuterAutoBeadEnergy(point)
  local cmpt = self:GetSeasonMazeLogicComponent()
  return cmpt:AddAutoBeadEnergy(point)
end

function SeasonMazeService:SubOuterAutoBeadEnergy(point)
  local cmpt = self:GetSeasonMazeLogicComponent()
  return cmpt:SubAutoBeadEnergy(point)
end

function SeasonMazeService:IsSeasonMazeWorldBoss()
  local matchType, subMatchType = self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss)
  if subMatchType == MatchType.MT_WorldBoss then
    return true
  end
  return false
end

function SeasonMazeService:BuildResult(result, victory)
  local mr = SeasonMazeResult:New()
  local cmpt = self:GetSeasonMazeLogicComponent()
  local battleSvc = self._world:GetService("Battle")
  if self:IsSeasonMazeWorldBoss() then
    mr.total_damage = battleSvc:GetWorldBossTotalDamage(result, victory)
  end
  mr.relic_list = cmpt:GetRelicAndCounter()
  mr.outside_attr = cmpt:GetOutsideAttribute()
  local featureSvc = self:GetService("FeatureLogic")
  mr.outside_attr[SeasonMazeAttrType.SMAT_AlgorithmUpEnergy] = featureSvc:GetAUOEValue()
  Log.info("SeasonMazeResult OutAttrBegin")
  for k, v in pairs(mr.outside_attr) do
    Log.info("key :", k, " value:", v)
  end
  if mr.outside_attr[SeasonMazeAttrType.SMAT_AutoBeadEnergy] then
    mr.outside_attr[SeasonMazeAttrType.SMAT_AutoBeadEnergy] = math.floor(mr.outside_attr[SeasonMazeAttrType.SMAT_AutoBeadEnergy])
    Log.info("FloorAutoBeadEnergyValue :", mr.outside_attr[SeasonMazeAttrType.SMAT_AutoBeadEnergy])
  end
  Log.info("SeasonMazeResult OutAttrEnd")
  local pet_infos = {}
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local petEntities = teamEntity:Team():GetTeamPetEntities()
  for _, e in ipairs(petEntities) do
    local info = MatchPetResult:New()
    info.pet_pstid = e:PetPstID():GetPstID()
    info.pet_power = e:Attributes():GetAttribute("Power")
    info.pet_legendPower = e:Attributes():GetAttribute("LegendPower")
    local hp = e:Attributes():GetCurrentHP()
    info.pet_blood = hp / e:Attributes():CalcMaxHp()
    if hp <= 0 then
      info.pet_is_dead = true
    end
    table.insert(pet_infos, info)
  end
  mr.pet_list = pet_infos
  return mr
end

function SeasonMazeService:GetRelics()
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze then
    return {}
  end
end

function SeasonMazeService:CheckRelicCounter(relicID)
  local cfg = Cfg.cfg_item_relic[relicID]
  local seasonMazeCmpt = self:GetSeasonMazeLogicComponent()
  local cnt = seasonMazeCmpt:GetRelicCounter(relicID)
  if not cnt or cfg.OutGameTriggerCount == 0 or cnt < cfg.OutGameTriggerCount then
    return true
  end
  return false
end

function SeasonMazeService:CheckSuite(suiteID)
  local seasonMazeCmpt = self:GetSeasonMazeLogicComponent()
  local relics = seasonMazeCmpt:GetSuitRelic()
  local suiteCfgList = Cfg.cfg_item_relic({SuiteID = suiteID})
  for _, cfg in pairs(suiteCfgList) do
    if not table.icontains(relics, cfg.ID) then
      return false
    end
    if not self:CheckRelicCounter(cfg.ID) then
      return false
    end
  end
  return true
end

function SeasonMazeService:Initialize()
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze then
    return
  end
end

function SeasonMazeService:CalculateRelicInnerEff(relicID)
  local relics = self:GetRelics()
  local cfg = Cfg.cfg_item_relic[relicID]
  if cfg.InnerGameType == RelicInnerGameEffType.ReplaceRelicID then
    local param = cfg.InnerGameTypeParam
    local needRelicID = param.needRelicID
    if table.icontains(relics, needRelicID) then
      return param.replaceID
    end
  end
  return relicID
end

function SeasonMazeService:InitRelics()
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze then
    return {}
  end
  local relics = table.cloneconf(self:GetAllRelic())
  local validRelics = {}
  for _, relicID in ipairs(relics) do
    local cfg = Cfg.cfg_item_relic[relicID]
    if self:CheckRelicCounter(relicID) then
      if cfg.InnerGameType and cfg.InnerGameType > 0 then
        local id = self:CalculateRelicInnerEff(relicID)
        table.insert(validRelics, id)
      else
        table.insert(validRelics, relicID)
      end
    end
  end
  table.sort(validRelics, function(a, b)
    local oa = Cfg.cfg_item_relic[a].ShowOrder
    local ob = Cfg.cfg_item_relic[b].ShowOrder
    if oa == ob then
      return a < b
    else
      return oa < ob
    end
  end)
  for _, relic in ipairs(validRelics) do
    self:ApplyRelic(relic)
  end
end

function SeasonMazeService:ApplyRelic(relicID)
  local buffLSvc = self._world:GetService("BuffLogic")
  local cfg = Cfg.cfg_item_relic[relicID]
  if #cfg.BuffID > 0 then
    for _, buffID in ipairs(cfg.BuffID) do
      if 0 < buffID then
        Log.notice("[SeasonMaze ApplyRelic] add buff:", buffID, " relic:", relicID)
        local buffIns = buffLSvc:AddBuffByTargetType(buffID, cfg.BuffTargetType, cfg.BuffTargetParam)
        for _, buffIn in ipairs(buffIns) do
          buffIn:SetRelicID(relicID)
        end
      end
    end
  end
end

function SeasonMazeService:AddRelicCount(relic)
  local cmpt = self:GetSeasonMazeLogicComponent()
  cmpt:AddRelicCount(relic)
end

function SeasonMazeService:GetGoldCoin()
  local cmpt = self:GetSeasonMazeLogicComponent()
  return cmpt:GetGoldCoin()
end

function SeasonMazeService:GetWaveRandoms()
  local cmpt = self:GetSeasonMazeLogicComponent()
  return cmpt:GetWaveRandoms()
end

function SeasonMazeService:GetInitAUOEValue()
  local cmpt = self:GetSeasonMazeLogicComponent()
  return cmpt:GetInitAUOEValue()
end
