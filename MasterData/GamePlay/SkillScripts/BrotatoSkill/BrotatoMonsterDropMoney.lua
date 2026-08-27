local BrotatoMonsterDropMoney = class("BrotatoMonsterDropMoney", LuaSkillBase)
local base = LuaSkillBase
BrotatoMonsterDropMoney.config = {
  effect1Id = 5,
  effect2Id = 8,
  effect3Id = 9,
  effectDoubleId = 7
}

function BrotatoMonsterDropMoney:ctor()
end

function BrotatoMonsterDropMoney:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnBrotatoMonsterDie, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "BrotatoMonsterDropMoney_2", 1, self.BeforeEndBattle)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "BrotatoMonsterDropMoney_3", 1, self.AfterBattleStart)
  self.totalMoney = 0
  self.hasPickupMoney = 0
  self.notPickupMoney = 0
end

function BrotatoMonsterDropMoney:AfterBattleStart()
  self.notPickupMoney = LuaSkillCtrl:GetNotPickupGold() or 0
  self.notPickupMoneyCache = self.notPickupMoney
  LuaSkillCtrl:SetCacheGold(0)
  MsgCenter:Broadcast(eMsgEventId.EpMoneyChange)
end

function BrotatoMonsterDropMoney:OnRoleDie(killer, role)
  local dropMoneyCount = role.recordTable.moneyNum
  if dropMoneyCount ~= nil then
    local effectId
    if dropMoneyCount < 3 then
      effectId = self.config.effect1Id
    elseif dropMoneyCount < 6 then
      effectId = self.config.effect2Id
    else
      effectId = self.config.effect3Id
    end
    if self.notPickupMoney > 0 then
      if dropMoneyCount <= self.notPickupMoney then
        self.notPickupMoney = self.notPickupMoney - dropMoneyCount
        dropMoneyCount = dropMoneyCount * 2
      else
        dropMoneyCount = dropMoneyCount + self.notPickupMoney
        self.notPickupMoney = 0
      end
      effectId = self.config.effectDoubleId
    end
    self.totalMoney = self.totalMoney + dropMoneyCount
    local target = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
    local effect = LuaSkillCtrl:CallEffect(target, effectId, self)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter, effect, dropMoneyCount)
    local range = self.caster.recordTable.brotatoDropRange
    if range == nil then
      self.caster.recordTable.brotatoDropRange = 50
      range = 50
    end
    LuaSkillCtrl:CallAddCircleColliderForEffect(effect, range, eColliderInfluenceType.Player, nil, collisionEnter)
  end
end

function BrotatoMonsterDropMoney:OnCollisionEnter(effect, dropMoneyCount, collider, index, entity)
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
  self.hasPickupMoney = self.hasPickupMoney + dropMoneyCount
  LuaSkillCtrl:SetCacheGold(self.hasPickupMoney)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.PickUpCoins)
  MsgCenter:Broadcast(eMsgEventId.EpMoneyChange)
  LuaSkillCtrl:ClearColliderOrEmission(collider)
  if not LuaSkillCtrl.IsInVerify then
    AudioManager:PlayAudioById(1090)
  end
end

function BrotatoMonsterDropMoney:BeforeEndBattle()
  if self.hasPickupMoney >= self.notPickupMoneyCache then
    local curNotPickUpMoney = self.totalMoney - self.hasPickupMoney
    LuaSkillCtrl:SetNotPickupGold(curNotPickUpMoney)
  else
  end
end

function BrotatoMonsterDropMoney:OnCasterDie()
  base.OnCasterDie(self)
end

return BrotatoMonsterDropMoney
