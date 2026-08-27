local bs_10326 = class("bs_10326", LuaSkillBase)
local base = LuaSkillBase
bs_10326.config = {Attack1BuffId = 1264}

function bs_10326:ctor()
end

function bs_10326:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_10326_14", 90, self.OnAfterHurt, {
    senderBelongNum = eBattleRoleBelong.player,
    extraArg2 = false,
    extraArg3 = false
  })
end

function bs_10326:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isCrit and self:IsReadyToTake() and not isTriggerSet then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetlist.Count ~= 0 then
      for i = 0, targetlist.Count - 1 do
        LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.Attack1BuffId, 1, 75, true)
      end
    end
  end
end

function bs_10326:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10326
