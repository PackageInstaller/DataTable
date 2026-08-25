local VideoPreparedQueue, Super = System.NewClass("VideoPreparedQueue")
local Time = CS.UnityEngine.Time

function VideoPreparedQueue:ctor()
  Super.ctor(self)
  self.toPreparedList = {}
  self.currPreparingPlayer = nil
  self.timeout = 0
end

function VideoPreparedQueue:OpenMedia(videoUrl, gameVideoPlayer)
  if not videoUrl or 0 == #videoUrl then
    gameVideoPlayer:StartPrepared(videoUrl)
    return
  end
  local prepareItem = {}
  prepareItem.videoUrl = videoUrl
  prepareItem.player = gameVideoPlayer
  table.insert(self.toPreparedList, prepareItem)
  if not self.isRunning then
    self.isRunning = true
    UpdateBeat.Instance:Add(self.Update, self)
  end
end

function VideoPreparedQueue:CloseMedia(gameVideoPlayer)
  if self.currPreparingPlayer and gameVideoPlayer == self.currPreparingPlayer.player then
    self.currPreparingPlayer = nil
    return
  end
  for i = 1, #self.toPreparedList do
    local player = self.toPreparedList[i].player
    if player == gameVideoPlayer then
      table.remove(self.toPreparedList, i)
      break
    end
  end
end

function VideoPreparedQueue:Update(gameVideoPlayer, onPrepared)
  if not self.currPreparingPlayer and 0 == #self.toPreparedList then
    self:Stop()
    return
  end
  if not self.currPreparingPlayer then
    local preparingPlayer = self.toPreparedList[1]
    table.remove(self.toPreparedList, 1)
    self:StartPrepare(preparingPlayer)
  end
  self.timeout = self.timeout + Time.deltaTime
  if self.timeout >= 5 then
    self.currPreparingPlayer = nil
  end
end

function VideoPreparedQueue:StartPrepare(preparingPlayer)
  self.currPreparingPlayer = preparingPlayer
  self.timeout = 0
  if not (preparingPlayer and preparingPlayer.player) or not preparingPlayer.player.mediaPlayer then
    self.currPreparingPlayer = nil
    return
  end
  preparingPlayer.player:StartPrepared(preparingPlayer.videoUrl, function()
    if self.currPreparingPlayer == preparingPlayer then
      self.currPreparingPlayer = nil
    end
  end)
end

function VideoPreparedQueue:Stop()
  self.isRunning = false
  self.timeout = 0
  UpdateBeat.Instance:Remove(self.Update, self)
  table.clear(self.toPreparedList)
  self.currPreparingPlayer = nil
end

VideoPreparedQueue.Instance = VideoPreparedQueue()
return VideoPreparedQueue
