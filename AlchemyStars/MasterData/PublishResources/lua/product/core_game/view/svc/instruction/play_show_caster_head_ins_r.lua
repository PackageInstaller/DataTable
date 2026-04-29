require("base_ins_r")
_class("PlayShowCasterHeadInstruction", BaseInstruction)
PlayShowCasterHeadInstruction = PlayShowCasterHeadInstruction

function PlayShowCasterHeadInstruction:Constructor(paramList)
  self._isShow = paramList.isShow
end

function PlayShowCasterHeadInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local petPstId = 0
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    petPstId = casterEntity:GetSuperEntity():PetPstID():GetPstID()
  else
    petPstId = casterEntity:PetPstID():GetPstID()
  end
  if self._isShow == "1" then
    world:EventDispatcher():Dispatch(GameEventType.InOutQueue, petPstId, true)
  else
    world:EventDispatcher():Dispatch(GameEventType.InOutQueue, petPstId, false)
  end
end
