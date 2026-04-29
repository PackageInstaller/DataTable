local MailType = {
  MAIL_TYPE_UNKNOWN = 0,
  MAIL_TYPE_SYSTEM = 1,
  MAIL_TYPE_MAZE_RESET = 2,
  MAIL_TYPE_MONTH_GIFT = 3,
  MAIL_TYPE_GM_SYSTEM_NOTICE = 10,
  MAIL_TYPE_HALL_FIRST_LOGIN = 11,
  MAIL_TYPE_SCENARIO = 21,
  MAIL_TYPE_ITEM_CONVER = 22,
  MAIL_TYPE_FIX_ITEM = 23,
  MAIL_TYPE_TOWER_COMPENTSATE = 24,
  MAIL_TYPE_TEXT_CONVER = 25,
  MAIL_TYPE_COMMON = 26,
  MAIL_TYPE_CAM_QUEST = 27,
  MAIL_TYPE_MAX = 28
}
_enum("MailType", MailType)
local MailErrorCode = {
  MAIL_SUCC = 0,
  MAIL_FAILED = 1,
  MAIL_ALREADY_GAIN = 2,
  MAIL_ERR_PSTID = 3,
  MAIL_ERR_NOLOGIN = 4,
  MAIL_INVALID_MAILTID = 5,
  MAIL_ERR_DB = 6,
  MAIL_INVALID_MAILTYPE = 7,
  MAIL_ERR_GENERATEID = 8,
  MAIL_ERR_NOAPPENDIX = 9,
  MAIL_ERR_INVALIDTEMPLATEID = 10,
  MAIL_ERR_INVALIDNOTICEMAIL = 11,
  MAIL_ERR_DEL_EXIST_APPENDIX = 12,
  MAIL_ERR_MAIL_EXPIRED = 13,
  MAIL_ERR_MAIL_EXIST = 14,
  MAIL_ALREADY_READ = 15,
  MAIL_ERR_MAIL_HAVE_APPENDIX = 16,
  MAIL_ERR_MAIL_BATCHMAIL_EMPTY = 17,
  MAIL_ERR_NICK_ICON_STR_MAX_SIZE = 18,
  MAIL_ERR_TITLE_STR_MAX_SIZE = 19,
  MAIL_ERR_CONTENT_STR_MAX_SIZE = 20,
  MAIL_ERR_WRONG_SERVER = 22,
  MAIL_ERR_OPERATOR_CONFLICT = 23,
  MAIL_ERR_NO_HAVE_NEW_SYS_MAIL = 24,
  MAIL_ERR_PHY_IS_LIMIT = 25,
  MAIL_ERR_ASSET_DOUBLE_RES_LIMIT = 26,
  MAIL_ERR_ASSET_ACTIVE_TOKEN_LIMIT = 27
}
_enum("MailErrorCode", MailErrorCode)
_class("MobileMailInfo", Object)
MobileMailInfo = MobileMailInfo

function MobileMailInfo:Constructor()
  self.mail_id = 0
  self.sender_nick = ""
  self.sender_icon_id = ""
  self.title_id = ""
  self.content_id = ""
  self.create_time = 0
  self.remain_time = 0
  self.is_gain = false
  self.is_read = false
  self.appendix = {}
  self.mail_type = 0
  self.content_id_ext = RoleAsset:New()
  self.content_param = {}
end

MobileMailInfo._proto = {
  [1] = {"mail_id", "int64"},
  [2] = {
    "sender_nick",
    "string"
  },
  [3] = {
    "sender_icon_id",
    "string"
  },
  [4] = {"title_id", "string"},
  [5] = {"content_id", "string"},
  [6] = {
    "create_time",
    "time"
  },
  [7] = {
    "remain_time",
    "int"
  },
  [8] = {"is_gain", "bool"},
  [9] = {"is_read", "bool"},
  [10] = {
    "appendix",
    "list<RoleAsset>"
  },
  [11] = {"mail_type", "int"},
  [12] = {
    "content_id_ext",
    "RoleAsset"
  },
  [13] = {
    "content_param",
    "list<string>"
  }
}
