local bs_105601 = class("bs_105601", LuaSkillBase)
local base = LuaSkillBase
bs_105601.config = {
  buffId_tr = 105602,
  buffId_gs = 3021,
  selectId_pass = 5
}

function bs_105601:ctor()
end

function bs_105601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_105601_13", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_tr)
  self.caster.recordTable["105601_Roll"] = self.arglist[1]
  self.caster.recordTable["105601_arg2"] = self.arglist[2]
end

function bs_105601:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_tr and target ~= nil and target.hp > 0 and target.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_gs, 1, self.arglist[4])
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_tr, 0, true)
  end
end

function bs_105601:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105601
