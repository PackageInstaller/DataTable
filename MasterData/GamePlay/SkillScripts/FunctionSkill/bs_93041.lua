local bs_93041 = class("bs_93041", LuaSkillBase)
local base = LuaSkillBase
bs_93041.config = {
  buffId_blood = 195,
  buffId_fire = 1227,
  buffId1 = 2080
}

function bs_93041:ctor()
end

function bs_93041:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_93041_1", 1, self.OnSetDeadHurt, nil, nil, nil, eBattleRoleBelong.enemy)
end

function bs_93041:OnSetDeadHurt(context)
  if context.sender ~= self.caster then
    return
  end
  if context.target:GetBuffTier(self.config.buffId_blood) > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, self.arglist[2])
  end
  if 0 < context.target:GetBuffTier(self.config.buffId_fire) then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[3] // 1000
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
end

function bs_93041:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93041
