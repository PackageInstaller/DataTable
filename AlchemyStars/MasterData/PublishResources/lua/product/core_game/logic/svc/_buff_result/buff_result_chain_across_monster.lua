require("_buff_result_base")
_class("BuffResultChainAcrossMonster", BuffResultBase)
BuffResultChainAcrossMonster = BuffResultChainAcrossMonster

function BuffResultChainAcrossMonster:Constructor(entityID, notifyType, chainIndex, pos, show)
  self._entityID = entityID
  self._notifyType = notifyType
  self._chainIndex = chainIndex
  self._pos = pos
  self._show = show
end

function BuffResultChainAcrossMonster:GetEntityID()
  return self._entityID
end

function BuffResultChainAcrossMonster:GetNotifyType()
  return self._notifyType
end

function BuffResultChainAcrossMonster:GetChainIndex()
  return self._chainIndex
end

function BuffResultChainAcrossMonster:GetPos()
  return self._pos
end

function BuffResultChainAcrossMonster:GetShow()
  return self._show
end
