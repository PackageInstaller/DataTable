require("common_async_base")
_class("GM_AddAllPet", Common_AsyncBase)
GM_AddAllPet = GM_AddAllPet

function GM_AddAllPet:TaskFunc(TT, status)
  self.m_pManager:AsyncGM_AddAllPet(TT, status)
end
