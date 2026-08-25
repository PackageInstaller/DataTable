local jf = lunate.js_functions
local E = require("ejoysdk_lua.ejoysdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local TAG = "ejoysdk_vm_func_account#"

local function print_log(message)
  if message then
    _ejoysdk.log("account_vm_func# " .. message)
  end
end

local M = {}
M.GAME_PLAYER_INIT_STATUS = {
  UN_INIT = "un_init",
  INITIALIZING = "initializing",
  INIT_SUCCESS = "init_success",
  INIT_FAIL = "init_fail"
}
_ejoysdk.register_ejoysdk_vm_func("harmony_account_login", function(cb)
  print_log("call harmony_account_login")
  local authentication = jf.import("@hms.core.authentication")
  local huaweiIDProvider = lunate.new_instance(authentication.HuaweiIDProvider)
  local request = huaweiIDProvider:createLoginWithHuaweiIDRequest()
  request.forceLogin = true
  local euuid = require("ejoysdk_lua.ejoysdk_uuid")
  local uuid = euuid.random_i64() .. euuid.random_i64()
  request.state = uuid
  local context = jf.get_context()
  local authenticationController = lunate.new_instance(authentication.AuthenticationController, context)
  authenticationController:executeRequest(request, function(err, loginWithHuaweiIDResponse)
    print_log("call harmony_account_login callback ")
    if err then
      local errCode = err.code
      local errMsg = err.message
      print_log("call harmony_account_login error, code >> " .. tostring(errCode) .. ", msg >> " .. tostring(errMsg))
      if cb then
        cb(false, errCode, errMsg)
      end
    elseif loginWithHuaweiIDResponse then
      local state = loginWithHuaweiIDResponse.state
      if state and state ~= uuid then
        print_log("login fail,The state is different >> " .. tostring(state))
        if cb then
          cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED, "login fail,The state is different")
        end
        return
      end
      local loginWithHuaweiIDCredential = loginWithHuaweiIDResponse.data
      if loginWithHuaweiIDCredential then
        local authorizationCode = loginWithHuaweiIDCredential.authorizationCode
        local idToken = loginWithHuaweiIDCredential.idToken
        local unionID = loginWithHuaweiIDCredential.unionID
        print_log("authorizationCode >> " .. tostring(authorizationCode) .. ", idToken >> " .. tostring(idToken))
        local gamePlayer = jf.import("@hms.core.gameservice.gameplayer")
        print_log("getLocalPlayer")
        gamePlayer.getLocalPlayer(context, function(error, result)
          print_log("getLocalPlayer callback")
          if error then
            local code = error.code
            local message = error.message
            print_log("call getLocalPlayer error, code >> " .. tostring(code) .. ", msg >> " .. tostring(message))
            if cb then
              cb(false, code, message)
            end
          else
            local gamePlayerId = result.gamePlayerId
            local data = {
              token = idToken,
              gamePlayerId = gamePlayerId,
              authorizationCode = authorizationCode,
              unionID = unionID
            }
            if cb then
              cb(true, data)
            end
          end
        end)
      elseif cb then
        cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED, "loginWithHuaweiIDCredential is nil")
      end
    elseif cb then
      cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED, "loginWithHuaweiIDResponse is nil")
    end
  end)
end)
_ejoysdk.register_ejoysdk_vm_func("union_login", function(cb, showLoginDialog)
  print_log("call union_login, show login dialog >> " .. tostring(showLoginDialog))
  local gameplayer = jf.import("@hms.core.gameservice.gameplayer")
  local officialAccount = {
    accountName = "官方账号登录",
    accountIcon = jf.find_resource("app.media.ejoysdk_icon_lingxi")
  }
  local request = {
    showLoginDialog = showLoginDialog,
    loginPanelType = 1,
    thirdAccountInfos = {officialAccount}
  }
  local context = jf.get_context()
  print_log("begin union login")
  gameplayer.unionLogin(context, request):Then(function(result)
    local accountName = result.accountName
    local needBinding = result.needBinding
    local localPlayer
    if result.localPlayer then
      localPlayer = lunate.deepcopy(result.localPlayer)
    end
    print_log("union login result, account name >> " .. tostring(accountName) .. ", and needBinding >> " .. tostring(needBinding))
    cb(true, accountName, needBinding, localPlayer)
  end):catch(function(error)
    print_log("union login error, code >> " .. tostring(error.code) .. ", message >> " .. tostring(error.message))
    cb(false, error.code, error.message)
  end)
end)
_ejoysdk.register_ejoysdk_vm_func("auth_request", function(cb, needBinding)
  print_log("call auth_request, needBinding " .. tostring(needBinding))
  if needBinding then
    local scopes = {"profile", "phone"}
    local permissions = {
      "serviceauthcode"
    }
    local euuid = require("ejoysdk_lua.ejoysdk_uuid")
    local uuid = euuid.random_i64() .. euuid.random_i64()
    jf.auth_request(scopes, permissions, uuid, true, function(succ, result)
      print_log("auth request return, succ >> " .. tostring(succ))
      if succ then
        local avatarUri = result.avatarUri
        local nickName = result.nickName
        local authorizationCode = result.authorizationCode
        print_log("union login result, avatarUri >> " .. tostring(avatarUri) .. ", and nickName >> " .. tostring(nickName))
        print_log("union login result, authorizationCode >> " .. tostring(authorizationCode))
        cb(true, authorizationCode)
      else
        local error = result
        print_log("auth request error, code >> " .. tostring(error.code) .. ", message >> " .. tostring(error.message))
        cb(false, error.code, error.message)
      end
    end)
  else
    local authentication = jf.import("@hms.core.authentication")
    local huaweiIDProvider = lunate.new_instance(authentication.HuaweiIDProvider)
    local request = huaweiIDProvider:createLoginWithHuaweiIDRequest()
    request.forceLogin = true
    local euuid = require("ejoysdk_lua.ejoysdk_uuid")
    local uuid = euuid.random_i64() .. euuid.random_i64()
    request.state = uuid
    local context = jf.get_context()
    local authenticationController = lunate.new_instance(authentication.AuthenticationController, context)
    authenticationController:executeRequest(request, function(err, loginWithHuaweiIDResponse)
      print_log("call harmony_account_login callback ")
      if err then
        local errCode = err.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
        local errMsg = err.message or "unknown error"
        print_log("call harmony_account_login error, code >> " .. tostring(errCode) .. ", msg >> " .. tostring(errMsg))
        if cb then
          cb(false, errCode, errMsg)
        end
      elseif loginWithHuaweiIDResponse then
        local state = loginWithHuaweiIDResponse.state
        if state and state ~= uuid then
          print_log("login fail,The state is different >> " .. tostring(state))
          if cb then
            cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED, "login fail,The state is different")
          end
          return
        end
        local loginWithHuaweiIDCredential = loginWithHuaweiIDResponse.data
        if loginWithHuaweiIDCredential then
          local authorizationCode = loginWithHuaweiIDCredential.authorizationCode
          local idToken = loginWithHuaweiIDCredential.idToken
          local unionID = loginWithHuaweiIDCredential.unionID
          print_log("authorizationCode >> " .. tostring(authorizationCode) .. ", idToken >> " .. tostring(idToken) .. ", unionID >> " .. tostring(unionID))
          if cb then
            cb(true, authorizationCode)
          end
        elseif cb then
          cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED, "loginWithHuaweiIDCredential is nil")
        end
      elseif cb then
        cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED, "loginWithHuaweiIDResponse is nil")
      end
    end)
  end
end)
_ejoysdk.register_ejoysdk_vm_func("bind_player", function(cb, thirdOpenId, teamPlayerId)
  print_log("call bind_player")
  print_log("thirdOpenId >> " .. tostring(thirdOpenId) .. ", teamPlayerId >> " .. tostring(teamPlayerId))
  local context = jf.get_context()
  local gameplayer = jf.import("@hms.core.gameservice.gameplayer")
  gameplayer.bindPlayer(context, thirdOpenId, teamPlayerId):Then(function(result)
    print_log("bind player success")
    E.LOG.debug(TAG, result)
    cb(true)
  end):catch(function(error)
    print_log("bind player error, code >> " .. tostring(error.code) .. ", message >> " .. tostring(error.message))
    cb(false, error.code, error.message)
  end)
end)
_ejoysdk.register_ejoysdk_vm_func("unbind_player", function(cb, thirdOpenId, teamPlayerId)
  print_log("call unbind_player")
  print_log("thirdOpenId >> " .. tostring(thirdOpenId) .. ", teamPlayerId >> " .. tostring(teamPlayerId))
  local context = jf.get_context()
  local gameplayer = jf.import("@hms.core.gameservice.gameplayer")
  gameplayer.unbindPlayer(context, thirdOpenId, teamPlayerId):Then(function(result)
    print_log("unbind player success")
    E.LOG.debug(TAG, result)
    cb(true)
  end):catch(function(error)
    print_log("unbind player error, code >> " .. tostring(error.code) .. ", message >> " .. tostring(error.message))
    cb(false, error.code, error.message)
  end)
end)
_ejoysdk.register_ejoysdk_vm_func("verify_local_player", function(cb, thirdOpenId, isRealName, isAdult)
  print_log("call verify local player")
  print_log("officialId >> " .. tostring(thirdOpenId) .. ", isRealName >> " .. tostring(isRealName) .. ", isAdult >> " .. tostring(isAdult))
  local context = jf.get_context()
  local gameplayer = jf.import("@hms.core.gameservice.gameplayer")
  local request = {
    thirdOpenId = thirdOpenId,
    isRealName = isRealName,
    isAdult = isAdult
  }
  gameplayer.verifyLocalPlayer(context, request):Then(function(result)
    print_log("verify local player success")
    E.LOG.debug(TAG, result)
    cb(true)
  end):catch(function(error)
    print_log("verify local player error, code >> " .. tostring(error.code) .. ", message >> " .. tostring(error.message))
    cb(false, error.code, error.message)
  end)
end)
_ejoysdk.register_ejoysdk_vm_func("harmony_create_set_player_info", function(player_info, channelPlayerId)
  print_log("call harmony_create_set_player_info")
  if not channelPlayerId then
    print_log("set player info fail, channelPlayerId is nil")
    return
  end
  local roleId = player_info.player_id
  local roleName = player_info.player_name
  local serverId = player_info.server_id
  local serverName = player_info.server_name
  print_log("roleId>>" .. tostring(roleId) .. ",roleName>>" .. tostring(roleName) .. ",serverId>>" .. tostring(serverId) .. ",serverName>>" .. tostring(serverName))
  if not roleId or not roleName then
    print_log("set player info error, role info is undefined")
    return
  end
  local request = {
    roleId = roleId,
    roleName = roleName,
    serverId = serverId,
    serverName = serverName,
    gamePlayerId = channelPlayerId
  }
  local gamePlayer = jf.import("@hms.core.gameservice.gameplayer")
  local context = jf.get_context()
  gamePlayer.savePlayerRole(context, request, function()
    print_log("savePlayerRole success.")
  end)
end)

local function decodePurchaseOrder(purchaseData)
  local JSON = require("ejoysdk_lua.ejoysdk_json")
  local jwsPurchaseOrder = JSON.decode(purchaseData).jwsPurchaseOrder
  local purchaseStr = jf.utils():decodeJwtObj(jwsPurchaseOrder)
  print_log("pay success and purchaseStr >> " .. tostring(purchaseStr))
  local purchaseOrderPayload = JSON.decode(purchaseStr)
  purchaseOrderPayload.jwsPurchaseOrder = jwsPurchaseOrder
  return purchaseOrderPayload
end

_ejoysdk.register_ejoysdk_vm_func("harmony_create_purchases", function(cb, cpOrderId, productId)
  print_log("call harmony_create_purchases cpOrderId >> " .. tostring(cpOrderId))
  local reservedInfo = {tradeId = cpOrderId}
  local JSON = require("ejoysdk_lua.ejoysdk_json")
  local reservedInfoJson = JSON.encode(reservedInfo)
  local iap = jf.import("@hms.core.iap")
  local context = jf.get_context()
  local createPurchaseParam = {
    productId = productId,
    productType = iap.ProductType.CONSUMABLE,
    developerPayload = reservedInfoJson
  }
  iap.createPurchase(context, createPurchaseParam):Then(function(result)
    print_log("createPurchase return")
    if not result or not result.purchaseData then
      cb(false, cpOrderId, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_RESULT_EMPTY, "createPurchase return purchase data nil")
      return
    end
    local ok, purchaseOrderPayload = pcall(decodePurchaseOrder, result.purchaseData)
    if ok then
      cb(true, cpOrderId, purchaseOrderPayload)
    else
      print_log("decode purchase data error")
      cb(false, cpOrderId, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_RESULT_DECODE_ERROR, "decode purchase data error")
    end
  end):catch(function(error)
    cb(false, cpOrderId, error.code, error.message)
  end)
end)
_ejoysdk.register_ejoysdk_vm_func("harmony_query_purchases", function(cb)
  print_log("call harmony_query_purchases")
  local iap = jf.import("@hms.core.iap")
  local context = jf.get_context()
  local param = {
    productType = iap.ProductType.CONSUMABLE,
    queryType = iap.PurchaseQueryType.UNFINISHED
  }
  iap.queryPurchases(context, param):Then(function(res)
    print_log("queryPurchases return")
    local resCopy = lunate.deepcopy(res)
    local purchaseDataList = resCopy.purchaseDataList
    if purchaseDataList and #purchaseDataList > 0 then
      local purchaseOrderPayloadArray = {}
      for _, purchaseData in pairs(purchaseDataList) do
        local ok, purchaseOrderPayload = pcall(decodePurchaseOrder, purchaseData)
        if ok then
          table.insert(purchaseOrderPayloadArray, purchaseOrderPayload)
        else
          print_log("decode purchaseData data error")
        end
      end
      cb(true, purchaseOrderPayloadArray)
    else
      print_log("purchaseDataList is nil or empty")
      cb(false, -1, "purchaseDataList is nil or empty")
    end
  end):catch(function(error)
    cb(false, error.code, error.message)
  end)
end)
_ejoysdk.register_ejoysdk_vm_func("harmony_finish_purchases", function(purchaseOrder)
  print_log("call harmony_finish_purchases")
  local finishPurchaseParam = {
    productType = purchaseOrder.pType,
    purchaseToken = purchaseOrder.pToken,
    purchaseOrderId = purchaseOrder.pId
  }
  E.log(finishPurchaseParam)
  local iap = jf.import("@hms.core.iap")
  local context = jf.get_context()
  iap.finishPurchase(context, finishPurchaseParam):Then(function(_result)
    print_log("finish purchase success: " .. tostring(purchaseOrder.productId))
  end):catch(function(error)
    print_log("finish purchase error, code >> " .. tostring(error.code) .. ", message >> " .. tostring(error.message))
  end)
end)
_ejoysdk.register_ejoysdk_vm_func("harmony_query_environment_status", function(cb)
  print_log("call harmony_query_environment_status")
  local iap = jf.import("@hms.core.iap")
  local context = jf.get_context()
  iap.queryEnvironmentStatus(context):Then(function()
    print_log("lua query environment status success")
    cb(true)
  end):catch(function(error)
    print_log("query environment status fail >> " .. tostring(error.context) .. ", message >> " .. tostring(error.message))
    cb(false)
  end)
end)
local game_player_status = M.GAME_PLAYER_INIT_STATUS.UN_INIT
local callbacks_list = {}

function M.init_game_player(cb)
  E.LOG.debug(TAG, "call harmony_account init_game_player, game_player_status: " .. tostring(game_player_status))
  if game_player_status == M.GAME_PLAYER_INIT_STATUS.INIT_SUCCESS then
    cb(true)
    return
  elseif game_player_status == M.GAME_PLAYER_INIT_STATUS.INIT_FAIL then
    cb(false)
    return
  elseif game_player_status == M.GAME_PLAYER_INIT_STATUS.INITIALIZING then
    table.insert(callbacks_list, cb)
    return
  end
  table.insert(callbacks_list, cb)
  local gameplayer = jf.import("@hms.core.gameservice.gameplayer")
  local context = jf.get_context()
  gameplayer.init(context, function(error)
    if nil == error then
      E.LOG.debug(TAG, "harmony_account game player init success")
      game_player_status = M.GAME_PLAYER_INIT_STATUS.INIT_SUCCESS
    else
      E.LOG.debug(TAG, "harmony_account game player init error")
      game_player_status = M.GAME_PLAYER_INIT_STATUS.INIT_FAIL
    end
    while #callbacks_list > 0 do
      local _cb = table.remove(callbacks_list, 1)
      local is_game_player_init_success = nil == error
      _cb(is_game_player_init_success)
    end
  end)
  game_player_status = M.GAME_PLAYER_INIT_STATUS.INITIALIZING
end

_ejoysdk.register_ejoysdk_vm_func("harmony_game_player_init", function(cb)
  M.init_game_player(cb)
end)
_ejoysdk.register_ejoysdk_vm_func("register_player_changed", function(_cb)
  local gameplayer = jf.import("@hms.core.gameservice.gameplayer")
  gameplayer.on("playerChanged"):Then(function(result)
    print_log("on player changed >> " .. tostring(result.event))
  end)
end)
return M
