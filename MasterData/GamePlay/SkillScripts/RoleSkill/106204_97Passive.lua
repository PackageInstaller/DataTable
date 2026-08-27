local bs_106201 = require("GamePlay.SkillScripts.RoleSkill.106201_97Passive")
local bs_106204 = class("bs_106204", bs_106201)
local base = bs_106201
bs_106204.config = {weaponLv = 1, buff_1 = 106206}
bs_106204.config = setmetatable(bs_106204.config, {
  __index = base.config
})

function bs_106204:ctor()
end

function bs_106204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_106204_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_106204_2", 1, self.OnSetHurt, nil, nil, self.caster.belongNum, eBattleRoleBelong.enemy)
end

function bs_106204:OnAfterBattleStart()
  local target = LuaSkillCtrl:CallTargetSelect(self, 21, 20)
  if target == nil or target.Count == 0 then
    return
  end
  local grid = self:FindGrid(target[0].targetRole)
  if table.length(self.table) < self.maxCount and grid ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_showdd, self)
    self:Summon(grid)
  end
end

function bs_106204:OnSetHurt(context)
  if context.sender.roleDataId == 62 then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buff_1, 1, self.arglist[14])
  end
end

function bs_106204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106204
