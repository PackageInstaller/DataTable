require("br_sealed_curse")
_class("BuffLogicSetSealedCurse", BuffLogicBase)
BuffLogicSetSealedCurse = BuffLogicSetSealedCurse

function BuffLogicSetSealedCurse:DoLogic()
  local e = self._buffInstance:Entity()
  if not e:HasPetPstID() then
    return
  end
  e:BuffComponent():SetFlag(BuffFlags.SealedCurse)
  return BuffResultSealedCurse:New(self._buffInstance:BuffSeq(), true)
end

_class("BuffLogicResetSealedCurse", BuffLogicBase)
BuffLogicResetSealedCurse = BuffLogicResetSealedCurse

function BuffLogicResetSealedCurse:DoLogic()
  local e = self._buffInstance:Entity()
  if not e:HasPetPstID() then
    return
  end
  e:BuffComponent():ResetFlag(BuffFlags.SealedCurse)
  local shouldReady = false
  local localSkillID = e:SkillInfo():GetActiveSkillID()
  if not localSkillID then
    local petPstIDComponent = e:PetPstID()
    local petPstID = petPstIDComponent:GetPstID()
    local petData = self._world:GetPetData(petPstID)
    localSkillID = petData:GetPetActiveSkill()
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(localSkillID)
  local attributesComponent = e:Attributes()
  if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
    local currentPower = attributesComponent:GetAttribute("LegendPower")
    if currentPower >= skillConfigData:GetSkillTriggerParam() then
      shouldReady = true
    end
  else
    local currentPower = attributesComponent:GetAttribute("Power")
    if currentPower <= 0 then
      shouldReady = true
    end
  end
  if shouldReady then
    local blsvc = self._world:GetService("BuffLogic")
    blsvc:ChangePetActiveSkillReady(e, 1)
  end
  return BuffResultSealedCurse:New(self._buffInstance:BuffSeq(), false)
end
