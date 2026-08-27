local bs_82051 = class("bs_82051", LuaSkillBase)
local base = LuaSkillBase
bs_82051.config = {buff_attrup = 719}

function bs_82051:ctor()
end

function bs_82051:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeJudgeAndAddBuffTrigger("bs_82051_1", 1, self.OnAddBeforeJudgeAndAddBuff, nil, nil, nil, eBattleRoleBelong.enemy)
  self.passiveCd = 0
end

function bs_82051:OnAddBeforeJudgeAndAddBuff(target, context)
  if context.buff.buffCfg.IsControl and target ~= nil and target.hp > 0 and target.belongNum ~= eBattleRoleBelong.player and context.buff.maker == self.caster then
    local battleCtrl = LuaSkillCtrl.battleCtrl
    local curFrame = battleCtrl.frame
    if curFrame < self.passiveCd then
      return
    end
    target:TryCallBreakNumChange(-self.arglist[1])
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_attrup, 1, self.arglist[3])
    self.passiveCd = curFrame + self.arglist[4]
  end
end

function bs_82051:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_82051
