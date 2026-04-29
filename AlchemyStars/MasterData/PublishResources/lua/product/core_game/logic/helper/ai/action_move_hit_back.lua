require("action_move_base")
_class("ActionMove_HitBack", ActionMoveBase)
ActionMove_HitBack = ActionMove_HitBack

function ActionMove_HitBack:Constructor()
  self:_Reset()
end

function ActionMove_HitBack:Reset()
  ActionMove_HitBack.super.Reset(self)
  self:_Reset()
end

function ActionMove_HitBack:_Reset()
  self.m_listPos_BombToPlayer = nil
  self.m_listPos_PlayerToBomb = nil
  self.m_listPos_HitPlayer = nil
  self.m_listPos_MoveToPlayer = nil
  self.m_listPos_MoveToBomb = nil
end

function ActionMove_HitBack:OnBegin()
  local entityCaster = self.m_entityOwn
  local aiCmpt = entityCaster:AI()
  if false == aiCmpt:CanMove() then
    self:PrintLog("启动移动<不允许>")
    return
  end
  local targetEntity = aiCmpt:GetTargetEntity()
  if targetEntity and targetEntity:HasGridLocation() then
    local nSkillID = self:GetLogicData(1)
    if nSkillID == 0 then
      return
    end
    local posSelf = entityCaster:GetGridPosition()
    local selfBodyArea = entityCaster:BodyArea():GetArea()
    local nValidMobility = aiCmpt:GetMobilityValid()
    local listWalkRange = self:ComputeWalkRange(posSelf, nValidMobility, true)
    local entityPlayer = aiCmpt:GetTargetDefault()
    local posPlayer = entityPlayer:GetGridPosition()
    local posTarget = aiCmpt:GetTargetPos()
    if targetEntity ~= entityPlayer then
      self.m_listPos_BombToPlayer = self:_InitBestPos_BombToPlayer(listWalkRange, selfBodyArea, nSkillID, posPlayer, posTarget)
      self.m_listPos_MoveToBomb = self:_InitBestPos_Target(selfBodyArea, nSkillID, posTarget)
    end
    self.m_listPos_PlayerToBomb = self:_InitBestPos_PlayerToBomb(listWalkRange, selfBodyArea, nSkillID, posPlayer)
    self.m_listPos_HitPlayer = self:_InitBestPos_HitPlayer(listWalkRange, selfBodyArea, nSkillID, posPlayer)
    self.m_listPos_MoveToPlayer = self:_InitBestPos_Target(selfBodyArea, nSkillID, posPlayer)
  else
    self:PrintLog("没有找到目标")
  end
end

function ActionMove_HitBack:FindNewTargetPos()
  local entityOwn = self.m_entityOwn
  local posSelf = entityOwn:GetGridPosition()
  local aiCmpt = entityOwn:AI()
  local posFind
  posFind = self:FindPosByNearCenter(self.m_listPos_BombToPlayer, posSelf, nil, nil)
  if posFind then
    self:PrintLog("击退炸弹到玩家", self:_MakePosString(posFind))
    return posFind
  end
  posFind = self:FindPosByNearCenter(self.m_listPos_PlayerToBomb, posSelf, nil, nil)
  if posFind then
    self:PrintLog("击退玩家到炸弹", self:_MakePosString(posFind))
    return posFind
  end
  posFind = self:FindPosByNearCenter(self.m_listPos_HitPlayer, posSelf, nil, nil)
  if posFind then
    self:PrintLog("击退玩家", self:_MakePosString(posFind))
    return posFind
  end
  posFind = self:FindPosByNearCenter(self.m_listPos_MoveToPlayer, posSelf, nil, nil)
  if posFind then
    self:PrintLog("移动到玩家", self:_MakePosString(posFind))
    return posFind
  end
  posFind = self:FindPosByNearCenter(self.m_listPos_MoveToBomb, posSelf, nil, nil)
  if posFind then
    self:PrintLog("移动到炸弹", self:_MakePosString(posFind))
    return posFind
  end
  local posTarget = aiCmpt:GetTargetPos()
  return posTarget
end

function ActionMove_HitBack:_FindWalkPosData(listWalkRange, posBaseWalk)
  for key, value in ipairs(listWalkRange) do
    if value.m_nPos == posBaseWalk then
      return value
    end
  end
  return nil
end

function ActionMove_HitBack:_FindHitStartPos(listWalkRange, listBodyArea, nSkillID, posHit, listTargetPos)
  local listPosPlan = {}
  local listPosAttack = self:_ComputeSkillRange(nSkillID, posHit, listBodyArea)
  for _, posBaseWalk in ipairs(listPosAttack) do
    for j, posTarget in ipairs(listTargetPos) do
      for i = 1, #listBodyArea do
        local posWork = posBaseWalk + listBodyArea[i]
        if posWork.x == posHit.x or posWork.y == posHit.y then
          if self:_IsOneLine(posWork, posHit, posTarget) then
            local posDataWalk = self:_FindWalkPosData(listWalkRange, posBaseWalk)
            if posDataWalk then
              table.insert(listPosPlan, posDataWalk)
            end
          end
          break
        end
      end
    end
  end
  return listPosPlan
end

function ActionMove_HitBack:_InitBestPos_BombToPlayer(listWalkRange, selfBodyArea, nSkillID, posPlayer, posBomb)
  return self:_FindHitStartPos(listWalkRange, selfBodyArea, nSkillID, posBomb, {posPlayer})
end

function ActionMove_HitBack:_InitBestPos_PlayerToBomb(listWalkRange, selfBodyArea, nSkillID, posPlayer)
  local utilSvc = self._world:GetService("TrapLogic")
  local listBomb = utilSvc:FindTrapByType(TrapType.BombByHitBack)
  local listBombPos = {}
  for i = 1, #listBomb do
    local posBomb = listBomb[i]:GetGridPosition()
    table.insert(listBombPos, posBomb)
  end
  return self:_FindHitStartPos(listWalkRange, selfBodyArea, nSkillID, posPlayer, listBombPos)
end

function ActionMove_HitBack:_InitBestPos_HitPlayer(listWalkRange, listBodyArea, nSkillID, posPlayer)
  local listPosPlan = {}
  local listPosAttack = self:_ComputeSkillRange(nSkillID, posPlayer, listBodyArea)
  for _, posBaseWalk in ipairs(listPosAttack) do
    local posDataWalk = self:_FindWalkPosData(listWalkRange, posBaseWalk)
    if posDataWalk then
      table.insert(listPosPlan, posDataWalk)
    end
  end
  return listPosPlan
end

function ActionMove_HitBack:_InitBestPos_Target(listBodyArea, nSkillID, posTarget)
  local listPosPlan = {}
  local listPosAttack = self:_ComputeSkillRange(nSkillID, posTarget, listBodyArea)
  for _, posBaseWalk in ipairs(listPosAttack) do
    local posData = ComputeWalkPos:New(posBaseWalk, 1)
    table.insert(listPosPlan, posData)
  end
  return listPosPlan
end

_class("PosSortByDir", Object)
PosSortByDir = PosSortByDir

function PosSortByDir:Constructor(posBase, posTarget, posWork, nIndex)
  self.m_dirBase = self.ComputeDir_Normalize(posTarget, posBase)
  self.m_dirWork = self.ComputeDir_Normalize(posBase, posWork)
  self.m_angle = self.ComputeAngle(self.m_dirBase, self.m_dirWork)
  self.m_posWork = posWork
  self.m_nIndex = nIndex
end

function PosSortByDir.ComputeDir_Normalize(posA, posB)
  local posDir = posA - posB
  return posDir.normalized
end

function PosSortByDir.ComputeAngle(dirA, dirB)
  return dirA.x * dirB.x + dirA.y * dirB.y
end

function PosSortByDir:GetPosWork()
  return self.m_posWork
end

function PosSortByDir._ComparerByDir(dataA, dataB)
  local nDistanceA = dataA.m_angle
  local nDistanceB = dataB.m_angle
  if nDistanceA > nDistanceB then
    return 1
  elseif nDistanceA < nDistanceB then
    return -1
  else
    return dataB.m_nIndex - dataA.m_nIndex
  end
end
