require("base_ins_r")
_class("PlayTrapStateAnimationInstruction", BaseInstruction)
PlayTrapStateAnimationInstruction = PlayTrapStateAnimationInstruction

function PlayTrapStateAnimationInstruction:Constructor(paramList)
  self._openAnimName = paramList.openAnimName
  self._closeAnimName = paramList.closeAnimName
  self._hasSummonMonster = tonumber(paramList.hasSummonMonster) or 1
end

function PlayTrapStateAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.TrapSummonMonster)
  if not resultArray or not resultArray[1] then
    return
  end
  local result = resultArray[1]
  if not result:GetTrapOpenStateChange() then
    return
  end
  local e = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    e = cSuperEntity:GetSuperEntity()
  end
  local renderAttrCmpt = e:RenderAttributes()
  if renderAttrCmpt:GetAttribute("OpenState") and renderAttrCmpt:GetAttribute("OpenState") == 1 then
    e:SetAnimatorControllerTriggers({
      self._openAnimName
    })
  else
    e:SetAnimatorControllerTriggers({
      self._closeAnimName
    })
  end
end
