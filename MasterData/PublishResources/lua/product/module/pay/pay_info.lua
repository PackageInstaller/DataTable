local PayErrorCode = {
  PAY_SUCC = 0,
  PAY_FAILED = 1,
  PAY_ERROR_NET_ERR = 2,
  PAY_ERROR_CONFIG_ERR = 3,
  PAY_ERROR_RMI_FAILED = 4,
  PAY_ERROR_THIRD_PROCESS_ERR = 5,
  PAY_ERROR_GENERATE_ID_ERR = 6,
  PAY_ERROR_COMMAND_TYPE = 7,
  PAY_ERROR_PARAMETER = 8,
  PAY_ERROR_NOT_ENOUGH_BALANCE = 9,
  PAY_ERROR_NOT_USE_MIDAS = 10,
  PAY_ERROR_INVALID_GOODS_ID = 11,
  PAY_ERROR_DUPLICATE_BILLNO = 12,
  PAY_ERROR_INVALID_BILLNO = 13,
  PAY_ERROR_MIDAS_TRANSMIT = 14
}
_enum("PayErrorCode", PayErrorCode)
local PayLimitRet = {
  PLR_SUCCESS = 0,
  PLR_FAIL = 1,
  PLR_ERROR_CFG = 2,
  PLR_ERROR_FULL = 3
}
_enum("PayLimitRet", PayLimitRet)
local IAPProductType = {
  IPT_Normal = 0,
  IPT_MonthCard = 1,
  IPT_SuperMonthCard = 2
}
_enum("IAPProductType", IAPProductType)
local IAPPlatform = {
  IAP_Platform_PC = 0,
  IAP_Platform_Andorid = 1,
  IAP_Platform_IOS = 2
}
_enum("IAPPlatform", IAPPlatform)
local PayCommandType = {
  PayCommand_Null = 0,
  PayCommand_GetBalance = 1,
  PayCommand_CostMoney = 2,
  PayCommand_CancelPay = 3,
  PayCommand_BuyGoods = 4,
  PayCommand_PresentDiamond = 5,
  PayCommand_Subscribe = 6,
  PayCommand_DmmOrder = 7,
  PayCommand_GetProductsInfo = 8
}
_enum("PayCommandType", PayCommandType)
local ProductListType = {
  ProductList_ALL = 0,
  ProductList_Charge = 1,
  ProductList_Goods = 2,
  ProductList_Sub = 3
}
_enum("ProductListType", ProductListType)
local SubscribeStatus = {
  SubscribeStatus_NotBuy = 0,
  SubscribeStatus_NotTake = 1,
  SubscribeStatus_Taked = 2,
  SubscribeStatus_CanRenew = 3,
  SubscribeStatus_OverTime = 4
}
_enum("SubscribeStatus", SubscribeStatus)
local ClientPayAction = {
  PayFail = 0,
  PaySuccess = 1,
  PayCancel = 2,
  PayPull = 3
}
_enum("ClientPayAction", ClientPayAction)
local MidasOrderStatus = {
  UNPAY = 1,
  PAYING = 2,
  PAY_SUCCESS = 3,
  PAY_FAIL = 4,
  PROVIDE_SUCCESS = 5,
  PROVIDE_FAIL = 6
}
_enum("MidasOrderStatus", MidasOrderStatus)
local MidasSDKResult = {
  SUCCESS = 0,
  ERROR_SDK = 1,
  ERROR_SVR = 2,
  ERROR_CHANNEL = 3
}
_enum("MidasSDKResult", MidasSDKResult)
_class("MobileSubscribeInfo", Object)
MobileSubscribeInfo = MobileSubscribeInfo

function MobileSubscribeInfo:Constructor()
  self.service_code = ""
  self.last_time = 0
  self.end_time = 0
  self.status = 0
end

MobileSubscribeInfo._proto = {
  [1] = {
    "service_code",
    "string"
  },
  [2] = {"last_time", "time"},
  [3] = {"end_time", "time"},
  [4] = {"status", "short"}
}
_class("DMMPurchaseInfo", Object)
DMMPurchaseInfo = DMMPurchaseInfo

function DMMPurchaseInfo:Constructor()
  self.product_id = ""
  self.quantity = 0
end

DMMPurchaseInfo._proto = {
  [1] = {"product_id", "string"},
  [2] = {"quantity", "int"}
}
_class("MobileProductInfo", Object)
MobileProductInfo = MobileProductInfo

function MobileProductInfo:Constructor()
  self.productId = ""
  self.price = ""
  self.currency = ""
  self.microprice = 0
  self.originalPrice = 0
  self.originalMicroprice = 0
end

MobileProductInfo._proto = {
  [1] = {"productId", "string"},
  [2] = {"price", "string"},
  [3] = {"currency", "string"},
  [4] = {"microprice", "int"},
  [5] = {
    "originalPrice",
    "int"
  },
  [6] = {
    "originalMicroprice",
    "int"
  }
}
