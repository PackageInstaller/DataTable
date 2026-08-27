local bs_21262 = class("bs_21262", LuaSkillBase)
local base = LuaSkillBase
bs_21262.config = {check_roleDataId = 40045, buffId = 2230}

function bs_21262:ctor()
end

function bs_21262:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21262", 1, self.OnAfterBattleStart)
end

function bs_21262:OnAfterBattleStart()
  local pf = LuaSkillCtrl:GetPlayerRoleEntity()
  if pf.recordTable.bs_70053 ~= nil and pf.recordTable.bs_70053 == true then
    local elist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    if elist == nil or elist.Count < 1 then
      return
    end
    for i = 0, elist.Count - 1 do
      LuaSkillCtrl:CallBuff(self, elist[i], self.config.buffId, 1, nil, true, nil, true)
    end
  end
end

function bs_21262:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21262
