local bs_109310 = class("bs_109310", LuaSkillBase)
local base = LuaSkillBase
bs_109310.config = {buffId_1 = 109302}

function bs_109310:ctor()
end

function bs_109310:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_109310", 2, self.OnAfterAddBuff, nil, self.caster, nil, nil)
end

function bs_109310:OnAfterAddBuff(buff, target)
  if target ~= nil and target.hp > 0 and buff.buffCfg.IsControl then
    local num = target:GetBuffTier(self.config.buffId_1)
    local buff_1 = target:GetRoleBuffById(self.config.buffId_1)
    if num ~= 0 and num < buff_1.buffCfg.MaxTier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1, 1, self.arglist[1])
    end
  end
end

function bs_109310:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_109310:LuaDispose()
  base.LuaDispose(self)
end

return bs_109310
