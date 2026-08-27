local bs_105101 = require("GamePlay.SkillScripts.RoleSkill.105101_NascitaPassive")
local bs_105104 = class("bs_105404", bs_105101)
local base = bs_105101
bs_105104.config = {
  buffId_claw = 1051012,
  buffId_CD = 1051014,
  buffId_miss = 1051015,
  weaponLv = 1
}
bs_105104.config = setmetatable(bs_105104.config, {
  __index = base.config
})

function bs_105104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("105104_1", 2, self.OnAfterAddBuff, nil, nil, nil, nil, nil)
  self:AddBeforeAddBuffTrigger("bs_105104_beforeBuff", 1, self.OnBeforeAddBuff, nil, nil, nil, eBattleRoleBelong.enemy, self.config.buffId_claw)
  self:AddBuffDieTrigger("bs_105104_2", 3, self.OnBuffDie, self.caster, nil, self.config.buffId_CD)
  self.clawNum = 0
  self.beforeNum = 0
  self.afterNum = 0
  self.HpSum = 0
end

function bs_105104:OnBeforeAddBuff(target, context)
  if target ~= self.caster and target.hp > 0 and 0 < self.caster:GetBuffTier(self.config.buffId_CD) then
    self.beforeNum = target:GetBuffTier(self.config.buffId_claw)
  end
end

function bs_105104:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_CD and target == self.caster and target.hp > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_miss, 1)
  end
  if buff.dataId == self.config.buffId_claw and target.hp > 0 and 0 < self.caster:GetBuffTier(self.config.buffId_CD) then
    self.afterNum = target:GetBuffTier(self.config.buffId_claw)
    self.clawNum = self.clawNum + self.afterNum - self.beforeNum
  end
end

function bs_105104:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_CD and target == self.caster and target.hp > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_miss, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_miss, 1, self.arglist[8])
    local originAttrList = self.caster.originAttrList
    local MaxHp = originAttrList[eHeroAttr.maxHp] * self.arglist[10] // 1000
    if MaxHp >= self.HpSum then
      local Num = self.caster.pow * self.arglist[9] // 1000 * self.clawNum
      if MaxHp < self.HpSum + Num then
        Num = MaxHp - self.HpSum
      end
      if 0 <= Num then
        self.caster:AddRoleProperty(eHeroAttr.maxHp, Num, eHeroAttrType.Extra)
        LuaSkillCtrl:CallHeal(Num, self, self.caster, true)
        self.HpSum = self.HpSum + Num
      end
    end
    self.clawNum = 0
  end
end

function bs_105104:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105104
