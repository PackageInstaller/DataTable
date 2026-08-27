local bs_17110 = class("bs_17110", LuaSkillBase)
local base = LuaSkillBase
bs_17110.config = {buffId = 170}

function bs_17110:ctor()
end

function bs_17110:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillBase:AddAfterPlaySkillTriggerForTable("bs_17110_2", 2, self.OnAfterPlaySkill, {
    sender = self.caster,
    extraArg1 = eSkillTag.normalSkill
  })
end

function bs_17110:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.isNormalSkill and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[2] // 1000
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
  end
end

function bs_17110:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17110
