local bs_92088 = class("bs_92088", LuaSkillBase)
local base = LuaSkillBase
bs_92088.config = {}

function bs_92088:ctor()
end

function bs_92088:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_92088_1", 900, self.OnSetDeadHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  self.killer = nil
end

function bs_92088:OnSetDeadHurt(context)
  if context.target.belongNum == eBattleRoleBelong.enemy and context.sender == self.caster then
    local buffs = LuaSkillCtrl:GetRoleBuffs(context.target)
    self.killer = context.sender
    self:DebuffSpread(context.target, buffs)
  end
end

function bs_92088:DebuffSpread(target, buffs)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  local addBuff = buffs
  for i = 0, targetList.Count - 1 do
    if targetList[i].recordTable.equipSummoner then
      break
    end
    self:AddDebuff(targetList[i], addBuff)
  end
end

function bs_92088:AddDebuff(target, buffs)
  if target == nil or target.hp <= 0 then
    return
  end
  if buffs == nil or buffs.Count < 1 then
    return
  end
  for i = 0, buffs.Count - 1 do
    if buffs[i].buffType == 2 then
      local skill = buffs[i].battleSkill
      local sender = buffs[i].maker
      local buffID = buffs[i].dataId
      local tier = buffs[i].tier
      local decade = buffs[i].totalTime
      if buffID == self.config.buffId_taunt2 or buffID == self.config.buffId_taunt then
        local setBuff = LuaSkillCtrl:CallBuff(self, target, buffID, tier, decade, false, sender)
      else
        local setBuff = LuaSkillCtrl:CallBuffWithOriginSkill(skill, target, buffID, tier, decade, false, self.killer)
      end
    end
  end
end

function bs_92088:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92088
