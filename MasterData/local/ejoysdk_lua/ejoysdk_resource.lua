local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "res"
local M = {}
local R = {}
local order = {
  OK = {
    CN = "支付成功"
  },
  APPLE_PURCHASING = {
    CN = "连接苹果服务器中"
  },
  PURCHASING = {
    CN = "连接游戏服务器完成购买"
  },
  CANT_PURCHASE = {
    CN = "当前状态无法支付"
  },
  CREATE_ORDER = {
    CN = "创建支付订单"
  },
  CREATE_ORDER_FAIL = {
    CN = "创建订单失败"
  },
  TRING = {
    CN = "支付成功，等待游戏服务器返回"
  },
  APPLE_TRING = {
    CN = "支付成功，等待苹果服务器返回"
  },
  CANCEL = {
    CN = "用户取消支付"
  },
  APPLE_ERROR = {
    CN = "苹果支付服务异常"
  },
  UNKNOWN = {
    CN = "无法连接支付服务器"
  }
}
R.order = order
local holo = {
  EDITOR_ERROR = {
    CN = "打开个人信息页失败"
  },
  WEB_LOGIN_ERROR = {
    CN = "登录页面失败"
  }
}
R.holo = holo
local game_center = {
  USER_CANCEL = {
    CN = "用户取消"
  },
  USER_LOGOUT = {
    CN = "用户登出"
  },
  UNAVAIABLE = {
    CN = "功能不可用"
  },
  APPLE_DECLINE = {
    CN = "苹果拒绝"
  }
}
R.game_center = game_center

local function init(lang, default)
  for k, v in pairs(R) do
    local new = {}
    for rid, res in pairs(v) do
      local entry = res[lang]
      entry = entry or res[default]
      new[rid] = entry
    end
    M[k] = new
  end
end

init("CN", E.CONFIG.get_config("default_lang"))
ET.subscribe(ET.config.CONFIG_CHANGED .. "_" .. "lang", function(new_lang)
  init(new_lang, E.CONFIG.get_config("default_lang"))
end)
return M
