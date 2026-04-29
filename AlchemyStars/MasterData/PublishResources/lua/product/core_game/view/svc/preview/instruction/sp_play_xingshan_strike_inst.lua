require("sp_base_inst")
_class("SkillPreviewXingshanStrikeInstruction", SkillPreviewBaseInstruction)
SkillPreviewXingshanStrikeInstruction = SkillPreviewXingshanStrikeInstruction

function SkillPreviewXingshanStrikeInstruction:Constructor(param)
  self._teleportScopeCfg = {
    TargetType = tonumber(param.teleportScopeTargetType),
    ScopeType = tonumber(param.teleportScopeType),
    ScopeParam = {
      tonumber(param.teleportScopeParam)
    },
    ScopeCenterType = tonumber(param.teleportScopeCenterType)
  }
  self._damageScopeCfg = {
    TargetType = tonumber(param.damageScopeTargetType),
    ScopeType = tonumber(param.damageScopeType),
    ScopeParam = {
      tonumber(param.damageScopeParam)
    },
    ScopeCenterType = tonumber(param.damageScopeCenterType)
  }
end

function SkillPreviewXingshanStrikeInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local configSvc = world:GetService("Config")
  local helper = configSvc._skillConfigHelper
  local parser = helper._scopeParamParser
  local previewTeleportScopeParam = SkillPreviewScopeParam:New(self._teleportScopeCfg)
  local teleportSParam = parser:ParseScopeParam(self._teleportScopeCfg.ScopeType, self._teleportScopeCfg.ScopeParam)
  previewTeleportScopeParam:SetScopeParamData(teleportSParam)
  local previewDamageScopeParam = SkillPreviewScopeParam:New(self._damageScopeCfg)
  local damageSParam = parser:ParseScopeParam(self._damageScopeCfg.ScopeType, self._damageScopeCfg.ScopeParam)
  previewDamageScopeParam:SetScopeParamData(damageSParam)
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local tv2Pick = previewPickUpComponent:GetAllValidPickUpGridPos()
  local v2Pickup = tv2Pick[1] or casterEntity:GetGridPosition()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  local dirNew = v2Pickup - casterEntity:GetGridPosition()
  if dirNew.x > 0 then
    dirNew.x = 1
  elseif dirNew.x < 0 then
    dirNew.x = -1
  end
  if 0 < dirNew.y then
    dirNew.y = 1
  elseif 0 > dirNew.y then
    dirNew.y = -1
  end
  casterEntity:SetDirection(dirNew)
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local teleportScopeResult = utilScopeSvc._skillScopeCalc:CalcSkillPreviewScope(casterEntity:GetGridPosition(), dirNew, casterBodyArea, previewTeleportScopeParam, casterEntity)
  local teleportPos = self:_FindTeleportPos_Comparer(casterEntity, casterEntity:GetGridPosition(), teleportScopeResult:GetAttackRange())
  teleportPos = teleportPos or casterEntity:GetGridPosition()
  local damageScopeResult = utilScopeSvc._skillScopeCalc:CalcSkillPreviewScope(teleportPos, dirNew, casterBodyArea, previewDamageScopeParam, casterEntity)
  if teleportPos ~= casterEntity:GetGridPosition() then
    local entitySvc = world:GetService("RenderEntity")
    entitySvc:CreateGhost(teleportPos, casterEntity, "AtkUltPreview")
  end
  previewActiveSkillService:AllPieceDoConvert("Dark")
  previewActiveSkillService:DoAnim(damageScopeResult:GetAttackRange(), "Silver")
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local targetIDList = utilScopeSvc:SelectSkillTarget(casterEntity, previewDamageScopeParam:GetScopeTargetType(), damageScopeResult)
  targetIDList = table.unique(targetIDList)
  for _, id in pairs(targetIDList) do
    local entity = world:GetEntityByID(id)
    if entity and entity:HasTeam() then
      entity = entity:GetTeamLeaderPetEntity()
    end
    if entity and entity:HasMaterialAnimationComponent() and not entity:BuffView():HasBuffEffect(BuffEffectType.NotPlayMaterialAnimation) then
      entity:NewEnableFlashAlpha()
    end
  end
end

function SkillPreviewXingshanStrikeInstruction:_FindTeleportPos_Comparer(entityCaster, posCenter, skillRangePos)
  local world = entityCaster:GetOwnerWorld()
  if nil == skillRangePos then
    return posCenter
  end
  local listRangeInPlan = skillRangePos
  local entityMain = world:Player():GetPreviewTeamEntity()
  local posMain = entityMain:GetGridPosition()
  local boardServiceLogic = world:GetService("BoardLogic")
  local sortPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByFar)
  sortPosList:AllowDuplicate()
  for i = 1, #skillRangePos do
    AINewNode.InsertSortedArray(sortPosList, posMain, skillRangePos[i], i)
  end
  local bodyArea = entityCaster:BodyArea():GetArea()
  local skillEffectCalcService = world:GetService("SkillEffectCalc")
  local nBlockRaceType = BlockFlag.LinkLine
  for i = 1, sortPosList:Size() do
    local sortPosData = sortPosList:GetAt(i)
    local posWork = sortPosData.data
    local bPosBlock = boardServiceLogic:IsPosBlockByArea(posWork, nBlockRaceType, bodyArea, entityCaster)
    if not bPosBlock then
      return posWork
    end
  end
  return posCenter
end
