local bs_100605 = require("GamePlay.SkillScripts.RoleSkill.100605_FresnelPassive")
local bs_100606 = class("bs_100606", bs_100605)
local base = bs_100605
bs_100606.config = {
  weaponLv = 3,
  hurt_config = 38,
  extra_skill = 100607,
  buffId_hurt = 100602,
  buffId_lz1 = 107101,
  Role_id = 1006,
  buff_100604 = 100604,
  selectId = 6,
  rangeOffset = 10
}
bs_100606.config = setmetatable(bs_100606.config, {
  __index = base.config
})

function bs_100606:ctor()
end

function bs_100606:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_100606_1", 1, self.OnAfterBattleStart)
  LuaSkillCtrl:AddExtraAddSkill(self.config.extra_skill, self.level)
end

function bs_100606:OnAfterBattleStart()
  local list = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.rangeOffset)
  for i = 0, list.Count - 1 do
    if list[i].targetRole.belongNum == self.caster.belongNum and list[i].targetRole.roleType == 1 then
      LuaSkillCtrl:CallBuff(self, list[i].targetRole, self.config.buff_100604, 1, nil, true)
    end
  end
end

function bs_100606:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100606
