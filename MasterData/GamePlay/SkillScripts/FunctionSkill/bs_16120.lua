local bs_16120 = class("bs_16120", LuaSkillBase)
local base = LuaSkillBase
bs_16120.config = {resistanceBuff = 111141}

function bs_16120:ctor()
end

function bs_16120:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_16120_2", 1, self.OnSetHurt, self.caster, nil, nil, nil)
  self:AddAfterAddBuffTrigger("bs_16120_8", 1, self.OnAfterAddBuff, nil, self.caster, nil, eBattleRoleBelong.enemy, nil)
  self.controlTime = 0
  self.maxControlCount = self.arglist[1] / self.arglist[2] + 1
end

function bs_16120:OnSetHurt(context)
  if context.sender.belongNum == eBattleRoleBelong.enemy then
    context.hurt = context.hurt * math.max(1000, 1000 + self.arglist[1] - self.controlTime * self.arglist[2]) // 1000
  end
end

function bs_16120:OnAfterAddBuff(buff, target)
  if buff.buffCfg.IsControl == true then
    if self.controlTime < self.maxControlCount then
      self.controlTime = self.controlTime + 1
    else
      self:RemoveSkillTrigger(eSkillTriggerType.AfterAddBuff)
    end
  end
end

function bs_16120:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_16120
