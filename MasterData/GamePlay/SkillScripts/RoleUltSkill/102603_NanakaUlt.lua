local bs_102603 = class("bs_102603", LuaSkillBase)
local base = LuaSkillBase
bs_102603.config = {
  heal_config = {baseheal_formula = 10088},
  heal_configF = {baseheal_formula = 102601},
  effectId_Start = 102601,
  effectId_Loop = 102602,
  effectId_End = 102603,
  buffID = 102603,
  audioIdStart = 102601,
  audioIdMovie = 102602
}

function bs_102603:ctor()
end

function bs_102603:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102603:PlaySkill(data, selectTargetCoord, selectRolesdata)
  self:CallCasterWait(5)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    local effect = LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_Loop, self)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    local collisionExit = BindCallback(self, self.OnCollisionExit)
    LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Player, nil, collisionEnter, collisionExit)
    LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
      if effect ~= nil then
        effect:Die()
        effect = nil
        local targetlist_heal = LuaSkillCtrl:FindAllRolesWithinRange(targetGrid, 1, true)
        if targetlist_heal ~= nil and targetlist_heal.Count > 0 then
          for i = 0, targetlist_heal.Count - 1 do
            local targetlist_heal_ally = targetlist_heal[i]
            if targetlist_heal_ally.belongNum == self.caster.belongNum then
              local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist_heal_ally)
              local healCfg
              if self:IsConsumeSkill() then
                healCfg = self.config.heal_configF
              else
                healCfg = self.config.heal_config
              end
              LuaSkillCtrl:HealResult(skillResult, healCfg)
              skillResult:EndResult()
            end
          end
        end
      end
    end)
  end
end

function bs_102603:OnCollisionEnter(collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum == self.caster.belongNum and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffID, 1)
  end
end

function bs_102603:OnCollisionExit(collider, entity)
  if entity ~= nil and entity.hp > 0 and entity:GetBuffTier(self.config.buffID) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffID, 1)
  end
end

function bs_102603:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_102603:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_102603:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_102603:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_102603:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102603
