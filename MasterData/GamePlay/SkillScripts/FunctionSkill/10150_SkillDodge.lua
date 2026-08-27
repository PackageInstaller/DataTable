local bs_10150 = class("bs_10150", LuaSkillBase)
local base = LuaSkillBase
bs_10150.config = {buffId = 1122, buffTier = 1}

function bs_10150:ctor()
end

function bs_10150:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10150_2", 2, self.OnAfterPlaySkill)
end

function bs_10150:OnAfterPlaySkill(skill, role)
  if self.caster.recordTable["104502_active"] == false then
    return
  end
  if skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 24, 10)
    if targetlist.Count > 0 then
      local layer = targetlist[0].targetRole:GetBuffTier(self.config.buffId)
      if layer ~= self.arglist[2] then
        if layer <= self.arglist[2] then
          LuaSkillCtrl:CallBuff(self, targetlist[0].targetRole, self.config.buffId, self.config.buffTier, nil, true)
        elseif layer > self.arglist[2] then
          LuaSkillCtrl:DispelBuff(targetlist[0].targetRole, self.config.buffId, 0)
          LuaSkillCtrl:CallBuff(self, targetlist[0].targetRole, self.config.buffId, self.arglist[2], nil, true)
        end
      end
      if self.caster.recordTable["30039_Flag"] and targetlist.Count > 1 then
        local layer = targetlist[1].targetRole:GetBuffTier(self.config.buffId)
        if layer ~= self.arglist[2] then
          if layer <= self.arglist[2] then
            LuaSkillCtrl:CallBuff(self, targetlist[1].targetRole, self.config.buffId, self.config.buffTier, nil, true)
          elseif layer > self.arglist[2] then
            LuaSkillCtrl:DispelBuff(targetlist[1].targetRole, self.config.buffId, 0)
            LuaSkillCtrl:CallBuff(self, targetlist[1].targetRole, self.config.buffId, self.arglist[2], nil, true)
          end
        end
      end
    end
  end
end

function bs_10150:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10150
