require("trigger_base")
_class("TTBloodLessThan", TriggerBase)
TTBloodLessThan = TTBloodLessThan

function TTBloodLessThan:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local entity = notify:GetNotifyEntity()
  local curhp = owner:Attributes():GetCurrentHP()
  local maxhp = owner:Attributes():CalcMaxHp()
  local battleSvc = self._world:GetService("Battle")
  if not self._y then
    curhp, maxhp = battleSvc:GetCasterHP(owner)
  elseif owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    local cAttr = teamEntity:Attributes()
    curhp = cAttr:GetCurrentHP()
    maxhp = cAttr:CalcMaxHp()
  end
  local isOwnerAndNotifierPlayer = not (owner:HasTeam() or entity:HasTeam()) or owner:HasPetPstID() or entity:HasPetPstID()
  local blood = curhp / maxhp
  return blood < self._x and (owner:GetID() == entity:GetID() or isOwnerAndNotifierPlayer)
end

_class("TTBloodMoreThan", TriggerBase)
TTBloodMoreThan = TTBloodMoreThan

function TTBloodMoreThan:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local entity = notify:GetNotifyEntity()
  local curhp = owner:Attributes():GetCurrentHP()
  local maxhp = owner:Attributes():CalcMaxHp()
  local battleSvc = self._world:GetService("Battle")
  if not self._y then
    curhp, maxhp = battleSvc:GetCasterHP(owner)
  elseif owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    local cAttr = teamEntity:Attributes()
    curhp = cAttr:GetCurrentHP()
    maxhp = cAttr:CalcMaxHp()
  end
  if notify:GetNotifyType() == NotifyType.PlayerMoveStart then
    local curBlood = curhp / maxhp
    return curBlood > self._x
  end
  local isOwnerAndNotifierPlayer = not (owner:HasTeam() or entity:HasTeam()) or owner:HasPetPstID() or entity:HasPetPstID()
  local blood = curhp / maxhp
  return blood > self._x and (owner:GetID() == entity:GetID() or isOwnerAndNotifierPlayer)
end

_class("TTBloodEqual", TriggerBase)
TTBloodEqual = TTBloodEqual

function TTBloodEqual:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local entity = notify:GetNotifyEntity()
  local battleSvc = self._world:GetService("Battle")
  local curhp = owner:Attributes():GetCurrentHP()
  local maxhp = owner:Attributes():CalcMaxHp()
  if not self._y then
    curhp, maxhp = battleSvc:GetCasterHP(owner)
  elseif owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    local cAttr = teamEntity:Attributes()
    curhp = cAttr:GetCurrentHP()
    maxhp = cAttr:CalcMaxHp()
  end
  local isOwnerAndNotifierPlayer = not (owner:HasTeam() or entity:HasTeam()) or owner:HasPetPstID() or entity:HasPetPstID()
  local blood = curhp / maxhp
  return blood == self._x and (owner:GetID() == entity:GetID() or isOwnerAndNotifierPlayer)
end

_class("TTOwnerBlood", TriggerBase)
TTOwnerBlood = TTOwnerBlood

function TTOwnerBlood:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local curhp = owner:Attributes():GetCurrentHP()
  local maxhp = owner:Attributes():CalcMaxHp()
  local blood = curhp / maxhp
  return CompareNumber(self._x, blood, self._y)
end

_class("TTDamageLargerThenRate", TriggerBase)
TTDamageLargerThenRate = TTDamageLargerThenRate

function TTDamageLargerThenRate:IsSatisfied(notify)
  return math.abs(notify:GetChangeHP()) / notify:GetMaxHP() > self._x
end

_class("TTAttackElementMatch", TriggerBase)
TTAttackElementMatch = TTAttackElementMatch

function TTAttackElementMatch:IsSatisfied(notify)
  local element
  local ownerEntity = notify:GetAttackerEntity()
  if notify:GetAttackerEntity():PetPstID() then
    element = notify:GetAttackerEntity():Attributes():GetAttribute("Element")
  elseif notify:GetAttackerEntity():MonsterID() then
    element = notify:GetAttackerEntity():Element():GetPrimaryType()
  end
  for i, p in ipairs(self._param) do
    if element == p then
      return true
    end
  end
  return false
end

_class("TTTargetGridElementMatch", TriggerBase)
TTTargetGridElementMatch = TTTargetGridElementMatch

function TTTargetGridElementMatch:IsSatisfied(notify)
  local utilData = self._world:GetService("UtilData")
  local gridPos = notify:GetDefenderEntity():GridLocation().Position
  if notify:GetDefenderEntity():BodyArea() then
    local bodyAreaComponent = notify:GetDefenderEntity():BodyArea()
    local bodyArea = bodyAreaComponent._area
    for _, v in ipairs(bodyArea) do
      local pieceElement = utilData:FindPieceElement(Vector2(gridPos.x + v.x, gridPos.y + v.y))
      for _, elementType in ipairs(self._param) do
        if elementType == pieceElement then
          return true
        end
      end
    end
  else
    local pieceElement = utilData:FindPieceElement(gridPos)
    for _, elementType in ipairs(self._param) do
      if elementType == pieceElement then
        return true
      end
    end
  end
  return false
end

_class("TTDefenderElementMatch", TriggerBase)
TTDefenderElementMatch = TTDefenderElementMatch

function TTDefenderElementMatch:IsSatisfied(notify)
  self._satisfied = false
  local attacker = notify:GetNotifyEntity()
  local defender = notify:GetDefenderEntity()
  if attacker == nil or defender == nil then
    return
  end
  local owner = self:GetOwnerEntity()
  if owner:GetID() ~= attacker:GetID() then
    return
  end
  local elementCom = defender:Element()
  if not elementCom then
    return
  end
  local defElement = elementCom:GetPrimaryType()
  for _, element in ipairs(self._param) do
    if element == defElement then
      return true
    end
  end
end

_class("TTCombo", TriggerBase)

function TTCombo:IsSatisfied(notify)
  local combo = self._world:GetService("Battle"):GetLogicComboNum()
  return 0 < combo and combo % self._x == 0
end

_class("TTOwnerElementMatch", TriggerBase)
TTOwnerElementMatch = TTOwnerElementMatch

function TTOwnerElementMatch:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local element
  if entity:PetPstID() then
    element = entity:Attributes():GetAttribute("Element")
  elseif entity:MonsterID() then
    element = entity:Attributes():GetAttribute("Element")
  end
  for i, p in ipairs(self._param) do
    if element == p then
      return true
    end
  end
end

_class("TTNotifyBuff", TriggerBase)
TTNotifyBuff = TTNotifyBuff

function TTNotifyBuff:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local entity = notify:GetNotifyEntity()
  if entity and owner ~= entity then
    return false
  end
  local buffCmp = owner:BuffComponent()
  if not buffCmp then
    return false
  end
  self._satisfied = false
  for i, buffEffect in ipairs(self._param) do
    if buffCmp:HasBuffEffect(buffEffect) then
      return true
    end
  end
end

_class("TTNotifyOnlyBuff", TriggerBase)
TTNotifyOnlyBuff = TTNotifyOnlyBuff

function TTNotifyOnlyBuff:OnNotify(notify)
  local entity = notify:GetNotifyEntity()
  self._satisfied = false
  local buffCmp = entity:BuffComponent()
  for i, buffEffect in ipairs(self._param) do
    if buffCmp:HasBuffEffect(buffEffect) then
      self._satisfied = true
      break
    end
  end
end

function TTNotifyOnlyBuff:IsSatisfied()
  return self._satisfied
end

_class("TTTrapOnPos", TriggerBase)
TTTrapOnPos = TTTrapOnPos

function TTTrapOnPos:OnNotify(notify)
  self._pos = notify:GetPos()
end

function TTTrapOnPos:IsSatisfied()
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local listIDRet = {}
  local listTraps = trapGroup:GetEntities()
  for i = 1, #listTraps do
    local trap = listTraps[i]
    if trap then
      local pos = trap:GetGridPosition()
      local bodyArea = trap:BodyArea()
      local bodyAreaList = bodyArea:GetArea()
      for _, area in ipairs(bodyAreaList) do
        if area.x + pos.x == self._pos.x and area.y + pos.y == self._pos.y then
          local trapComponent = trap:Trap()
          if trapComponent and trapComponent:GetTrapID() then
            table.insert(listIDRet, trapComponent:GetTrapID())
          end
        end
      end
    end
  end
  for index, trapID in ipairs(listIDRet) do
    if trapID == self._x then
      return true
    end
  end
end

_class("TTCheckNoDeadTrapOnPos", TriggerBase)
TTCheckNoDeadTrapOnPos = TTCheckNoDeadTrapOnPos

function TTCheckNoDeadTrapOnPos:OnNotify(notify)
  self._pos = notify:GetPos()
end

function TTCheckNoDeadTrapOnPos:IsSatisfied()
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local listIDRet = {}
  local listTraps = trapGroup:GetEntities()
  for i = 1, #listTraps do
    local trap = listTraps[i]
    local canSelect = true
    local deadMarkCmpt = trap:DeadMark()
    if deadMarkCmpt and deadMarkCmpt:GetDeadStateID() == GameStateID.ActiveSkill then
      canSelect = false
    end
    if trap and canSelect then
      local pos = trap:GetGridPosition()
      local bodyArea = trap:BodyArea()
      local bodyAreaList = bodyArea:GetArea()
      for _, area in ipairs(bodyAreaList) do
        if area.x + pos.x == self._pos.x and area.y + pos.y == self._pos.y then
          local trapComponent = trap:Trap()
          if trapComponent and trapComponent:GetTrapID() then
            table.insert(listIDRet, trapComponent:GetTrapID())
          end
        end
      end
    end
  end
  for index, trapID in ipairs(listIDRet) do
    if trapID == self._x then
      return true
    end
  end
end

_class("TTSameCampInTeam", TriggerBase)
TTSameCampInTeam = TTSameCampInTeam

function TTSameCampInTeam:Constructor()
  self._targetCampType = self._param[1]
  self._targetCount = self._param[2]
  self._satisfied = false
end

function TTSameCampInTeam:IsSatisfied()
  local dicPetCampCount = {}
  local pets = self._world:GetLocalMatchPetList()
  for _, matchPet in ipairs(pets) do
    local campID = matchPet:GetPetCamp()
    if not dicPetCampCount[campID] then
      dicPetCampCount[campID] = 0
    end
    dicPetCampCount[campID] = dicPetCampCount[campID] + 1
  end
  local requiredCount = dicPetCampCount[self._targetCampType]
  if requiredCount and requiredCount >= self._targetCount then
    self._satisfied = true
  end
  Log.notice("TTSameCampInTeam: IsSatisfied=", self._satisfied, "requiredCamp=", self._targetCampType, "requiredCount=", self._targetCount)
  return self._satisfied
end

_class("TTOwnerBuff", TriggerBase)
TTOwnerBuff = TTOwnerBuff

function TTOwnerBuff:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if owner:HasDeadMark() then
    return false
  end
  local buffCmp = owner:BuffComponent()
  if not buffCmp then
    return
  end
  self._satisfied = false
  for i, buffEffect in ipairs(self._param) do
    if buffCmp:HasBuffEffect(buffEffect) then
      self._satisfied = true
      return true
    end
  end
end

_class("TTOwnerNoBuff", TriggerBase)
TTOwnerNoBuff = TTOwnerNoBuff

function TTOwnerNoBuff:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if owner:HasDeadMark() then
    return false
  end
  local buffCmp = owner:BuffComponent()
  if not buffCmp then
    return
  end
  self._satisfied = false
  for i, buffEffect in ipairs(self._param) do
    if buffCmp:HasBuffEffect(buffEffect) then
      self._satisfied = false
      return false
    end
  end
  return true
end

_class("TTDefenderBuff", TriggerBase)
TTDefenderBuff = TTDefenderBuff

function TTDefenderBuff:IsSatisfied(notify)
  local buffCmp = notify:GetDefenderEntity():BuffComponent()
  if not buffCmp then
    return
  end
  for i, buffEffect in ipairs(self._param) do
    if buffCmp:HasBuffEffect(buffEffect) then
      return true
    end
  end
end

_class("TTDefenderNoBuff", TriggerBase)
TTDefenderNoBuff = TTDefenderNoBuff

function TTDefenderNoBuff:IsSatisfied(notify)
  if not notify:GetDefenderEntity() then
    return false
  end
  local buffCmp = notify:GetDefenderEntity():BuffComponent()
  if not buffCmp then
    return false
  end
  for i, buffEffect in ipairs(self._param) do
    if buffCmp:HasBuffEffect(buffEffect) then
      return false
    end
  end
  return true
end

_class("TTDefenderBodyAreaHasTrap", TriggerBase)
TTDefenderBodyAreaHasTrap = TTDefenderBodyAreaHasTrap

function TTDefenderBodyAreaHasTrap:IsSatisfied(notify)
  local defender = notify:GetDefenderEntity()
  if not defender then
    return false
  end
  local utilSvc = self._world:GetService("UtilData")
  local gridPosition = defender:GetGridPosition()
  local bodyArea = defender:BodyArea():GetArea()
  for _, areaPos in ipairs(bodyArea) do
    local workPos = areaPos + gridPosition
    local traps = utilSvc:GetTrapsAtPos(workPos)
    if traps then
      for index, e in ipairs(traps) do
        if table.intable(self._param, e:Trap():GetTrapID()) then
          return true
        end
      end
    end
  end
  return false
end

_class("TTMazeRoomType", TriggerBase)
TTMazeRoomType = TTMazeRoomType

function TTMazeRoomType:IsSatisfied()
  local mazeService = self:GetWorld():GetService("Maze")
  if mazeService:GetMazeRoomType() == self._x then
    return true
  end
end

_class("TTMonsterAI", TriggerBase)
TTMonsterAI = TTMonsterAI

function TTMonsterAI:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local monsterID = entity:MonsterID()
  if not monsterID then
    return
  end
  local cfgService = self._world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local monsterAIIDList = monsterConfigData:GetMonsterAIID(monsterID:GetMonsterID())
  local monsterMainAIID = monsterAIIDList[1][1]
  return table.icontains(self._param, monsterMainAIID)
end

_class("TTMonsterAIAliveCount", TriggerBase)
TTMonsterAIAliveCount = TTMonsterAIAliveCount

function TTMonsterAIAliveCount:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if owner:HasDeadMark() then
    return false
  end
  local cfgService = self._world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local notifyEntity = notify:GetNotifyEntity()
  local notifyEntityMonsterID = notifyEntity:MonsterID()
  local notifyEntityMonsterAIIDList = monsterConfigData:GetMonsterAIID(notifyEntityMonsterID:GetMonsterID())
  if notifyEntityMonsterAIIDList[1][1] ~= self._x then
    return false
  end
  local aliveCount = 0
  local cfgService = self._world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadMark() and e:GetID() ~= notifyEntity:GetID() then
      local monsterID = e:MonsterID()
      local monsterAIIDList = monsterConfigData:GetMonsterAIID(monsterID:GetMonsterID())
      if monsterAIIDList[1][1] == self._x then
        aliveCount = aliveCount + 1
      end
    end
  end
  local isSatisfied = aliveCount == self._y or self._z and aliveCount == self._z
  return isSatisfied
end

_class("TTMonsterBodyArea", TriggerBase)
TTMonsterBodyArea = TTMonsterBodyArea

function TTMonsterBodyArea:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local cnt = entity:BodyArea():GetAreaCount()
  if cnt == 1 and self._x == 1 then
    return true
  end
  if 1 < cnt and 1 < self._x then
    return true
  end
  return false
end

_class("TTRegularBodyMonster", TriggerBase)
TTRegularBodyMonster = TTRegularBodyMonster

function TTRegularBodyMonster:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  if not entity then
    return false
  end
  local cfgService = self._world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  if monsterConfigData:IsRegularShape(entity:MonsterID():GetMonsterID()) then
    return true
  end
  return false
end

_class("TTMonsterClassIDMatch", TriggerBase)
TTMonsterClassIDMatch = TTMonsterClassIDMatch

function TTMonsterClassIDMatch:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local monsterID = entity:MonsterID():GetMonsterID()
  local monsterClassID = 0
  local cfg = Cfg.cfg_monster[monsterID]
  if cfg and cfg.ClassID then
    monsterClassID = cfg.ClassID
  end
  if table.intable(self._param, monsterClassID) then
    return true
  end
  return false
end

_class("TTCountCycle", TriggerCount)
TTCountCycle = TTCountCycle

function TTCountCycle:OnNotify(notify)
  self:AddCount(1)
end

function TTCountCycle:IsSatisfied(notify)
  local _satisfied = self._count >= self._x
  if _satisfied then
    self:SetCount(0)
  end
  return _satisfied
end

_class("TTCompareCount", TriggerBase)
TTCompareCount = TTCompareCount

function TTCompareCount:IsSatisfied(notify)
  local operation = self._x
  local owner = self:GetOwnerEntity()
  local cBuff = owner:BuffComponent()
  local key = self:GetKeyStr()
  if operation == 1 then
    local n = self._z or 1
    local newCount = cBuff:GetBuffValue(key) or 0
    newCount = newCount + n
    cBuff:SetBuffValue(key, newCount)
    return true
  end
  if operation == 2 then
    local n = self._z or 0
    cBuff:SetBuffValue(key, n)
    return true
  end
  local countSave = cBuff:GetBuffValue(key) or 0
  local compareFlag = self._param[3]
  local count = self._param[4]
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = countSave == count
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = countSave ~= count
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = countSave > count
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = countSave >= count
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = countSave < count
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = countSave <= count
  end
  return satisfied
end

function TTCompareCount:GetKeyStr()
  return "CompareTriggerCount" .. self._y
end

local ComparisonOperator = {
  EQ = 1,
  NE = 2,
  GT = 3,
  GE = 4,
  LT = 5,
  LE = 6
}
_enum("ComparisonOperator", ComparisonOperator)
_class("TTSpecificPetNormalHitMe", TriggerBase)
TTSpecificPetNormalHitMe = TTSpecificPetNormalHitMe

function TTSpecificPetNormalHitMe:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.PlayerBeHit and notify:GetNotifyType() ~= NotifyType.MonsterBeHit then
    return
  end
  local attacker = notify:GetAttackerEntity()
  if notify:GetSkillType() == SkillType.Normal and attacker:HasPetPstID() and attacker:PetPstID():GetTemplateID() == self._x and notify:GetDefenderEntity() == self:GetOwnerEntity() then
    return true
  end
end

_class("TTPetNotify", TriggerBase)
TTPetNotify = TTPetNotify

function TTPetNotify:IsSatisfied(notify)
  local notifyEntity = notify:GetNotifyEntity()
  if not notifyEntity then
    return false
  end
  if notifyEntity:PetPstID() then
    return true
  end
  if notifyEntity:HasSuperEntity() and notifyEntity:EntityType():IsSkillHolder() then
    return notifyEntity:GetSuperEntity():HasPetPstID()
  end
  return false
end

_class("TTDefenderDistance", TriggerBase)
TTDefenderDistance = TTDefenderDistance

function TTDefenderDistance:IsSatisfied(notify)
  local attacker = notify:GetNotifyEntity()
  local attackPos = notify:GetTargetPos()
  if not attacker:PetPstID() then
    return false
  end
  if attacker ~= self:GetOwnerEntity() then
    return false
  end
  local attackerPos = attacker:GridLocation():Center()
  local distance = Vector2.Distance(attackPos, attackerPos)
  local paramDistance = tonumber(self._param[1])
  if distance < paramDistance then
    return true
  end
  return false
end

_class("TTMonsterSkillDamageEnd", TriggerBase)
TTMonsterSkillDamageEnd = TTMonsterSkillDamageEnd

function TTMonsterSkillDamageEnd:IsSatisfied(notify)
  self._satisfied = false
  local attacker = notify:GetNotifyEntity()
  local owner = self:GetOwnerEntity()
  if owner ~= attacker then
    return false
  end
  local skillId = notify:GetSkillID()
  if self._x == skillId then
    return true
  end
  if self._param and table.intable(self._param, skillId) then
    return true
  end
  return false
end

_class("TTActiveSkillFirstHitRow", TriggerBase)
TTActiveSkillFirstHitRow = TTActiveSkillFirstHitRow

function TTActiveSkillFirstHitRow:Constructor()
  self._firstRowPosList = nil
end

function TTActiveSkillFirstHitRow:Reset()
  self._firstRowPosList = nil
end

function TTActiveSkillFirstHitRow:IsSatisfied(notify)
  local attacker = notify:GetNotifyEntity()
  local owner = self:GetOwnerEntity()
  if owner ~= attacker then
    return false
  end
  if notify:GetNotifyType() == NotifyType.NotifyTrainFirstRowPos then
    self._firstRowPosList = notify:GetData()
  end
  if not self._firstRowPosList then
    return false
  end
  if notify:GetNotifyType() == NotifyType.ActiveSkillEachAttackStart then
    local targetPos = notify:GetTargetPos()
    if table.icontains(self._firstRowPosList, targetPos) then
      return true
    end
  end
  if notify:GetNotifyType() == NotifyType.ActiveSkillAttackEnd or notify:GetNotifyType() == NotifyType.ActiveSkillAttackEndBeforeMonsterDead then
    self:Reset()
  end
  return false
end

_class("TTTargetPosIsSkillCenterPos", TriggerBase)
TTTargetPosIsSkillCenterPos = TTTargetPosIsSkillCenterPos

function TTTargetPosIsSkillCenterPos:Constructor()
end

function TTTargetPosIsSkillCenterPos:IsSatisfied(notify)
  local entityCaster = notify:GetNotifyEntity()
  if entityCaster == self:GetOwnerEntity() then
    return false
  end
  local targetPos = notify:GetTargetPos()
  local skillResult = entityCaster:SkillContext():GetResultContainer()
  local centerPos = skillResult:GetScopeResult():GetCenterPos()
  local ret = targetPos == centerPos
  return ret
end

_class("TTTargetBodyAreaSubset", TriggerBase)
TTTargetBodyAreaSubset = TTTargetBodyAreaSubset

function TTTargetBodyAreaSubset:IsSatisfied(notify)
  local defender = notify:GetDefenderEntity()
  local posDefender = defender:GridLocation().Position
  local exceptionPos = {}
  for i = 1, table.count(self._param), 2 do
    local v = Vector2(self._param[i], self._param[i + 1])
    local pos = v + posDefender
    table.insert(exceptionPos, pos)
  end
  if table.icontains(exceptionPos, notify:GetTargetPos()) then
    return true
  end
  return false
end

_class("TTTargetBodyAreaSubsetBuff", TriggerBase)
TTTargetBodyAreaSubsetBuff = TTTargetBodyAreaSubsetBuff

function TTTargetBodyAreaSubsetBuff:IsSatisfied(notify)
  local defender = notify:GetDefenderEntity()
  local posDefender = defender:GridLocation().Position
  local attackRange = notify:GetAttackRange()
  local posList = {}
  for i = 1, table.count(self._param), 2 do
    local v = Vector2(self._param[i], self._param[i + 1])
    local pos = v + posDefender
    table.insert(posList, pos)
  end
  if attackRange then
    for _, grid in ipairs(attackRange) do
      if table.icontains(posList, grid) then
        return false
      end
    end
  end
  return true
end

_class("TTMonsterKilled", TriggerBase)
TTMonsterKilled = TTMonsterKilled

function TTMonsterKilled:IsSatisfied(notify)
  local isOnlySelf = self._param[1] == 1
  local entity = notify:GetNotifyEntity()
  local ownerEntity = self:GetOwnerEntity()
  if isOnlySelf and entity:GetID() ~= ownerEntity:GetID() then
    return false
  end
  local skillEffectResultContainer = entity:SkillContext():GetResultContainer()
  if not skillEffectResultContainer then
    return false
  end
  local skillScopeResult = skillEffectResultContainer:GetScopeResult()
  if not skillScopeResult then
    return false
  end
  local world = entity:GetOwnerWorld()
  local ids = skillScopeResult:GetTargetIDs()
  for _, monsterEntityID in ipairs(ids) do
    local entity = world:GetEntityByID(monsterEntityID)
    local monsterID = entity:MonsterID()
    if monsterID then
      local attributeComponent = entity:Attributes()
      if attributeComponent then
        local logicHP = attributeComponent:GetCurrentHP()
        if not entity or entity:HasDeadMark() or logicHP <= 0 then
          return true
        end
      end
    end
  end
  return false
end

_class("TTLimitAiRound", TriggerBase)
TTLimitAiRound = TTLimitAiRound

function TTLimitAiRound:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local aiComponent = owner:AI()
  local nSaveRound = aiComponent:GetRuntimeData("NextRoundCount") or 0
  if self._param and table.intable(self._param, nSaveRound) then
    return true
  end
  return false
end

_class("TTTrapBombSummon", TriggerBase)
TTTrapBombSummon = TTTrapBombSummon

function TTTrapBombSummon:IsSatisfied(notify)
  local nNotifyType = notify:GetNotifyType()
  if nNotifyType == NotifyType.TrapAction then
    local posAction = notify:GetPosAction()
    local entityOwn = self:GetOwnerEntity()
    local posEntityOwn = entityOwn:GetGridPosition()
    if posEntityOwn ~= posAction then
      return false
    end
    local bHave = self:_IsHaveTrapBomb(posAction)
    Log.debug("[TrapBomb]：判定ID=[", entityOwn:GetID(), "]在位置", GameHelper.MakePosString(posAction), "是否有炸弹", bHave)
    return not bHave
  end
  local entityOwn = self:GetOwnerEntity()
  local posSelf = entityOwn:GridLocation().Position
  local bHave = self:_IsHaveTrapBomb(posSelf)
  return not bHave
end

function TTTrapBombSummon:_IsHaveTrapBomb(pos)
  local utilSvc = self._world:GetService("UtilData")
  local listTrapBomb = utilSvc:FindTrapByTypeAndPos(TrapType.BombByHitBack, pos)
  if not listTrapBomb or table.count(listTrapBomb) <= 0 then
    return false
  end
  return true
end

_class("TTSuperChain", TriggerBase)
TTSuperChain = TTSuperChain

function TTSuperChain:IsSatisfied(notify)
  return self._world:BattleStat():IsRoundSuperChain()
end

_class("TTPossessedGridConverted", TriggerBase)
TTPossessedGridConverted = TTPossessedGridConverted

function TTPossessedGridConverted:IsSatisfied(notify)
  local entity = self:GetOwnerEntity()
  local gridPosition = entity:GetGridPosition()
  local bodyAreaComponent = entity:BodyArea()
  local bodyArea = {}
  if bodyAreaComponent then
    bodyArea = bodyAreaComponent:GetArea()
  else
    table.insert(bodyArea, Vector2.New(0, 0))
  end
  local keepPieceType = self._param[1]
  for _, areaPos in ipairs(bodyArea) do
    local absolutePos = areaPos + gridPosition
    local convertInfo = notify:GetConvertInfoAt(absolutePos)
    if convertInfo then
      local after = convertInfo:GetAfterPieceType()
      if after ~= keepPieceType then
        return true
      end
    end
  end
  return false
end

_class("TTTeamMovePieceTypeMatch", TriggerBase)
TTTeamMovePieceTypeMatch = TTTeamMovePieceTypeMatch

function TTTeamMovePieceTypeMatch:IsSatisfied(notify)
  local entityID = notify:GetEntityID()
  local entity = self._world:GetEntityByID(entityID)
  local teamEntity = entity:Pet():GetOwnerTeamEntity()
  local teamEntityLeader = teamEntity:GetTeamLeaderPetEntity()
  if teamEntityLeader:GetID() ~= entityID then
    return false
  end
  local pieceType = notify:GetPosPieceType()
  return table.icontains(self._param, pieceType)
end

_class("TTPieceTypeMatch", TriggerBase)
TTPieceTypeMatch = TTPieceTypeMatch

function TTPieceTypeMatch:IsSatisfied(notify)
  local entityID = notify:GetEntityID()
  local entity = self:GetOwnerEntity()
  if entity:GetID() ~= entityID then
    return false
  end
  local pieceType = notify:GetPosPieceType()
  return table.icontains(self._param, pieceType)
end

_class("TTPosPieceTypeMatch", TriggerBase)
TTPosPieceTypeMatch = TTPosPieceTypeMatch

function TTPosPieceTypeMatch:IsSatisfied(notify)
  local pieceType = notify:GetPosPieceType()
  return table.icontains(self._param, pieceType)
end

_class("TTPieceEffectTypeMatch", TriggerBase)
TTPieceEffectTypeMatch = TTPieceEffectTypeMatch

function TTPieceEffectTypeMatch:IsSatisfied(notify)
  local pieceEffectType = notify:GetPieceEffectType()
  return self._x == pieceEffectType
end

_class("TTTrapTrigger", TriggerBase)

function TTTrapTrigger:IsSatisfied(notify)
  if not notify._skillID or not notify._trapEntity then
    return false
  end
  local trapID = self._param[1]
  local trapSkillID = self._param[2]
  local cTrap = notify._trapEntity:Trap()
  if not cTrap then
    return false
  end
  return trapID == cTrap:GetTrapID() and trapSkillID == notify._skillID
end

_class("TTTeleportOldPosInOwnerArea", TriggerBase)
TTTeleportOldPosInOwnerArea = TTTeleportOldPosInOwnerArea

function TTTeleportOldPosInOwnerArea:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local owner = self:GetOwnerEntity()
  if not entity or owner:HasDeadMark() then
    return false
  end
  local posOld = notify:GetPosOld()
  local posNew = notify:GetPosNew()
  local owner = self:GetOwnerEntity()
  local center = owner:GridLocation().Position
  local area = owner:BodyArea():GetArea()
  local isChangePos = false
  for _, v in ipairs(area) do
    local workPos = center + v
    if posOld.x == workPos.x and posOld.y == workPos.y then
      isChangePos = true
    end
  end
  for _, v in ipairs(area) do
    local workPos = center + v
    if posNew.x == workPos.x and posNew.y == workPos.y then
      isChangePos = false
    end
  end
  return isChangePos
end

_class("TTTeleportNewPosInOwnerArea", TriggerBase)
TTTeleportNewPosInOwnerArea = TTTeleportNewPosInOwnerArea

function TTTeleportNewPosInOwnerArea:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local owner = self:GetOwnerEntity()
  if not entity or owner:HasDeadMark() then
    return false
  end
  local posOld = notify:GetPosOld()
  local posNew = notify:GetPosNew()
  local owner = self:GetOwnerEntity()
  local center = owner:GridLocation().Position
  local area = owner:BodyArea():GetArea()
  local isChangePos = false
  if posNew.x == center.x and posNew.y == center.y then
    isChangePos = true
  end
  return isChangePos
end

_class("TTTeamOwnerBuff", TriggerBase)
TTTeamOwnerBuff = TTTeamOwnerBuff

function TTTeamOwnerBuff:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local buffCmp
  if owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    buffCmp = teamEntity:BuffComponent()
  else
    return
  end
  if not buffCmp then
    return
  end
  self._satisfied = false
  for i, buffEffect in ipairs(self._param) do
    if buffCmp:HasBuffEffect(buffEffect) then
      self._satisfied = true
      return true
    end
  end
end

_class("TTNotifyTeamLeader", TriggerBase)
TTNotifyTeamLeader = TTNotifyTeamLeader

function TTNotifyTeamLeader:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  if entity:HasPet() then
    local teamEntity = entity:Pet():GetOwnerTeamEntity()
    local teamEntityLeader = teamEntity:GetTeamLeaderPetEntity()
    return teamEntityLeader:GetID() == entity:GetID()
  end
  return false
end

_class("TTTrapSkillMatch", TriggerBase)
TTTrapSkillMatch = TTTrapSkillMatch

function TTTrapSkillMatch:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local trapCmpt = entity:Trap()
  if not trapCmpt then
    return false
  end
  local skillId = notify:GetSkillID()
  local trapID = trapCmpt:GetTrapID()
  if self._x == trapID and self._y == skillId then
    return true
  end
  return false
end

_class("TTFirstDeadPet", TriggerBase)
TTFirstDeadPet = TTFirstDeadPet

function TTFirstDeadPet:IsSatisfied(notify)
  if self._world:BattleStat():GetFirstDeadPetEntity() then
    return true
  end
  return false
end

_class("TTSkillIDMatch", TriggerBase)
TTSkillIDMatch = TTSkillIDMatch

function TTSkillIDMatch:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local skillID = notify:GetSkillID()
  for i, p in ipairs(self._param) do
    if skillID == p then
      return true
    end
  end
  return false
end

_class("TTActiveSkillTag", TriggerBase)
TTActiveSkillTag = TTActiveSkillTag

function TTActiveSkillTag:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local skillID = notify:GetSkillID()
  local configSvc = self._world:GetService("Config")
  local skillCfg = configSvc:GetSkillConfigData(skillID)
  local skillTags = skillCfg:GetSkillTag()
  for i, v in ipairs(self._param) do
    if not table.icontains(skillTags, v) then
      return false
    end
  end
  return true
end

_class("TTAfterPetTeleport", TriggerBase)
TTAfterPetTeleport = TTAfterPetTeleport

function TTAfterPetTeleport:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local owner = self:GetOwnerEntity()
  if not entity or owner:HasDeadMark() then
    return false
  end
  if entity:HasPetPstID() then
    return true
  end
  return false
end

_class("TTHasHPShield", TriggerBase)
TTHasHPShield = TTHasHPShield

function TTHasHPShield:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local owner = self:GetOwnerEntity()
  local testOwner = self._param[1] == 1
  if testOwner then
    entity = owner
  end
  if not entity or owner:HasDeadMark() then
    return false
  end
  local buffCmpt = entity:BuffComponent()
  if buffCmpt == nil then
    return false
  end
  local curHpShieldValue = buffCmpt:GetBuffValue("HPShield") or 0
  if curHpShieldValue <= 0 then
    return false
  end
  return true
end

_class("TTTeamHasHPShield", TriggerBase)
TTTeamHasHPShield = TTTeamHasHPShield

function TTTeamHasHPShield:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local owner = self:GetOwnerEntity()
  if owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    entity = teamEntity
  end
  if not entity or owner:HasDeadMark() then
    return false
  end
  local buffCmpt = entity:BuffComponent()
  if buffCmpt == nil then
    return false
  end
  local curHpShieldValue = buffCmpt:GetBuffValue("HPShield") or 0
  if curHpShieldValue <= 0 then
    return false
  end
  return true
end

_class("TTDamageOnAllMonsters", TriggerBase)
TTDamageOnAllMonsters = TTDamageOnAllMonsters

function TTDamageOnAllMonsters:IsSatisfied(notify)
  local targetMap = notify:GetTargetMap()
  local eOwner = self:GetOwnerEntity()
  local eidOwner = eOwner:GetID()
  local notifyEntity = notify:GetNotifyEntity()
  if type(notifyEntity) == "table" then
    notifyEntity = notifyEntity:GetID()
  end
  if notifyEntity ~= eidOwner then
    return false
  end
  if self._world:MatchType() == MatchType.MT_BlackFist then
    return true
  end
  local aliveMonsters = self._world:GetGroupEntities(self._world.BW_WEMatchers.AliveMonster)
  for _, entity in ipairs(aliveMonsters) do
    local idEntity = entity:GetID()
    if not targetMap[idEntity] then
      return false
    end
  end
  return true
end

_class("TTPlayerDecreaseHp", TriggerBase)
TTPlayerDecreaseHp = TTPlayerDecreaseHp

function TTPlayerDecreaseHp:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local owner = self:GetOwnerEntity()
  if not entity or owner:HasDeadMark() then
    return false
  end
  local changeHp = notify:GetChangeHP()
  if changeHp < 0 then
    return true
  end
  return false
end

_class("TTGameOver", TriggerBase)
TTGameOver = TTGameOver

function TTGameOver:IsSatisfied(notify)
  if self._x == 1 then
    return notify:GetVictory() == self._x
  end
  local defeatType = notify:GetDefeatType()
  return defeatType == self._y
end

_class("TTDefenderInCenterLine", TriggerBase)
TTDefenderInCenterLine = TTDefenderInCenterLine

function TTDefenderInCenterLine:IsSatisfied(notify)
  local casterEntity = notify:GetNotifyEntity()
  local defenderPos = notify:GetTargetPos()
  if not casterEntity:HasPetPstID() or casterEntity:GetID() ~= self:GetOwnerEntity():GetID() then
    return false
  end
  local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  local pickDirection, pickGrid = activeSkillPickUpComponent:GetLastPickDirectionAndPickPos()
  if (pickDirection == HitBackDirectionType.Right or pickDirection == HitBackDirectionType.Left) and defenderPos.y == pickGrid.y then
    return true
  end
  if (pickDirection == HitBackDirectionType.Up or pickDirection == HitBackDirectionType.Down) and defenderPos.x == pickGrid.x then
    return true
  end
  return false
end

_class("TTCheckLayer", TriggerBase)
TTCheckLayer = TTCheckLayer

function TTCheckLayer:IsSatisfied(notify)
  local buffLogicService = self._world:GetService("BuffLogic")
  local layerName = notify:GetLayerName()
  for i, buffEffect in ipairs(self._param) do
    local condName = buffLogicService:GetBuffLayerName(buffEffect)
    if layerName == condName then
      return true
    end
  end
  return false
end

_class("TTDefenderHPLessThan", TriggerBase)
TTDefenderHPLessThan = TTDefenderHPLessThan

function TTDefenderHPLessThan:IsSatisfied(notify)
  local cAttrDefender = notify:GetDefenderEntity():Attributes()
  if not cAttrDefender or not cAttrDefender:GetCurrentHP() then
    return false
  end
  local curhp = cAttrDefender:GetCurrentHP()
  local maxhp = cAttrDefender:CalcMaxHp()
  local pct = curhp / maxhp
  return pct < self._param[1]
end

_class("TTCmpDefenderHPPercent", TriggerBase)
TTCmpDefenderHPPercent = TTCmpDefenderHPPercent

function TTCmpDefenderHPPercent:IsSatisfied(notify)
  if notify:GetDefenderEntity():Trap() then
    return false
  end
  local cAttrDefender = notify:GetDefenderEntity():Attributes()
  if not cAttrDefender or not cAttrDefender:GetCurrentHP() then
    return false
  end
  local curhp = cAttrDefender:GetCurrentHP()
  local maxhp = cAttrDefender:CalcMaxHp()
  local pct = curhp / maxhp
  local cmpType = self._param[1]
  local count = self._param[2]
  return Algorithm.CmpByOperator(pct, count, cmpType)
end

_class("TTCampOrElementMatch", TriggerBase)
TTCampOrElementMatch = TTCampOrElementMatch

function TTCampOrElementMatch:IsSatisfied(notify)
  if self._x == notify:GetElement() or self._y == notify:GetCampID() then
    return true
  else
    return false
  end
end

_class("TTElementMatch", TriggerBase)
TTElementMatch = TTElementMatch

function TTElementMatch:IsSatisfied(notify)
  if self._x == notify:GetElement() then
    return true
  end
  return false
end

_class("TTSlantNormalAttack", TriggerBase)
TTSlantNormalAttack = TTSlantNormalAttack

function TTSlantNormalAttack:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local attackPos = notify:GetAttackPos()
  local targetPos = notify:GetTargetPos()
  if notify:GetAttackerEntity() == owner and math.abs(attackPos.x - targetPos.x) == 1 and math.abs(attackPos.y - targetPos.y) == 1 then
    return true
  end
  return false
end

_class("TTTeamOwnerDebuff", TriggerBase)
TTTeamOwnerDebuff = TTTeamOwnerDebuff

function TTTeamOwnerDebuff:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local buffCmp
  if owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    buffCmp = teamEntity:BuffComponent()
  else
    return
  end
  if not buffCmp then
    return
  end
  self._satisfied = buffCmp:HasDebuff()
  return self._satisfied
end

_class("TTOwnerDebuff", TriggerBase)
TTOwnerDebuff = TTOwnerDebuff

function TTOwnerDebuff:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local buffCmp
  buffCmp = owner:BuffComponent()
  if not buffCmp then
    return
  end
  self._satisfied = buffCmp:HasDebuff()
  return self._satisfied
end

_class("TTDefenderDenuff", TriggerBase)
TTDefenderDenuff = TTDefenderDenuff

function TTDefenderDenuff:IsSatisfied(notify)
  local buffCmp = notify:GetDefenderEntity():BuffComponent()
  if not buffCmp then
    return
  end
  if not buffCmp then
    return
  end
  self._satisfied = buffCmp:HasDebuff()
  return self._satisfied
end

_class("TTCompareChainPath", TriggerBase)
TTCompareChainPath = TTCompareChainPath

function TTCompareChainPath:OnNotify(notify)
end

function TTCompareChainPath:IsSatisfied(notify)
  self._chainCount = notify:GetChainCount()
  local compareFlag = self._x
  local count = self._y
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = self._chainCount == count
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = self._chainCount ~= count
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = count < self._chainCount
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = count <= self._chainCount
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = count > self._chainCount
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = count >= self._chainCount
  end
  return satisfied
end

_class("TTCompareSkillStageIndex", TriggerBase)
TTCompareSkillStageIndex = TTCompareSkillStageIndex

function TTCompareSkillStageIndex:OnNotify(notify)
end

function TTCompareSkillStageIndex:IsSatisfied(notify)
  self._skillStageIndex = notify:GetSkillStageIndex()
  if not self._skillStageIndex then
    return false
  end
  local compareFlag = self._x
  local count = self._y
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = self._skillStageIndex == count
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = self._skillStageIndex ~= count
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = count < self._skillStageIndex
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = count <= self._skillStageIndex
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = count > self._skillStageIndex
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = count >= self._skillStageIndex
  end
  return satisfied
end

local CompMonsterType = {
  All = 1,
  ExceptBoss = 2,
  OnlyBoss = 3
}
_enum("CompMonsterType", CompMonsterType)
_class("TTCompMonsterType", TriggerBase)
TTCompMonsterType = TTCompMonsterType

function TTCompMonsterType:IsSatisfied(notify)
  local compareFlag = self._x
  local notifyEntity = notify:GetNotifyEntity()
  if not notifyEntity:MonsterID() then
    return false
  end
  local isBoss = notifyEntity:HasBoss()
  if compareFlag == CompMonsterType.All then
    return true
  elseif compareFlag == CompMonsterType.ExceptBoss then
    return not isBoss
  elseif compareFlag == CompMonsterType.OnlyBoss then
    return isBoss
  end
  return false
end

_class("TTNotifyMeOrTeam", TriggerBase)
TTNotifyMeOrTeam = TTNotifyMeOrTeam

function TTNotifyMeOrTeam:IsSatisfied(notify)
  local notifyEntity = notify:GetNotifyEntity()
  if not notifyEntity then
    return false
  end
  local ownerEntity = self:GetOwnerEntity()
  if ownerEntity:GetID() == notifyEntity:GetID() then
    return true
  end
  if ownerEntity:HasPet() and notifyEntity:GetID() == ownerEntity:Pet():GetOwnerTeamEntity():GetID() then
    return true
  end
  return false
end

_class("TTNotifyMeOrTeamPet", TriggerBase)
TTNotifyMeOrTeamPet = TTNotifyMeOrTeamPet

function TTNotifyMeOrTeamPet:IsSatisfied(notify)
  local notifyEntity = notify:GetNotifyEntity()
  if not notifyEntity then
    return false
  end
  local ownerEntity = self:GetOwnerEntity()
  if ownerEntity:GetID() == notifyEntity:GetID() then
    return true
  end
  if ownerEntity:HasPet() and notifyEntity:GetID() == ownerEntity:Pet():GetOwnerTeamEntity():GetID() then
    return true
  end
  if ownerEntity:HasPet() and notifyEntity:HasPet() and notifyEntity:Pet():GetOwnerTeamEntity():GetID() == ownerEntity:Pet():GetOwnerTeamEntity():GetID() then
    return true
  end
  return false
end

_class("TTAtkHPPercentGreater", TriggerBase)
TTAtkHPPercentGreater = TTAtkHPPercentGreater

function TTAtkHPPercentGreater:IsSatisfied(notify)
  if not notify.GetAttackerEntity or not notify.GetDefenderEntity then
    return false
  end
  local attacker = notify:GetAttackerEntity()
  local defender = notify:GetDefenderEntity()
  if defender:HasTeam() then
    if not attacker:MonsterID() and not attacker:HasPet() then
      return false
    end
  else
    return false
  end
  local defHP = defender:Attributes():GetCurrentHP()
  local defMaxHP = defender:Attributes():CalcMaxHp()
  local atkHP = attacker:Attributes():GetCurrentHP()
  local atkMaxHP = attacker:Attributes():CalcMaxHp()
  local defPercent = math.modf(defHP / defMaxHP * 1000)
  local atkPercent = math.modf(atkHP / atkMaxHP * 1000)
  if defPercent < atkPercent then
    return true
  else
    return false
  end
end

_class("TTDefHPPercentGreater", TriggerBase)
TTDefHPPercentGreater = TTDefHPPercentGreater

function TTDefHPPercentGreater:IsSatisfied(notify)
  if not notify.GetAttackerEntity or not notify.GetDefenderEntity then
    return false
  end
  local battleService = self._world:GetService("Battle")
  local attacker = notify:GetAttackerEntity()
  local defender = notify:GetDefenderEntity()
  local atkHP = attacker:Attributes():GetCurrentHP()
  local atkMaxHP = attacker:Attributes():CalcMaxHp()
  if attacker:HasPetPstID() then
    if not defender:MonsterID() and not defender:HasTeam() then
      return false
    end
    atkHP, atkMaxHP = battleService:GetCasterHP(attacker)
  else
    return false
  end
  local defHP = defender:Attributes():GetCurrentHP()
  local defMaxHP = defender:Attributes():CalcMaxHp()
  local defPercent = math.modf(defHP / defMaxHP * 1000)
  local atkPercent = math.modf(atkHP / atkMaxHP * 1000)
  if defPercent > atkPercent then
    return true
  else
    return false
  end
end

_class("TTChainSkillCount", TriggerBase)
TTChainSkillCount = TTChainSkillCount

function TTChainSkillCount:IsSatisfied(notify)
  local cnt = notify:GetChainSkillCount()
  return cnt >= self._x
end

_class("TTNotifyMeEffectType", TriggerBase)
TTNotifyMeEffectType = TTNotifyMeEffectType

function TTNotifyMeEffectType:IsSatisfied(notify)
  if notify.GetEffectType and notify:GetEffectType() and self.x then
    return notify:GetEffectType() == self.x and notify:GetNotifyEntity():GetID() == self:GetOwnerEntity():GetID()
  end
  return false
end

_class("TTNotifySkill", TriggerBase)
TTNotifySkill = TTNotifySkill

function TTNotifySkill:IsSatisfied(notify)
  return table.icontains(self._param, notify:GetSkillID())
end

_class("TTNotifyEffectType", TriggerBase)
TTNotifyEffectType = TTNotifyEffectType

function TTNotifyEffectType:IsSatisfied(notify)
  if notify.GetEffectType and notify:GetEffectType() and #self._param > 0 then
    return table.intable(self._param, notify:GetEffectType())
  end
  return false
end

_class("TTLayerBiggerThan", TriggerBase)
TTLayerBiggerThan = TTLayerBiggerThan

function TTLayerBiggerThan:IsSatisfied(notify)
  local svc = self._world:GetService("BuffLogic")
  local layerName = svc:GetBuffLayerName(self._x)
  local layerCount = svc:GetBuffLayer(self:GetOwnerEntity(), self._x)
  if layerCount and layerCount >= self._y then
    return true
  end
  return false
end

_class("TTNotifyDefenderIsMe", TriggerBase)
TTNotifyDefenderIsMe = TTNotifyDefenderIsMe

function TTNotifyDefenderIsMe:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if owner:HasPet() then
    owner = owner:Pet():GetOwnerTeamEntity()
  end
  local entity = notify:GetDefenderEntity()
  return owner:GetID() == entity:GetID()
end

function Algorithm.CmpByOperator(value, target, operator)
  if type(value) ~= "number" or type(target) ~= "number" then
    return false
  end
  if operator == ComparisonOperator.EQ then
    return value == target
  elseif operator == ComparisonOperator.NE then
    return value ~= target
  elseif operator == ComparisonOperator.GT then
    return target < value
  elseif operator == ComparisonOperator.GE then
    return target <= value
  elseif operator == ComparisonOperator.LT then
    return value < target
  elseif operator == ComparisonOperator.LE then
    return value <= target
  end
  return false
end

_class("TTDefenderCount", TriggerBase)
TTDefenderCount = TTDefenderCount

function TTDefenderCount:IsSatisfied(notify)
  local targetCount = notify:GetTargetCount()
  local cmpType = self._param[1]
  local count = self._param[2]
  return Algorithm.CmpByOperator(targetCount, count, cmpType)
end

_class("TTCmpDeferHPAndAtkerAtk", TriggerBase)
TTCmpDeferHPAndAtkerAtk = TTCmpDeferHPAndAtkerAtk

function TTCmpDeferHPAndAtkerAtk:IsSatisfied(notify)
  if not notify.GetDefenderEntity or not notify.GetAttackerEntity then
    return false
  end
  local defender = notify:GetDefenderEntity()
  local attacker = notify:GetAttackerEntity()
  local defenderHP = defender:Attributes():GetCurrentHP()
  if not defenderHP then
    return false
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  local attackerAtkNum = buffLogicService:GetAttributeValue(attacker, "Attack")
  local cmpType = self._param[1]
  local count = self._param[2] * attackerAtkNum
  return Algorithm.CmpByOperator(defenderHP, count, cmpType)
end

_class("TTIsDefenderPlayer", TriggerBase)
TTIsDefenderPlayer = TTIsDefenderPlayer

function TTIsDefenderPlayer:IsSatisfied(notify)
  if not NotifyAttackBase:IsInstanceOfType(notify) then
    return false
  end
  local def = notify:GetDefenderEntity()
  local eDef
  if type(def) == "number" then
    eDef = self._world:GetEntityByID(def)
  elseif Entity:IsInstanceOfType(def) then
    eDef = def
  end
  if not eDef then
    return false
  end
  return eDef:HasTeam() or eDef:HasPetPstID()
end

_class("TTTrapExist", TriggerBase)
TTTrapExist = TTTrapExist

function TTTrapExist:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local world = owner:GetOwnerWorld()
  local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() then
      local trapID = e:Trap():GetTrapID()
      if table.intable(self._param, trapID) then
        return true
      end
    end
  end
  return false
end

_class("TTMonsterAliveCount", TriggerBase)
TTMonsterAliveCount = TTMonsterAliveCount

function TTMonsterAliveCount:IsSatisfied(notify)
  local battleService = self._world:GetService("Battle")
  local monsterAliveCount = battleService:GetAliveMonsterCount()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    monsterAliveCount = 1
  end
  return Algorithm.CmpByOperator(monsterAliveCount, self._y, self._x)
end

_class("TTPlayerHPRecovered", TriggerBase)
TTPlayerHPRecovered = TTPlayerHPRecovered

function TTPlayerHPRecovered:IsSatisfied(notify)
  return notify:GetChangeHP() > 0
end

_class("TTIsAttachMonsterDead", TriggerBase)
TTIsAttachMonsterDead = TTIsAttachMonsterDead

function TTIsAttachMonsterDead:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.MonsterDead then
    return false
  end
  local deadMonsterEntity = notify:GetNotifyEntity()
  local owner = self:GetOwnerEntity()
  if not owner:AI() then
    return false
  end
  local attachMonsterID = owner:AI():GetRuntimeData("AttachMonsterID")
  return deadMonsterEntity:GetID() == attachMonsterID
end

_class("TTChainPathTypeElement", TriggerBase)
TTChainPathTypeElement = TTChainPathTypeElement

function TTChainPathTypeElement:IsSatisfied(notify)
  if not notify.GetChainPathType then
    return false
  end
  local chainPathType = notify:GetChainPathType()
  return table.icontains(self._param, chainPathType)
end

_class("TTBuffEffectMatch", TriggerBase)
TTBuffEffectMatch = TTBuffEffectMatch

function TTBuffEffectMatch:IsSatisfied(notify)
  local effctType = notify:GetBuffEffectType()
  return table.icontains(self._param, effctType)
end

_class("TTRemoveDuplicateDefender", TriggerBase)
TTRemoveDuplicateDefender = TTRemoveDuplicateDefender

function TTRemoveDuplicateDefender:Constructor()
  self._defenderIds = {}
end

function TTRemoveDuplicateDefender:IsSatisfied(notify)
  local es = notify:GetTargetEntityList()
  local e = es[1]
  if e and not table.icontains(self._defenderIds, e:GetID()) then
    self._defenderIds[#self._defenderIds + 1] = e:GetID()
    return true
  end
  return false
end

_class("TTNotifyEntityIsPetOrTrap", TriggerBase)
TTNotifyEntityIsPetOrTrap = TTNotifyEntityIsPetOrTrap

function TTNotifyEntityIsPetOrTrap:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  if entity:HasPetPstID() then
    return true
  end
  local trapCmpt = entity:Trap()
  if trapCmpt then
    return true
  end
  return false
end

_class("TTNotifyNotMe", TriggerBase)
TTNotifyNotMe = TTNotifyNotMe

function TTNotifyNotMe:IsSatisfied(notify)
  local notifyEntity = notify:GetNotifyEntity()
  if not notifyEntity or notifyEntity:MonsterID() then
    return false
  end
  local ownerEntity = self:GetOwnerEntity()
  return ownerEntity:GetID() ~= notifyEntity:GetID()
end

_class("TTStickerNeedToDie", TriggerBase)
TTStickerNeedToDie = TTStickerNeedToDie

function TTStickerNeedToDie:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  local pos = ownerEntity:GetGridPosition()
  local boardCmpt = self._world:GetBoardEntity():Board()
  local es = boardCmpt:GetPieceEntities(pos, function(e)
    return e:HasTeam()
  end)
  if 0 < #es then
    return false
  end
  local triggerCnt = ownerEntity:Trap():GetCurrentTriggerCount()
  return 0 < triggerCnt
end

_class("TTPosInSpTrap", TriggerBase)
TTPosInSpTrap = TTPosInSpTrap

function TTPosInSpTrap:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  local pos
  if notify:GetNotifyType() == NotifyType.Teleport then
    pos = notify:GetPosNew()
    local casterEntity = notify:GetNotifyEntity()
    if casterEntity:GetID() ~= ownerEntity:GetID() then
      return false
    end
  end
  if notify:GetNotifyType() == NotifyType.HitBackEnd then
    pos = notify:GetPosEnd()
    local defenderID = notify:GetDefenderId()
    if defenderID ~= ownerEntity:GetID() then
      return false
    end
  end
  if notify:GetNotifyType() == NotifyType.TractionEnd then
    pos = notify:GetPosEnd()
    local defenderID = notify:GetDefenderId()
    if defenderID ~= ownerEntity:GetID() then
      return false
    end
  end
  if not pos then
    return false
  end
  local trapLogic = self._world:GetService("TrapLogic")
  local trapIDList = trapLogic:FindTrapIDByPos(pos)
  return table.intable(trapIDList, self._x)
end

_class("TTPosNoInSpTrap", TriggerBase)
TTPosNoInSpTrap = TTPosNoInSpTrap

function TTPosNoInSpTrap:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  local pos
  if notify:GetNotifyType() == NotifyType.Teleport then
    pos = notify:GetPosNew()
    local casterEntity = notify:GetNotifyEntity()
    if casterEntity:GetID() ~= ownerEntity:GetID() then
      return false
    end
  end
  if notify:GetNotifyType() == NotifyType.HitBackEnd then
    pos = notify:GetPosEnd()
    local defenderID = notify:GetDefenderId()
    if defenderID ~= ownerEntity:GetID() then
      return false
    end
  end
  if notify:GetNotifyType() == NotifyType.TractionEnd then
    pos = notify:GetPosEnd()
    local defenderID = notify:GetDefenderId()
    if defenderID ~= ownerEntity:GetID() then
      return false
    end
  end
  if not pos then
    return false
  end
  local trapLogic = self._world:GetService("TrapLogic")
  local trapIDList = trapLogic:FindTrapIDByPos(pos)
  return not table.intable(trapIDList, self._x)
end

_class("TTWaveNumMatch", TriggerBase)
TTWaveNumMatch = TTWaveNumMatch

function TTWaveNumMatch:IsSatisfied(notify)
  local waveNum = notify:GetWaveNum()
  if waveNum and table.intable(self._param, waveNum) then
    return true
  end
  return false
end

_class("TTAtkTargetPosMarkedByAttacker", TriggerBase)
TTAtkTargetPosMarkedByAttacker = TTAtkTargetPosMarkedByAttacker

function TTAtkTargetPosMarkedByAttacker:Constructor(_owner, _triggerCond, series)
  self._series = series or 1
end

function TTAtkTargetPosMarkedByAttacker:IsSatisfied(notify)
  local eAttacker = notify:GetAttackerEntity()
  if not eAttacker:HasMarkGridComponent() then
    return false
  end
  local cMarkGrid = eAttacker:MarkGridComponent()
  return cMarkGrid:IsPosMarked(self._series, Vector2.Pos2Index(notify:GetTargetPos()))
end

_class("TTSimpleHPMoreThan", TriggerBase)
TTSimpleHPMoreThan = TTSimpleHPMoreThan

function TTSimpleHPMoreThan:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  local entity = notify:GetNotifyEntity()
  local curhp = owner:Attributes():GetCurrentHP()
  local maxhp = owner:Attributes():CalcMaxHp()
  if owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    local cAttr = teamEntity:Attributes()
    curhp = cAttr:GetCurrentHP()
    maxhp = cAttr:CalcMaxHp()
  end
  local blood = curhp / maxhp
  return blood > self._x
end

_class("TTResetGridFlushTrapPosNoInMy", TriggerBase)
TTResetGridFlushTrapPosNoInMy = TTResetGridFlushTrapPosNoInMy

function TTResetGridFlushTrapPosNoInMy:IsSatisfied(notify)
  local trapList
  if notify:GetNotifyType() == NotifyType.ResetGridFlushTrap then
    trapList = notify:GetFlushTrapList()
  end
  if not trapList then
    return false
  end
  local ownerEntity = self:GetOwnerEntity()
  local ownerPos = ownerEntity:GetGridPosition()
  local areaCmpt = ownerEntity:BodyArea()
  local areaList = areaCmpt:GetArea()
  local onwerPosList = {}
  for i, area in ipairs(areaList) do
    table.insert(onwerPosList, Vector2(ownerPos.x + area.x, ownerPos.y + area.y))
  end
  for _, entity in ipairs(trapList) do
    local pos = entity:GetGridPosition()
    local trapComponent = entity:Trap()
    if trapComponent and trapComponent:GetTrapID() and table.Vector2Include(onwerPosList, pos) and trapComponent:GetTrapID() == self._x then
      return true
    end
  end
  return false
end

_class("TTSkillScopeCompareTargetCount", TriggerBase)
TTSkillScopeCompareTargetCount = TTSkillScopeCompareTargetCount

function TTSkillScopeCompareTargetCount:OnNotify(notify)
end

function TTSkillScopeCompareTargetCount:IsSatisfied(notify)
  local skillID = self._param[1]
  local compareFlag = self._param[2]
  local count = self._param[3]
  local ownerEntity = self:GetOwnerEntity()
  local ownerPos = ownerEntity:GetGridPosition()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, ownerPos, ownerEntity)
  local targetEntityIDArray = targetSelector:DoSelectSkillTarget(ownerEntity, skillTargetType, scopeResult, skillID)
  local entityIDArray = {}
  for i = 1, #targetEntityIDArray do
    if not table.icontains(entityIDArray, targetEntityIDArray[i]) then
      table.insert(entityIDArray, targetEntityIDArray[i])
    end
  end
  local targetEntityCount = 0
  for _, targetID in ipairs(entityIDArray) do
    local targetEntity = self._world:GetEntityByID(targetID)
    if targetEntity and not targetEntity:HasDeadMark() then
      targetEntityCount = targetEntityCount + 1
    end
  end
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = targetEntityCount == count
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = targetEntityCount ~= count
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = count < targetEntityCount
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = count <= targetEntityCount
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = count > targetEntityCount
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = count >= targetEntityCount
  end
  return satisfied
end

_class("TTSkillTargetCountCompareMaxCount", TriggerBase)
TTSkillTargetCountCompareMaxCount = TTSkillTargetCountCompareMaxCount

function TTSkillTargetCountCompareMaxCount:OnNotify(notify)
end

function TTSkillTargetCountCompareMaxCount:IsSatisfied(notify)
  local skillID, targetEntityCount
  if notify.GetSkillID then
    skillID = notify:GetSkillID()
  end
  if notify.GetDefenderPosList then
    local entityIDArray = {}
    for i = 1, #notify:GetDefenderPosList() do
      if not table.icontains(entityIDArray, notify:GetDefenderPosList()[i]) then
        table.insert(entityIDArray, notify:GetDefenderPosList()[i])
      end
    end
    targetEntityCount = table.count(entityIDArray)
  end
  if not skillID or not targetEntityCount then
    return false
  end
  local compareFlag = self._param[1]
  local effectIndex = self._param[2]
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local scopeParam = skillConfigData:GetSkillScopeParam()
  if effectIndex then
    local svcCfgDeco = self._world:GetService("ConfigDecoration")
    local skillEffectArray = svcCfgDeco:GetLatestEffectParamArray(notify:GetNotifyEntity():GetID(), skillID)
    local skillEffectParam = skillEffectArray[effectIndex]
    scopeParam = skillEffectParam:GetSkillEffectScopeParam()
  end
  local skillMaxCount = 0
  if type(scopeParam) == "table" then
    skillMaxCount = scopeParam[1]
  else
    skillMaxCount = scopeParam
  end
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = targetEntityCount == skillMaxCount
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = targetEntityCount ~= skillMaxCount
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = targetEntityCount > skillMaxCount
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = targetEntityCount >= skillMaxCount
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = targetEntityCount < skillMaxCount
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = targetEntityCount <= skillMaxCount
  end
  return satisfied
end

_class("TTTargetAroundBodyAreaCompareMonsterCount", TriggerBase)
TTTargetAroundBodyAreaCompareMonsterCount = TTTargetAroundBodyAreaCompareMonsterCount

function TTTargetAroundBodyAreaCompareMonsterCount:IsSatisfied(notify)
  local ringCount = self._param[1]
  local compareFlag = self._param[2]
  local count = self._param[3]
  local targetEntity
  if notify.GetDefenderEntity then
    targetEntity = notify:GetDefenderEntity()
  end
  targetEntity = targetEntity or self:GetOwnerEntity()
  local v2SelfGridPos = targetEntity:GetGridPosition()
  local bodyArea = targetEntity:BodyArea():GetArea()
  local v2SelfDir = targetEntity:GetGridDirection()
  local scopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(scopeSvc)
  local scopeResult = scopeCalc:ComputeScopeRange(SkillScopeType.AroundBodyArea, {0, ringCount}, v2SelfGridPos, bodyArea, v2SelfDir, SkillTargetType.Monster, v2SelfGridPos)
  local posList = scopeResult:GetAttackRange()
  local monsterEntityList = {}
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadMark() and e:GetID() ~= targetEntity:GetID() then
      local bodyAreaCmpt = e:BodyArea()
      local bodyArea = bodyAreaCmpt:GetArea()
      local myPos = e:GetGridPosition()
      for i, v in ipairs(bodyArea) do
        local pos = myPos + v
        if table.intable(posList, pos) then
          table.insert(monsterEntityList, e)
          break
        end
      end
    end
  end
  local targetEntityCount = table.count(monsterEntityList)
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = targetEntityCount == count
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = targetEntityCount ~= count
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = count < targetEntityCount
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = count <= targetEntityCount
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = count > targetEntityCount
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = count >= targetEntityCount
  end
  return satisfied
end

_class("TTTeamInActiveSkillScope", TriggerBase)
TTTeamInActiveSkillScope = TTTeamInActiveSkillScope

function TTTeamInActiveSkillScope:IsSatisfied(notify)
  local calcScopeWithPickUpPosIndex = self._param[1]
  local casterEntity = self:GetOwnerEntity()
  local centerPos = casterEntity:GetGridPosition()
  local pickupComponent = casterEntity:ActiveSkillPickUpComponent()
  if calcScopeWithPickUpPosIndex and pickupComponent then
    local pickUpGridArray = pickupComponent:GetAllValidPickUpGridPos()
    centerPos = pickUpGridArray[calcScopeWithPickUpPosIndex]
    centerPos = centerPos or pickupComponent:GetLastPickUpGridPos()
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local activeSkillCmpt = teamEntity:ActiveSkill()
  local activeSkillID = activeSkillCmpt:GetActiveSkillID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, centerPos, casterEntity)
  local skillRangeGridList = scopeResult:GetAttackRange()
  if table.icontains(skillRangeGridList, teamPos) then
    return true
  end
  return false
end

_class("TTNTTrapPosInMy", TriggerBase)
TTNTTrapPosInMy = TTNTTrapPosInMy

function TTNTTrapPosInMy:IsSatisfied(notify)
  local entity
  if notify:GetNotifyType() == NotifyType.TrapDead or notify:GetNotifyType() == NotifyType.TrapShow then
    entity = notify:GetNotifyEntity()
  end
  if not entity then
    return false
  end
  local ownerEntity = self:GetOwnerEntity()
  local ownerPos = ownerEntity:GetGridPosition()
  local areaCmpt = ownerEntity:BodyArea()
  local areaList = areaCmpt:GetArea()
  local onwerPosList = {}
  for i, area in ipairs(areaList) do
    table.insert(onwerPosList, Vector2(ownerPos.x + area.x, ownerPos.y + area.y))
  end
  local pos = entity:GetGridPosition()
  local trapComponent = entity:Trap()
  if trapComponent and trapComponent:GetTrapID() and table.Vector2Include(onwerPosList, pos) and trapComponent:GetTrapID() == self._x then
    return true
  end
  return false
end

_class("TTDefenderHasMostBuffLayer", TriggerBase)
TTDefenderHasMostBuffLayer = TTDefenderHasMostBuffLayer

function TTDefenderHasMostBuffLayer:IsSatisfied(notify)
  local defenderEntity = notify:GetDefenderEntity()
  if not defenderEntity then
    return false
  end
  local buffCmp = defenderEntity:BuffComponent()
  if not buffCmp then
    return false
  end
  self._satisfied = false
  local buffEffectType = self._x
  local svc = self._world:GetService("BuffLogic")
  local monsterEntityList = {}
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadMark() then
      table.insert(monsterEntityList, e)
    end
  end
  if defenderEntity:HasTeam() then
    table.insert(monsterEntityList, defenderEntity)
  end
  if table.count(monsterEntityList) == 0 then
    return false
  end
  local hasMostBuffLayerMonsterEntityList = {}
  local mostBuffLayer = 0
  for _, e in ipairs(monsterEntityList) do
    local curMarkLayer = svc:GetBuffLayer(e, buffEffectType)
    if mostBuffLayer < curMarkLayer then
      table.clear(hasMostBuffLayerMonsterEntityList)
      table.insert(hasMostBuffLayerMonsterEntityList, e)
      mostBuffLayer = curMarkLayer
    elseif curMarkLayer == mostBuffLayer and curMarkLayer ~= 0 then
      table.insert(hasMostBuffLayerMonsterEntityList, e)
    end
  end
  if table.count(hasMostBuffLayerMonsterEntityList) == 0 then
    return false
  end
  local hasMostBuffLayerMonsterEntity
  if table.count(hasMostBuffLayerMonsterEntityList) > 0 then
    local mostHp = 0
    for _, e in ipairs(hasMostBuffLayerMonsterEntityList) do
      local curhp = e:Attributes():GetCurrentHP()
      if mostHp < curhp then
        curhp = mostHp
        hasMostBuffLayerMonsterEntity = e
      end
    end
  end
  if not hasMostBuffLayerMonsterEntity then
    return false
  end
  self._satisfied = hasMostBuffLayerMonsterEntity:GetID() == defenderEntity:GetID()
  return self._satisfied
end

_class("TTCurseTowerIsActive", TriggerBase)
TTCurseTowerIsActive = TTCurseTowerIsActive

function TTCurseTowerIsActive:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  local curseTowerCmpt = ownerEntity:CurseTower()
  if not curseTowerCmpt then
    return false
  end
  local towerState = curseTowerCmpt:GetTowerState()
  if towerState == CurseTowerState.Deactive then
    return false
  end
  return true
end

_class("TTOwnerGridPosChange", TriggerBase)
TTOwnerGridPosChange = TTOwnerGridPosChange

function TTOwnerGridPosChange:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  local pos
  if notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
    pos = notify:GetWalkPos()
    local notifyEntity = notify:GetNotifyEntity()
    if notifyEntity:GetID() == ownerEntity:GetID() then
      return true
    end
  end
  if notify:GetNotifyType() == NotifyType.Teleport then
    pos = notify:GetPosNew()
    local notifyEntity = notify:GetNotifyEntity()
    if notifyEntity:GetID() == ownerEntity:GetID() then
      return true
    end
  end
  if notify:GetNotifyType() == NotifyType.HitBackEnd then
    pos = notify:GetPosEnd()
    local defenderID = notify:GetDefenderId()
    if defenderID == ownerEntity:GetID() then
      return true
    end
  end
  if notify:GetNotifyType() == NotifyType.TractionEnd then
    pos = notify:GetPosEnd()
    local defenderID = notify:GetDefenderId()
    if defenderID == ownerEntity:GetID() then
      return true
    end
  end
  if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    local pet = notify:GetNotifyEntity()
    local team = pet:Pet():GetOwnerTeamEntity()
    if team:GetID() == ownerEntity:GetID() then
      return true
    end
  end
  if notify:GetNotifyType() == NotifyType.ForceMovement then
    pos = notify:GetPosNew()
    local notifyEntity = notify:GetNotifyEntity()
    if notifyEntity:GetID() == ownerEntity:GetID() then
      return true
    end
  end
  if notify:GetNotifyType() == NotifyType.TransportEachMoveEnd then
    pos = notify:GetPosNew()
    local notifyEntity = notify:GetNotifyEntity()
    if notifyEntity:GetID() == ownerEntity:GetID() then
      return true
    end
  end
  return false
end

_class("TTConvertSourceEffectType", TriggerBase)
TTConvertSourceEffectType = TTConvertSourceEffectType

function TTConvertSourceEffectType:IsSatisfied(notify)
  if type(notify.GetConvertEffectType) ~= "function" then
    Log.error(self._className, "通知与判定不兼容。")
    return false
  end
  local source = notify:GetConvertEffectType()
  if not source then
    return false
  end
  return table.icontains(self._param, source)
end

_class("TTNotifyEntityIsOwnerSummonerEntity", TriggerBase)
TTNotifyEntityIsOwnerSummonerEntity = TTNotifyEntityIsOwnerSummonerEntity

function TTNotifyEntityIsOwnerSummonerEntity:IsSatisfied(notify)
  if not notify.GetNotifyEntity then
    return false
  end
  local entity = notify:GetNotifyEntity()
  local owner = self:GetOwnerEntity()
  local ownerSummonerEntity = owner:GetSummonerEntity()
  if not ownerSummonerEntity then
    return false
  end
  local satisfied = entity:GetID() == ownerSummonerEntity:GetID()
  return satisfied
end

_class("TTTrapTriggerIsMyTeam", TriggerBase)
TTTrapTriggerIsMyTeam = TTTrapTriggerIsMyTeam

function TTTrapTriggerIsMyTeam:IsSatisfied(notify)
  if not notify.GetTriggerEntity then
    return false
  end
  local triggerEnitity = notify:GetTriggerEntity()
  if not triggerEnitity then
    return true
  end
  if triggerEnitity:HasPet() then
    triggerEnitity = triggerEnitity:Pet():GetOwnerTeamEntity()
  end
  local ownerEntity = self:GetOwnerEntity()
  if ownerEntity:HasPet() then
    ownerEntity = ownerEntity:Pet():GetOwnerTeamEntity()
  end
  return triggerEnitity == ownerEntity
end

_class("TTNotifyFriendPetOrTeam", TriggerBase)
TTNotifyFriendPetOrTeam = TTNotifyFriendPetOrTeam

function TTNotifyFriendPetOrTeam:IsSatisfied(notify)
  local notifyEntity = notify:GetNotifyEntity()
  if notifyEntity:HasPet() then
    notifyEntity = notifyEntity:Pet():GetOwnerTeamEntity()
  end
  local ownerEntity = self:GetOwnerEntity()
  if ownerEntity:HasPet() then
    ownerEntity = ownerEntity:Pet():GetOwnerTeamEntity()
  end
  return notifyEntity:GetID() == ownerEntity:GetID()
end

_class("TTDonotCheckGameTurn", TriggerBase)
TTDonotCheckGameTurn = TTDonotCheckGameTurn

function TTDonotCheckGameTurn:IsSatisfied(notify)
  return true
end

_class("TTCasterIsLegendPet", TriggerBase)
TTCasterIsLegendPet = TTCasterIsLegendPet

function TTCasterIsLegendPet:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.ActiveSkillAttackStart and notify:GetNotifyType() ~= NotifyType.ActiveSkillAttackEnd then
    return false
  end
  local casterEntity = notify:GetAttackerEntity()
  if casterEntity:HasPetPstID() and casterEntity:PetPstID():IsLegendPet() then
    return true
  end
  return false
end

_class("TTIsAuroraTime", TriggerBase)
TTIsAuroraTime = TTIsAuroraTime

function TTIsAuroraTime:IsSatisfied(notify)
  local battleStatCmpt = self._world:BattleStat()
  return battleStatCmpt:IsRoundAuroraTime()
end

_class("TTAttackerIsMeOrAttackerSuperIsMe", TriggerBase)
TTAttackerIsMeOrAttackerSuperIsMe = TTAttackerIsMeOrAttackerSuperIsMe

function TTAttackerIsMeOrAttackerSuperIsMe:IsSatisfied(notify)
  local attackEntity = notify:GetAttackerEntity()
  local ownerEntity = self:GetOwnerEntity()
  if attackEntity:GetID() == ownerEntity:GetID() then
    return true
  end
  if attackEntity:HasSuperEntity() and attackEntity:GetSuperEntity():GetID() == ownerEntity:GetID() then
    return true
  end
  return false
end

_class("TTTeamLeaderMoveEndPosInRingRange", TriggerBase)
TTTeamLeaderMoveEndPosInRingRange = TTTeamLeaderMoveEndPosInRingRange

function TTTeamLeaderMoveEndPosInRingRange:IsSatisfied(notify)
  local world = notify:GetNotifyEntity():GetOwnerWorld()
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeCalc = utilScopeSvc:GetSkillScopeCalc()
  local scopeParamParser = SkillScopeParamParser:New()
  local param = scopeParamParser:ParseScopeParam(SkillScopeType.SquareRing, self._param)
  local bodyArea = self:GetOwnerEntity():BodyArea():GetArea()
  local scopeResult = scopeCalc:ComputeScopeRange(SkillScopeType.SquareRing, param, self:GetOwnerEntity():GetGridPosition(), bodyArea, self:GetOwnerEntity():GetGridDirection(), SkillTargetType.Pet, self:GetOwnerEntity():GetGridPosition(), self:GetOwnerEntity())
  if not scopeResult:GetAttackRange() then
    return false
  end
  return table.icontains(scopeResult:GetAttackRange(), notify:GetPos())
end

_class("TTNotifyEntityIsSpecificPet", TriggerBase)
TTNotifyEntityIsSpecificPet = TTNotifyEntityIsSpecificPet

function TTNotifyEntityIsSpecificPet:IsSatisfied(notify)
  if not notify.GetNotifyEntity then
    return false
  end
  local notifyEntity = notify:GetNotifyEntity()
  if notifyEntity:HasPetPstID() and table.icontains(self._param, notifyEntity:PetPstID():GetTemplateID()) then
    return true
  end
  return false
end

_class("TTNotifyTrapLevelMatch", TriggerBase)
TTNotifyTrapLevelMatch = TTNotifyTrapLevelMatch

function TTNotifyTrapLevelMatch:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local trapCmpt = entity:Trap()
  if not trapCmpt then
    return false
  end
  local trapLevel = trapCmpt:GetTrapLevel()
  if table.icontains(self._param, trapLevel) then
    return true
  end
  return false
end

_class("TTNotifyTrapIDMatch", TriggerBase)
TTNotifyTrapIDMatch = TTNotifyTrapIDMatch

function TTNotifyTrapIDMatch:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  local trapCmpt = entity:Trap()
  if not trapCmpt then
    return false
  end
  local trapID = trapCmpt:GetTrapID()
  if table.icontains(self._param, trapID) then
    return true
  end
  return false
end

_class("TTNotifyEntityInOwnerBodyArea", TriggerBase)
TTNotifyEntityInOwnerBodyArea = TTNotifyEntityInOwnerBodyArea

function TTNotifyEntityInOwnerBodyArea:IsSatisfied(notify)
  local entity = notify:GetNotifyEntity()
  if not entity then
    return false
  end
  local ownerEntity = self:GetOwnerEntity()
  local ownerPos = ownerEntity:GetGridPosition()
  local areaCmpt = ownerEntity:BodyArea()
  local areaList = areaCmpt:GetArea()
  local onwerPosList = {}
  for i, area in ipairs(areaList) do
    table.insert(onwerPosList, Vector2(ownerPos.x + area.x, ownerPos.y + area.y))
  end
  local pos = entity:GetGridPosition()
  local trapComponent = entity:Trap()
  if trapComponent and trapComponent:GetTrapID() and table.Vector2Include(onwerPosList, pos) then
    return true
  end
  return false
end

_class("TTLayerCountDivisible", TriggerBase)
TTLayerCountDivisible = TTLayerCountDivisible

function TTLayerCountDivisible:IsSatisfied(notify)
  local buffId = self._param[1]
  local e = self:GetOwnerEntity()
  local cBuff = e:BuffComponent()
  local layerCount = 0
  local instance = cBuff:GetBuffById(buffId)
  if instance then
    local layerName = instance:GetBuffLayerName()
    layerCount = cBuff:GetBuffValue(layerName) or 0
  end
  if layerCount == 0 then
    return false
  end
  local totalParam = #self._param
  local bDivesible = false
  for i = 2, totalParam do
    local divNum = self._param[i]
    if divNum == 0 then
    else
      local a, b = math.modf(layerCount / divNum)
      if b == 0 then
        bDivesible = true
        break
      end
    end
  end
  return bDivesible
end

_class("TTChainSkillStage", TriggerBase)
TTChainSkillStage = TTChainSkillStage

function TTChainSkillStage:IsSatisfied(notify)
  local chainStage = self._param[1]
  if notify.GetChainSkillStage then
    local curStage = notify:GetChainSkillStage()
    if curStage and chainStage and curStage == chainStage then
      return true
    end
  end
  return false
end

_class("TTTeamInSideSkillScope", TriggerBase)
TTTeamInSideSkillScope = TTTeamInSideSkillScope

function TTTeamInSideSkillScope:IsSatisfied(notify)
  local skillID = self._param[1]
  local inSide = self._param[2] or 1
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local posTeam = teamEntity:GridLocation().Position
  local curMovePos = posTeam
  if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveStart or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    curMovePos = notify:GetPos()
  elseif notify:GetNotifyType() == NotifyType.Teleport then
    curMovePos = notify:GetPosNew()
  elseif notify:GetNotifyType() == NotifyType.HitBackEnd and notify:GetDefenderId() == teamEntity:GetID() then
    curMovePos = notify:GetPosEnd()
  elseif notify:GetNotifyType() == NotifyType.EntityMoveEnd then
    curMovePos = notify:GetPosNew()
  end
  local ownerEntity = self:GetOwnerEntity()
  local bodyArea = ownerEntity:BodyArea():GetArea()
  local posSelf = ownerEntity:GridLocation().Position
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local skillResult = skillCalculater:CalcSkillScope(skillConfigData, posSelf, Vector2(0, 1), bodyArea)
  local match = table.icontains(skillResult:GetAttackRange(), curMovePos)
  if inSide == 1 then
    return match
  elseif inSide == 0 then
    return not match
  end
  return false
end

_class("TTMonsterInAuraRange", TriggerBase)
TTMonsterInAuraRange = TTMonsterInAuraRange

function TTMonsterInAuraRange:IsSatisfied(notify)
  local auraGroupID = self._param[1]
  local inSide = self._param[2] or 1
  local inBoss = self._param[3] or 0
  local entity = notify:GetNotifyEntity()
  local curMovePos = entity:GridLocation().Position
  local bodyArea = entity:BodyArea():GetArea()
  if notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
    curMovePos = notify:GetWalkPos()
  elseif notify:GetNotifyType() == NotifyType.Teleport then
    curMovePos = notify:GetPosNew()
  elseif notify:GetNotifyType() == NotifyType.HitBackEnd then
    entity = self._world:GetEntityByID(notify:GetDefenderId())
    curMovePos = notify:GetPosEnd()
    bodyArea = entity:BodyArea():GetArea()
  elseif notify:GetNotifyType() == NotifyType.EntityMoveEnd then
    curMovePos = notify:GetPosNew()
  elseif notify:GetNotifyType() == NotifyType.PlayerTurnStart then
    entity = self:GetOwnerEntity()
    curMovePos = entity:GridLocation().Position
    bodyArea = entity:BodyArea():GetArea()
  end
  if not entity:HasMonsterID() then
    return false
  end
  if inBoss == 0 and entity:HasBoss() then
    return false
  end
  if inBoss == 1 and not entity:HasBoss() then
    return false
  end
  local battleSvc = self._world:GetService("Battle")
  local match = false
  for _, value in pairs(bodyArea) do
    local workPos = curMovePos + value
    if battleSvc:IsPosInAuraRange(auraGroupID, workPos) then
      match = true
      break
    end
  end
  if inSide == 1 then
    return match
  elseif inSide == 0 then
    return not match
  end
  return false
end

_class("TTMoveEntityIsTeamOrPet", TriggerBase)
TTMoveEntityIsTeamOrPet = TTMoveEntityIsTeamOrPet

function TTMoveEntityIsTeamOrPet:IsSatisfied(notify)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if notify:GetNotifyType() == NotifyType.HitBackEnd then
    return notify:GetDefenderId() == teamEntity:GetID()
  elseif notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    return true
  elseif notify:GetNotifyType() == NotifyType.Teleport then
    local entity = notify:GetNotifyEntity()
    return entity:HasTeam() or entity:HasPetPstID()
  elseif notify:GetNotifyType() == NotifyType.TransportEachMoveEnd then
    local entity = notify:GetNotifyEntity()
    return entity:HasTeam() or entity:HasPetPstID()
  elseif notify:GetNotifyType() == NotifyType.ForceMovement then
    local entity = notify:GetNotifyEntity()
    return entity:HasTeam() or entity:HasPetPstID()
  end
  return false
end

_class("TTDefenderListHasBuff", TriggerBase)
TTDefenderListHasBuff = TTDefenderListHasBuff

function TTDefenderListHasBuff:IsSatisfied(notify)
  if notify.GetDefenderEntityIDList then
    local eids = notify:GetDefenderEntityIDList()
    for _, id in ipairs(eids) do
      local defender = self._world:GetEntityByID(id)
      local buffCmp = defender:BuffComponent()
      if buffCmp then
        for i, buffEffect in ipairs(self._param) do
          if buffCmp:HasBuffEffect(buffEffect) then
            return true
          end
        end
      end
    end
  end
  return false
end

_class("TTNotifyBuffEffectMatch", TriggerBase)

function TTNotifyBuffEffectMatch:IsSatisfied(notify)
  if not notify.GetBuffEffectType then
    return false
  end
  return table.icontains(self._param, notify:GetBuffEffectType())
end

_class("TTIsMeNewTeamLeader", TriggerBase)
TTIsMeNewTeamLeader = TTIsMeNewTeamLeader

function TTIsMeNewTeamLeader:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if not owner:HasPetPstID() then
    return false
  end
  local tOldTeamOrder = notify:GetOldTeamOrder()
  local ownerPstID = owner:PetPstID():GetPstID()
  if tOldTeamOrder and ownerPstID == tOldTeamOrder[1] then
    return false
  end
  if not notify.GetNewTeamOrder then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    local cTeam = teamEntity:Team()
    local eTeamLeader = cTeam:GetTeamLeaderEntity()
    return owner:GetID() == eTeamLeader:GetID()
  end
  local tNewTeamOrder = notify:GetNewTeamOrder()
  if self._param[1] == 1 then
    return ownerPstID ~= tNewTeamOrder[1]
  else
    return ownerPstID == tNewTeamOrder[1]
  end
end

_class("TTOwnerPetIsTeamLeader", TriggerBase)
TTOwnerPetIsTeamLeader = TTOwnerPetIsTeamLeader

function TTOwnerPetIsTeamLeader:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    if teamEntity and teamEntity:Team() then
      local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
      if teamLeaderEntityID == owner:GetID() then
        return true
      end
    end
  end
  return false
end

_class("TTOwnerPetTeamOrderChangeType", TriggerBase)
TTOwnerPetTeamOrderChangeType = TTOwnerPetTeamOrderChangeType

function TTOwnerPetTeamOrderChangeType:IsSatisfied(notify)
  local function getTeamOrderIndex(teamOrder, petPstID)
    for i, v in ipairs(teamOrder) do
      if v == petPstID then
        return i
      end
    end
  end
  
  local bSatisfied = false
  local checkOffType = tonumber(self._param[1]) or 0
  local offIndex
  local owner = self:GetOwnerEntity()
  if owner:HasDeadMark() then
    return false
  end
  if owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    if teamEntity and teamEntity:Team() then
      local cTeam = teamEntity:Team()
      local ownerPstId = owner:PetPstID():GetPstID()
      if notify.GetOldTeamOrder and notify.GetNewTeamOrder then
        local oldOrder = notify:GetOldTeamOrder()
        local newOrder = notify:GetNewTeamOrder()
        local oldIndex = getTeamOrderIndex(oldOrder, ownerPstId)
        local newIndex = getTeamOrderIndex(newOrder, ownerPstId)
        offIndex = newIndex - oldIndex
        local curOffType = 0
        if 0 < offIndex then
          curOffType = 1
        elseif offIndex < 0 then
          curOffType = -1
        end
        if curOffType == checkOffType then
          bSatisfied = true
        end
      end
    end
  end
  local operation = tonumber(self._param[2]) or 0
  if operation ~= 0 then
    local key = self:GetKeyStr()
    if operation == 1 and offIndex then
      local cBuff = owner:BuffComponent()
      if cBuff then
        cBuff:SetBuffValue(key, offIndex)
      end
    end
  end
  return bSatisfied
end

function TTOwnerPetTeamOrderChangeType:GetKeyStr()
  if self._param[3] then
    return "OwnerPetTeamOrderChangeType" .. self._param[3]
  end
  return "OwnerPetTeamOrderChangeType"
end

_class("TTNotifyIsOwnerSummonerTeamOrFriendPet", TriggerBase)
TTNotifyIsOwnerSummonerTeamOrFriendPet = TTNotifyIsOwnerSummonerTeamOrFriendPet

function TTNotifyIsOwnerSummonerTeamOrFriendPet:IsSatisfied(notify)
  if not notify.GetNotifyEntity then
    return false
  end
  local owner = self:GetOwnerEntity()
  local ownerSummonerEntity = owner:GetSummonerEntity()
  if not ownerSummonerEntity then
    return false
  end
  local ownerSummonerTeamEntity
  if ownerSummonerEntity:Pet() then
    ownerSummonerTeamEntity = ownerSummonerEntity:Pet():GetOwnerTeamEntity()
  elseif ownerSummonerEntity:GetSuperEntity() then
    ownerSummonerTeamEntity = ownerSummonerEntity:GetSuperEntity():Pet():GetOwnerTeamEntity()
  elseif ownerSummonerEntity:HasLogicAutoBead() then
    local autoBeadCmpt = ownerSummonerEntity:LogicAutoBead()
    local teamEntityID = autoBeadCmpt:GetAttachTeamEntityID()
    local teamEntity = self._world:GetEntityByID(teamEntityID)
    if teamEntity then
      ownerSummonerTeamEntity = teamEntity
    end
  else
    return false
  end
  local entity = notify:GetNotifyEntity()
  if notify:GetNotifyType() == NotifyType.TractionEnd then
    local defenderID = notify:GetDefenderId()
    entity = self._world:GetEntityByID(defenderID)
  elseif notify:GetNotifyType() == NotifyType.HitBackEnd then
    local defenderID = notify:GetDefenderId()
    entity = self._world:GetEntityByID(defenderID)
  end
  if entity:HasTeam() then
  elseif entity:HasPet() then
    local teamEntity = entity:Pet():GetOwnerTeamEntity()
    entity = teamEntity
  elseif entity:HasTrapID() then
    return entity:GetID() == owner:GetID()
  end
  local match = entity:GetID() == ownerSummonerTeamEntity:GetID()
  return match
end

_class("TTDefenderIsMe", TriggerBase)
TTDefenderIsMe = TTDefenderIsMe

function TTDefenderIsMe:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if notify.GetDefenderEntity then
    local entity = notify:GetDefenderEntity()
    return owner == entity
  end
  return false
end

_class("TTOwnerPetIsNotTeamTail", TriggerBase)
TTOwnerPetIsNotTeamTail = TTOwnerPetIsNotTeamTail

function TTOwnerPetIsNotTeamTail:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if not owner:HasPet() then
    return false
  end
  local cTeam = owner:Pet():GetOwnerTeamEntity():Team()
  local teamOrder = cTeam:GetTeamOrder()
  if notify.GetFormerTeamOrder and notify:GetFormerTeamOrder() then
    teamOrder = notify:GetFormerTeamOrder()
  elseif notify.GetNewTeamOrder and notify:GetNewTeamOrder() then
    teamOrder = notify:GetNewTeamOrder()
  end
  for i = #teamOrder, 1, -1 do
    local pstId = teamOrder[i]
    local e = cTeam:GetPetEntityByPetPstID(pstId)
    if not e:PetPstID():IsHelpPet() and not e:HasPetDeadMark() then
      return pstId ~= owner:PetPstID():GetPstID()
    end
  end
end

_class("TTPetInSkillScope", TriggerBase)
TTPetInSkillScope = TTPetInSkillScope

function TTPetInSkillScope:IsSatisfied(notify)
  local skillID = self._param[1]
  local inSide = self._param[2] or 1
  local ownerEntity = self:GetOwnerEntity()
  if ownerEntity:HasDeadMark() then
    return false
  end
  local posSelf = ownerEntity:GridLocation():GetGridPos()
  local bodyArea = ownerEntity:BodyArea():GetArea()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local skillResult = skillCalculater:CalcSkillScope(skillConfigData, posSelf, Vector2(0, 1), bodyArea)
  local petPos = Vector2(0, 0)
  if ownerEntity:HasSummoner() then
    local petEntity = ownerEntity:GetSummonerEntity()
    if petEntity then
      petPos = petEntity:GetGridPosition()
      if petEntity:HasSuperEntity() then
        petPos = petEntity:GetSuperEntity():GetGridPosition()
      end
    end
  end
  local match = table.icontains(skillResult:GetAttackRange(), petPos)
  if inSide == 1 then
    return match
  elseif inSide == 0 then
    return not match
  end
  return false
end

_class("TTSanValueInRange", TriggerBase)
TTSanValueInRange = TTSanValueInRange

function TTSanValueInRange:IsSatisfied(notify)
  local minValue = self._param[1]
  local maxValue = self._param[2]
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if featureLogicSvc and featureLogicSvc:HasFeatureType(FeatureType.Sanity) then
    local curSanValue = featureLogicSvc:GetSanValue()
    if curSanValue and minValue <= curSanValue and maxValue >= curSanValue then
      return true
    end
  end
  return false
end

_class("TTPickUpPosIsTeamPos", TriggerBase)
TTPickUpPosIsTeamPos = TTPickUpPosIsTeamPos

function TTPickUpPosIsTeamPos:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  local pickupComponent = ownerEntity:ActiveSkillPickUpComponent()
  if not pickupComponent then
    return false
  end
  local lastPickUpPos = pickupComponent:GetLastPickUpGridPos()
  if not lastPickUpPos then
    return false
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local posTeam = teamEntity:GetGridPosition()
  return lastPickUpPos == posTeam
end

_class("TTIsOnMatchPieceTypeGrid", TriggerBase)
TTIsOnMatchPieceTypeGrid = TTIsOnMatchPieceTypeGrid

function TTIsOnMatchPieceTypeGrid:IsSatisfied()
  local entity = self:GetOwnerEntity()
  local gridPosition = entity:GetGridPosition()
  local matchPieceType = self._param[1]
  local isMatch = self._param[2] or 1
  local utilData = self._world:GetService("UtilData")
  local pieceType = utilData:FindPieceElement(gridPosition)
  if isMatch == 1 then
    return pieceType == matchPieceType
  else
    return pieceType ~= matchPieceType
  end
  return false
end

_class("TTCurDayNightState", TriggerBase)
TTCurDayNightState = TTCurDayNightState

function TTCurDayNightState:IsSatisfied(notify)
  local checkState = self._param[1]
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if featureLogicSvc and featureLogicSvc:HasFeatureType(FeatureType.DayNight) then
    local curState = featureLogicSvc:GetCurDayNightState()
    if curState and curState == checkState then
      return true
    end
  end
  return false
end

TTSanChangedMode = {Increased = 1, Decreased = 2}
_enum("TTSanChangedMode", TTSanChangedMode)
_class("TTSanChanged", TriggerBase)
TTSanChanged = TTSanChanged

function TTSanChanged:Constructor()
  self._mode = tonumber(self._param[1])
  self._satisfied = false
end

function TTSanChanged:IsSatisfied(notify)
  if not NTSanValueChange:IsInstanceOfType(notify) then
    Log.error("这啥通知??", notify:GetNotifyType())
    return false
  end
  if self._mode == TTSanChangedMode.Increased then
    return notify:GetCurValue() > notify:GetOldValue()
  elseif self._mode == TTSanChangedMode.Decreased then
    return notify:GetCurValue() < notify:GetOldValue()
  end
  Log.error("模式错误：", tostring(self._mode))
  return false
end

_class("TTKilledByPet", TriggerBase)
TTKilledByPet = TTKilledByPet

function TTKilledByPet:IsSatisfied(notify)
  local attackEntity = notify:GetNotifyEntity()
  local isPetCaster = false
  if attackEntity:HasSuperEntity() and attackEntity:EntityType():IsSkillHolder() and attackEntity:GetSuperEntity():HasPetPstID() then
    isPetCaster = true
  elseif attackEntity:HasSummoner() and attackEntity:GetSummonerEntity():HasPet() then
    isPetCaster = true
  elseif attackEntity:HasPet() then
    isPetCaster = true
  end
  if not isPetCaster then
    return false
  end
  local ownerEntity = self:GetOwnerEntity()
  local skillEffectResultContainer = attackEntity:SkillContext():GetResultContainer()
  if not skillEffectResultContainer then
    return false
  end
  local skillScopeResult = skillEffectResultContainer:GetScopeResult()
  if not skillScopeResult then
    return false
  end
  local ids = skillScopeResult:GetTargetIDs()
  for _, entityID in ipairs(ids) do
    local entity = self._world:GetEntityByID(entityID)
    if entity and entity:GetID() == ownerEntity:GetID() then
      local attributeComponent = entity:Attributes()
      if attributeComponent then
        local logicHP = attributeComponent:GetCurrentHP()
        if not entity or entity:HasDeadMark() or logicHP <= 0 then
          return true
        end
      end
    end
  end
  return false
end

_class("TTSanChangeHasDebtVal", TriggerBase)
TTSanChangeHasDebtVal = TTSanChangeHasDebtVal

function TTSanChangeHasDebtVal:IsSatisfied(notify)
  if notify:GetNotifyType() == NotifyType.SanValueChange then
    local debtVal = notify:GetDebtValue()
    if debtVal and 0 < debtVal then
      return true
    end
  end
  return false
end

_class("TTPickUpPosMonsterBuffEffectMatch", TriggerBase)
TTPickUpPosMonsterBuffEffectMatch = TTPickUpPosMonsterBuffEffectMatch

function TTPickUpPosMonsterBuffEffectMatch:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  local pickupComponent = ownerEntity:ActiveSkillPickUpComponent()
  if not pickupComponent then
    return false
  end
  local lastPickUpPos = pickupComponent:GetLastPickUpGridPos()
  if not lastPickUpPos then
    return false
  end
  local buffEffect = self._param[1]
  local have = self._param[2] or 1
  local utilData = self._world:GetService("UtilData")
  local haveBuff = utilData:OnCalcTargetPosMonsterBuffEffectMatch(lastPickUpPos, buffEffect, ownerEntity)
  local isSatisfied = haveBuff == true and have == 1 or haveBuff == false and have == 0
  return isSatisfied
end

_class("TTTargetPosMonsterBuffEffectMatch", TriggerBase)
TTTargetPosMonsterBuffEffectMatch = TTTargetPosMonsterBuffEffectMatch

function TTTargetPosMonsterBuffEffectMatch:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  local targetPos
  if notify:GetNotifyType() == NotifyType.NormalAttackChangeBefore then
    targetPos = notify:GetTargetPos()
  end
  if not targetPos then
    return false
  end
  local buffEffect = self._param[1]
  local have = self._param[2] or 1
  local utilData = self._world:GetService("UtilData")
  local haveBuff = utilData:OnCalcTargetPosMonsterBuffEffectMatch(targetPos, buffEffect, ownerEntity)
  local isSatisfied = haveBuff == true and have == 1 or haveBuff == false and have == 0
  return isSatisfied
end

_class("TTSyncMovePosHasMonster", TriggerBase)
TTSyncMovePosHasMonster = TTSyncMovePosHasMonster

function TTSyncMovePosHasMonster:IsSatisfied(notify)
  local targetPos
  if notify:GetNotifyType() == NotifyType.SyncMoveEachMoveEnd then
    targetPos = notify:GetPos()
  end
  if not targetPos then
    return false
  end
  local boardsvc = self._world:GetService("BoardLogic")
  local monsterList = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    monsterList = {
      self._world:Player():GetCurrentEnemyTeamEntity()
    }
  else
    monsterList = boardsvc:GetMonstersAtPos(targetPos)
  end
  local isSatisfied = false
  for _, monster in ipairs(monsterList) do
    if not monster:HasDeadMark() then
      isSatisfied = true
      break
    end
  end
  return isSatisfied
end

_class("TTSyncMovePosHasChanged", TriggerBase)
TTSyncMovePosHasChanged = TTSyncMovePosHasChanged

function TTSyncMovePosHasChanged:Constructor()
  local ignoreFirstMove = tonumber(self._param[1])
  self._ignoreFirstMove = ignoreFirstMove == 1
end

function TTSyncMovePosHasChanged:IsSatisfied(notify)
  local targetPos
  if notify:GetNotifyType() == NotifyType.SyncMoveEachMoveEnd then
    targetPos = notify:GetPos()
  end
  if not targetPos then
    return false
  end
  local pathIndex = notify:GetPathIndex()
  if pathIndex == 1 and self._ignoreFirstMove then
    return true
  end
  local oldPos = notify:GetOldPos()
  if oldPos ~= targetPos then
    return true
  end
  return false
end

_class("TTRideState", TriggerBase)
TTRideState = TTRideState

function TTRideState:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  local notifyEntity = notify:GetNotifyEntity()
  if notifyEntity:GetID() ~= ownerEntity:GetID() then
    return false
  end
  local isRide
  if notify:GetNotifyType() == NotifyType.RideStateChange then
    isRide = notify:GetRideState()
  end
  local checkState = self._param[1] == 1
  if isRide == checkState then
    return true
  end
  return false
end

_class("TTIsMount", TriggerBase)
TTIsMount = TTIsMount

function TTIsMount:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  if not ownerEntity:HasRide() then
    return false
  end
  local rideCmpt = ownerEntity:Ride()
  local mountID = rideCmpt:GetMountID()
  local mountEntity = self:GetWorld():GetEntityByID(mountID)
  if not mountEntity then
    return false
  end
  if mountEntity:HasTrap() and mountEntity:HasDeadMark() then
    return true
  elseif mountEntity:HasMonsterID() then
    local buffCmpt = mountEntity:BuffComponent()
    if buffCmpt and buffCmpt:HasBuffEffect(BuffEffectType.Palsy) then
      return true
    end
  end
  return false
end

_class("TTIsTrapStateOpen", TriggerBase)
TTIsTrapStateOpen = TTIsTrapStateOpen

function TTIsTrapStateOpen:IsSatisfied()
  local entity = self:GetOwnerEntity()
  if not entity:HasTrapID() then
    return false
  end
  local attrCpmt = entity:Attributes()
  local state = self._x or 1
  if attrCpmt and attrCpmt:GetAttribute("OpenState") and attrCpmt:GetAttribute("OpenState") == state then
    return true
  end
  return false
end

TTLayerCountNonDivisible_ZeroLayerPolicy = {TrueOnZero = 1, FalseOnZero = 2}
_enum("TTLayerCountNonDivisible_ZeroLayerPolicy", TTLayerCountNonDivisible_ZeroLayerPolicy)
_class("TTLayerCountNonDivisible", TriggerBase)
TTLayerCountNonDivisible = TTLayerCountNonDivisible

function TTLayerCountNonDivisible:IsSatisfied(notify)
  local buffId = self._param[1]
  local divider = self._param[2]
  local zeroLayerPolicy = self._param[3]
  if #self._param < 3 then
    Log.exception(self._className, "缺少必要参数")
    return false
  end
  if divider == 0 then
    Log.exception(self._className, "除数不能是0")
    return false
  end
  local e = self:GetOwnerEntity()
  local cBuff = e:BuffComponent()
  local layerCount = 0
  local instance = cBuff:GetBuffById(buffId)
  if instance then
    local layerName = instance:GetBuffLayerName()
    layerCount = cBuff:GetBuffValue(layerName) or 0
  end
  if layerCount == 0 then
    return zeroLayerPolicy == TTLayerCountNonDivisible_ZeroLayerPolicy.TrueOnZero
  end
  local a, b = math.modf(layerCount / divider)
  return b ~= 0
end

_class("TTLayerChangeCasterIsMe", TriggerBase)
TTLayerChangeCasterIsMe = TTLayerChangeCasterIsMe

function TTLayerChangeCasterIsMe:IsSatisfied(notify)
  if not notify:GetCasterEntity() or not self:GetOwnerEntity() then
    return false
  end
  return self:GetOwnerEntity():GetID() == notify:GetCasterEntity():GetID()
end

_class("TTIsMeInvolvedInTeamLeaderChange", TriggerBase)
TTIsMeInvolvedInTeamLeaderChange = TTIsMeInvolvedInTeamLeaderChange

function TTIsMeInvolvedInTeamLeaderChange:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if not owner:HasPetPstID() then
    return false
  end
  local ownerEntityID = owner:GetID()
  if notify:GetNotifyType() == NotifyType.TeamOrderChange then
    local oldTeamOrder = notify:GetOldTeamOrder()
    local newTeamOrder = notify:GetNewTeamOrder()
    local ownerPstID = owner:PetPstID():GetPstID()
    return oldTeamOrder[1] ~= newTeamOrder[1] and (ownerPstID == oldTeamOrder[1] or ownerPstID == newTeamOrder[1])
  end
  local eNewTeamLeader = notify:GetNewTeamLeader()
  local eOldTeamLeader = notify:GetOldTeamLeader()
  return ownerEntityID == eNewTeamLeader:GetID() or ownerEntityID == eOldTeamLeader:GetID()
end

_class("TTActiveSkillCausedDamage", TriggerBase)
TTActiveSkillCausedDamage = TTActiveSkillCausedDamage

function TTActiveSkillCausedDamage:IsSatisfied(notify)
  local attacker = notify:GetAttackerEntity()
  local skillEffectResultContainer = attacker:SkillContext():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if not damageResultArray or #damageResultArray == 0 then
    return false
  end
  local damageCount = 0
  for _, result in ipairs(damageResultArray) do
    local tDamageInfo = result:GetDamageInfoArray()
    if tDamageInfo and 0 < #tDamageInfo then
      for __, damageInfo in ipairs(tDamageInfo) do
        local targetID = damageInfo:GetTargetEntityID()
        local e = self._world:GetEntityByID(targetID)
        if e and not e:HasTrap() then
          local damageType = damageInfo:GetDamageType()
          if damageType ~= DamageType.Miss then
            damageCount = damageCount + 1
          end
        end
      end
    end
  end
  return 0 < damageCount
end

_class("TTFeatureSkillTypeMatch", TriggerBase)
TTFeatureSkillTypeMatch = TTFeatureSkillTypeMatch

function TTFeatureSkillTypeMatch:IsSatisfied(notify)
  if notify:GetNotifyType() == NotifyType.FeatureSkillAttackEnd then
    local ntFeatureType = notify:GetFeatureType()
    for i, p in ipairs(self._param) do
      if ntFeatureType == p then
        return true
      end
    end
  end
  return false
end

_class("TTOwnerHasAllBuff", TriggerBase)
TTOwnerHasAllBuff = TTOwnerHasAllBuff

function TTOwnerHasAllBuff:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if owner:HasDeadMark() then
    return false
  end
  local buffCmp = owner:BuffComponent()
  if not buffCmp then
    return
  end
  for i, buffEffect in ipairs(self._param) do
    if not buffCmp:HasBuffEffect(buffEffect) then
      self._satisfied = false
      return false
    end
  end
  self._satisfied = true
  return true
end

_class("TTFirstNormalAttackDir", TriggerBase)
TTFirstNormalAttackDir = TTFirstNormalAttackDir

function TTFirstNormalAttackDir:IsSatisfied(notify)
  local entity = self:GetOwnerEntity()
  if not entity:HasPetPstID() then
    return
  end
  local cPetPstID = entity:PetPstID()
  local attackPos = notify:GetAttackPos()
  local damagePos = notify:GetTargetPos()
  local dir = damagePos - attackPos
  local dirNum = 0
  if dir.x == 0 and 0 < dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.Up
  elseif 0 < dir.x and 0 < dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.RightTop
  elseif 0 < dir.x and dir.y == 0 then
    dirNum = BuffLogicSaveNormalAttackDirEnum.Right
  elseif 0 < dir.x and 0 > dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.RightBottom
  elseif dir.x == 0 and 0 > dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.Down
  elseif 0 > dir.x and 0 > dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.LeftBottom
  elseif 0 > dir.x and dir.y == 0 then
    dirNum = BuffLogicSaveNormalAttackDirEnum.Left
  elseif 0 > dir.x and 0 < dir.y then
    dirNum = BuffLogicSaveNormalAttackDirEnum.LeftTop
  end
  if not table.icontains(self._param, dirNum) then
    return false
  end
  local curRound = self._world:BattleStat():GetGameRoundCount()
  if table.icontains(cPetPstID:GetRoundNormalAttackDirTable(curRound), dirNum) then
    return false
  end
  return true
end

_class("TTPlayerMovePosNotFirstStep", TriggerBase)
TTPlayerMovePosNotFirstStep = TTPlayerMovePosNotFirstStep

function TTPlayerMovePosNotFirstStep:Constructor()
end

function TTPlayerMovePosNotFirstStep:IsSatisfied(notify)
  local targetPos
  if notify:GetNotifyType() ~= NotifyType.PlayerEachMoveEnd then
    return false
  end
  local chainIndex = notify:GetChainIndex()
  if 1 < chainIndex then
    return true
  end
  return false
end

_class("TTGridConvertMyPos", TriggerBase)
TTGridConvertMyPos = TTGridConvertMyPos

function TTGridConvertMyPos:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.GridConvert and notify:GetNotifyType() ~= NotifyType.ExChangeGridColor and notify:GetNotifyType() ~= NotifyType.CovCrystalPrism then
    return false
  end
  local owner = self:GetOwnerEntity()
  local bodyAreaCmpt = owner:BodyArea()
  local bodyArea = bodyAreaCmpt:GetArea()
  local myPos = owner:GetGridPosition()
  for i, v in ipairs(bodyArea) do
    local pos = myPos + v
    if notify:GetConvertInfoAt(pos) ~= nil then
      return true
    end
  end
  return false
end

_class("TTActiveSkillPowerfullRound", TriggerBase)
TTActiveSkillPowerfullRound = TTActiveSkillPowerfullRound

function TTActiveSkillPowerfullRound:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if owner:HasPet() then
    local checkRound = self._param[1] or -1
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    if teamEntity then
      local readyCount = teamEntity:ActiveSkill():GetPreviousReadyRoundCount(owner:GetID())
      if readyCount == checkRound then
        return true
      end
    end
  end
  return false
end

_class("TTTeamInAuraRange", TriggerBase)
TTTeamInAuraRange = TTTeamInAuraRange

function TTTeamInAuraRange:IsSatisfied(notify)
  local auraGroupID = self._param[1]
  local inSide = self._param[2] or 1
  local lsvcTrigger = self._world:GetService("Trigger")
  local curMovePos = lsvcTrigger:GetPlayerMoveEndPosByNotify(notify)
  local battleSvc = self._world:GetService("Battle")
  local match = battleSvc:IsPosInAuraRange(auraGroupID, curMovePos)
  if inSide == 1 then
    return match
  elseif inSide == 0 then
    return not match
  end
  return false
end

_class("TTCoffinMusumeCandleLight", TriggerBase)
TTCoffinMusumeCandleLight = TTCoffinMusumeCandleLight

function TTCoffinMusumeCandleLight:IsSatisfied(notify)
  local isLightTrue = self._param[1] == 1
  local owner = self:GetOwnerEntity()
  local hasBuffComponent = owner:HasBuff()
  local isLightOn = false
  if hasBuffComponent then
    isLightOn = owner:BuffComponent():GetBuffValue(BattleConst.CandleLightKey) == 1
  end
  return isLightTrue and isLightOn or not isLightOn
end

_class("TTPetMoveInRange", TriggerBase)
TTPetMoveInRange = TTPetMoveInRange

function TTPetMoveInRange:IsSatisfied(notify)
  local pos = notify:GetPos()
  local skillID = self._x
  local owner = self:GetOwnerEntity()
  local bodyArea = owner:BodyArea():GetArea()
  local centerPos = owner:GetGridPosition()
  local casterDir = owner:GetGridDirection()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configSvc = self._world:GetService("Config")
  local skillConfig = configSvc:GetSkillConfigData(skillID)
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local result = skillCalculater:CalcSkillScope(skillConfig, centerPos, casterDir, bodyArea, owner)
  local attackRange = result:GetAttackRange()
  return table.Vector2Include(attackRange, pos)
end

_class("TTPosInAuraRange", TriggerBase)
TTPosInAuraRange = TTPosInAuraRange

function TTPosInAuraRange:IsSatisfied(notify)
  local auraGroupID = self._param[1]
  local layerCount = self._param[2]
  local inSide = self._param[3] or 1
  local compareType = self._param[4] or 1
  local ownerEntity = self:GetOwnerEntity()
  if ownerEntity:HasDeadMark() then
    return false
  end
  local posSelf = ownerEntity:GridLocation():GetGridPos()
  local bodyArea = ownerEntity:BodyArea():GetArea()
  local curMovePos = posSelf
  if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveStart or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    curMovePos = notify:GetPos()
  elseif notify:GetNotifyType() == NotifyType.Teleport then
    curMovePos = notify:GetPosNew()
  elseif notify:GetNotifyType() == NotifyType.EntityMoveEnd then
    curMovePos = notify:GetPosNew()
  end
  local trapSvc = self._world:GetService("TrapLogic")
  local battleSvc = self._world:GetService("Battle")
  local match = false
  for _, value in ipairs(bodyArea) do
    local newPos = curMovePos + value
    local count = battleSvc:GetAuraSuperposedCount(auraGroupID, newPos)
    count = count or -1
    if compareType == 1 then
      if layerCount <= count then
        match = true
        break
      end
    elseif compareType == 0 and count == layerCount then
      match = true
      break
    end
  end
  if inSide == 1 then
    return match
  elseif inSide == 0 then
    return not match
  end
  return false
end

_class("TTMonsterCompareDistance", TriggerBase)
TTMonsterCompareDistance = TTMonsterCompareDistance

function TTMonsterCompareDistance:IsSatisfied(notify)
  local monsterClassID = self._param[1]
  local targetEntity
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local monsterList, monsterPosList = utilScopeSvc:SelectAllMonster()
  for i, e in ipairs(monsterList) do
    if monsterClassID == e:MonsterID():GetMonsterClassID() then
      targetEntity = e
      break
    end
  end
  if not targetEntity then
    return false
  end
  local targetPos = targetEntity:GetGridPosition()
  local owner = self:GetOwnerEntity()
  local ownerPos = owner:GetGridPosition()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local targetDis = Vector2.Distance(targetPos, teamPos)
  local ownerDis = Vector2.Distance(ownerPos, teamPos)
  local compareFlag = self._param[2]
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = ownerDis == targetDis
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = ownerDis ~= targetDis
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = targetDis < ownerDis
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = targetDis <= ownerDis
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = targetDis > ownerDis
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = targetDis >= ownerDis
  end
  return satisfied
end

_class("TTHowManyKindsOfElementInTeam", TriggerBase)
TTHowManyKindsOfElementInTeam = TTHowManyKindsOfElementInTeam

function TTHowManyKindsOfElementInTeam:IsSatisfied(notify)
  local elementSourceType = self._param[1]
  local compareFlag = self._param[2]
  local targetNumber = self._param[3]
  local satisfied = false
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if not teamEntity then
    return satisfied
  end
  local curElementList = {}
  local teamCmpt = teamEntity:Team()
  local petEntities = teamCmpt:GetTeamPetEntities()
  for _, e in ipairs(petEntities) do
    local curEntityElement
    local elementCmpt = e:Element()
    if elementSourceType == 1 then
      curEntityElement = elementCmpt:GetPrimaryType()
    elseif elementSourceType == 2 then
      curEntityElement = elementCmpt:GetSecondaryType()
    end
    local isContain = table.icontains(curElementList, curEntityElement)
    if isContain == false then
      curElementList[#curElementList + 1] = curEntityElement
    end
  end
  local elementCount = #curElementList
  if compareFlag == ComparisonOperator.EQ then
    satisfied = elementCount == targetNumber
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = elementCount ~= targetNumber
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = targetNumber < elementCount
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = targetNumber <= elementCount
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = targetNumber > elementCount
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = targetNumber >= elementCount
  end
  return satisfied
end

_class("TTTrapSummonerHasSummonedBefore", TriggerBase)
TTTrapSummonerHasSummonedBefore = TTTrapSummonerHasSummonedBefore

function TTTrapSummonerHasSummonedBefore:IsSatisfied(notify)
  local ownerEntity = notify:GetOwnerEntity()
  if not ownerEntity then
    return false
  end
  return notify:IsFirstSummon()
end

_class("TTTrapSummonedByMe", TriggerBase)
TTTrapSummonedByMe = TTTrapSummonedByMe

function TTTrapSummonedByMe:IsSatisfied(notify)
  local ownerEntity = notify:GetOwnerEntity()
  if not ownerEntity then
    return false
  end
  if ownerEntity:HasSuperEntity() and ownerEntity:EntityType():IsSkillHolder() then
    ownerEntity = ownerEntity:GetSuperEntity()
  end
  return ownerEntity:GetID() == self:GetOwnerEntity():GetID()
end

_class("TTNotifyDefenderBodyAreaMatch", TriggerBase)
TTNotifyDefenderBodyAreaMatch = TTNotifyDefenderBodyAreaMatch

function TTNotifyDefenderBodyAreaMatch:IsSatisfied(notify)
  if notify.GetDefenderEntity then
    local entity = notify:GetDefenderEntity()
    if self._world:MatchType() == MatchType.MT_BlackFist then
      local enemyTeamEntity = self._world:Player():GetCurrentEnemyTeamEntity()
      if entity:GetID() == enemyTeamEntity:GetID() then
        local param = self._param[1]
        if not param then
          return false
        end
        if param == 1 then
          return true
        else
          return false
        end
      else
        return false
      end
    elseif entity:MonsterID() then
      local bodyAreaComponent = entity:BodyArea()
      if bodyAreaComponent then
        bodyAreaComponent:GetAreaCount()
        local cnt = bodyAreaComponent:GetAreaCount()
        local param = self._param[1]
        if not param then
          return false
        end
        if cnt == 1 and param == 1 then
          return true
        end
        if 1 < cnt and 1 < param then
          return true
        end
      end
    end
  end
  return false
end

_class("TTWeikeNotifySkillType", TriggerBase)
TTWeikeNotifySkillType = TTWeikeNotifySkillType

function TTWeikeNotifySkillType:IsSatisfied(notify)
  local targetSkillType = self._param[1]
  local skillType = notify:GetSkillType()
  return skillType == targetSkillType
end

_class("TTAttackTargetVisibleBuffCount", TriggerBase)
TTAttackTargetVisibleBuffCount = TTAttackTargetVisibleBuffCount

function TTAttackTargetVisibleBuffCount:IsSatisfied(notify)
  local targetEntity = notify:GetDefenderEntity()
  if not targetEntity or not targetEntity:HasBuff() then
    return false
  end
  local cBuff = targetEntity:BuffComponent()
  local buffArray = cBuff:GetBuffArray()
  local count = 0
  for _, instance in ipairs(buffArray) do
    local buffID = instance:BuffID()
    local cfgBuff = Cfg.cfg_buff[buffID]
    if cfgBuff.ShowBuffIcon then
      count = count + 1
    end
  end
  return count >= self._param[1]
end

_class("TTDefenderRingDistance", TriggerBase)
TTDefenderRingDistance = TTDefenderRingDistance

function TTDefenderRingDistance:IsSatisfied(notify)
  local attacker = notify:GetNotifyEntity()
  local attackPos = notify:GetTargetPos()
  if attacker ~= self:GetOwnerEntity() then
    return false
  end
  local attackerPos = attacker:GridLocation():Center()
  local distance = math.min(math.abs(attackerPos.x - attackPos.x), math.abs(attackerPos.y - attackPos.y))
  local paramDistance = tonumber(self._param[1])
  return distance < paramDistance
end

_class("TTIsMeHPLocked", TriggerBase)
TTIsMeHPLocked = TTIsMeHPLocked

function TTIsMeHPLocked:IsSatisfied(notify)
  local blsvc = self._world:GetService("BuffLogic")
  local lockBuff, isLock = blsvc:CheckEntityLockHP(self:GetOwnerEntity())
  return isLock
end

_class("TTIsSkillSelectTargetModeMatch", TriggerBase)
TTIsSkillSelectTargetModeMatch = TTIsSkillSelectTargetModeMatch

function TTIsSkillSelectTargetModeMatch:IsSatisfied(notify)
  if not notify.GetSkillID then
    return false
  end
  local skillID = notify:GetSkillID()
  if not skillID then
    return false
  end
  local skillLogicService = self._world:GetService("SkillLogic")
  local checkType = self._param[1] or 0
  if checkType == SkillTargetSelectionMode.Grid then
    local isGridSkill = skillLogicService:IsSelectGridSkill(skillID)
    return isGridSkill
  elseif checkType == SkillTargetSelectionMode.Entity then
    local isSingleSkill = skillLogicService:IsSelectEntitySkill(skillID)
    return isSingleSkill
  end
  return false
end

_class("TTGridConvertHasWater", TriggerBase)
TTGridConvertHasWater = TTGridConvertHasWater

function TTGridConvertHasWater:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.GridConvert then
    return false
  end
  local bluePieceNum = 0
  local convertInfoArray = notify:GetConvertInfoArray()
  for _, convertInfo in ipairs(convertInfoArray) do
    local afterPieceType = convertInfo:GetAfterPieceType()
    if afterPieceType == PieceType.Blue then
      bluePieceNum = bluePieceNum + 1
    end
  end
  if 0 < bluePieceNum then
    notify:SetConvertWaterCount(bluePieceNum)
  end
  return 0 < bluePieceNum
end

_class("TTPetIDInTeam", TriggerBase)
TTPetIDInTeam = TTPetIDInTeam

function TTPetIDInTeam:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  if ownerEntity:HasTeam() then
    local cTeam = ownerEntity:Team()
    local pets = cTeam:GetTeamPetEntities()
    for _, pet in ipairs(pets) do
      local cPetPstID = pet:PetPstID()
      if table.icontains(self._param, cPetPstID:GetTemplateID()) then
        return true
      end
    end
  end
  if ownerEntity:HasPet() then
    local eTeam = ownerEntity:Pet():GetOwnerTeamEntity()
    local cTeam = eTeam:Team()
    local pets = cTeam:GetTeamPetEntities()
    for _, pet in ipairs(pets) do
      local cPetPstID = pet:PetPstID()
      if table.icontains(self._param, cPetPstID:GetTemplateID()) then
        return true
      end
    end
  end
  return false
end

_class("TTChainSkillIndex", TriggerBase)
TTChainSkillIndex = TTChainSkillIndex

function TTChainSkillIndex:IsSatisfied(notify)
  local targetIndex = self._param[1]
  if not self:GetOwnerEntity():HasSkillInfo() then
    return false
  end
  if not notify.GetChainSkillId then
    return false
  end
  local chainSkillId = notify:GetChainSkillId()
  if not chainSkillId then
    return false
  end
  local cSkillInfo = self:GetOwnerEntity():SkillInfo()
  local index = cSkillInfo:GetChainSkillLevel(chainSkillId)
  return targetIndex == index
end

_class("TTTeamEnterExitAuraRange", TriggerBase)
TTTeamEnterExitAuraRange = TTTeamEnterExitAuraRange

function TTTeamEnterExitAuraRange:IsSatisfied(notify)
  local auraGroupID = self._param[1]
  local paramEnter = self._param[2] or 1
  local isEnter = paramEnter == 1
  local lsvcTrigger = self._world:GetService("Trigger")
  local moveBeginPos = lsvcTrigger:GetPlayerMoveBeginPosByNotify(notify)
  local moveEndPos = lsvcTrigger:GetPlayerMoveEndPosByNotify(notify)
  if moveBeginPos == moveEndPos then
    return false
  end
  local battleSvc = self._world:GetService("Battle")
  local isMoveBeginInAura = battleSvc:IsPosInAuraRange(auraGroupID, moveBeginPos)
  local isMoveEndInAura = battleSvc:IsPosInAuraRange(auraGroupID, moveEndPos)
  if isEnter then
    return not isMoveBeginInAura and isMoveEndInAura
  else
    return isMoveBeginInAura and not isMoveEndInAura
  end
  return false
end

_class("TTIsEquipRefineUIStateMatch", TriggerBase)
TTIsEquipRefineUIStateMatch = TTIsEquipRefineUIStateMatch

function TTIsEquipRefineUIStateMatch:IsSatisfied(notify)
  if not notify.GetRefineUIState then
    return false
  end
  local notifyState = notify:GetRefineUIState()
  local checkState = self._param[1] or EquipRefineUIStateType.On
  if checkState == notifyState then
    return true
  end
  return false
end

_class("TTIsControlOrMoveHost", TriggerBase)
TTIsControlOrMoveHost = TTIsControlOrMoveHost

function TTIsControlOrMoveHost:IsSatisfied(notify)
  local entityID
  if notify:GetNotifyType() == NotifyType.AddControlBuffEnd then
    local notifyEntity = notify:GetNotifyEntity()
    entityID = notifyEntity:GetID()
  elseif notify:GetNotifyType() == NotifyType.HitBackEnd or notify:GetNotifyType() == NotifyType.TractionEnd then
    entityID = notify:GetDefenderId()
  end
  if not entityID then
    return false
  end
  local owner = self:GetOwnerEntity()
  if not owner:AI() then
    return false
  end
  local attachMonsterID = owner:AI():GetRuntimeData("AttachMonsterID")
  return entityID == attachMonsterID
end

_class("TTIsDefenderBodyMatchOrCannotBeHitBack", TriggerBase)
TTIsDefenderBodyMatchOrCannotBeHitBack = TTIsDefenderBodyMatchOrCannotBeHitBack

function TTIsDefenderBodyMatchOrCannotBeHitBack:IsSatisfied(notify)
  if not notify.GetDefenderEntity then
    return false
  end
  local defender = notify:GetDefenderEntity()
  local param = self._param[1] or 1
  local isBodyAreaMatch = false
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local enemyTeamEntity = self._world:Player():GetCurrentEnemyTeamEntity()
    if defender:GetID() == enemyTeamEntity:GetID() and param == 1 then
      isBodyAreaMatch = true
    end
  elseif defender:MonsterID() then
    local bodyAreaComponent = defender:BodyArea()
    if bodyAreaComponent then
      bodyAreaComponent:GetAreaCount()
      local cnt = bodyAreaComponent:GetAreaCount()
      if cnt == 1 and param == 1 then
        isBodyAreaMatch = true
      end
      if 1 < cnt and 1 < param then
        isBodyAreaMatch = true
      end
    end
  end
  local buffSvc = self._world:GetService("BuffLogic")
  local isCannotBeHitBack = not buffSvc:CheckCanBeHitBack(defender)
  return isBodyAreaMatch or isCannotBeHitBack
end

_class("TTCheckCountDown", TriggerBase)
TTCheckCountDown = TTCheckCountDown

function TTCheckCountDown:IsSatisfied(notify)
  local buffID = self._param[1]
  local checkNumber = self._param[2] or 0
  local owner = self:GetOwnerEntity()
  local buffCmp = owner:BuffComponent()
  local buffInstance = buffCmp:GetBuffById(buffID)
  if not buffInstance then
    return
  end
  local countDown = buffInstance:GetCountDown()
  if not countDown then
    return
  end
  return countDown == checkNumber
end

_class("TTHasMonsterAroundDefender", TriggerBase)
TTHasMonsterAroundDefender = TTHasMonsterAroundDefender

function TTHasMonsterAroundDefender:IsSatisfied(notify)
  local skillID = self._param[1]
  if not notify.GetDefenderEntity then
    return false
  end
  local defenderEntity = notify:GetDefenderEntity()
  if not defenderEntity then
    return false
  end
  local posDefender = defenderEntity:GetGridPosition()
  local bodyArea = defenderEntity:BodyArea():GetArea()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local scopeResult = skillCalculater:CalcSkillScope(skillConfigData, posDefender, Vector2(0, 1), bodyArea)
  local posList = scopeResult:GetAttackRange()
  local boardsvc = self._world:GetService("BoardLogic")
  for index, rangePos in ipairs(posList) do
    local monsterList = boardsvc:GetMonstersAtPos(rangePos)
    local isSatisfied = false
    for _, monster in ipairs(monsterList) do
      if not monster:HasDeadMark() then
        isSatisfied = true
        break
      end
    end
    if isSatisfied then
      return true
    end
  end
  return false
end

_class("TTFmodLevelTotalRoundCount", TriggerBase)
TTFmodLevelTotalRoundCount = TTFmodLevelTotalRoundCount

function TTFmodLevelTotalRoundCount:IsSatisfied(notify)
  local fmodCount = self._param[1]
  local compareFlag = self._param[2]
  local count = self._param[3]
  local battleStatCmpt = self._world:BattleStat()
  local levelRound = battleStatCmpt:GetLevelTotalRoundCount()
  local curRound = levelRound % fmodCount
  if curRound == 0 then
    curRound = fmodCount
  end
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = curRound == count
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = curRound ~= count
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = count < curRound
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = count <= curRound
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = count > curRound
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = count >= curRound
  end
  return satisfied
end

_class("TTOwnerAroundCompareTrapCount", TriggerBase)
TTOwnerAroundCompareTrapCount = TTOwnerAroundCompareTrapCount

function TTOwnerAroundCompareTrapCount:IsSatisfied(notify)
  local skillID = self._param[1]
  local compareFlag = self._param[2]
  local count = self._param[3]
  local trapIDList = {}
  for i = 4, table.count(self._param) do
    table.insert(trapIDList, self._param[i])
  end
  local hasTrapPosList = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() then
      local trapID = e:Trap():GetTrapID()
      if table.intable(trapIDList, trapID) then
        local pos = e:GetGridPosition()
        table.insert(hasTrapPosList, pos)
      end
    end
  end
  local owner = self:GetOwnerEntity()
  local posDefender = owner:GetGridPosition()
  local bodyArea = owner:BodyArea():GetArea()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local scopeResult = skillCalculater:CalcSkillScope(skillConfigData, posDefender, Vector2(0, 1), bodyArea)
  local posList = scopeResult:GetAttackRange()
  local curCount = 0
  for index, rangePos in ipairs(posList) do
    if table.intable(hasTrapPosList, rangePos) then
      curCount = curCount + 1
    end
  end
  local satisfied = false
  if compareFlag == ComparisonOperator.EQ then
    satisfied = curCount == count
  elseif compareFlag == ComparisonOperator.NE then
    satisfied = curCount ~= count
  elseif compareFlag == ComparisonOperator.GT then
    satisfied = count < curCount
  elseif compareFlag == ComparisonOperator.GE then
    satisfied = count <= curCount
  elseif compareFlag == ComparisonOperator.LT then
    satisfied = count > curCount
  elseif compareFlag == ComparisonOperator.LE then
    satisfied = count >= curCount
  end
  return satisfied
end

_class("TTActiveSkillCostCasterHPNoZero", TriggerBase)
TTActiveSkillCostCasterHPNoZero = TTActiveSkillCostCasterHPNoZero

function TTActiveSkillCostCasterHPNoZero:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.ActiveSkillCostCasterHPEnd then
    return false
  end
  local damage = notify:GetDamage()
  if 0 < damage then
    return true
  else
    return false
  end
end

local HPChangeState = {Increase = 0, Decrease = 1}
_enum("HPChangeState", HPChangeState)
_class("TTBloodChange", TriggerBase)
TTBloodChange = TTBloodChange

function TTBloodChange:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.MonsterHPCChange and notify:GetNotifyType() ~= NotifyType.TrapHpChange and notify:GetNotifyType() ~= NotifyType.PlayerHPChange then
    return false
  end
  local isHPIncrease = notify:IsHPIncrease()
  if self._x == HPChangeState.Increase then
    return isHPIncrease
  elseif self._x == HPChangeState.Decrease then
    return not isHPIncrease
  end
end

_class("TTBreakHPLockIsUnlockHP", TriggerBase)
TTBreakHPLockIsUnlockHP = TTBreakHPLockIsUnlockHP

function TTBreakHPLockIsUnlockHP:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.BreakHPLock then
    return false
  end
  local isUnlockHP = notify:GetIsUnlockHP()
  return isUnlockHP == true
end

_class("TTNotHaveBattleLevelResult", TriggerBase)
TTNotHaveBattleLevelResult = TTNotHaveBattleLevelResult

function TTNotHaveBattleLevelResult:IsSatisfied(notify)
  local battleStatCmpt = self._world:BattleStat()
  local battleLevelResult = battleStatCmpt:GetBattleLevelResult()
  return battleLevelResult == false
end

_class("TTPopStarScoreNoLess", TriggerBase)
TTPopStarScoreNoLess = TTPopStarScoreNoLess

function TTPopStarScoreNoLess:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.PopStarScoreChange then
    return false
  end
  local popStarSvc = self._world:GetService("PopStarLogic")
  local curScore = popStarSvc:GetPopGridNum()
  return curScore >= self._x
end

_class("TTPopStarPopNumNoLess", TriggerBase)
TTPopStarPopNumNoLess = TTPopStarPopNumNoLess

function TTPopStarPopNumNoLess:IsSatisfied(notify)
  if notify:GetNotifyType() ~= NotifyType.PopStarEnd then
    return false
  end
  local popNum = notify:GetPopNum()
  return popNum >= self._x
end

_class("TTPetActiveSkillReady", TriggerBase)
TTPetActiveSkillReady = TTPetActiveSkillReady

function TTPetActiveSkillReady:IsSatisfied(notify)
  local matchReady = self._x or 1
  local owner = self:GetOwnerEntity()
  if owner:HasPet() then
    local skillID = 0
    local utilData = self._world:GetService("UtilData")
    local ready = utilData:GetPetSkillReadyAttr(owner, skillID)
    if ready then
      return ready == matchReady
    end
    if ready == nil and matchReady == 0 then
      return true
    end
  end
  return false
end

_class("TTOwnerPetIsTeamLeaderOrChainPathTypeElement", TriggerBase)
TTOwnerPetIsTeamLeaderOrChainPathTypeElement = TTOwnerPetIsTeamLeaderOrChainPathTypeElement

function TTOwnerPetIsTeamLeaderOrChainPathTypeElement:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if owner:HasPetPstID() then
    local teamEntity = owner:Pet():GetOwnerTeamEntity()
    if teamEntity and teamEntity:Team() then
      local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
      if teamLeaderEntityID == owner:GetID() then
        return true
      end
    end
    if not notify.GetChainPathType then
      return false
    end
    local chainPathType = notify:GetChainPathType()
    return table.icontains(self._param, chainPathType)
  end
  return false
end

_class("TTCurseHpOverRedHp", TriggerBase)
TTCurseHpOverRedHp = TTCurseHpOverRedHp

function TTCurseHpOverRedHp:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if owner:HasDeadMark() then
    return false
  end
  local checkNotifyPass = true
  if notify and notify:GetNotifyType() == NotifyType.MonsterBuffDamageEnd then
    local defEntity = notify:GetNotifyEntity()
    if defEntity and defEntity:GetID() ~= owner:GetID() then
      checkNotifyPass = false
    end
  end
  if not checkNotifyPass then
    return false
  end
  local attrCmpt = owner:Attributes()
  local buffCmpt = owner:BuffComponent()
  if attrCmpt and buffCmpt then
    local curhp = attrCmpt:GetCurrentHP()
    local curCurseHp = buffCmpt:GetCurseHPValue(true)
    if curhp <= curCurseHp then
      return true
    end
  end
  return false
end

_class("TTPlayerEachMoveEndRangeHasMonster", TriggerBase)
TTPlayerEachMoveEndRangeHasMonster = TTPlayerEachMoveEndRangeHasMonster

function TTPlayerEachMoveEndRangeHasMonster:Constructor()
  self._skillID = self._param[1]
end

function TTPlayerEachMoveEndRangeHasMonster:IsSatisfied(notify)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(self._skillID)
  local centerPos = notify:GetPos()
  local ownerEntity = self:GetOwnerEntity()
  local scopeResult = scopeCalc:ComputeScopeRange(skillConfigData:GetSkillScopeType(), skillConfigData:GetSkillScopeParam(), centerPos, ownerEntity:BodyArea():GetArea(), ownerEntity:GetGridDirection(), SkillTargetType.Monster, ownerEntity:GetGridPosition(), ownerEntity)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local tEntityID = targetSelector:_SelectMonsterDeadOrAlive(ownerEntity, scopeResult, self._skillID, skillConfigData:GetSkillTargetTypeParam()) or {}
  return 0 < #tEntityID
end

_class("TTPlayerEachMoveEndRangeHasTrapByTypeOrMonster", TriggerBase)
TTPlayerEachMoveEndRangeHasTrapByTypeOrMonster = TTPlayerEachMoveEndRangeHasTrapByTypeOrMonster

function TTPlayerEachMoveEndRangeHasTrapByTypeOrMonster:Constructor()
  self._skillID = self._param[1]
  self._trapType = {}
  for i = 2, #self._param do
    table.insert(self._trapType, self._param[i])
  end
end

function TTPlayerEachMoveEndRangeHasTrapByTypeOrMonster:IsSatisfied(notify)
  local triggerCond = {
    self._triggerType,
    self._skillID
  }
  local triggerMonster = TTPlayerEachMoveEndRangeHasMonster:New(self._owner, triggerCond)
  if triggerMonster:IsSatisfied(notify) then
    return true
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(self._skillID)
  local centerPos = notify:GetPos()
  local ownerEntity = self:GetOwnerEntity()
  local scopeResult = scopeCalc:ComputeScopeRange(skillConfigData:GetSkillScopeType(), skillConfigData:GetSkillScopeParam(), centerPos, ownerEntity:BodyArea():GetArea(), ownerEntity:GetGridDirection(), SkillTargetType.Trap, ownerEntity:GetGridPosition(), ownerEntity)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local selected = targetSelector:_SelectTrap(ownerEntity, scopeResult, self._skillID, skillConfigData:GetSkillTargetTypeParam(), false) or {}
  local tEntityID = {}
  for id, _ in pairs(selected) do
    table.insert(tEntityID, id)
  end
  if #tEntityID == 0 then
    return false
  end
  for _, id in ipairs(tEntityID) do
    local e = self._world:GetEntityByID(id)
    local cTrap = e:Trap()
    local trapType = cTrap:GetTrapType()
    if table.icontains(self._trapType, trapType) then
      return true
    end
  end
  return false
end

_class("TTDefenderHasAttackerAddIconBuff", TriggerBase)
TTDefenderHasAttackerAddIconBuff = TTDefenderHasAttackerAddIconBuff

function TTDefenderHasAttackerAddIconBuff:IsSatisfied(notify)
  if not notify.GetAttackerEntity or not notify.GetDefenderEntity then
    return false
  end
  local attacker = notify:GetAttackerEntity()
  local defender = notify:GetDefenderEntity()
  local buffCmp = defender:BuffComponent()
  if not buffCmp then
    return
  end
  local buffArray = buffCmp:GetBuffArray()
  for _, instance in ipairs(buffArray) do
    local buffLayerName = instance:GetBuffLayerName()
    local isShowBuffIcon = instance:BuffConfigData():GetBuffShowBuffIcon()
    local buffLayerCount = buffCmp:GetBuffValue(buffLayerName)
    if isShowBuffIcon and buffLayerCount ~= 0 then
      local context = instance:Context()
      local buffCasterEntity = context and context.casterEntity or nil
      if buffCasterEntity then
        if buffCasterEntity:HasSuperEntity() then
          buffCasterEntity = buffCasterEntity:GetSuperEntity()
        end
        if buffCasterEntity:GetID() == attacker:GetID() then
          return true
        end
      end
    end
  end
  return false
end

_class("TTDefenderBeHitBackOrTraction", TriggerBase)
TTDefenderBeHitBackOrTraction = TTDefenderBeHitBackOrTraction

function TTDefenderBeHitBackOrTraction:IsSatisfied(notify)
  local entityID
  if notify:GetNotifyType() == NotifyType.HitBackEnd or notify:GetNotifyType() == NotifyType.TractionEnd then
    entityID = notify:GetDefenderId()
  end
  if not entityID then
    return false
  end
  local owner = self:GetOwnerEntity()
  return entityID == owner:GetID()
end

_class("TTNoCurseHp", TriggerBase)
TTNoCurseHp = TTNoCurseHp

function TTNoCurseHp:IsSatisfied(notify)
  local owner = self:GetOwnerEntity()
  if owner:HasDeadMark() then
    return false
  end
  local buffCmpt = owner:BuffComponent()
  if buffCmpt then
    local isCurseHpEnabled = buffCmpt:IsCurseHPEnabled()
    if not isCurseHpEnabled then
      return true
    end
  end
  return false
end

_class("TTMonsterClassIDMatchDefender", TriggerBase)
TTMonsterClassIDMatchDefender = TTMonsterClassIDMatchDefender

function TTMonsterClassIDMatchDefender:IsSatisfied(notify)
  if not notify.GetDefenderEntity then
    Log.error("TTMonsterClassIDMatchDefender(400)无法处理通知: ", tostring(notify:GetNotifyType()))
    return false
  end
  local entity = notify:GetDefenderEntity()
  if not entity:HasMonsterID() then
    return false
  end
  local monsterID = entity:MonsterID():GetMonsterID()
  local monsterClassID = 0
  local cfg = Cfg.cfg_monster[monsterID]
  if cfg and cfg.ClassID then
    monsterClassID = cfg.ClassID
  end
  if table.intable(self._param, monsterClassID) then
    return true
  end
  return false
end

_class("TTIsBuffHasRoundCountAndIcon", TriggerBase)
TTIsBuffHasRoundCountAndIcon = TTIsBuffHasRoundCountAndIcon

function TTIsBuffHasRoundCountAndIcon:IsSatisfied(notify)
  if not notify.GetBuffID or not notify.GetBuffSeqID then
    Log.exception("buff判定条件408无法处理通知：", tostring(notify:GetNotifyType()))
    return false
  end
  if not notify:GetBuffSeqID() then
    Log.debug("TTIsBuffHasRoundCountAndIcon: buff没有被添加")
    return false
  end
  local buffID = notify:GetBuffID()
  if not buffID or not Cfg.cfg_buff[buffID] then
    Log.debug("TTIsBuffHasRoundCountAndIcon: 通知数据内没有有效的buffID")
    return false
  end
  local cfg = Cfg.cfg_buff[buffID]
  if cfg.RoundCount == 0 then
    Log.debug("TTIsBuffHasRoundCountAndIcon: buff没有持续时间 ", buffID)
    return false
  end
  if not cfg.ShowBuffIcon then
    Log.debug("TTIsBuffHasRoundCountAndIcon: buff不显示图标 ", buffID)
    return false
  end
  return true
end

_class("TTNotifyIsMyTeam", TriggerBase)
TTNotifyIsMyTeam = TTNotifyIsMyTeam

function TTNotifyIsMyTeam:IsSatisfied(notify)
  local ownerEntity = self:GetOwnerEntity()
  local ownerTeam
  if ownerEntity:HasTeam() then
    ownerTeam = ownerEntity
  elseif ownerEntity:HasPet() then
    ownerTeam = ownerEntity:Pet():GetOwnerTeamEntity()
  end
  if not ownerTeam then
    return false
  end
  local notifyTeam = notify:GetNotifyEntity()
  if not notifyTeam:HasTeam() then
    return false
  end
  return ownerTeam:GetID() == notifyTeam:GetID()
end

_class("TTNotifySkillDamageTargetCount", TriggerBase)
TTNotifySkillDamageTargetCount = TTNotifySkillDamageTargetCount

function TTNotifySkillDamageTargetCount:Constructor()
  self._compareFlag = self._param[1]
  self._compareNum = self._param[2]
end

function TTNotifySkillDamageTargetCount:IsSatisfied(notify)
  if notify.GetSkillDamageTargetCount then
    local countSave = notify:GetSkillDamageTargetCount()
    if countSave and 0 <= countSave then
      local satisfied = false
      if self._compareFlag == ComparisonOperator.EQ then
        satisfied = countSave == self._compareNum
      elseif self._compareFlag == ComparisonOperator.NE then
        satisfied = countSave ~= self._compareNum
      elseif self._compareFlag == ComparisonOperator.GT then
        satisfied = countSave > self._compareNum
      elseif self._compareFlag == ComparisonOperator.GE then
        satisfied = countSave >= self._compareNum
      elseif self._compareFlag == ComparisonOperator.LT then
        satisfied = countSave < self._compareNum
      elseif self._compareFlag == ComparisonOperator.LE then
        satisfied = countSave <= self._compareNum
      end
      return satisfied
    end
  end
  return false
end

_class("TTSkillIDNotMatch", TriggerBase)
TTSkillIDNotMatch = TTSkillIDNotMatch

function TTSkillIDNotMatch:IsSatisfied(notify)
  if notify.GetSkillID then
    local skillID = notify:GetSkillID()
    for i, p in ipairs(self._param) do
      if skillID == p then
        return false
      end
    end
    return true
  end
  return false
end

_class("TTCheckNotifyCostStep", TriggerBase)
TTCheckNotifyCostStep = TTCheckNotifyCostStep

function TTCheckNotifyCostStep:IsSatisfied(notify)
  local notifyType = notify:GetNotifyType()
  if notifyType == NotifyType.FeatureStepPointMoveCost or notifyType == NotifyType.FeatureStepPointSkillCost then
    local moveCost = notify:GetCostVal()
    return CompareNumber(self._x, moveCost, self._y)
  end
  return false
end

_class("TTCheckRecentMoveCostStep", TriggerBase)
TTCheckRecentMoveCostStep = TTCheckRecentMoveCostStep

function TTCheckRecentMoveCostStep:IsSatisfied(notify)
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if featureLogicSvc and featureLogicSvc:HasFeatureType(FeatureType.StepPoint) then
    local recentMoveCost = featureLogicSvc:GetRecentMoveCostStepPoint()
    if recentMoveCost then
      return CompareNumber(self._x, recentMoveCost, self._y)
    end
  end
  return false
end

_class("TTCheckCurStepPoint", TriggerBase)
TTCheckCurStepPoint = TTCheckCurStepPoint

function TTCheckCurStepPoint:IsSatisfied(notify)
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if featureLogicSvc and featureLogicSvc:HasFeatureType(FeatureType.StepPoint) then
    local curStepPoint = featureLogicSvc:GetCurStepPoint()
    if curStepPoint then
      return CompareNumber(self._x, curStepPoint, self._y)
    end
  end
  return false
end

_class("TTAttackerIsMeOrAttackerSuperIsMeOrSummonIsMe", TriggerBase)
TTAttackerIsMeOrAttackerSuperIsMeOrSummonIsMe = TTAttackerIsMeOrAttackerSuperIsMeOrSummonIsMe

function TTAttackerIsMeOrAttackerSuperIsMeOrSummonIsMe:IsSatisfied(notify)
  local attackEntity = notify:GetAttackerEntity()
  local ownerEntity = self:GetOwnerEntity()
  if attackEntity:GetID() == ownerEntity:GetID() then
    return true
  end
  if attackEntity:HasSuperEntity() and attackEntity:GetSuperEntity():GetID() == ownerEntity:GetID() then
    return true
  end
  if attackEntity:HasSummoner() and attackEntity:GetSummonerEntity():GetID() == ownerEntity:GetID() then
    return true
  end
  if attackEntity:HasSuperEntity() then
    local superEntity = attackEntity:GetSuperEntity()
    if superEntity:HasSummoner() and superEntity:GetSummonerEntity():GetID() == ownerEntity:GetID() then
      return true
    end
  end
  return false
end

_class("TTPetAnyActiveSkillReady", TriggerBase)
TTPetAnyActiveSkillReady = TTPetAnyActiveSkillReady

function TTPetAnyActiveSkillReady:IsSatisfied(notify)
  local matchReady = self._x or 1
  local owner = self:GetOwnerEntity()
  if owner:HasPet() then
    local utilData = self._world:GetService("UtilData")
    local anyReady = utilData:IsPetAnySkillReady(owner)
    if matchReady == 1 then
      return anyReady
    elseif matchReady == 0 then
      return not anyReady
    end
  end
  return false
end
