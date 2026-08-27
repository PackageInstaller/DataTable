local bs_21027 = class("bs_21027", LuaSkillBase)
local base = LuaSkillBase
bs_21027.config = {buffId = 110020, effectId = 10950}

function bs_21027:ctor()
end

function bs_21027:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_10323_10", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum, nil, nil, nil)
  self:AddBeforeBuffDispelTrigger("bs_21027_1", 1, self.BeforeBuffDispel, nil, eBattleRoleBelong.player, self.config.buffId)
  self:AddBuffDieTrigger("bs_21027_2", 1, self.OnBuffDie, nil, eBattleRoleBelong.player, self.config.buffId)
end

function bs_21027:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum and role.roleType == 1 then
    local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if 1 > targetlist.Count then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i]
      if 1 <= targetRole:GetBuffTier(self.config.buffId) then
        LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId, 1)
      end
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, 60)
      LuaSkillCtrl:CallStartLocalScale(targetRole, Vector3.New(1.2, 1.2, 1.2), 0.2)
    end
  end
end

function bs_21027:BeforeBuffDispel(targetRole, context)
  LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
  LuaSkillCtrl:CallStartLocalScale(targetRole, Vector3.New(1, 1, 1), 0.2)
end

function bs_21027:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId then
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
    LuaSkillCtrl:CallStartLocalScale(target, Vector3.New(1, 1, 1), 0.2)
  end
end

function bs_21027:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21027
