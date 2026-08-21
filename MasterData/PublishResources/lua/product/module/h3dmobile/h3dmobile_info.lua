local MaintainState = {
  MS_Close = 1,
  MS_Open = 2,
  MS_Test = 3
}
_enum("MaintainState", MaintainState)
local APPPublishType = {
  APT_INTL = 1,
  APT_US = 2,
  APT_HMT = 3,
  APT_INLAND = 4
}
_enum("APPPublishType", APPPublishType)
local APPPublishSubType = {
  APST_INTL_BEGIN = 1,
  APST_JA = 1,
  APST_KO = 2,
  APST_EU = 3,
  APST_SE = 4,
  APST_SA = 5,
  APST_INTL_END = 100,
  APST_US_BEGIN = 101,
  APST_NA = 101,
  APST_US_END = 200,
  APST_HMT_BEGIN = 201,
  APST_HMT = 201,
  APST_HMT_END = 300,
  APST_INLAND_BEGIN = 301,
  APST_INLAND_END = 400
}
_enum("APPPublishSubType", APPPublishSubType)
local MOBILE_LOGIN_ERROR = {
  MOBILE_LOGIN_OK = 0,
  MOBILE_LOGIN_SERVER_LIMIT = 100,
  MOBILE_LOGIN_SERVER_MAINTAIN = 101,
  MOBILE_LOGIN_EMPTY_OPENID = 200,
  MOBILE_LOGIN_MSDK_ERROR = 201,
  MOBILE_LOGIN_LOW_VERSION = 202,
  MOBILE_LOGIN_HIGH_VERSION = 203,
  MOBILE_LOGIN_BANNED = 204,
  MOBILE_LOGIN_NOT_ACTIVITY = 205,
  MOBILE_LOGIN_ERROR_ACTIVATIONCODE = 206,
  MOBILE_LOGIN_INDULGE_KICK = 207,
  MOBILE_LOGIN_HOT_UPDATE_MUST_UPDATE = 208,
  MOBILE_LOGIN_HOT_UPDATE_REDOWNLOAD = 209,
  MOBILE_LOGIN_BAN = 210,
  MOBILE_LOGIN_MSDK_THIRD_ERROR = 211,
  MOBILE_LOGIN_SESSION_ERROR = 300,
  MOBILE_LOGIN_STATUS_ERROR = 301,
  MOBILE_LOGIN_GROUP_ERROR = 302,
  MOBILE_LOGIN_NO_PLAYER = 303,
  MOBILE_LOGIN_RETRY = 304
}
_enum("MOBILE_LOGIN_ERROR", MOBILE_LOGIN_ERROR)
local MOBILE_LOGOUT_ERROR = {
  MOBILE_LOGOUT_PLAYER_LOGOUT = 0,
  MOBILE_LOGOUT_SERVER_KICK = 1,
  MOBILE_LOGOUT_SERVER_LIMIT = 2,
  MOBILE_LOGOUT_SHUTDOWN_KICK = 3,
  MOBILE_LOGOUT_NO_PLAYER = 4,
  MOBILE_LOGOUT_NOT_LOGIN = 5,
  MOBILE_LOGOUT_MULTI_LOGIN = 6,
  MOBILE_LOGOUT_NOPACK_TIMEOUT = 7,
  MOBILE_LOGOUT_LSMTIMEOUT = 8,
  MOBILE_LOGOUT_TOKEN_EXPIRE = 9,
  MOBILE_LOGOUT_LOADDATA = 10,
  MOBILE_LOGOUT_LEAVE_GROUP = 11,
  MOBILE_LOGOUT_LEAVE_ROOM = 12,
  MOBILE_LOGOUT_MATCH_ERROR = 13,
  MOBILE_LOGOUT_LOGIN_BAN = 200,
  MOBILE_LOGOUT_DEL_ROLE = 201,
  MOBILE_LOGOUT_IDIP_KICK = 202,
  MOBILE_LOGOUT_IDIP_ZERO_PROFIT = 203,
  MOBILE_LAYOUT_IDG_KICK = 299
}
_enum("MOBILE_LOGOUT_ERROR", MOBILE_LOGOUT_ERROR)
local MobileClientLaunchChannel = {MCLC_Normal = 0, MCLC_Hall = 1}
_enum("MobileClientLaunchChannel", MobileClientLaunchChannel)
local MOBILE_NOTIFICATION_TYPE = {MOBILE_NOTIFICATION_FORCE_CLIENT_UPDATE = 0, MOBILE_NOTIFICATION_FORCE_RESVER_UPDATE = 1}
_enum("MOBILE_NOTIFICATION_TYPE", MOBILE_NOTIFICATION_TYPE)
_class("MSDKTokenInfo", Object)
MSDKTokenInfo = MSDKTokenInfo

function MSDKTokenInfo:Constructor()
  self.type = -1
  self.value = ""
  self.expiration = 0
end

MSDKTokenInfo._proto = {
  [1] = {"type", "int"},
  [2] = {"value", "string"},
  [3] = {"expiration", "time"}
}
_class("MSDKAuthInfo", Object)
MSDKAuthInfo = MSDKAuthInfo

function MSDKAuthInfo:Constructor()
  self.flag = 0
  self.desc = ""
  self.platform = 0
  self.open_id = ""
  self.user_id = ""
  self.pf = ""
  self.pf_key = ""
  self.m_token = ""
  self.m_pay_token = ""
end

MSDKAuthInfo._proto = {
  [1] = {"flag", "int"},
  [2] = {"desc", "string"},
  [3] = {"platform", "int"},
  [4] = {"open_id", "string"},
  [5] = {"user_id", "string"},
  [6] = {"pf", "string"},
  [7] = {"pf_key", "string"},
  [8] = {"m_token", "string"},
  [9] = {
    "m_pay_token",
    "string"
  }
}
_class("MobileNetToken", Object)
MobileNetToken = MobileNetToken

function MobileNetToken:Constructor()
  self.type = 0
  self.serial = 0
  self.token_id = 0
end

MobileNetToken._proto = {
  [1] = {"type", "short"},
  [2] = {"serial", "short"},
  [3] = {"token_id", "int64"}
}
local H3DLanguageType = {
  lt_zh = 1,
  lt_tw = 2,
  lt_us = 4,
  lt_kr = 8,
  lt_jp = 15
}
_enum("H3DLanguageType", H3DLanguageType)
local MobileClientLoginChannel = {
  MCLC_NONE = -1,
  MCLC_PC = 0,
  MCLC_WX = 1,
  MCLC_QQ = 2,
  MCLC_GUEST = 3,
  MCLC_FACEBOOK = 4,
  MCLC_GAME_CENTER = 5,
  MCLC_GOOGLE_PLAY = 6,
  MCLC_TWITTER = 9,
  MCLC_GARENA = 10,
  MCLC_SELF = 11,
  MCLC_EGAME = 12,
  MCLC_NINTENDO = 13,
  MCLC_LINE = 14,
  MCLC_APPLE = 15,
  MCLC_DMM = 30,
  MCLC_LI = 131,
  MCLC_QRCODE = 1000,
  MCLC_AUTO = 1001,
  MCLC_IEG_PASS_START = 58,
  MCLC_IEG_PASS_1 = 58,
  MCLC_IEG_PASS_2 = 59,
  MCLC_IEG_PASS_3 = 61,
  MCLC_IEG_PASS_END = 61
}
_enum("MobileClientLoginChannel", MobileClientLoginChannel)
local ClientRuntimeOS = {
  CRO_PC = 0,
  CRO_ANDROID = 1,
  CRO_IOS = 2,
  CRO_EDITOR = 20
}
_enum("ClientRuntimeOS", ClientRuntimeOS)
local StoreChannel = {
  SC_APPSTORE = 0,
  SC_GOOGLEPLAY = 1,
  SC_GALAXY = 2,
  SC_DMM = 3,
  SC_ONESTORE = 8,
  SC_AMAZON = 10
}
_enum("StoreChannel", StoreChannel)
_class("MobileClientInfo", Object)
MobileClientInfo = MobileClientInfo

function MobileClientInfo:Constructor()
  self.m_runtime_os = 0
  self.client_version = ""
  self.m_login_source = 0
  self.server_list_md5 = ""
  self.device_info = ""
  self.m_fps = 0
  self.m_net_type = 0
  self.m_reg_channel = ""
  self.m_login_channel = ""
  self.m_launch_channel = MobileClientLaunchChannel.MCLC_Normal
  self.operatings_system = ""
  self.processor_type = ""
  self.processor_count = 0
  self.system_memorysize = 0
  self.graphics_memorysize = 0
  self.graphics_devicename = ""
  self.graphics_devicevendor = ""
  self.graphics_deviceid = 0
  self.graphics_device_vendorid = 0
  self.graphics_device_version = ""
  self.graphics_shader_level = 0
  self.supports_shadows = false
  self.supports_render_textures = false
  self.supports_image_effects = false
  self.device_unique_identifier = ""
  self.device_name = ""
  self.device_model = ""
  self.lod_level = 0
  self.is_guest = false
  self.client_app_version = ""
  self.client_res_version = ""
  self.idfv = ""
  self.android_id = ""
  self.m_store_channel = 0
end

local SystemInfo = UnityEngine.SystemInfo

function MobileClientInfo:IsGuest()
  return self.is_guest
end

function MobileClientInfo:Initialize(qqwx, lod_level)
  self.m_login_source = qqwx
  self.m_runtime_os = GetPlatformOS()
  self.lod_level = lod_level
  self.operatings_system = SystemInfo.operatingSystem
  self.processor_type = SystemInfo.processorType
  self.processor_count = SystemInfo.processorCount
  self.system_memorysize = SystemInfo.systemMemorySize
  self.graphics_memorysize = SystemInfo.graphicsMemorySize
  self.graphics_devicename = SystemInfo.graphicsDeviceName
  self.graphics_devicevendor = SystemInfo.graphicsDeviceVendor
  self.graphics_deviceid = SystemInfo.graphicsDeviceID
  self.graphics_device_vendorid = SystemInfo.graphicsDeviceVendorID
  self.graphics_device_version = SystemInfo.graphicsDeviceVersion
  self.graphics_shader_level = SystemInfo.graphicsShaderLevel
  self.supports_shadows = SystemInfo.supportsShadows
  self.supports_render_textures = true
  self.supports_image_effects = SystemInfo.supportsImageEffects
  self.device_unique_identifier = SystemInfo.deviceUniqueIdentifier
  self.device_name = SystemInfo.deviceName
  self.device_model = SystemInfo.deviceModel
  self.m_net_type = GetInternetReachability()
end

MobileClientInfo._proto = {
  [1] = {
    "m_runtime_os",
    "int"
  },
  [2] = {
    "client_version",
    "string"
  },
  [3] = {
    "m_login_source",
    "int"
  },
  [4] = {
    "server_list_md5",
    "string"
  },
  [5] = {
    "device_info",
    "string"
  },
  [6] = {"m_fps", "int"},
  [7] = {"m_net_type", "int"},
  [8] = {
    "m_reg_channel",
    "string"
  },
  [9] = {
    "m_login_channel",
    "string"
  },
  [10] = {
    "m_launch_channel",
    "int"
  },
  [11] = {
    "operatings_system",
    "string"
  },
  [12] = {
    "processor_type",
    "string"
  },
  [13] = {
    "processor_count",
    "int"
  },
  [14] = {
    "system_memorysize",
    "int"
  },
  [15] = {
    "graphics_memorysize",
    "int"
  },
  [16] = {
    "graphics_devicename",
    "string"
  },
  [17] = {
    "graphics_devicevendor",
    "string"
  },
  [18] = {
    "graphics_deviceid",
    "int"
  },
  [19] = {
    "graphics_device_vendorid",
    "int"
  },
  [20] = {
    "graphics_device_version",
    "string"
  },
  [21] = {
    "graphics_shader_level",
    "int"
  },
  [22] = {
    "supports_shadows",
    "bool"
  },
  [23] = {
    "supports_render_textures",
    "bool"
  },
  [24] = {
    "supports_image_effects",
    "bool"
  },
  [25] = {
    "device_unique_identifier",
    "string"
  },
  [26] = {
    "device_name",
    "string"
  },
  [27] = {
    "device_model",
    "string"
  },
  [28] = {"lod_level", "int"},
  [29] = {"is_guest", "bool"},
  [30] = {
    "client_app_version",
    "string"
  },
  [31] = {
    "client_res_version",
    "string"
  },
  [32] = {"idfv", "string"},
  [33] = {"android_id", "string"},
  [34] = {
    "m_store_channel",
    "int"
  }
}
_class("GamePlayerNum", Object)
GamePlayerNum = GamePlayerNum

function GamePlayerNum:Constructor()
  self.gameId = 0
  self.androidNum = 0
  self.iosNum = 0
end

GamePlayerNum._proto = {
  [1] = {"gameId", "int"},
  [2] = {"androidNum", "int"},
  [3] = {"iosNum", "int"}
}
