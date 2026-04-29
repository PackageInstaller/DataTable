_class("BuffLogicPlayBGM", BuffLogicBase)
BuffLogicPlayBGM = BuffLogicPlayBGM

function BuffLogicPlayBGM:Constructor(buffInstance, logicParam)
  self._bgmID = logicParam.bgmID
  self._useLevelBGM = logicParam.useLevelBGM
end

function BuffLogicPlayBGM:DoLogic()
  local buffResult = BuffResultPlayBGM:New(self._bgmID, self._useLevelBGM)
  return buffResult
end
