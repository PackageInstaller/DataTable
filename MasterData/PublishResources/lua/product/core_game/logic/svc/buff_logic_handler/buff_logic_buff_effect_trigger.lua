_class("BuffLogicBuffEffectTrigger", BuffLogicBase)
BuffLogicBuffEffectTrigger = BuffLogicBuffEffectTrigger

function BuffLogicBuffEffectTrigger:Constructor(buffInstance, logicParam)
  self._buffEffectType = logicParam.buffEffectType
  self._buffID = logicParam.buffID
end

function BuffLogicBuffEffectTrigger:DoLogic(notify)
  local buffSvc = self._world:GetService("BuffLogic")
  local owner = self._buffInstance:Entity()
  local success = false
  local buffCount = 0
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    local buffCom = monsterEntity:BuffComponent()
    if buffCom then
      local buffInstance = buffCom:GetSingleBuffByBuffEffect(self._buffEffectType)
      if buffInstance then
        buffSvc:AddBuff(self._buffID, owner)
        buffCount = buffCount + 1
        success = true
      end
    end
  end
  if success then
    self._world:GetService("Trigger"):Notify(NTNotifyTriggerBuff:New(owner))
  end
  local res = BuffResultBuffEffectTrigger:New(buffCount, success)
  return res
end
