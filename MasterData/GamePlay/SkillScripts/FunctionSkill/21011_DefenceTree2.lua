local bs_21011 = class("bs_21011", LuaSkillBase)
local base = LuaSkillBase
bs_21011.config = {effecIdAoe = 10943, effecIdHit = 10944}

function bs_21011:ctor()
end

function bs_21011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21011_1", 1, self.OnAfterBattleStart)
  self.hurtTime = nil
end

function bs_21011:OnAfterBattleStart()
  if self.hurtTime ~= nil then
    self.hurtTime:Stop()
    self.hurtTime = nil
  end
  local callback = BindCallback(self, self.FunSkill)
  self.hurtTime = LuaSkillCtrl:StartTimer(nil, self.arglist[1], callback, nil, -1, self.arglist[1])
end

function bs_21011:FunSkill()
  local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 9, 1)
  if targetlist.Count > 0 then
    local value = self.caster.def + self.caster.magic_res
    local Num = 0
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].targetRole.belongNum == eBattleRoleBelong.enemy and LuaSkillCtrl:IsRoleAdjacent(targetlist[i].targetRole, self.caster) then
        LuaSkillCtrl:RemoveLife(value, self, targetlist[i].targetRole, true, nil, true, true, eHurtType.RealDmg)
        LuaSkillCtrl:CallEffect(targetlist[i].targetRole, self.config.effecIdHit, self)
        Num = Num + 1
      end
    end
    if 0 < Num then
      LuaSkillCtrl:CallEffect(self.caster, self.config.effecIdAoe, self)
    end
  end
end

function bs_21011:OnCasterDie()
  base.OnCasterDie(self)
  if self.hurtTime ~= nil then
    self.hurtTime:Stop()
    self.hurtTime = nil
  end
end

function bs_21011:LuaDispose()
  if self.hurtTime ~= nil then
    self.hurtTime:Stop()
    self.hurtTime = nil
  end
  base.LuaDispose(self)
end

return bs_21011
