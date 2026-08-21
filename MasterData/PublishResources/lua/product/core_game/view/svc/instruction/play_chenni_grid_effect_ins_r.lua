require("base_ins_r")
_class("PlayChenNiGridEffectInstruction", BaseInstruction)
PlayChenNiGridEffectInstruction = PlayChenNiGridEffectInstruction

function PlayChenNiGridEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
end

function PlayChenNiGridEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local casterPos = casterEntity:GridLocation():GetGridPos()
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local scopeGridList = renderPickUpComponent:GetAllValidPickUpGridPos()
  local pickUpPos = scopeGridList[1]
  local dirType = scopeCalc:GetDirection(pickUpPos, casterPos)
  local scopeList, scopeListNEGPos = utilScopeSvc:CalcPickUpSingleLine(dirType, casterPos)
  table.Vector2Append(scopeList, scopeListNEGPos)
  table.insert(scopeList, casterPos)
  local effectService = world:GetService("Effect")
  local centerPos = utilScopeSvc:GetGridListCenterPos(scopeList)
  local effectPos = centerPos
  local effectDir
  if dirType == HitBackDirectionType.RightDown or dirType == HitBackDirectionType.LeftUp then
    effectDir = Vector2(1, -1)
  elseif dirType == HitBackDirectionType.Right or dirType == HitBackDirectionType.Left then
    effectDir = Vector2(1, 0)
  elseif dirType == HitBackDirectionType.Down or dirType == HitBackDirectionType.Up then
    effectDir = Vector2(0, 1)
  elseif dirType == HitBackDirectionType.RightUp or dirType == HitBackDirectionType.LeftDown then
    effectDir = Vector2(1, 1)
  end
  effectService:CreateWorldPositionDirectionEffect(self._effectID, effectPos, effectDir)
end

function PlayChenNiGridEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      10
    })
  end
  return t
end
