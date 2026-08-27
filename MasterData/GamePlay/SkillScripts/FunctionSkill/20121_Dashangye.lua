local bs_20121 = class("bs_20121", LuaSkillBase)
local base = LuaSkillBase
bs_20121.config = {
  buffId = 1126,
  buffTier = 1,
  effectId = 10927
}

function bs_20121:ctor()
end

function bs_20121:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20121_1", 1, self.OnAfterBattleStart)
end

function bs_20121:OnAfterBattleStart()
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 5, 0)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    if 0 < targetRole.hp then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.config.buffTier, nil, true)
    end
  end
end

function bs_20121:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20121
