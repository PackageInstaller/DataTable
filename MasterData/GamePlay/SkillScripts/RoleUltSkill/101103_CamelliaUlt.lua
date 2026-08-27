local bs_101103 = class("bs_101103", LuaSkillBase)
local base = LuaSkillBase
bs_101103.config = {
  hurt_config = {hit_formula = 10010, basehurt_formula = 10076},
  hurt_configF = {hit_formula = 10010, basehurt_formula = 10164},
  effectId_Start = 101101,
  effectId_End = 101102,
  selectTargetId = 9,
  buffID_jifei = 101104,
  buffID_dingshen = 101101,
  buffID_jiansu = 101105,
  audioIdStart = 101106,
  audioIdMovie = 101107,
  audioIdEnd = 101108
}

function bs_101103:ctor()
end

function bs_101103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101103:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(5)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    local effect = LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_Start, self)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    local collisionExit = BindCallback(self, self.OnCollisionExit)
    local targetlist_jifei = LuaSkillCtrl:FindAllRolesWithinRange(targetGrid, 1, true)
    if targetlist_jifei ~= nil and targetlist_jifei.Count > 0 then
      for i = 0, targetlist_jifei.Count - 1 do
        local targetlist_jifei_enemy = targetlist_jifei[i]
        if targetlist_jifei_enemy.belongNum ~= eBattleRoleBelong.player then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist_jifei_enemy)
          local hurtCfg
          if self:IsConsumeSkill() then
            hurtCfg = self.config.hurt_configF
          else
            hurtCfg = self.config.hurt_config
          end
          LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, nil, false)
          LuaSkillCtrl:CallBuff(self, targetlist_jifei_enemy, self.config.buffID_jifei, 1, 15)
          skillResult:EndResult()
        end
      end
    end
    LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Enemy, nil, collisionEnter, collisionExit)
    LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
      if effect ~= nil then
        effect:Die()
        effect = nil
      end
    end)
  end
end

function bs_101103:OnCollisionEnter(collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum ~= self.caster.belongNum and entity.belongNum == eBattleRoleBelong.enemy then
    if LuaSkillCtrl.IsInTDBattle and LuaSkillCtrl.cluaSkillCtrl ~= nil then
      LuaSkillCtrl:CallBuff(self, entity, self.config.buffID_jiansu, 1)
      return
    end
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffID_dingshen, 1)
  end
end

function bs_101103:OnCollisionExit(collider, entity)
  if entity ~= nil and entity.hp > 0 then
    if LuaSkillCtrl.IsInTDBattle and LuaSkillCtrl.cluaSkillCtrl ~= nil then
      LuaSkillCtrl:DispelBuff(entity, self.config.buffID_jiansu, 1)
      return
    end
    LuaSkillCtrl:DispelBuff(entity, self.config.buffID_dingshen, 1)
  end
end

function bs_101103:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_101103:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_101103:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_101103:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_101103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101103
