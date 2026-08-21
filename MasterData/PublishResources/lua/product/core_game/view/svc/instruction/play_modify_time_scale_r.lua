require("base_ins_r")
_class("PlayModifyTimeScaleInstruction", BaseInstruction)
PlayModifyTimeScaleInstruction = PlayModifyTimeScaleInstruction
local ModifyTimeScaleType = {Reset = 0, SetTimeScale = 1}
_enum("ModifyTimeScaleType", ModifyTimeScaleType)

function PlayModifyTimeScaleInstruction:Constructor(paramList)
  self._modifyType = tonumber(paramList.type)
  if self._modifyType == ModifyTimeScaleType.SetTimeScale then
    self._timeScale = tonumber(paramList.timeScale)
  end
end

function PlayModifyTimeScaleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._modifyType == ModifyTimeScaleType.Reset then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, true)
  elseif self._modifyType == ModifyTimeScaleType.SetTimeScale and self._timeScale then
    HelperProxy:GetInstance():SetGameTimeScale(self._timeScale)
    AudioHelperController.SetInnerGameSoundPlaySpeed(self._timeScale)
  end
end
