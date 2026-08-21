local Enum_Login_Step = {
  E_Login_Step_Ready = 0,
  E_Login_Step_RequestZoneInfo = 1,
  E_Login_Step_RequestGetVersionInfo = 2,
  E_Login_Step_CheckVersion = 3,
  E_Login_Step_RequestGetDefaultServerInfo = 4,
  E_Login_Step_RequestLoginVerify = 5,
  E_Login_Step_RequestChooseRole = 6,
  E_Login_Step_RequestCreateRole = 7
}
_enum("Enum_Login_Step", Enum_Login_Step)
local ServerStatus = {
  ServerStatus_Invalid = -1,
  ServerStatus_Congestion = 0,
  ServerStatus_Hot = 1,
  ServerStatus_Normal = 2,
  ServerStatus_Stop = 3
}
_enum("ServerStatus", ServerStatus)
local ServerType = {
  ServerType_Invalid = -1,
  ServerType_Normal = 0,
  ServerType_New = 1,
  ServerType_Recommend = 2,
  ServerType_Test = 3
}
_enum("ServerType", ServerType)
_class("MobileServerInfo", Object)
MobileServerInfo = MobileServerInfo

function MobileServerInfo:Constructor()
  self.id = -1
  self.status = ServerStatus.ServerStatus_Normal
  self.type = ServerType.ServerType_Normal
  self.name = ""
  self.zone_id = 0
  self.maintain = false
  self.cfg_status = 0
end

MobileServerInfo._proto = {
  [1] = {"id", "int"},
  [2] = {"status", "int"},
  [3] = {"type", "int"},
  [4] = {"name", "string"},
  [5] = {"zone_id", "int"}
}
_class("MobileBulletinInfo", Object)
MobileBulletinInfo = MobileBulletinInfo

function MobileBulletinInfo:Constructor()
  self.id = -1
  self.start_time = 0
  self.end_time = 0
  self.title = ""
  self.url = ""
  self.content = ""
  self.timestr = ""
  self.user = ""
  self.rule = ""
end

MobileBulletinInfo._proto = {
  [1] = {"id", "int"},
  [2] = {"title", "string"},
  [3] = {"content", "string"},
  [4] = {"timestr", "string"},
  [5] = {"user", "string"},
  [6] = {"rule", "string"}
}
_class("LocalPushInfo", Object)
LocalPushInfo = LocalPushInfo

function LocalPushInfo:Constructor()
  self.day_interval = 1
  self.start = 0
  self.title = ""
  self.content = ""
end

LocalPushInfo._proto = {
  [1] = {
    "day_interval",
    "int"
  },
  [2] = {"start", "time"},
  [3] = {"title", "string"},
  [4] = {"content", "string"}
}
_class("MobileGatewayInfo", Object)
MobileGatewayInfo = MobileGatewayInfo

function MobileGatewayInfo:Constructor()
  self.id = -1
  self.ip = ""
  self.port = 0
  self.proxy_port = 0
end

MobileGatewayInfo._proto = {
  [1] = {"id", "int"},
  [2] = {"ip", "string"},
  [3] = {"port", "int"},
  [4] = {"proxy_port", "int"}
}
local HotUpdateStatus = {
  HoutUpdateStatus_OK = 0,
  HoutUpdateStatus_Fail = 1,
  HoutUpdateStatus_Server_Maintain = 2,
  HoutUpdateStatus_IsVerifyVersion = 3
}
_enum("HotUpdateStatus", HotUpdateStatus)
_class("HotUpdateVersionInfo", Object)
HotUpdateVersionInfo = HotUpdateVersionInfo

function HotUpdateVersionInfo:Constructor()
  self.min_app_version = ""
  self.app_force_full_update = false
  self.app_version = ""
  self.app_url_android = ""
  self.app_size_android = 0
  self.app_url_ios = ""
  self.res_version = ""
  self.res_url = ""
  self.redirect_optimize_period = 0
  self.zip_res_version = ""
  self.enable_multi_hotupdate = false
  self.min_not_update_app_version = ""
  self.enable_first_app_update = true
  self.first_app_cfg_url_suffix_map = {}
  self.res_root_name = ""
end

HotUpdateVersionInfo._proto = {
  [1] = {
    "min_app_version",
    "string"
  },
  [2] = {
    "app_force_full_update",
    "bool"
  },
  [3] = {
    "app_version",
    "string"
  },
  [4] = {
    "app_url_android",
    "string"
  },
  [5] = {
    "app_size_android",
    "uint64"
  },
  [6] = {
    "app_url_ios",
    "string"
  },
  [7] = {
    "res_version",
    "string"
  },
  [8] = {"res_url", "string"},
  [9] = {
    "redirect_optimize_period",
    "int"
  },
  [10] = {
    "zip_res_version",
    "string"
  },
  [11] = {
    "enable_multi_hotupdate",
    "bool"
  },
  [12] = {
    "enable_first_app_update",
    "bool"
  },
  [13] = {
    "res_root_name",
    "string"
  }
}
_class("NetworkCfgInfo", Object)
NetworkCfgInfo = NetworkCfgInfo

function NetworkCfgInfo:Constructor()
  self.network_cfg_ver = ""
  self.max_wait_tick4_send = 0
  self.max_wait_tick4_recv = 0
  self.max_wait_tick4_connect = 0
  self.max_wait_tick4_calltimelong = 0
  self.resend_delay_cd = 0
  self.wait_tick4_report = 0
end

NetworkCfgInfo._proto = {
  [1] = {
    "network_cfg_ver",
    "string"
  },
  [2] = {
    "max_wait_tick4_send",
    "int"
  },
  [3] = {
    "max_wait_tick4_recv",
    "int"
  },
  [4] = {
    "max_wait_tick4_connect",
    "int"
  },
  [5] = {
    "max_wait_tick4_calltimelong",
    "int"
  },
  [6] = {
    "resend_delay_cd",
    "int"
  },
  [7] = {
    "wait_tick4_report",
    "int"
  }
}
_class("BulletinInfo", Object)
BulletinInfo = BulletinInfo

function BulletinInfo:Constructor()
  self.id = 0
  self.name = ""
  self.host = ""
  self.port = 0
end

BulletinInfo._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {"host", "string"},
  [4] = {"port", "ushort"}
}
_class("bulletin_zone_info", Object)
bulletin_zone_info = bulletin_zone_info

function bulletin_zone_info:Constructor()
  self.id = 1
  self.zone_name = ""
  self.domain_name = ""
  self.port = 0
  self.status = ServerStatus.ServerStatus_Normal
  self.type = ServerType.ServerType_Recommend
  self.is_skip = false
end

bulletin_zone_info._proto = {
  [1] = {"id", "int"},
  [2] = {"zone_name", "string"},
  [3] = {
    "domain_name",
    "string"
  },
  [4] = {"port", "int"},
  [5] = {"status", "int"},
  [6] = {"type", "int"},
  [7] = {"is_skip", "bool"}
}
