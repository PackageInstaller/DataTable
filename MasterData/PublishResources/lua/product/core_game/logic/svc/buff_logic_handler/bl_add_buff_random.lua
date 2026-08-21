_class("BuffLogicAddBuffRandom", BuffLogicBase)
BuffLogicAddBuffRandom = BuffLogicAddBuffRandom

function BuffLogicAddBuffRandom:Constructor(buffInstance, logicParam)
  self._buffIDList = logicParam.buffIDList or {}
  self._buffCount = #self._buffIDList
end

function BuffLogicAddBuffRandom:DoLogic(notify)
  if notify.GetDefenderEntity then
    local target = notify:GetDefenderEntity()
    local result = BuffResultAddBuff:New()
    local owner = self._buffInstance:Entity()
    local caster = self._buffInstance:Context() and self._buffInstance:Context().casterEntity or owner
    local buffSource = BuffSource:New(BuffSourceType.Buff, caster:GetID())
    local world = self._buffInstance:World()
    local buffSvc = world:GetService("BuffLogic")
    local randomSvc = world:GetService("RandomLogic")
    local index = randomSvc:LogicRand(1, self._buffCount)
    local buffID = self._buffIDList[index]
    Log.debug("Before RandomAddBuff Index=", index, " BuffID=", buffID, " TargetID=", target:GetID())
    local ins = buffSvc:AddBuff(buffID, target, {casterEntity = caster}, buffSource)
    if ins then
      Log.debug("End RandomAddBuff Index=", index, " BuffID=", buffID, " BuffSeq=", ins:BuffSeq(), " TargetID=", target:GetID())
      result:AddBuffData(target:GetID(), ins:BuffSeq())
    end
    return result
  end
end
