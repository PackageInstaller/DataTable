local sixtower_zhaohuan = class("sixtower_zhaohuan", LuaSkillBase)
local base = LuaSkillBase
sixtower_zhaohuan.config = {buffId = 2242}

function sixtower_zhaohuan:ctor()
end

function sixtower_zhaohuan:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnCallSummoner)
end

function sixtower_zhaohuan:OnCallSummoner(summnoerEntity)
  local belong_num = summnoerEntity.belongNum
  if belong_num ~= eBattleRoleBelong.player and belong_num ~= eBattleRoleBelong.enemy then
    return
  end
  local list = LuaSkillCtrl:GetSelectTeamRoles(belong_num)
  if list == nil or list.Count < 1 then
    return
  end
  for i = 0, list.Count - 1 do
    LuaSkillCtrl:CallBuff(self, list[i], self.config.buffId, 1, self.arglist[3], true, nil, true)
  end
end

function sixtower_zhaohuan:OnCasterDie()
  base.OnCasterDie(self)
end

return sixtower_zhaohuan
