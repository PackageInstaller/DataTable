require("message_def")
local homelandMessageDef = {
  CLSID_CEventEnterHomelandReq = 40000,
  CLSID_CEventEnterHomelandRes = 40001,
  CLSID_CEventForgeReq = 40002,
  CLSID_CEventForgeRes = 40003,
  CLSID_CEventUnlockReq = 40004,
  CLSID_CEventUnlockRes = 40005,
  CLSID_CEventOneClickUnlockReq = 40006,
  CLSID_CEventOneClickUnlockRes = 40007,
  CLSID_CEventAccelerateReq = 40008,
  CLSID_CEventAccelerateRes = 40009,
  CLSID_CEventCancelReq = 40010,
  CLSID_CEventCancelRes = 40011,
  CLSID_CEventPickUpReq = 40012,
  CLSID_CEventPickUpRes = 40013,
  CLSID_CEventSelectSkinReq = 40014,
  CLSID_CEventSelectSkinRes = 40015,
  CLSID_CEventHomelandBuildReq = 40016,
  CLSID_CEventHomelandBuildRes = 40017,
  CLSID_CEventHomelandGetFishingDataReq = 40018,
  CLSID_CEventHomelandGetFishingDataReply = 40019,
  CLSID_CEventHomelandFishBiteReq = 40020,
  CLSID_CEventHomelandFishBiteReply = 40021,
  CLSID_CEventHomelandFishingComfirmReq = 40022,
  CLSID_CEventHomelandFishingComfirmReply = 40023,
  CLSID_CEventHomelandRefreshRarePositionReq = 40024,
  CLSID_CEventHomelandRefreshRarePositionReply = 40025,
  CLSID_CEventHomelandShopReq = 40026,
  CLSID_CEventHomelandShopReply = 40027,
  CLSID_CEventHomelandSellReq = 40028,
  CLSID_CEventHomelandSellReply = 40029,
  CLSID_CEventHomelandGoodsReq = 40030,
  CLSID_CEventHomelandGoodsReply = 40031,
  CLSID_CEventHomelandShopUpdate = 40032,
  CLSID_CEventHomelandTreasureReq = 40033,
  CLSID_CEventHomelandTreasureReply = 40034,
  CLSID_CEventHomelandTreasureStateReq = 40035,
  CLSID_CEventHomelandTreasureStateReply = 40036,
  CLSID_CEventHomelandTreasureUpdate = 40037,
  CLSID_CEventHomelandFellReq = 40038,
  CLSID_CEventHomelandFellRes = 40039,
  CLSID_CEventFellInfoReq = 40040,
  CLSID_CEventFellInfoRes = 40041,
  CLSID_CEventDormitoryChangeNameReq = 40042,
  CLSID_CEventDormitoryChangeNameRes = 40043,
  CLSID_CEventDormitoryUpdatePetReq = 40044,
  CLSID_CEventDormitoryUpdatePetRes = 40045,
  CLSID_CEventClientTriggerEventReq = 40046,
  CLSID_CEventClientTriggerEventRes = 40047,
  CLSID_CEventClientFinishEventReq = 40048,
  CLSID_CEventClientFinishEventRes = 40049,
  CLSID_CEventPushFinishHomeChatId = 40050,
  CLSID_CEventPushEventChange = 40051,
  CLSID_CEventCultivationReq = 40052,
  CLSID_CEventCultivationRes = 40053,
  CLSID_CEventCultivationCancelReq = 40054,
  CLSID_CEventCultivationCancelRes = 40055,
  CLSID_CEventCultivationAccelerateReq = 40056,
  CLSID_CEventDyeingTreeReq = 40057,
  CLSID_CEventDyeingTreeRes = 40058,
  CLSID_CEventCultivationAccelerateRes = 40059,
  CLSID_CEventCultivationPickUpReq = 40060,
  CLSID_CEventCultivationPickUpRes = 40061,
  CLSID_CEventWishingPoolCollectReq = 40062,
  CLSID_CEventWishingPoolCollectReply = 40063,
  CLSID_CEventWishingPoolTakeOutReq = 40064,
  CLSID_CEventWishingPoolTakeOutReply = 40065,
  CLSID_CEventWishingPoolUpdateFishReq = 40066,
  CLSID_CEventWishingPoolUpdateFishReply = 40067,
  CLSID_CEventFishTankUpdateFishReq = 40068,
  CLSID_CEventFishTankUpdateFishReply = 40069,
  CLSID_CEventHomelandDormitoryUpdate = 40070,
  CLSID_CEventHomelandMiningReq = 40071,
  CLSID_CEventHomelandMiningRes = 40072,
  CLSID_CEventMiningInfoReq = 40073,
  CLSID_CEventMiningInfoRes = 40074,
  CLSID_CEventHomelandReadedDairyReq = 40075,
  CLSID_CEventHomelandReadedDairyRes = 40076,
  CLSID_CEventHomelandSignReq = 40077,
  CLSID_CEventHomelandSignRes = 40078,
  CLSID_CEventPushLevelInfo = 40079,
  CLSID_CEventHomelandLevelRewardReq = 40080,
  CLSID_CEventHomelandLevelRewardRes = 40081,
  CLSID_CEventGetSignInfoReq = 40082,
  CLSID_CEventGetSignInfoRes = 40083,
  CLSID_CEventHomelandVisitListReq = 40084,
  CLSID_CEventHomelandVisitListReply = 40085,
  CLSID_CEventHomelandVisitFriendReq = 40086,
  CLSID_CEventHomelandVisitFriendReply = 40087,
  CLSID_CEventHomelandTakeItemReq = 40088,
  CLSID_CEventHomelandTakeItemReply = 40089,
  CLSID_CEventHomelandAccForgeReq = 40090,
  CLSID_CEventHomelandAccForgeReply = 40091,
  CLSID_CEventHomelandAccCultivateReq = 40092,
  CLSID_CEventHomelandAccCultivateReply = 40093,
  CLSID_CEventHomelandMoveItemReq = 40094,
  CLSID_CEventHomelandMoveItemReply = 40095,
  CLSID_CEventHomelandVisitLogReq = 40096,
  CLSID_CEventHomelandVisitLogReply = 40097,
  CLSID_CEventHomelandForgeUpdate = 40098,
  CLSID_CEventHomelandCultivationUpdate = 40099,
  CLSID_CEventHomelandVisitItemUpdate = 40100,
  CLSID_CEventHomelandFinishTaskReq = 40101,
  CLSID_CEventHomelandFinishTaskRes = 40102,
  CLSID_CEventHomelandUpdateTaskReq = 40103,
  CLSID_CEventHomelandUpdateTaskRes = 40104,
  CLSID_CEventHomelandTraceReq = 40105,
  CLSID_CEventHomelandTraceRes = 40106,
  CLSID_CEventHomelandTaskViewStoryReq = 40107,
  CLSID_CEventHomelandTaskViewStoryRes = 40108,
  CLSID_CEventHomelandTaskQuestTakeReq = 40109,
  CLSID_CEventHomelandTaskQuestTakeRes = 40110,
  CLSID_CEventHomelandTaskGroupTakeReq = 40111,
  CLSID_CEventHomelandTaskGroupTakeRes = 40112,
  CLSID_CEventPushHomelandFunctionUnlocked = 40113,
  CLSID_CEventHomelandFixShabbyReq = 40114,
  CLSID_CEventHomelandFixShabbyRes = 40115,
  CLSID_CEventHomelandShopRefreshReq = 40116,
  CLSID_CEventHomelandShopRefreshReply = 40117,
  CLSID_CEventHomelandVisitUpdate = 40118,
  CLSID_CEventHomelandStoryTaskUnlockReq = 40119,
  CLSID_CEventHomelandStoryTaskUnlockReply = 40120,
  CLSID_CEventHomelandStoryTaskAutoOperateReq = 40121,
  CLSID_CEventHomelandStoryTaskAutoOperateReply = 40122,
  CLSID_CEventHomelandStoryTaskUpdate = 40123,
  CLSID_CEventHomelandStoryTaskMoudleUnlockReq = 40124,
  CLSID_CEventHomelandStoryTaskMoudleUnlockReply = 40125,
  CLSID_CEventUnlockFatherHangPointReq = 40126,
  CLSID_CEventUnlockFatherHangPointRes = 40127,
  CLSID_CEventFatherHangPointUpdate = 40128,
  CLSID_CEventEnterMakingMoviceReq = 40129,
  CLSID_CEventEnterMakingMoviceRes = 40130,
  CLSID_CEventSubmitRecordNameReq = 40131,
  CLSID_CEventSubmitRecordNameRes = 40132,
  CLSID_CEventRequestScoreReq = 40133,
  CLSID_CEventRequestScoreRes = 40134,
  CLSID_CEventSaveRecordReq = 40135,
  CLSID_CEventSaveRecordRes = 40136,
  CLSID_CEventRequestRecordArchReq = 40137,
  CLSID_CEventRequestRecordArchRes = 40138,
  CLSID_CEventHomelandRefreshRarePositionPush = 40139,
  CLSID_CEventFishingChallengeReq = 40140,
  CLSID_CEventFishingChallengeRes = 40141,
  CLSID_CEventFishingChallengeEndReq = 40142,
  CLSID_CEventFishingChallengeEndRes = 40143,
  CLSID_CEventCancelFishingChallengeReq = 40144,
  CLSID_CEventCancelFishingChallengeRes = 40145,
  CLSID_CEventReceiveAnonymousLetterRewardReq = 40146,
  CLSID_CEventReceiveAnonymousLetterRewardRes = 40147
}
table.append(MessageDef, homelandMessageDef)
_class("CEventEnterHomelandReq", CCallRequestEvent)
CEventEnterHomelandReq = CEventEnterHomelandReq

function CEventEnterHomelandReq:Constructor()
  self.player_pstid = 0
end

CEventEnterHomelandReq._proto = {
  [1] = {
    "player_pstid",
    "int64"
  }
}
_class("CEventEnterHomelandRes", CCallReplyEvent)
CEventEnterHomelandRes = CEventEnterHomelandRes

function CEventEnterHomelandRes:Constructor()
  self.nRet = 0
  self.data = ClientHomelandInfo:New()
  self.can_trigger_event_list = {}
  self.can_trigger_event_num = 0
  self.task_group_timeline = {}
  self.task_group_close_timeline = {}
end

CEventEnterHomelandRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "data",
    "ClientHomelandInfo"
  },
  [3] = {
    "can_trigger_event_list",
    "list<int>"
  },
  [4] = {
    "can_trigger_event_num",
    "int"
  },
  [5] = {
    "task_group_timeline",
    "list<homeland_sametime_group>"
  },
  [6] = {
    "task_group_close_timeline",
    "list<homeland_sametime_group>"
  }
}
_class("CEventForgeReq", CCallRequestEvent)
CEventForgeReq = CEventForgeReq

function CEventForgeReq:Constructor()
  self.architecture_id = 0
  self.queue_index = 0
end

CEventForgeReq._proto = {
  [1] = {
    "architecture_id",
    "int"
  },
  [2] = {
    "queue_index",
    "int"
  }
}
_class("CEventForgeRes", CCallReplyEvent)
CEventForgeRes = CEventForgeRes

function CEventForgeRes:Constructor()
  self.nRet = 0
  self.forge_list = {}
end

CEventForgeRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "forge_list",
    "list<ForgeItemInfo>"
  }
}
_class("CEventUnlockReq", CCallRequestEvent)
CEventUnlockReq = CEventUnlockReq

function CEventUnlockReq:Constructor()
  self.architecture_id = 0
end

CEventUnlockReq._proto = {
  [1] = {
    "architecture_id",
    "int"
  }
}
_class("CEventUnlockRes", CCallReplyEvent)
CEventUnlockRes = CEventUnlockRes

function CEventUnlockRes:Constructor()
  self.nRet = 0
  self.unlock_architecture_list = {}
end

CEventUnlockRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "unlock_architecture_list",
    "list<int>"
  }
}
_class("CEventOneClickUnlockReq", CCallRequestEvent)
CEventOneClickUnlockReq = CEventOneClickUnlockReq

function CEventOneClickUnlockReq:Constructor()
  self.architecture_ids = {}
end

CEventOneClickUnlockReq._proto = {
  [1] = {
    "architecture_ids",
    "list<int>"
  }
}
_class("CEventOneClickUnlockRes", CCallReplyEvent)
CEventOneClickUnlockRes = CEventOneClickUnlockRes

function CEventOneClickUnlockRes:Constructor()
  self.nRet = 0
  self.unlock_architecture_list = {}
end

CEventOneClickUnlockRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "unlock_architecture_list",
    "list<int>"
  }
}
_class("CEventAccelerateReq", CCallRequestEvent)
CEventAccelerateReq = CEventAccelerateReq

function CEventAccelerateReq:Constructor()
  self.queue_index = 0
  self.item = RoleAsset:New()
end

CEventAccelerateReq._proto = {
  [1] = {
    "queue_index",
    "int"
  },
  [2] = {"item", "RoleAsset"}
}
_class("CEventAccelerateRes", CCallReplyEvent)
CEventAccelerateRes = CEventAccelerateRes

function CEventAccelerateRes:Constructor()
  self.nRet = 0
  self.forge_list = {}
end

CEventAccelerateRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "forge_list",
    "list<ForgeItemInfo>"
  }
}
_class("CEventCancelReq", CCallRequestEvent)
CEventCancelReq = CEventCancelReq

function CEventCancelReq:Constructor()
  self.queue_index = 0
end

CEventCancelReq._proto = {
  [1] = {
    "queue_index",
    "int"
  }
}
_class("CEventCancelRes", CCallReplyEvent)
CEventCancelRes = CEventCancelRes

function CEventCancelRes:Constructor()
  self.nRet = 0
  self.forge_list = {}
  self.return_material = {}
end

CEventCancelRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "forge_list",
    "list<ForgeItemInfo>"
  },
  [3] = {
    "return_material",
    "list<RoleAsset>"
  }
}
_class("CEventPickUpReq", CCallRequestEvent)
CEventPickUpReq = CEventPickUpReq

function CEventPickUpReq:Constructor()
  self.queue_index = 0
end

CEventPickUpReq._proto = {
  [1] = {
    "queue_index",
    "int"
  }
}
_class("CEventPickUpRes", CCallReplyEvent)
CEventPickUpRes = CEventPickUpRes

function CEventPickUpRes:Constructor()
  self.nRet = 0
  self.forge_list = {}
  self.architecture = {}
  self.already_forge_list = {}
end

CEventPickUpRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "forge_list",
    "list<ForgeItemInfo>"
  },
  [3] = {
    "architecture",
    "list<RoleAsset>"
  },
  [4] = {
    "already_forge_list",
    "list<int>"
  }
}
_class("CEventSelectSkinReq", CCallRequestEvent)
CEventSelectSkinReq = CEventSelectSkinReq

function CEventSelectSkinReq:Constructor()
  self.pstid = 0
  self.skin_id = 0
end

CEventSelectSkinReq._proto = {
  [1] = {"pstid", "uint64"},
  [2] = {"skin_id", "int"}
}
_class("CEventSelectSkinRes", CCallReplyEvent)
CEventSelectSkinRes = CEventSelectSkinRes

function CEventSelectSkinRes:Constructor()
  self.nRet = 0
  self.architecture_info = Architecture:New()
end

CEventSelectSkinRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "architecture_info",
    "Architecture"
  }
}
_class("CEventHomelandBuildReq", CCallRequestEvent)
CEventHomelandBuildReq = CEventHomelandBuildReq

function CEventHomelandBuildReq:Constructor()
  self.add_architectures = {}
  self.delete_pstids = {}
  self.update_architectures = {}
end

CEventHomelandBuildReq._proto = {
  [1] = {
    "add_architectures",
    "list<Architecture>"
  },
  [2] = {
    "delete_pstids",
    "list<uint64>"
  },
  [3] = {
    "update_architectures",
    "list<Architecture>"
  }
}
_class("CEventHomelandBuildRes", CCallReplyEvent)
CEventHomelandBuildRes = CEventHomelandBuildRes

function CEventHomelandBuildRes:Constructor()
  self.nRet = 0
  self.add_architectures = {}
  self.delete_pstids = {}
  self.update_architectures = {}
end

CEventHomelandBuildRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "add_architectures",
    "list<Architecture>"
  },
  [3] = {
    "delete_pstids",
    "list<uint64>"
  },
  [4] = {
    "update_architectures",
    "list<Architecture>"
  }
}
_class("CEventHomelandGetFishingDataReq", CCallRequestEvent)
CEventHomelandGetFishingDataReq = CEventHomelandGetFishingDataReq

function CEventHomelandGetFishingDataReq:Constructor()
end

CEventHomelandGetFishingDataReq._proto = {}
_class("CEventHomelandGetFishingDataReply", CCallReplyEvent)
CEventHomelandGetFishingDataReply = CEventHomelandGetFishingDataReply

function CEventHomelandGetFishingDataReply:Constructor()
  self.nRet = 0
  self.fishing_postions = {}
  self.append_wishingcoin_position = {}
  self.clue_submit_status = {}
end

CEventHomelandGetFishingDataReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "fishing_postions",
    "list<FishingPositionData>"
  },
  [3] = {
    "append_wishingcoin_position",
    "list<int>"
  },
  [4] = {
    "clue_submit_status",
    "map<int,ClueRareStatus>"
  }
}
_class("CEventHomelandFishBiteReq", CCallRequestEvent)
CEventHomelandFishBiteReq = CEventHomelandFishBiteReq

function CEventHomelandFishBiteReq:Constructor()
  self.fishing_position_id = 0
  self.fishing_entry_type = 0
  self.follow_fishing_id = 0
end

CEventHomelandFishBiteReq._proto = {
  [1] = {
    "fishing_position_id",
    "int"
  },
  [2] = {
    "fishing_entry_type",
    "int"
  },
  [3] = {
    "follow_fishing_id",
    "int"
  }
}
_class("CEventHomelandFishBiteReply", CCallReplyEvent)
CEventHomelandFishBiteReply = CEventHomelandFishBiteReply

function CEventHomelandFishBiteReply:Constructor()
  self.nRet = 0
  self.result_fish_id = 0
end

CEventHomelandFishBiteReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "result_fish_id",
    "int"
  }
}
_class("CEventHomelandFishingComfirmReq", CCallRequestEvent)
CEventHomelandFishingComfirmReq = CEventHomelandFishingComfirmReq

function CEventHomelandFishingComfirmReq:Constructor()
  self.fishing_entry_type = 0
end

CEventHomelandFishingComfirmReq._proto = {
  [1] = {
    "fishing_entry_type",
    "int"
  }
}
_class("CEventHomelandFishingComfirmReply", CCallReplyEvent)
CEventHomelandFishingComfirmReply = CEventHomelandFishingComfirmReply

function CEventHomelandFishingComfirmReply:Constructor()
  self.nRet = 0
end

CEventHomelandFishingComfirmReply._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventHomelandRefreshRarePositionReq", CCallRequestEvent)
CEventHomelandRefreshRarePositionReq = CEventHomelandRefreshRarePositionReq

function CEventHomelandRefreshRarePositionReq:Constructor()
  self.rare_clue_id = 0
end

CEventHomelandRefreshRarePositionReq._proto = {
  [1] = {
    "rare_clue_id",
    "int"
  }
}
_class("CEventHomelandRefreshRarePositionReply", CCallReplyEvent)
CEventHomelandRefreshRarePositionReply = CEventHomelandRefreshRarePositionReply

function CEventHomelandRefreshRarePositionReply:Constructor()
  self.nRet = 0
  self.clue_submit_status = {}
  self.assets = {}
end

CEventHomelandRefreshRarePositionReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "clue_submit_status",
    "map<int,ClueRareStatus>"
  },
  [3] = {
    "assets",
    "list<RoleAsset>"
  }
}
_class("CEventHomelandShopReq", CCallRequestEvent)
CEventHomelandShopReq = CEventHomelandShopReq

function CEventHomelandShopReq:Constructor()
  self.id = 0
  self.num = 0
end

CEventHomelandShopReq._proto = {
  [1] = {"id", "int"},
  [2] = {"num", "int"}
}
_class("CEventHomelandShopReply", CCallReplyEvent)
CEventHomelandShopReply = CEventHomelandShopReply

function CEventHomelandShopReply:Constructor()
  self.nRet = 0
end

CEventHomelandShopReply._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventHomelandSellReq", CCallRequestEvent)
CEventHomelandSellReq = CEventHomelandSellReq

function CEventHomelandSellReq:Constructor()
  self.id_num = {}
end

CEventHomelandSellReq._proto = {
  [1] = {
    "id_num",
    "map<int,int>"
  }
}
_class("CEventHomelandSellReply", CCallReplyEvent)
CEventHomelandSellReply = CEventHomelandSellReply

function CEventHomelandSellReply:Constructor()
  self.nRet = 0
end

CEventHomelandSellReply._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventHomelandGoodsReq", CCallRequestEvent)
CEventHomelandGoodsReq = CEventHomelandGoodsReq

function CEventHomelandGoodsReq:Constructor()
  self.id = 0
  self.is_sell = false
end

CEventHomelandGoodsReq._proto = {
  [1] = {"id", "int"},
  [2] = {"is_sell", "bool"}
}
_class("CEventHomelandGoodsReply", CCallReplyEvent)
CEventHomelandGoodsReply = CEventHomelandGoodsReply

function CEventHomelandGoodsReply:Constructor()
  self.nRet = 0
  self.goods_info = {}
  self.goods_refresh_time = 0
end

CEventHomelandGoodsReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "goods_info",
    "map<int,homelandGoodsInfo>"
  },
  [3] = {
    "goods_refresh_time",
    "time"
  }
}
_class("CEventHomelandShopUpdate", CSvrPushEvent)
CEventHomelandShopUpdate = CEventHomelandShopUpdate

function CEventHomelandShopUpdate:Constructor()
  self.shop_info = homelandShopInfo:New()
end

CEventHomelandShopUpdate._proto = {
  [1] = {
    "shop_info",
    "homelandShopInfo"
  }
}
_class("CEventHomelandTreasureReq", CCallRequestEvent)
CEventHomelandTreasureReq = CEventHomelandTreasureReq

function CEventHomelandTreasureReq:Constructor()
  self.birth_id = 0
end

CEventHomelandTreasureReq._proto = {
  [1] = {"birth_id", "int"}
}
_class("CEventHomelandTreasureReply", CCallReplyEvent)
CEventHomelandTreasureReply = CEventHomelandTreasureReply

function CEventHomelandTreasureReply:Constructor()
  self.nRet = 0
  self.trea_info = homelandTreasure:New()
end

CEventHomelandTreasureReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "trea_info",
    "homelandTreasure"
  }
}
_class("CEventHomelandTreasureStateReq", CCallRequestEvent)
CEventHomelandTreasureStateReq = CEventHomelandTreasureStateReq

function CEventHomelandTreasureStateReq:Constructor()
  self.birth_id = 0
  self.state = 0
end

CEventHomelandTreasureStateReq._proto = {
  [1] = {"birth_id", "int"},
  [2] = {"state", "int"}
}
_class("CEventHomelandTreasureStateReply", CCallReplyEvent)
CEventHomelandTreasureStateReply = CEventHomelandTreasureStateReply

function CEventHomelandTreasureStateReply:Constructor()
  self.nRet = 0
  self.assets = {}
end

CEventHomelandTreasureStateReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "assets",
    "list<RoleAsset>"
  }
}
_class("CEventHomelandTreasureUpdate", CSvrPushEvent)
CEventHomelandTreasureUpdate = CEventHomelandTreasureUpdate

function CEventHomelandTreasureUpdate:Constructor()
  self.trea_info = homelandTreasure:New()
end

CEventHomelandTreasureUpdate._proto = {
  [1] = {
    "trea_info",
    "homelandTreasure"
  }
}
_class("CEventHomelandFellReq", CCallRequestEvent)
CEventHomelandFellReq = CEventHomelandFellReq

function CEventHomelandFellReq:Constructor()
  self.tree_id = 0
  self.feel_times = 0
end

CEventHomelandFellReq._proto = {
  [1] = {"tree_id", "int"},
  [2] = {"feel_times", "int"}
}
_class("CEventHomelandFellRes", CCallReplyEvent)
CEventHomelandFellRes = CEventHomelandFellRes

function CEventHomelandFellRes:Constructor()
  self.nRet = 0
  self.assets = {}
  self.fell_info = FellInfo:New()
end

CEventHomelandFellRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "assets",
    "list<RoleAsset>"
  },
  [3] = {"fell_info", "FellInfo"}
}
_class("CEventFellInfoReq", CCallRequestEvent)
CEventFellInfoReq = CEventFellInfoReq

function CEventFellInfoReq:Constructor()
end

CEventFellInfoReq._proto = {}
_class("CEventFellInfoRes", CCallReplyEvent)
CEventFellInfoRes = CEventFellInfoRes

function CEventFellInfoRes:Constructor()
  self.nRet = 0
  self.fell_info = FellInfo:New()
end

CEventFellInfoRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {"fell_info", "FellInfo"}
}
_class("CEventDormitoryChangeNameReq", CCallRequestEvent)
CEventDormitoryChangeNameReq = CEventDormitoryChangeNameReq

function CEventDormitoryChangeNameReq:Constructor()
  self.index = 0
  self.name = ""
end

CEventDormitoryChangeNameReq._proto = {
  [1] = {"index", "int"},
  [2] = {"name", "string"}
}
_class("CEventDormitoryChangeNameRes", CCallReplyEvent)
CEventDormitoryChangeNameRes = CEventDormitoryChangeNameRes

function CEventDormitoryChangeNameRes:Constructor()
  self.nRet = 0
end

CEventDormitoryChangeNameRes._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventDormitoryUpdatePetReq", CCallRequestEvent)
CEventDormitoryUpdatePetReq = CEventDormitoryUpdatePetReq

function CEventDormitoryUpdatePetReq:Constructor()
  self.updateData = {}
end

CEventDormitoryUpdatePetReq._proto = {
  [1] = {
    "updateData",
    "map<int,map<int,int64>>"
  }
}
_class("CEventDormitoryUpdatePetRes", CCallReplyEvent)
CEventDormitoryUpdatePetRes = CEventDormitoryUpdatePetRes

function CEventDormitoryUpdatePetRes:Constructor()
  self.nRet = 0
end

CEventDormitoryUpdatePetRes._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventClientTriggerEventReq", CCallRequestEvent)
CEventClientTriggerEventReq = CEventClientTriggerEventReq

function CEventClientTriggerEventReq:Constructor()
  self.trigger_event_list = {}
end

CEventClientTriggerEventReq._proto = {
  [1] = {
    "trigger_event_list",
    "list<int>"
  }
}
_class("CEventClientTriggerEventRes", CCallReplyEvent)
CEventClientTriggerEventRes = CEventClientTriggerEventRes

function CEventClientTriggerEventRes:Constructor()
  self.nRet = 0
  self.event_info = homelandEventInfo:New()
end

CEventClientTriggerEventRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "event_info",
    "homelandEventInfo"
  }
}
_class("CEventClientFinishEventReq", CCallRequestEvent)
CEventClientFinishEventReq = CEventClientFinishEventReq

function CEventClientFinishEventReq:Constructor()
  self.finish_event_id = 0
end

CEventClientFinishEventReq._proto = {
  [1] = {
    "finish_event_id",
    "int"
  }
}
_class("CEventClientFinishEventRes", CCallReplyEvent)
CEventClientFinishEventRes = CEventClientFinishEventRes

function CEventClientFinishEventRes:Constructor()
  self.nRet = 0
  self.event_info = homelandEventInfo:New()
  self.wishing_coin_position = 0
end

CEventClientFinishEventRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "event_info",
    "homelandEventInfo"
  },
  [3] = {
    "wishing_coin_position",
    "int"
  }
}
_class("CEventPushFinishHomeChatId", CCliPushEvent)
CEventPushFinishHomeChatId = CEventPushFinishHomeChatId

function CEventPushFinishHomeChatId:Constructor()
  self.pet_template_id = 0
  self.finish_home_pet_chat_id = 0
end

CEventPushFinishHomeChatId._proto = {
  [1] = {
    "pet_template_id",
    "int"
  },
  [2] = {
    "finish_home_pet_chat_id",
    "int"
  }
}
_class("CEventPushEventChange", CSvrPushEvent)
CEventPushEventChange = CEventPushEventChange

function CEventPushEventChange:Constructor()
  self.erase_event_id = {}
  self.event_info = homelandEventInfo:New()
  self.trigger_immediately_event = 0
end

CEventPushEventChange._proto = {
  [1] = {
    "erase_event_id",
    "list<int>"
  },
  [2] = {
    "event_info",
    "homelandEventInfo"
  },
  [3] = {
    "trigger_immediately_event",
    "int"
  }
}
_class("CEventCultivationReq", CCallRequestEvent)
CEventCultivationReq = CEventCultivationReq

function CEventCultivationReq:Constructor()
  self.cultivation_info = ClietCultivationInfo:New()
end

CEventCultivationReq._proto = {
  [1] = {
    "cultivation_info",
    "ClietCultivationInfo"
  }
}
_class("CEventCultivationRes", CCallReplyEvent)
CEventCultivationRes = CEventCultivationRes

function CEventCultivationRes:Constructor()
  self.nRet = 0
  self.infos = CultivationInfo:New()
end

CEventCultivationRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "infos",
    "CultivationInfo"
  }
}
_class("CEventCultivationCancelReq", CCallRequestEvent)
CEventCultivationCancelReq = CEventCultivationCancelReq

function CEventCultivationCancelReq:Constructor()
  self.land_pstid = 0
end

CEventCultivationCancelReq._proto = {
  [1] = {"land_pstid", "int64"}
}
_class("CEventCultivationCancelRes", CCallReplyEvent)
CEventCultivationCancelRes = CEventCultivationCancelRes

function CEventCultivationCancelRes:Constructor()
  self.nRet = 0
  self.infos = CultivationInfo:New()
end

CEventCultivationCancelRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "infos",
    "CultivationInfo"
  }
}
_class("CEventCultivationAccelerateReq", CCallRequestEvent)
CEventCultivationAccelerateReq = CEventCultivationAccelerateReq

function CEventCultivationAccelerateReq:Constructor()
  self.land_pstid = 0
  self.item_info = RoleAsset:New()
end

CEventCultivationAccelerateReq._proto = {
  [1] = {"land_pstid", "int64"},
  [2] = {"item_info", "RoleAsset"}
}
_class("CEventDyeingTreeReq", CCallRequestEvent)
CEventDyeingTreeReq = CEventDyeingTreeReq

function CEventDyeingTreeReq:Constructor()
  self.architecture_pstid = 0
  self.select_tree_id = 0
  self.dye_item_id = 0
end

CEventDyeingTreeReq._proto = {
  [1] = {
    "architecture_pstid",
    "int64"
  },
  [2] = {
    "select_tree_id",
    "int"
  },
  [3] = {
    "dye_item_id",
    "int"
  }
}
_class("CEventDyeingTreeRes", CCallReplyEvent)
CEventDyeingTreeRes = CEventDyeingTreeRes

function CEventDyeingTreeRes:Constructor()
  self.nRet = 0
  self.arch_info = Architecture:New()
end

CEventDyeingTreeRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "arch_info",
    "Architecture"
  }
}
_class("CEventCultivationAccelerateRes", CCallReplyEvent)
CEventCultivationAccelerateRes = CEventCultivationAccelerateRes

function CEventCultivationAccelerateRes:Constructor()
  self.nRet = 0
  self.infos = CultivationInfo:New()
end

CEventCultivationAccelerateRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "infos",
    "CultivationInfo"
  }
}
_class("CEventCultivationPickUpReq", CCallRequestEvent)
CEventCultivationPickUpReq = CEventCultivationPickUpReq

function CEventCultivationPickUpReq:Constructor()
  self.land_pstid = 0
end

CEventCultivationPickUpReq._proto = {
  [1] = {"land_pstid", "int64"}
}
_class("CEventCultivationPickUpRes", CCallReplyEvent)
CEventCultivationPickUpRes = CEventCultivationPickUpRes

function CEventCultivationPickUpRes:Constructor()
  self.nRet = 0
  self.infos = CultivationInfo:New()
  self.items = {}
  self.homeland_exp = 0
  self.is_first = false
end

CEventCultivationPickUpRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "infos",
    "CultivationInfo"
  },
  [3] = {
    "items",
    "list<RoleAsset>"
  },
  [4] = {
    "homeland_exp",
    "int"
  },
  [5] = {"is_first", "bool"}
}
_class("CEventWishingPoolCollectReq", CCallRequestEvent)
CEventWishingPoolCollectReq = CEventWishingPoolCollectReq

function CEventWishingPoolCollectReq:Constructor()
  self.item_id = 0
end

CEventWishingPoolCollectReq._proto = {
  [1] = {"item_id", "int"}
}
_class("CEventWishingPoolCollectReply", CCallReplyEvent)
CEventWishingPoolCollectReply = CEventWishingPoolCollectReply

function CEventWishingPoolCollectReply:Constructor()
  self.nRet = 0
  self.item_count = {}
  self.reward = {}
  self.wishing_coin_list = {}
end

CEventWishingPoolCollectReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "item_count",
    "map<int,int>"
  },
  [3] = {
    "reward",
    "list<RoleAsset>"
  },
  [4] = {
    "wishing_coin_list",
    "list<int>"
  }
}
_class("CEventWishingPoolTakeOutReq", CCallRequestEvent)
CEventWishingPoolTakeOutReq = CEventWishingPoolTakeOutReq

function CEventWishingPoolTakeOutReq:Constructor()
  self.item_id = 0
end

CEventWishingPoolTakeOutReq._proto = {
  [1] = {"item_id", "int"}
}
_class("CEventWishingPoolTakeOutReply", CCallReplyEvent)
CEventWishingPoolTakeOutReply = CEventWishingPoolTakeOutReply

function CEventWishingPoolTakeOutReply:Constructor()
  self.nRet = 0
  self.item_count = {}
end

CEventWishingPoolTakeOutReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "item_count",
    "map<int,int>"
  }
}
_class("CEventWishingPoolUpdateFishReq", CCallRequestEvent)
CEventWishingPoolUpdateFishReq = CEventWishingPoolUpdateFishReq

function CEventWishingPoolUpdateFishReq:Constructor()
  self.all_fish_num = {}
end

CEventWishingPoolUpdateFishReq._proto = {
  [1] = {
    "all_fish_num",
    "map<int,int>"
  }
}
_class("CEventWishingPoolUpdateFishReply", CCallReplyEvent)
CEventWishingPoolUpdateFishReply = CEventWishingPoolUpdateFishReply

function CEventWishingPoolUpdateFishReply:Constructor()
  self.nRet = 0
  self.item_count = {}
end

CEventWishingPoolUpdateFishReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "item_count",
    "map<int,int>"
  }
}
_class("CEventFishTankUpdateFishReq", CCallRequestEvent)
CEventFishTankUpdateFishReq = CEventFishTankUpdateFishReq

function CEventFishTankUpdateFishReq:Constructor()
  self.tank_pst_id = 0
  self.fish2num = {}
end

CEventFishTankUpdateFishReq._proto = {
  [1] = {
    "tank_pst_id",
    "int64"
  },
  [2] = {
    "fish2num",
    "map<int,int>"
  }
}
_class("CEventFishTankUpdateFishReply", CCallReplyEvent)
CEventFishTankUpdateFishReply = CEventFishTankUpdateFishReply

function CEventFishTankUpdateFishReply:Constructor()
  self.nRet = 0
  self.fish_tank_item_count = {}
end

CEventFishTankUpdateFishReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "fish_tank_item_count",
    "map<int,int>"
  }
}
_class("CEventHomelandDormitoryUpdate", CSvrPushEvent)
CEventHomelandDormitoryUpdate = CEventHomelandDormitoryUpdate

function CEventHomelandDormitoryUpdate:Constructor()
  self.list = {}
end

CEventHomelandDormitoryUpdate._proto = {
  [1] = {
    "list",
    "list<dormitory_room>"
  }
}
_class("CEventHomelandMiningReq", CCallRequestEvent)
CEventHomelandMiningReq = CEventHomelandMiningReq

function CEventHomelandMiningReq:Constructor()
  self.mine_id = 0
  self.mining_times = 0
end

CEventHomelandMiningReq._proto = {
  [1] = {"mine_id", "int"},
  [2] = {
    "mining_times",
    "int"
  }
}
_class("CEventHomelandMiningRes", CCallReplyEvent)
CEventHomelandMiningRes = CEventHomelandMiningRes

function CEventHomelandMiningRes:Constructor()
  self.nRet = 0
  self.assets = {}
  self.mining_info = MiningInfo:New()
end

CEventHomelandMiningRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "assets",
    "list<RoleAsset>"
  },
  [3] = {
    "mining_info",
    "MiningInfo"
  }
}
_class("CEventMiningInfoReq", CCallRequestEvent)
CEventMiningInfoReq = CEventMiningInfoReq

function CEventMiningInfoReq:Constructor()
end

CEventMiningInfoReq._proto = {}
_class("CEventMiningInfoRes", CCallReplyEvent)
CEventMiningInfoRes = CEventMiningInfoRes

function CEventMiningInfoRes:Constructor()
  self.nRet = 0
  self.mining_info = MiningInfo:New()
end

CEventMiningInfoRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "mining_info",
    "MiningInfo"
  }
}
_class("CEventHomelandReadedDairyReq", CCallRequestEvent)
CEventHomelandReadedDairyReq = CEventHomelandReadedDairyReq

function CEventHomelandReadedDairyReq:Constructor()
  self.nReadDairyId = 0
end

CEventHomelandReadedDairyReq._proto = {
  [1] = {
    "nReadDairyId",
    "int"
  }
}
_class("CEventHomelandReadedDairyRes", CCallReplyEvent)
CEventHomelandReadedDairyRes = CEventHomelandReadedDairyRes

function CEventHomelandReadedDairyRes:Constructor()
  self.nRet = 0
end

CEventHomelandReadedDairyRes._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventHomelandSignReq", CCallRequestEvent)
CEventHomelandSignReq = CEventHomelandSignReq

function CEventHomelandSignReq:Constructor()
end

CEventHomelandSignReq._proto = {}
_class("CEventHomelandSignRes", CCallReplyEvent)
CEventHomelandSignRes = CEventHomelandSignRes

function CEventHomelandSignRes:Constructor()
  self.nRet = 0
  self.info = HomelandSignInfo:New()
end

CEventHomelandSignRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "info",
    "HomelandSignInfo"
  }
}
_class("CEventPushLevelInfo", CSvrPushEvent)
CEventPushLevelInfo = CEventPushLevelInfo

function CEventPushLevelInfo:Constructor()
  self.level = 0
  self.exp = 0
end

CEventPushLevelInfo._proto = {
  [1] = {"level", "int"},
  [2] = {"exp", "int64"}
}
_class("CEventHomelandLevelRewardReq", CCallRequestEvent)
CEventHomelandLevelRewardReq = CEventHomelandLevelRewardReq

function CEventHomelandLevelRewardReq:Constructor()
  self.level = 0
end

CEventHomelandLevelRewardReq._proto = {
  [1] = {"level", "int"}
}
_class("CEventHomelandLevelRewardRes", CCallReplyEvent)
CEventHomelandLevelRewardRes = CEventHomelandLevelRewardRes

function CEventHomelandLevelRewardRes:Constructor()
  self.nRet = 0
  self.info = HomelandSignInfo:New()
  self.assets = {}
end

CEventHomelandLevelRewardRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "info",
    "HomelandSignInfo"
  },
  [3] = {
    "assets",
    "list<RoleAsset>"
  }
}
_class("CEventGetSignInfoReq", CCallRequestEvent)
CEventGetSignInfoReq = CEventGetSignInfoReq

function CEventGetSignInfoReq:Constructor()
end

CEventGetSignInfoReq._proto = {}
_class("CEventGetSignInfoRes", CCallReplyEvent)
CEventGetSignInfoRes = CEventGetSignInfoRes

function CEventGetSignInfoRes:Constructor()
  self.nRet = 0
  self.info = HomelandSignInfo:New()
end

CEventGetSignInfoRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "info",
    "HomelandSignInfo"
  }
}
_class("CEventHomelandVisitListReq", CCallRequestEvent)
CEventHomelandVisitListReq = CEventHomelandVisitListReq

function CEventHomelandVisitListReq:Constructor()
end

CEventHomelandVisitListReq._proto = {}
_class("CEventHomelandVisitListReply", CCallReplyEvent)
CEventHomelandVisitListReply = CEventHomelandVisitListReply

function CEventHomelandVisitListReply:Constructor()
  self.nRet = 0
  self.visit_list = {}
end

CEventHomelandVisitListReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "visit_list",
    "list<visit_simple_info>"
  }
}
_class("CEventHomelandVisitFriendReq", CCallRequestEvent)
CEventHomelandVisitFriendReq = CEventHomelandVisitFriendReq

function CEventHomelandVisitFriendReq:Constructor()
  self.pstid = 0
end

CEventHomelandVisitFriendReq._proto = {
  [1] = {"pstid", "int64"}
}
_class("CEventHomelandVisitFriendReply", CCallReplyEvent)
CEventHomelandVisitFriendReply = CEventHomelandVisitFriendReply

function CEventHomelandVisitFriendReply:Constructor()
  self.nRet = 0
  self.infos = FriendHomelandInfo:New()
end

CEventHomelandVisitFriendReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "infos",
    "FriendHomelandInfo"
  }
}
_class("CEventHomelandTakeItemReq", CCallRequestEvent)
CEventHomelandTakeItemReq = CEventHomelandTakeItemReq

function CEventHomelandTakeItemReq:Constructor()
  self.pstid = 0
  self.index = 0
  self.item_pstid = 0
end

CEventHomelandTakeItemReq._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"index", "int"},
  [3] = {"item_pstid", "int64"}
}
_class("CEventHomelandTakeItemReply", CCallReplyEvent)
CEventHomelandTakeItemReply = CEventHomelandTakeItemReply

function CEventHomelandTakeItemReply:Constructor()
  self.nRet = 0
  self.newInfo = {}
end

CEventHomelandTakeItemReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "newInfo",
    "map<int,SpecItemAsset>"
  }
}
_class("CEventHomelandAccForgeReq", CCallRequestEvent)
CEventHomelandAccForgeReq = CEventHomelandAccForgeReq

function CEventHomelandAccForgeReq:Constructor()
  self.pstid = 0
end

CEventHomelandAccForgeReq._proto = {
  [1] = {"pstid", "int64"}
}
_class("CEventHomelandAccForgeReply", CCallReplyEvent)
CEventHomelandAccForgeReply = CEventHomelandAccForgeReply

function CEventHomelandAccForgeReply:Constructor()
  self.nRet = 0
  self.newInfo = ForgeQueueInfo:New()
  self.forge_time = {}
  self.help_list = {}
end

CEventHomelandAccForgeReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "newInfo",
    "ForgeQueueInfo"
  },
  [3] = {
    "forge_time",
    "map<int,VisitHelpTimeInfo>"
  },
  [4] = {"help_list", "list<int>"}
}
_class("CEventHomelandAccCultivateReq", CCallRequestEvent)
CEventHomelandAccCultivateReq = CEventHomelandAccCultivateReq

function CEventHomelandAccCultivateReq:Constructor()
  self.pstid = 0
  self.land_pstid = 0
end

CEventHomelandAccCultivateReq._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"land_pstid", "int64"}
}
_class("CEventHomelandAccCultivateReply", CCallReplyEvent)
CEventHomelandAccCultivateReply = CEventHomelandAccCultivateReply

function CEventHomelandAccCultivateReply:Constructor()
  self.nRet = 0
  self.newInfo = CultivationInfo:New()
  self.cul_time = VisitHelpTimeInfo:New()
end

CEventHomelandAccCultivateReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "newInfo",
    "CultivationInfo"
  },
  [3] = {
    "cul_time",
    "VisitHelpTimeInfo"
  }
}
_class("CEventHomelandMoveItemReq", CCallRequestEvent)
CEventHomelandMoveItemReq = CEventHomelandMoveItemReq

function CEventHomelandMoveItemReq:Constructor()
  self.item = RoleAsset:New()
  self.index = 0
end

CEventHomelandMoveItemReq._proto = {
  [1] = {"item", "RoleAsset"},
  [2] = {"index", "int"}
}
_class("CEventHomelandMoveItemReply", CCallReplyEvent)
CEventHomelandMoveItemReply = CEventHomelandMoveItemReply

function CEventHomelandMoveItemReply:Constructor()
  self.nRet = 0
  self.item = SpecItemAsset:New()
end

CEventHomelandMoveItemReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "item",
    "SpecItemAsset"
  }
}
_class("CEventHomelandVisitLogReq", CCallRequestEvent)
CEventHomelandVisitLogReq = CEventHomelandVisitLogReq

function CEventHomelandVisitLogReq:Constructor()
end

CEventHomelandVisitLogReq._proto = {}
_class("CEventHomelandVisitLogReply", CCallReplyEvent)
CEventHomelandVisitLogReply = CEventHomelandVisitLogReply

function CEventHomelandVisitLogReply:Constructor()
  self.nRet = 0
  self.log_list = homelandVisitLog:New()
end

CEventHomelandVisitLogReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "log_list",
    "homelandVisitLog"
  }
}
_class("CEventHomelandForgeUpdate", CSvrPushEvent)
CEventHomelandForgeUpdate = CEventHomelandForgeUpdate

function CEventHomelandForgeUpdate:Constructor()
  self.forge_list = {}
  self.forge_time = {}
end

CEventHomelandForgeUpdate._proto = {
  [1] = {
    "forge_list",
    "list<ForgeItemInfo>"
  },
  [2] = {
    "forge_time",
    "map<int,VisitHelpTimeInfo>"
  }
}
_class("CEventHomelandCultivationUpdate", CSvrPushEvent)
CEventHomelandCultivationUpdate = CEventHomelandCultivationUpdate

function CEventHomelandCultivationUpdate:Constructor()
  self.infos = CultivationInfo:New()
  self.cul_time = {}
end

CEventHomelandCultivationUpdate._proto = {
  [1] = {
    "infos",
    "CultivationInfo"
  },
  [2] = {
    "cul_time",
    "map<int64,VisitHelpTimeInfo>"
  }
}
_class("CEventHomelandVisitItemUpdate", CSvrPushEvent)
CEventHomelandVisitItemUpdate = CEventHomelandVisitItemUpdate

function CEventHomelandVisitItemUpdate:Constructor()
  self.index = 0
end

CEventHomelandVisitItemUpdate._proto = {
  [1] = {"index", "int"}
}
_class("CEventHomelandFinishTaskReq", CCallRequestEvent)
CEventHomelandFinishTaskReq = CEventHomelandFinishTaskReq

function CEventHomelandFinishTaskReq:Constructor()
  self.nQuestCfgId = 0
end

CEventHomelandFinishTaskReq._proto = {
  [1] = {
    "nQuestCfgId",
    "int"
  }
}
_class("CEventHomelandFinishTaskRes", CCallReplyEvent)
CEventHomelandFinishTaskRes = CEventHomelandFinishTaskRes

function CEventHomelandFinishTaskRes:Constructor()
  self.nRet = 0
  self.rewards = {}
end

CEventHomelandFinishTaskRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("CEventHomelandUpdateTaskReq", CCallRequestEvent)
CEventHomelandUpdateTaskReq = CEventHomelandUpdateTaskReq

function CEventHomelandUpdateTaskReq:Constructor()
  self.nGroupCfgIdVec = {}
end

CEventHomelandUpdateTaskReq._proto = {
  [1] = {
    "nGroupCfgIdVec",
    "list<int>"
  }
}
_class("CEventHomelandUpdateTaskRes", CCallReplyEvent)
CEventHomelandUpdateTaskRes = CEventHomelandUpdateTaskRes

function CEventHomelandUpdateTaskRes:Constructor()
  self.nRet = 0
end

CEventHomelandUpdateTaskRes._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventHomelandTraceReq", CCallRequestEvent)
CEventHomelandTraceReq = CEventHomelandTraceReq

function CEventHomelandTraceReq:Constructor()
  self.trace_type = 0
  self.trace_id = 0
end

CEventHomelandTraceReq._proto = {
  [1] = {"trace_type", "int"},
  [2] = {"trace_id", "int"}
}
_class("CEventHomelandTraceRes", CCallReplyEvent)
CEventHomelandTraceRes = CEventHomelandTraceRes

function CEventHomelandTraceRes:Constructor()
  self.nRet = 0
  self.trace_info = {}
end

CEventHomelandTraceRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "trace_info",
    "map<int,TypeTraceInfo>"
  }
}
_class("CEventHomelandTaskViewStoryReq", CCallRequestEvent)
CEventHomelandTaskViewStoryReq = CEventHomelandTaskViewStoryReq

function CEventHomelandTaskViewStoryReq:Constructor()
  self.nQuestCfgId = 0
  self.nHomeLandGroupTaskStoryMask = 0
end

CEventHomelandTaskViewStoryReq._proto = {
  [1] = {
    "nQuestCfgId",
    "int"
  },
  [2] = {
    "nHomeLandGroupTaskStoryMask",
    "int"
  }
}
_class("CEventHomelandTaskViewStoryRes", CCallReplyEvent)
CEventHomelandTaskViewStoryRes = CEventHomelandTaskViewStoryRes

function CEventHomelandTaskViewStoryRes:Constructor()
  self.nRet = 0
end

CEventHomelandTaskViewStoryRes._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventHomelandTaskQuestTakeReq", CCallRequestEvent)
CEventHomelandTaskQuestTakeReq = CEventHomelandTaskQuestTakeReq

function CEventHomelandTaskQuestTakeReq:Constructor()
  self.nQuestCfgId = 0
end

CEventHomelandTaskQuestTakeReq._proto = {
  [1] = {
    "nQuestCfgId",
    "int"
  }
}
_class("CEventHomelandTaskQuestTakeRes", CCallReplyEvent)
CEventHomelandTaskQuestTakeRes = CEventHomelandTaskQuestTakeRes

function CEventHomelandTaskQuestTakeRes:Constructor()
  self.nRet = 0
  self.rewards = {}
  self.nQuestRet = 0
end

CEventHomelandTaskQuestTakeRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  },
  [3] = {"nQuestRet", "int"}
}
_class("CEventHomelandTaskGroupTakeReq", CCallRequestEvent)
CEventHomelandTaskGroupTakeReq = CEventHomelandTaskGroupTakeReq

function CEventHomelandTaskGroupTakeReq:Constructor()
  self.nTaskGroupId = 0
end

CEventHomelandTaskGroupTakeReq._proto = {
  [1] = {
    "nTaskGroupId",
    "int"
  }
}
_class("CEventHomelandTaskGroupTakeRes", CCallReplyEvent)
CEventHomelandTaskGroupTakeRes = CEventHomelandTaskGroupTakeRes

function CEventHomelandTaskGroupTakeRes:Constructor()
  self.nRet = 0
  self.rewards = {}
end

CEventHomelandTaskGroupTakeRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
local EHomelandFunctionUnlock = {
  HOMELAND_FUNCTION_UNLOCK_MASK_BIT = 64,
  HOMELAND_FUNCTION_UNLOCK_MASK_NUM = 2,
  HOMELAND_FUNCTION_UNLOCK_MASK_MAX_BIT_NUM = 128
}
_enum("EHomelandFunctionUnlock", EHomelandFunctionUnlock)
_class("CEventPushHomelandFunctionUnlocked", CSvrPushEvent)
CEventPushHomelandFunctionUnlocked = CEventPushHomelandFunctionUnlocked

function CEventPushHomelandFunctionUnlocked:Constructor()
  self.unlock_functions = {}
  self.function_unlock_type = 0
end

CEventPushHomelandFunctionUnlocked._proto = {
  [1] = {
    "unlock_functions",
    "list<int64>"
  },
  [2] = {
    "function_unlock_type",
    "int"
  }
}
_class("CEventHomelandFixShabbyReq", CCallRequestEvent)
CEventHomelandFixShabbyReq = CEventHomelandFixShabbyReq

function CEventHomelandFixShabbyReq:Constructor()
  self.arch_pstid = 0
end

CEventHomelandFixShabbyReq._proto = {
  [1] = {"arch_pstid", "uint64"}
}
_class("CEventHomelandFixShabbyRes", CCallReplyEvent)
CEventHomelandFixShabbyRes = CEventHomelandFixShabbyRes

function CEventHomelandFixShabbyRes:Constructor()
  self.nRet = 0
  self.architecture_info = Architecture:New()
end

CEventHomelandFixShabbyRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "architecture_info",
    "Architecture"
  }
}
_class("CEventHomelandShopRefreshReq", CCallRequestEvent)
CEventHomelandShopRefreshReq = CEventHomelandShopRefreshReq

function CEventHomelandShopRefreshReq:Constructor()
end

CEventHomelandShopRefreshReq._proto = {}
_class("CEventHomelandShopRefreshReply", CCallReplyEvent)
CEventHomelandShopRefreshReply = CEventHomelandShopRefreshReply

function CEventHomelandShopRefreshReply:Constructor()
  self.nRet = 0
  self.shop_info = homelandShopInfo:New()
end

CEventHomelandShopRefreshReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "shop_info",
    "homelandShopInfo"
  }
}
_class("CEventHomelandVisitUpdate", CSvrPushEvent)
CEventHomelandVisitUpdate = CEventHomelandVisitUpdate

function CEventHomelandVisitUpdate:Constructor()
  self.info = homelandVisit:New()
end

CEventHomelandVisitUpdate._proto = {
  [1] = {
    "info",
    "homelandVisit"
  }
}
_class("CEventHomelandStoryTaskUnlockReq", CCallRequestEvent)
CEventHomelandStoryTaskUnlockReq = CEventHomelandStoryTaskUnlockReq

function CEventHomelandStoryTaskUnlockReq:Constructor()
  self.id = 0
end

CEventHomelandStoryTaskUnlockReq._proto = {
  [1] = {"id", "int"}
}
_class("CEventHomelandStoryTaskUnlockReply", CCallReplyEvent)
CEventHomelandStoryTaskUnlockReply = CEventHomelandStoryTaskUnlockReply

function CEventHomelandStoryTaskUnlockReply:Constructor()
  self.nRet = 0
end

CEventHomelandStoryTaskUnlockReply._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventHomelandStoryTaskAutoOperateReq", CCallRequestEvent)
CEventHomelandStoryTaskAutoOperateReq = CEventHomelandStoryTaskAutoOperateReq

function CEventHomelandStoryTaskAutoOperateReq:Constructor()
  self.id = 0
end

CEventHomelandStoryTaskAutoOperateReq._proto = {
  [1] = {"id", "int"}
}
_class("CEventHomelandStoryTaskAutoOperateReply", CCallReplyEvent)
CEventHomelandStoryTaskAutoOperateReply = CEventHomelandStoryTaskAutoOperateReply

function CEventHomelandStoryTaskAutoOperateReply:Constructor()
  self.nRet = 0
end

CEventHomelandStoryTaskAutoOperateReply._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventHomelandStoryTaskUpdate", CSvrPushEvent)
CEventHomelandStoryTaskUpdate = CEventHomelandStoryTaskUpdate

function CEventHomelandStoryTaskUpdate:Constructor()
  self.info = homelandStoryTask:New()
end

CEventHomelandStoryTaskUpdate._proto = {
  [1] = {
    "info",
    "homelandStoryTask"
  }
}
_class("CEventHomelandStoryTaskMoudleUnlockReq", CCallRequestEvent)
CEventHomelandStoryTaskMoudleUnlockReq = CEventHomelandStoryTaskMoudleUnlockReq

function CEventHomelandStoryTaskMoudleUnlockReq:Constructor()
end

CEventHomelandStoryTaskMoudleUnlockReq._proto = {}
_class("CEventHomelandStoryTaskMoudleUnlockReply", CCallReplyEvent)
CEventHomelandStoryTaskMoudleUnlockReply = CEventHomelandStoryTaskMoudleUnlockReply

function CEventHomelandStoryTaskMoudleUnlockReply:Constructor()
  self.nRet = 0
  self.info = homelandStoryTask:New()
end

CEventHomelandStoryTaskMoudleUnlockReply._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "info",
    "homelandStoryTask"
  }
}
_class("CEventUnlockFatherHangPointReq", CCallRequestEvent)
CEventUnlockFatherHangPointReq = CEventUnlockFatherHangPointReq

function CEventUnlockFatherHangPointReq:Constructor()
  self.pstid = 0
  self.hang_point_id = 0
end

CEventUnlockFatherHangPointReq._proto = {
  [1] = {"pstid", "int64"},
  [2] = {
    "hang_point_id",
    "int"
  }
}
_class("CEventUnlockFatherHangPointRes", CCallReplyEvent)
CEventUnlockFatherHangPointRes = CEventUnlockFatherHangPointRes

function CEventUnlockFatherHangPointRes:Constructor()
  self.nRet = 0
  self.data = FatherArchitectureData:New()
end

CEventUnlockFatherHangPointRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "data",
    "FatherArchitectureData"
  }
}
_class("CEventFatherHangPointUpdate", CSvrPushEvent)
CEventFatherHangPointUpdate = CEventFatherHangPointUpdate

function CEventFatherHangPointUpdate:Constructor()
  self.father_arch_info = FatherArchitectureData:New()
end

CEventFatherHangPointUpdate._proto = {
  [1] = {
    "father_arch_info",
    "FatherArchitectureData"
  }
}
_class("CEventEnterMakingMoviceReq", CCallRequestEvent)
CEventEnterMakingMoviceReq = CEventEnterMakingMoviceReq

function CEventEnterMakingMoviceReq:Constructor()
  self.movice_id = 0
end

CEventEnterMakingMoviceReq._proto = {
  [1] = {"movice_id", "int"}
}
_class("CEventEnterMakingMoviceRes", CCallReplyEvent)
CEventEnterMakingMoviceRes = CEventEnterMakingMoviceRes

function CEventEnterMakingMoviceRes:Constructor()
  self.nRet = 0
  self.pstid = 0
end

CEventEnterMakingMoviceRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {"pstid", "uint64"}
}
_class("CEventSubmitRecordNameReq", CCallRequestEvent)
CEventSubmitRecordNameReq = CEventSubmitRecordNameReq

function CEventSubmitRecordNameReq:Constructor()
  self.pstid = 0
  self.name = ""
end

CEventSubmitRecordNameReq._proto = {
  [1] = {"pstid", "uint64"},
  [2] = {"name", "string"}
}
_class("CEventSubmitRecordNameRes", CCallReplyEvent)
CEventSubmitRecordNameRes = CEventSubmitRecordNameRes

function CEventSubmitRecordNameRes:Constructor()
  self.nRet = 0
end

CEventSubmitRecordNameRes._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventRequestScoreReq", CCallRequestEvent)
CEventRequestScoreReq = CEventRequestScoreReq

function CEventRequestScoreReq:Constructor()
  self.record = MoviceRecord:New()
  self.pstid = 0
end

CEventRequestScoreReq._proto = {
  [1] = {
    "record",
    "MoviceRecord"
  },
  [2] = {"pstid", "uint64"}
}
_class("CEventRequestScoreRes", CCallReplyEvent)
CEventRequestScoreRes = CEventRequestScoreRes

function CEventRequestScoreRes:Constructor()
  self.nRet = 0
  self.item_score = 0
  self.option_score = 0
  self.pet_score = 0
  self.rewards = {}
  self.data = MoviceData:New()
end

CEventRequestScoreRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {"item_score", "int"},
  [3] = {
    "option_score",
    "int"
  },
  [4] = {"pet_score", "int"},
  [5] = {
    "rewards",
    "list<RoleAsset>"
  },
  [6] = {"data", "MoviceData"}
}
_class("CEventSaveRecordReq", CCallRequestEvent)
CEventSaveRecordReq = CEventSaveRecordReq

function CEventSaveRecordReq:Constructor()
  self.cur_record_pstid = 0
  self.replace_record_pstid = 0
  self.arch_list = {}
end

CEventSaveRecordReq._proto = {
  [1] = {
    "cur_record_pstid",
    "uint64"
  },
  [2] = {
    "replace_record_pstid",
    "uint64"
  },
  [3] = {
    "arch_list",
    "list<Architecture>"
  }
}
_class("CEventSaveRecordRes", CCallReplyEvent)
CEventSaveRecordRes = CEventSaveRecordRes

function CEventSaveRecordRes:Constructor()
  self.nRet = 0
  self.data = MoviceData:New()
end

CEventSaveRecordRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {"data", "MoviceData"}
}
_class("CEventRequestRecordArchReq", CCallRequestEvent)
CEventRequestRecordArchReq = CEventRequestRecordArchReq

function CEventRequestRecordArchReq:Constructor()
  self.pstid = 0
  self.movice_id = 0
end

CEventRequestRecordArchReq._proto = {
  [1] = {"pstid", "uint64"},
  [2] = {"movice_id", "int"}
}
_class("CEventRequestRecordArchRes", CCallReplyEvent)
CEventRequestRecordArchRes = CEventRequestRecordArchRes

function CEventRequestRecordArchRes:Constructor()
  self.nRet = 0
  self.arch_list = {}
end

CEventRequestRecordArchRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "arch_list",
    "list<Architecture>"
  }
}
_class("CEventHomelandRefreshRarePositionPush", CSvrPushEvent)
CEventHomelandRefreshRarePositionPush = CEventHomelandRefreshRarePositionPush

function CEventHomelandRefreshRarePositionPush:Constructor()
  self.clue_submit_status = {}
end

CEventHomelandRefreshRarePositionPush._proto = {
  [1] = {
    "clue_submit_status",
    "map<int,ClueRareStatus>"
  }
}
_class("CEventFishingChallengeReq", CCallRequestEvent)
CEventFishingChallengeReq = CEventFishingChallengeReq

function CEventFishingChallengeReq:Constructor()
  self.match_main_id = 0
end

CEventFishingChallengeReq._proto = {
  [1] = {
    "match_main_id",
    "int"
  }
}
_class("CEventFishingChallengeRes", CCallReplyEvent)
CEventFishingChallengeRes = CEventFishingChallengeRes

function CEventFishingChallengeRes:Constructor()
  self.nRet = 0
  self.end_time = 0
  self.pet_ability_id = 0
end

CEventFishingChallengeRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {"end_time", "time"},
  [3] = {
    "pet_ability_id",
    "int"
  }
}
_class("CEventFishingChallengeEndReq", CCallRequestEvent)
CEventFishingChallengeEndReq = CEventFishingChallengeEndReq

function CEventFishingChallengeEndReq:Constructor()
  self.pet_fish_num = 0
end

CEventFishingChallengeEndReq._proto = {
  [1] = {
    "pet_fish_num",
    "int"
  }
}
_class("CEventFishingChallengeEndRes", CCallReplyEvent)
CEventFishingChallengeEndRes = CEventFishingChallengeEndRes

function CEventFishingChallengeEndRes:Constructor()
  self.nRet = 0
  self.success = 0
  self.rewards = {}
  self.challenge_pet_times = {}
end

CEventFishingChallengeEndRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {"success", "int"},
  [3] = {
    "rewards",
    "list<RoleAsset>"
  },
  [4] = {
    "challenge_pet_times",
    "map<int,int>"
  }
}
_class("CEventCancelFishingChallengeReq", CCallRequestEvent)
CEventCancelFishingChallengeReq = CEventCancelFishingChallengeReq

function CEventCancelFishingChallengeReq:Constructor()
  self.match_main_id = 0
end

CEventCancelFishingChallengeReq._proto = {
  [1] = {
    "match_main_id",
    "int"
  }
}
_class("CEventCancelFishingChallengeRes", CCallReplyEvent)
CEventCancelFishingChallengeRes = CEventCancelFishingChallengeRes

function CEventCancelFishingChallengeRes:Constructor()
  self.nRet = 0
end

CEventCancelFishingChallengeRes._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventReceiveAnonymousLetterRewardReq", CCallRequestEvent)
CEventReceiveAnonymousLetterRewardReq = CEventReceiveAnonymousLetterRewardReq

function CEventReceiveAnonymousLetterRewardReq:Constructor()
  self.anonymous_letter_id = 0
end

CEventReceiveAnonymousLetterRewardReq._proto = {
  [1] = {
    "anonymous_letter_id",
    "int"
  }
}
_class("CEventReceiveAnonymousLetterRewardRes", CCallReplyEvent)
CEventReceiveAnonymousLetterRewardRes = CEventReceiveAnonymousLetterRewardRes

function CEventReceiveAnonymousLetterRewardRes:Constructor()
  self.nRet = 0
  self.rewards = {}
  self.anonymous_letter_receive = {}
end

CEventReceiveAnonymousLetterRewardRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  },
  [3] = {
    "anonymous_letter_receive",
    "list<int>"
  }
}
