local bs_60009 = class("bs_60009", LuaSkillBase)
local base = LuaSkillBase
bs_60009.config = {effectId = 12063}

function bs_60009:ctor()
end

function bs_60009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_60009", 1, self.OnAfterBattleStart)
  self:AddAfterPlaySkillTrigger("bs_60009", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_60009:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[2] // 1000)
  end, nil, -1)
end

function bs_60009:OnAfterPlaySkill(skill, role)
  local targetList = LuaSkillCtrl:GetAllEnmyRoles()
  if 0 < #targetList then
    for k, v in pairs(targetList) do
      local targetRole = v
      LuaSkillCtrl:ClearShield(targetRole, 0)
    end
  end
end

function bs_60009:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_60009
