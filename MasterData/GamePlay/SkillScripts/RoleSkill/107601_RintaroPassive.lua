local bs_107601 = class("bs_107601", LuaSkillBase)
local base = LuaSkillBase
bs_107601.config = {
  summonerId = 107601,
  cd = 107601,
  recoverHealEffect = 107605,
  standBron = 107603
}
local SyncAttrList = {
  eHeroAttr.pow,
  eHeroAttr.skill_intensity,
  eHeroAttr.dodge,
  eHeroAttr.speed,
  eHeroAttr.crit,
  eHeroAttr.critDamage,
  eHeroAttr.sunder,
  eHeroAttr.damage_increase,
  eHeroAttr.injury_reduce,
  eHeroAttr.heal,
  eHeroAttr.treatment,
  eHeroAttr.magic_pen,
  eHeroAttr.return_damage,
  eHeroAttr.life_steal,
  eHeroAttr.spell_life_steal,
  eHeroAttr.resistance
}

function bs_107601:ctor()
end

function bs_107601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_107601_1", 1, self.OnSetHurt, nil, nil, nil, self.caster.belongNum)
  self:AddAfterHurtTrigger("bs_107601_2", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum)
  self.mark = nil
  self.caster.recordTable.arg1 = self.arglist[2]
  self.caster.recordTable.arg2 = self.arglist[3]
end

function bs_107601:OnSetHurt(context)
  if context.target.isDead == true then
    return
  end
  local buffCdTier = context.target:GetBuffTier(self.config.cd)
  if context.target.roleDataId ~= 1077 and buffCdTier == 0 and context.target.roleType ~= eBattleRoleType.realSummoner then
    if LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
      LuaSkillCtrl:CallRecoverHeal(context.target, self, self.arglist[2], self.arglist[3], 0, self.config.recoverHealEffect)
      LuaSkillCtrl:CallBuff(self, context.target, self.config.cd, 1, self.arglist[4], true)
    end
  elseif context.target.roleDataId == 1077 and buffCdTier == 0 and context.target.recordTable.rate_ex ~= nil then
    local num = context.target.recordTable.rate_ex
    if LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] + num then
      LuaSkillCtrl:CallRecoverHeal(context.target, self, self.arglist[2], self.arglist[3], 0, self.config.recoverHealEffect)
      LuaSkillCtrl:CallBuff(self, context.target, self.config.cd, 1, self.arglist[4], true)
    end
  end
end

function bs_107601:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if (target.roleDataId == 1077 or target.roleDataId == 1078) and target.hp * 1000 // target.maxHp <= self.arglist[5] and self.mark ~= true and target.hp > 0 then
    local x = target.x
    local y = target.y
    local grid = self:GetRoleBehindGrid(target)
    if grid ~= nil then
      LuaSkillCtrl:SetRolePos(grid, target)
      self:CallSummoner(target, x, y)
    end
  end
end

function bs_107601:GetRoleBehindGrid(role)
  local grid_dict = LuaSkillCtrl:FindEmptyGridsWithinRange(role.x, role.y, 4)
  if grid_dict == nil or grid_dict.Count <= 0 then
    return nil
  end
  local grid
  for j = 0, grid_dict.Count - 1 do
    grid = grid_dict[j]
    local lsObject = role.lsObject
    local tempdir = CS.TrueSync.TSVector3.Subtract(lsObject.localPosition, grid.fixLogicPosition).normalized
    local qua = CS.TrueSync.TSQuaternion.LookRotation(tempdir)
    if qua.eulerAngles ~= lsObject.localRotation.eulerAngles then
      local angle = CS.TrueSync.TSQuaternion.Angle(qua, lsObject.localRotation):AsInt()
      if -80 < angle and angle < 80 then
        self.caster.recordTable.turn = role
        return grid
      end
    end
    grid = nil
  end
  if grid == nil then
    grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
    return grid
  end
end

function bs_107601:CallSummoner(target, x, y)
  if self.caster ~= nil and self.caster.hp >= 0 then
    local tar = LuaSkillCtrl:GetTargetWithGrid(x, y)
    LuaSkillCtrl:CallEffect(tar, self.config.standBron, self)
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summonerId, x, y)
    local hpAndMaxhp = self.caster.maxHp * self.arglist[8] // 1000
    summoner:SetAttr(eHeroAttr.maxHp, hpAndMaxhp)
    summoner:SetAttr(eHeroAttr.hp, hpAndMaxhp)
    for i, v in ipairs(SyncAttrList) do
      local curValue = self.caster:GetRealProperty(v)
      summoner:SetAttr(v, curValue)
    end
    summoner:SetAsRealEntity(9)
    self.mark = true
    local arg1 = self.arglist[7]
    local arg2 = target.uid
    local arg3 = self.arglist[6]
    local tab = {
      arg_1 = arg1,
      arg_2 = arg2,
      arg_3 = arg3
    }
    summoner:SetRecordTable(tab)
    LuaSkillCtrl:AddSummonerRole(summoner)
  end
end

function bs_107601:OnCasterDie()
  base.OnCasterDie(self)
  self.mark = nil
end

return bs_107601
