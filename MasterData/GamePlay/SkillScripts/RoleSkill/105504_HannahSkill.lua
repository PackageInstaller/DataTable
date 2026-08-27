local bs_105502 = require("GamePlay.SkillScripts.RoleSkill.105502_HannahSkill")
local bs_105504 = class("bs_105504", bs_105502)
local base = bs_105502
bs_105504.config = {
  buffId_crit1 = 105503,
  buffId_crit2 = 105504,
  weaponLv = 1
}
bs_105504.config = setmetatable(bs_105504.config, {
  __index = base.config
})

function bs_105504:ctor()
end

function bs_105504:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_105504_2", 4, self.OnAfterAddBuff, self.caster, nil, nil, eBattleRoleBelong.player, nil)
  self:AddBuffDieTrigger("bs_105504_1", 10, self.OnBuffDie, nil, eBattleRoleBelong.player, nil)
end

function bs_105504:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_crit1 and target ~= nil and target.hp > 0 then
    target:AddRoleProperty(eHeroAttr.pow, self:CalcuPowNum(true, false), eHeroAttrType.Extra)
  elseif buff.dataId == self.config.buffId_crit2 and target ~= nil and target.hp > 0 then
    target:AddRoleProperty(eHeroAttr.pow, self:CalcuPowNum(true, true), eHeroAttrType.Extra)
  end
end

function bs_105504:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_crit1 and target ~= nil and target.hp > 0 then
    target:AddRoleProperty(eHeroAttr.pow, self:CalcuPowNum(false, false), eHeroAttrType.Extra)
  elseif buff.dataId == self.config.buffId_crit2 and target ~= nil and target.hp > 0 then
    target:AddRoleProperty(eHeroAttr.pow, self:CalcuPowNum(false, true), eHeroAttrType.Extra)
  end
end

function bs_105504:CalcuPowNum(isAdd, powerFull)
  local pow_origin = self.caster.originAttrList[eHeroAttr.skill_intensity]
  local addNum
  if isAdd then
    addNum = pow_origin
  else
    addNum = -pow_origin
  end
  if not powerFull then
    return addNum * self.arglist[6] // 1000
  else
    return addNum * self.arglist[7] // 1000
  end
end

function bs_105504:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105504
