local bs_104002 = require("GamePlay.SkillScripts.RoleSkill.104002_DusevnyjSkill")
local bs_104006 = class("bs_104006", bs_104002)
local base = bs_104002
bs_104006.config = {
  weaponLv = 3,
  buffID = 104015,
  hurt_config2 = 3,
  effectID_ZW = 104013
}
bs_104006.config = setmetatable(bs_104006.config, {
  __index = base.config
})

function bs_104006:ctor()
end

function bs_104006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_104006_2", 1, self.OnSetHurt, nil, nil, self.caster.belongNum, nil, nil, nil, nil, eSkillTag.commonAttack, false)
end

function bs_104006:OnSetHurt(context)
  local target = context.target
  if context.skill.isCommonAttack and not context.isMiss and target ~= nil and target.hp > 0 and self.caster.recordTable.skill_open == true and not context.isTriggerSet and target.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffID, 1, nil)
    local maskEffect
    local isFullTier = false
    local num = target:GetBuffTier(self.config.buffID)
    if 0 < num then
      isFullTier = num >= self.arglist[2]
      local battleBuff = target:GetRoleBuffById(self.config.buffID)
      local listBattleEffect = battleBuff.listBattleEffect
      if 0 < listBattleEffect.Count then
        maskEffect = listBattleEffect[0]
        if isFullTier then
          LuaSkillCtrl:EffectSetCountAllActive(maskEffect, false)
        else
          local MaskEffectNum = num - 1
          LuaSkillCtrl:EffectSetCountActive(maskEffect, MaskEffectNum, true)
        end
      end
    end
    if isFullTier then
      local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, self.config.hurt_config2, {
        self.arglist[3]
      }, true)
      skillResult1:EndResult()
      LuaSkillCtrl:CallEffect(target, self.config.effectID_ZW, self)
      LuaSkillCtrl:DispelBuff(target, self.config.buffID, 0, true)
    end
  end
end

function bs_104006:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_104006:LuaDispose()
  base.LuaDispose(self)
  self.Mask = nil
  self.MaskEffect = nil
end

return bs_104006
