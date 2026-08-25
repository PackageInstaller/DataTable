local UIVideo = {}
local UpdateUtils = require("UpdateUtils")
local UpdateManager = require("UpdateManager")

function UIVideo:Create(mediaPlayerNode, videoPlayerNode)
  if not mediaPlayerNode or not videoPlayerNode then
    return
  end
  local gameAppGo = CS.UnityEngine.GameObject.Find("GameUpdater")
  self.wwiseManager = gameAppGo:GetComponent(typeof(CS.WwiseManager.WwiseManager))
  if not self.wwiseManager then
    self.wwiseManager = gameAppGo:AddComponent(typeof(CS.WwiseManager.WwiseManager))
  end
  local videoName, videoWwiseEvt = self:_GetVideoName()
  self.useUnityVideoPlayer = false
  self._checkErrFrameCount = 0
  self.videoName = videoName
  self.videoWwiseEvt = videoWwiseEvt
  self:_SetupAvproVideo(mediaPlayerNode)
  self:_SetupVideoPlayer(videoPlayerNode)
  self.wwiseManager:Init()
  self.wwiseManager:SetCurrentSoundLanguage("Japanese")
  self:_ApplySavedVolumeSettings()
  self:StartPlay()
end

function UIVideo:_GetVideoName()
  local videoName, videoWwiseEvt
  if UpdateManager.IsGroupDownload("Download") then
    local data = UpdateUtils.ReadJsonCache("z1_use.cfg")
    if data and data.PvVideo and self:IsVideoExistOnDownloadPath(data.PvVideo) then
      videoName = data.PvVideo
      videoWwiseEvt = data.PvMusic
    end
  end
  if not videoName or not videoWwiseEvt then
    return "Video/login_temp_video_Original.mp4", "Play_Mus_Login"
  end
  return videoName, videoWwiseEvt
end

function UIVideo:_SetupAvproVideo(mediaPlayerNode)
  self.videoPlayerDisplayUGUI = mediaPlayerNode:GetComponent(typeof(CS.RenderHeads.Media.AVProVideo.DisplayUGUI))
  self.mediaPlayerNode = mediaPlayerNode
  self.mediaPlayer = mediaPlayerNode:GetComponent(typeof(CS.RenderHeads.Media.AVProVideo.MediaPlayer))
  self.mediaPlayerNode:SetActive(false)
  self.mediaPlayer.AutoOpen = false
  self.mediaPlayer.AutoStart = false
  self.mediaPlayer.Events:AddListener(function(_, eventType, _)
    if eventType == CS.RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Error then
      self.mediaPlayerNode:SetActive(false)
      self:StartPlayUnityPlayer()
    elseif eventType == CS.RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.ReadyToPlay then
      self.isVideoPrepared = true
    end
  end)
end

function UIVideo:_SetupVideoPlayer(videoPlayerNode)
  self.targetRawImage = videoPlayerNode:GetComponent(typeof(CS.UnityEngine.UI.RawImage))
  self.videoPlayerNode = videoPlayerNode
  self.videoPlayer = videoPlayerNode:GetComponent(typeof(CS.UnityEngine.Video.VideoPlayer))
  self.videoPlayerNode:SetActive(false)
  self.videoPlayer.playOnAwake = false
  
  local function onVideoErrorReceived()
    self.videoPlayerNode:SetActive(false)
  end
  
  local function onVideoPlayedStarted()
    if self.targetRawImage then
      self.targetRawImage.texture = self.videoPlayer.texture
      self.targetRawImage.enabled = true
    end
  end
  
  local function onVideoPrepareCompleted()
    self.isVideoPrepared = true
    print(">>>>>>>>>onVideoPrepareCompleted")
  end
  
  self.videoPlayer:prepareCompleted("+", onVideoPrepareCompleted)
  self.videoPlayer:errorReceived("+", onVideoErrorReceived)
  self.videoPlayer:started("+", onVideoPlayedStarted)
  self.innerVideoPrepareCompleted = onVideoPrepareCompleted
  self.innerVideoErrorReceived = onVideoErrorReceived
  self.innerVideoPlayedStarted = onVideoPlayedStarted
  self.mediaPlayer.Events:AddListener(function(_, eventType, _)
    if eventType == CS.RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Error then
      self.videoPlayerNode:SetActive(false)
    elseif eventType == CS.RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.ReadyToPlay then
      self.isVideoPrepared = true
    end
  end)
end

function UIVideo:StartPlay()
  print("UIVideo:StartPlay()")
  local E = require("ejoysdk_lua.ejoysdk")
  local pkg_info = E and E.get_pkg_info() or nil
  if pkg_info and pkg_info.is_simulator then
    print("UIVideo==StartPlay=is_simulator")
    self:StartPlayUnityPlayer()
    return
  end
  self.videoPlayerDisplayUGUI.enabled = false
  local mediaType, mediaPath = self:GetMediaPath()
  self.mediaPlayerNode:SetActive(true)
  self.videoPlayerNode:SetActive(false)
  local openMediaResult = self.mediaPlayer:OpenMedia(mediaType, mediaPath, false)
  if not openMediaResult then
    self:StartPlayUnityPlayer()
  end
end

function UIVideo:StartPlayUnityPlayer()
  if self.useUnityVideoPlayer then
    return
  end
  print("UIVideo:StartPlayUnityPlayer()")
  self.useUnityVideoPlayer = true
  self.targetRawImage.enabled = false
  local videoPath = self:GetVideoPath()
  self.mediaPlayerNode:SetActive(false)
  self.videoPlayerNode:SetActive(true)
  self.videoPlayer.url = videoPath
  self.videoPlayer:Prepare()
end

function UIVideo:IsVideoExistOnDownloadPath(videoName)
  local persistenDataPath = CS.ResourceManager.DownloadHelper.GetDownloadPathDefault()
  local persistentFileName = persistenDataPath .. "/" .. videoName
  local fileInfo = CS.System.IO.FileInfo(persistentFileName)
  return fileInfo.Exists
end

function UIVideo:GetMediaPath()
  local videoName = self.videoName
  local persistenDataPath = CS.ResourceManager.DownloadHelper.GetDownloadPathDefault()
  local persistentFileName = persistenDataPath .. "/" .. videoName
  local fileInfo = CS.System.IO.FileInfo(persistentFileName)
  print("videoName: ", self.videoName, "fileInfo.Exists: ", fileInfo.Exists)
  local MediaPathType = CS.RenderHeads.Media.AVProVideo.MediaPathType
  if fileInfo.Exists then
    local relativePath = CS.ResourceManager.DownloadHelper.GetDownloadRelativePath()
    return MediaPathType.RelativeToPersistentDataFolder, string.format("%s/%s", relativePath, videoName)
  end
  return MediaPathType.RelativeToStreamingAssetsFolder, videoName
end

function UIVideo:GetVideoPath()
  local videoName = self.videoName
  local persistenDataPath = CS.ResourceManager.DownloadHelper.GetDownloadPathDefault()
  local persistentFileName = persistenDataPath .. "/" .. videoName
  local fileInfo = CS.System.IO.FileInfo(persistentFileName)
  print("videoName: ", videoName, "fileInfo.Exists: ", fileInfo.Exists)
  local MediaPathType = CS.RenderHeads.Media.AVProVideo.MediaPathType
  if fileInfo.Exists then
    return persistentFileName
  end
  return CS.UnityEngine.Application.streamingAssetsPath .. "/" .. videoName
end

function UIVideo:Update()
  if self.isVideoPrepared and not self.isPlayVideo and self.wwiseManager and self.wwiseManager:IsInitialized() then
    self.isPlayVideo = true
    if self.useUnityVideoPlayer then
      self.videoPlayer:Play()
      self.targetRawImage.enabled = true
    else
      self.mediaPlayer:Play()
      self.videoPlayerDisplayUGUI.enabled = true
    end
    self.wwiseManager:PlaySound(self.videoWwiseEvt)
  end
  if self.isPlayVideo and not self.useUnityVideoPlayer and -1 ~= self._checkErrFrameCount then
    if self.mediaPlayer and self.mediaPlayer.TextureProducer and self.mediaPlayer.TextureProducer:GetTexture() then
      self._checkErrFrameCount = -1
      return
    end
    self._checkErrFrameCount = self._checkErrFrameCount or 0
    self._checkErrFrameCount = self._checkErrFrameCount + 1
    if self._checkErrFrameCount >= 5 then
      self._checkErrFrameCount = -1
      self.isPlayVideo = false
      self.isVideoPrepared = false
      if self.wwiseManager then
        self.wwiseManager:StopAll()
      end
      self.mediaPlayerNode:SetActive(false)
      self:StartPlayUnityPlayer()
    end
  end
end

function UIVideo:Dispose()
  self._checkErrFrameCount = 0
  self.isPlayVideo = false
  self.isVideoPrepared = false
  if self.wwiseManager then
    local akGameObj, audioListener = self:FindAkGameObjAndListener()
    if audioListener then
      CS.UnityEngine.GameObject.DestroyImmediate(audioListener, true)
    end
    if akGameObj then
      CS.UnityEngine.GameObject.DestroyImmediate(akGameObj, true)
    end
    self.wwiseManager:Destory()
    CS.UnityEngine.GameObject.Destroy(self.wwiseManager)
    self.wwiseManager = nil
  end
  if self.mediaPlayer then
    self.mediaPlayerNode:SetActive(false)
    self.mediaPlayer.Events:RemoveAllListeners()
    self.mediaPlayer:Stop()
    self.mediaPlayer:CloseMedia()
  end
  if self.videoPlayer then
    if self.innerVideoPrepareCompleted then
      self.videoPlayer:prepareCompleted("-", self.innerVideoPrepareCompleted)
    end
    if self.innerVideoPlayedStarted then
      self.videoPlayer:started("-", self.innerVideoPlayedStarted)
    end
    if self.innerVideoErrorReceived then
      self.videoPlayer:errorReceived("-", self.innerVideoErrorReceived)
    end
    self.videoPlayer:Stop()
    self.videoPlayerNode:SetActive(false)
    self.videoPlayer = nil
  end
end

function UIVideo:_ApplySavedVolumeSettings()
  local rtpcNames = {
    "Main_Vol",
    "Mus_Vol",
    "Sfx_Vol",
    "Voc_Vol"
  }
  local data = UpdateUtils.ReadJsonCache("z1_use.cfg")
  if not data then
    return
  end
  for _, rtpcName in ipairs(rtpcNames) do
    local key = "Audio_" .. rtpcName .. "_val"
    local rawVal = data[key]
    local val = rawVal and tonumber(rawVal) or 100
    local wwiseVal = val * 10
    self.wwiseManager:SetRTPCValueByName(rtpcName, wwiseVal)
  end
end

function UIVideo:FindAkGameObjAndListener()
  local akGameObj, audioListener
  local mainCam = CS.UnityEngine.GameObject.Find("Main Camera")
  local comps = mainCam:GetComponents(typeof(CS.UnityEngine.Component))
  for i = 0, comps.Length - 1 do
    local tName = comps[i]:GetType().FullName
    if "AkAudioListener" == tName then
      audioListener = comps[i]
    elseif "AkGameObj" == tName then
      akGameObj = comps[i]
    end
  end
  return akGameObj, audioListener
end

return UIVideo
