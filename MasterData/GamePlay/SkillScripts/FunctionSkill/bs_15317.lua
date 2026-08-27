local bs_15317 = class("bs_15317", LuaSkillBase)
local base = LuaSkillBase
bs_15317.config = {}

function bs_15317:ctor()
end

function bs_15317:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15317_1", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.player, eBattleRoleBelong.enemy)
  self.target = nil
  self.defNum = 0
  self.magicNum = 0
end

function bs_15317:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not skill.isCommonAttack and target == nil then
    return
  end
  if self.target == target then
    return
  end
  self:clearEffect()
  self.target = target
  self.defNum = self.target.def * self.arglist[1] // 1000
  self.magicNum = self.target.magic_res * self.arglist[1] // 1000
  if self.target ~= nil then
    self.target:AddRoleProperty(eHeroAttr.def, -self.defNum, eHeroAttrType.Extra)
    self.target:AddRoleProperty(eHeroAttr.magic_res, -self.magicNum, eHeroAttrType.Extra)
  end
  if self.caster ~= nil then
    self.caster:AddRoleProperty(eHeroAttr.def, self.defNum, eHeroAttrType.Extra)
    self.caster:AddRoleProperty(eHeroAttr.magic_res, self.magicNum, eHeroAttrType.Extra)
  end
end

function bs_15317:clearEffect()
  if self.target ~= nil then
    if self.caster ~= nil then
      self.caster:AddRoleProperty(eHeroAttr.def, -self.defNum, eHeroAttrType.Extra)
      self.caster:AddRoleProperty(eHeroAttr.magic_res, -self.magicNum, eHeroAttrType.Extra)
    end
    if self.target ~= nil then
      self.target:AddRoleProperty(eHeroAttr.def, self.defNum, eHeroAttrType.Extra)
      self.target:AddRoleProperty(eHeroAttr.magic_res, self.magicNum, eHeroAttrType.Extra)
    end
  end
end

function bs_15317:OnCasterDie()
  base.OnCasterDie(self)
  self:clearEffect()
end

return bs_15317
