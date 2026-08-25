local LoadingMusicManager, Super = System.NewClass("LoadingMusicManager", Manager)

function LoadingMusicManager:ctor()
  Super.ctor(self)
end

function LoadingMusicManager:Awake(binder)
  Super.Awake(self)
  self.musicRootNode = GameObject.Find("UIRoot/SafeArea/FixedRoot/Panel_LoadingMusic")
  self.binder = binder
  if not self.musicRootNode then
    return
  end
  local duration = 0.01
  local repeatTimes = 30
  self.timer = self.binder:BindTimer(duration, repeatTimes, function()
    local audioSource = self.musicRootNode:GetComponent(typeof(CS.UnityEngine.AudioSource))
    if audioSource.volume <= 0 then
      return
    end
    audioSource.volume = audioSource.volume - duration * 100 / repeatTimes
  end, function()
    if self.timer then
      self.binder:StopTimer(self.timer)
      self.timer = nil
    end
    if self.musicRootNode then
      GameObject.DestroyImmediate(self.musicRootNode)
    end
  end)
end

function LoadingMusicManager:OnDestroy()
  Super.OnDestroy(self)
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
end

return LoadingMusicManager
