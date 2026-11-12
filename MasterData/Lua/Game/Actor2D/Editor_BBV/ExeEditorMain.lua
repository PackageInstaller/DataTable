EXE_EDITOR = true
require("GameCore.GameCore")
EventManager.Hit(EventId.OpenPanel, PanelId.ExeEditor)
local goLaunchUI = GameObject.Find("==== Builtin UI ====/LaunchUI")
GameObject.Destroy(goLaunchUI)

function Check_BBV_Data_Legal(sVoResName)
  local BBVMgr = require("Game.Actor2D.BubbleVoiceManager")
  return BBVMgr.CheckTime(sVoResName)
end
