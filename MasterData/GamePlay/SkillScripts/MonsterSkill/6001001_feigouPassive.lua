local bs_6001001 = class("bs_6001001", LuaSkillBase)
local base = LuaSkillBase
bs_6001001.config = {effectId = 601001}

function bs_6001001:ctor()
end

function bs_6001001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_6001001_1", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_6001001:OnAfterPlaySkill(skill, role)
  if role.belongNum == eBattleRoleBelong.player and skill.isUltSkill then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local count = skills.Count
      if 0 < count then
        for j = 0, count - 1 do
          if not skills[j].isCommonAttack then
            local curCd = skills[j].totalCDTime * -1
            LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curCd)
          end
        end
      end
    end
  end
end

function bs_6001001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6001001
