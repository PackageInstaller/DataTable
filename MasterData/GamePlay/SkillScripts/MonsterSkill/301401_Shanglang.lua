local bs_301401 = class("bs_301401", LuaSkillBase)
local base = LuaSkillBase
bs_301401.config = {
  waveRadium = 30,
  waveTotalEffect = 10924,
  waveTotalEffectfan = 10925,
  waveEffect = 0,
  waveEffectBoom = 0,
  phaseMoveBuffId = 63,
  flyBuff = 110002,
  stunBuff = 1000,
  beatBackDurationTimePerGrid = 2,
  buffId_198 = 198,
  waringDelay = 30
}
local WaveDir = {left = 1, right = -1}

function bs_301401:ctor()
end

function bs_301401:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_301401_1", 1, self.OnStartBattle)
end

function bs_301401:OnStartBattle()
  self.waveDir = WaveDir.left
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_198, 1, nil, true)
end

function bs_301401:CallNextWaveCountDown()
  MsgCenter:Broadcast(eMsgEventId.WaveComing, eWaveType.entropyWave)
end

function bs_301401:PlaySkill(data)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.waringDelay, arriveCallBack)
  self:CallNextWaveCountDown()
end

function bs_301401:OnArriveAction()
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  if self.waveDir > 0 then
    LuaSkillCtrl:CallEffect(target, self.config.waveTotalEffect, self)
  else
    LuaSkillCtrl:CallEffect(target, self.config.waveTotalEffectfan, self)
  end
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.CallWave, self.waveDir, self.config.effectId, true, true)
  self.waveDir = self.waveDir * -1
end

function bs_301401:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_301401
