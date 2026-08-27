local career_104 = class("career_104", LuaSkillBase)
local base = LuaSkillBase
career_104.config = {}

function career_104:ctor()
end

function career_104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("career_104_5", 1, self.OnAfterHurt, {
    senderBelongNum = eBattleRoleBelong.player,
    targetBelongNum = eBattleRoleBelong.enemy
  })
end

function career_104:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == eBattleRoleBelong.enemy and sender.belongNum == eBattleRoleBelong.player and not isMiss then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 96, 10)
    if targetlist.Count > 0 then
      local target1 = targetlist[0].targetRole
      if target1 == target then
        LuaSkillCtrl:RemoveLife(1, self, target, true, nil, true, true, eHurtType.RealDmg)
      end
    end
  end
end

function career_104:OnCasterDie()
  base.OnCasterDie(self)
end

return career_104
