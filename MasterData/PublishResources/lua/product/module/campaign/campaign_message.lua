require("message_def")
local campaignMessageDef = {
  CLSID_CEventRequestCampaignLoadInfoList = 35000,
  CLSID_CEventReplyCampaignLoadInfoList = 35001,
  CLSID_CEventRequestCampaignLoadInfo = 35002,
  CLSID_CEventReplyCampaignLoadInfo = 35003,
  CLSID_CEventCampaignRequest = 35004,
  CLSID_CEventCampaignReply = 35005,
  CLSID_CEventCampaignPushNotify = 35006,
  CLSID_CEventStepChangeNotify = 35007,
  CLSID_CEventChangeCampaignSampleNotify = 35008,
  CLSID_CEventRequestCampaignSetRemind = 35009,
  CLSID_CEventReplyCampaignSetRemind = 35010,
  CLSID_CEventRequestCampaignClearNewFlag = 35011,
  CLSID_CEventReplyCampaignClearNewFlag = 35012,
  CLSID_CEventRequestCampaignGetMatchMissionExReward = 35013,
  CLSID_CEventReplyCampaignGetMatchMissionExReward = 35014,
  CLSID_CEventRequestCampaignGetMatchMissionArrayExReward = 35015,
  CLSID_CEventReplyCampaignGetMatchMissionArrayExReward = 35016,
  CLSID_CEventUnlockCampaignReq = 35017,
  CLSID_CEventUnlockCampaignRes = 35018,
  CLSID_CEventRequestCampaignReviewLoadInfoList = 35019,
  CLSID_CEventReplyCampaignReviewLoadInfoList = 35020,
  CLSID_CEventEnterCampaignReviewReq = 35021,
  CLSID_CEventEnterCampaignReviewRes = 35022,
  CLSID_CEventCampaignLoadComponentRankReq = 35023,
  CLSID_CEventCampaignLoadComponentRankRes = 35024,
  CLSID_CEventCampaignTeamRecordReq = 35025,
  CLSID_CEventCampaignTeamRecordRes = 35026,
  CLSID_CEventRequestCampaignPreviewList = 35027,
  CLSID_CEventReplyCampaignPreviewList = 35028
}
table.append(MessageDef, campaignMessageDef)
_class("CEventRequestCampaignLoadInfoList", CCallRequestEvent)
CEventRequestCampaignLoadInfoList = CEventRequestCampaignLoadInfoList

function CEventRequestCampaignLoadInfoList:Constructor()
end

CEventRequestCampaignLoadInfoList._proto = {}
_class("CEventReplyCampaignLoadInfoList", CCallReplyEvent)
CEventReplyCampaignLoadInfoList = CEventReplyCampaignLoadInfoList

function CEventReplyCampaignLoadInfoList:Constructor()
  self.ret = 0
  self.sample_list = {}
  self.recomond_index = 0
  self.campaing_review_time_start = 0
end

CEventReplyCampaignLoadInfoList._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "sample_list",
    "list<campaign_sample>"
  },
  [3] = {
    "recomond_index",
    "int"
  },
  [4] = {
    "campaing_review_time_start",
    "time"
  }
}
_class("CEventRequestCampaignLoadInfo", CCallRequestEvent)
CEventRequestCampaignLoadInfo = CEventRequestCampaignLoadInfo

function CEventRequestCampaignLoadInfo:Constructor()
  self.m_id = 0
end

CEventRequestCampaignLoadInfo._proto = {
  [1] = {"m_id", "int"}
}
_class("CEventReplyCampaignLoadInfo", CCallReplyEvent)
CEventReplyCampaignLoadInfo = CEventReplyCampaignLoadInfo

function CEventReplyCampaignLoadInfo:Constructor()
  self.ret = 0
  self.m_campaign_load_info = CampaignLoadInfo:New()
end

CEventReplyCampaignLoadInfo._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "m_campaign_load_info",
    "CampaignLoadInfo"
  }
}
_class("CEventCampaignRequest", CCallRequestEvent)
CEventCampaignRequest = CEventCampaignRequest

function CEventCampaignRequest:Constructor()
  self.m_id = 0
  self.m_component_id = 0
  self.m_opt = 0
  self.m_config_version = 0
  self.m_last_interactive_time = 0
  self.m_req_data = ""
end

CEventCampaignRequest._proto = {
  [1] = {"m_id", "int"},
  [2] = {
    "m_component_id",
    "int"
  },
  [3] = {"m_opt", "int"},
  [4] = {
    "m_config_version",
    "int"
  },
  [5] = {
    "m_last_interactive_time",
    "time"
  },
  [6] = {"m_req_data", "buffer"}
}
_class("CEventCampaignReply", CCallReplyEvent)
CEventCampaignReply = CEventCampaignReply

function CEventCampaignReply:Constructor()
  self.ret = 0
  self.m_component_step = 0
  self.m_rep_data = ""
end

CEventCampaignReply._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "m_component_step",
    "int"
  },
  [3] = {"m_rep_data", "buffer"}
}
_class("CEventCampaignPushNotify", CSvrPushEvent)
CEventCampaignPushNotify = CEventCampaignPushNotify

function CEventCampaignPushNotify:Constructor()
  self.m_campaign_id = 0
  self.m_component_id = 0
  self.m_component_step = 0
  self.m_push_data = ICampaignNotifyDataInfo:New()
end

CEventCampaignPushNotify._proto = {
  [1] = {
    "m_campaign_id",
    "int"
  },
  [2] = {
    "m_component_id",
    "int"
  },
  [3] = {
    "m_component_step",
    "int"
  },
  [4] = {
    "m_push_data",
    "ICampaignNotifyDataInfo"
  }
}
_class("CEventStepChangeNotify", CSvrPushEvent)
CEventStepChangeNotify = CEventStepChangeNotify

function CEventStepChangeNotify:Constructor()
  self.m_process = campaign_process:New()
  self.m_component_steps = {}
end

CEventStepChangeNotify._proto = {
  [1] = {
    "m_process",
    "campaign_process"
  },
  [2] = {
    "m_component_steps",
    "map<int,int>"
  }
}
_class("CEventChangeCampaignSampleNotify", CSvrPushEvent)
CEventChangeCampaignSampleNotify = CEventChangeCampaignSampleNotify

function CEventChangeCampaignSampleNotify:Constructor()
  self.sample_list = {}
end

CEventChangeCampaignSampleNotify._proto = {
  [1] = {
    "sample_list",
    "list<campaign_sample>"
  }
}
_class("CEventRequestCampaignSetRemind", CCallRequestEvent)
CEventRequestCampaignSetRemind = CEventRequestCampaignSetRemind

function CEventRequestCampaignSetRemind:Constructor()
  self.campaign_id = 0
  self.is_close_remind = false
  self.cfg_version = 0
  self.com_last_interactive_time = 0
end

CEventRequestCampaignSetRemind._proto = {
  [1] = {
    "campaign_id",
    "int"
  },
  [2] = {
    "is_close_remind",
    "bool"
  },
  [3] = {
    "cfg_version",
    "int"
  },
  [4] = {
    "com_last_interactive_time",
    "time"
  }
}
_class("CEventReplyCampaignSetRemind", CCallReplyEvent)
CEventReplyCampaignSetRemind = CEventReplyCampaignSetRemind

function CEventReplyCampaignSetRemind:Constructor()
  self.ret = 0
end

CEventReplyCampaignSetRemind._proto = {
  [1] = {"ret", "int"}
}
_class("CEventRequestCampaignClearNewFlag", CCallRequestEvent)
CEventRequestCampaignClearNewFlag = CEventRequestCampaignClearNewFlag

function CEventRequestCampaignClearNewFlag:Constructor()
  self.m_campaign_id = 0
end

CEventRequestCampaignClearNewFlag._proto = {
  [1] = {
    "m_campaign_id",
    "int"
  }
}
_class("CEventReplyCampaignClearNewFlag", CCallReplyEvent)
CEventReplyCampaignClearNewFlag = CEventReplyCampaignClearNewFlag

function CEventReplyCampaignClearNewFlag:Constructor()
  self.m_ret = 0
end

CEventReplyCampaignClearNewFlag._proto = {
  [1] = {"m_ret", "int"}
}
_class("CEventRequestCampaignGetMatchMissionExReward", CCallRequestEvent)
CEventRequestCampaignGetMatchMissionExReward = CEventRequestCampaignGetMatchMissionExReward

function CEventRequestCampaignGetMatchMissionExReward:Constructor()
  self.eMatchType = 0
  self.nMissionId = 0
end

CEventRequestCampaignGetMatchMissionExReward._proto = {
  [1] = {"eMatchType", "int"},
  [2] = {"nMissionId", "int"}
}
_class("CEventReplyCampaignGetMatchMissionExReward", CCallReplyEvent)
CEventReplyCampaignGetMatchMissionExReward = CEventReplyCampaignGetMatchMissionExReward

function CEventReplyCampaignGetMatchMissionExReward:Constructor()
  self.campaign_reward = {}
end

CEventReplyCampaignGetMatchMissionExReward._proto = {
  [1] = {
    "campaign_reward",
    "list<RoleAsset>"
  }
}
_class("CEventRequestCampaignGetMatchMissionArrayExReward", CCallRequestEvent)
CEventRequestCampaignGetMatchMissionArrayExReward = CEventRequestCampaignGetMatchMissionArrayExReward

function CEventRequestCampaignGetMatchMissionArrayExReward:Constructor()
  self.eMatchType = 0
  self.nArrMissionId = {}
end

CEventRequestCampaignGetMatchMissionArrayExReward._proto = {
  [1] = {"eMatchType", "int"},
  [2] = {
    "nArrMissionId",
    "list<int>"
  }
}
_class("CEventReplyCampaignGetMatchMissionArrayExReward", CCallReplyEvent)
CEventReplyCampaignGetMatchMissionArrayExReward = CEventReplyCampaignGetMatchMissionArrayExReward

function CEventReplyCampaignGetMatchMissionArrayExReward:Constructor()
  self.campaign_reward_map = {}
end

CEventReplyCampaignGetMatchMissionArrayExReward._proto = {
  [1] = {
    "campaign_reward_map",
    "map<int,list<RoleAsset>>"
  }
}
_class("CEventUnlockCampaignReq", CCallRequestEvent)
CEventUnlockCampaignReq = CEventUnlockCampaignReq

function CEventUnlockCampaignReq:Constructor()
  self.campaign_id = 0
end

CEventUnlockCampaignReq._proto = {
  [1] = {
    "campaign_id",
    "int"
  }
}
_class("CEventUnlockCampaignRes", CCallReplyEvent)
CEventUnlockCampaignRes = CEventUnlockCampaignRes

function CEventUnlockCampaignRes:Constructor()
  self.ret = 0
  self.sample_list = {}
  self.recomond_index = 0
  self.campaing_review_time_start = 0
end

CEventUnlockCampaignRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "sample_list",
    "list<campaign_sample>"
  },
  [3] = {
    "recomond_index",
    "int"
  },
  [4] = {
    "campaing_review_time_start",
    "time"
  }
}
_class("CEventRequestCampaignReviewLoadInfoList", CCallRequestEvent)
CEventRequestCampaignReviewLoadInfoList = CEventRequestCampaignReviewLoadInfoList

function CEventRequestCampaignReviewLoadInfoList:Constructor()
end

CEventRequestCampaignReviewLoadInfoList._proto = {}
_class("CEventReplyCampaignReviewLoadInfoList", CCallReplyEvent)
CEventReplyCampaignReviewLoadInfoList = CEventReplyCampaignReviewLoadInfoList

function CEventReplyCampaignReviewLoadInfoList:Constructor()
  self.ret = 0
  self.sample_list = {}
  self.recomond_index = 0
  self.campaing_review_time_start = 0
end

CEventReplyCampaignReviewLoadInfoList._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "sample_list",
    "list<campaign_sample>"
  },
  [3] = {
    "recomond_index",
    "int"
  },
  [4] = {
    "campaing_review_time_start",
    "time"
  }
}
_class("CEventEnterCampaignReviewReq", CCallRequestEvent)
CEventEnterCampaignReviewReq = CEventEnterCampaignReviewReq

function CEventEnterCampaignReviewReq:Constructor()
end

CEventEnterCampaignReviewReq._proto = {}
_class("CEventEnterCampaignReviewRes", CCallReplyEvent)
CEventEnterCampaignReviewRes = CEventEnterCampaignReviewRes

function CEventEnterCampaignReviewRes:Constructor()
  self.ret = 0
end

CEventEnterCampaignReviewRes._proto = {
  [1] = {"ret", "int"}
}
_class("CEventCampaignLoadComponentRankReq", CCallRequestEvent)
CEventCampaignLoadComponentRankReq = CEventCampaignLoadComponentRankReq

function CEventCampaignLoadComponentRankReq:Constructor()
  self.component_cfg_id = 0
  self.rank_sub_key = 0
end

CEventCampaignLoadComponentRankReq._proto = {
  [1] = {
    "component_cfg_id",
    "int"
  },
  [2] = {
    "rank_sub_key",
    "int"
  }
}
_class("CEventCampaignLoadComponentRankRes", CCallReplyEvent)
CEventCampaignLoadComponentRankRes = CEventCampaignLoadComponentRankRes

function CEventCampaignLoadComponentRankRes:Constructor()
  self.ret = 0
  self.rank_list = RankShowSimpleInfo:New()
end

CEventCampaignLoadComponentRankRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rank_list",
    "RankShowSimpleInfo"
  }
}
_class("CEventCampaignTeamRecordReq", CCallRequestEvent)
CEventCampaignTeamRecordReq = CEventCampaignTeamRecordReq

function CEventCampaignTeamRecordReq:Constructor()
  self.num = 0
  self.mission = 0
  self.campaign_id = 0
  self.component_id = 0
end

CEventCampaignTeamRecordReq._proto = {
  [1] = {"num", "int"},
  [2] = {"mission", "int"},
  [3] = {
    "campaign_id",
    "int"
  },
  [4] = {
    "component_id",
    "int"
  }
}
_class("CEventCampaignTeamRecordRes", CCallReplyEvent)
CEventCampaignTeamRecordRes = CEventCampaignTeamRecordRes

function CEventCampaignTeamRecordRes:Constructor()
  self.ret = 0
  self.info = {}
  self.next_num = 0
end

CEventCampaignTeamRecordRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "list<campaign_mtr_role>"
  },
  [3] = {"next_num", "int"}
}
_class("CEventRequestCampaignPreviewList", CCallRequestEvent)
CEventRequestCampaignPreviewList = CEventRequestCampaignPreviewList

function CEventRequestCampaignPreviewList:Constructor()
  self.campaign_list = {}
end

CEventRequestCampaignPreviewList._proto = {
  [1] = {
    "campaign_list",
    "list<int>"
  }
}
_class("CEventReplyCampaignPreviewList", CCallReplyEvent)
CEventReplyCampaignPreviewList = CEventReplyCampaignPreviewList

function CEventReplyCampaignPreviewList:Constructor()
  self.ret = 0
  self.m_campaign_preview_info_list = {}
end

CEventReplyCampaignPreviewList._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "m_campaign_preview_info_list",
    "map<int,CampaignLoadInfo>"
  }
}
