require("base_ins_r")
_class("PlayCasterUISkillPassiveInstruction", BaseInstruction)
PlayCasterUISkillPassiveInstruction = PlayCasterUISkillPassiveInstruction

function PlayCasterUISkillPassiveInstruction:Constructor(paramList)
  self._active = tonumber(paramList.active)
end

function PlayCasterUISkillPassiveInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if not casterEntity:PetPstID() then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivatePassive, casterEntity:PetPstID():GetPstID(), self._active == 1)
end
