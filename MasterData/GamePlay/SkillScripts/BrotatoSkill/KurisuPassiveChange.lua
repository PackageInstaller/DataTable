local KurisuPassiveChange = {}
KurisuPassiveChange.config = {SummonerCount = 2}

function KurisuPassiveChange:InitSkill(isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_107801_2", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffid_counter)
  self:AddLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerSkill, self.OnKurisuSummonerSkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnKurisuSummonerHurt, self.OnKurisuSummonerHurt)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRecoverHeal, self.OnRecoverHeal)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107801_2", 2, self.OnAfterBattleStart)
  self.energyNum = 0
  self.energyP1 = self.arglist[1]
  self.energyP2 = self.arglist[2]
  self.energyPow = self.arglist[3] + self.arglist[2]
  self.attackChange = 0
  self.caster.recordTable.first_attack = self.arglist[5]
  self.caster.recordTable.tanshe_attack = self.arglist[6]
  self:AddLuaTrigger(eSkillLuaTrigger.OnPlayChang, self.OnPlayChang)
  self.exSummoner = 0
  self.caster.recordTable.Kurisu_Mode = 0
  self.caster.recordTable.Kurisu_tanshe = 4
  self.MaxSummonerNum = 3
  self.caster.recordTable.Kurisu_CdReset = 45
  self.table = {}
end

function KurisuPassiveChange:OnAfterBattleStart()
end

function KurisuPassiveChange:OnPlayChang(data)
  if self.caster.recordTable.Kurisu_Mode ~= 2 then
    return
  end
  local SummonerNum = self.exSummoner // self.config.SummonerCount
  local temp_SummonerNum = SummonerNum
  self.exSummoner = self.exSummoner + 1
  local SummonerNum = self.exSummoner // self.config.SummonerCount
  if SummonerNum ~= temp_SummonerNum and self.MaxSummonerNum > 0 then
    self:Summon()
    self.MaxSummonerNum = self.MaxSummonerNum - 1
  end
end

function KurisuPassiveChange:OnAfterAddBuff(buff, target)
  if self.caster.recordTable.Kurisu_Mode == 3 then
    return
  else
    if target ~= self.caster or self.caster == nil or self.caster.hp <= 0 then
      return
    end
    local tempattacktype = self.attackChange
    self.energyNum = self.caster:GetBuffTier(self.config.buffid_counter)
    if self.energyNum >= self.energyPow then
      LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnPlayChang, true)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffid_counter, self.arglist[3])
    elseif self.energyNum >= self.energyP2 then
      self.attackChange = 2
    elseif self.energyNum >= self.energyP1 then
      self.attackChange = 1
    end
    if tempattacktype ~= self.attackChange then
      self:Summon()
      if self.attackChange == 2 then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid_attack, 1, nil, false)
      end
    end
  end
end

return KurisuPassiveChange
