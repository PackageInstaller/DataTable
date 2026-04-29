require("action_move_base")
_class("ActionMoveGroup", ActionMoveBase)
ActionMoveGroup = ActionMoveGroup

function ActionMoveGroup:Constructor()
  self.m_nextPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  self.m_nextPosList:AllowDuplicate()
end

function ActionMoveGroup:Reset()
  ActionMoveGroup.super.Reset(self)
  self.m_nextPosList:Clear()
  self:GetAllGroupMonster()
end

function ActionMoveGroup:CheckCanMove()
  for _, monster in ipairs(self._sameGroupMonsterList) do
    local aiCmpt = monster:AI()
    if not aiCmpt:CanMove() then
      return false
    end
  end
  return true
end

function ActionMoveGroup:FindGroupMoveEntity()
  local maxGroupMoveMonsterEntity
  local maxGroupMoveCount = 0
  local aiRecorderCmpt = self._world:GetBoardEntity():AIRecorder()
  local isSameStep = true
  local firstStep = -1
  local noMoveCount = 0
  for _, monster in ipairs(self._sameGroupMonsterList) do
    local collection = aiRecorderCmpt:FindWalkResultByCasterID(monster:GetID())
    if collection then
      if maxGroupMoveCount < #collection:GetWalkResultList() then
        maxGroupMoveCount = #collection:GetWalkResultList()
        maxGroupMoveMonsterEntity = monster
      end
      if firstStep == -1 then
        firstStep = #collection:GetWalkResultList()
      elseif firstStep ~= #collection:GetWalkResultList() then
        Log.fatal("全都动过,有一个多走一格")
        isSameStep = false
      end
    else
      noMoveCount = noMoveCount + 1
    end
  end
  if isSameStep and noMoveCount ~= 0 and noMoveCount ~= #self._sameGroupMonsterList then
    Log.fatal("有动过有没动")
    isSameStep = false
  end
  if isSameStep then
    return
  end
  return maxGroupMoveMonsterEntity
end

function ActionMoveGroup:BeforeCalcMovePos()
  local sBoard = self._world:GetService("BoardLogic")
  for _, monster in ipairs(self._sameGroupMonsterList) do
    if monster:GetID() ~= self.m_entityOwn:GetID() then
      sBoard:RemoveEntityBlockFlag(monster, monster:GetGridPosition())
    end
  end
end

function ActionMoveGroup:AfterCalcMovePos()
  local sBoard = self._world:GetService("BoardLogic")
  for _, monster in ipairs(self._sameGroupMonsterList) do
    if monster:GetID() ~= self.m_entityOwn:GetID() then
      sBoard:SetEntityBlockFlag(monster, monster:GetGridPosition())
    end
  end
end

function ActionMoveGroup:GetFakeBodyArea()
  local bodyArea = {
    Vector2(0, 0)
  }
  local posSelf = self.m_entityOwn:GridLocation().Position
  for i, monster in ipairs(self._sameGroupMonsterList) do
    if monster:GetID() ~= self.m_entityOwn:GetID() then
      local offset = monster:GetGridPosition() - posSelf
      table.insert(bodyArea, offset)
    end
  end
  return bodyArea
end

function ActionMoveGroup:InitTargetPosList(listPosTarget)
  self:BeforeCalcMovePos()
  local posSelf = self.m_entityOwn:GetGridPosition()
  local nSkillID = self:GetLogicData(1)
  local cSkillID = self:GetLogicData(-1)
  if cSkillID then
    nSkillID = cSkillID
  end
  local selfBodyArea = self.m_entityOwn:BodyArea():GetArea()
  if nSkillID <= 0 then
    return
  end
  local range = {}
  self.m_nextPosList:Clear()
  for _, targetPos in ipairs(listPosTarget) do
    local walkRange = self:_ComputeSkillRange(nSkillID, targetPos, selfBodyArea)
    for i = 1, #walkRange do
      local posWork = walkRange[i]
      if self:IsPosAccessible(posWork) then
        range[#range + 1] = Vector2.Pos2Index(posWork)
        AINewNode.InsertSortedArray(self.m_nextPosList, posSelf, posWork, i)
      end
    end
  end
  self:AfterCalcMovePos()
  self:PrintDebugLog("MoveRange=", table.concat(range, " "))
end

function ActionMoveGroup:FindNewTargetPos()
  local posDefault = self.m_entityOwn:AI():GetTargetPos()
  return self:FindPosValid(self.m_nextPosList, posDefault)
end

function ActionMoveGroup:_CalcMovePos(entityWork)
  local aiComponent = entityWork:AI()
  local posSelf = entityWork:GridLocation().Position
  local sameGroupMoveEntity = self:FindGroupMoveEntity()
  if sameGroupMoveEntity then
    local groupMoveEntityAICmpt = sameGroupMoveEntity:AI()
    local groupMoveEntityOldPos = groupMoveEntityAICmpt:GetLastMovePos()
    local groupMoveEntityCurPos = sameGroupMoveEntity:GetGridPosition()
    local offset = groupMoveEntityOldPos - posSelf
    local posWalk = groupMoveEntityCurPos - offset
    self:PrintLog("同组怪物移动过 Pos=", self:_MakePosString(groupMoveEntityCurPos), "Offset:", self:_MakePosString(offset), "  ", self:_MakePosString(posSelf), ">===>", self:_MakePosString(posWalk))
    self:PrintDebugLog("同组怪物移动过 Pos=", self:_MakePosString(groupMoveEntityCurPos), "Offset:", self:_MakePosString(offset), "  ", self:_MakePosString(posSelf), ">===>", self:_MakePosString(posWalk))
    Log.fatal("MonsterID:", entityWork:GetID(), " GroupID:", self:GetMonsterGroupID(), "同组怪物移动过 Pos=", self:_MakePosString(groupMoveEntityCurPos), "Offset:", self:_MakePosString(offset), "  ", self:_MakePosString(posSelf), ">===>", self:_MakePosString(posWalk))
    return posWalk
  else
    local posTarget = self:FindNewTargetPos()
    self.m_posTarget = posTarget
    if posSelf == posTarget then
      self:PrintLog("不需要移动，当前就是目标坐标", self:_MakePosString(posSelf))
      self:PrintDebugLog("不需要移动，当前就是目标坐标", self:_MakePosString(posSelf))
      Log.fatal("MonsterID:", entityWork:GetID(), " GroupID:", self:GetMonsterGroupID(), "不需要移动，当前就是目标坐标", self:_MakePosString(posSelf))
      return nil
    end
    local nWalkTotal = aiComponent:GetMobilityValid()
    local posWalkList = self:ComputeWalkRange(posSelf, nWalkTotal, true)
    local posWalk = self:FindNewWalkPos(posWalkList, posTarget, posSelf)
    if posWalk and posWalk == posSelf then
      self:PrintLog("不需要移动 ", self:_MakePosString(posSelf), ">===>", self:_MakePosString(posWalk))
      self:PrintDebugLog("不需要移动 ", self:_MakePosString(posSelf), ">===>", self:_MakePosString(posWalk))
      Log.fatal("MonsterID:", entityWork:GetID(), " GroupID:", self:GetMonsterGroupID(), "不需要移动 ", self:_MakePosString(posSelf), ">===>", self:_MakePosString(posWalk))
      return nil
    end
    self:PrintDebugLog("移动到", self:_MakePosString(posWalk))
    Log.fatal("MonsterID:", entityWork:GetID(), " GroupID:", self:GetMonsterGroupID(), "移动到", self:_MakePosString(posWalk))
    return posWalk
  end
end
