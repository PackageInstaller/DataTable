_class("MonsterShowLogicService", BaseService)
MonsterShowLogicService = MonsterShowLogicService

function MonsterShowLogicService:DoAllMonsterDeadLogic(deadMarkOrderRequired)
  local drops = self:_CalcMonsterDrop()
  self:_DoPhantamDead()
  local deadEntityIDList = {}
  local deadMarkAddCountMap = {}
  local deadMonsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadMark)
  for _, e in ipairs(deadMonsterGroup:GetEntities()) do
    if e:HasMonsterID() and not e:DeadMark():HasDoLogicDead() then
      deadEntityIDList[#deadEntityIDList + 1] = e:GetID()
      deadMarkAddCountMap[e:GetID()] = e:DeadMark():GetDeadMarkAddCount()
    end
  end
  if deadMarkOrderRequired then
    table.sort(deadEntityIDList, function(a, b)
      return deadMarkAddCountMap[a] < deadMarkAddCountMap[b]
    end)
  end
  for _, v in ipairs(deadEntityIDList) do
    local monsterEntity = self._world:GetEntityByID(v)
    self:_DoLogicDead(monsterEntity)
  end
  return drops, deadEntityIDList
end

function MonsterShowLogicService:_DoPhantamDead()
  local deadMonsters = self._world:GetGroup(self._world.BW_WEMatchers.DeadMark):GetEntities()
  local phantoms = self._world:GetGroup(self._world.BW_WEMatchers.Phantom):GetEntities()
  if deadMonsters and 0 < #deadMonsters and phantoms and 0 < #phantoms then
    local deads = {}
    for _, entity in ipairs(deadMonsters) do
      deads[entity:GetID()] = true
    end
    for _, phantom in ipairs(phantoms) do
      if deads[phantom:PhantomComponent():GetOwnerEntityID()] then
        phantom:AddDeadMark()
      end
    end
  end
end

function MonsterShowLogicService:_CalcMonsterDeathSkill(monsterEntity)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local monsterIDCmpt = monsterEntity:MonsterID()
  local deathSkillID = 0
  if monsterIDCmpt then
    deathSkillID = monsterConfigData:GetMonsterDeathSkillID(monsterIDCmpt:GetMonsterID())
    if deathSkillID then
      local skillLogicService = self._world:GetService("SkillLogic")
      skillLogicService:CalcSkillEffect(monsterEntity, deathSkillID)
      skillLogicService:UpdateRenderSkillRoutine(monsterEntity)
    end
  end
  return deathSkillID
end

function MonsterShowLogicService:_DoLogicDead(monsterEntity)
  if not monsterEntity:HasDeadMark() then
    Log.exception("monster entity has not dead,", Log.traceback())
    return
  end
  local deadMarkCmpt = monsterEntity:DeadMark()
  if deadMarkCmpt:HasDoLogicDead() then
    return
  end
  local monsterIDCmpt = monsterEntity:MonsterID()
  if not monsterIDCmpt then
    return
  end
  deadMarkCmpt:SetDoLogicDead(true)
  local sTrigger = self._world:GetService("Trigger")
  sTrigger:Notify(NTMonsterDeadStart:New(monsterEntity))
  self:CalcDropSkill(monsterEntity)
  self:_CalcMonsterDeathSkill(monsterEntity)
  local sBoard = self._world:GetService("BoardLogic")
  sBoard:RemoveEntityBlockFlag(monsterEntity, monsterEntity:GridLocation().Position)
  local battleSvc = self._world:GetService("Battle")
  battleSvc:RemoveMonsterAuraRange(monsterEntity)
  sTrigger:Notify(NTMonsterDead:New(monsterEntity))
  monsterEntity:SetGridPosition(Vector2(BattleConst.CacheHeight, BattleConst.CacheHeight))
  sTrigger:Notify(NTMonsterDeadEnd:New(monsterEntity))
end

function MonsterShowLogicService:_CalcMonsterDrop()
  local deadMonsterArray = self:_CalcDeadMonsterOrder()
  local dropService = self._world:GetService("Drop")
  local drops = {}
  for _, deadEntityID in ipairs(deadMonsterArray) do
    local monsterEntity = self._world:GetEntityByID(deadEntityID)
    local dropCmpt = monsterEntity:DropAsset()
    if not dropCmpt:HasDoDrop() then
      dropCmpt:SetDoDrop(true)
      local monsterIDCmpt = monsterEntity:MonsterID()
      if monsterIDCmpt then
        local monsterConfigID = monsterIDCmpt:GetMonsterID()
        local monsterConfigData = self._configService:GetMonsterConfigData()
        local dropArray = monsterConfigData:GetMonsterDropIDs(monsterConfigID)
        local dropAssetList = {}
        if dropArray ~= nil then
          for _, v in ipairs(dropArray) do
            local asset = dropService:DoActorDrop(v.dropID, deadEntityID, true)
            if asset then
              table.insert(dropAssetList, {
                asset = asset,
                effect = v.dropEffectID or 0
              })
            end
          end
        end
        local dropItem = {
          Drops = dropAssetList,
          Pos = monsterEntity:GridLocation():Center()
        }
        dropCmpt:SetDropAsset(dropItem)
        table.insert(drops, dropItem)
      end
    end
  end
  return drops
end

function MonsterShowLogicService:CalcDropSkill(e)
  local skillLogicService = self._world:GetService("SkillLogic")
  local utilDataSvc = self._world:GetService("UtilData")
  local skillId = utilDataSvc:GetDropSkill(e)
  if skillId and 0 < skillId then
    skillLogicService:CalcSkillEffect(e, skillId)
    skillLogicService:UpdateRenderSkillRoutine(e)
  end
end

local sort_world

local function Sort__CalcDeadMonsterOrder(entityID1, entityID2)
  local playerPos = sort_world:Player():GetLocalTeamEntity():GridLocation().Position
  local pos1 = sort_world:GetEntityByID(entityID1):GridLocation().Position
  local pos2 = sort_world:GetEntityByID(entityID2):GridLocation().Position
  local dis1 = Vector2.Distance(playerPos, pos1)
  local dis2 = Vector2.Distance(playerPos, pos2)
  return dis1 < dis2
end

function MonsterShowLogicService:_CalcDeadMonsterOrder()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadMark)
  local deadMonsterArray = {}
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if e:HasMonsterID() then
      deadMonsterArray[#deadMonsterArray + 1] = e:GetID()
    end
  end
  if self._world:Player():GetLocalTeamEntity() then
    sort_world = self._world
    table.sort(deadMonsterArray, Sort__CalcDeadMonsterOrder)
    sort_world = nil
  end
  return deadMonsterArray
end

function MonsterShowLogicService:AddMonsterDeadMark(entity, ignoreBattleStat)
  if not entity:HasMonsterID() then
    return
  end
  local cAttributes = entity:Attributes()
  local curHp = cAttributes:GetCurrentHP()
  if 0 < curHp then
    return
  end
  if entity:HasDeadMark() then
    return
  end
  local world = entity:GetOwnerWorld()
  local battleStatCmpt = world:BattleStat()
  if not ignoreBattleStat then
    battleStatCmpt:AddDeadMonsterID(entity:MonsterID():GetMonsterID())
    battleStatCmpt:AddDeadMonsterBuffInfo(entity)
  end
  entity:AddDeadMark()
  return entity:DeadMark()
end

function MonsterShowLogicService:IsAllMonsterHasDeadMark()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local team = self._world:Player():GetRemoteTeamEntity()
    return team:HasTeamDeadMark()
  end
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local isDead = e:HasDeadMark()
    if not isDead then
      return false
    end
  end
  return true
end

function MonsterShowLogicService:ClearMonsterDeadEntity()
  local toDestroyIDList = {}
  local monsterDeadGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadMark)
  for _, e in ipairs(monsterDeadGroup:GetEntities()) do
    toDestroyIDList[#toDestroyIDList + 1] = e:GetID()
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  for _, entityID in ipairs(toDestroyIDList) do
    local deadEntity = self._world:GetEntityByID(entityID)
    buffLogicService:RemoveAllBuffInstance(deadEntity)
    self._world:DestroyEntity(deadEntity)
  end
end

function MonsterShowLogicService:Transformation(result, skillEffectParam)
  if result:GetCaster() then
    local caster = self._world:GetEntityByID(result:GetCaster())
    local elementType = 0
    local targetID = result:GetMonsterID()
    if not caster:HasMonsterID() then
      Log.fatal("[Skill] 严重错误，只有怪物才能变身")
      return
    end
    local cfgService = self._world:GetService("Config")
    local monsterConfigData = cfgService:GetMonsterConfigData()
    local raceType = monsterConfigData:GetMonsterRaceType(targetID)
    local monsterType = monsterConfigData:GetMonsterType(targetID)
    local monsterGroupID = monsterConfigData:GetMonsterGroupID(targetID)
    local monsterClassID = monsterConfigData:GetMonsterClassID(targetID)
    local monsterCampType = monsterConfigData:GetMonsterCampType(targetID)
    caster:ReplaceMonsterID(targetID, raceType, monsterType, monsterGroupID, monsterClassID, monsterCampType)
    local attributeCmpt = caster:Attributes()
    local attack = monsterConfigData:GetMonsterAttack(targetID)
    local defense = monsterConfigData:GetMonsterDefense(targetID)
    local evade = monsterConfigData:GetMonsterEvade(targetID)
    local maxHP = attributeCmpt:CalcMaxHp()
    local resultMaxHP = maxHP
    local inherAttribute = skillEffectParam:GetInheritAttribute()
    if 0 < table.count(inherAttribute) then
      if inherAttribute.Attack then
        local originalAttack = attributeCmpt:GetAttribute("Attack")
        attack = math.floor(originalAttack * inherAttribute.Attack)
      end
      if inherAttribute.Defense then
        local originalDefense = attributeCmpt:GetAttribute("Defense")
        defense = math.floor(originalDefense * inherAttribute.Defense)
      end
      if inherAttribute.MaxHP then
        resultMaxHP = math.floor(maxHP * inherAttribute.MaxHP)
      end
    end
    local useHpPercent = result:GetUseHpPercent()
    if useHpPercent ~= 0 then
      local hp = attributeCmpt:GetCurrentHP()
      local curHpPercent = hp / maxHP
      local TransformationHp = math.floor((curHpPercent + useHpPercent / 100) * resultMaxHP)
      if resultMaxHP < TransformationHp then
        TransformationHp = resultMaxHP
      end
      attributeCmpt:Modify("HP", TransformationHp)
      result:SetTransformationHp(TransformationHp)
      result:SetTransformationHpMax(resultMaxHP)
      self._world:GetSyncLogger():Trace({
        key = "Transformation",
        casterID = caster:GetID(),
        beforeHp = hp,
        beforeMaxHp = maxHP,
        targetHp = resultMaxHP,
        useHpPercent = useHpPercent,
        transformationHp = TransformationHp
      })
      self:LogNotice("Transformation() caster=", caster:GetID(), " beforeHp=", hp, " beforeMaxHp=", maxHP, " targetHp=", resultMaxHP, " useHpPercent=", useHpPercent, " transformationHp=", TransformationHp)
    end
    attributeCmpt:Modify("Attack", attack)
    attributeCmpt:Modify("Defense", defense)
    attributeCmpt:Modify("Evade", evade)
    attributeCmpt:Modify("MaxHP", resultMaxHP)
    elementType = monsterConfigData:GetMonsterElementType(targetID)
    local nheritElement = skillEffectParam:GetInheritElement()
    if nheritElement then
      local oriEntity = caster
      if caster:HasSuperEntity() then
        oriEntity = caster:GetSuperEntity()
      end
      if oriEntity:HasAttributes() then
        local attrCmpt = oriEntity:Attributes()
        elementType = attrCmpt:GetAttribute("Element")
      end
    end
    caster:ReplaceElement(elementType, nil)
    attributeCmpt:SetSimpleAttribute("Element", elementType)
    result:SetElementType(elementType)
    local casterPos = caster:GetGridPosition()
    local oriCasterPos = casterPos
    local newPosIndexInOriBodyArea = skillEffectParam:GetSetTargetPosByOriBodyAreaIndex()
    if newPosIndexInOriBodyArea ~= 0 then
      local oriBodyArea = caster:BodyArea():GetArea()
      if newPosIndexInOriBodyArea <= #oriBodyArea then
        local off = oriBodyArea[newPosIndexInOriBodyArea]
        casterPos = casterPos + off
        result:SetNewPos(casterPos)
      end
    end
    if skillEffectParam:IsUseTargetBodyArea() then
      local sBoard = self._world:GetService("BoardLogic")
      local bodyArea, blockFlag = sBoard:RemoveEntityBlockFlag(caster, oriCasterPos)
      local areaArray = monsterConfigData:GetMonsterArea(targetID)
      caster:ReplaceBodyArea(areaArray)
      sBoard:SetEntityBlockFlag(caster, casterPos, blockFlag)
    end
    caster:SetGridPosition(casterPos)
  end
end

function MonsterShowLogicService:ChangeElement(result)
  if result:GetTarget() then
    local target = self._world:GetEntityByID(result:GetTarget())
    local attributeCmpt = target:Attributes()
    local elementType = result:GetElementType()
    target:ReplaceElement(elementType, nil)
    attributeCmpt:SetSimpleAttribute("Element", elementType)
  end
end

function MonsterShowLogicService:DoLogicFeatureDead(monsterEntity)
  if not monsterEntity:HasDeadMark() then
    Log.exception("monster entity has not dead,", Log.traceback())
    return
  end
  local deadMarkCmpt = monsterEntity:DeadMark()
  if deadMarkCmpt:HasDoLogicDead() then
    return
  end
  local monsterIDCmpt = monsterEntity:MonsterID()
  if not monsterIDCmpt then
    return
  end
  deadMarkCmpt:SetDoLogicDead(true)
  local sBoard = self._world:GetService("BoardLogic")
  sBoard:RemoveEntityBlockFlag(monsterEntity, monsterEntity:GetGridPosition())
  monsterEntity:SetGridPosition(Vector2(BattleConst.CacheHeight, BattleConst.CacheHeight))
end
