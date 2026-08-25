local IgnoreErrCodeId = {
  [200] = 1,
  [1] = 1,
  [-1] = 1,
  [0] = 1
}
local M = {}

function M.ShowErrCodeTips(errCode, data, cancelFunc, confirmFunc)
  local id = errCode.code
  if not id or IgnoreErrCodeId[id] then
    return
  end
  if data then
    if data.tip then
      Alert.Show(data.tip, cancelFunc, confirmFunc)
    elseif data.msg then
      Alert.ShowStrForErrCode(data.msg, cancelFunc, confirmFunc)
    end
    if data.showTrace then
      Logger.Error(data.msg)
    end
    return
  end
  M.Init()
  local errTid = M.__errList[id]
  local errConfig = DT.ErrCode[errTid]
  if errConfig then
    Alert.ShowStrForErrCode(errConfig.Desc, cancelFunc, confirmFunc)
  end
end

function M.ShowErrCodeTipsByDisconnect()
  Alert.Show(10108)
end

function M.Init()
  if M.__errList then
    return
  end
  M.__errList = {}
  local errConfig = DT.ErrCode
  for k, v in pairs(errConfig) do
    M.__errList[v.Data] = k
  end
end

function M.GetTipText(eTid, data, errCode)
  M.Init()
  local errTextTid = M.__errList[eTid] or ""
  local errConfig = DT.ErrCode[errTextTid]
  if errConfig then
    return errConfig.Desc or ""
  else
    Logger.Debug("Table[ErrCode] not find eTid=" .. (errTextTid or eTid) .. " errCode: " .. table.tostring(errCode))
  end
  return LT.Text("Service_Not_Errcode") .. "[" .. eTid .. "(" .. errTextTid .. ")]" .. " errCode: " .. table.tostring(errCode)
end

local ErrorMsg = setmetatable({}, {
  __index = function(_, name)
    if M[name] then
      return M[name]
    end
    local errConfig = DT.ErrCode[name]
    if errConfig then
      return errConfig.Data
    end
    Logger.Error("Table[ErrCode] not find eTid=" .. name)
    return 0
  end
})
return ErrorMsg
