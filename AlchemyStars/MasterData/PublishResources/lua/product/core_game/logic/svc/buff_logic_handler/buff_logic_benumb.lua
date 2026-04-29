_class("BuffLogicSetBenumb", BuffLogicBase)
BuffLogicSetBenumb = BuffLogicSetBenumb

function BuffLogicSetBenumb:Constructor(buffInstance, logicParam)
end

function BuffLogicSetBenumb:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetFlag(BuffFlags.Benumb)
  if e:HasMonsterID() then
    local cAI = e:AI()
    local vmb = cAI:GetMobilityValid()
    if 0 < vmb then
      cAI:ClearMobilityTotal()
    end
    e:Attributes():Modify("MaxMobility", 1)
  end
  self._world:GetService("Trigger"):Notify(NTBenumbed:New(e))
  return true
end

_class("BuffLogicResetBenumb", BuffLogicBase)
BuffLogicResetBenumb = BuffLogicResetBenumb

function BuffLogicResetBenumb:Constructor(buffInstance, logicParam)
end

function BuffLogicResetBenumb:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():ResetFlag(BuffFlags.Benumb)
  if e:HasMonsterID() then
    e:Attributes():Modify("MaxMobility", 99)
  end
  return true
end
