require("buff_result_flag_count")
_class("BuffLogicAddFlagCount", BuffLogicBase)
BuffLogicAddFlagCount = BuffLogicAddFlagCount
local _OverlapKeyFormatter = "FlagCount_%d"

function BuffLogicAddFlagCount:Constructor(buffInstance, logicParam)
  self._flagID = tonumber(logicParam.flagID)
  self._layer = tonumber(logicParam.layer)
  assert(self._flagID, "[BuffLogicAddFlagCount] 缺少必要数字参数: flagID", logicParam.flagID)
  assert(self._layer, "[BuffLogicAddFlagCount] 缺少必要数字参数: layer", logicParam.layer)
end

function BuffLogicAddFlagCount:DoLogic(notify)
  return self:_ApplyFlag(self._flagID, self._layer)
end

function BuffLogicAddFlagCount:DoOverlap(logicParam)
  local flagID = tonumber(logicParam.flagID)
  local layer = tonumber(logicParam.layer)
  assert(flagID, "[BuffLogicAddFlagCount] 堆叠时缺少必要数字参数: flagID", logicParam.flagID)
  assert(layer, "[BuffLogicAddFlagCount] 堆叠时缺少必要数字参数: layer", logicParam.layer)
  self._layer = self._layer + logicParam.layer
  return self:_ApplyFlag(logicParam.flagID, logicParam.layer)
end

function BuffLogicAddFlagCount:_ApplyFlag(flagID, layer)
  local bc = self._entity:BuffComponent()
  local key = string.format(BattleConst.FlagBuffOverlayKeyFormatter, flagID)
  local valBefore = bc:GetBuffValue(key)
  local valCurrent = self:_AppendOverlapValue(key, layer)
  Log.notice(self._className, "ApplyFlag: ", key, " flagID=", flagID, " layer=", layer, "final=", valCurrent)
  return BuffResultFlagCount:New(flagID, valBefore, valCurrent)
end

function BuffLogicAddFlagCount:_AppendOverlapValue(key, layer)
  local bc = self._entity:BuffComponent()
  bc:AddBuffValue(key, layer)
  return bc:GetBuffValue(key)
end

_class("BuffLogicRemoveFlagCount", BuffLogicAddFlagCount)
BuffLogicRemoveFlagCount = BuffLogicRemoveFlagCount

function BuffLogicRemoveFlagCount:_AppendOverlapValue(key, flagID, layer)
  return BuffLogicRemoveFlagCount.super._AppendOverlapValue(self, key, -layer)
end
