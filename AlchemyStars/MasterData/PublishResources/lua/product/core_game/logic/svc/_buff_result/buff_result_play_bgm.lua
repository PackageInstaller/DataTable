require("_buff_result_base")
_class("BuffResultPlayBGM", BuffResultBase)
BuffResultPlayBGM = BuffResultPlayBGM

function BuffResultPlayBGM:Constructor(bgmID, useLevelBGM)
  self._bgmID = bgmID
  self._useLevelBGM = useLevelBGM
end

function BuffResultPlayBGM:GetBGMID()
  return self._bgmID
end

function BuffResultPlayBGM:GetuseLevelBGM()
  return self._useLevelBGM
end
