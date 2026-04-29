require("action_move_base")
_class("ActionMoveSkillTargetCountMost", ActionMoveBase)
ActionMoveSkillTargetCountMost = ActionMoveSkillTargetCountMost

function ActionMoveSkillTargetCountMost:Constructor()
  self:_Reset()
  self._targetPosAndRound = {}
end

function ActionMoveSkillTargetCountMost:Reset()
  ActionMoveSkillTargetCountMost.super.Reset(self)
  self:_Reset()
end

function ActionMoveSkillTargetCountMost:_Reset()
  self._targetPos = nil
end

function ActionMoveSkillTargetCountMost:InitTargetPosList(listPosTarget)
  local battleStatCmpt = self._world:BattleStat()
  local levelTotalRoundCount = battleStatCmpt:GetLevelTotalRoundCount()
  local targetPos = self._targetPosAndRound[levelTotalRoundCount]
  if targetPos then
    self._targetPos = targetPos
    return
  end
  local monsterClassID = self.m_entityOwn:MonsterID():GetMonsterClassID()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    if not monsterEntity:HasDeadMark() then
      local targetMonsterClassID = monsterEntity:MonsterID():GetMonsterClassID()
      if targetMonsterClassID == monsterClassID then
        local buffCmpt = monsterEntity:BuffComponent()
        local targetPosAndRound = buffCmpt:GetBuffValue("ActionMoveSkillTargetCountMost") or {}
        local targetPos = targetPosAndRound[levelTotalRoundCount]
        if targetPos then
          self._targetPos = targetPos
          self._targetPosAndRound[levelTotalRoundCount] = self._targetPos
          return
        end
      end
    end
  end
  local skillID = self:GetLogicData(-1)
  if skillID == 0 then
    return
  end
  local posSelf = self.m_entityOwn:GetGridPosition()
  local aiCmpt = self.m_entityOwn:AI()
  local remainMobility = aiCmpt:GetMobilityValid()
  if remainMobility <= 0 then
    self._targetPos = posSelf
    return
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local blockFlag = boardServiceLogic:GetEntityMoveBlockFlag(self.m_entityOwn)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local fullScreenCalc = SkillScopeCalculator_FullScreen:New(skillCalculater)
  local scopeResult = fullScreenCalc:CalcRange(SkillScopeType.FullScreen, 1, posSelf, self.m_entityOwn:BodyArea():GetArea(), self.m_entityOwn:GetGridDirection(), SkillTargetType.Board, posSelf)
  local targetPosList = {}
  for _, pos in ipairs(scopeResult:GetAttackRange()) do
    local isBlock = boardServiceLogic:IsPosBlock(pos, blockFlag)
    if not isBlock then
      table.insert(targetPosList, pos)
    end
  end
  if not table.intable(targetPosList, posSelf) then
    table.insert(targetPosList, posSelf)
  end
  local bodyArea = self.m_entityOwn:BodyArea():GetArea()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local posAndTargrtCount = {}
  for _, pos in ipairs(targetPosList) do
    local skillResult = skillCalculater:CalcSkillScope(skillConfigData, pos, Vector2(0, 1), bodyArea)
    local targetType = skillConfigData:GetSkillTargetType()
    local targetArray = targetSelector:DoSelectSkillTarget(self.m_entityOwn, targetType, skillResult, skillID) or {}
    if targetArray and 0 < table.count(targetArray) then
      table.insert(posAndTargrtCount, {
        pos = pos,
        targetCount = table.count(targetArray)
      })
    end
  end
  if table.count(posAndTargrtCount) == 0 then
    self._targetPos = posSelf
    return
  end
  table.sort(posAndTargrtCount, function(a, b)
    return a.targetCount > b.targetCount
  end)
  local posAndTargrtCountSecend = {}
  if 0 < table.count(posAndTargrtCount) then
    local targetCount = posAndTargrtCount[1].targetCount
    for _, v in ipairs(posAndTargrtCount) do
      if v.targetCount == targetCount then
        table.insert(posAndTargrtCountSecend, v)
      end
    end
  end
  table.sort(posAndTargrtCountSecend, function(a, b)
    local disA = Vector2.Distance(a.pos, posSelf)
    local disB = Vector2.Distance(b.pos, posSelf)
    return disA < disB
  end)
  if 0 < table.count(posAndTargrtCountSecend) then
    self._targetPos = posAndTargrtCountSecend[1].pos
    if table.intable(posAndTargrtCountSecend, posSelf) then
      self._targetPos = posSelf
    end
  end
  self._targetPosAndRound[levelTotalRoundCount] = self._targetPos
  local curBuffCmpt = self.m_entityOwn:BuffComponent()
  curBuffCmpt:SetBuffValue("ActionMoveSkillTargetCountMost", self._targetPosAndRound)
end

function ActionMoveSkillTargetCountMost:FindNewTargetPos()
  return self._targetPos
end
