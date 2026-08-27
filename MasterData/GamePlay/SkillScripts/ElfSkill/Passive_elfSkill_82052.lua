local bs_82052 = class("bs_82052", LuaSkillBase)
local base = LuaSkillBase
bs_82052.config = {buff_damageup = 720}

function bs_82052:ctor()
end

function bs_82052:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_82052_1", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil)
  self.caster.recordTable.addDAMAGE = false
end

function bs_82052:OnAfterAddBuff(buff, target)
  if buff.buffCfg.IsControl and target ~= nil and target.hp > 0 and target.belongNum ~= eBattleRoleBelong.player and self.caster.recordTable.addDAMAGE == false then
    self.caster.recordTable.addDAMAGE = true
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_damageup, 1)
  end
end

function bs_82052:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_82052
