require("llb_logic_base")
_class("LLBuffLogicGenerateCard", LLBuffLogicBase)
LLBuffLogicGenerateCard = LLBuffLogicGenerateCard

function LLBuffLogicGenerateCard:Constructor(buffObj, logicParam)
  self._type = logicParam.type
  self._id = logicParam.id
end

function LLBuffLogicGenerateCard:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local llEntMng = notifyEntity:GetLuckLandModule():GetEntityMng()
  if self._type == LuckLandEntityType.Pet then
    llEntMng:PetEnterBackpack(llEntMng:CreateEntity(self._type, self._id))
  elseif self._type == LuckLandEntityType.Monster and not llEntMng:IsFightMonstersFull() then
    llEntMng:AppendMonster(llEntMng:CreateEntity(self._type, self._id))
  end
end
