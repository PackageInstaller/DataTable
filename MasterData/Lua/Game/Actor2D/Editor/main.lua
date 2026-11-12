require("GameCore.GameCore")
RUNNING_ACTOR2D_EDITOR = true
local goLaunchUI = GameObject.Find("==== Builtin UI ====/LaunchUI")
GameObject.Destroy(goLaunchUI)
CS.WwiseAudioManager.Instance.MusicVolume = 0
EventManager.Hit(EventId.OpenPanel, PanelId.Actor2DEditor)
