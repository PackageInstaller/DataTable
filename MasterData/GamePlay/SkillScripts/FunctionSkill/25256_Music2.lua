local bs_25256 = class("bs_25256", LuaSkillBase)
local base = LuaSkillBase
bs_25256.config = {buffId = 3025}

function bs_25256:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_25256_1", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
  self:AddBuffDieTrigger("bs_25256_2", 3, self.OnBuffDie, nil, nil, self.config.buffId)
end

function bs_25256:OnAfterPlaySkill(skill, role)
  if skill.skillTag ~= eSkillTag.ultSkill then
    return
  end
  if skill.skillType ~= eBattleSkillLogicType.Original then
    return
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 84, 10)
  if targetList.Count == 0 then
    return
  end
  local role
  for i = 0, targetList.Count - 1 do
    if targetList[i].targetRole.intensity < 3 then
      role = targetList[i].targetRole
      break
    end
  end
  if role == nil then
    return
  end
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1])
  local buffTier = role:GetBuffTier(self.config.buffId)
  if 0 < buffTier then
    LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(0.2, 0.2, 0.2))
  end
end

function bs_25256:OnBuffDie(buff, target, removeType)
  if buff.dataId ~= self.config.buffId then
    return
  end
  LuaSkillCtrl:CallStartLocalScale(target, Vector3.New(1, 1, 1))
end

function bs_25256:AfterBuffRemove(buffId, target, removeType)
  if buffId ~= self.config.buffId then
    return
  end
  LuaSkillCtrl:CallStartLocalScale(target, Vector3.New(1, 1, 1))
end

function bs_25256:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25256
