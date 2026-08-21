require("scope_base")
_class("SkillScopeCalculator_TargetUnderFoot", SkillScopeCalculator_Base)
SkillScopeCalculator_TargetUnderFoot = SkillScopeCalculator_TargetUnderFoot

function SkillScopeCalculator_TargetUnderFoot:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local bodyAreaArray = bodyArea
  local param = scopeParam
  local world = self._gridFilter._world
  local bodyAreaPosList = {}
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local isHasMonster, monsterID = utilScopeSvc:IsPosHasMonster(centerPos)
  if isHasMonster then
    local monsterEntity = world:GetEntityByID(monsterID)
    local buffComponent = monsterEntity:BuffComponent()
    if not buffComponent:HasBuffEffect(BuffEffectType.NotBeSelectedAsSkillTarget) then
      local bodyAreaList = monsterEntity:BodyArea():GetArea()
      local gridPos = monsterEntity:GridLocation():GetGridPos()
      for _, bodyArea in ipairs(bodyAreaList) do
        local workPos = gridPos + bodyArea
        table.insert(bodyAreaPosList, workPos)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.TargetUnderFoot, centerPos, bodyAreaPosList, bodyAreaPosList)
  return result
end
