_class("SmokingTestProgressInfo", Object)
SmokingTestProgressInfo = SmokingTestProgressInfo

function SmokingTestProgressInfo:Constructor()
  self._totalProgress = 1
  self._currentProgress = 0
  self._progressToken = nil
end

function SmokingTestProgressInfo:GetProgress()
  return self._currentProgress, self._totalProgress, self._currentProgress / self._totalProgress
end

function SmokingTestProgressInfo:TickProgress(progressToken)
  if progressToken then
    if self._progressToken == progressToken then
      return
    end
    self._progressToken = progressToken
  end
  self._currentProgress = self._currentProgress + 1
end

function SmokingTestProgressInfo:SetCurrentProgress(p)
  self._currentProgress = p
end

function SmokingTestProgressInfo:SetTotalProgress(p)
  self._totalProgress = p
end

function SmokingTestProgressInfo:__tostring()
  return string.format("%d/%d (%.2f%%)", self._currentProgress, self._totalProgress, self._currentProgress / self._totalProgress * 100)
end
