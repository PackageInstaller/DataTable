local CO = require("Common/Coroutine")
local S = require("Common/Singleton")
local m_uiManager = S:Get("UIWindowManager")
local m_dirty = false

function MarkAsDirty()
  if not m_dirty then
    m_dirty = true
    m_uiManager.PendingRefresh(Apply)
  end
end

function Start()
end

function OnDestroy()
  if m_dirty then
    m_uiManager.CancelPendingRefresh(Apply)
    m_dirty = false
  end
end

function Apply()
  if m_dirty then
    __impl.Draw()
    m_dirty = false
  end
end
