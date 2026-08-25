local CursorManager, Super = System.NewClass("CursorManager", Manager)
local DEFAULT_CURSOR_PATH = "Icon/Cursor/Icon_Cursor_Default.png"
local DEFAULT_HOTSPOT = CS.UnityEngine.Vector2(0, 0)
local T_Texture2D = typeof(CS.UnityEngine.Texture2D)

function CursorManager:ctor()
  Super.ctor(self)
end

function CursorManager:Awake()
  Super.Awake(self)
  if ApplicationUtils.IsWindowsOrEditor() then
    self:SetDefaultCursor()
  end
end

function CursorManager:SetDefaultCursor()
  local tex = ResLoadMgr.LoadAsset(DEFAULT_CURSOR_PATH, self, T_Texture2D)
  if not tex then
    Logger.Debug("[CursorManager] SetDefaultCursor: texture not found at %s", DEFAULT_CURSOR_PATH)
    return
  end
  local ok, err = pcall(CS.UnityEngine.Cursor.SetCursor, tex, DEFAULT_HOTSPOT, CS.UnityEngine.CursorMode.Auto)
  if not ok then
    Logger.Debug("[CursorManager] SetCursor failed: %s", tostring(err))
  end
end

function CursorManager:SetCursor(path, hotspotX, hotspotY)
  if not path then
    return
  end
  local tex = ResLoadMgr.LoadAsset(path, self, T_Texture2D)
  if not tex then
    Logger.Debug("[CursorManager] SetCursor: texture not found at %s", path)
    return
  end
  local hotspot = CS.UnityEngine.Vector2(hotspotX or 0, hotspotY or 0)
  local ok, err = pcall(CS.UnityEngine.Cursor.SetCursor, tex, hotspot, CS.UnityEngine.CursorMode.Auto)
  if not ok then
    Logger.Debug("[CursorManager] SetCursor failed: %s", tostring(err))
  end
end

function CursorManager:ResetCursor()
  local ok, err = pcall(CS.UnityEngine.Cursor.SetCursor, nil, CS.UnityEngine.Vector2.zero, CS.UnityEngine.CursorMode.Auto)
  if not ok then
    Logger.Debug("[CursorManager] ResetCursor failed: %s", tostring(err))
  end
end

function CursorManager:OnDestroy()
  self:ResetCursor()
  Super.OnDestroy(self)
end

return CursorManager
