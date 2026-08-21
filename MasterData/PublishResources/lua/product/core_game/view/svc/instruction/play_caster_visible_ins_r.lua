require("base_ins_r")
_class("PlayCasterVisibleInstruction", BaseInstruction)
PlayCasterVisibleInstruction = PlayCasterVisibleInstruction

function PlayCasterVisibleInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
  self._forcePlayOnSkillHolder = tonumber(paramList.forcePlayOnSkillHolder) == 1
end

function PlayCasterVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local realCaster = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() and not self._forcePlayOnSkillHolder then
    realCaster = casterEntity:GetSuperEntity()
  end
  local isShow = self._visible == 1
  realCaster:SetViewVisible(isShow)
  local cHP = realCaster:HP()
  if not cHP then
    return
  end
  local world = realCaster:GetOwnerWorld()
  local eidHPBar = cHP:GetHPSliderEntityID()
  local hpBarEntity = world:GetEntityByID(eidHPBar)
  if not hpBarEntity then
    return
  end
  if realCaster:HasMonsterID() then
    local monsrsvc = world:GetService("MonsterShowRender")
    monsrsvc:ShowMonsterHPBar(TT, realCaster, hpBarEntity, isShow)
  end
end
