_class("SkillEffectCalc_MoyeMove", Object)
SkillEffectCalc_MoyeMove = SkillEffectCalc_MoyeMove

function SkillEffectCalc_MoyeMove:Constructor(world)
  self._world = world
end

function SkillEffectCalc_MoyeMove:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local activeSkillPickUpCmpt = casterEntity:ActiveSkillPickUpComponent()
  if not activeSkillPickUpCmpt then
    return
  end
  local chainPath = activeSkillPickUpCmpt:GetAllValidPickUpGridPos()
  local linkCount = #chainPath
  if linkCount <= 1 then
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local remoteTeamPos
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local remoteTeam = self._world:Player():GetRemoteTeamEntity()
    if remoteTeam then
      remoteTeamPos = remoteTeam:GetGridPosition()
    end
  end
  local finalPos
  for i = #chainPath, 1, -1 do
    local isOccupied = utilDataSvc:IsHaveEntity(chainPath[i], EnumTargetEntity.Monster | EnumTargetEntity.Pet)
    if not isOccupied and remoteTeamPos ~= chainPath[i] then
      finalPos = chainPath[i]
      break
    end
  end
  finalPos = finalPos or self:_GetAroundValidGrid(chainPath[#chainPath])
  finalPos = finalPos or casterEntity:GetGridPosition()
  local effectResult = SkillEffectResultMoyeMove:New()
  local teleportRes = self:CalculateTeleportResult(skillEffectCalcParam, finalPos)
  effectResult:SetTeleportResult(teleportRes)
  return {effectResult}
end

function SkillEffectCalc_MoyeMove:CalculateTeleportResult(skillEffectCalcParam, finalPos)
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local pieceType = param:GetConvertType()
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local casterPos = casterEntity:GetGridPosition():Clone()
  if not pieceType then
    local boardServiceLogic = self._world:GetService("BoardLogic")
    boardServiceLogic:RemoveEntityBlockFlag(casterEntity, casterPos)
    pieceType = boardServiceLogic:SupplyPieceList({casterPos})[1].color
  end
  local dir = casterEntity:GetGridDirection():Clone()
  local result = SkillEffectResult_Teleport:New(casterEntityID, casterPos, pieceType, finalPos, dir)
  return result
end

function SkillEffectCalc_MoyeMove:_GetAroundValidGrid(grid)
  local around = {
    {-1, -1},
    {-1, 0},
    {-1, 1},
    {0, 1},
    {1, 1},
    {1, 0},
    {1, -1},
    {0, -1}
  }
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local finded = false
  for _, offset in ipairs(around) do
    local targetGrid = grid + offset
    if not boardServiceLogic:IsPosBlock(targetGrid, BlockFlag.LinkLine) then
      finded = true
      return targetGrid
    end
  end
  if not finded then
    if not self._index then
      self._index = 0
    end
    self._index = self._index + 1
    if self._index > #around then
      self._index = #around
    end
    self:_GetAroundValidGrid(grid + around[self._index])
  end
end
