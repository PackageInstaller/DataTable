local bs_107410 = class("bs_107410", LuaSkillBase)
local base = LuaSkillBase
bs_107410.config = {buffId = 107405, effectid = 107423}

function bs_107410:ctor()
end

function bs_107410:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107410:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectid, self, nil, nil, nil, true)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role ~= nil and 0 < role.hp then
        LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId, 1, self.arglist[2])
      end
    end
  end
end

return bs_107410
