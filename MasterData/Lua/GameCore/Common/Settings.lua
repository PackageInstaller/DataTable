local Settings = {}
Settings.sCurrentTxtLanguage = NovaAPI.GetCur_TextLanguage()
Settings.sCurrentVoLanguage = NovaAPI.GetCur_VoiceLanguage()
Settings.AB_ROOT_PATH = "Assets/AssetBundles/"
Settings.DESIGN_SCREEN_RESOLUTION_WIDTH = 2160
Settings.DESIGN_SCREEN_RESOLUTION_HEIGHT = 1080
Settings.CURRENT_CANVAS_FULL_RECT_WIDTH = 2160
Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT = 1080
Settings.CANVAS_SCALE = 0.01
Settings.RENDERTEXTURE_SIZE_FACTOR = 1
if NovaAPI.IsMobilePlatform() == true then
  Settings.RENDERTEXTURE_SIZE_FACTOR = 0.8
end
Settings.bDestroyHistoryUIInstance = CS.ClientManager.Instance:GetMemoryType()
Settings.sPrologueAvgId1 = "STm00_01"
Settings.sPrologueVideo = "Prologue/Prologue_P4"
Settings.sPrologueAvgId2 = "STm00_02"
Settings.bSkipSnapshotWait = false
return Settings
