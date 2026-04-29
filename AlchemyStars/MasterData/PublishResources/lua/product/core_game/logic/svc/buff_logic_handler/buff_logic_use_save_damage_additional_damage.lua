_class("BuffLogicUseSaveDamageAdditionalDamage", BuffLogicBase)
BuffLogicUseSaveDamageAdditionalDamage = BuffLogicUseSaveDamageAdditionalDamage

function BuffLogicUseSaveDamageAdditionalDamage:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._addValue = logicParam.addValue or 0
  self._damageType = logicParam.damageType or DamageType.Recover
  self._effectID = logicParam.effectID
end

function BuffLogicUseSaveDamageAdditionalDamage:DoLogic(notify)
  local e = self._buffInstance:Entity()
  if e:HasDeadMark() or e:HasPetDeadMark() then
    return
  end
  local attrCmpt = e:Attributes()
  local max_hp = attrCmpt:CalcMaxHp()
  local cur_hp = attrCmpt:GetCurrentHP()
  if cur_hp <= 0 then
    return
  end
  local curSaveSkillDamage = e:BuffComponent():GetBuffValue("SaveSkillDamage") or 0
  if curSaveSkillDamage == 0 then
    return
  end
  e:BuffComponent():SetBuffValue("SaveSkillDamage", 0)
  local damageValue = curSaveSkillDamage * (1 + self._mulValue) + self._addValue
  local changeHp = math.floor(damageValue)
  if max_hp < changeHp + cur_hp then
    changeHp = max_hp - cur_hp
  end
  local teamEntity
  if e:HasTeam() then
    teamEntity = e
  elseif e:HasPet() then
    teamEntity = e:Pet():GetOwnerTeamEntity()
  end
  if 0 < changeHp then
    if teamEntity and teamEntity:Attributes():GetAttribute("BuffForbidCure") then
      return
    elseif e:Attributes():GetAttribute("BuffForbidCure") then
      return
    end
  end
  if changeHp < 0 then
    changeHp = -changeHp
  end
  local calcDamage = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(damageValue, self._damageType)
  damageInfo:SetChangeHP(changeHp)
  if self._damageType == DamageType.Recover then
    calcDamage:AddTargetHP(e:GetID(), damageInfo)
  end
  local result = BuffResultUseSaveDamageAdditionalDamage:New(damageInfo, self._effectID)
  return result
end
