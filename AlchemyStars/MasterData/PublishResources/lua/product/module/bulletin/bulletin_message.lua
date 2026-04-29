require("message_def")
local bulletinMessageDef = {
  CLSID_CEventRequestGetServerInfo = 2000,
  CLSID_CEventReplyGetServerInfo = 2001,
  CLSID_CEventRequestGetDefaultServerInfo = 2002,
  CLSID_CEventReplyGetDefaultServerInfo = 2003,
  CLSID_CEventRequestGetLoginInfo = 2004,
  CLSID_CEventReplyGetLoginInfo = 2005,
  CLSID_CEventRequestQuickGetServerInfo = 2006,
  CLSID_CEventReplyQuickGetServerInfo = 2007,
  CLSID_CEventRequestQuickGetDefaultServerInfo = 2008,
  CLSID_CEventReplyQuickGetDefaultServerInfo = 2009,
  CLSID_CEventRequestGetVersionInfo = 2010,
  CLSID_CEventReplyGetVersionInfo = 2011,
  CLSID_CEventRequestZoneInfo = 2012,
  CLSID_CEventReplyZoneInfo = 2013,
  CLSID_CEventRequestMailMaintainInfo = 2014,
  CLSID_CEventReplyMailMaintainInfo = 2015,
  CLSID_CEventRequestGetVersionInfo2 = 2016,
  CLSID_CEventReplyGetVersionInfo2 = 2017,
  CLSID_CEventSvrNetworkCfgPush = 2018
}
table.append(MessageDef, bulletinMessageDef)
local GET_DEFAULT_SERVER_CODE = {
  GET_DEFAULT_SERVER_SUCCEED = 0,
  GET_DEFAULT_SERVER_NO_GATEWAY = 1,
  GET_DEFAULT_SERVER_NO_LOGIN_STATUS = 2,
  GET_DEFAULT_SERVER_ERR_BY_LOGIN_STATUS = 3,
  GET_DEFAULT_SERVER_ERR_BY_BALANCE = 4,
  GET_DEFAULT_SERVER_ERR_BY_AVAIL = 5,
  GET_DEFAULT_SERVER_ERR_BY_RECOMMEND = 6,
  GET_DEFAULT_SERVER_ERR_MainTain = 7,
  GET_DEFAULT_SERVER_ERR_BY_ZONE_FERQ = 8,
  GET_DEFAULT_SERVER_ERR_BY_ZONE_FULL = 9
}
_enum("GET_DEFAULT_SERVER_CODE", GET_DEFAULT_SERVER_CODE)
_class("CEventRequestGetServerInfo", CCallRequestEvent)
CEventRequestGetServerInfo = CEventRequestGetServerInfo

function CEventRequestGetServerInfo:Constructor()
  self.login_info = MSDKAuthInfo:New()
end

CEventRequestGetServerInfo._proto = {
  [1] = {
    "login_info",
    "MSDKAuthInfo"
  }
}
_class("CEventReplyGetServerInfo", CCallReplyEvent)
CEventReplyGetServerInfo = CEventReplyGetServerInfo

function CEventReplyGetServerInfo:Constructor()
  self.ret = 0
  self.server_list = {}
  self.haverole_server_list = {}
  self.recently_login_list = {}
end

CEventReplyGetServerInfo._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "server_list",
    "list<MobileServerInfo>"
  },
  [3] = {
    "haverole_server_list",
    "list<int>"
  },
  [4] = {
    "recently_login_list",
    "list<int>"
  }
}
_class("CEventRequestGetDefaultServerInfo", CCallRequestEvent)
CEventRequestGetDefaultServerInfo = CEventRequestGetDefaultServerInfo

function CEventRequestGetDefaultServerInfo:Constructor()
  self.server_id = -1
  self.login_info = MSDKAuthInfo:New()
end

CEventRequestGetDefaultServerInfo._proto = {
  [1] = {"server_id", "int"},
  [2] = {
    "login_info",
    "MSDKAuthInfo"
  }
}
_class("CEventReplyGetDefaultServerInfo", CCallReplyEvent)
CEventReplyGetDefaultServerInfo = CEventReplyGetDefaultServerInfo

function CEventReplyGetDefaultServerInfo:Constructor()
  self.ret = 0
  self.bulletin_info = {}
  self.default_server = MobileServerInfo:New()
  self.local_push_info_list = {}
  self.default_gateway = MobileGatewayInfo:New()
  self.token = MobileNetToken:New()
  self.net_cfg_info = NetworkCfgInfo:New()
end

CEventReplyGetDefaultServerInfo._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "bulletin_info",
    "list<MobileBulletinInfo>"
  },
  [3] = {
    "default_server",
    "MobileServerInfo"
  },
  [4] = {
    "local_push_info_list",
    "list<LocalPushInfo>"
  },
  [5] = {
    "default_gateway",
    "MobileGatewayInfo"
  },
  [6] = {
    "token",
    "MobileNetToken"
  },
  [7] = {
    "net_cfg_info",
    "NetworkCfgInfo"
  }
}
_class("CEventRequestGetLoginInfo", CCallRequestEvent)
CEventRequestGetLoginInfo = CEventRequestGetLoginInfo

function CEventRequestGetLoginInfo:Constructor()
end

CEventRequestGetLoginInfo._proto = {}
_class("CEventReplyGetLoginInfo", CCallReplyEvent)
CEventReplyGetLoginInfo = CEventReplyGetLoginInfo

function CEventReplyGetLoginInfo:Constructor()
  self.ret = 0
  self.token = MobileNetToken:New()
end

CEventReplyGetLoginInfo._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "token",
    "MobileNetToken"
  }
}
_class("CEventRequestQuickGetServerInfo", CCallRequestEvent)
CEventRequestQuickGetServerInfo = CEventRequestQuickGetServerInfo

function CEventRequestQuickGetServerInfo:Constructor()
  self.login_info = MSDKAuthInfo:New()
end

CEventRequestQuickGetServerInfo._proto = {
  [1] = {
    "login_info",
    "MSDKAuthInfo"
  }
}
_class("CEventReplyQuickGetServerInfo", CCallReplyEvent)
CEventReplyQuickGetServerInfo = CEventReplyQuickGetServerInfo

function CEventReplyQuickGetServerInfo:Constructor()
  self.ret = 0
  self.default_gateway = MobileGatewayInfo:New()
  self.default_server = MobileServerInfo:New()
  self.server_list = {}
  self.bulletin_info = {}
  self.local_push_info_list = {}
  self.token = MobileNetToken:New()
end

CEventReplyQuickGetServerInfo._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "default_gateway",
    "MobileGatewayInfo"
  },
  [3] = {
    "default_server",
    "MobileServerInfo"
  },
  [4] = {
    "server_list",
    "list<MobileServerInfo>"
  },
  [5] = {
    "bulletin_info",
    "list<MobileBulletinInfo>"
  },
  [6] = {
    "local_push_info_list",
    "list<LocalPushInfo>"
  },
  [7] = {
    "token",
    "MobileNetToken"
  }
}
_class("CEventRequestQuickGetDefaultServerInfo", CCallRequestEvent)
CEventRequestQuickGetDefaultServerInfo = CEventRequestQuickGetDefaultServerInfo

function CEventRequestQuickGetDefaultServerInfo:Constructor()
  self.server_id = -1
  self.login_info = MSDKAuthInfo:New()
end

CEventRequestQuickGetDefaultServerInfo._proto = {
  [1] = {"server_id", "int"},
  [2] = {
    "login_info",
    "MSDKAuthInfo"
  }
}
_class("CEventReplyQuickGetDefaultServerInfo", CCallReplyEvent)
CEventReplyQuickGetDefaultServerInfo = CEventReplyQuickGetDefaultServerInfo

function CEventReplyQuickGetDefaultServerInfo:Constructor()
  self.ret = 0
  self.bulletin_info = {}
  self.default_server = MobileServerInfo:New()
  self.local_push_info_list = {}
  self.default_gateway = MobileGatewayInfo:New()
  self.token = MobileNetToken:New()
end

CEventReplyQuickGetDefaultServerInfo._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "bulletin_info",
    "list<MobileBulletinInfo>"
  },
  [3] = {
    "default_server",
    "MobileServerInfo"
  },
  [4] = {
    "local_push_info_list",
    "list<LocalPushInfo>"
  },
  [5] = {
    "default_gateway",
    "MobileGatewayInfo"
  },
  [6] = {
    "token",
    "MobileNetToken"
  }
}
_class("CEventRequestGetVersionInfo", CCallRequestEvent)
CEventRequestGetVersionInfo = CEventRequestGetVersionInfo

function CEventRequestGetVersionInfo:Constructor()
  self.client_app_version = ""
  self.osId = -1
  self.openId = ""
end

CEventRequestGetVersionInfo._proto = {
  [1] = {
    "client_app_version",
    "string"
  },
  [2] = {"osId", "int"},
  [3] = {"openId", "string"}
}
_class("CEventReplyGetVersionInfo", CCallReplyEvent)
CEventReplyGetVersionInfo = CEventReplyGetVersionInfo

function CEventReplyGetVersionInfo:Constructor()
  self.ret = 0
  self.version_info = HotUpdateVersionInfo:New()
  self.verify_bulletin_info = BulletinInfo:New()
end

CEventReplyGetVersionInfo._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "version_info",
    "HotUpdateVersionInfo"
  },
  [3] = {
    "verify_bulletin_info",
    "BulletinInfo"
  }
}
_class("CEventRequestZoneInfo", CCallRequestEvent)
CEventRequestZoneInfo = CEventRequestZoneInfo

function CEventRequestZoneInfo:Constructor()
  self.client_app_version = ""
  self.osId = -1
end

CEventRequestZoneInfo._proto = {
  [1] = {
    "client_app_version",
    "string"
  },
  [2] = {"osId", "int"}
}
_class("CEventReplyZoneInfo", CCallReplyEvent)
CEventReplyZoneInfo = CEventReplyZoneInfo

function CEventReplyZoneInfo:Constructor()
  self.ret = 0
  self.zone_info = {}
end

CEventReplyZoneInfo._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "zone_info",
    "list<bulletin_zone_info>"
  }
}
_class("CEventRequestMailMaintainInfo", CCallRequestEvent)
CEventRequestMailMaintainInfo = CEventRequestMailMaintainInfo

function CEventRequestMailMaintainInfo:Constructor()
  self.mail = ""
end

CEventRequestMailMaintainInfo._proto = {
  [1] = {"mail", "string"}
}
_class("CEventReplyMailMaintainInfo", CCallReplyEvent)
CEventReplyMailMaintainInfo = CEventReplyMailMaintainInfo

function CEventReplyMailMaintainInfo:Constructor()
  self.ret = 0
  self.isActive = 0
end

CEventReplyMailMaintainInfo._proto = {
  [1] = {"ret", "int"},
  [2] = {"isActive", "int"}
}
_class("CEventRequestGetVersionInfo2", CCallRequestEvent)
CEventRequestGetVersionInfo2 = CEventRequestGetVersionInfo2

function CEventRequestGetVersionInfo2:Constructor()
  self.client_app_version = ""
  self.osId = -1
  self.openId = ""
  self.client_res_version = ""
  self.device_model = ""
  self.operating_system = ""
end

CEventRequestGetVersionInfo2._proto = {
  [1] = {
    "client_app_version",
    "string"
  },
  [2] = {"osId", "int"},
  [3] = {"openId", "string"},
  [4] = {
    "client_res_version",
    "string"
  },
  [5] = {
    "device_model",
    "string"
  },
  [6] = {
    "operating_system",
    "string"
  }
}
_class("CEventReplyGetVersionInfo2", CCallReplyEvent)
CEventReplyGetVersionInfo2 = CEventReplyGetVersionInfo2

function CEventReplyGetVersionInfo2:Constructor()
  self.ret = 0
  self.version_info = HotUpdateVersionInfo:New()
  self.verify_bulletin_info = BulletinInfo:New()
  self.first_app_cfg_url_suffix = ""
  self.enable_native_download = false
end

CEventReplyGetVersionInfo2._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "version_info",
    "HotUpdateVersionInfo"
  },
  [3] = {
    "verify_bulletin_info",
    "BulletinInfo"
  },
  [4] = {
    "first_app_cfg_url_suffix",
    "string"
  },
  [5] = {
    "enable_native_download",
    "bool"
  }
}
_class("CEventSvrNetworkCfgPush", CSvrPushEvent)
CEventSvrNetworkCfgPush = CEventSvrNetworkCfgPush

function CEventSvrNetworkCfgPush:Constructor()
  self.m_net_cfg_info = NetworkCfgInfo:New()
end

CEventSvrNetworkCfgPush._proto = {
  [1] = {
    "m_net_cfg_info",
    "NetworkCfgInfo"
  }
}
