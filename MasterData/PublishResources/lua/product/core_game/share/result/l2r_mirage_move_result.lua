_class("L2RMirageMoveResult", Object)
L2RMirageMoveResult = L2RMirageMoveResult

function L2RMirageMoveResult:Constructor(mirageWalkRes)
  self._mirageWalkRes = mirageWalkRes
end

function L2RMirageMoveResult:GetWalkResult()
  return self._mirageWalkRes
end

_class("L2RMirageWarningResult", Object)
L2RMirageWarningResult = L2RMirageWarningResult

function L2RMirageWarningResult:Constructor(warningPosList)
  self._warningPosList = warningPosList
end

function L2RMirageWarningResult:GetWarningPosList()
  return self._warningPosList
end
