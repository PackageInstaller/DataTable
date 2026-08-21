require("base_ins_r")
_class("PlayCasterShowHideInstruction", BaseInstruction)
PlayCasterShowHideInstruction = PlayCasterShowHideInstruction

function PlayCasterShowHideInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
  self._forcePlayOnSkillHolder = tonumber(paramList.forcePlayOnSkillHolder) == 1
end

function PlayCasterShowHideInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local realCaster = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() and not self._forcePlayOnSkillHolder then
    realCaster = casterEntity:GetSuperEntity()
  end
  local isShow = self._visible == 1
  local v3Location = realCaster:GetPosition()
  v3Location.y = isShow and 0 or 1000
  realCaster:SetLocation(v3Location)
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
