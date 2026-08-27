local bs_108303 = class("bs_108303", LuaSkillBase)
local base = LuaSkillBase
bs_108303.config = {
  effect_fw = 108310,
  effect_jf = 108311,
  buffid_jiansu = 108304,
  buffid_qiyou = 108302,
  buffid_jifei = 108303,
  buffid_biaoji = 108305,
  actionId = 1005,
  actionIdend = 1006,
  action_speed = 1,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    def_formula = 9996,
    minhurt_formula = 9994,
    crit_formula = 9992,
    crithur_ratio = 9995,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 0,
    hurt_type = 1,
    hurt_tag = 1
  },
  audioIdStart = 108308,
  audioIdMovie = 108309,
  audioIdEnd = 108310
}

function bs_108303:ctor()
end

function bs_108303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.trigger = false
end

function bs_108303:PlaySkill(data)
  local ultGrid = LuaSkillCtrl:GetTargetWithGrid(self.caster.x, self.caster.y)
  local effect = LuaSkillCtrl:CallEffect(ultGrid, self.config.effect_fw, self)
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 180, eColliderInfluenceType.Enemy, nil, collisionEnter, collisionExit)
  LuaSkillCtrl:StartTimer(nil, self.arglist[5], function()
    if effect ~= nil then
      effect:Die()
      effect = nil
    end
  end)
  self:RandomSelectAttack(ultGrid)
  if not self.trigger then
    self:AddSetHurtTrigger("bs_108303_3", 1, self.OnSetHurt, nil, self.caster, nil, nil)
    self.trigger = true
  end
end

function bs_108303:OnCollisionEnter(collider, index, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnShaleBuffAdd, entity, false)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffid_jiansu, 1)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffid_biaoji, 1)
  end
end

function bs_108303:RandomSelectAttack(ultGrid)
  local AttackTimes = self.arglist[5] // self.arglist[2]
  self.hitTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
    local targetlist = LuaSkillCtrl:FindAllRolesWithinRange(ultGrid, 2, false)
    if targetlist ~= nil and targetlist.Count > 0 then
      local _tempList = {}
      for i = targetlist.Count - 1, 0, -1 do
        if targetlist[i].belongNum == eBattleRoleBelong.enemy and not LuaSkillCtrl:RoleContainsBuffFeature(targetlist[i], 5) then
          table.insert(_tempList, targetlist[i])
        end
      end
      if _tempList == nil or #_tempList == 0 then
        return
      end
      local target
      if #_tempList == 1 then
        target = _tempList[1]
      else
        local randomMax = #_tempList
        local RandomNum = LuaSkillCtrl:CallRange(1, randomMax)
        local num = RandomNum
        target = _tempList[num]
      end
      if target ~= nil then
        LuaSkillCtrl:CallEffect(target, self.config.effect_jf, self)
        LuaSkillCtrl:CallBuff(self, target, self.config.buffid_jifei, 1, 10)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
          self.arglist[3]
        })
        skillResult:EndResult()
      end
    end
  end, self, AttackTimes - 1, self.arglist[2] - 1)
end

function bs_108303:OnCollisionExit(collider, entity)
  if entity ~= nil and entity.hp > 0 and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffid_qiyou, 0)
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnShaleBuffAdd, entity, true)
    LuaSkillCtrl:DispelBuff(entity, self.config.buffid_jiansu, 0)
    LuaSkillCtrl:DispelBuff(entity, self.config.buffid_biaoji, 0)
  end
end

function bs_108303:OnSetHurt(context)
  if context.sender.belongNum == eBattleRoleBelong.enemy and context.sender:GetBuffTier(self.config.buffid_biaoji) > 0 then
    context.hurt = context.hurt * (1000 - self.arglist[4]) // 1000
  end
end

function bs_108303:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_108303:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_108303:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_108303:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_108303:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108303
