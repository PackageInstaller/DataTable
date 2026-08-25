local corunning = coroutine.running
local coresume = coroutine.resume
local coyield = coroutine.yield
local tostring = table.tostring
local RpcClient = System.NewClass("RpcClient")

function RpcClient:ctor(moduleName, cb)
  self.moduleName = moduleName
  self.cb_showErrCodeTips = cb or 0
end

local function rpcCallback(thread, ...)
  local ret, err = coresume(thread, ...)
  if not ret then
    Logger.Error([[
Coroutine LuaError:%s
%s]], err, debug.traceback(thread))
  end
end

function RpcClient:__index(key)
  local rawValue = rawget(RpcClient, key)
  if nil ~= rawValue then
    return rawValue
  end
  local name = rawget(self, "moduleName") .. "." .. key
  local callRpc = RpcMgr.CallCommonRpc
  local rpcMgr = RpcMgr.Instance
  
  local function call(me, ...)
    if me == self then
      if key and rawget(self, "moduleName") ~= "Login" then
        rpcMgr:SetRpcRequest(true)
      end
      callRpc(rpcMgr, name, {
        ...
      }, rpcCallback, corunning())
      local ret = coyield()
      if ret[2] and type(ret[2]) == "number" then
        ret[2] = {
          code = ret[2]
        }
      end
      if "Login.Heartbeat" ~= name then
        local log = string.format("协议:%s 返回data:%s errCode:%s\n", name, table.tostringByProto(ret[1]), table.tostringByProto(ret[2], "", ""))
        Logger.Proto(log)
        if self.cb_showErrCodeTips and type(self.cb_showErrCodeTips) == "function" then
          self.cb_showErrCodeTips(ret[2], ret[1])
        end
      end
      if key then
        rpcMgr:SetRpcRequest(false)
      end
      return ret[1], ret[2]
    else
      callRpc(rpcMgr, name, {
        me,
        ...
      }, nil, corunning())
    end
  end
  
  rawset(self, key, call)
  return call
end

return RpcClient
