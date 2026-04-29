require("scope_base")
_class("SkillScopeCalculator_ScopeByPickNum", SkillScopeCalculator_Base)
SkillScopeCalculator_ScopeByPickNum = SkillScopeCalculator_ScopeByPickNum

function SkillScopeCalculator_ScopeByPickNum:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local curPickNum = 0
  if type(centerPos) == "table" then
    curPickNum = #centerPos
  elseif centerPos then
    centerPos = {centerPos}
    curPickNum = 1
  else
    centerPos = {}
  end
  local bodyAreaArray = bodyArea
  local param = scopeParam
  local world = self._gridFilter._world
  local attackRangeList = {}
  local wholeRangeList = {}
  local scopeIndex = curPickNum + 1
  local useLastAsDefault = scopeParam.useLastAsDefault
  if useLastAsDefault and scopeIndex > #scopeParam then
    scopeIndex = #scopeParam
  end
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  if scopeIndex <= #scopeParam then
    local scope = scopeParam[scopeIndex]
    local _scopeType = scope.scopeType
    if _scopeType then
      local _scope_param = scope.scopeParam
      local _scope_centerPosIndex = scope.centerPosIndex
      local useCasterPos = scope.useCasterPos
      local transCenterPos = centerPos
      if useCasterPos then
        transCenterPos = casterPos
      elseif _scope_centerPosIndex then
        if _scope_centerPosIndex == 0 then
          transCenterPos = centerPos
        elseif _scope_centerPosIndex == -1 then
          transCenterPos = centerPos[#centerPos]
        else
          transCenterPos = centerPos[_scope_centerPosIndex]
        end
      end
      local checkOk = true
      local centerPosCheckTrapID = scope.centerPosCheckTrapID
      if centerPosCheckTrapID and not self:_CheckPosHasTrap(transCenterPos, centerPosCheckTrapID) then
        checkOk = false
      end
      if checkOk then
        local result = calc:ComputeScopeRange(_scopeType, _scope_param, transCenterPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
        attackRangeList = result:GetAttackRange()
        wholeRangeList = result:GetWholeGridRange()
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.ScopeByPickNum, centerPos, attackRangeList, wholeRangeList)
  return result
end

function SkillScopeCalculator_ScopeByPickNum:_CheckPosHasTrap(pos, trapID)
  local bFindTrap = false
  local world = self._gridFilter._world
  local utilSvc = world:GetService("UtilData")
  local array = utilSvc:GetTrapsAtPos(pos)
  for _, eTrap in ipairs(array) do
    local cTrap = eTrap:Trap()
    if cTrap and not eTrap:HasDeadMark() and cTrap:GetTrapID() == trapID then
      bFindTrap = true
      break
    end
  end
  return bFindTrap
end
