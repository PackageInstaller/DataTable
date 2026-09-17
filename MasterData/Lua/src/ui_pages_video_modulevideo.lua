local this = class("moduleVideo", G_UIModuleBase)
local CriWareStatus = CS.CriWare.CriMana.Player.Status

function this.bind()
  return {go_content = false, go_btnSkip = false}
end

function this.methods()
  return {
    onClick_skip = function(self)
      self:playVideoEnd()
    end
  }
end

function this:close()
  L_TimerManager:clearTimer(self)
  C_SoulEssenceMovieHelper.StopSoulEssenceMovie()
end

function this:playVideo(moviePath, startCallback, endCallback)
  self._init = true
  self._moviePath = moviePath
  self._endCallback = endCallback
  self._startCallback = startCallback
  printf("播放视频", self._moviePath)
  local isEmpty = string.isEmpty(self._moviePath)
  self.bind.go_btnSkip = false
  self.bind.go_content = not isEmpty
  if isEmpty then
    if self._endCallback then
      self._endCallback()
    end
    return
  else
    local isWatched = L_CommonUtil.getLocalValue(self._moviePath) ~= nil
    if isWatched then
      L_TimerManager:newOrResetTimer(self, "showSkip", function()
        self.bind.go_btnSkip = true
      end, 1)
    else
      L_CommonUtil.setLocalValue(self._moviePath, 1)
    end
  end
  self._videoComponent = self.bindComponents.movieController_moduleVideo
  C_SoulEssenceMovieHelper.PlaySoulEssenceMovie(self._videoComponent, self._moviePath)
  self._videoComponent.player.statusChangeCallback = handler(self, self.statusChangeCallback)
end

function this:statusChangeCallback(status)
  if status == CriWareStatus.Error then
    error("播放出错,请检查路径是否正确")
    self:playVideoEnd()
  elseif status == CriWareStatus.PlayEnd then
    self:playVideoEnd()
  elseif status == CriWareStatus.Playing and self._init then
    if self._startCallback then
      self._startCallback(self._videoComponent.Duration)
    end
    self._init = false
  end
end

function this:playVideoEnd()
  if self._endCallback then
    self._endCallback()
  end
  self.bind.go_content = false
  self.bind.go_btnSkip = false
  C_SoulEssenceMovieHelper.StopSoulEssenceMovie()
end

return this
