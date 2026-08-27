local bs_102403 = class("bs_102403", LuaSkillBase)
local base = LuaSkillBase
bs_102403.config = {
  hurt_config = {hit_formula = 10010, basehurt_formula = 10076},
  effectId_missile = 102401,
  effectId_back = 102403,
  buff_crit = 102401,
  audioIdStart = 102401,
  audioIdMovie = 102402,
  audioIdEnd = 102403
}

function bs_102403:ctor()
end

function bs_102403:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102403:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(20)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputTarget)
    local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(inputTarget, 1, true)
    local effectTarget = LuaSkillCtrl:FindAllGridsWithinRange(inputTarget, 1, true)
    for i = 0, 2 do
      local j = LuaSkillCtrl:CallRange(0, effectTarget.Count - 1)
      local RealEffectTarget = LuaSkillCtrl:GetTargetWithGrid(effectTarget[j].x, effectTarget[j].y)
      LuaSkillCtrl:CallEffect(RealEffectTarget, self.config.effectId_missile, self)
    end
    LuaSkillCtrl:StartTimer(self, 10, function()
      if targetlist_enemy ~= nil and targetlist_enemy.Count > 0 then
        for i = 0, targetlist_enemy.Count - 1 do
          local targetlist_hit_enemy = targetlist_enemy[i]
          if targetlist_hit_enemy.belongNum ~= eBattleRoleBelong.player then
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist_hit_enemy)
            LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, false)
            skillResult:EndResult()
          end
          if targetlist_hit_enemy.belongNum == eBattleRoleBelong.enemy then
            LuaSkillCtrl:CallEffect(targetlist_hit_enemy, self.config.effectId_back, self, nil, self.caster, 1, true)
            LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_crit, 1, self.arglist[4], false)
          end
        end
      end
    end)
  end
end

function bs_102403:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_102403:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_102403:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_102403:OnMovieFadeOut()
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  base.OnMovieFadeOut(self)
end

function bs_102403:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_102403:LuaDispose()
  base.LuaDispose(self)
end

return bs_102403
