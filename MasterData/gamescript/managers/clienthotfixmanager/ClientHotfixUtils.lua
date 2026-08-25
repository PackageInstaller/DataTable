local function table_patch(src, diff, name, level, lanKeymap)
  local pre = string.rep("\t", level)
  
  print(pre, "正在patch", name)
  local A = rawget(src, "__v__properties") or rawget(src, "data") or src
  if diff.sub ~= nil then
    for k, v in pairs(diff.sub) do
      rawset(A, k, table_patch(A[k], v, k, level + 1, lanKeymap))
    end
  end
  if nil ~= diff.del then
    for k, v in pairs(diff.del) do
      print(pre, "删除", k, table.tostring(v), A[v])
      rawset(A, v, nil)
    end
  end
  if nil ~= diff.mod then
    for k, v in pairs(diff.mod) do
      if lanKeymap and lanKeymap[k] then
        k = string.format("_cn_%s", k)
      end
      if nil == A[k] then
        print(pre, "新增", k, table.tostring(v))
      else
        print(pre, "覆盖", k, table.tostring(A[k]), table.tostring(v))
      end
      rawset(A, k, v)
    end
  end
  print(pre, "完成patch", name)
  return src
end

local function hotfixConfig(patches)
  for cfgName, diff in pairs(patches) do
    local cfg = DT[cfgName]
    if cfg then
      table_patch(cfg, diff, cfgName, 0)
    else
      Logger.Info("[hotfix] 找不到要热修复的配置文件 | %s", cfgName)
    end
  end
end

local tunpack = table.unpack
local tinsert = table.insert
local Paramsas = {
  S = param_types.Str,
  N = param_types.Num,
  I = param_types.Int,
  B = param_types.Bool,
  T = param_types.Table
}

local function RpcParams(...)
  local params = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    if type(v) == "string" then
      local paramType = Paramsas[v]
      if not paramType then
        error("无法识别参数别名类型：%s", v)
      end
      v = paramType(i)
    end
    tinsert(params, v)
  end
  return params
end

local function hotfixServiceRpc(rpcModel, name, func, ...)
  local ltask = require("ltask")
  local ServiceUtils = require("ServiceUtils")
  local service = ltask.getservice()
  local key = string.format("%s.%s", rpcModel.__name, name)
  local prePatchKey = "__prePatch__Rpc_Func_" .. key
  if nil == service[prePatchKey] then
    service[prePatchKey] = service[key]
  end
  service[key] = function(...)
    do return func, rpcModel.Instance, ... end
    return func, rpcModel.Instance, ...
  end
  local params = table.pack(...)
  ltask.fork(function()
    print("-----hotfix RegisterRpc", key)
    ServiceUtils.ServiceClients.ServiceNetwork.HotfixRpc(key, params)
  end)
end

local function hotfixRpc(rpcModule, name, func, ...)
  hotfixServiceRpc(rpcModule, name, func, ...)
end

local function hotfixModelStateFunction(model, stateFunction)
  if not model.__prePatch__stateFunction then
    model.__prePatch__stateFunction = model.stateFunction
  end
  model.stateFunction = stateFunction
end

local function hotfixModelViewFunction(model, viewFunction)
  if not model.__prePatch__viewFunctions then
    model.__prePatch__viewFunctions = model.viewFunctions
  end
  model.viewFunctions = {viewFunction}
end

local function hotfixModelActionFunction(model, actionFunction)
  if not model.__prePatch__actionFunctions then
    model.__prePatch__actionFunctions = model.actionFunctions
  end
  model.actionFunctions = {actionFunction}
end

local function hotfixModelSetupFunction(model, setupFunction)
  if not model.__prePatch__setup then
    model.__prePatch__setup = model.setup
  end
end

local function hotfixWindowFunctional(windowConfig, functional)
  package.loaded[windowConfig.url] = functional
  if windowConfig.functional then
    windowConfig.functional = functional
  end
end

return {
  hotfixConfig = hotfixConfig,
  hotfixRpc = hotfixRpc,
  hotfixServiceRpc = hotfixServiceRpc,
  hotfixModelStateFunction = hotfixModelStateFunction,
  hotfixModelViewFunction = hotfixModelViewFunction,
  hotfixModelActionFunction = hotfixModelActionFunction,
  hotfixModelSetupFunction = hotfixModelSetupFunction,
  hotfixWindowFunctional = hotfixWindowFunctional
}
