local bs_92091 = class("bs_92091", LuaSkillBase)
local base = LuaSkillBase
bs_92091.config = {buffId = 2073}

function bs_92091:ctor()
end

function bs_92091:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_92091_1", 1, self.OnAfterPlaySkill)
end

function bs_92091:OnAfterPlaySkill(skill, role)
  if skill.skillTag ~= eSkillTag.ultSkill then
    return
  end
  local buffTier = role:GetBuffTier(self.config.buffId)
  if buffTier < 1 then
    return
  end
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[1] * buffTier // 1000)
end

function bs_92091:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92091
