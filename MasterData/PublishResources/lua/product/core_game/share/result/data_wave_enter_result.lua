_class("DataWaveEnterResult", Object)
DataWaveEnterResult = DataWaveEnterResult

function DataWaveEnterResult:Constructor(waveNum, isExit, exitPos)
  self._waveNum = waveNum
  self._exitPos = exitPos
  self._isExit = isExit
end

function DataWaveEnterResult:GetWaveIndex()
  return self._waveNum
end

function DataWaveEnterResult:GetExitPos()
  return self._exitPos
end

function DataWaveEnterResult:IsExit()
  return self._isExit
end
