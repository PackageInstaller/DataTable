local channelConfigs = import(".ChannelConfigs")
local config = channelConfigs[CHANNEL_NAME]
local rechargeCsv = require("csvdata.recharge")
local SDK_CLASS_NAME = channelConfigs[CHANNEL_KEY].sdkClassName
local appId = "1263731905"
local store = cc.iOSPay
local SDKAppStore = {
  callbacks = {}
}

function SDKAppStore:initPlatform(...)
  luaoc.callStaticMethod(SDK_CLASS_NAME, "initPlatform", {})
  
  local function callback(params)
    if not self.callbacks[params.name] then
      return
    end
    self.callbacks[params.name](params)
  end
  
  luaoc.callStaticMethod(SDK_CLASS_NAME, "registerScriptHandler", {listener = callback})
end

function SDKAppStore:cleanup()
  self.callbacks = {}
  luaoc.callStaticMethod(SDK_CLASS_NAME, "unregisterScriptHandler", {})
end

function SDKAppStore:getLoginUrl(params)
  local loginUrl = config.loginUrl
  loginUrl = string.format(loginUrl, params.token, device.getOpenUDID(), CHANNEL_NAME)
  if appreview then
    loginUrl = loginUrl .. "&appreview=true"
  end
  return loginUrl
end

function SDKAppStore:addCallback(name, callback)
  self.callbacks[name] = callback
end

function SDKAppStore.removeCallback(name)
  self.callbacks[name] = nil
end

function SDKAppStore:login(...)
  luaoc.callStaticMethod(SDK_CLASS_NAME, "login", {})
end

function SDKAppStore:logout()
  luaoc.callStaticMethod(SDK_CLASS_NAME, "logout", {})
  game:enterScene("LoginScene")
end

function SDKAppStore:initStore()
  store.init(handler(self, self.storeCallback))
  local productIds = {}
  for _, data in pairs(rechargeCsv) do
    productIds[data.iap_product_id] = true
  end
  store.loadProducts(table.keys(productIds), function(event)
    print("load products finished...")
  end)
end

function SDKAppStore:purchase(params)
  params = params or {}
  UIHelper.showWaiting(true)
  if not store.isProductLoaded(params.rechargeData.iap_product_id) then
    UIHelper.removeWaiting()
    device.showAlert("提示", "支付项正在加载，请稍候...", "确定")
  end
  local paymentParams = {
    result = -1,
    orderId = params.order,
    productId = params.rechargeData.iap_product_id,
    price = params.rechargeData.rmb,
    count = params.diamond > 0 and params.diamond or 1
  }
  luaoc.callStaticMethod(SDK_CLASS_NAME, "payment", paymentParams)
  if not store.purchase(params.rechargeData.iap_product_id, params.order) then
    UIHelper.removeWaiting()
    local paymentParams = {
      result = 1,
      orderId = params.order
    }
    luaoc.callStaticMethod(SDK_CLASS_NAME, "payment", paymentParams)
    device.showAlert("错误", "支付失败，请重试", "确定")
  end
end

function SDKAppStore:storeCallback(transaction)
  UIHelper.removeWaiting()
  local stateFuncs = {
    purchased = function(transaction)
      local purchaseRequest = {
        order = transaction.transaction.userInfo,
        transactionId = transaction.transaction.transactionIdentifier,
        receipt = crypto.encodeBase64(transaction.transaction.receipt),
        productId = transaction.transaction.productIdentifier,
        sandbox = string.find(transaction.transaction.receipt, "Sandbox") ~= nil
      }
      UIHelper.showWaiting()
      game:sendData(actionCodes.Store_iapPurchaseRpc, MsgPack.pack(purchaseRequest))
      game:addResponseHandler(actionCodes.Store_iapPurchaseRpc, function(event)
        store.finishTransaction(transaction.transaction)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.rechargeId then
          local paymentParams = {
            result = 0,
            orderId = transaction.transaction.userInfo,
            price = rechargeCsv[msg.rechargeId].rmb
          }
          luaoc.callStaticMethod(SDK_CLASS_NAME, "payment", paymentParams)
        end
      end)
    end,
    failed = function(transaction)
      device.showAlert("支付失败", transaction.transaction.errorString, "取消")
      local purchaseRequest = {
        order = transaction.transaction.userInfo,
        transactionId = transaction.transaction.transactionIdentifier,
        productId = transaction.transaction.productIdentifier
      }
      game:sendData(actionCodes.Store_iapCancelPurchase, MsgPack.pack(purchaseRequest))
      NetManager:removeResponseHandler(actionCodes.Store_ayncPurchaseRpc)
      local paymentParams = {
        result = 1,
        orderId = transaction.transaction.userInfo
      }
      luaoc.callStaticMethod(SDK_CLASS_NAME, "payment", paymentParams)
      store.finishTransaction(transaction.transaction)
    end,
    cancelled = function(transaction)
      device.showAlert("", "支付操作取消", "确定")
      local purchaseRequest = {
        order = transaction.transaction.userInfo,
        transactionId = transaction.transaction.transactionIdentifier,
        productId = transaction.transaction.productIdentifier
      }
      game:sendData(actionCodes.Store_iapCancelPurchase, MsgPack.pack(purchaseRequest))
      NetManager:removeResponseHandler(actionCodes.Store_ayncPurchaseRpc)
      local paymentParams = {
        result = 2,
        orderId = transaction.transaction.userInfo
      }
      luaoc.callStaticMethod(SDK_CLASS_NAME, "payment", paymentParams)
      store.finishTransaction(transaction.transaction)
    end,
    restored = function(transaction)
      store.finishTransaction(transaction.transaction)
    end
  }
  if stateFuncs[transaction.transaction.state] then
    stateFuncs[transaction.transaction.state](transaction)
  end
end

function SDKAppStore:handleEvent(event)
  if event.eventName == "roleLogin" then
    local apiArgs = {
      userId = event.userId,
      roleName = event.roleName,
      roleLevel = event.roleLevel,
      serverId = event.serverId,
      firstLogin = event.firstLogin
    }
    luaoc.callStaticMethod(SDK_CLASS_NAME, "roleLogin", apiArgs)
  elseif event.eventName == "roleLevel" then
    local apiArgs = {
      roleLevel = event.roleLevel
    }
    luaoc.callStaticMethod(SDK_CLASS_NAME, "roleLevel", apiArgs)
    if tonumber(event.roleLevel) % 3 == 0 then
      luaoc.callStaticMethod(SDK_CLASS_NAME, "showReviewAlert", {})
    end
    if tonumber(event.roleLevel) % 4 == 0 then
      luaoc.callStaticMethod(SDK_CLASS_NAME, "userCert", {})
    end
  elseif event.eventName == "logout" then
  end
end

return SDKAppStore
