local BrotatoGameWinSkill = class("BrotatoGameWinSkill", LuaSkillBase)
local base = LuaSkillBase
BrotatoGameWinSkill.config = {}

function BrotatoGameWinSkill:ctor()
end

function BrotatoGameWinSkill:InitSkill(isMidwaySkill)
  local battleRoomId = LuaSkillCtrl:GetBattleRoomId()
  local cfg = ConfigData.brotato_sector_stage_extra[battleRoomId]
  if cfg ~= nil then
    if table.contain(cfg.win_condition, 1) then
      self:AddTrigger(eSkillTriggerType.AfterBattleStart, "BrotatoGameWin_1", 1, self.OnAfterBattleStart)
      self.totalTime = cfg.live_time * 15
      self.timeValue = self.totalTime
      LuaSkillCtrl:SetGameScoreAcitve(2, true)
      LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
      LuaSkillCtrl:RecordLimitTime(self.totalTime)
    end
    if table.contain(cfg.win_condition, 2) then
      self.killMonsterRoleDataId = cfg.kill_monster_id
      self:AddOnRoleDieTrigger("BrotatoGameWin_2", 1, self.OnRoleDie)
    end
  end
end

function BrotatoGameWinSkill:OnAfterBattleStart(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.CountDown), nil, 119, 15)
end

function BrotatoGameWinSkill:OnRoleDie(killer, role)
  if role.roleDataId == self.killMonsterRoleDataId then
    LuaSkillCtrl:ForceEndBattle(true)
  end
end

function BrotatoGameWinSkill:CountDown()
  self.timeValue = self.timeValue - 15
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  if self.timeValue <= 0 then
    LuaSkillCtrl:ForceEndBattle(true)
  end
end

function BrotatoGameWinSkill:OnCasterDie()
  base.OnCasterDie(self)
end

return BrotatoGameWinSkill
