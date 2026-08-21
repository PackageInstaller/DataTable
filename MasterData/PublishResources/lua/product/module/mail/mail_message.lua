require("message_def")
local mailMessageDef = {
  CLSID_CEventMobileTestCases = 10000,
  CLSID_CEventMobileTestCasesRes = 10001,
  CLSID_CEventMobileNotifyNewMail = 10002,
  CLSID_CEventMobileNotifyExpiredMail = 10003,
  CLSID_CEventMobileReqMail = 10004,
  CLSID_CEventMobileReqMailRes = 10005,
  CLSID_CEventMobileReadMail = 10006,
  CLSID_CEventMobileReadMailRes = 10007,
  CLSID_CEventMobileDeleteMail = 10008,
  CLSID_CEventMobileDeleteMailRes = 10009,
  CLSID_CEventMobileDeleteAllMail = 10010,
  CLSID_CEventMobileDeleteAllMailRes = 10011,
  CLSID_CEventMobileGetOneMail = 10012,
  CLSID_CEventMobileGetOneMailRes = 10013,
  CLSID_CEventMobileGetAllMail = 10014,
  CLSID_CEventMobileGetAllMailRes = 10015
}
table.append(MessageDef, mailMessageDef)
_class("CEventMobileTestCases", CCallRequestEvent)
CEventMobileTestCases = CEventMobileTestCases

function CEventMobileTestCases:Constructor()
end

CEventMobileTestCases._proto = {}
_class("CEventMobileTestCasesRes", CCallReplyEvent)
CEventMobileTestCasesRes = CEventMobileTestCasesRes

function CEventMobileTestCasesRes:Constructor()
  self.ret = 0
end

CEventMobileTestCasesRes._proto = {
  [1] = {"ret", "int"}
}
_class("CEventMobileNotifyNewMail", CSvrPushEvent)
CEventMobileNotifyNewMail = CEventMobileNotifyNewMail

function CEventMobileNotifyNewMail:Constructor()
end

CEventMobileNotifyNewMail._proto = {}
_class("CEventMobileNotifyExpiredMail", CSvrPushEvent)
CEventMobileNotifyExpiredMail = CEventMobileNotifyExpiredMail

function CEventMobileNotifyExpiredMail:Constructor()
  self.expired_mail_vec = {}
end

CEventMobileNotifyExpiredMail._proto = {
  [3] = {
    "expired_mail_vec",
    "list<int64>"
  }
}
_class("CEventMobileReqMail", CCallRequestEvent)
CEventMobileReqMail = CEventMobileReqMail

function CEventMobileReqMail:Constructor()
end

CEventMobileReqMail._proto = {}
_class("CEventMobileReqMailRes", CCallReplyEvent)
CEventMobileReqMailRes = CEventMobileReqMailRes

function CEventMobileReqMailRes:Constructor()
  self.ret = 0
  self.mail_vec = {}
  self.collect_mail_vec = {}
end

CEventMobileReqMailRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "mail_vec",
    "list<MobileMailInfo>"
  },
  [3] = {
    "collect_mail_vec",
    "list<MobileMailInfo>"
  }
}
_class("CEventMobileReadMail", CCallRequestEvent)
CEventMobileReadMail = CEventMobileReadMail

function CEventMobileReadMail:Constructor()
  self.mail_id = 0
end

CEventMobileReadMail._proto = {
  [1] = {"mail_id", "int64"}
}
_class("CEventMobileReadMailRes", CCallReplyEvent)
CEventMobileReadMailRes = CEventMobileReadMailRes

function CEventMobileReadMailRes:Constructor()
  self.ret = 0
  self.mail_id = 0
end

CEventMobileReadMailRes._proto = {
  [1] = {"ret", "int"},
  [2] = {"mail_id", "int64"}
}
_class("CEventMobileDeleteMail", CCallRequestEvent)
CEventMobileDeleteMail = CEventMobileDeleteMail

function CEventMobileDeleteMail:Constructor()
  self.mail_id = 0
end

CEventMobileDeleteMail._proto = {
  [1] = {"mail_id", "int64"}
}
_class("CEventMobileDeleteMailRes", CCallReplyEvent)
CEventMobileDeleteMailRes = CEventMobileDeleteMailRes

function CEventMobileDeleteMailRes:Constructor()
  self.ret = 0
  self.mail_id = 0
end

CEventMobileDeleteMailRes._proto = {
  [1] = {"ret", "int"},
  [2] = {"mail_id", "int64"}
}
_class("CEventMobileDeleteAllMail", CCallRequestEvent)
CEventMobileDeleteAllMail = CEventMobileDeleteAllMail

function CEventMobileDeleteAllMail:Constructor()
end

CEventMobileDeleteAllMail._proto = {}
_class("CEventMobileDeleteAllMailRes", CCallReplyEvent)
CEventMobileDeleteAllMailRes = CEventMobileDeleteAllMailRes

function CEventMobileDeleteAllMailRes:Constructor()
  self.ret = 0
  self.mail_vec = {}
end

CEventMobileDeleteAllMailRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "mail_vec",
    "list<MobileMailInfo>"
  }
}
_class("CEventMobileGetOneMail", CCallRequestEvent)
CEventMobileGetOneMail = CEventMobileGetOneMail

function CEventMobileGetOneMail:Constructor()
  self.mail_id = 0
end

CEventMobileGetOneMail._proto = {
  [1] = {"mail_id", "int64"}
}
_class("CEventMobileGetOneMailRes", CCallReplyEvent)
CEventMobileGetOneMailRes = CEventMobileGetOneMailRes

function CEventMobileGetOneMailRes:Constructor()
  self.ret = 0
  self.mail_id = 0
  self.reward_vec = {}
end

CEventMobileGetOneMailRes._proto = {
  [1] = {"ret", "int"},
  [2] = {"mail_id", "int64"},
  [3] = {
    "reward_vec",
    "list<RoleAsset>"
  }
}
_class("CEventMobileGetAllMail", CCallRequestEvent)
CEventMobileGetAllMail = CEventMobileGetAllMail

function CEventMobileGetAllMail:Constructor()
  self.get_collect = false
end

CEventMobileGetAllMail._proto = {
  [1] = {
    "get_collect",
    "bool"
  }
}
_class("CEventMobileGetAllMailRes", CCallReplyEvent)
CEventMobileGetAllMailRes = CEventMobileGetAllMailRes

function CEventMobileGetAllMailRes:Constructor()
  self.ret = 0
  self.mail_vec = {}
  self.reward_vec = {}
end

CEventMobileGetAllMailRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "mail_vec",
    "list<MobileMailInfo>"
  },
  [3] = {
    "reward_vec",
    "list<RoleAsset>"
  }
}
