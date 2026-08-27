local bs_100704 = require("GamePlay.SkillScripts.RoleSkill.100704_ChelseaPassive")
local bs_100706 = class("bs_100706", bs_100704)
local base = bs_100704
bs_100706.config = {weaponLv = 3, buffId_Dj = 100701}
bs_100706.config = setmetatable(bs_100706.config, {
  __index = base.config
})

function bs_100706:ctor()
end

function bs_100706:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_100706_1", 1, self.OnSetHurt, nil, nil, self.caster.belongNum, nil, eBattleRoleBelong.player, nil, nil, eSkillTag.commonAttack)
  self.caster.recordTable["100706_time"] = self.arglist[4]
end

function bs_100706:OnSetHurt(context)
  if context.target:GetBuffTier(self.config.buffId_Dj) > 0 and 0 < context.target.intensity then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnChelseaStun, context.target)
  end
end

function bs_100706:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100706
