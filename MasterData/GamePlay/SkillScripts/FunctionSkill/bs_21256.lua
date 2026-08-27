local bs_21256 = class("bs_21256", LuaSkillBase)
local base = LuaSkillBase
bs_21256.config = {buffId = 2235}

function bs_21256:ctor()
end

function bs_21256:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_21256_2", 1, self.OnBeforeAddBuff, self.caster)
end

function bs_21256:OnBeforeAddBuff(target, context)
  if context.buff.buffCfg.IsControl then
    local targetList = LuaSkillCtrl:FindRolesAroundRole(target)
    if targetList ~= nil and targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local damage = self.caster.pow * self.arglist[1] // 1000
        local belong_num = targetList[i].belongNum
        if belong_num == eBattleRoleBelong.enemy and targetList[i] ~= target.targetRole then
          LuaSkillCtrl:RemoveLife(damage, self, targetList[i], true, nil, true)
          LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId, 1, self.arglist[2], true, nil, true)
        end
      end
    end
  end
end

function bs_21256:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21256
