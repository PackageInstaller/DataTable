require("common_async_base")
_class("GM_AddResource", Common_AsyncBase)
GM_AddResource = GM_AddResource

function GM_AddResource:Constructor(_manager, resourceId, count)
  self.m_resourceId = resourceId
  self.m_count = count
end

function GM_AddResource:TaskFunc(TT, status)
  self._manager:AsyncGM_AddAsset(TT, status, self.m_resourceId, self.m_count)
end
