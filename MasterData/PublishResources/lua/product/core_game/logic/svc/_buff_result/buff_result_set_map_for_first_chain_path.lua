require("_buff_result_base")
_class("BuffResultSetMapForFirstChainPath", BuffResultBase)
BuffResultSetMapForFirstChainPath = BuffResultSetMapForFirstChainPath

function BuffResultSetMapForFirstChainPath:Constructor(pieceType, effectID, effOutAnim)
  self._pieceType = pieceType
  self._effectID = effectID
  self._effOutAnim = effOutAnim
end

function BuffResultSetMapForFirstChainPath:GetEffectID()
  return self._effectID
end

function BuffResultSetMapForFirstChainPath:GetEffectOutAnim()
  return self._effOutAnim
end
