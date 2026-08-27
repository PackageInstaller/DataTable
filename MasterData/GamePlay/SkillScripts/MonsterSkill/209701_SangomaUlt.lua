local bs_209701 = class("bs_209701", LuaSkillBase)
local base = LuaSkillBase
bs_209701.config = {
  buffAtkDown = 108403,
  effectLine = 108422,
  effectsummon = 108421,
  buffId_focusOnFiring = 107907,
  selectId = 9,
  effectDead = 108423
}

function bs_209701:ctor()
end

function bs_209701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.master = self.caster.recordTable.arg_1
  self.alive = self.caster.recordTable.arg_2
  self.timer = nil
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnAfterBattleStart)
  self:AddOnRoleDieTriggerForTable("bs_209701_2", 1, self.OnRoleDie, {
    target = self.master
  })
end

function bs_209701:OnAfterBattleStart(role)
  if role == self.caster then
    self.bounus = true
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectsummon, self)
    self.line = LuaSkillCtrl:CallEffect(self.master, self.config.effectLine, self)
    local tarList = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId, 1)
    if tarList ~= nil and tarList.Count > 0 then
      for i = 0, tarList.Count - 1 do
        LuaSkillCtrl:CallBuff(self, tarList[i].targetRole, self.config.buffId_focusOnFiring, 1, 30)
      end
    end
    if role == self.caster then
      self.timer = LuaSkillCtrl:StartTimer(nil, self.alive, function()
        self:KillSelf()
      end)
    end
  end
end

function bs_209701:OnRoleDie(killer, role)
  self:KillSelf()
end

function bs_209701:KillSelf()
  if self.caster == nil then
    return
  end
  self.bounus = false
  local hurt = self.caster.maxHp + 1
  LuaSkillCtrl:RemoveLife(hurt, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
end

function bs_209701:OnCasterDie()
  LuaSkillCtrl:SetRoleVisible(self.caster, false)
  if self.line ~= nil then
    self.line:Die()
    self.line = nil
  end
  if self.bounus then
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnSangomaSummonerDead, self.master)
  end
  base.OnCasterDie(self)
end

function bs_209701:LuaDispose()
  if self.line ~= nil then
    self.line:Die()
    self.line = nil
  end
  base.LuaDispose(self)
end

return bs_209701
