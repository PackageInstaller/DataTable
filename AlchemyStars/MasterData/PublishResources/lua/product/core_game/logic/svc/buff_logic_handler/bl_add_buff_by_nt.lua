_class("BuffLogicAddBuffByAddBuff", BuffLogicBase)
BuffLogicAddBuffByAddBuff = BuffLogicAddBuffByAddBuff

function BuffLogicAddBuffByAddBuff:Constructor(buffInstance, logicParam)
  self.prob = logicParam.prob or {}
end

function BuffLogicAddBuffByAddBuff:DoLogic(notify)
  if notify:GetNotifyType() == NotifyType.AfterEntityAddBuff then
    local buffID = notify:GetBuffId()
    local target = notify:GetNotifyEntity()
    local result = BuffResultAddBuff:New()
    local owner = self._buffInstance:Entity()
    local caster = self._buffInstance:Context() and self._buffInstance:Context().casterEntity or owner
    local randomSvc = self._world:GetService("RandomLogic")
    local bAdd = false
    for _, probNum in ipairs(self.prob) do
      local rand = randomSvc:LogicRand(1, 100)
      if probNum >= rand then
        local buffSource = BuffSource:New(BuffSourceType.Buff, caster:GetID())
        local world = self._buffInstance:World()
        local buffSvc = world:GetService("BuffLogic")
        local ins = buffSvc:AddBuff(buffID, target, {casterEntity = caster}, buffSource, nil, true)
        if ins then
          bAdd = true
          result:AddBuffData(target:GetID(), ins:BuffSeq())
          Log.debug("AddBuffByAddBuff TargetID:", target:GetID(), " BuffID:", buffID, " BuffSeq:", ins:BuffSeq())
        end
      else
        break
      end
    end
    if bAdd then
      result:SetAddBuffSeq(notify:GetBuffSeq())
      return result
    end
  end
end
