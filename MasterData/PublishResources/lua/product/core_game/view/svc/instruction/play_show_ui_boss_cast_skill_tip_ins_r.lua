require("base_ins_r")
_class("PlayShowUIBossCastSkillTipInstruction", BaseInstruction)
PlayShowUIBossCastSkillTipInstruction = PlayShowUIBossCastSkillTipInstruction

function PlayShowUIBossCastSkillTipInstruction:Constructor(paramList)
  self._maxNum = tonumber(paramList.maxNum) or 30
end

function PlayShowUIBossCastSkillTipInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  world:EventDispatcher():Dispatch(GameEventType.UIInitBossCastSkillTipInfo, self._maxNum)
end
