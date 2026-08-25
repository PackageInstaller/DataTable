local System = require("System.System")
local Manager = require("Utility.Manager")
local TaskMgr = require("Managers.TaskMgr")
local Logger = require("Utility.Logger")
local ErrorMsg = require("Net.ErrorMsg")
local EventMgr = require("Managers.EventManager.EventMgr")
local Reactive = require("Vue.reactivity.reactive")
local apus = require("ejoysdk_lua.apm-sdk-lua.apus")
local NetworkProfiler = require("Foundation.Network.NetworkProfiler")
local IsEditor = CS.Z1Client.General.OSDef.isEditor
local isReactive = Reactive.isReactive
local UnityTime = CS.UnityEngine.Time
local ProtoManager, Super = System.NewClass("ProtoManager", Manager)

local function AddLogic(self, T)
  local ret = T()
  table.insert(self.LogicProtos, ret)
  self.Protos[T.__name] = ret
  return ret
end

local function DestroyLogicProtos(self)
  for _, v in ipairs(self.LogicProtos) do
    v:Shutdown()
  end
  self.LogicProtos = {}
end

local function DestroyPvpProtos(self)
  for _, v in ipairs(self.PvpProtos) do
    v:Shutdown()
  end
  self.PvpProtos = {}
end

function ProtoManager:ctor()
  Super.ctor(self)
  self.LogicProtos = {}
  self.PvpProtos = {}
  self.Protos = {}
end

function ProtoManager:Awake()
  Super.Awake(self)
  self:CreateLogicReqOrRes()
end

function ProtoManager:Destroy()
  DestroyPvpProtos(self)
  DestroyLogicProtos(self)
  self.Protos = {}
  Super.Destroy(self)
end

function ProtoManager:CreateLogicReqOrRes()
  self.LoginRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.LoginRequest"))
  self.GameCopyRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.GameCopyRequest"))
  self.WorldRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.WorldRequest"))
  self.GmRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.GmRequest"))
  self.GameRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.GameRequest"))
  self.TaskRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.TaskRequest"))
  self.PvpRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.PvpRequest"))
  self.RailWayRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.RailWayRequest"))
  self.CommentRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.CommentRequest"))
  self.SettingRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.SettingRequest"))
  self.TrinketRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.TrinketRequest"))
  self.StageRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.StageRequest"))
  self.AvgCommunicateRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.AvgCommunicateRequest"))
  self.PvpRewardRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.PvpRewardRequest"))
  self.SettingRequest = AddLogic(self, System.ImportRpcModule("Net.Logic.Request.SettingRequest"))
  print("==========================================================================")
  AddLogic(self, System.ImportRpcModule("Net.Logic.Response.LoginResponse"))
  print("====================333333333333333========================================")
  self.WorldResponse = AddLogic(self, System.ImportRpcModule("Net.Logic.Response.WorldResponse"))
  self.RoleResponse = AddLogic(self, System.ImportRpcModule("Net.Logic.Response.RoleResponse"))
  for _, v in ipairs(self.LogicProtos) do
    v:Startup()
  end
end

function ProtoManager:CreatePvpReqOrRes()
  for _, v in ipairs(self.PvpProtos) do
    v:Startup()
  end
end

function ProtoManager:OnEnterPvp()
  self:CreatePvpReqOrRes()
end

function ProtoManager:OnExitPvp()
  DestroyPvpProtos(self)
end

function ProtoManager:ClearRpcReconnectInfo()
  if self.rpcInfo then
    Logger.Info("ClearRpcReconnectInfo", self.rpcInfo.funName)
    self.rpcInfo = nil
  end
end

function ProtoManager:RpcReconnectAfter()
  if self.rpcInfo then
    Logger.Info("RpcReconnectAfter", self.rpcInfo.funName)
    self:ClearRpcReconnectInfo()
  end
end

function ProtoManager:SetReqWithoutMask(boolVal)
  if nil == boolVal then
    return
  end
  self.reqWithoutMask = boolVal
end

function ProtoManager:ResetReqWithoutMask()
  self.reqWithoutMask = nil
end

function ProtoManager:GetLatestReqProto()
  return self._lastReq, self._lastFunName
end

function ProtoManager:ReqServer(req, funName, successCallback, failCallback, ...)
  if not LoginMgr.Instance.model.isActorLogin then
    error("LoginMgr.Instance.model.isActorLogin == false  req=" .. req .. "." .. funName)
    if failCallback then
      failCallback()
    end
    return
  end
  if IsEditor then
    local params = {
      ...
    }
    for i = 1, #params do
      if params[i] and type(params[i]) == "table" and isReactive(params[i]) then
        Logger.Error("参数是一个Reactive对象，有可能导致卡死，请不要用Reactive对象")
        CS.EndlessLoopingWatcher.AppendText("参数是一个Reactive对象，有可能导致卡死，请不要用Reactive对象=" .. debug.traceback() .. "\r\n")
      end
    end
  end
  self._lastReq = req
  self._lastFunName = funName
  self.rpcInfo = {
    req = req,
    funName = funName,
    successCallback = successCallback,
    failCallback = failCallback,
    info = {
      ...
    }
  }
  
  local function Req(...)
    local sendTime = UnityTime.unscaledTime
    local func = self[req][funName]
    NetBlockMgr.Instance:OnRequest(req, funName)
    local data, code = func(self[req], ...)
    code = code or {}
    NetBlockMgr.Instance:OnRespond(req, funName)
    local handleStart = NetworkProfiler.enabled and os.clock() or nil
    local respondTime = UnityTime.unscaledTime
    local timeMs = math.floor(respondTime - sendTime * 1000)
    apus.count_game_rpc_call(funName, true, 0, timeMs, req)
    if code.code == ErrorMsg.SUCCESS then
      if successCallback then
        successCallback(data, code)
      end
    else
      if failCallback then
        failCallback(data, code)
      end
      Logger.Info(req .. "." .. funName .. " not data,errcod=", code.code)
    end
    EventMgr.Instance.OnProtoMsgRequest:Dispatch(funName)
    EventMgr.Instance.CloseReqMask:Dispatch()
    if handleStart then
      local handleElapsed = os.clock() - handleStart
      NetworkProfiler.Record(NetworkProfiler.NetworkProfilerType.HandleRespond, req .. "." .. funName, handleElapsed)
    end
    return code
  end
  
  TaskMgr.Instance.Fork(function(...)
    local code = Req(...)
    if 0 == code.code then
      Logger.Info("gameOut reReq funName = %s", funName)
      Req(...)
    end
    if 0 ~= code.code and self.rpcInfo and self.rpcInfo.funName == funName then
      self:ClearRpcReconnectInfo()
    end
  end, ...)
end

return ProtoManager
