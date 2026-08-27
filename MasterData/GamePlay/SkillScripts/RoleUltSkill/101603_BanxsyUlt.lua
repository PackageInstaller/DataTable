local bs_101603 = class("bs_101603", LuaSkillBase)
local base = LuaSkillBase
bs_101603.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    def_formula = 9996,
    minhurt_formula = 9994,
    crit_formula = 0,
    crithur_ratio = 9995,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000,
    hurt_type = -1
  },
  buffId_color = 101601,
  buffID_blind = 101602,
  audioIdStart = 199,
  audioIdMovie = 200,
  audioIdEnd = 201,
  selectId = 9,
  select_range = 10,
  movieEndRoleActionId = 1005
}

function bs_101603:ctor()
end

function bs_101603:InitSkill(isMidwaySkill)
end

function bs_101603:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(20)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.select_range)
  if targetList.Count <= 0 then
    return
  else
    for i = 0, targetList.Count - 1 do
      local buff = LuaSkillCtrl:GetRoleBuffById(targetList[i].targetRole, self.config.buffId_color)
      if buff ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
          self.arglist[1]
        })
        skillResult:EndResult()
        LuaSkillCtrl:DispelBuffByMaker(self.caster, targetList[i].targetRole, self.config.buffId_color, 0)
        if targetList[i].targetRole.belongNum == eBattleRoleBelong.enemy then
          LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffID_blind, 1, self.arglist[2])
        end
      end
    end
  end
end

function bs_101603:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_101603:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_101603:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_101603:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_101603:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101603
