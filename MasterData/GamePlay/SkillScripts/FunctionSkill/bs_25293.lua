local bs_25293 = class("bs_25293", LuaSkillBase)
local base = LuaSkillBase
bs_25293.config = {buffId = 2150, duration = 75}

function bs_25293:ctor()
end

function bs_25293:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallSummonerBuff)
end

function bs_25293:CallSummonerBuff(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetlist.Count < 1 then
      return
    end
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleType == eBattleRoleType.realSummoner then
        local targetRole = targetlist[i]
        if targetRole:GetBuffTier(self.config.buffId) < self.arglist[2] then
          LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
        end
      end
    end
  end
end

function bs_25293:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25293
