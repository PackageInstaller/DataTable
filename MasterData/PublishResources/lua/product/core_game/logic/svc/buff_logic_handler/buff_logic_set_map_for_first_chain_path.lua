_class("BuffLogicSetMapForFirstChainPath", BuffLogicBase)
BuffLogicSetMapForFirstChainPath = BuffLogicSetMapForFirstChainPath

function BuffLogicSetMapForFirstChainPath:Constructor(buffInstance, logicParam)
  local isSetNum = logicParam.isSet or 0
  self._isSet = isSetNum == 1
  self._piece = logicParam.piece
  self._effectID = logicParam.effectID
  self._effectOutAnim = logicParam.effectOutAnim
end

function BuffLogicSetMapForFirstChainPath:DoLogic()
  local board = self._world:GetBoardEntity():Board()
  local buffResult
  if self._isSet then
    board:SetMapForFirstChainPath(self._piece)
    buffResult = BuffResultSetMapForFirstChainPath:New(self._piece, self._effectID, self._effectOutAnim)
  else
    board:SetMapForFirstChainPath(nil)
    buffResult = BuffResultSetMapForFirstChainPath:New(nil, nil, nil)
  end
  return buffResult
end
