local bs_2069999 = class("bs_2069999", LuaSkillBase)
local base = LuaSkillBase
bs_2069999.config = {
  delayInvoke = 20,
  actionId_start = 1001,
  buffId_Super = 3003
}

function bs_2069999:PlaySkill(data, selectTargetCoord, selectRoles)
  self:OnMonsterUltPlay(data, selectTargetCoord, selectRoles, true, BindCallback(self, self.ExecuteUltSkill))
end

function bs_2069999:ExecuteUltSkill()
  print("实际释放逻辑")
end

function bs_2069999:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Super, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_2069999:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 15, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

return bs_2069999
