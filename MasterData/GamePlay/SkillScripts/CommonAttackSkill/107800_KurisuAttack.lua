local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_107800 = class("bs_107800", bs_1)
local base = bs_1
bs_107800.config = {
  effectId_trail = 107801,
  select_Id = 42,
  hurt_id_1 = 45,
  hurt_id_2 = 46,
  hurt_id_3 = 49
}
bs_107800.config = setmetatable(bs_107800.config, {
  __index = base.config
})

function bs_107800:ctor()
end

function bs_107800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerSkill, self.OnKurisuSummonerSkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerHurt, self.OnKurisuSummonerHurt)
  self.hurtArgs = {}
end

function bs_107800:OnKurisuSummonerSkill(luaSkill, type, skillTag)
  if skillTag == eSkillTag.commonAttack then
    if type == 0 then
      LuaSkillCtrl:CallBeforSkillPlayTrigger(self, self.caster)
    elseif type == 1 then
      LuaSkillCtrl:CallAfterSkillPlayTrigger(self, self.caster)
    end
  end
end

function bs_107800:OnKurisuSummonerHurt(skillTag, target, effect, times)
  if skillTag == eSkillTag.commonAttack then
    if times == 4 then
      local args = LuaSkillCtrl:CreatCacheTable(self.caster.recordTable.first_attack, self.hurtArgs)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_id_2, args, false)
      skillResult:EndResult()
    else
      local args = LuaSkillCtrl:CreatCacheTable(self.caster.recordTable.tanshe_attack, self.hurtArgs)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_id_3, args, true)
      skillResult:EndResult()
    end
  end
end

function bs_107800:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_id_1, {1000}, false)
    skillResult:EndResult()
  end
end

function bs_107800:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107800
