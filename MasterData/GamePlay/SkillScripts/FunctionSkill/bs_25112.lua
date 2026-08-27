local bs_25112 = class("bs_25112", LuaSkillBase)
local base = LuaSkillBase
bs_25112.config = {buffId = 110094}

function bs_25112:ctor()
end

function bs_25112:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_25112_2", 1, self.OnAfterAddBuff, nil, nil, eBattleRoleBelong.player, eBattleRoleBelong.enemy, nil, nil, eBuffFeatureType.Stun)
end

function bs_25112:OnAfterAddBuff(buff, target)
  if target.belongNum == eBattleRoleBelong.enemy then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local targetRole = targetList[i].targetRole
        LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 0, true)
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, self.arglist[2])
      end
    end
  end
end

function bs_25112:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25112
