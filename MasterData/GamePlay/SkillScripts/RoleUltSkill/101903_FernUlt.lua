local bs_101903 = class("bs_101903", LuaSkillBase)
local base = LuaSkillBase
bs_101903.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  hurt_configF = {
    hit_formula = 0,
    basehurt_formula = 3029,
    crit_formula = 0
  },
  aoe_config = {
    effect_shape = 0,
    aoe_select_code = 4,
    aoe_range = 0
  },
  buffId_stun = 3006,
  buffId_tip = 101901,
  selectId = 9,
  select_Range = 10,
  effect_start = 101901,
  effect_hit = 101902,
  effect_MoveSpeed = 7,
  buffFeature_ignoreCtrl = 15,
  buffId_Dj = 100701,
  buffId_Back = 3007,
  audioIdStart = 101901,
  audioIdMovie = 101902,
  audioIdEnd = 101903
}

function bs_101903:ctor()
end

function bs_101903:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101903:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(20)
  local EnemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  local border = LuaSkillCtrl:GetMapBorder()
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, self.config.effect_start, self, nil, nil, nil)
  LuaSkillCtrl:StartTimer(self, 6, BindCallback(self, self.BeatBackAllRoles, EnemyList))
  LuaSkillCtrl:StartTimer(self, 7, BindCallback(self, self.OnMoveEnd, EnemyList))
end

function bs_101903:BeatBackAllRoles(EnemyList)
  for i = 0, EnemyList.Count - 1 do
    local role = EnemyList[i].targetRole
    if not (0 >= role.hp) then
      local IfRoleCotainsIgnoreCtrlBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, self.config.buffFeature_ignoreCtrl)
      if role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral and IfRoleCotainsIgnoreCtrlBuff == false then
        if 0 < role:GetBuffTier(self.config.buffId_Dj) then
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_Back, 1, 1)
        else
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_tip, 1, 1)
          local EnemyTargetGrid = LuaSkillCtrl:GetFurthestRightEmptyGrid(role.x, role.y)
          if EnemyTargetGrid ~= nil then
            LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, role, EnemyTargetGrid.x, EnemyTargetGrid.y, self.config.effect_MoveSpeed, 63, 1)
          end
        end
      elseif role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral and IfRoleCotainsIgnoreCtrlBuff == true then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role, self.aoe_config)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
          self.arglist[1]
        }, false)
        skillResult:EndResult()
      end
    end
  end
end

function bs_101903:OnMoveEnd(EnemyList)
  for i = 0, EnemyList.Count - 1 do
    local role = EnemyList[i].targetRole
    if not (0 >= role.hp) then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      local hurtCfg
      if self:IsConsumeSkill() then
        hurtCfg = self.config.hurt_configF
      else
        hurtCfg = self.config.hurt_config
      end
      LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, {
        self.arglist[1]
      }, false)
      skillResult:EndResult()
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId_stun, 1, self.arglist[2])
      LuaSkillCtrl:CallEffect(role, self.config.effect_hit, self)
    end
  end
end

function bs_101903:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_101903:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_101903:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_101903:OnMovieFadeOut()
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  base.OnMovieFadeOut(self)
end

function bs_101903:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_101903:LuaDispose()
  base.LuaDispose(self)
end

return bs_101903
