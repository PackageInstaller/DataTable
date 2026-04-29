_class("SkillEffectCalc_TeleportAndTurnBodyArea", Object)
SkillEffectCalc_TeleportAndTurnBodyArea = SkillEffectCalc_TeleportAndTurnBodyArea

function SkillEffectCalc_TeleportAndTurnBodyArea:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_TeleportAndTurnBodyArea:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local utilData = self._world:GetService("UtilData")
  local sourcePos = casterEntity:GetGridPosition()
  local stageIndex = skillEffectCalcParam.skillEffectParam:GetSkillEffectDamageStageIndex()
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local ignoreBlock = param:IsIgnoreBlock()
  local fixedPos = param:GetFixedPosList()
  local targetID = targets[1]
  local targetEntity = self._world:GetEntityByID(targetID)
  local boardSvc = self._world:GetService("BoardLogic")
  boardSvc:RemovePosBlock(casterEntity, sourcePos, BlockFlag.MonsterLand)
  local pos, dir = self:FindPosAndDir(targetEntity, fixedPos, ignoreBlock)
  local newBodyArea = self:ChangeBodyAreaByDir(dir)
  boardSvc:SetEntityBlockFlag(casterEntity, pos, BlockFlag.MonsterLand)
  local gridOffSet, damageOffSet = self:GetOffsetByDirType(dir)
  casterEntity:SetGridOffsetAndDamageOffset(gridOffSet, damageOffSet)
  local colorOld = utilData:FindPieceElement(sourcePos)
  local vDir = self:GetDirByDirType(dir)
  local skillEffectResultChangeBodyArea = SkillEffectResultChangeBodyArea:New(casterEntity:GetID(), newBodyArea)
  table.insert(results, skillEffectResultChangeBodyArea)
  local result = SkillEffectResult_Teleport:New(skillEffectCalcParam.casterEntityID, sourcePos, colorOld, pos, vDir, stageIndex)
  table.insert(results, result)
  return results
end

function SkillEffectCalc_TeleportAndTurnBodyArea:FindPosAndDir(targetEntity, fixedPosData, ignoreBlock)
  local pos = targetEntity:GetGridPosition()
  local dir = targetEntity:GetGridDirection()
  local bodyArea = targetEntity:BodyArea():GetArea()
  local boardSvc = self._world:GetService("BoardLogic")
  local minDisCount = 1
  local newPos = pos
  local newDir = dir
  for index, v in ipairs(fixedPosData) do
    local disCount = 0
    local vPos = v.pos
    local vDir = v.dir
    local vBodyArea = self:GetBodyAreaByDir(vDir)
    for _, body in ipairs(vBodyArea) do
      local tPos = vPos + body
      if boardSvc:IsPosBlock(tPos, BlockFlag.MonsterLand) and not ignoreBlock then
        disCount = disCount - 10000
      else
        disCount = disCount + Vector2.Distance(tPos, pos)
      end
    end
    if minDisCount < disCount then
      minDisCount = disCount
      newPos = vPos
      newDir = vDir
    end
  end
  return newPos, newDir
end

function SkillEffectCalc_TeleportAndTurnBodyArea:GetBodyAreaByDir(dir)
  return _G.DirectionalRelativePosMap[DirectionalRelativePosMapType.Classical6Grid][dir]
end

function SkillEffectCalc_TeleportAndTurnBodyArea:GetOffsetByDirType(dir)
  if dir == 1 then
    return Vector2(1, 0), Vector2(1, 0)
  elseif dir == 2 then
    return Vector2(0, 1), Vector2(0, 1)
  elseif dir == 3 then
    return Vector2(1, 1), Vector2(1, 1)
  elseif dir == 4 then
    return Vector2(1, 1), Vector2(1, 1)
  end
end

function SkillEffectCalc_TeleportAndTurnBodyArea:GetDirByDirType(dir)
  if dir == 1 then
    return Vector2(0, -1)
  elseif dir == 2 then
    return Vector2(-1, 0)
  elseif dir == 3 then
    return Vector2(0, 1)
  elseif dir == 4 then
    return Vector2(1, 0)
  end
end

function SkillEffectCalc_TeleportAndTurnBodyArea:ChangeBodyAreaByDir(dir)
  local bodyAreaList = _G.DirectionalRelativePosMap[DirectionalRelativePosMapType.Classical6Grid][dir]
  local ret = {}
  for i, pos in ipairs(bodyAreaList) do
    local n = Vector2(pos.x, pos.y)
    table.insert(ret, n)
  end
  return ret
end
