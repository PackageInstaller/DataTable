local bs_21088 = class("bs_21088", LuaSkillBase)
local base = LuaSkillBase
bs_21088.config = {buffId = 110036}

function bs_21088:ctor()
end

function bs_21088:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21088_1", 1, self.OnAfterBattleStart)
end

function bs_21088:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  local buffTier = 0
  if 0 < targetlist.Count then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].targetRole.belongNum == eBattleRoleBelong.enemy then
        buffTier = buffTier + 1
      end
    end
    buffTier = buffTier * self.arglist[1] // 10
  end
  local selflist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if 0 < selflist.Count then
    for i = 0, selflist.Count - 1 do
      LuaSkillCtrl:CallBuff(self, selflist[i].targetRole, self.config.buffId, buffTier, nil)
    end
  end
end

function bs_21088:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21088
