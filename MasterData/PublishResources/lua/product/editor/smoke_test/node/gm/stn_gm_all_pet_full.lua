require("common_async_base")
_class("GM_AllPetFull", Common_AsyncBase)
GM_AllPetFull = GM_AllPetFull

function GM_AllPetFull:TaskFunc(TT, status)
  self.m_pManager:AsyncGM_AllPetFull(TT, status)
end
