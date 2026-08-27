local bs_10294 = class("bs_10294", LuaSkillBase)
local base = LuaSkillBase
bs_10294.config = {}

function bs_10294:ctor()
end

function bs_10294:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10294_10", 1, self.OnRoleDie)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRevengeCall, self.eventFunc)
  self.rand_flag = 1
  local cm = LuaSkillCtrl:GetPlayerRoleEntity()
  if cm.recordTable["30043"] == nil then
    cm.recordTable["30043"] = {}
    for i = 1, 5 do
      cm.recordTable["30043"][i] = -1
    end
  end
  cm.recordTable["30043"][self.rand_flag] = self.rand_flag
end

function bs_10294:OnRoleDie(killer, role)
  if role.belongNum ~= eBattleRoleBelong.player or role.roleType ~= eBattleRoleType.character then
    return
  end
  local value = ConfigData.game_config.ultMpCost * self.arglist[1] // 1000
  LuaSkillCtrl:CallAddPlayerHmp(value)
end

function bs_10294:eventFunc(killer, role, tb)
  local isCastable = false
  for i = 1, #tb do
    if tb[i] == self.rand_flag then
      isCastable = true
      break
    end
  end
  if not isCastable then
    return
  end
  self:OnRoleDie(killer, role)
end

function bs_10294:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10294
