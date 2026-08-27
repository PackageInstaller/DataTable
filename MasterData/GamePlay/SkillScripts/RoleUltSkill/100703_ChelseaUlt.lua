local bs_100703 = class("bs_100703", LuaSkillBase)
local base = LuaSkillBase
bs_100703.config = {
  effectId_start = 100706,
  effectId_Gun = 100707,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3024,
    returndamage_formula = 0
  },
  hurt_configF = {
    hit_formula = 0,
    basehurt_formula = 3027,
    returndamage_formula = 0
  },
  aoe_config = {
    effect_shape = 1,
    aoe_select_code = 4,
    aoe_range = 10
  },
  audioIdStart = 100704,
  audioIdMovie = 100705,
  audioIdEnd = 100706,
  fronttime = 15,
  movieEndRoleActionId = 1006,
  buffId_BingDong = 1178
}

function bs_100703:ctor()
end

function bs_100703:InitSkill(isMidwaySkill)
  self.hurt_config = {}
end

function bs_100703:PlaySkill()
  self:CallCasterWait(20)
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, self.config.effectId_start, self, self.SkillEventFunc, nil, 0.5)
end

function bs_100703:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(self, 5, function()
      local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
      for i = 0, skillResult.roleList.Count - 1 do
        if skillResult.roleList[i].belongNum == eBattleRoleBelong.enemy then
          LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId_BingDong, self.arglist[2], self.arglist[3])
        end
      end
      local hurtCfg
      if self:IsConsumeSkill() then
        hurtCfg = self.config.hurt_configF
      else
        hurtCfg = self.config.hurt_config
      end
      LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, {
        self.arglist[1]
      })
      skillResult:EndResult()
    end, nil)
  end
end

function bs_100703:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_100703:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, self.config.fronttime, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_Gun, self)
end

function bs_100703:PlayUltMovie()
  base.PlayUltMovie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_100703:OnSkipUltView()
  base.OnSkipUltView(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_100703:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_100703:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_100703:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_100703
