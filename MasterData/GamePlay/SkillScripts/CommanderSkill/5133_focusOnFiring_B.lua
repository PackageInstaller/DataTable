local base = require("GamePlay.SkillScripts.CommanderSkill.5131_focusOnFiring")
local bs_5133 = class("bs_5133", base)
bs_5133.config = {buffId = 513101, buffId_ex = 513201}
bs_5133.config = setmetatable(bs_5133.config, {
  __index = base.config
})
bs_5133.AbandonTakeFeature = {
  eBuffFeatureType.BeatBack
}

function bs_5133:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_5133_1", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddBuffDieTrigger("bs_5133_2", 1, self.OnBuffDie, nil, nil, self.config.buffId)
end

function bs_5133:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.hp <= 0 or target:GetBuffTier(self.config.buffId_ex) < 1 then
    return
  end
  if sender.recordTable["5133_heal"] == nil then
    local healnum = sender.maxHp * self.arglist[2] // 1000
    local heal_config = {heal_number = healnum}
    if 0 < healnum then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender)
      LuaSkillCtrl:HealResult(skillResult, heal_config, nil, false, true)
      skillResult:EndResult()
      sender.recordTable["5133_heal"] = true
    end
  end
end

function bs_5133:OnBuffDie(buff, target, removeType)
  if target.hp <= 0 then
    return
  end
  if removeType == eBuffRemoveType.Timeout then
    target.recordTable["5133_heal"] = nil
  end
end

function bs_5133:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5133
