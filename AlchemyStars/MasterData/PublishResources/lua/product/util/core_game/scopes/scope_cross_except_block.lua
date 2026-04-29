require("scope_base")
_class("SkillScopeCalculator_CrossExceptBlock", SkillScopeCalculator_Base)
SkillScopeCalculator_CrossExceptBlock = SkillScopeCalculator_CrossExceptBlock

function SkillScopeCalculator_CrossExceptBlock:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local bReverse = false
  if casterEntity then
    local bPickToReverse = scopeParam[4] or 0
    if bPickToReverse == 1 then
      local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
      if activeSkillPickUpComponent then
        local pickCount = activeSkillPickUpComponent:GetAllValidPickUpGridPosCount()
        if 0 < pickCount then
          bReverse = true
        end
      else
        local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
        if previewPickUpComponent then
          local pickCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
          if 0 < pickCount then
            bReverse = true
          end
        end
      end
    end
  end
  local cross_area, wholeArea = self:_CalcCrossExceptBlock(scopeParam, centerPos, bodyArea, bReverse)
  local result = SkillScopeResult:New(SkillScopeType.CrossExceptBlock, casterPos, cross_area, wholeArea)
  return result
end
