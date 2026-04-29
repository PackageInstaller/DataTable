require("sp_base_inst")
_class("SkillPreviewPlayTargetHitBackInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayTargetHitBackInstruction = SkillPreviewPlayTargetHitBackInstruction

function SkillPreviewPlayTargetHitBackInstruction:Constructor(params)
  self._casterPosBlock = params.casterPosBlock
end

function SkillPreviewPlayTargetHitBackInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeGridList = previewContext:GetScopeResult()
  local previewEffectCalcService = self._world:GetService("PreviewCalcEffect")
  local effect = previewContext:GetEffect(SkillEffectType.HitBack)
  local targetIDList = table.unique(previewContext:GetTargetEntityIDList())
  local previewIndex = previewActiveSkillService:GetPreviewIndex()
  local hitBackDirType = previewContext:GetHitBackDirType()
  local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.HitBack, effect)
  local enableByPickNum = effectParam:GetEnableByPickNum()
  if enableByPickNum then
    local checkNum = tonumber(enableByPickNum)
    local attacker = casterEntity
    local component = attacker:PreviewPickUpComponent()
    if component then
      local curPickNum = component:GetAllValidPickUpGridPosCount()
      if curPickNum ~= checkNum then
        return
      end
    end
  end
  hitBackDirType = hitBackDirType or effectParam:GetDirType()
  local posPickup = previewContext:GetPickUpPos()
  if not posPickup or effectParam:GetForceUseCasterPos() then
  else
    previewContext:SetCasterPos(posPickup)
  end
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local pickList = previewPickUpComponent and previewPickUpComponent:GetAllValidPickUpGridPos() or {}
  if 0 < #pickList then
    local usePickPosIndex = effectParam:GetUsePickPosIndex()
    if effectParam:GetForceUseCasterPos() then
    elseif usePickPosIndex and 0 < usePickPosIndex and usePickPosIndex <= #pickList then
      previewContext:SetCasterPos(pickList[usePickPosIndex])
    end
  end
  local casterPos = previewContext:GetCasterPos()
  utilScopeSvc:SortHitbackTargetByDirType(targetIDList, hitBackDirType, casterPos)
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if self._casterPosBlock then
    env:DelEntityBlockFlag(casterEntity, casterEntity:GridLocation():GetGridPos())
  end
  for _, targetID in ipairs(targetIDList) do
    local result = previewEffectCalcService:CalcHitBack(casterEntity, scopeGridList, targetID, previewContext, effectParam)
    self:_DoHitBack(result, previewIndex, targetID)
  end
end

function SkillPreviewPlayTargetHitBackInstruction:_DoHitBack(result, previewIndex, targetID)
  if not result then
    return
  end
  if not result:GetHitDir() then
    return
  end
  local enemyEntity = self._world:GetEntityByID(targetID)
  local entitySvc = self._world:GetService("RenderEntity")
  local ghostEntity = entitySvc:CreateGhost(enemyEntity:GridLocation().Position, enemyEntity)
  local boardServiceRender = self._world:GetService("BoardRender")
  local startPos = boardServiceRender:GetRealEntityGridPos(enemyEntity)
  local targetPos = result:GetGridPos()
  ghostEntity:SetGridPosition(targetPos)
  ghostEntity:AddHitback(startPos, BattleConst.HitbackSpeed, targetPos, result:GetHitDir())
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if enemyEntity:HasPet() then
    enemyEntity = enemyEntity:Pet():GetOwnerTeamEntity()
  end
  local ghostBlock = env:GetEntityBlockFlag(enemyEntity)
  for _, area in ipairs(enemyEntity:BodyArea():GetArea()) do
    local blockData = env:GetPosBlockData(targetPos + area)
    blockData:AddBlock(enemyEntity:GetID(), ~BlockFlag.LinkLine & ghostBlock)
  end
end
