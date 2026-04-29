require("message_def")
local payMessageDef = {
  CLSID_CEventTestAddDiamond = 16000,
  CLSID_CEventTestAddDiamondResult = 16001,
  CLSID_CEventTestUseDiamond = 16002,
  CLSID_CEventTestUseDiamondResult = 16003,
  CLSID_CEventMobileLoadMidasConfig = 16004,
  CLSID_CEventMobileLoadMidasConfigResult = 16005,
  CLSID_CEventMobileGetBalance = 16006,
  CLSID_CEventMobileCostMoney = 16007,
  CLSID_CEventMobileCostMoneyResult = 16008,
  CLSID_CEventMobileBuyGoods = 16009,
  CLSID_CEventMobileBuyGoodsResult = 16010,
  CLSID_CEventPushPayLoginCheckFailed = 16011,
  CLSID_CEventMobileBuySubscribe = 16012,
  CLSID_CEventMobileBuySubscribeResult = 16013,
  CLSID_CEventPushSubscribeInfoList = 16014,
  CLSID_CEventReqPayId = 16015,
  CLSID_CEventReqPayIdResult = 16016,
  CLSID_CEventReqPayAge = 16017,
  CLSID_CEventReqPayAgeResult = 16018,
  CLSID_CEventReqCanPay = 16019,
  CLSID_CEventReqCanPayResult = 16020,
  CLSID_CEventPushPayInfo = 16021,
  CLSID_CEventMobileDmmOrder = 16022,
  CLSID_CEventMobileDmmOrderResult = 16023,
  CLSID_CEventMobileGetProductsInfo = 16024,
  CLSID_CEventMobileGetProductsInfoResult = 16025,
  CLSID_CEventMobileQueryOrder = 16026,
  CLSID_CEventMobileQueryOrderResult = 16027
}
table.append(MessageDef, payMessageDef)
_class("CEventTestAddDiamond", CCallRequestEvent)
CEventTestAddDiamond = CEventTestAddDiamond

function CEventTestAddDiamond:Constructor()
  self.diamond_count = 0
end

CEventTestAddDiamond._proto = {
  [1] = {
    "diamond_count",
    "int"
  }
}
_class("CEventTestAddDiamondResult", CCallReplyEvent)
CEventTestAddDiamondResult = CEventTestAddDiamondResult

function CEventTestAddDiamondResult:Constructor()
  self.result = 0
end

CEventTestAddDiamondResult._proto = {
  [1] = {"result", "int"}
}
_class("CEventTestUseDiamond", CCallRequestEvent)
CEventTestUseDiamond = CEventTestUseDiamond

function CEventTestUseDiamond:Constructor()
  self.diamond_count = 0
end

CEventTestUseDiamond._proto = {
  [1] = {
    "diamond_count",
    "int"
  }
}
_class("CEventTestUseDiamondResult", CCallReplyEvent)
CEventTestUseDiamondResult = CEventTestUseDiamondResult

function CEventTestUseDiamondResult:Constructor()
  self.result = 0
end

CEventTestUseDiamondResult._proto = {
  [1] = {"result", "int"}
}
_class("CEventMobileLoadMidasConfig", CCallRequestEvent)
CEventMobileLoadMidasConfig = CEventMobileLoadMidasConfig

function CEventMobileLoadMidasConfig:Constructor()
end

CEventMobileLoadMidasConfig._proto = {}
_class("CEventMobileLoadMidasConfigResult", CCallReplyEvent)
CEventMobileLoadMidasConfigResult = CEventMobileLoadMidasConfigResult

function CEventMobileLoadMidasConfigResult:Constructor()
  self.ret = 0
  self.env = ""
  self.process = ""
  self.idc = ""
  self.idc_info = ""
  self.zone_id = 0
end

CEventMobileLoadMidasConfigResult._proto = {
  [1] = {"ret", "int"},
  [2] = {"env", "string"},
  [3] = {"process", "string"},
  [4] = {"idc", "string"},
  [5] = {"idc_info", "string"},
  [6] = {"zone_id", "int"}
}
_class("CEventMobileGetBalance", CCliPushEvent)
CEventMobileGetBalance = CEventMobileGetBalance

function CEventMobileGetBalance:Constructor()
  self.is_for_charge = false
end

CEventMobileGetBalance._proto = {
  [1] = {
    "is_for_charge",
    "bool"
  }
}
_class("CEventMobileCostMoney", CCallRequestEvent)
CEventMobileCostMoney = CEventMobileCostMoney

function CEventMobileCostMoney:Constructor()
  self.amt = 0
  self.item_name = ""
  self.mark = ""
end

CEventMobileCostMoney._proto = {
  [1] = {"amt", "int"},
  [2] = {"item_name", "string"},
  [3] = {"mark", "string"}
}
_class("CEventMobileCostMoneyResult", CCallReplyEvent)
CEventMobileCostMoneyResult = CEventMobileCostMoneyResult

function CEventMobileCostMoneyResult:Constructor()
  self.result = 0
  self.balance = 0
end

CEventMobileCostMoneyResult._proto = {
  [1] = {"result", "int"},
  [2] = {"balance", "int"}
}
_class("CEventMobileBuyGoods", CCallRequestEvent)
CEventMobileBuyGoods = CEventMobileBuyGoods

function CEventMobileBuyGoods:Constructor()
  self.num = 0
  self.productid = ""
  self.goodsmeta = ""
end

CEventMobileBuyGoods._proto = {
  [1] = {"num", "int"},
  [2] = {"productid", "string"},
  [3] = {"goodsmeta", "string"}
}
_class("CEventMobileBuyGoodsResult", CCallReplyEvent)
CEventMobileBuyGoodsResult = CEventMobileBuyGoodsResult

function CEventMobileBuyGoodsResult:Constructor()
  self.result = 0
  self.token = ""
  self.url_params = ""
end

CEventMobileBuyGoodsResult._proto = {
  [1] = {"result", "int"},
  [2] = {"token", "string"},
  [3] = {"url_params", "string"}
}
_class("CEventPushPayLoginCheckFailed", CSvrPushEvent)
CEventPushPayLoginCheckFailed = CEventPushPayLoginCheckFailed

function CEventPushPayLoginCheckFailed:Constructor()
end

CEventPushPayLoginCheckFailed._proto = {}
_class("CEventMobileBuySubscribe", CCallRequestEvent)
CEventMobileBuySubscribe = CEventMobileBuySubscribe

function CEventMobileBuySubscribe:Constructor()
end

CEventMobileBuySubscribe._proto = {}
_class("CEventMobileBuySubscribeResult", CCallReplyEvent)
CEventMobileBuySubscribeResult = CEventMobileBuySubscribeResult

function CEventMobileBuySubscribeResult:Constructor()
  self.result = 0
end

CEventMobileBuySubscribeResult._proto = {
  [1] = {"result", "int"}
}
_class("CEventPushSubscribeInfoList", CSvrPushEvent)
CEventPushSubscribeInfoList = CEventPushSubscribeInfoList

function CEventPushSubscribeInfoList:Constructor()
  self.subscribe_list = {}
end

CEventPushSubscribeInfoList._proto = {
  [1] = {
    "subscribe_list",
    "list<MobileSubscribeInfo>"
  }
}
_class("CEventReqPayId", CCallRequestEvent)
CEventReqPayId = CEventReqPayId

function CEventReqPayId:Constructor()
end

CEventReqPayId._proto = {}
_class("CEventReqPayIdResult", CCallReplyEvent)
CEventReqPayIdResult = CEventReqPayIdResult

function CEventReqPayIdResult:Constructor()
  self.result = 0
  self.cfg_id = 0
end

CEventReqPayIdResult._proto = {
  [1] = {"result", "int"},
  [2] = {"cfg_id", "int"}
}
_class("CEventReqPayAge", CCallRequestEvent)
CEventReqPayAge = CEventReqPayAge

function CEventReqPayAge:Constructor()
  self.cfg_id = 0
end

CEventReqPayAge._proto = {
  [1] = {"cfg_id", "int"}
}
_class("CEventReqPayAgeResult", CCallReplyEvent)
CEventReqPayAgeResult = CEventReqPayAgeResult

function CEventReqPayAgeResult:Constructor()
  self.result = 0
end

CEventReqPayAgeResult._proto = {
  [1] = {"result", "int"}
}
_class("CEventReqCanPay", CCallRequestEvent)
CEventReqCanPay = CEventReqCanPay

function CEventReqCanPay:Constructor()
  self.the_pay = 0
end

CEventReqCanPay._proto = {
  [1] = {"the_pay", "int"}
}
_class("CEventReqCanPayResult", CCallReplyEvent)
CEventReqCanPayResult = CEventReqCanPayResult

function CEventReqCanPayResult:Constructor()
  self.result = 0
end

CEventReqCanPayResult._proto = {
  [1] = {"result", "int"}
}
_class("CEventPushPayInfo", CCliPushEvent)
CEventPushPayInfo = CEventPushPayInfo

function CEventPushPayInfo:Constructor()
  self.type = 0
  self.pay_type = ""
  self.midas_id = ""
  self.count = 0
  self.first_or_not = false
end

CEventPushPayInfo._proto = {
  [1] = {"type", "int"},
  [2] = {"pay_type", "string"},
  [3] = {"midas_id", "string"},
  [4] = {"count", "int"},
  [5] = {
    "first_or_not",
    "bool"
  }
}
_class("CEventMobileDmmOrder", CCallRequestEvent)
CEventMobileDmmOrder = CEventMobileDmmOrder

function CEventMobileDmmOrder:Constructor()
  self.language = ""
  self.app_meta = ""
  self.pay_channel = ""
  self.region = ""
  self.currency = ""
  self.amount = ""
  self.pay_desc = ""
  self.purchase_list = {}
  self.pay_token = ""
  self.view_id = ""
end

CEventMobileDmmOrder._proto = {
  [1] = {"language", "string"},
  [2] = {"app_meta", "string"},
  [3] = {
    "pay_channel",
    "string"
  },
  [4] = {"region", "string"},
  [5] = {"currency", "string"},
  [6] = {"amount", "string"},
  [7] = {"pay_desc", "string"},
  [8] = {
    "purchase_list",
    "list<DMMPurchaseInfo>"
  },
  [9] = {"pay_token", "string"},
  [10] = {"view_id", "string"}
}
_class("CEventMobileDmmOrderResult", CCallReplyEvent)
CEventMobileDmmOrderResult = CEventMobileDmmOrderResult

function CEventMobileDmmOrderResult:Constructor()
  self.result = 0
  self.reference_id = ""
  self.trans_info = ""
  self.pay_info = ""
  self.name = ""
  self.message = ""
end

CEventMobileDmmOrderResult._proto = {
  [1] = {"result", "int"},
  [2] = {
    "reference_id",
    "string"
  },
  [3] = {"trans_info", "string"},
  [4] = {"pay_info", "string"},
  [5] = {"name", "string"},
  [6] = {"message", "string"}
}
_class("CEventMobileGetProductsInfo", CCallRequestEvent)
CEventMobileGetProductsInfo = CEventMobileGetProductsInfo

function CEventMobileGetProductsInfo:Constructor()
  self.channel = ""
  self.currency_type = ""
  self.product_ids = {}
  self.product_type = ""
  self.language = ""
end

CEventMobileGetProductsInfo._proto = {
  [1] = {"channel", "string"},
  [2] = {
    "currency_type",
    "string"
  },
  [3] = {
    "product_ids",
    "list<string>"
  },
  [4] = {
    "product_type",
    "string"
  },
  [5] = {"language", "string"}
}
_class("CEventMobileGetProductsInfoResult", CCallReplyEvent)
CEventMobileGetProductsInfoResult = CEventMobileGetProductsInfoResult

function CEventMobileGetProductsInfoResult:Constructor()
  self.result = 0
  self.midas_ret = 0
  self.product_info = {}
end

CEventMobileGetProductsInfoResult._proto = {
  [1] = {"result", "int"},
  [2] = {"midas_ret", "int"},
  [3] = {
    "product_info",
    "list<MobileProductInfo>"
  }
}
_class("CEventMobileQueryOrder", CCallRequestEvent)
CEventMobileQueryOrder = CEventMobileQueryOrder

function CEventMobileQueryOrder:Constructor()
  self.is_after_pay = false
  self.reference_id = ""
  self.transaction_id = ""
end

CEventMobileQueryOrder._proto = {
  [1] = {
    "is_after_pay",
    "bool"
  },
  [2] = {
    "reference_id",
    "string"
  },
  [3] = {
    "transaction_id",
    "string"
  }
}
_class("CEventMobileQueryOrderResult", CCallReplyEvent)
CEventMobileQueryOrderResult = CEventMobileQueryOrderResult

function CEventMobileQueryOrderResult:Constructor()
  self.result = 0
  self.status = 0
  self.name = ""
  self.message = ""
end

CEventMobileQueryOrderResult._proto = {
  [1] = {"result", "int"},
  [2] = {"status", "int"},
  [3] = {"name", "string"},
  [4] = {"message", "string"}
}
