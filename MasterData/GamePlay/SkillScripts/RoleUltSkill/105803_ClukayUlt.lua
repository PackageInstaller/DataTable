local bs_105803 = class("bs_105803", LuaSkillBase)
local base = LuaSkillBase
bs_105803.config = {
  effectId_ct = 105820,
  effectId_ZD = 105814,
  effectId_ZDsj = 105813,
  effectId_ZDqk = 105815,
  effectId_xhqk = 105827,
  effectId_xhzd = 105816,
  effectId_sj = 105818,
  effectId_hj = 105817,
  effectTime = 10,
  buffId_Ult = 105803,
  buffId = 104401,
  configId = 13,
  aoe_config = {
    effect_shape = 2,
    aoe_select_code = 4,
    aoe_range = 1
  },
  audioIdStart = 105809,
  audioIdMovie = 105810,
  audioIdEnd = 105811
}

function bs_105803:ctor()
end

function bs_105803:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105803:PlaySkill(data, selectTargetCoord, selectRolesdata)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Ult, 1, 35, true)
    self:TryResetMoveState(self.caster)
    local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    self.caster.lsObject:SetPositionForce(grid.fixLogicPosition)
    local time = 69
    self:CallCasterWait(time)
    self.caster:LookAtTarget(targetGrid)
    if self.timer1 ~= nil then
      self.timer1:Stop()
      self.timer1 = nil
    end
    if self.beginTimer ~= nil then
      self.beginTimer:Stop()
      self.beginTimer = nil
    end
    if self.timer2 ~= nil then
      self.timer2:Stop()
      self.timer2 = nil
    end
    self:SetLastSelectTarget(targetGrid)
    self.timer1 = LuaSkillCtrl:StartTimer(nil, 4, function()
      LuaSkillCtrl:CallRoleAction(self.caster, 1006)
      self.beginTimer = LuaSkillCtrl:StartTimer(nil, 2, function()
        LuaSkillCtrl:CallEffectWithArg(targetGrid, self.config.effectId_ct, self, false, false, self.CallEffectAndEmissions, targetGrid)
        LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_ZDqk, self)
      end, nil, 4)
      self.timer2 = LuaSkillCtrl:StartTimer(nil, 25, function()
        LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_xhzd, self)
        LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_xhqk, self)
        LuaSkillCtrl:DispelBuff(self.caster, 196, 1, true)
        LuaSkillCtrl:StartTimer(nil, 6, function()
          local effect = LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_hj, self)
          LuaSkillCtrl:StartTimer(nil, 10, function()
            LuaSkillCtrl:StartTimer(nil, 2, function()
              local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(targetGrid, 1, true)
              if targetlist_enemy ~= nil and targetlist_enemy.Count > 0 then
                local true_targetlist = {}
                for i = 0, targetlist_enemy.Count - 1 do
                  if targetlist_enemy[i] ~= nil and targetlist_enemy[i].belongNum == eBattleRoleBelong.enemy and not targetlist_enemy[i]:IsUnSelect(self.caster) then
                    local k = targetlist_enemy[i]
                    table.insert(true_targetlist, k)
                  end
                end
                local num = table.length(true_targetlist)
                local num_t = LuaSkillCtrl:CallRange(1, num)
                local target = true_targetlist[num_t]
                if target ~= nil and 0 < target.hp then
                  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
                  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
                    self.arglist[4]
                  }, false)
                  LuaSkillCtrl:CallEffect(target, self.config.effectId_sj, self)
                end
              else
              end
              self:SetLastSelectTarget(nil)
            end, self, self.arglist[3] - 1, 1)
            LuaSkillCtrl:StartTimer(nil, 45, function()
              if effect ~= nil then
                effect:Die()
                effect = nil
              end
            end)
          end)
        end)
      end)
    end)
  end
end

function bs_105803:CallEffectAndEmissions(inputTarget, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local collisionTrigger = BindCallback(self, self.OnCollision, inputTarget)
    LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, inputTarget, 30, 10, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, false)
  end
end

function bs_105803:OnCollision(inputTarget, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 or entity.belongNum == self.caster.belongNum then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.arglist[2]
  }, false)
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_ZDsj, self)
  skillResult:EndResult()
end

function bs_105803:PlayUltEffect(data, selectTargetCoord, selectRoles)
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 40, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_105803:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_105803:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_105803:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_105803:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer1 ~= nil then
    self.timer1:Stop()
    self.timer1 = nil
  end
  if self.beginTimer ~= nil then
    self.beginTimer:Stop()
    self.beginTimer = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Stop()
    self.timer2 = nil
  end
end

function bs_105803:OnBreakSkill(role)
  if role == self.caster then
    self:CancleCasterWait()
    self:SetLastSelectTarget(nil)
  end
  base.OnBreakSkill(self, role)
end

function bs_105803:LuaDispose()
  base.LuaDispose(self)
end

return bs_105803
