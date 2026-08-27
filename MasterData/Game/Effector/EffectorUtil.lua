local EffectorUtil = {}

function EffectorUtil.ConvertEffectorUid(uid)
  local functionId = uid >> 32
  local logicId = uid & CommonUtil.UInt32Max
  return functionId, logicId
end

return EffectorUtil
