local bs_20253 = class("bs_20253", LuaSkillBase)
local base = LuaSkillBase
bs_20253.config = {buffId = 120000}

function bs_20253:ctor()
end

function bs_20253:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_20253_1", 1, self.OnAfterPlaySkill)
end

function bs_20253:OnAfterPlaySkill(skill, role)
  if skill.dataId == 103703 then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetlist.Count < 1 then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local role = targetlist[i].targetRole
      local buffTier = role:GetBuffTier(self.config.buffId)
      if buffTier == 0 then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil, true)
      end
    end
  end
end

function bs_20253:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20253
