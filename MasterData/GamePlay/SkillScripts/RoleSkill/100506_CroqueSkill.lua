local bs_100505 = require("GamePlay.SkillScripts.RoleSkill.100505_CroqueSkill")
local bs_100506 = class("bs_100506", bs_100505)
local base = bs_100505
bs_100506.config = {
  weaponLv = 3,
  buffId_jianshang = 100503,
  buffId_chiyan = 107101
}
bs_100506.config = setmetatable(bs_100506.config, {
  __index = base.config
})

function bs_100506:ctor()
end

function bs_100506:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_100506_3", 1, self.OnSetHurt, nil, self.caster, eBattleRoleBelong.enemy)
end

function bs_100506:OnSetHurt(context)
  if context.sender:GetBuffTier(self.config.buffId_chiyan) > 0 and context.sender.belongNum == 2 then
    context.hurt = context.hurt * (1000 - self.arglist[8]) // 1000
  end
end

return bs_100506
