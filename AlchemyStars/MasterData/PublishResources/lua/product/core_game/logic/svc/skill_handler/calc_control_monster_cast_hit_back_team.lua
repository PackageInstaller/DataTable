_class("SkillEffectCalc_ControlMonsterCastHitBackTeam", SkillEffectCalc_Base)
SkillEffectCalc_ControlMonsterCastHitBackTeam = SkillEffectCalc_ControlMonsterCastHitBackTeam

function SkillEffectCalc_ControlMonsterCastHitBackTeam:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_ControlMonsterCastHitBackTeam:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillRange = skillEffectCalcParam.skillRange
  local skillParam = skillEffectCalcParam.skillEffectParam
  local targetMonsterClassID = skillParam:GetMonsterClassID()
  local monsterEntityIDs = {}
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    local monsterIDCmpt = monsterEntity:MonsterID()
    if monsterIDCmpt and targetMonsterClassID == monsterIDCmpt:GetMonsterClassID() and not monsterEntity:HasDeadMark() then
      local buffCmpt = monsterEntity:BuffComponent()
      if not buffCmpt:HasFlag(BuffFlags.Benumb) and not buffCmpt:HasBuffEffect(BuffFlags.SkipTurn) and not buffCmpt:HasBuffEffect(BuffEffectType.Fear) then
        table.insert(monsterEntityIDs, monsterEntity:GetID())
      end
    end
  end
  local hitBackCount = table.count(monsterEntityIDs)
  if hitBackCount == 0 then
    return
  end
  local movePath = {}
  local utilData = self._world:GetService("UtilData")
  local randomSvc = self._world:GetService("RandomLogic")
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  table.insert(movePath, teamPos)
  local dirList = {
    Vector2(0, 1),
    Vector2(0, -1),
    Vector2(-1, 0),
    Vector2(1, 0)
  }
  for i = 1, hitBackCount do
    local curPos = movePath[#movePath]
    local priorityPosList = {}
    local secondPosList = {}
    for _, dir in ipairs(dirList) do
      local targetPos = curPos + dir
      if not table.icontains(movePath, targetPos) then
        table.insert(priorityPosList, targetPos)
      else
        table.insert(secondPosList, targetPos)
      end
    end
    local targetPos
    local randomCount = table.count(priorityPosList)
    if 0 < randomCount then
      for j = 1, randomCount do
        local randomIndex = randomSvc:LogicRand(1, #priorityPosList)
        local randomPos = priorityPosList[randomIndex]
        local isBlock = utilData:IsPosBlock(randomPos, BlockFlag.MonsterLand)
        if not isBlock then
          targetPos = randomPos
          break
        else
          table.removev(priorityPosList, randomPos)
        end
      end
    end
    if targetPos == nil and 0 < #secondPosList then
      local randomIndex = randomSvc:LogicRand(1, #secondPosList)
      local randomPos = secondPosList[randomIndex]
      targetPos = randomPos
    end
    if targetPos then
      table.insert(movePath, targetPos)
      local dir = targetPos - curPos
      local hitbackDirType
      if dir == Vector2.up then
        hitbackDirType = HitBackDirectionType.Up
      elseif dir == Vector2.right then
        hitbackDirType = HitBackDirectionType.Right
      elseif dir == Vector2.down then
        hitbackDirType = HitBackDirectionType.Down
      elseif dir == Vector2.left then
        hitbackDirType = HitBackDirectionType.Left
      end
      local hitbackDistance = 1
      local ignorePathBlock = false
      local backupDirectionPlan, notCalcBomb, excludeCasterPos
      local interactType = HitBackInteractnWithBoardType.None
      local ignorePlayerBlock = false
      local hitbackResult = self._skillEffectService:CalcHitbackEffectResult(curPos, dir, teamEntity:BodyArea():GetArea(), teamEntity:GetID(), hitbackDirType, HitBackType.PushAway, hitbackDistance, HitBackCalcType.Instant, ignorePlayerBlock, excludeCasterPos, casterEntity, skillRange, notCalcBomb, ignorePathBlock, backupDirectionPlan, interactType, SkillEffectType.ControlMonsterCastHitBackTeam)
      skillEffectResultContainer:AddEffectResult(hitbackResult)
      table.insert(results, hitbackResult)
    end
  end
  local skillEffectResultControlMonsterCastHitBackTeam = SkillEffectResultControlMonsterCastHitBackTeam:New(monsterEntityIDs)
  skillEffectResultContainer:AddEffectResult(skillEffectResultControlMonsterCastHitBackTeam)
end
