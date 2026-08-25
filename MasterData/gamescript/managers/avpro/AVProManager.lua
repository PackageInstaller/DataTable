local CsTexture2D = typeof(CS.UnityEngine.Texture2D)
local AVProManager, Super = System.NewClass("AVProManager", Manager)

function AVProManager:ctor()
  Super.ctor(self)
end

function AVProManager:Awake()
  Super.Awake(self)
  
  function CS.Z1AVProMediaPlayer.GetMediaPathTypeFunc(videoUrl)
    local mediaPathType = StrUtils.GetMediaPathType(videoUrl)
    return mediaPathType
  end
  
  function CS.Z1VideoInterface.GetVideoFullPath(videoUrl)
    do return StrUtils.GetVideoUrl end
    return StrUtils.GetVideoUrl, videoUrl
  end
  
  self.isErrorOccu = false
  self.isInitedFinished = false
  self._activedVideos = {}
  self:_DispatchInitedFinished()
end

function AVProManager:_DispatchInitedFinished()
  if not self.isInitedFinished then
    self.isInitedFinished = true
    EventMgr.Instance.OnVideoInited:Dispatch()
  end
end

function AVProManager:OnDestroy()
  Super.OnDestroy(self)
  CS.Z1AVProMediaPlayer.GetVideoFullPath = nil
  CS.Z1AVProMediaPlayer.GetMediaPathTypeFunc = nil
  ResLoadMgr.UnloadAssetByTarget(self)
  self.blackTex = nil
  self:Clear()
end

function AVProManager:GetBlackTexture()
  if not self.blackTex then
    self.blackTex = ResLoadMgr.LoadAsset("UIResources/UITextures/UI_Common_Black4x4.png", self, CsTexture2D)
  end
  return self.blackTex
end

function AVProManager:Clear()
  table.clear(self._activedVideos)
  self._isAppPaused = false
end

function AVProManager:OnActiveVideo(video)
end

function AVProManager:OnDeactiveVideo(video)
end

function AVProManager:OnApplicationPause()
end

function AVProManager:OnApplicationResume()
end

return AVProManager
