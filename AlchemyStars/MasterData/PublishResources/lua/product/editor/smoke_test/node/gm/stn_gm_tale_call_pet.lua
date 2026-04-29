require("common_async_base")
_class("GM_TaleCallPet", Common_AsyncBase)
GM_TaleCallPet = GM_TaleCallPet

function GM_TaleCallPet:Constructor(_manager, id)
  self._talePetID = id
end

function GM_TaleCallPet:TaskFunc(TT, status)
  self._manager:AsyncGM_TaleCallPet(TT, status, self._talePetID)
end
