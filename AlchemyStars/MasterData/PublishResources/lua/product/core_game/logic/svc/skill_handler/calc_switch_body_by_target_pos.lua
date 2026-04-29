require("switch_body_area_dir_type")
_class("SkillEffectCalc_SwitchBodyAreaByTargetPos", Object)
SkillEffectCalc_SwitchBodyAreaByTargetPos = SkillEffectCalc_SwitchBodyAreaByTargetPos

function SkillEffectCalc_SwitchBodyAreaByTargetPos:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_SwitchBodyAreaByTargetPos:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local targetIDList = skillEffectCalcParam:GetTargetEntityIDs()
  local targetID = false
  if table.count(targetIDList) >= 1 then
    targetID = targetIDList[1]
  end
  if not targetID or targetID == -1 then
    Log.fatal("Need Target SkillID", skillEffectCalcParam:GetSkillID())
  end
  local targetEntity = self._world:GetEntityByID(targetID)
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local type = param:GetType()
  local newBodyArea, newDir
  local switchBodyType = SwitchBodyAreaDirType.None
  if type == SwitchBodyAreaType.TailFlick then
    newDir, newBodyArea, switchBodyType = utilScopeSvc:GetTailFlickSwitchBodyArea(casterEntity, targetEntity)
  elseif type == SwitchBodyAreaType.CounterAttack then
    newDir, newBodyArea, switchBodyType = utilScopeSvc:GetCounterAttackSwitchBodyArea(casterEntity, targetEntity)
  elseif type == SwitchBodyAreaType.ByCasterDir then
    newDir, newBodyArea = self:RefreshBodyAreaByCasterDir(casterEntity)
  elseif type == SwitchBodyAreaType.AfterTransformation then
    newDir, newBodyArea = self:GetValidBodyAreaAfterTransformation(casterEntity)
  elseif type == SwitchBodyAreaType.CoffinMusume then
    newDir, newBodyArea, switchBodyType = self:GetCoffinMusumeBodyArea(casterEntity, targetEntity)
  end
  local casterPos = casterEntity:GetGridPosition()
  local bodyAreaCmpt = casterEntity:BodyArea()
  local bodyArea = bodyAreaCmpt:GetArea()
  local oldBodyAreaPos = casterPos + bodyArea[1]
  local result = SkillEffectSwitchBodyAreaByTargetPosResult:New(newDir, newBodyArea, switchBodyType, oldBodyAreaPos, bodyArea)
  local sBoard = self._world:GetService("BoardLogic")
  local _, blockFlag = sBoard:RemoveEntityBlockFlag(casterEntity, casterPos)
  casterEntity:SetGridDirection(newDir)
  casterEntity:ReplaceBodyArea(newBodyArea)
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(NTBodyAreaChange:New(casterEntity))
  sBoard:SetEntityBlockFlag(casterEntity, casterPos, blockFlag)
  return {result}
end

function SkillEffectCalc_SwitchBodyAreaByTargetPos:RefreshBodyAreaByCasterDir(casterEntity)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local dirType = utilScopeSvc:GetEntityDirType(casterEntity)
  local bodyArea = utilScopeSvc:GetNewBodyAreaByDirType(dirType)
  local dir = casterEntity:GetGridDirection()
  return dir, {
    Vector2(0, 0),
    bodyArea
  }
end

function SkillEffectCalc_SwitchBodyAreaByTargetPos:GetValidBodyAreaAfterTransformation(casterEntity)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local casterPos = casterEntity:GetGridPosition()
  local bodyAreaCmpt = casterEntity:BodyArea()
  local bodyArea = bodyAreaCmpt:GetArea()
  local bodyAreaPos = casterPos + bodyArea[1]
  if utilScopeSvc:IsValidPiecePos(bodyAreaPos) then
    local dir = utilScopeSvc:GetVectorDirByBodyArea(casterEntity)
    return dir, bodyArea
  end
  local retDir
  local retBodyArea = {
    Vector2(0, 0)
  }
  local dirTypeList = {
    DirectionType.Up,
    DirectionType.Right,
    DirectionType.Down,
    DirectionType.Left
  }
  for i, dirType in ipairs(dirTypeList) do
    local area = utilScopeSvc:GetNewBodyAreaByDirType(dirType)
    if utilScopeSvc:IsValidPiecePos(casterPos + area) then
      retDir = utilScopeSvc:GetDirByDirType(dirType)
      table.insert(retBodyArea, area)
      return retDir, retBodyArea
    end
  end
end

function SkillEffectCalc_SwitchBodyAreaByTargetPos:GetCoffinMusumeBodyArea(casterEntity, targetEntity)
  local casterGridCenterPos = casterEntity:GetGridPosition()
  local targetPos = targetEntity:GetGridPosition()
  local relative = targetPos - casterGridCenterPos
  local oldGridDir = casterEntity:GetGridDirection()
  local oldBodyArea = casterEntity:BodyArea():GetArea()
  if oldGridDir == Vector2.up then
    relative = Vector2.New(relative.x * -1, relative.y * -1)
  elseif oldGridDir == Vector2.left then
    relative = Vector2.New(relative.y * -1, relative.x)
  elseif oldGridDir == Vector2.right then
    relative = Vector2.New(relative.y, relative.x * -1)
  end
  local newGridDir = oldGridDir
  local newBodyArea = {}
  local dirType = SwitchBodyAreaDirType.None
  if relative.x <= 1 and relative.x >= -1 and relative.y < 0 then
    return oldGridDir, oldBodyArea, SwitchBodyAreaDirType.None
  elseif relative.x > 0 and relative.y <= 1 and -1 <= relative.y then
    for _, v2 in ipairs(oldBodyArea) do
      table.insert(newBodyArea, Vector2.New(v2.y * -1, v2.x))
    end
    newGridDir = Vector2.New(oldGridDir.y * -1, oldGridDir.x)
    dirType = SwitchBodyAreaDirType.Left
  elseif relative.x < 0 and relative.y <= 1 and -1 <= relative.y then
    for _, v2 in ipairs(oldBodyArea) do
      table.insert(newBodyArea, Vector2.New(v2.y, v2.x * -1))
    end
    newGridDir = Vector2.New(oldGridDir.y, oldGridDir.x * -1)
    dirType = SwitchBodyAreaDirType.Right
  else
    for _, v2 in ipairs(oldBodyArea) do
      table.insert(newBodyArea, Vector2.New(v2.x * -1, v2.y * -1))
    end
    newGridDir = Vector2.New(oldGridDir.x * -1, oldGridDir.y * -1)
    dirType = SwitchBodyAreaDirType.Turn
  end
  if self._world:RunAtClient() and HelperProxy:GetInstance():IsDebug() then
    local casterPos = casterEntity:GetGridPosition()
    local oldBodyAreaStrTable = {}
    for _, v2 in ipairs(oldBodyArea) do
      table.insert(oldBodyAreaStrTable, (v2 + casterPos):IntegerStr())
    end
    local newBodyAreaStrTable = {}
    for _, v2 in ipairs(newBodyArea) do
      table.insert(newBodyAreaStrTable, (v2 + casterPos):IntegerStr())
    end
    Log.info("[CoffinMusume] switch body from : ", table.concat(oldBodyAreaStrTable), " to ", table.concat(newBodyAreaStrTable))
    Log.info("[CoffinMusume] oldGridDir = ", tostring(oldGridDir), " newGridDir = ", tostring(newGridDir), " dirType = ", GetEnumKey("SwitchBodyAreaDirType", dirType))
  end
  return newGridDir, newBodyArea, dirType
end
