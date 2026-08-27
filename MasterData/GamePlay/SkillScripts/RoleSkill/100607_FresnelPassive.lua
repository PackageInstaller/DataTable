local bs_100605 = require("GamePlay.SkillScripts.RoleSkill.100605_FresnelPassive")
local bs_100607 = class("bs_100607", bs_100605)
local base = bs_100605
bs_100607.config = {
  weaponLv = 3,
  Role_id = 1006,
  selectId = 2,
  buff_100604 = 100604,
  rangeOffset = 10
}
bs_100607.config = setmetatable(bs_100607.config, {
  __index = base.config
})

function bs_100607:ctor()
end

function bs_100607:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_100607_1", 1, self.OnAfterBattleStart)
  self.BenchRole = LuaSkillCtrl:GetOriginRole(self.config.Role_id)
end

function bs_100607:OnAfterBattleStart()
  if self.BenchRole == nil then
    return
  end
  if self.BenchRole.roleOnBench then
    local list = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.rangeOffset)
    for i = 0, list.Count - 1 do
      if list[i].targetRole.belongNum == self.caster.belongNum and list[i].targetRole.roleType == 1 then
        LuaSkillCtrl:CallBuff(self, list[i].targetRole, self.config.buff_100604, 1, nil, true)
      end
    end
  end
end

function bs_100607:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100607
