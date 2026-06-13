local t = {
  [-1] = {
    error_ui = 1,
    id = -1,
    ignore_tips = 1,
    tips = "错误码未定义",
    type = "ERRCODE_UNDEFINED"
  },
  [0] = {
    error_ui = 1,
    id = 0,
    ignore_tips = 1,
    tips = "成功",
    type = "OK"
  },
  [101] = {
    error_ui = 1,
    id = 101,
    ignore_tips = 1,
    tips = "账号信息错误",
    type = "ACCOUNT_INFO_ERR"
  },
  [102] = {
    error_ui = 1,
    id = 102,
    ignore_tips = 1,
    tips = "请求频率过高",
    type = "REQ_FREQUENCY_TOO_HIGH"
  },
  [1001] = {
    error_ui = 0,
    id = 1001,
    ignore_tips = 1,
    tips = "Token验证失败",
    type = "ERR_TOKEN"
  },
  [1002] = {
    error_ui = 1,
    id = 1002,
    tips = "解包失败",
    type = "UNPACK_ERROR"
  },
  [1003] = {
    error_ui = 1,
    id = 1003,
    tips = "正在加载数据",
    type = "DATA_LOADING"
  },
  [1004] = {
    error_ui = 1,
    id = 1004,
    tips = "已登录",
    type = "ALREADY_LOGIN"
  },
  [1006] = {
    error_ui = 1,
    id = 1006,
    ignore_tips = 1,
    tips = "登录失败",
    type = "LOGIN_FAILED"
  },
  [1007] = {
    error_ui = 1,
    id = 1007,
    tips = "未找到该玩家",
    type = "ROLE_NOT_FIND"
  },
  [1008] = {
    error_ui = 1,
    id = 1008,
    ignore_tips = 1,
    tips = "协议错误",
    type = "PROTO_ERROR"
  },
  [1009] = {
    error_ui = 1,
    id = 1009,
    ignore_tips = 1,
    tips = "未知错误",
    type = "UNKNOWN_ERROR"
  },
  [1010] = {
    error_ui = 1,
    id = 1010,
    ignore_tips = 1,
    tips = "塔不存在",
    type = "TOWER_NOT_FIND"
  },
  [1011] = {
    error_ui = 1,
    id = 1011,
    ignore_tips = 1,
    tips = "错误层数",
    type = "TOWER_FLOOR_NOT_FIND"
  },
  [1012] = {
    error_ui = 1,
    id = 1012,
    ignore_tips = 1,
    tips = "房间不存在",
    type = "TOWER_ROOM_NOT_FIND"
  },
  [1013] = {
    error_ui = 1,
    id = 1013,
    tips = "关卡未通关",
    type = "TOWER_ROOM_NOT_FIGHT_THROUGH"
  },
  [1014] = {
    error_ui = 1,
    id = 1014,
    tips = "该关卡已通关",
    type = "TOWER_ROOM_ALREADY_FIGHT_THROUGH"
  },
  [1015] = {
    error_ui = 1,
    id = 1015,
    tips = "上一层未通关",
    type = "TOWER_PREV_FLOOR_NOT_FIGHT_THROUGH"
  },
  [1016] = {
    error_ui = 1,
    id = 1016,
    ignore_tips = 1,
    tips = "起始房间错误",
    type = "TOWER_BEGIN_ROOM_ERROR"
  },
  [1017] = {
    error_ui = 1,
    id = 1017,
    ignore_tips = 1,
    tips = "房间不连通",
    type = "TOWER_ROOMS_DISCONNECTED"
  },
  [1018] = {
    error_ui = 1,
    id = 1018,
    tips = "已经在关卡中",
    type = "TOWER_ALREADY_IN_ROOM"
  },
  [1019] = {
    error_ui = 1,
    id = 1019,
    ignore_tips = 1,
    tips = "角色层索引记录错误",
    type = "TOWER_ROLE_FLOOR_IDX_ERROR"
  },
  [1020] = {
    error_ui = 1,
    id = 1020,
    ignore_tips = 1,
    tips = "角色房间号记录错误",
    type = "TOWER_ROLE_ROOM_NUM_ERROR"
  },
  [1021] = {
    error_ui = 1,
    id = 1021,
    ignore_tips = 1,
    tips = "兑换道具规则不存在",
    type = "EXCHANGE_ITEMS_RULL_NOT_FIND"
  },
  [1022] = {
    error_ui = 1,
    id = 1022,
    ignore_tips = 1,
    tips = "兑换道具失败(删除物品失败或增加物品失败）",
    type = "EXCHANGE_ITEMS_ERROR"
  },
  [1023] = {
    error_ui = 1,
    id = 1023,
    ignore_tips = 1,
    tips = "奖励组不存在",
    type = "AWARD_GROUP_NOT_FIND"
  },
  [1024] = {
    error_ui = 1,
    id = 1024,
    ignore_tips = 1,
    tips = "该编号奖励不存在",
    type = "AWARD_NOT_FIND"
  },
  [1025] = {
    error_ui = 1,
    id = 1025,
    tips = "仓库已满",
    type = "BAG_OVERFLOW"
  },
  [1026] = {
    error_ui = 1,
    id = 1026,
    tips = "条件不满足",
    type = "CONDITION_NOT_COMPLETE"
  },
  [1027] = {
    error_ui = 1,
    id = 1027,
    tips = "消耗不满足",
    type = "COST_NOT_ENOUGHT"
  },
  [1028] = {
    error_ui = 1,
    id = 1028,
    ignore_tips = 1,
    tips = "配置错误",
    type = "CONFIG_ERROR"
  },
  [1029] = {
    error_ui = 1,
    id = 1029,
    tips = "未拥有该道具",
    type = "OBJECT_NOT_FOUND"
  },
  [1030] = {
    error_ui = 1,
    id = 1030,
    tips = "未满级",
    type = "BUDDY_NOT_MAX_LV"
  },
  [1031] = {
    error_ui = 1,
    id = 1031,
    tips = "已满级",
    type = "BUDDY_MAX_LV"
  },
  [1032] = {
    error_ui = 1,
    id = 1032,
    tips = "装备已满级",
    type = "EQUIP_MAX_LV"
  },
  [1033] = {
    error_ui = 1,
    id = 1033,
    tips = "装备未满级",
    type = "EQUIP_NOT_MAX_LV"
  },
  [1034] = {
    error_ui = 1,
    id = 1034,
    ignore_tips = 1,
    tips = "攻击者技能不存在",
    type = "ATTACKER_SKILL_NOT_FOUND"
  },
  [1035] = {
    error_ui = 1,
    id = 1035,
    ignore_tips = 1,
    tips = "攻击者已死亡",
    type = "ATTACKER_NOT_ALIVE"
  },
  [1036] = {
    error_ui = 1,
    id = 1036,
    ignore_tips = 1,
    tips = "受害者已死亡",
    type = "VICTIM_NOT_ALIVE"
  },
  [1037] = {
    error_ui = 1,
    id = 1037,
    ignore_tips = 1,
    tips = "攻击者不存在",
    type = "ATTACKER_NOT_FOUND"
  },
  [1038] = {
    error_ui = 1,
    id = 1038,
    ignore_tips = 1,
    tips = "受害者不存在",
    type = "VICTIM_NOT_FOUND"
  },
  [1039] = {
    error_ui = 1,
    id = 1039,
    ignore_tips = 1,
    tips = "子弹可碰撞次数上限",
    type = "HIT_COUNT_ERROR"
  },
  [1040] = {
    error_ui = 0,
    id = 1040,
    ignore_tips = 1,
    tips = "magic不被此次子弹允许释放",
    type = "MAGIC_DONT_PERMIT_MISSILEUUID"
  },
  [1041] = {
    error_ui = 0,
    id = 1041,
    ignore_tips = 1,
    tips = "magic不被此次技能允许释放",
    type = "MAGIC_DONT_PERMIT_SKILLUUID"
  },
  [1042] = {
    error_ui = 0,
    id = 1042,
    ignore_tips = 1,
    tips = "不是合法magic",
    type = "MAGIC_NOT_FOUND"
  },
  [1043] = {
    error_ui = 0,
    id = 1043,
    ignore_tips = 1,
    tips = "子弹不被此次技能允许释放",
    type = "MISSILE_DONT_PERMIT_SKILLUUID"
  },
  [1044] = {
    error_ui = 0,
    id = 1044,
    ignore_tips = 1,
    tips = "不是合法子弹",
    type = "MISSILE_NOT_FOUND"
  },
  [1045] = {
    error_ui = 0,
    id = 1045,
    ignore_tips = 1,
    tips = "不是合法技能",
    type = "SKILL_NOT_FOUND"
  },
  [1046] = {
    error_ui = 0,
    id = 1046,
    ignore_tips = 1,
    tips = "技能UUID重复",
    type = "SKILL_UUID_REPEAT"
  },
  [1047] = {
    error_ui = 0,
    id = 1047,
    ignore_tips = 1,
    tips = "目标entity不存在",
    type = "TARGET_ENTITY_NOT_FOUND"
  },
  [1048] = {
    error_ui = 0,
    id = 1048,
    ignore_tips = 1,
    tips = "entity不存在",
    type = "ENTITY_NOT_FOUND"
  },
  [1049] = {
    error_ui = 1,
    id = 1049,
    tips = "不在战斗中",
    type = "NOT_IN_WAR"
  },
  [1050] = {
    error_ui = 1,
    id = 1050,
    tips = "该装备不能分解",
    type = "EQUIP_CANT_DECOMPOSE"
  },
  [1051] = {
    error_ui = 1,
    id = 1051,
    tips = "没有设置出战",
    type = "DONT_SET_APPEAR"
  },
  [1052] = {
    error_ui = 1,
    id = 1052,
    tips = "该武器类型不匹配",
    type = "EQUIP_TYPE_ERROR"
  },
  [1053] = {
    error_ui = 1,
    id = 1053,
    tips = "任务未完成",
    type = "TASK_UNCOMPLETE"
  },
  [1054] = {
    error_ui = 1,
    id = 1054,
    tips = "任务已完成",
    type = "TASK_COMPLETE"
  },
  [1055] = {
    error_ui = 1,
    id = 1055,
    tips = "角色在战斗中",
    type = "ROLE_IN_WAR"
  },
  [1056] = {
    error_ui = 1,
    id = 1056,
    ignore_tips = 1,
    tips = "参数错误",
    type = "PARAM_ERROR"
  },
  [1057] = {
    error_ui = 1,
    id = 1057,
    tips = "关卡未开启",
    type = "EPISODE_UNCOMPLETE"
  },
  [1058] = {
    error_ui = 1,
    id = 1058,
    tips = "挑战次数不足",
    type = "CHALLENGE_NOT_ENOUGH"
  },
  [1059] = {
    error_ui = 1,
    id = 1059,
    ignore_tips = 1,
    tips = "道具ID_UUID不匹配",
    type = "ID_UUID_MISMATCH"
  },
  [1060] = {
    error_ui = 1,
    id = 1060,
    tips = "战斗未结束，无法使用仓库",
    type = "IS_IN_WAR"
  },
  [1061] = {
    error_ui = 1,
    id = 1061,
    tips = "出战角色数量不满足",
    type = "FIGHT_COUNT_NOT_ENOUGHT"
  },
  [1062] = {
    error_ui = 1,
    id = 1062,
    tips = "当前关卡未结算",
    type = "TOWER_NOT_LIQUIDATION"
  },
  [1063] = {
    error_ui = 1,
    id = 1063,
    tips = "当前关卡未通关",
    type = "EXIST_A_TOWER"
  },
  [1064] = {
    error_ui = 1,
    id = 1064,
    ignore_tips = 1,
    tips = "找不到塔的入口信息",
    type = "TOWER_ENTER_ERROR"
  },
  [1065] = {
    error_ui = 1,
    id = 1065,
    ignore_tips = 1,
    tips = "塔不匹配",
    type = "TOWER_NOT_MATCH"
  },
  [1066] = {
    error_ui = 1,
    id = 1066,
    tips = "角色尚未死亡",
    type = "HERO_NOT_DEAD"
  },
  [1067] = {
    error_ui = 1,
    id = 1067,
    ignore_tips = 1,
    tips = "材料错误",
    type = "MATERIAL_ERROR"
  },
  [1068] = {
    error_ui = 1,
    id = 1068,
    tips = "没有编队",
    type = "FORMATION_NOT_FIND"
  },
  [1069] = {
    error_ui = 1,
    id = 1069,
    ignore_tips = 1,
    tips = "已经触发掉落",
    type = "HAD_DROPED"
  },
  [1070] = {
    error_ui = 1,
    id = 1070,
    tips = "邮件已读",
    type = "MAIL_HAD_READ"
  },
  [1071] = {
    error_ui = 1,
    id = 1071,
    tips = "背包空间不足",
    type = "BAG_NOT_ENOUGHT"
  },
  [1072] = {
    error_ui = 1,
    id = 1072,
    tips = "兑换次数不足",
    type = "EXCHANGE_TIMES_NOT_ENOUGHT"
  },
  [1073] = {
    error_ui = 1,
    id = 1073,
    tips = "未登入",
    type = "NOT_LOGIN"
  },
  [1074] = {
    error_ui = 1,
    id = 1074,
    tips = "商店未开启",
    type = "BATTLE_SHOP_NOT_FIND"
  },
  [1075] = {
    error_ui = 0,
    id = 1075,
    tips = "已达最大刷新次数",
    type = "MAX_REFRESH_COUNT"
  },
  [1080] = {
    error_ui = 1,
    id = 1080,
    ignore_tips = 1,
    tips = "激活的天赋和职业不匹配",
    type = "TALENT_CAREER_NOT_MATCH"
  },
  [1081] = {
    error_ui = 1,
    id = 1081,
    ignore_tips = 1,
    tips = "激活的天赋不在天赋树内",
    type = "TALENT_NOT_FOUND_IN_TREE"
  },
  [1082] = {
    error_ui = 1,
    id = 1082,
    ignore_tips = 1,
    tips = "激活的天赋不是上一个已经激活的天赋的下一个节点",
    type = "TALENT_ACTIVATING_ERROR"
  },
  [1083] = {
    error_ui = 1,
    id = 1083,
    tips = "请上阵角色后出战",
    type = "NOT_FIND_FIGHT_BUDDY"
  },
  [1084] = {
    error_ui = 1,
    id = 1084,
    ignore_tips = 1,
    tips = "商品不存在",
    type = "ITEM_NOT_FIND"
  },
  [1085] = {
    error_ui = 1,
    id = 1085,
    tips = "已购买",
    type = "HAD_BUY"
  },
  [1086] = {
    error_ui = 1,
    id = 1086,
    tips = "英雄不存在",
    type = "HERO_NOT_FOUND"
  },
  [1087] = {
    error_ui = 1,
    id = 1087,
    tips = "英雄已死亡",
    type = "HERO_IS_DEAD"
  },
  [1088] = {
    error_ui = 1,
    id = 1088,
    tips = "当前角色生命值已满，无法使用",
    type = "HP_OVERFLOW"
  },
  [1089] = {
    error_ui = 1,
    id = 1089,
    tips = "天赋已经激活",
    type = "TALENT_ACTIVATE"
  },
  [1090] = {
    error_ui = 1,
    id = 1090,
    ignore_tips = 1,
    tips = "最大子子弹数量",
    type = "CHILD_MISSILE_LIMIT_CNT"
  },
  [1091] = {
    error_ui = 1,
    id = 1091,
    ignore_tips = 1,
    tips = "父子弹不存在",
    type = "PARENT_MISSILE_NOT_FOUND"
  },
  [1092] = {
    error_ui = 0,
    id = 1092,
    ignore_tips = 1,
    tips = "错误的missile ID",
    type = "NOT_CHILD_MISSILE_ID"
  },
  [1093] = {
    error_ui = 1,
    id = 1093,
    tips = "附件未领取",
    type = "ATTACHMENT_NOT_GET"
  },
  [1094] = {
    error_ui = 1,
    id = 1094,
    tips = "重要邮件已满",
    type = "IMPORTTANT_MAIL_MAX_CNT"
  },
  [1095] = {
    error_ui = 1,
    id = 1095,
    tips = "天赋效果没有激活",
    type = "TALENT_EFFECT_NOT_ACTIVATE"
  },
  [1096] = {
    error_ui = 1,
    id = 1096,
    tips = "请依次激活天赋",
    type = "TALENT_NOT_FIRST"
  },
  [1097] = {
    error_ui = 1,
    id = 1097,
    tips = "客户端版本过低",
    type = "CLIENT_VERSION_IS_TOO_LOW"
  },
  [1098] = {
    error_ui = 1,
    id = 1098,
    tips = "编队名字太长",
    type = "TEAM_NAME_TOO_LONG"
  },
  [1099] = {
    error_ui = 1,
    id = 1099,
    tips = "编队最大数量",
    type = "TEAM_MAX_COUNT"
  },
  [1100] = {
    error_ui = 1,
    id = 1100,
    tips = "已签到",
    type = "SIGN_REPEAT"
  },
  [1101] = {
    error_ui = 1,
    id = 1101,
    tips = "商店未开启",
    type = "EXCHANGE_SHOP_NOT_OPEN"
  },
  [1102] = {
    error_ui = 1,
    id = 1102,
    ignore_tips = 1,
    tips = "商品不存在",
    type = "EXCHANGE_GOODS_NOT_FIND"
  },
  [1103] = {
    error_ui = 1,
    id = 1103,
    tips = "商品已售罄",
    type = "GOODS_QUOTA_NOT_ENOUGHT"
  },
  [1104] = {
    error_ui = 1,
    id = 1104,
    ignore_tips = 1,
    tips = "公告重复标记",
    type = "NOTICE_READ_REPEAT"
  },
  [1105] = {
    error_ui = 1,
    id = 1105,
    ignore_tips = 1,
    tips = "头像不存在",
    type = "FACE_NOT_FIND"
  },
  [1106] = {
    error_ui = 1,
    id = 1106,
    tips = "此兑换码无效",
    type = "CDKEY_NOT_FIND"
  },
  [1107] = {
    error_ui = 1,
    id = 1107,
    tips = "兑换码已使用",
    type = "CDKEY_USED"
  },
  [1108] = {
    error_ui = 1,
    id = 1108,
    tips = "兑换码最大使用次数",
    type = "CDKEY_MAX_USE_CNT"
  },
  [1109] = {
    error_ui = 1,
    id = 1109,
    tips = "生日已设置",
    type = "BIRTHDAY_HAD_SET"
  },
  [1110] = {
    error_ui = 1,
    id = 1110,
    tips = "语录长度超出范围",
    type = "MAX_QUOTATION_SIZE"
  },
  [1111] = {
    error_ui = 1,
    id = 1111,
    tips = "名称长度超出范围",
    type = "MAX_NAME_SIZE"
  },
  [1112] = {
    error_ui = 1,
    id = 1112,
    ignore_tips = 1,
    tips = "头像不存在",
    type = "FACE_NOT_FIND"
  },
  [1113] = {
    error_ui = 1,
    id = 1113,
    ignore_tips = 1,
    tips = "活动不存在",
    type = "ACTY_NO_EXISTEN"
  },
  [1114] = {
    error_ui = 1,
    id = 1114,
    tips = "活动未开放",
    type = "ACTY_NO_OPEN"
  },
  [1115] = {
    error_ui = 1,
    id = 1115,
    tips = "角色档案未激活",
    type = "CONCERN_BUDDY_LOCK"
  },
  [1116] = {
    error_ui = 1,
    id = 1116,
    ignore_tips = 1,
    tips = "档案不存在",
    type = "ARCH_NO_EXISTEM"
  },
  [1117] = {
    error_ui = 1,
    id = 1117,
    tips = "档案未开放",
    type = "ARCH_NO_OPEN"
  },
  [1118] = {
    error_ui = 1,
    id = 1118,
    tips = "该词条尚未解锁",
    type = "DICTIONARY_LOCK"
  },
  [1119] = {
    error_ui = 1,
    id = 1119,
    tips = "该怪物档案未解锁",
    type = "MONSTER_ARCH_LOCK"
  },
  [1120] = {
    error_ui = 1,
    id = 1120,
    tips = "今天已经提交评分",
    type = "TODAY_ALREADY_SET_SCORE"
  },
  [1121] = {
    error_ui = 1,
    id = 1121,
    tips = "该行动录像未解锁",
    type = "MOVE_VIDEO_LOCK"
  },
  [1122] = {
    error_ui = 1,
    id = 1122,
    tips = "该相片未解锁",
    type = "ALBUM_LOCK"
  },
  [1123] = {
    error_ui = 1,
    id = 1123,
    tips = "商品已达到购买上限",
    type = "BUY_GOOD_LIMIT"
  },
  [1124] = {
    error_ui = 1,
    id = 1124,
    tips = "无法装备祝福",
    type = "NOT_CARGO_BLESS"
  },
  [1125] = {
    error_ui = 1,
    id = 1125,
    tips = "未解锁祝福栏位",
    type = "BLESS_POS_LOCK"
  },
  [1126] = {
    error_ui = 1,
    id = 1126,
    tips = "当前无法发言",
    type = "IN_BAN_CHAT_STATE"
  },
  [1127] = {
    error_ui = 1,
    id = 1127,
    tips = "礼包码未启用",
    type = "CD_KEY_IN_BAN_STATUS"
  },
  [1128] = {
    error_ui = 1,
    id = 1128,
    tips = "礼包码已过期",
    type = "CD_KEY_GIFT_EXPIRE"
  },
  [1400] = {
    error_ui = 1,
    id = 1400,
    tips = "已经是好友",
    type = "ALREADY_FRIEND"
  },
  [1401] = {
    error_ui = 1,
    id = 1401,
    tips = "好友申请CD中",
    type = "APPLY_FRIEND_CD"
  },
  [1402] = {
    error_ui = 1,
    id = 1402,
    tips = "好友申请不存在",
    type = "FRIEND_APPLY_NOEXIST"
  },
  [1403] = {
    error_ui = 1,
    id = 1403,
    tips = "好友数量已达上限",
    type = "FRIEND_NUM_LIMIT"
  },
  [1404] = {
    error_ui = 1,
    id = 1404,
    tips = "该好友不存在",
    type = "FRIEND_NOEXIST"
  },
  [1405] = {
    error_ui = 1,
    id = 1405,
    tips = "不能向自己申请好友",
    type = "CANT_APPLY_FRIEND_TO_SELF"
  },
  [1406] = {
    error_ui = 1,
    id = 1406,
    tips = "不能添加自己为好友",
    type = "CANT_ADD_SELF_AS_FRIEND"
  },
  [1407] = {
    error_ui = 1,
    id = 1407,
    tips = "宝箱已经被领取",
    type = "TREASURE_IS_OBTAINED"
  },
  [1408] = {
    error_ui = 1,
    id = 1408,
    ignore_tips = 1,
    tips = "宝箱不存在",
    type = "BATTLE_TREASURE_NOT_FIND"
  },
  [1409] = {
    error_ui = 1,
    id = 1409,
    ignore_tips = 1,
    tips = "功能性NPC不存在",
    type = "FUNCTIONAL_NPC_NOT_FOUND"
  },
  [1410] = {
    error_ui = 1,
    id = 1410,
    ignore_tips = 1,
    tips = "功能性NPC已不能交互",
    type = "FUNCTIONAL_NPC_CANT_INTERACT"
  },
  [1411] = {
    error_ui = 1,
    id = 1411,
    ignore_tips = 1,
    tips = "无效的账号",
    type = "ERROR_ACCOUNT"
  },
  [1412] = {
    error_ui = 1,
    id = 1412,
    ignore_tips = 1,
    tips = "时装不存在",
    type = "BUDDY_FASHION_NOT_FOUND"
  },
  [1413] = {
    error_ui = 1,
    id = 1413,
    ignore_tips = 1,
    tips = "时装重复阅读",
    type = "BUDDY_FASHION_READ_REPEAT"
  },
  [1414] = {
    error_ui = 1,
    id = 1414,
    ignore_tips = 1,
    tips = "时装穿上操作重复",
    type = "BUDDY_FASHION_WEAR_REPEAT"
  },
  [1415] = {
    error_ui = 1,
    id = 1415,
    tips = "角色尚未拥有",
    type = "BUDDY_NOT_YET_GET"
  },
  [1416] = {
    error_ui = 1,
    id = 1416,
    ignore_tips = 1,
    tips = "材料塔不存在",
    type = "MATERIAL_NOT_FIND"
  },
  [1417] = {
    error_ui = 1,
    id = 1417,
    ignore_tips = 1,
    tips = "无尽塔不存在",
    type = "INFINITE_NOT_FIND"
  },
  [1418] = {
    error_ui = 1,
    id = 1418,
    tips = "天赋树尚未激活",
    type = "TALENT_TREE_NOT_ACTIVATE"
  },
  [1419] = {
    error_ui = 1,
    id = 1419,
    tips = "天赋树激活重复",
    type = "TALENT_TREE_ACTIVATE_REPEAT"
  },
  [1420] = {
    error_ui = 1,
    id = 1420,
    tips = "有未选择的技能",
    type = "BATTLE_SKILL_NOT_SELECT"
  },
  [1421] = {
    error_ui = 1,
    id = 1421,
    ignore_tips = 1,
    tips = "技能不存在",
    type = "BATTLE_SKILL_NOT_FOUND"
  },
  [1500] = {
    error_ui = 1,
    id = 1500,
    ignore_tips = 1,
    tips = "玩家不在该聊天频道",
    type = "ROLE_NOT_IN_CHAT_CHANNEL"
  },
  [1501] = {
    error_ui = 1,
    id = 1501,
    ignore_tips = 1,
    tips = "聊天频道不存在",
    type = "CHAT_CHANNEL_NO_EXIST"
  },
  [1502] = {
    error_ui = 1,
    id = 1502,
    ignore_tips = 1,
    tips = "重复加入聊天频道",
    type = "REJOIN_CHAT_CHANNEL"
  },
  [1503] = {
    error_ui = 1,
    id = 1503,
    ignore_tips = 1,
    tips = "无效的聊天频道ID",
    type = "INVALID_CHAT_CHANNEL_ID"
  },
  [1504] = {
    error_ui = 1,
    id = 1504,
    ignore_tips = 1,
    tips = "全部聊天频道爆满",
    type = "ALL_CHAT_CHANNEL_CROWDED"
  },
  [1505] = {
    error_ui = 1,
    id = 1505,
    ignore_tips = 1,
    tips = "聊天频道创建失败",
    type = "CREATE_CHAT_CHANNEL_FAILED"
  },
  [1506] = {
    error_ui = 1,
    id = 1506,
    ignore_tips = 1,
    tips = "当前聊天频道人数已达上限",
    type = "CHAT_CHANNEL_ROLE_NUM_LIMIT"
  },
  [1507] = {
    error_ui = 1,
    id = 1507,
    tips = "文字内容存在敏感信息",
    type = "CHAT_MSG_INCLUDE_SENSITIVE_WORDS"
  },
  [1508] = {
    error_ui = 1,
    id = 1508,
    tips = "主天赋尚未激活",
    type = "MAIN_TALENT_NOT_ACTIVATE"
  },
  [1509] = {
    error_ui = 1,
    id = 1509,
    tips = "未达到发言等级",
    type = "INSUFFICIENT_CHAT_LV"
  },
  [1510] = {
    error_ui = 1,
    id = 1510,
    tips = "发言过于频繁,请稍后",
    type = "IN_CHAT_CD"
  },
  [1600] = {
    error_ui = 1,
    id = 1600,
    tips = "服务器维护中",
    type = "SERVER_MAINTENANCE"
  },
  [1601] = {
    error_ui = 1,
    id = 1601,
    tips = "账号验证失败",
    type = "PLATFORM_AUTH_FAILED"
  },
  [1602] = {
    error_ui = 1,
    id = 1602,
    ignore_tips = 1,
    tips = "未注册的鉴权请求",
    type = "UNREGISTERED_AUTH_REQUEST"
  },
  [1603] = {
    error_ui = 1,
    id = 1603,
    tips = "服务器启动中,请稍后",
    type = "SERVER_STARTING"
  },
  [1604] = {
    error_ui = 1,
    id = 1604,
    tips = "技能未激活",
    type = "SKILL_NOT_ACTIVE"
  },
  [1605] = {
    error_ui = 1,
    id = 1605,
    ignore_tips = 1,
    tips = "专精技能不存在",
    type = "BATTLE_SKILL_MAJOR_NOT_FOUND"
  },
  [1606] = {
    error_ui = 1,
    id = 1606,
    tips = "系统未开启",
    type = "SYSTEM_NOT_OPEN"
  },
  [1607] = {
    error_ui = 1,
    id = 1607,
    tips = "已回复",
    type = "HAD_RESTORE_HP"
  },
  [1608] = {
    error_ui = 0,
    id = 1608,
    ignore_tips = 1,
    tips = "子弹目标不存在",
    type = "MISSILE_TARGET_NOT_FOUND"
  },
  [1609] = {
    error_ui = 1,
    id = 1609,
    ignore_tips = 1,
    tips = "重复领取奖励",
    type = "RECEIVE_AWARD_REPEAT"
  },
  [1610] = {
    error_ui = 1,
    id = 1610,
    ignore_tips = 1,
    tips = "标记重复",
    type = "MARK_REPEAT"
  },
  [1611] = {
    error_ui = 1,
    id = 1611,
    ignore_tips = 1,
    tips = "挑战重复",
    type = "CHALLENGE_REPEAT"
  },
  [1612] = {
    error_ui = 1,
    id = 1612,
    ignore_tips = 1,
    tips = "还未阅读新手剧情",
    type = "NOT_READ_NEWBIE_STORY"
  },
  [1613] = {
    error_ui = 1,
    id = 1613,
    ignore_tips = 1,
    tips = "签到天数超出上限",
    type = "SIGN_IN_OVERFLOW"
  },
  [1614] = {
    error_ui = 1,
    id = 1614,
    ignore_tips = 1,
    tips = "已接取组内其它任务",
    type = "HAS_ACCEPT_GROUP_TASK"
  },
  [1615] = {
    error_ui = 1,
    id = 1615,
    ignore_tips = 1,
    tips = "请求过于频繁",
    type = "REQUEST_FREQUENT"
  },
  [1616] = {
    error_ui = 1,
    id = 1616,
    ignore_tips = 1,
    tips = "卡池未开放",
    type = "DRAW_POOL_NOT_OPEN"
  },
  [1617] = {
    error_ui = 1,
    id = 1617,
    ignore_tips = 1,
    tips = "卡池组未开放",
    type = "DRAW_GROUP_NOT_OPEN"
  },
  [1618] = {
    error_ui = 1,
    id = 1618,
    tips = "剩余检索次数不足",
    type = "DRAW_POOL_CNT_NOT_ENOUGHT"
  },
  [1619] = {
    error_ui = 1,
    id = 1619,
    ignore_tips = 1,
    tips = "挑战重复开始",
    type = "CHALLENGE_REPEAT"
  },
  [1620] = {
    error_ui = 1,
    id = 1620,
    tips = "挑战尚未开始",
    type = "CHALLENGE_NOT_START"
  },
  [1621] = {
    error_ui = 1,
    id = 1621,
    ignore_tips = 1,
    tips = "未找到指定活动",
    type = "ACTIVITY_NOT_FOUND"
  },
  [1622] = {
    error_ui = 1,
    id = 1622,
    tips = "不在活动期间",
    type = "ACTIVITY_DISVALID_DURATION"
  },
  [1624] = {
    error_ui = 1,
    id = 1624,
    ignore_tips = 1,
    tips = "关卡未定义",
    type = "EPISODE_NOT_FOUND"
  },
  [1625] = {
    error_ui = 1,
    id = 1625,
    ignore_tips = 1,
    tips = "专精点不足",
    type = "BATTLE_SKILL_POINT_NOT_ENOUGHT"
  },
  [1626] = {
    error_ui = 1,
    id = 1626,
    ignore_tips = 1,
    tips = "专精与出战角色不匹配",
    type = "BATTLE_SKILL_MISMATCH"
  },
  [1627] = {
    error_ui = 1,
    id = 1627,
    tips = "升阶已满级",
    type = "BUDDY_MAX_ADVANCE_LV"
  },
  [1628] = {
    error_ui = 1,
    id = 1628,
    tips = "宝箱未领取",
    type = "TREASURE_BOX_NOT_EMPTY"
  },
  [1629] = {
    error_ui = 1,
    id = 1629,
    ignore_tips = 1,
    tips = "宝箱生成失败",
    type = "TREASURE_BOX_GEN_FAILD"
  },
  [1630] = {
    error_ui = 1,
    id = 1630,
    ignore_tips = 1,
    tips = "宝箱奖励不存在",
    type = "TREASURE_NOT_EXIST"
  },
  [1631] = {
    error_ui = 1,
    id = 1631,
    ignore_tips = 1,
    tips = "章节不能被选择",
    type = "CHALLENGE_CARD_CANT_CHOOSE"
  },
  [1632] = {
    error_ui = 1,
    id = 1632,
    ignore_tips = 1,
    tips = "章节库为空",
    type = "CHALLENGE_CARD_POOL_IS_EMPTY"
  },
  [1633] = {
    error_ui = 1,
    id = 1633,
    ignore_tips = 1,
    tips = "章节不存在",
    type = "CHALLENGE_CARD_NOT_FOUND"
  },
  [1634] = {
    error_ui = 1,
    id = 1634,
    ignore_tips = 1,
    tips = "环不存在",
    type = "CHALLENGE_RING_CIRCLE_NOT_FOUND"
  },
  [1635] = {
    error_ui = 1,
    id = 1635,
    ignore_tips = 1,
    tips = "章节没有被选择",
    type = "CHALLENGE_CARD_ISNT_CHOOSE"
  },
  [1636] = {
    error_ui = 1,
    id = 1636,
    ignore_tips = 1,
    tips = "章节逻辑没有执行完毕",
    type = "CHALLENGE_CARD_NOT_END"
  },
  [1637] = {
    error_ui = 1,
    id = 1637,
    ignore_tips = 1,
    tips = "挑战之环重复开始",
    type = "CHALLENGE_START_REPEATE"
  },
  [1638] = {
    error_ui = 1,
    id = 1638,
    ignore_tips = 1,
    tips = "解锁房间失败",
    type = "UNLOCK_FAIL"
  },
  [1639] = {
    error_ui = 1,
    id = 1639,
    ignore_tips = 1,
    tips = "创建房间失败",
    type = "CREATE_ROOM_FAIL"
  },
  [1640] = {
    error_ui = 1,
    id = 1640,
    ignore_tips = 1,
    tips = "房间不存在",
    type = "NOT_FIND_ROOM"
  },
  [1641] = {
    error_ui = 1,
    id = 1641,
    ignore_tips = 1,
    tips = "修改状态失败",
    type = "ROOM_CHANGE_PLAYER_STATE_FAIL"
  },
  [1642] = {
    error_ui = 1,
    id = 1642,
    ignore_tips = 1,
    tips = "已在房间内",
    type = "PLAYER_IN_ROOM"
  },
  [1643] = {
    error_ui = 1,
    id = 1643,
    ignore_tips = 1,
    tips = "房间已满人",
    type = "ROOM_PLAYER_FULL"
  },
  [1644] = {
    error_ui = 1,
    id = 1644,
    ignore_tips = 1,
    tips = "没有此玩家",
    type = "ROOM_PLAYER_NOT_FIND"
  },
  [1645] = {
    error_ui = 1,
    id = 1645,
    ignore_tips = 1,
    tips = "玩家未全部准备",
    type = "ROOM_JOINWAR_PLAYER_NOTREADY"
  },
  [1646] = {
    error_ui = 1,
    id = 1646,
    ignore_tips = 1,
    tips = "已经进入匹配",
    type = "ALREADY_MATCH"
  },
  [1647] = {
    error_ui = 1,
    id = 1647,
    ignore_tips = 1,
    tips = "匹配参数错误",
    type = "MATCH_PARAM_ERR"
  },
  [1648] = {
    error_ui = 1,
    id = 1648,
    ignore_tips = 1,
    tips = "房间有相同角色",
    type = "ROOM_HAVE_IDENTICAL_ROLE"
  },
  [1649] = {
    error_ui = 1,
    id = 1649,
    ignore_tips = 1,
    tips = "正在创建房间",
    type = "ROOM_IN_CREATE_TIME"
  },
  [1650] = {
    error_ui = 1,
    id = 1650,
    tips = "未达到活动参与等级",
    type = "ROOM_DISSATISFY_ACTY_LV"
  },
  [1651] = {
    error_ui = 1,
    id = 1651,
    ignore_tips = 1,
    tips = "章节无法解锁",
    type = "CHALLENGE_CARD_CANT_UNLOCK"
  },
  [1652] = {
    error_ui = 1,
    id = 1652,
    ignore_tips = 1,
    tips = "章节解锁重复",
    type = "CHALLENGE_CARD_UNLOCK_REPEAT"
  },
  [1653] = {
    error_ui = 1,
    id = 1653,
    tips = "不能重复使用该道具",
    type = "NO_REPEAT_USE_ITEM"
  },
  [1654] = {
    error_ui = 1,
    id = 1654,
    ignore_tips = 1,
    tips = "没有找到在匹配中的玩家",
    type = "NOT_HAVE_MATCH_PLAYER"
  },
  [1655] = {
    error_ui = 1,
    id = 1655,
    ignore_tips = 1,
    tips = "没有权限改变房间匹配状态",
    type = "ROOM_PLAYER_NOT_CHANGESTATE"
  },
  [1656] = {
    error_ui = 1,
    id = 1656,
    ignore_tips = 1,
    tips = "不在匹配中",
    type = "NO_HAS_MATCH"
  },
  [1657] = {
    error_ui = 1,
    id = 1657,
    ignore_tips = 1,
    tips = "不能添加击杀层数",
    type = "NOT_CAN_ADD_GREED_KILL"
  },
  [1658] = {
    error_ui = 1,
    id = 1658,
    ignore_tips = 1,
    tips = "不能释放这个击杀magic",
    type = "NO_HAS_GREED_KILL"
  },
  [1659] = {
    error_ui = 1,
    id = 1659,
    tips = "正在战斗中",
    type = "PLAYER_IN_WAR"
  },
  [1660] = {
    error_ui = 1,
    id = 1660,
    ignore_tips = 1,
    tips = "已锁定",
    type = "EQUIP_IN_LOCK"
  },
  [1661] = {
    error_ui = 1,
    id = 1661,
    tips = "请勿重复邀请",
    type = "INVITE_PLAYER_IN_CD"
  },
  [1662] = {
    error_ui = 1,
    id = 1662,
    tips = "没有可邀请好友",
    type = "ROOM_NO_PLAYERS_TO_INVITE"
  },
  [1663] = {
    error_ui = 1,
    id = 1663,
    ignore_tips = 1,
    tips = "无效的破坏物奖励",
    type = "BREAKABLE_ID_INVAILD"
  },
  [1664] = {
    error_ui = 1,
    id = 1664,
    ignore_tips = 1,
    tips = "获取玩家数据失败",
    type = "GET_ROOM_PLAYER_DATA_FAIL"
  },
  [1665] = {
    error_ui = 1,
    id = 1665,
    ignore_tips = 1,
    tips = "符文道具缺少数据",
    type = "RUNE2_ITEM_LACK_DATA"
  },
  [1666] = {
    error_ui = 1,
    id = 1666,
    tips = "没有该道具",
    type = "NOT_FIND_ITEM"
  },
  [1667] = {
    error_ui = 1,
    id = 1667,
    ignore_tips = 1,
    tips = "角色无法镶嵌该符文",
    type = "HERO_NOT_SET_RUNE2"
  },
  [1668] = {
    error_ui = 1,
    id = 1668,
    ignore_tips = 1,
    tips = "没有此购买项目种类",
    type = "NOT_FIND_SDKKEY_TYPE"
  },
  [1669] = {
    error_ui = 1,
    id = 1669,
    ignore_tips = 1,
    tips = "购买项目未开启",
    type = "RECHARGE_PROJECT_NOT_OPEN"
  },
  [1670] = {
    error_ui = 1,
    id = 1670,
    ignore_tips = 1,
    tips = "没有此购买项目配置",
    type = "NOT_FIND_SDKKEY_ITEM"
  },
  [1671] = {
    error_ui = 1,
    id = 1671,
    ignore_tips = 1,
    tips = "无法充值购买此礼包",
    type = "NOT_BUY_GIFT_BY_SDK"
  },
  [1672] = {
    error_ui = 1,
    id = 1672,
    tips = "未购买前置礼包",
    type = "NOT_BUY_GIFT_BY_FACINGID"
  },
  [1673] = {
    error_ui = 1,
    id = 1673,
    tips = "不在礼包购买期限内",
    type = "NOT_IN_BUY_GIFT_TIME"
  },
  [1674] = {
    error_ui = 1,
    id = 1674,
    tips = "礼包购买次数达到上限",
    type = "GIFT_BUY_CNT_IN_LIMIT"
  },
  [1675] = {
    error_ui = 1,
    id = 1675,
    tips = "名字包含敏感字符",
    type = "NAME_CONTAIN_SENSITIVE_WORD"
  },
  [1676] = {
    error_ui = 1,
    id = 1676,
    tips = "含有不合法的内容",
    type = "ILLEGAL_CONTENT"
  },
  [1677] = {
    error_ui = 1,
    id = 1677,
    tips = "服务器繁忙，请稍后再试",
    type = "SERVER_IS_BUSY"
  },
  [1678] = {
    error_ui = 1,
    id = 1678,
    ignore_tips = 1,
    tips = "不存在该购买项",
    type = "NOT_FIND_SDKKEY_ID"
  },
  [1679] = {
    error_ui = 1,
    id = 1679,
    ignore_tips = 1,
    tips = "非法字符",
    type = "INVALID_WORD"
  },
  [1680] = {
    error_ui = 1,
    id = 1680,
    tips = "该礼包无法购买",
    type = "BUY_GIFT_NEED_BY_SDK"
  },
  [1681] = {
    error_ui = 1,
    id = 1681,
    tips = "补给差分机生效天数已达上限",
    type = "MONTHLY_CARD_DAY_LIMIT"
  },
  [1682] = {
    error_ui = 1,
    id = 1682,
    tips = "没有可领取的奖励",
    type = "NOT_FIND_RECEIVE_REWARD"
  },
  [1683] = {
    error_ui = 1,
    id = 1683,
    ignore_tips = 1,
    tips = "当前角色未镶嵌符文",
    type = "HERO_NOT_FIND_RUNE2_DATA"
  },
  [1684] = {
    error_ui = 1,
    id = 1684,
    ignore_tips = 1,
    tips = "缺失相关铸造信息",
    type = "NOT_FIND_RUNE2_CAST_DATA"
  },
  [1685] = {
    error_ui = 1,
    id = 1685,
    tips = "角色语音尚未解锁",
    type = "BUDDY_VOICE_NOT_UNLOCK"
  },
  [1686] = {
    error_ui = 1,
    id = 1686,
    ignore_tips = 1,
    tips = "角色语音重复解锁",
    type = "BUDDY_VOICE_IS_UNLOCKED"
  },
  [1687] = {
    error_ui = 1,
    id = 1687,
    ignore_tips = 1,
    tips = "缺少符文道具来源",
    type = "NOT_FIND_RUNE2_SOURCE"
  },
  [1688] = {
    error_ui = 1,
    id = 1688,
    tips = "已退出账号，请重新登陆",
    type = "TICKET_TIMEOUT"
  },
  [1689] = {
    error_ui = 1,
    id = 1689,
    tips = "黑名单人数已达上限",
    type = "BLACKLIST_NUM_LIMIT"
  },
  [1690] = {
    error_ui = 1,
    id = 1690,
    tips = "黑名单不能对自己操作",
    type = "BLACKLIST_CANT_OPERATE_ON_SELF"
  },
  [1691] = {
    error_ui = 1,
    id = 1691,
    tips = "对方不在您的黑名单中",
    type = "TARGET_NOT_IN_YOUR_BLACKLIST"
  },
  [1692] = {
    error_ui = 1,
    id = 1692,
    tips = "已经在黑名单中",
    type = "ALREADY_ON_BLACKLIST"
  },
  [1693] = {
    error_ui = 1,
    id = 1693,
    tips = "不能尝试获取自己的信息",
    type = "CANT_GET_SELF_INFO"
  },
  [1694] = {
    error_ui = 1,
    id = 1694,
    ignore_tips = 1,
    tips = "公会名长度超出限制",
    type = "GUILD_NAME_TOO_LONG"
  },
  [1695] = {
    error_ui = 1,
    id = 1695,
    ignore_tips = 1,
    tips = "公会名不能为空",
    type = "GUILD_NAME_IS_EMPTY"
  },
  [1696] = {
    error_ui = 1,
    id = 1696,
    ignore_tips = 1,
    tips = "公会理念长度超出限制",
    type = "GUILD_IDEA_TOO_LONG"
  },
  [1698] = {
    error_ui = 1,
    id = 1698,
    ignore_tips = 1,
    tips = "已拥有公会",
    type = "OWNED_A_GUILD"
  },
  [1699] = {
    error_ui = 1,
    id = 1699,
    ignore_tips = 1,
    tips = "公会名重复",
    type = "GUILD_NAME_CONFLICT"
  },
  [1700] = {
    error_ui = 1,
    id = 1700,
    ignore_tips = 1,
    tips = "公会创建失败",
    type = "GUILD_CREATE_FAILED"
  },
  [1701] = {
    error_ui = 1,
    id = 1701,
    ignore_tips = 1,
    tips = "尚未加入公会",
    type = "ISNOT_IN_A_GUILD"
  },
  [1702] = {
    error_ui = 1,
    id = 1702,
    ignore_tips = 1,
    tips = "玩家不在公会中",
    type = "ROLE_NOT_IN_GUILD"
  },
  [1703] = {
    error_ui = 1,
    id = 1703,
    ignore_tips = 1,
    tips = "请勿重复申请",
    type = "ALREADY_APPLIED"
  },
  [1704] = {
    error_ui = 1,
    id = 1704,
    ignore_tips = 1,
    tips = "公会人数已满",
    type = "GUILD_MEMBER_NUM_LIMIT"
  },
  [1705] = {
    error_ui = 1,
    id = 1705,
    ignore_tips = 1,
    tips = "公会申请不存在",
    type = "GUILD_APPLY_NOEXIST"
  },
  [1706] = {
    error_ui = 1,
    id = 1706,
    ignore_tips = 1,
    tips = "权限不足",
    type = "PERMISSION_DENIED"
  },
  [1707] = {
    error_ui = 1,
    id = 1707,
    ignore_tips = 1,
    tips = "不能踢出自己",
    type = "CANT_KICKOUT_YOURSELF"
  },
  [1708] = {
    error_ui = 1,
    id = 1708,
    ignore_tips = 1,
    tips = "请先转让会长后退出",
    type = "GUILD_ISNOT_EMPTY"
  },
  [1709] = {
    error_ui = 1,
    id = 1709,
    ignore_tips = 1,
    tips = "公会操作处于CD中",
    type = "GUILD_OPERATION_IN_CD"
  },
  [1710] = {
    error_ui = 1,
    id = 1710,
    ignore_tips = 1,
    tips = "洗练已达到最高等级",
    type = "BUDDY_REFINE_MAX_GRADE"
  },
  [1711] = {
    error_ui = 1,
    id = 1711,
    ignore_tips = 1,
    tips = "洗练未满足等级限制",
    type = "REFINE_UPGRADE_NOT_SATISFY_CFG_LV"
  },
  [1712] = {
    error_ui = 1,
    id = 1712,
    ignore_tips = 1,
    tips = "洗练等级未达到要求",
    type = "BUDDY_REFINE_NOT_MAX_GRADE"
  },
  [1713] = {
    error_ui = 1,
    id = 1713,
    ignore_tips = 1,
    tips = "邀请已过期",
    type = "INVITATION_EXPIRE"
  },
  [1714] = {
    error_ui = 1,
    id = 1714,
    ignore_tips = 1,
    tips = "公会名字包含敏感字符",
    type = "GUILD_NAME_CONTAIN_SENSITIVE_WORD"
  },
  [1715] = {
    error_ui = 1,
    id = 1715,
    ignore_tips = 1,
    tips = "公会理念包含敏感字符",
    type = "GUILD_IDEA_CONTAIN_SENSITIVE_WORD"
  },
  [1716] = {
    error_ui = 1,
    id = 1716,
    ignore_tips = 1,
    tips = "特权已解锁",
    type = "INFINITE_PRIVILEGE_OPENED"
  },
  [1717] = {
    error_ui = 1,
    id = 1717,
    ignore_tips = 1,
    tips = "前置特权未解锁",
    type = "INFINITE_PRIVILEGE_PRE_NOT_OPEN"
  },
  [1718] = {
    error_ui = 1,
    id = 1718,
    ignore_tips = 1,
    tips = "玩家已有公会",
    type = "SEARCH_PLAYER_HAS_GUILD"
  },
  [1719] = {
    error_ui = 1,
    id = 1719,
    ignore_tips = 1,
    tips = "找不到玩家",
    type = "CANNOT_FIND_PLAYER"
  },
  [1720] = {
    error_ui = 1,
    id = 1720,
    tips = "magic效果不允许释放",
    type = "MAGIC_NOT_ALLOW"
  },
  [1721] = {
    error_ui = 1,
    id = 1721,
    tips = "对方好友数量已达上限",
    type = "OTHERSIDE_FRIEND_NUM_LIMIT"
  },
  [1722] = {
    error_ui = 1,
    id = 1722,
    tips = "输入内容包含敏感词，请修改",
    type = "CONTENT_SENSITIVE_WORD"
  },
  [1723] = {
    error_ui = 1,
    id = 1723,
    ignore_tips = 1,
    tips = "该关卡不支持复活到上个房间",
    type = "NOT_TOWER_TP_REVIVE_ROOM"
  },
  [1724] = {
    error_ui = 1,
    id = 1724,
    tips = "已达该抽卡每日上限",
    type = "DRAW_GROUP_DAY_LIMIT"
  },
  [1725] = {
    error_ui = 1,
    id = 1725,
    tips = "恢复次数达上限",
    type = "CURSE_RESTORE_CNT_LIMIT"
  },
  [1726] = {
    error_ui = 1,
    id = 1726,
    tips = "诅咒值不值",
    type = "CURSE_VALUE_LIMIT"
  },
  [1727] = {
    error_ui = 1,
    id = 1727,
    tips = "商品不存在",
    type = "CURSE_GOODS_NOT_FOUND"
  },
  [1728] = {
    error_ui = 1,
    id = 1728,
    tips = "商品已售罄",
    type = "CURSE_GOODS_HAD_BUY"
  },
  [1729] = {
    error_ui = 0,
    id = 1729,
    tips = "逃跑失败",
    type = "CURSE_SKIP_CARD_FAILED"
  },
  [1730] = {
    error_ui = 1,
    id = 1730,
    ignore_tips = 1,
    tips = "章节不存在",
    type = "CURSE_CARD_NOT_FOUND"
  },
  [1731] = {
    error_ui = 1,
    id = 1731,
    ignore_tips = 1,
    tips = "章节类型不匹配",
    type = "CURSE_CARD_TYPE_ERR"
  },
  [1732] = {
    error_ui = 0,
    id = 1732,
    ignore_tips = 1,
    tips = "章节功能非法",
    type = "CURSE_CARD_FUNC_ERR"
  },
  [1733] = {
    error_ui = 1,
    id = 1733,
    tips = "当前章节未完成",
    type = "CURSE_HAD_CARD"
  },
  [1734] = {
    error_ui = 1,
    id = 1734,
    ignore_tips = 1,
    tips = "章节不可操作",
    type = "CURSE_CARD_POS_ERR"
  },
  [1735] = {
    error_ui = 1,
    id = 1735,
    ignore_tips = 1,
    tips = "服务器功能测试中",
    type = "SERVER_TESTING"
  },
  [1736] = {
    error_ui = 1,
    id = 1736,
    ignore_tips = 1,
    tips = "章节索引错误",
    type = "CURSE_CARD_INDEX_ERR"
  },
  [1737] = {
    error_ui = 0,
    id = 1737,
    tips = "有未完成的章节",
    type = "CURSE_CARD_NOT_FINISHED"
  },
  [1738] = {
    error_ui = 1,
    id = 1738,
    tips = "网络异常，请尝试重新登录",
    type = "LOBBY_NETWORK_ERR"
  },
  [1739] = {
    error_ui = 1,
    id = 1739,
    tips = "网络异常，正在返回主界面",
    type = "BATTLE_NETWORK_ERR"
  },
  [1740] = {
    error_ui = 1,
    id = 1740,
    ignore_tips = 1,
    tips = "缺少活动选择奖励配置",
    type = "LACK_ACTY_CHOOSE_REWARD_CONFIG"
  },
  [1741] = {
    error_ui = 1,
    id = 1741,
    ignore_tips = 1,
    tips = "未进入结算流程",
    type = "CHOOSE_REWARD_NOT_ENABLED"
  },
  [1742] = {
    error_ui = 1,
    id = 1742,
    ignore_tips = 1,
    tips = "已进入战斗结算选择奖励阶段",
    type = "IN_CHOOSE_REWARD_STATUS"
  },
  [1743] = {
    error_ui = 1,
    id = 1743,
    tips = "账号已被封禁",
    type = "PLAYER_IN_BAN_STATUS"
  },
  [1744] = {
    error_ui = 1,
    id = 1744,
    ignore_tips = 1,
    tips = "角色符文等级已达上线",
    type = "BUDDY_RUNE_GRADE_MAX"
  },
  [1745] = {
    error_ui = 1,
    id = 1745,
    tips = "角色并未被封禁",
    type = "ROLE_NOT_IN_BAN_STATUS"
  },
  [1746] = {
    error_ui = 1,
    id = 1746,
    tips = "道具合成数量为空",
    type = "COMBINE_NUM_EMPTY"
  },
  [1747] = {
    error_ui = 1,
    id = 1747,
    ignore_tips = 1,
    tips = "缺少奇珍道具来源",
    type = "NOT_FIND_ORNAMENTS_SOURCE"
  },
  [1748] = {
    error_ui = 1,
    id = 1748,
    tips = "无法领取此星级奖励",
    type = "NOT_RECEIVA_STAR_REWARD"
  },
  [1749] = {
    error_ui = 1,
    id = 1749,
    tips = "关卡未解锁",
    type = "EPI_IN_LOCK_STATUS"
  },
  [1750] = {
    error_ui = 0,
    id = 1750,
    tips = "输入内容包含敏感词",
    type = "CONTENT_SENSITIVE_WORD_IN_PLAY_STORY"
  },
  [1751] = {
    error_ui = 1,
    id = 1751,
    ignore_tips = 1,
    tips = "该NPC不支持购买行为",
    type = "NPC_IS_NOT_SHOP_TYPE"
  },
  [1752] = {
    error_ui = 1,
    id = 1752,
    ignore_tips = 1,
    tips = "商品不存在",
    type = "NPC_GOODS_NOT_FOUND"
  },
  [1753] = {
    error_ui = 1,
    id = 1753,
    tips = "商品已售罄",
    type = "NPC_GOODS_HAD_BUY"
  },
  [1754] = {
    error_ui = 1,
    id = 1754,
    ignore_tips = 1,
    tips = "该关卡无法适用回存档点复活方式",
    type = "EPI_NOT_TP_REVIVE"
  },
  [1755] = {
    error_ui = 1,
    id = 1755,
    tips = "已准备此奇珍",
    type = "HAVE_ORNAMENTS_ITEMS"
  },
  [1756] = {
    error_ui = 1,
    id = 1756,
    tips = "成就组进度奖励已领取",
    type = "ACHIEVEMENT_GROUNP_AWARD_REPLACE"
  },
  [1757] = {
    error_ui = 1,
    id = 1757,
    tips = "成就组无进度奖励",
    type = "ACHIEVEMENT_GROUNP_NOT_AWARD"
  },
  [1758] = {
    error_ui = 1,
    id = 1758,
    tips = "成就组进度未完成",
    type = "ACHIEVEMENT_GROUNP_NOT_COMPLETE"
  },
  [1759] = {
    error_ui = 1,
    id = 1759,
    tips = "该称号已激活",
    type = "TITLE_ALREADY_ACTIVATED"
  },
  [1760] = {
    error_ui = 1,
    id = 1760,
    tips = "已获取高等级称号",
    type = "TITLE_GAINED_HIGHER"
  },
  [1761] = {
    error_ui = 1,
    id = 1761,
    tips = "称号未激活",
    type = "TITLE_ALREADY_NOT_ACTIVATED"
  },
  [1762] = {
    error_ui = 1,
    id = 1762,
    tips = "称号使用中",
    type = "TITLE_ALREADY_USING"
  },
  [1763] = {
    error_ui = 1,
    id = 1763,
    tips = "未开放注册",
    type = "NOT_ALLOW_CREATE_ROLE"
  },
  [1764] = {
    error_ui = 1,
    id = 1764,
    tips = "物品不可回复",
    type = "ITEM_NOT_RECOVER"
  },
  [1765] = {
    error_ui = 1,
    id = 1765,
    tips = "已达回复上限",
    type = "ITEM_RECOVER_NOT_ACTIVE"
  },
  [1766] = {
    error_ui = 1,
    id = 1766,
    ignore_tips = 1,
    tips = "进度任务不存在",
    type = "ACHIEVEMENT_PROGRESS_TASK_NOT_FOUND"
  },
  [1767] = {
    error_ui = 1,
    id = 1767,
    tips = "称号未穿戴",
    type = "TITLE_NOT_USING"
  },
  [1768] = {
    error_ui = 1,
    id = 1768,
    ignore_tips = 1,
    tips = "获取公会在线人数失败",
    type = "GUILD_NOT_GET_ONLINE_NUM"
  },
  [1769] = {
    error_ui = 1,
    id = 1769,
    tips = "物品不可合成",
    type = "ITEM_CANNOT_COMBIME"
  },
  [1770] = {
    error_ui = 1,
    id = 1770,
    ignore_tips = 1,
    tips = "地图传送功能已被禁用",
    type = "TP_ROOM_BY_MAP_IN_BAN"
  },
  [1771] = {
    error_ui = 1,
    id = 1771,
    ignore_tips = 1,
    tips = "该房间无法使用地图传送",
    type = "IN_ROOM_NOT_TP_BY_MAP"
  },
  [1772] = {
    error_ui = 1,
    id = 1772,
    ignore_tips = 1,
    tips = "目的房间无法通过小地图传送",
    type = "ROOM_NOT_TP_BY_MAP"
  },
  [1773] = {
    error_ui = 1,
    id = 1773,
    ignore_tips = 1,
    tips = "地图传送只适用于同一层",
    type = "MAP_TP_IN_IDENTICAL_FLOOR"
  },
  [1774] = {
    error_ui = 1,
    id = 1774,
    ignore_tips = 1,
    tips = "超过预设符文数量",
    type = "EXCEED_WEEK_ACTY_BUDDY_RUNE_SET_DATA"
  },
  [1775] = {
    error_ui = 1,
    id = 1775,
    ignore_tips = 1,
    tips = "非主线章节不可保存",
    type = "NOT_CHAPTER"
  },
  [1776] = {
    error_ui = 1,
    id = 1776,
    tips = "当前节点未通关",
    type = "CHAPTER_NODE_NOT_PASS"
  },
  [1777] = {
    error_ui = 1,
    id = 1777,
    tips = "当前节点已保存",
    type = "CHAPTER_NODE_SETTLED"
  },
  [1778] = {
    error_ui = 1,
    id = 1778,
    tips = "前置关卡未完成",
    type = "FRONT_EPISODE_NOT_FINISH"
  },
  [1779] = {
    error_ui = 1,
    id = 1779,
    tips = "未达到指定星级",
    type = "NOT_ACHIEVE_EPI_STAT"
  },
  [1780] = {
    error_ui = 1,
    id = 1780,
    tips = "章节节点未解锁",
    type = "CHAPTER_NODE_LOCK"
  },
  [1781] = {
    error_ui = 1,
    id = 1781,
    ignore_tips = 1,
    tips = "支线任务不存在",
    type = "NOT_BRANCH_TASK"
  },
  [1782] = {
    error_ui = 1,
    id = 1782,
    ignore_tips = 1,
    tips = "节点结算失败",
    type = "SETTLEMENT_NODE_FAIL"
  },
  [1783] = {
    error_ui = 1,
    id = 1783,
    ignore_tips = 1,
    tips = "尚未解锁PVP玩法",
    type = "WEEK_ACTY_PVP_LOCK"
  },
  [1784] = {
    error_ui = 1,
    id = 1784,
    ignore_tips = 1,
    tips = "请勿重复参加PVP玩法",
    type = "PARTICIPATE_WEEK_ACTY_PVP"
  },
  [1785] = {
    error_ui = 1,
    id = 1785,
    tips = "玩法尚未开放",
    type = "WEEK_ACTY_PVP_NOT_OPEN"
  },
  [1786] = {
    error_ui = 1,
    id = 1786,
    tips = "活动已结束，等待结算",
    type = "WEEK_ACTY_PVP_IN_END"
  },
  [1787] = {
    error_ui = 1,
    id = 1787,
    tips = "尚未开启该阶段",
    type = "WEEK_ACTY_PVP_STAGE_NOT_OPEN"
  },
  [1788] = {
    error_ui = 1,
    id = 1788,
    ignore_tips = 1,
    tips = "符文预设重复",
    type = "RUNE_SET_UP_REPEAT"
  },
  [1789] = {
    error_ui = 1,
    id = 1789,
    ignore_tips = 1,
    tips = "一个角色只能设置一种符文",
    type = "BUDDY_SET_ONE_RUNE"
  },
  [1790] = {
    error_ui = 1,
    id = 1790,
    ignore_tips = 1,
    tips = "排行版不存在",
    type = "RANK_OBJECT_NOT_FOUND"
  },
  [1791] = {
    error_ui = 1,
    id = 1791,
    ignore_tips = 1,
    tips = "PVP段位不存在",
    type = "PVP_SEGEMTN_NOT_FIND"
  },
  [1792] = {
    error_ui = 1,
    id = 1792,
    tips = "名片未激活",
    type = "BUSSINESS_CARD_NOT_ACTIVE"
  },
  [1793] = {
    error_ui = 1,
    id = 1793,
    tips = "名片未穿戴",
    type = "BUSSINESS_CARD_NOT_WEAR"
  },
  [1794] = {
    error_ui = 1,
    id = 1794,
    ignore_tips = 1,
    tips = "未发现改段位池子",
    type = "PVP_SEGMENT_POND_NOT_FOUND"
  },
  [1795] = {
    error_ui = 1,
    id = 1795,
    ignore_tips = 1,
    tips = "未发现玩家段位池子",
    type = "PVP_SEGMENT_POND_NOT_PLAYER"
  },
  [1796] = {
    error_ui = 1,
    id = 1796,
    ignore_tips = 1,
    tips = "任务不存在",
    type = "TASK_NOT_FOUND"
  },
  [1797] = {
    error_ui = 1,
    id = 1797,
    tips = "请勿重复领取任务奖励",
    type = "TASK_GET_REWARD"
  },
  [1798] = {
    error_ui = 1,
    id = 1798,
    tips = "角色重复上阵",
    type = "WEEK_ACTY_BUDDY_REPEAT"
  },
  [1799] = {
    error_ui = 1,
    id = 1799,
    tips = "已经结算",
    type = "CHAPTER_SETTLEMENTED"
  },
  [1800] = {
    error_ui = 1,
    id = 1800,
    ignore_tips = 1,
    tips = "非剧情节点",
    type = "NOT_IS_STORE"
  },
  [1801] = {
    error_ui = 1,
    id = 1801,
    tips = "通关后可重复挑战",
    type = "TOWER_CUR_FLOOR_NOT_PASS"
  },
  [1802] = {
    error_ui = 1,
    id = 1802,
    ignore_tips = 1,
    tips = "该材料副本不支持自选掉落",
    type = "MATERIAL_NOT_CHOOSE_DROP"
  },
  [1803] = {
    error_ui = 1,
    id = 1803,
    ignore_tips = 1,
    tips = "未处于副本自选时间内",
    type = "MATERIAL_DAY_NOT_CHOOSE_DROP"
  },
  [1804] = {
    error_ui = 1,
    id = 1804,
    tips = "宝箱不可领取",
    type = "TREASURE_NOT_FINISH"
  },
  [1805] = {
    error_ui = 1,
    id = 1805,
    ignore_tips = 1,
    tips = "角色重复登场",
    type = "HERO_ALREADY_GOOUT"
  },
  [1806] = {
    error_ui = 1,
    id = 1806,
    tips = "当前关卡不允许设置助战角色",
    type = "EPISODE_NOT_SET_ASSIST_BUDDY"
  },
  [1807] = {
    error_ui = 1,
    id = 1807,
    tips = "助战元素未发现",
    type = "ASSIST_ELEMENT_NOT_FOUND"
  },
  [1808] = {
    error_ui = 1,
    id = 1808,
    tips = "助战角色未发现",
    type = "ASSIST_BUDDY_INDEX"
  },
  [1809] = {
    error_ui = 1,
    id = 1809,
    tips = "已达到陌生人助战次数上限",
    type = "STRANGER_HELP_CNT_LIMIT"
  },
  [1810] = {
    error_ui = 1,
    id = 1810,
    tips = "助战刷新CD中",
    type = "ASSIST_BUDDY_RESHRESH_IN_CD"
  },
  [1811] = {
    error_ui = 1,
    id = 1811,
    tips = "未获得好友赠送礼物",
    type = "FRIEND_PRESENT_REWARD_NOT_FOUND"
  },
  [1812] = {
    error_ui = 1,
    id = 1812,
    tips = "领取好友赠送礼物达到每日上限",
    type = "GET_FRIEND_PRESENT_REWARD_DAY_LIMIT"
  },
  [1813] = {
    error_ui = 1,
    id = 1813,
    tips = "已达每日赠送好友次数上限",
    type = "REPEAT_SEND_FRIEND_REWARD"
  },
  [1814] = {
    error_ui = 1,
    id = 1814,
    ignore_tips = 1,
    tips = "非长主线",
    type = "NOT_LONG_CHAPTER"
  },
  [1815] = {
    error_ui = 1,
    id = 1815,
    tips = "技能等级已到满级",
    type = "SKILL_MAX_LEVEL"
  },
  [1816] = {
    error_ui = 1,
    id = 1816,
    tips = "玩家数据异常,请联系客服",
    type = "PLAYER_DATA_ERR"
  },
  [1817] = {
    error_ui = 1,
    id = 1817,
    ignore_tips = 1,
    tips = "未发现该新手特权",
    type = "NEWBIE_PRIVILEGE_NOT_FOUND"
  },
  [1818] = {
    error_ui = 1,
    id = 1818,
    ignore_tips = 1,
    tips = "不在特权领奖时间内",
    type = "NOT_AT_GET_PRIVILEGE_REWARD_TIME"
  },
  [1819] = {
    error_ui = 1,
    id = 1819,
    tips = "该武器不能重载",
    type = "EQUIP_NOT_RESHAPE"
  },
  [1820] = {
    error_ui = 1,
    id = 1820,
    tips = "不在新手特权期间内",
    type = "NOT_IN_NEW_BIE_PRIVILEGE"
  },
  [1821] = {
    error_ui = 1,
    id = 1821,
    tips = "无法购买新手特权礼包",
    type = "NOT_BUT_NEWBIE_PRIVILEGE_GIFT"
  },
  [1822] = {
    error_ui = 1,
    id = 1822,
    tips = "历程等级条件未达成",
    type = "LEVEL_COND_NOT_COMPLETE"
  },
  [1823] = {
    error_ui = 1,
    id = 1823,
    tips = "历程等级奖励已领取",
    type = "LEVEL_REWARD_GAINED"
  },
  [1824] = {
    error_ui = 1,
    id = 1824,
    tips = "无法进行倍数挑战",
    type = "CHALLENG_MULTIPLE_NOT_OPEN"
  },
  [1825] = {
    error_ui = 1,
    id = 1825,
    ignore_tips = 1,
    tips = "挑战倍数参数错误",
    type = "CHALLENG_MULTIPLE_NOT_MATCH"
  },
  [1826] = {
    error_ui = 1,
    id = 1826,
    tips = "角色天赋已全部解锁",
    type = "BUDDY_TALENT_MAX_LV"
  },
  [1827] = {
    error_ui = 1,
    id = 1827,
    ignore_tips = 1,
    tips = "词条不存在",
    type = "RELIC_ENTRY_NOT_EXIST"
  },
  [1828] = {
    error_ui = 1,
    id = 1828,
    ignore_tips = 1,
    tips = "圣遗物不存在",
    type = "NOT_FOUND_RELIC"
  },
  [1829] = {
    error_ui = 1,
    id = 1829,
    tips = "升级消耗不能使用本体",
    type = "RELIC_UP_USE_SELF"
  },
  [1830] = {
    error_ui = 1,
    id = 1830,
    tips = "圣遗物已满级",
    type = "RELIC_ALREADY_MAX_LV"
  },
  [1831] = {
    error_ui = 1,
    id = 1831,
    tips = "未选择选篇",
    type = "NOT_CHOOSE_SECT"
  },
  [1832] = {
    error_ui = 1,
    id = 1832,
    ignore_tips = 1,
    tips = "没有此选篇",
    type = "NOT_FIND_SECT"
  },
  [1833] = {
    error_ui = 1,
    id = 1833,
    ignore_tips = 1,
    tips = "未发现该片语掉落",
    type = "NOT_FIND_ABILITY_DROP"
  },
  [1834] = {
    error_ui = 1,
    id = 1834,
    ignore_tips = 1,
    tips = "宝箱选择错误",
    type = "TREASURE_CHEST_SELECT_ERROR"
  },
  [1835] = {
    error_ui = 1,
    id = 1835,
    tips = "材料副本今日未开启",
    type = "MATERIAL_NOT_OPEN"
  },
  [1836] = {
    error_ui = 1,
    id = 1836,
    ignore_tips = 1,
    tips = "没有此中台事件",
    type = "ENTRE_EVENT_NOT_FIND"
  },
  [1837] = {
    error_ui = 1,
    id = 1837,
    tips = "无法领取事件奖励",
    type = "ENTRE_EVENT_NOT_GET_REWARD"
  },
  [1838] = {
    error_ui = 1,
    id = 1838,
    tips = "请勿重复交互",
    type = "EVENT_HAS_EACH"
  },
  [1839] = {
    error_ui = 1,
    id = 1839,
    ignore_tips = 1,
    tips = "该任务无法通过此途径交付",
    type = "GET_EVENT_NOT_BY_WAY"
  },
  [1840] = {
    error_ui = 1,
    id = 1840,
    tips = "活动已结束",
    type = "ACTIVITY_END"
  },
  [1841] = {
    error_ui = 1,
    id = 1841,
    tips = "活动任务未完成",
    type = "ACTIVITY_TASK_NO_DONE"
  },
  [1842] = {
    error_ui = 1,
    id = 1842,
    tips = "活动任务奖励已领取",
    type = "ACTIVITY_AWARD_GAINED"
  },
  [1843] = {
    error_ui = 1,
    id = 1843,
    ignore_tips = 1,
    tips = "词条洗练错误",
    type = "RELIC_ENTRY_REFLUSH_ERROR"
  },
  [1844] = {
    error_ui = 1,
    id = 1844,
    ignore_tips = 1,
    tips = "消耗不存在",
    type = "CONSUME_NOT_EXIST"
  },
  [1845] = {
    error_ui = 1,
    id = 1845,
    ignore_tips = 1,
    tips = "词条替换错误",
    type = "RELIC_ENTRY_REPEAT_ERROR"
  },
  [1846] = {
    error_ui = 1,
    id = 1846,
    tips = "圣遗物槽位未解锁",
    type = "RELIC_SLOT_LOCK"
  },
  [1847] = {
    error_ui = 1,
    id = 1847,
    tips = "圣遗物未穿戴",
    type = "RELIC_NOT_INLAY"
  },
  [1848] = {
    error_ui = 1,
    id = 1848,
    ignore_tips = 1,
    tips = "正式环境无法是用此协议",
    type = "SPROTO_NOT_IN_PRODUCT_ENV"
  },
  [1849] = {
    error_ui = 1,
    id = 1849,
    ignore_tips = 1,
    tips = "无法使用该修整功能",
    type = "NOT_USE_RECUPERATION_FUN"
  },
  [1850] = {
    error_ui = 1,
    id = 1850,
    tips = "片语已达到最高级",
    type = "ABILITY_GRADE_IN_LINIT"
  },
  [1851] = {
    error_ui = 1,
    id = 1851,
    tips = "无法使用该牌",
    type = "CURSE_CARD_NOT_USE"
  },
  [1852] = {
    error_ui = 1,
    id = 1852,
    tips = "此修整功能已达到使用上限",
    type = "CURSE_RECUPERATION_USE_COUNT_LIMIT"
  },
  [1853] = {
    error_ui = 1,
    id = 1853,
    tips = "无法刷新",
    type = "REFRESH_ABILITY_DROP_ERROR"
  },
  [1854] = {
    error_ui = 1,
    id = 1854,
    tips = "门暂未开放",
    type = "CURSE_DOOR_NOT_OPEN"
  },
  [1855] = {
    error_ui = 1,
    id = 1855,
    tips = "请先选择想要的奖励",
    type = "FREE_CHOOSE_DRAW_NOT_USE"
  },
  [1856] = {
    error_ui = 1,
    id = 1856,
    tips = "该自选奖励暂未开放",
    type = "FREE_CHOOSE_DRAW_ID_NOT_OPEN"
  },
  [1857] = {
    error_ui = 1,
    id = 1857,
    tips = "技能已达升级上限",
    type = "SKILL_VIRTUAL_MAX_LEVEL"
  },
  [1858] = {
    error_ui = 1,
    id = 1858,
    tips = "该星级奖励已经获取",
    type = "LINEAR_GAINED"
  },
  [1859] = {
    error_ui = 1,
    id = 1859,
    tips = "未达成领取星级奖励条件",
    type = "LINEAR_STAR_NOT_ENOUGH"
  },
  [1860] = {
    error_ui = 1,
    id = 1860,
    tips = "已开启设备登陆限制，请使用首次登陆绑定设备",
    type = "SERVER_OPEN_EQUIPMENT_RESTRICTION"
  },
  [1861] = {
    error_ui = 1,
    id = 1861,
    tips = "登陆失败，请尝试重新登陆",
    type = "SDK_VERIFY_ACCOUNT_ERROR"
  },
  [1862] = {
    error_ui = 1,
    id = 1862,
    ignore_tips = 1,
    tips = "场馆已达到最大等级",
    type = "SUB_MUSEUM_MODULE_MAX_LV"
  },
  [1863] = {
    error_ui = 1,
    id = 1863,
    ignore_tips = 1,
    tips = "繁荣度等级已达到最大",
    type = "PROSPERITY_MAX_LV"
  },
  [1864] = {
    error_ui = 1,
    id = 1864,
    ignore_tips = 1,
    tips = "该馆员已达到最高等级",
    type = "ASSISTANT_MAX_LV"
  },
  [1865] = {
    error_ui = 1,
    id = 1865,
    ignore_tips = 1,
    tips = "馆员已在其他场馆上阵",
    type = "ASSISTANT_HAVE_JOB"
  },
  [1866] = {
    error_ui = 1,
    id = 1866,
    ignore_tips = 1,
    tips = "上阵位置未开放",
    type = "MUSEUM_POS_NOT_OPEN"
  },
  [1867] = {
    error_ui = 1,
    id = 1867,
    tips = "积分奖励不足",
    type = "INFINITE_SCORE_REWARD_NOT_THROUGH"
  },
  [1868] = {
    error_ui = 1,
    id = 1868,
    tips = "积分奖励不能领取",
    type = "INFINITE_SCORE_GAINED"
  },
  [1869] = {
    error_ui = 1,
    id = 1869,
    tips = "未通关，不能进行扫荡",
    type = "INFINITE_SCORE_LESS"
  },
  [1870] = {
    error_ui = 1,
    id = 1870,
    tips = "词条必选项未选择",
    type = "INFINITE_MAST_ENTRY_NOT_SELECT"
  },
  [1871] = {
    error_ui = 1,
    id = 1871,
    ignore_tips = 1,
    tips = "选择词条组错误",
    type = "INFINITE_GROUP_NOT_FOUND"
  },
  [1872] = {
    error_ui = 1,
    id = 1872,
    ignore_tips = 1,
    tips = "词条未找到",
    type = "INFINITE_ENTRY_NOT_FOUND"
  },
  [1873] = {
    error_ui = 1,
    id = 1873,
    tips = "重复选择词条组",
    type = "INFINITE_GROUP_REPEAT"
  },
  [1874] = {
    error_ui = 1,
    id = 1874,
    tips = "无尽副本未开启",
    type = "INFINITE_NOT_OPEN"
  },
  [1875] = {
    error_ui = 1,
    id = 1875,
    tips = "进入副本未选择词条",
    type = "INFINITE_NOT_SELECT_OPTION"
  },
  [1876] = {
    error_ui = 1,
    id = 1876,
    ignore_tips = 1,
    tips = "副本对应选项组错误",
    type = "INFINITE_SELECT_OPTION_ERROR"
  },
  [1877] = {
    error_ui = 1,
    id = 1877,
    ignore_tips = 1,
    tips = "未开放扫荡功能",
    type = "NOT_OPEN_SWEEP"
  },
  [1878] = {
    error_ui = 1,
    id = 1878,
    tips = "尚未解锁此制作内容",
    type = "MUSEUM_MAKE_FORMULA_NOT_OPEN"
  },
  [1879] = {
    error_ui = 1,
    id = 1879,
    tips = "展馆位置未解锁",
    type = "SUB_MODULE_SHOW_CASE_NOT_OPEN"
  },
  [1880] = {
    error_ui = 1,
    id = 1880,
    tips = "展品已达到最大堆叠数量",
    type = "MUSEUM_EXHIBIT_COUNT_LIMIT"
  },
  [1881] = {
    error_ui = 1,
    id = 1881,
    tips = "图鉴奖励尚未激活",
    type = "MUSEUM_ACHIEVE_REWARD_NOT_OPEN"
  },
  [1882] = {
    error_ui = 1,
    id = 1882,
    tips = "该展柜无法放置此展品",
    type = "CASE_WITH_EXHIBIT_TYPE_NOT_MATA"
  },
  [1883] = {
    error_ui = 1,
    id = 1883,
    tips = "工厂已达到最大等级",
    type = "MUSEUM_FACTORY_MAX_LV"
  },
  [1884] = {
    error_ui = 1,
    id = 1884,
    ignore_tips = 1,
    tips = "包体信息错误",
    type = "SDK_VERIFY_DEVICE_ERROR"
  },
  [1885] = {
    error_ui = 1,
    id = 1885,
    ignore_tips = 1,
    tips = "pvp模式无法使用助战角色",
    type = "WEEK_ACTY_PVP_NOT_USE_ASSISTANT"
  },
  [1886] = {
    error_ui = 1,
    id = 1886,
    tips = "编队信息改变",
    type = "USE_NOT_IN_SETTING_BUDDY"
  },
  [1887] = {
    error_ui = 1,
    id = 1887,
    tips = "阵容已锁定",
    type = "FORMATION_IS_LOCK"
  },
  [1888] = {
    error_ui = 1,
    id = 1888,
    tips = "未锁定阵容",
    type = "NOT_SETTING_FORMATION"
  },
  [1889] = {
    error_ui = 1,
    id = 1889,
    tips = "本源未找到",
    type = "NOT_FOUND_GEMSTONE"
  },
  [1890] = {
    error_ui = 1,
    id = 1890,
    ignore_tips = 1,
    tips = "无效消耗",
    type = "NOT_FOUND_GEMSTONE_CONSUME"
  },
  [1891] = {
    error_ui = 1,
    id = 1891,
    tips = "已达最大等级",
    type = "GEMSTONE_MAX_LEVEL"
  },
  [1892] = {
    error_ui = 1,
    id = 1892,
    ignore_tips = 1,
    tips = "升级错误",
    type = "GEMSTONE_UP_LEVEL_ERROR"
  },
  [1893] = {
    error_ui = 1,
    id = 1893,
    tips = "纯能馈赠未开启",
    type = "BATTLE_PASS_NOT_OPEN"
  },
  [1894] = {
    error_ui = 1,
    id = 1894,
    tips = "未达到领取该奖励条件",
    type = "NOT_COMMPLE_REWARD_CONDITION"
  },
  [1895] = {
    error_ui = 1,
    id = 1895,
    ignore_tips = 1,
    tips = "战令未开启循环奖励",
    type = "BATTLE_PASS_NOT_OPEN_CIRCULATE_AWARD"
  },
  [1896] = {
    error_ui = 1,
    id = 1896,
    ignore_tips = 1,
    tips = "纯能馈赠未满级",
    type = "BATTLE_PASS_NOT_REACH_MAX_GRADE"
  },
  [1897] = {
    error_ui = 1,
    id = 1897,
    tips = "已激活无穷演算",
    type = "HAVE_BUY_SENIOR_BATTLE_PASS"
  },
  [1898] = {
    error_ui = 1,
    id = 1898,
    tips = "无法购买此商品",
    type = "NOT_BUY_SHOPPING"
  },
  [1899] = {
    error_ui = 1,
    id = 1899,
    tips = "购买等级超过限制",
    type = "BUY_BATTLE_PASS_LIMIT_GRADE"
  },
  [1900] = {
    error_ui = 1,
    id = 1900,
    ignore_tips = 1,
    tips = "宝石槽位未解锁",
    type = "GEMSTONE_LOCK"
  },
  [1901] = {
    error_ui = 1,
    id = 1901,
    ignore_tips = 1,
    tips = "无效槽位",
    type = "GEMSTONE_SLOT_NOT_FOUND"
  },
  [1902] = {
    error_ui = 1,
    id = 1902,
    ignore_tips = 1,
    tips = "不可同时装配同名本源",
    type = "GEMSTONE_REPEAT_EQUIP"
  },
  [1903] = {
    error_ui = 1,
    id = 1903,
    tips = "该元素暂未开启刷新",
    type = "ASSIST_FIGHT_ELEMENT_NOT_PUSH"
  },
  [1904] = {
    error_ui = 1,
    id = 1904,
    tips = "不存在替换词条",
    type = "NOT_FOUND_FLUSH_ENTRY"
  },
  [1905] = {
    error_ui = 1,
    id = 1905,
    tips = "此渠道无法登陆该服务器",
    type = "PLATFORM_NOT_LOGIN_SERVER"
  },
  [1906] = {
    error_ui = 1,
    id = 1906,
    tips = "未找到战斗编队",
    type = "NOT_FOUNT_FIGHT_TEAM"
  },
  [1907] = {
    error_ui = 1,
    id = 1907,
    tips = "关卡专属角色未上阵",
    type = "FIXED_BUDDY_NOT_EXIST_TEAM"
  },
  [1908] = {
    error_ui = 1,
    id = 1908,
    ignore_tips = 1,
    tips = "使用预期外上阵位置",
    type = "MASK_USE_FORCE_MAIN_POS"
  },
  [1909] = {
    error_ui = 1,
    id = 1909,
    ignore_tips = 1,
    tips = "使用关卡禁用角色",
    type = "USE_BANED_BUDDY"
  },
  [1910] = {
    error_ui = 1,
    id = 1910,
    ignore_tips = 1,
    tips = "使用关卡禁用位置",
    type = "USE_BANED_POS"
  },
  [1911] = {
    error_ui = 1,
    id = 1911,
    ignore_tips = 1,
    tips = "使用无效自定义角色",
    type = "INVAILD_FIXED_BUDDY"
  },
  [1912] = {
    error_ui = 1,
    id = 1912,
    ignore_tips = 1,
    tips = "角色数据生成失败",
    type = "FIGHT_TEAM_BUDDY_NOT_EXIST"
  },
  [1913] = {
    error_ui = 1,
    id = 1913,
    tips = "不存在该预制编队",
    type = "PREFAB_TEAM_ID_ERROR"
  },
  [1914] = {
    error_ui = 1,
    id = 1914,
    ignore_tips = 1,
    tips = "无效预制编队名称",
    type = "PREFAB_TEAM_NAME_ERROR"
  },
  [1915] = {
    error_ui = 1,
    id = 1915,
    tips = "编队成员超出上限",
    type = "PREFAB_TEASM_SIZE_ERROR"
  },
  [1916] = {
    error_ui = 1,
    id = 1916,
    ignore_tips = 1,
    tips = "编队角色不存在",
    type = "TEAM_BUDDY_NOT_EXIST"
  },
  [1917] = {
    error_ui = 1,
    id = 1917,
    ignore_tips = 1,
    tips = "编队使用重复角色",
    type = "TEAM_REPEAT_BUDDY"
  },
  [1918] = {
    error_ui = 1,
    id = 1918,
    ignore_tips = 1,
    tips = "编队未使用首发",
    type = "PREFAB_TEASM_MAIN_POS_NOT_EXIST"
  },
  [1919] = {
    error_ui = 1,
    id = 1919,
    ignore_tips = 1,
    tips = "战斗编队不存在",
    type = "FIGHT_TEAM_NOT_EXIST"
  },
  [1920] = {
    error_ui = 1,
    id = 1920,
    ignore_tips = 1,
    tips = "编队角色未获得",
    type = "TEAM_BUDDY_NOT_GAINED"
  },
  [1921] = {
    error_ui = 1,
    id = 1921,
    ignore_tips = 1,
    tips = "助战角色位置错误",
    type = "HELP_FIGHT_POS_ERROR"
  },
  [1922] = {
    error_ui = 1,
    id = 1922,
    ignore_tips = 1,
    tips = "助战角色错误",
    type = "HELP_FIGHT_BUDDY_ERROR"
  },
  [1923] = {
    error_ui = 1,
    id = 1923,
    tips = "奖励条件未达成",
    type = "DRAW_SELECT_CONDITION_ERROR"
  },
  [1924] = {
    error_ui = 1,
    id = 1924,
    ignore_tips = 1,
    tips = "选择角色错误",
    type = "DRAW_SELECT_ERROR"
  },
  [1925] = {
    error_ui = 1,
    id = 1925,
    tips = "奖励已经获取",
    type = "DRAW_SELECT_REWARD_GAINED"
  },
  [1926] = {
    error_ui = 1,
    id = 1926,
    tips = "该材料本未开启扫荡",
    type = "MATERIAL_NOT_SWEEP"
  },
  [1927] = {
    error_ui = 1,
    id = 1927,
    ignore_tips = 1,
    tips = "材料本选择错误",
    type = "MATERIAL_DROP_ERROR"
  },
  [1928] = {
    error_ui = 1,
    id = 1928,
    tips = "选择难度尚未解锁",
    type = "PVP_SEGMENT_NOT_OPEN"
  },
  [1929] = {
    error_ui = 1,
    id = 1929,
    ignore_tips = 1,
    tips = "缺少段位信息",
    type = "PVP_NOT_LACK_SEGMENT"
  },
  [1930] = {
    error_ui = 1,
    id = 1930,
    ignore_tips = 1,
    tips = "更改段位次数已到达最大值",
    type = "PVP_CHANGE_SEGMENT_CNT_LIMIT"
  },
  [1931] = {
    error_ui = 1,
    id = 1931,
    tips = "未装配",
    type = "PUZZLE_NOT_PLACE_IN"
  },
  [1932] = {
    error_ui = 1,
    id = 1932,
    ignore_tips = 1,
    tips = "取消装配失败",
    type = "PUZZLE_PLACE_OUT_ERROR"
  },
  [1933] = {
    error_ui = 1,
    id = 1933,
    ignore_tips = 1,
    tips = "分解错误",
    type = "PUZZLE_DECOMPOSE_ERROR"
  },
  [1934] = {
    error_ui = 1,
    id = 1934,
    ignore_tips = 1,
    tips = "装配失败",
    type = "PUZZLE_PLACE_IN_ERROR"
  },
  [1935] = {
    error_ui = 1,
    id = 1935,
    ignore_tips = 1,
    tips = "升级品质消耗未找到",
    type = "PUZZLE_CONSUME_NOT_FOUND"
  },
  [1936] = {
    error_ui = 1,
    id = 1936,
    ignore_tips = 1,
    tips = "消耗类型错误",
    type = "PUZZLE_CONSUME_ID_ERROR"
  },
  [1937] = {
    error_ui = 1,
    id = 1937,
    tips = "消耗不能使用本体",
    type = "PUZZLE_CONSUME_USE_SELF"
  },
  [1938] = {
    error_ui = 1,
    id = 1938,
    ignore_tips = 1,
    tips = "移除失败",
    type = "PUZZLE_DELETE_ERROR"
  },
  [1939] = {
    error_ui = 1,
    id = 1939,
    tips = "当前商店未开启",
    type = "CURSE_SHOP_SLOT_NOT_OPNE"
  },
  [1940] = {
    error_ui = 1,
    id = 1940,
    tips = "无法重复购买",
    type = "CURSE_SHOP_SLOT_GOOD_BUY"
  },
  [1941] = {
    error_ui = 1,
    id = 1941,
    tips = "商店重置次数已达到上限",
    type = "CURSE_SHOP_REFRESH_CNT_LIMIT"
  },
  [1942] = {
    error_ui = 1,
    id = 1942,
    ignore_tips = 1,
    tips = "开局选项未开放",
    type = "CURSE_OPTIONS_NOT_OPEN_CHOOSE"
  },
  [1943] = {
    error_ui = 1,
    id = 1943,
    ignore_tips = 1,
    tips = "开局选项重复操作",
    type = "CURSE_REPEAT_OPTIONS_ACTION"
  },
  [1944] = {
    error_ui = 1,
    id = 1944,
    tips = "无法开启命定之匣",
    type = "CURSE_EPISODE_EPI_NOT_HAVE_DESTINY_AWARD"
  },
  [1945] = {
    error_ui = 1,
    id = 1945,
    ignore_tips = 1,
    tips = "没有后续步骤",
    type = "CURSE_RECUPERATION_LIMIT_STEP"
  },
  [1946] = {
    error_ui = 1,
    id = 1946,
    tips = "请先选择选项",
    type = "CURSE_OPTIONS_NOT_ACTIVITY"
  },
  [1947] = {
    error_ui = 1,
    id = 1947,
    tips = "首充奖励尚未解锁",
    type = "FIRST_RECHARGE_AWARD_LOCK"
  },
  [1948] = {
    error_ui = 1,
    id = 1948,
    ignore_tips = 1,
    tips = "创建订单失败",
    type = "CREATE_RECHARGE_ORDER_FAILD"
  },
  [1949] = {
    error_ui = 1,
    id = 1949,
    ignore_tips = 1,
    tips = "游戏订单已存在",
    type = "RECHARGE_ORDER_HAVE"
  },
  [1950] = {
    error_ui = 2,
    id = 1950,
    tips = "应国家政策要求，本游戏不对未满8周岁的用户提供充值服务，本次操作无效！",
    type = "RECHARGE_PREVENT_ADDICTION"
  },
  [1951] = {
    error_ui = 1,
    id = 1951,
    tips = "奖励达到领取上线",
    type = "GET_AWARD_LIMIT"
  },
  [1952] = {
    error_ui = 1,
    id = 1952,
    ignore_tips = 1,
    tips = "订单信息错误",
    type = "NOT_TO_FIND_RECHARGE_ORDER"
  },
  [1953] = {
    error_ui = 1,
    id = 1953,
    tips = "订单已发货",
    type = "RECHARGE_ORDER_WAS_DELIVERED"
  },
  [1954] = {
    error_ui = 1,
    id = 1954,
    tips = "订单已取消",
    type = "RECHARGE_ORDER_WAS_CANCEL"
  },
  [1955] = {
    error_ui = 1,
    id = 1955,
    ignore_tips = 1,
    tips = "场景历程前置事件未完成",
    type = "JOURNEY_EVENT_PRE_NOT_DONE"
  },
  [1956] = {
    error_ui = 1,
    id = 1956,
    ignore_tips = 1,
    tips = "订单错误",
    type = "SDK_IOS_RECHARGE_ORDER_ERROR"
  },
  [1957] = {
    error_ui = 1,
    id = 1957,
    tips = "缺少第三方认证信息",
    type = "NOT_TO_FIND_SDK_ACCOUNT_DATA"
  },
  [1958] = {
    error_ui = 1,
    id = 1958,
    tips = "缺少账号认证信息",
    type = "NOT_TO_FIND_ACCOUNT_ID_CARD"
  },
  [1959] = {
    error_ui = 1,
    id = 1959,
    ignore_tips = 1,
    tips = "账号认证信息错误",
    type = "ACCOUNT_ID_CARD_ERROR"
  },
  [1960] = {
    error_ui = 1,
    id = 1960,
    ignore_tips = 1,
    tips = "无法使用模拟充值功能",
    type = "NOT_TO_USE_UGSDK_ACCOUNT_SIMULATED_RECHARGE"
  },
  [1961] = {
    error_ui = 1,
    id = 1961,
    tips = "宝箱已开启",
    type = "EPISODE_BOX_HAVE_GET_REWARD"
  },
  [1962] = {
    error_ui = 1,
    id = 1962,
    ignore_tips = 1,
    tips = "宝箱不可开启",
    type = "EPISODE_BOX_NOT_INTERACTIVE"
  },
  [1963] = {
    error_ui = 1,
    id = 1963,
    ignore_tips = 1,
    tips = "已领取同组奖励",
    type = "CD_KEY_GET_MUTEX_REWARD"
  },
  [1964] = {
    error_ui = 1,
    id = 1964,
    ignore_tips = 1,
    tips = "禁止购买",
    type = "SHOP_BAN_BUY"
  },
  [1965] = {
    error_ui = 1,
    id = 1965,
    tips = "修整章节奇珍未获得",
    type = "RECUPERATION_ORNAMENT_NOT_GAIN"
  },
  [1966] = {
    error_ui = 1,
    id = 1966,
    ignore_tips = 1,
    tips = "此任务非奇珍获取任务",
    type = "TASK_NOT_ORNAMENT_SELECT"
  },
  [1967] = {
    error_ui = 1,
    id = 1967,
    tips = "奇珍选择已完成",
    type = "ORNAMENT_SELECT_FINISH"
  },
  [1968] = {
    error_ui = 2,
    id = 1968,
    tips = "应国家政策要求，8周岁至16周岁的用户，单次充值金额不超过50元人民币，每月充值金额累计不超过200元人民币，本次操作无效！",
    type = "RECHARGE_LIMIT_TEXT_1"
  },
  [1969] = {
    error_ui = 2,
    id = 1969,
    tips = "应国家政策要求，16周岁至18周岁的用户，单次充值金额不超过100元人民币，每月充值金额累计不超过400元人民币，本次操作无效！",
    type = "RECHARGE_LIMIT_TEXT_2"
  },
  [1970] = {
    error_ui = 1,
    id = 1970,
    tips = "重复奇珍",
    type = "ORNAMENT_GAINED"
  },
  [1971] = {
    error_ui = 1,
    id = 1971,
    tips = "重复片语",
    type = "ABILITY_GAINED"
  },
  [1972] = {
    error_ui = 1,
    id = 1972,
    tips = "未达成选择选项条件",
    type = "CARD_EVENT_CONTIION_NOT_OPEN"
  },
  [1973] = {
    error_ui = 1,
    id = 1973,
    ignore_tips = 1,
    tips = "无法使用该道具",
    type = "NOT_USE_ITEM"
  },
  [1974] = {
    error_ui = 1,
    id = 1974,
    tips = "等级奖励已获取",
    type = "ACTIVITY_LEVEL_AWARD_GAINED"
  },
  [1975] = {
    error_ui = 1,
    id = 1975,
    tips = "任务未接取",
    type = "TASK_NOT_PICK"
  },
  [1976] = {
    error_ui = 1,
    id = 1976,
    tips = "请清理仓库后再领取",
    type = "COLLECT_AFTER_CLEAN_WAREHOUSE"
  },
  [1977] = {
    error_ui = 1,
    id = 1977,
    tips = "补给差分机未激活",
    type = "NOT_ACTIVE_MONTHLY_CARD"
  },
  [1978] = {
    error_ui = 1,
    id = 1978,
    tips = "好感度等级奖励已获取",
    type = "FAVOR_LEVEL_ARARD_GAINED"
  },
  [1979] = {
    error_ui = 1,
    id = 1979,
    tips = "贸易站生产中",
    type = "BUILDING_FACTORY_WORKING"
  },
  [1980] = {
    error_ui = 1,
    id = 1980,
    tips = "派遣重复角色",
    type = "BUILDING_ADVENTURE_USING_REPEAT_BUDDY"
  },
  [1981] = {
    error_ui = 1,
    id = 1981,
    tips = "该建筑已满级",
    type = "BUILDING_MAX_LEVEL"
  },
  [1982] = {
    error_ui = 1,
    id = 1982,
    ignore_tips = 1,
    tips = "任务不可接取",
    type = "BUILDING_ADVENTURE_TASK_NOT_GAINED"
  },
  [1983] = {
    error_ui = 1,
    id = 1983,
    ignore_tips = 1,
    tips = "任务状态错误",
    type = "BUILDING_ADVENTURE_STATE_ERROR"
  },
  [1984] = {
    error_ui = 1,
    id = 1984,
    tips = "派遣角色不满足条件",
    type = "ADVENTURE_CHECK_BUDDY_ERROE"
  },
  [1985] = {
    error_ui = 1,
    id = 1985,
    tips = "任务未完成",
    type = "BUILDING_ADVENTURE_TASK_NOT_FINISH"
  },
  [1986] = {
    error_ui = 1,
    id = 1986,
    tips = "领取奖励后无法切换段位",
    type = "GET_SEGMENT_AWARD_AFTER_NOT_CHANGE_SEGMENT"
  },
  [1987] = {
    error_ui = 1,
    id = 1987,
    tips = "当前IP已被封禁",
    type = "CLIENT_IP_IS_LOCK"
  },
  [1988] = {
    error_ui = 1,
    id = 1988,
    tips = "片段不能刷新",
    type = "CURSE_EQUATION_NOT_REFRESH"
  },
  [1989] = {
    error_ui = 1,
    id = 1989,
    ignore_tips = 1,
    tips = "片段选择错误",
    type = "CURSE_EQUATION_SELECT_INDEX_ERROR"
  },
  [1990] = {
    error_ui = 1,
    id = 1990,
    tips = "片段分支已经选择",
    type = "CURSE_EQUATION_BRANCH_SELECTED"
  },
  [1991] = {
    error_ui = 1,
    id = 1991,
    tips = "片段分支不可选择",
    type = "CURSE_EQUATION_SELECT_ERROR"
  },
  [1992] = {
    error_ui = 1,
    id = 1992,
    tips = "基建助战已达每日上限",
    type = "HELP_FIGHT_LIMIT"
  },
  [1993] = {
    error_ui = 1,
    id = 1993,
    tips = "工厂生产已满，不可加速",
    type = "BUILDING_FACTORY_FULL"
  },
  [1994] = {
    error_ui = 1,
    id = 1994,
    tips = "已打开",
    type = "EPISODE_HAVE_GET_REWARD"
  },
  [1995] = {
    error_ui = 1,
    id = 1995,
    tips = "无法使用充值功能",
    type = "NOT_TO_USE_PLATFORM_RECHARGE_FUNC"
  },
  [1996] = {
    error_ui = 1,
    id = 1996,
    ignore_tips = 1,
    tips = "缺少参数",
    type = "NOT_TO_FIND_PARAM"
  },
  [1997] = {
    error_ui = 1,
    id = 1997,
    ignore_tips = 1,
    tips = "订单验证失败",
    type = "HIVE_VERIFY_RECHARGE_ERROR"
  },
  [1998] = {
    error_ui = 1,
    id = 1998,
    ignore_tips = 1,
    tips = "第三方获取订单失败",
    type = "PLATFORM_RECHARGE_DATA_ERROR"
  },
  [1999] = {
    error_ui = 1,
    id = 1999,
    ignore_tips = 1,
    tips = "订单信息校验失败",
    type = "RECHARGE_ORDER_DATA_NOT_MATCH"
  },
  [2000] = {
    error_ui = 1,
    id = 2000,
    ignore_tips = 1,
    tips = "订单发货失败",
    type = "RECHARGE_ORDER_DELIVER_GOODS_ERROR"
  },
  [2001] = {
    error_ui = 1,
    id = 2001,
    tips = "未满足编队限制",
    type = "TEAM_LIMIT_NOT_CONDITION"
  },
  [2002] = {
    error_ui = 1,
    id = 2002,
    tips = "活动关卡未开启",
    type = "KITTEN_ESCAPE_EPISODE_NOT_OPEN"
  },
  [2003] = {
    error_ui = 1,
    id = 2003,
    tips = "活动关卡已通关",
    type = "KITTEN_ESCAPE_PASSED"
  },
  [2004] = {
    error_ui = 1,
    id = 2004,
    tips = "奖励已获取",
    type = "GOLD_EQUIP_AWARD_GAINED"
  },
  [2005] = {
    error_ui = 1,
    id = 2005,
    ignore_tips = 1,
    tips = "武器不存在",
    type = "GOLD_EQUIP_NOT_FOUND"
  },
  [2006] = {
    error_ui = 1,
    id = 2006,
    tips = "关卡未开启",
    type = "BOSS_FIGHT_EPISODE_NOT_OPEN"
  },
  [2007] = {
    error_ui = 1,
    id = 2007,
    tips = "打字数量已满",
    type = "MONKEY_FONT_COUNT_MAX"
  },
  [2008] = {
    error_ui = 1,
    id = 2008,
    ignore_tips = 1,
    tips = "房间玩家数据错误",
    type = "ROOM_PLAYER_DATA_FAIL"
  },
  [2009] = {
    error_ui = 1,
    id = 2009,
    ignore_tips = 1,
    tips = "房间不在战斗中",
    type = "ROOM_IN_WAR"
  },
  [2010] = {
    error_ui = 1,
    id = 2010,
    ignore_tips = 1,
    tips = "房间未开放",
    type = "ROOM_NOT_LAUNCH"
  },
  [2011] = {
    error_ui = 1,
    id = 2011,
    ignore_tips = 1,
    tips = "房间不可进入",
    type = "NO_PERMISSION"
  },
  [2012] = {
    error_ui = 1,
    id = 2012,
    tips = "正在打字中",
    type = "MONKEY_TYPE_WRITER_RUNNING"
  },
  [2013] = {
    error_ui = 1,
    id = 2013,
    ignore_tips = 1,
    tips = "聊天消息长度限制",
    type = "CHAT_MSG_LEN_LIMITED"
  },
  [2014] = {
    error_ui = 1,
    id = 2014,
    ignore_tips = 1,
    tips = "匹配失败",
    type = "MATCH_JOIN_FAIL"
  },
  [2015] = {
    error_ui = 1,
    id = 2015,
    tips = "该武器未开放选择",
    type = "GOLD_EQUIP_NOT_OPEN_SELECT"
  },
  [2016] = {
    error_ui = 1,
    id = 2016,
    ignore_tips = 1,
    tips = "副本未开放",
    type = "LINEAR_NOT_OPEN"
  },
  [2017] = {
    error_ui = 1,
    id = 2017,
    ignore_tips = 1,
    tips = "房间邀请消息过期",
    type = "ROOM_INVITE_MESSAGE_OVERDUE"
  },
  [2018] = {
    error_ui = 1,
    id = 2018,
    ignore_tips = 1,
    tips = "不在房间",
    type = "CHANGE_STATE_NOT_ROOM"
  },
  [2019] = {
    error_ui = 1,
    id = 2019,
    ignore_tips = 1,
    tips = "重复点击",
    type = "PLOT_PREHEAT_CLICKED"
  },
  [2020] = {
    error_ui = 1,
    id = 2020,
    ignore_tips = 1,
    tips = "前置未解锁",
    type = "ACTIVITY_CURSE_PRE_BLESS_LOCK"
  },
  [2021] = {
    error_ui = 1,
    id = 2021,
    ignore_tips = 1,
    tips = "不可领取奖励",
    type = "ACTIVITY_SIGN_IN_AWARD_NOT_OPEN"
  },
  [2022] = {
    error_ui = 1,
    id = 2022,
    ignore_tips = 1,
    tips = "不可洗练",
    type = "NOT_FIND_BUDDY_REFINE_REPLACE_ENTRY"
  },
  [2023] = {
    error_ui = 1,
    id = 2023,
    tips = "打字机过热",
    type = "MONKEY_UNIT_COUNT_NOT_MAX"
  },
  [2024] = {
    error_ui = 1,
    id = 2024,
    tips = "问题已解析",
    type = "MONKEY_QUESTION_COMPLETE"
  },
  [2025] = {
    error_ui = 1,
    id = 2025,
    ignore_tips = 1,
    tips = "找不到礼包配置",
    type = "NOT_FIND_GIFT_CONFIG"
  },
  [2026] = {
    error_ui = 1,
    id = 2026,
    tips = "问题解析中",
    type = "MONKEY_QUESTION_PARSING"
  },
  [2027] = {
    error_ui = 1,
    id = 2027,
    tips = "问题未解锁",
    type = "MONKEY_TYPE_WRITER_QUESTION_NOT_OPEN"
  },
  [2028] = {
    error_ui = 1,
    id = 2028,
    ignore_tips = 1,
    tips = "不存在解析中的问题",
    type = "MONKEY_NOT_RUNING"
  },
  [2029] = {
    error_ui = 1,
    id = 2029,
    tips = "已达最大等级",
    type = "MONKEY_WRITER_MAX_LEVEL"
  },
  [2030] = {
    error_ui = 1,
    id = 2030,
    tips = "已经获取奖励",
    type = "ACTIVITY_SIGN_IN_GAINED"
  },
  [2031] = {
    error_ui = 1,
    id = 2031,
    tips = "饰品未激活",
    type = "ORANSMENT_NOT_ACTIVE"
  },
  [2032] = {
    error_ui = 1,
    id = 2032,
    tips = "重复贴图",
    type = "CHARTLET_REPEAT"
  },
  [2033] = {
    error_ui = 1,
    id = 2033,
    ignore_tips = 1,
    tips = "未找到丢弃道具",
    type = "NO_FIND_DISCARD_ITEM"
  },
  [2034] = {
    error_ui = 1,
    id = 2034,
    tips = "剧情预览已解锁",
    type = "PLOT_PREHEAT_UNLOCKED"
  },
  [2035] = {
    error_ui = 1,
    id = 2035,
    tips = "文本存在敏感词汇",
    type = "TEXT_SENSITIVE_WORDS"
  },
  [2036] = {
    error_ui = 1,
    id = 2036,
    tips = "重复贴图框",
    type = "CHARTLET_FRAME_REPEAT"
  },
  [2037] = {
    error_ui = 1,
    id = 2037,
    tips = "问题已解析",
    type = "MONKEY_QUESTION_DONED"
  },
  [2038] = {
    error_ui = 1,
    id = 2038,
    tips = "禁用商店购买",
    type = "CURSE_BAN_SHOP_BUY"
  },
  [2039] = {
    error_ui = 1,
    id = 2039,
    tips = "祝福已解锁",
    type = "ACTIVITY_CURSE_LOCKED"
  },
  [2040] = {
    error_ui = 1,
    id = 2040,
    tips = "时装未解锁",
    type = "EQUIP_FASHION_NOT_ACTIVE"
  },
  [2041] = {
    error_ui = 1,
    id = 2041,
    ignore_tips = 1,
    tips = "方程无效分支",
    type = "CURSE_EQUATION_INVAILD_BRANCH"
  },
  [2042] = {
    error_ui = 1,
    id = 2042,
    ignore_tips = 1,
    tips = "装备不可操作",
    type = "EQUIP_CANT_WEAR"
  },
  [2043] = {
    error_ui = 1,
    id = 2043,
    ignore_tips = 1,
    tips = "没找到关卡",
    type = "CLIENT_2043"
  },
  [2044] = {
    error_ui = 1,
    id = 2044,
    tips = "已存在所选角色！",
    type = "CLIENT_2044"
  },
  [2045] = {
    error_ui = 1,
    id = 2045,
    tips = "操作频繁，请稍候尝试",
    type = "CLIENT_2045"
  },
  [2046] = {
    error_ui = 1,
    id = 2046,
    tips = "技能装配成功！",
    type = "CLIENT_2046"
  },
  [2047] = {
    error_ui = 1,
    id = 2047,
    tips = "商店刷新成功",
    type = "CLIENT_2047"
  },
  [2048] = {
    error_ui = 1,
    id = 2048,
    tips = "购买成功",
    type = "CLIENT_2048"
  },
  [2049] = {
    error_ui = 1,
    id = 2049,
    tips = "出售成功",
    type = "CLIENT_2049"
  },
  [2050] = {
    error_ui = 1,
    id = 2050,
    tips = "使用技能书成功",
    type = "CLIENT_2050"
  },
  [2051] = {
    error_ui = 1,
    id = 2051,
    tips = "选择成功",
    type = "CLIENT_2051"
  },
  [2052] = {
    error_ui = 1,
    id = 2052,
    tips = "天赋树激活成功",
    type = "CLIENT_2052"
  },
  [2053] = {
    error_ui = 1,
    id = 2053,
    tips = "天赋激活成功",
    type = "CLIENT_2053"
  },
  [2054] = {
    error_ui = 1,
    id = 2054,
    tips = "任务失败！！",
    type = "CLIENT_2054"
  },
  [2055] = {
    error_ui = 1,
    id = 2055,
    tips = "任务完成！！",
    type = "CLIENT_2055"
  },
  [2056] = {
    error_ui = 1,
    id = 2056,
    tips = "刷新成功",
    type = "CLIENT_2056"
  },
  [2057] = {
    error_ui = 1,
    id = 2057,
    tips = "未上阵指定角色",
    type = "CLIENT_2057"
  },
  [2058] = {
    error_ui = 1,
    id = 2058,
    tips = "未上阵指定元素角色",
    type = "CLIENT_2058"
  },
  [2059] = {
    error_ui = 1,
    id = 2059,
    tips = "未上阵指定职业角色",
    type = "CLIENT_2059"
  },
  [2060] = {
    error_ui = 1,
    id = 2060,
    tips = "可用线索不足",
    type = "CLIENT_2060"
  },
  [2061] = {
    error_ui = 1,
    id = 2061,
    tips = "协助角色已达上限",
    type = "CLIENT_2061"
  },
  [2062] = {
    error_ui = 1,
    id = 2062,
    tips = "上阵角色数量不足",
    type = "CLIENT_2062"
  },
  [2063] = {
    error_ui = 1,
    id = 2063,
    tips = "解锁成功",
    type = "CLIENT_2063"
  },
  [2064] = {
    error_ui = 1,
    id = 2064,
    tips = "血量不足",
    type = "CLIENT_2064"
  },
  [2065] = {
    error_ui = 1,
    id = 2065,
    tips = "迷失值已满",
    type = "CLIENT_2065"
  },
  [2066] = {
    error_ui = 1,
    id = 2066,
    tips = "迷失值不足",
    type = "CLIENT_2066"
  },
  [2067] = {
    error_ui = 1,
    id = 2067,
    tips = "请通关前置关卡",
    type = "CLIENT_2067"
  },
  [2068] = {
    error_ui = 1,
    id = 2068,
    tips = "前置关卡星级条件未达成",
    type = "CLIENT_2068"
  },
  [2069] = {
    error_ui = 1,
    id = 2069,
    tips = "章节未解锁",
    type = "CLIENT_2069"
  },
  [2070] = {
    error_ui = 1,
    id = 2070,
    tips = "道具使用成功",
    type = "CLIENT_2070"
  },
  [2071] = {
    error_ui = 1,
    id = 2071,
    tips = "上锁成功",
    type = "CLIENT_2071"
  },
  [2072] = {
    error_ui = 1,
    id = 2072,
    tips = "升级成功",
    type = "CLIENT_2072"
  },
  [2073] = {
    error_ui = 1,
    id = 2073,
    tips = "激活成功",
    type = "CLIENT_2073"
  },
  [2074] = {
    error_ui = 1,
    id = 2074,
    tips = "已保存",
    type = "CLIENT_2074"
  },
  [2075] = {
    error_ui = 1,
    id = 2075,
    tips = "保存失败",
    type = "CLIENT_2075"
  },
  [2076] = {
    error_ui = 1,
    id = 2076,
    tips = "装配成功",
    type = "CLIENT_2076"
  },
  [2077] = {
    error_ui = 1,
    id = 2077,
    tips = "暂无可装配古痕",
    type = "CLIENT_2077"
  },
  [2078] = {
    error_ui = 1,
    id = 2078,
    tips = "频道已满",
    type = "CLIENT_2078"
  },
  [2079] = {
    error_ui = 1,
    id = 2079,
    tips = "添加好友成功",
    type = "CLIENT_2079"
  },
  [2080] = {
    error_ui = 1,
    id = 2080,
    tips = "删除好友成功",
    type = "CLIENT_2080"
  },
  [2081] = {
    error_ui = 1,
    id = 2081,
    tips = "今日领取次数已达上限",
    type = "CLIENT_2081"
  },
  [2082] = {
    error_ui = 1,
    id = 2082,
    tips = "已赠送",
    type = "CLIENT_2082"
  },
  [2083] = {
    error_ui = 1,
    id = 2083,
    tips = "当前节点已完成",
    type = "CLIENT_2083"
  },
  [2084] = {
    error_ui = 1,
    id = 2084,
    tips = "该教学关未开启",
    type = "CLIENT_2084"
  },
  [2085] = {
    error_ui = 1,
    id = 2085,
    tips = "全部邮件删除成功",
    type = "CLIENT_2085"
  },
  [2086] = {
    error_ui = 1,
    id = 2086,
    tips = "当前明度已领取",
    type = "CLIENT_2086"
  },
  [2087] = {
    error_ui = 1,
    id = 2087,
    tips = "不在领取时间段",
    type = "CLIENT_2087"
  },
  [2088] = {
    error_ui = 1,
    id = 2088,
    tips = "签到成功",
    type = "CLIENT_2088"
  },
  [2089] = {
    error_ui = 1,
    id = 2089,
    tips = "修改成功",
    type = "CLIENT_2089"
  },
  [2090] = {
    error_ui = 1,
    id = 2090,
    tips = "更换成功",
    type = "CLIENT_2090"
  },
  [2091] = {
    error_ui = 1,
    id = 2091,
    tips = "购买成功！",
    type = "CLIENT_2091"
  },
  [2092] = {
    error_ui = 1,
    id = 2092,
    tips = "设置成功",
    type = "CLIENT_2092"
  },
  [2093] = {
    error_ui = 1,
    id = 2093,
    tips = "未解锁关卡",
    type = "CLIENT_2093"
  },
  [2094] = {
    error_ui = 1,
    id = 2094,
    tips = "未拥有该角色",
    type = "CLIENT_2094"
  },
  [2095] = {
    error_ui = 1,
    id = 2095,
    tips = "请先退出关卡！",
    type = "CLIENT_2095"
  },
  [2096] = {
    error_ui = 1,
    id = 2096,
    tips = "活动未开启",
    type = "CLIENT_2096"
  },
  [2097] = {
    error_ui = 1,
    id = 2097,
    tips = "传送门解锁成功！",
    type = "CLIENT_2097"
  },
  [2098] = {
    error_ui = 1,
    id = 2098,
    tips = "战斗未结束",
    type = "CLIENT_2098"
  },
  [2099] = {
    error_ui = 1,
    id = 2099,
    tips = "搜索不到公会！",
    type = "CLIENT_2099"
  },
  [2100] = {
    error_ui = 1,
    id = 2100,
    tips = "玩家已有公会！",
    type = "CLIENT_2100"
  },
  [2101] = {
    error_ui = 1,
    id = 2101,
    tips = "搜索不到玩家！",
    type = "CLIENT_2101"
  },
  [2102] = {
    error_ui = 1,
    id = 2102,
    tips = "领取成功",
    type = "CLIENT_2102"
  },
  [2103] = {
    error_ui = 1,
    id = 2103,
    tips = "道具数量达到上限",
    type = "CLIENT_2103"
  },
  [2104] = {
    error_ui = 1,
    id = 2104,
    tips = "无已开启活动",
    type = "CLIENT_2104"
  },
  [2105] = {
    error_ui = 1,
    id = 2105,
    tips = "怪物未收录",
    type = "CLIENT_2105"
  },
  [2106] = {
    error_ui = 1,
    id = 2106,
    tips = "货币不足！",
    type = "CLIENT_2106"
  },
  [2107] = {
    error_ui = 1,
    id = 2107,
    tips = "暂无装备",
    type = "CLIENT_2107"
  },
  [2108] = {
    error_ui = 1,
    id = 2108,
    tips = "战斗未结束，不能操作！",
    type = "CLIENT_2108"
  },
  [2109] = {
    error_ui = 1,
    id = 2109,
    tips = "暂无角色符合使用条件！",
    type = "CLIENT_2109"
  },
  [2110] = {
    error_ui = 1,
    id = 2110,
    tips = "已达到最大出售数量！",
    type = "CLIENT_2110"
  },
  [2111] = {
    error_ui = 1,
    id = 2111,
    tips = "已经达到最合适使用数量！",
    type = "CLIENT_2111"
  },
  [2112] = {
    error_ui = 1,
    id = 2112,
    tips = "最少出售数量不能为0！",
    type = "CLIENT_2112"
  },
  [2113] = {
    error_ui = 1,
    id = 2113,
    tips = "最少使用数量不能为0！",
    type = "CLIENT_2113"
  },
  [2114] = {
    error_ui = 1,
    id = 2114,
    tips = "该玩法不支持复活",
    type = "CLIENT_2114"
  },
  [2115] = {
    error_ui = 1,
    id = 2115,
    tips = "消耗不足",
    type = "CLIENT_2115"
  },
  [2116] = {
    error_ui = 1,
    id = 2116,
    ignore_tips = 1,
    tips = "请选择英雄进行镶嵌",
    type = "CLIENT_2116"
  },
  [2117] = {
    error_ui = 1,
    id = 2117,
    ignore_tips = 1,
    tips = "死亡英雄无法进行镶嵌",
    type = "CLIENT_2117"
  },
  [2118] = {
    error_ui = 1,
    id = 2118,
    ignore_tips = 1,
    tips = "该英雄无法进行镶嵌",
    type = "CLIENT_2118"
  },
  [2119] = {
    error_ui = 1,
    id = 2119,
    ignore_tips = 1,
    tips = "该英雄同类型符文已满级",
    type = "CLIENT_2119"
  },
  [2120] = {
    error_ui = 1,
    id = 2120,
    ignore_tips = 1,
    tips = "请选择英雄进行复活",
    type = "CLIENT_2120"
  },
  [2121] = {
    error_ui = 1,
    id = 2121,
    ignore_tips = 1,
    tips = "英雄未死亡",
    type = "CLIENT_2121"
  },
  [2122] = {
    error_ui = 1,
    id = 2122,
    ignore_tips = 1,
    tips = "请选择英雄后再进行购买",
    type = "CLIENT_2122"
  },
  [2123] = {
    error_ui = 1,
    id = 2123,
    ignore_tips = 1,
    tips = "死亡英雄无法进行购买",
    type = "CLIENT_2123"
  },
  [2124] = {
    error_ui = 1,
    id = 2124,
    ignore_tips = 1,
    tips = "符文不适配，无法购买",
    type = "CLIENT_2124"
  },
  [2125] = {
    error_ui = 1,
    id = 2125,
    tips = "角色不存在",
    type = "CLIENT_2125"
  },
  [2126] = {
    error_ui = 1,
    id = 2126,
    ignore_tips = 1,
    tips = "该角色不可镶嵌",
    type = "CLIENT_2126"
  },
  [2127] = {
    error_ui = 1,
    id = 2127,
    tips = "恢复默认成功",
    type = "CLIENT_2127"
  },
  [2128] = {
    error_ui = 1,
    id = 2128,
    tips = "没有可出售物品",
    type = "CLIENT_2128"
  },
  [2129] = {
    error_ui = 1,
    id = 2129,
    tips = "没有该类型物品可出售",
    type = "CLIENT_2129"
  },
  [2130] = {
    error_ui = 1,
    id = 2130,
    tips = "达到刷新上限",
    type = "CLIENT_2130"
  },
  [2131] = {
    error_ui = 1,
    id = 2131,
    tips = "请选择商品",
    type = "CLIENT_2131"
  },
  [2132] = {
    error_ui = 1,
    id = 2132,
    tips = "请选择物品",
    type = "CLIENT_2132"
  },
  [2133] = {
    error_ui = 1,
    id = 2133,
    tips = "请选择技能",
    type = "CLIENT_2133"
  },
  [2134] = {
    error_ui = 1,
    id = 2134,
    tips = "请选择天赋",
    type = "CLIENT_2134"
  },
  [2135] = {
    error_ui = 1,
    id = 2135,
    tips = "该天赋不可选",
    type = "CLIENT_2135"
  },
  [2136] = {
    error_ui = 1,
    id = 2136,
    tips = "该天赋已激活完毕",
    type = "CLIENT_2136"
  },
  [2137] = {
    error_ui = 1,
    id = 2137,
    tips = "请选择奖励",
    type = "CLIENT_2137"
  },
  [2138] = {
    error_ui = 1,
    id = 2138,
    tips = "到顶啦",
    type = "CLIENT_2138"
  },
  [2139] = {
    error_ui = 1,
    id = 2139,
    tips = "到尾啦",
    type = "CLIENT_2139"
  },
  [2140] = {
    error_ui = 1,
    id = 2140,
    tips = "未达到领取条件",
    type = "CLIENT_2140"
  },
  [2141] = {
    error_ui = 1,
    id = 2141,
    tips = "潜能提升成功",
    type = "CLIENT_2141"
  },
  [2142] = {
    error_ui = 1,
    id = 2142,
    tips = "未选消耗",
    type = "CLIENT_2142"
  },
  [2143] = {
    error_ui = 1,
    id = 2143,
    tips = "等级提升",
    type = "CLIENT_2143"
  },
  [2144] = {
    error_ui = 1,
    id = 2144,
    tips = "经验值提升",
    type = "CLIENT_2144"
  },
  [2145] = {
    error_ui = 1,
    id = 2145,
    tips = "条件不足",
    type = "CLIENT_2145"
  },
  [2146] = {
    error_ui = 1,
    id = 2146,
    tips = "材料消耗不足",
    type = "CLIENT_2146"
  },
  [2147] = {
    error_ui = 1,
    id = 2147,
    tips = "当前没有可选消耗",
    type = "CLIENT_2147"
  },
  [2148] = {
    error_ui = 1,
    id = 2148,
    tips = "暂未开放",
    type = "CLIENT_2148"
  },
  [2149] = {
    error_ui = 1,
    id = 2149,
    tips = "角色已在其他关卡出战",
    type = "CLIENT_2149"
  },
  [2150] = {
    error_ui = 1,
    id = 2150,
    tips = "已固定同角色出战",
    type = "CLIENT_2150"
  },
  [2151] = {
    error_ui = 1,
    id = 2151,
    tips = "关卡禁用",
    type = "CLIENT_2151"
  },
  [2152] = {
    error_ui = 1,
    id = 2152,
    tips = "材料不足",
    type = "CLIENT_2152"
  },
  [2153] = {
    error_ui = 1,
    id = 2153,
    tips = "技能等级提升",
    type = "CLIENT_2153"
  },
  [2154] = {
    error_ui = 1,
    id = 2154,
    tips = "强化成功",
    type = "CLIENT_2154"
  },
  [2155] = {
    error_ui = 1,
    id = 2155,
    tips = "请先进行刻印洗练",
    type = "CLIENT_2155"
  },
  [2156] = {
    error_ui = 1,
    id = 2156,
    tips = "没有符合的角色",
    type = "CLIENT_2156"
  },
  [2157] = {
    error_ui = 1,
    id = 2157,
    tips = "专属本源不可调整",
    type = "CLIENT_2157"
  },
  [2158] = {
    error_ui = 1,
    id = 2158,
    tips = "突破准备",
    type = "CLIENT_2158"
  },
  [2159] = {
    error_ui = 1,
    id = 2159,
    tips = "已锁定，解锁后才可消耗",
    type = "CLIENT_2159"
  },
  [2160] = {
    error_ui = 1,
    id = 2160,
    tips = "请选择需要替换的武器",
    type = "CLIENT_2160"
  },
  [2161] = {
    error_ui = 1,
    id = 2161,
    tips = "替换成功",
    type = "CLIENT_2161"
  },
  [2162] = {
    error_ui = 1,
    id = 2162,
    tips = "选中材料已达到最大值",
    type = "CLIENT_2162"
  },
  [2163] = {
    error_ui = 1,
    id = 2163,
    tips = "缺少同名武器",
    type = "CLIENT_2163"
  },
  [2164] = {
    error_ui = 1,
    id = 2164,
    tips = "同调完成",
    type = "CLIENT_2164"
  },
  [2165] = {
    error_ui = 1,
    id = 2165,
    tips = "冷却中！",
    type = "CLIENT_2165"
  },
  [2166] = {
    error_ui = 1,
    id = 2166,
    tips = "超出字数限制！",
    type = "CLIENT_2166"
  },
  [2167] = {
    error_ui = 1,
    id = 2167,
    tips = "请输入内容！",
    type = "CLIENT_2167"
  },
  [2168] = {
    error_ui = 1,
    id = 2168,
    tips = "频道未开启！",
    type = "CLIENT_2168"
  },
  [2169] = {
    error_ui = 1,
    id = 2169,
    tips = "未加入公会！",
    type = "CLIENT_2169"
  },
  [2170] = {
    error_ui = 1,
    id = 2170,
    tips = "输入数据不匹配！",
    type = "CLIENT_2170"
  },
  [2171] = {
    error_ui = 1,
    id = 2171,
    tips = "已在该频道！",
    type = "CLIENT_2171"
  },
  [2172] = {
    error_ui = 1,
    id = 2172,
    tips = "保存成功",
    type = "CLIENT_2172"
  },
  [2173] = {
    error_ui = 1,
    id = 2173,
    tips = "有重复的角色",
    type = "CLIENT_2173"
  },
  [2174] = {
    error_ui = 1,
    id = 2174,
    tips = "自定义名称不能为空",
    type = "CLIENT_2174"
  },
  [2175] = {
    error_ui = 1,
    id = 2175,
    tips = "自定义名称必须为纯数字",
    type = "CLIENT_2175"
  },
  [2176] = {
    error_ui = 1,
    id = 2176,
    tips = "自定义名称不能为0",
    type = "CLIENT_2176"
  },
  [2177] = {
    error_ui = 1,
    id = 2177,
    ignore_tips = 1,
    tips = "挑战类型只可填数字或不填",
    type = "CLIENT_2177"
  },
  [2178] = {
    error_ui = 1,
    id = 2178,
    ignore_tips = 1,
    tips = "挑战类型未定义",
    type = "CLIENT_2178"
  },
  [2179] = {
    error_ui = 1,
    id = 2179,
    tips = "当前宝箱不可打开",
    type = "CLIENT_2179"
  },
  [2180] = {
    error_ui = 1,
    id = 2180,
    tips = "网络繁忙，请稍候再试",
    type = "CLIENT_2180"
  },
  [2181] = {
    error_ui = 1,
    id = 2181,
    ignore_tips = 1,
    tips = "当前塔不能传送",
    type = "CLIENT_2181"
  },
  [2182] = {
    error_ui = 1,
    id = 2182,
    tips = "已处于目标房间",
    type = "CLIENT_2182"
  },
  [2183] = {
    error_ui = 1,
    id = 2183,
    tips = "已经达到最大数量！",
    type = "CLIENT_2183"
  },
  [2184] = {
    error_ui = 1,
    id = 2184,
    tips = "请从背包选择装备进行穿戴！",
    type = "CLIENT_2184"
  },
  [2185] = {
    error_ui = 1,
    id = 2185,
    tips = "角色已死亡，无法使用！",
    type = "CLIENT_2185"
  },
  [2186] = {
    error_ui = 1,
    id = 2186,
    tips = "角色血量已达上限，不能使用！",
    type = "CLIENT_2186"
  },
  [2187] = {
    error_ui = 1,
    id = 2187,
    tips = "超过血量上限，不能使用！",
    type = "CLIENT_2187"
  },
  [2188] = {
    error_ui = 1,
    id = 2188,
    tips = "所有角色血量已达上限，不能使用！",
    type = "CLIENT_2188"
  },
  [2189] = {
    error_ui = 1,
    id = 2189,
    tips = "角色已死亡，使用失败！",
    type = "CLIENT_2189"
  },
  [2190] = {
    error_ui = 1,
    id = 2190,
    ignore_tips = 1,
    tips = "无法传送至该房间！",
    type = "CLIENT_2190"
  },
  [2191] = {
    error_ui = 1,
    id = 2191,
    ignore_tips = 1,
    tips = "房间未通关，无法直接传送！",
    type = "CLIENT_2191"
  },
  [2192] = {
    error_ui = 1,
    id = 2192,
    tips = "表情暂未开启！",
    type = "CLIENT_2192"
  },
  [2193] = {
    error_ui = 1,
    id = 2193,
    tips = "复制成功",
    type = "CLIENT_2193"
  },
  [2194] = {
    error_ui = 1,
    id = 2194,
    tips = "已发送申请",
    type = "CLIENT_2194"
  },
  [2195] = {
    error_ui = 1,
    id = 2195,
    tips = "黑名单内人数达上限",
    type = "CLIENT_2195"
  },
  [2196] = {
    error_ui = 1,
    id = 2196,
    tips = "已移出黑名单",
    type = "CLIENT_2196"
  },
  [2197] = {
    error_ui = 1,
    id = 2197,
    tips = "拉黑成功",
    type = "CLIENT_2197"
  },
  [2198] = {
    error_ui = 1,
    id = 2198,
    tips = "未搜索到相关玩家",
    type = "CLIENT_2198"
  },
  [2199] = {
    error_ui = 1,
    id = 2199,
    tips = "可领取数量已达上限",
    type = "CLIENT_2199"
  },
  [2200] = {
    error_ui = 1,
    id = 2200,
    tips = "该物品已领取",
    type = "CLIENT_2200"
  },
  [2201] = {
    error_ui = 1,
    id = 2201,
    tips = "请先点击物品进行选中",
    type = "CLIENT_2201"
  },
  [2202] = {
    error_ui = 1,
    id = 2202,
    tips = "账号不能为空！",
    type = "CLIENT_2202"
  },
  [2203] = {
    error_ui = 1,
    id = 2203,
    tips = "普通邮件已满",
    type = "CLIENT_2203"
  },
  [2204] = {
    error_ui = 1,
    id = 2204,
    tips = "取消重要",
    type = "CLIENT_2204"
  },
  [2205] = {
    error_ui = 1,
    id = 2205,
    tips = "邮件过期，已删除",
    type = "CLIENT_2205"
  },
  [2206] = {
    error_ui = 1,
    id = 2206,
    tips = "设为重要",
    type = "CLIENT_2206"
  },
  [2207] = {
    error_ui = 1,
    id = 2207,
    tips = "邮件已过期",
    type = "CLIENT_2207"
  },
  [2208] = {
    error_ui = 1,
    id = 2208,
    tips = "无相关邮件",
    type = "CLIENT_2208"
  },
  [2209] = {
    error_ui = 1,
    id = 2209,
    tips = "楔石碎片不足",
    type = "CLIENT_2209"
  },
  [2210] = {
    error_ui = 1,
    id = 2210,
    tips = "购买等级成功",
    type = "CLIENT_2210"
  },
  [2211] = {
    error_ui = 1,
    id = 2211,
    tips = "不可超过9字",
    type = "CLIENT_2211"
  },
  [2212] = {
    error_ui = 1,
    id = 2212,
    tips = "昵称不允许为空",
    type = "CLIENT_2212"
  },
  [2213] = {
    error_ui = 1,
    id = 2213,
    tips = "改名卡不足",
    type = "CLIENT_2213"
  },
  [2214] = {
    error_ui = 1,
    id = 2214,
    tips = "至少输入1个字",
    type = "CLIENT_2214"
  },
  [2215] = {
    error_ui = 1,
    id = 2215,
    tips = "不可超过15字",
    type = "CLIENT_2215"
  },
  [2216] = {
    error_ui = 1,
    id = 2216,
    tips = "明度不足",
    type = "CLIENT_2216"
  },
  [2217] = {
    error_ui = 1,
    id = 2217,
    tips = "首发位置不能为空",
    type = "CLIENT_2217"
  },
  [2218] = {
    error_ui = 1,
    id = 2218,
    tips = "参数异常，请重试",
    type = "CLIENT_2218"
  },
  [2219] = {
    error_ui = 1,
    id = 2219,
    tips = "当前编队已满",
    type = "CLIENT_2219"
  },
  [2220] = {
    error_ui = 1,
    id = 2220,
    tips = "请使用正常名字",
    type = "CLIENT_2220"
  },
  [2221] = {
    error_ui = 1,
    id = 2221,
    tips = "名字太长了",
    type = "CLIENT_2221"
  },
  [2222] = {
    error_ui = 1,
    id = 2222,
    tips = "角色潜能已满，多余理型已转换",
    type = "CLIENT_2222"
  },
  [2223] = {
    error_ui = 1,
    id = 2223,
    tips = "已达上限",
    type = "CLIENT_2223"
  },
  [2224] = {
    error_ui = 1,
    id = 2224,
    tips = "使用数量需大于1",
    type = "CLIENT_2224"
  },
  [2225] = {
    error_ui = 1,
    id = 2225,
    tips = "道具数量不足",
    type = "CLIENT_2225"
  },
  [2226] = {
    error_ui = 1,
    id = 2226,
    tips = "请选择道具",
    type = "CLIENT_2226"
  },
  [2227] = {
    error_ui = 1,
    id = 2227,
    tips = "未选择要合成的物品",
    type = "CLIENT_2227"
  },
  [2228] = {
    error_ui = 1,
    id = 2228,
    tips = "已达下限",
    type = "CLIENT_2228"
  },
  [2229] = {
    error_ui = 1,
    id = 2229,
    tips = "兑换成功",
    type = "CLIENT_2229"
  },
  [2230] = {
    error_ui = 1,
    id = 2230,
    tips = "暂无公告",
    type = "CLIENT_2230"
  },
  [2231] = {
    error_ui = 1,
    id = 2231,
    tips = "已达本日上限",
    type = "CLIENT_2231"
  },
  [2232] = {
    error_ui = 1,
    id = 2232,
    tips = "请选择助理",
    type = "CLIENT_2232"
  },
  [2233] = {
    error_ui = 1,
    id = 2233,
    tips = "不能重复设置同一助理",
    type = "CLIENT_2233"
  },
  [2234] = {
    error_ui = 1,
    id = 2234,
    tips = "取出成功",
    type = "CLIENT_2234"
  },
  [2235] = {
    error_ui = 1,
    id = 2235,
    tips = "暂不支持装饰",
    type = "CLIENT_2235"
  },
  [2236] = {
    error_ui = 1,
    id = 2236,
    tips = "不能关注自己",
    type = "CLIENT_2236"
  },
  [2237] = {
    error_ui = 1,
    id = 2237,
    tips = "检索次数不足",
    type = "CLIENT_2237"
  },
  [2238] = {
    error_ui = 1,
    id = 2238,
    tips = "请先选择角色",
    type = "CLIENT_2238"
  },
  [2239] = {
    error_ui = 1,
    id = 2239,
    tips = "请输入公会名称！",
    type = "CLIENT_2239"
  },
  [2240] = {
    error_ui = 1,
    id = 2240,
    tips = "创建公会成功！",
    type = "CLIENT_2240"
  },
  [2241] = {
    error_ui = 1,
    id = 2241,
    tips = "本源品质过高，无法安装",
    type = "CLIENT_2241"
  },
  [2242] = {
    error_ui = 1,
    id = 2242,
    tips = "已安装同名本源",
    type = "CLIENT_2242"
  },
  [2243] = {
    error_ui = 1,
    id = 2243,
    tips = "未解锁",
    type = "CLIENT_2243"
  },
  [2244] = {
    error_ui = 1,
    id = 2244,
    tips = "暂无未上锁材料",
    type = "CLIENT_2244"
  },
  [2245] = {
    error_ui = 1,
    id = 2245,
    tips = "请选择难度",
    type = "CLIENT_2245"
  },
  [2246] = {
    error_ui = 1,
    id = 2246,
    tips = "解锁条件未达到",
    type = "CLIENT_2246"
  },
  [2247] = {
    error_ui = 1,
    id = 2247,
    tips = "完成前置问题后解锁",
    type = "CLIENT_2247"
  },
  [2248] = {
    error_ui = 1,
    id = 2248,
    tips = "当前任务已完成",
    type = "CLIENT_2248"
  },
  [2249] = {
    error_ui = 1,
    id = 2249,
    tips = "不可上阵相同角色",
    type = "CLIENT_2249"
  },
  [2250] = {
    error_ui = 1,
    id = 2250,
    tips = "线索不足",
    type = "CLIENT_2250"
  },
  [2251] = {
    error_ui = 1,
    id = 2251,
    tips = "达到加速上限",
    type = "CLIENT_2251"
  },
  [2252] = {
    error_ui = 1,
    id = 2252,
    tips = "仓库暂无收获",
    type = "CLIENT_2252"
  },
  [2253] = {
    error_ui = 1,
    id = 2253,
    tips = "舱室未解锁",
    type = "CLIENT_2253"
  },
  [2254] = {
    error_ui = 1,
    id = 2254,
    tips = "已达数量上限",
    type = "CLIENT_2254"
  },
  [2255] = {
    error_ui = 1,
    id = 2255,
    tips = "完成一次挑战后开启",
    type = "CLIENT_2255"
  },
  [2256] = {
    error_ui = 1,
    id = 2256,
    tips = "请先结算本章无尽",
    type = "CLIENT_2256"
  },
  [2257] = {
    error_ui = 1,
    id = 2257,
    tips = "未达到星级解锁条件",
    type = "CLIENT_2257"
  },
  [2258] = {
    error_ui = 1,
    id = 2258,
    tips = "暂无插件",
    type = "CLIENT_2258"
  },
  [2259] = {
    error_ui = 1,
    id = 2259,
    tips = "不存在满足条件的物品",
    type = "CLIENT_2259"
  },
  [2260] = {
    error_ui = 1,
    id = 2260,
    tips = "古痕已到达最高品质",
    type = "CLIENT_2260"
  },
  [2261] = {
    error_ui = 1,
    id = 2261,
    tips = "无可用物品",
    type = "CLIENT_2261"
  },
  [2262] = {
    error_ui = 1,
    id = 2262,
    tips = "暂无可重刻属性",
    type = "CLIENT_2262"
  },
  [2263] = {
    error_ui = 1,
    id = 2263,
    tips = "没有可放入消耗",
    type = "CLIENT_2263"
  },
  [2264] = {
    error_ui = 1,
    id = 2264,
    tips = "单次消耗已达上限",
    type = "CLIENT_2264"
  },
  [2265] = {
    error_ui = 1,
    id = 2265,
    tips = "已达等级上限",
    type = "CLIENT_2265"
  },
  [2266] = {
    error_ui = 1,
    id = 2266,
    tips = "重刻完成",
    type = "CLIENT_2266"
  },
  [2267] = {
    error_ui = 1,
    id = 2267,
    tips = "无布局改动",
    type = "CLIENT_2267"
  },
  [2268] = {
    error_ui = 1,
    id = 2268,
    tips = "按钮布局冲突",
    type = "CLIENT_2268"
  },
  [2269] = {
    error_ui = 1,
    id = 2269,
    tips = "新增成功",
    type = "CLIENT_2269"
  },
  [2270] = {
    error_ui = 1,
    id = 2270,
    tips = "删除成功",
    type = "CLIENT_2270"
  },
  [2271] = {
    error_ui = 1,
    id = 2271,
    tips = "名字重复,请重新输入",
    type = "CLIENT_2271"
  },
  [2272] = {
    error_ui = 1,
    id = 2272,
    tips = "已售罄",
    type = "CLIENT_2272"
  },
  [2273] = {
    error_ui = 1,
    id = 2273,
    tips = "已过期，无法购买！",
    type = "CLIENT_2273"
  },
  [2274] = {
    error_ui = 1,
    id = 2274,
    tips = "剩余天数已达上限！",
    type = "CLIENT_2274"
  },
  [2275] = {
    error_ui = 1,
    id = 2275,
    tips = "购买失败",
    type = "CLIENT_2275"
  },
  [2276] = {
    error_ui = 1,
    id = 2276,
    tips = "购买失败, 未在购买时间内",
    type = "CLIENT_2276"
  },
  [2277] = {
    error_ui = 1,
    id = 2277,
    tips = "不在购买时间内",
    type = "CLIENT_2277"
  },
  [2278] = {
    error_ui = 1,
    id = 2278,
    tips = "通关上一难度后解锁",
    type = "CLIENT_2278"
  },
  [2279] = {
    error_ui = 1,
    id = 2279,
    tips = "该牌未解锁",
    type = "CLIENT_2279"
  },
  [2280] = {
    error_ui = 1,
    id = 2280,
    tips = "活动玩法已结束！",
    type = "CLIENT_2280"
  },
  [2281] = {
    error_ui = 1,
    id = 2281,
    tips = "没有战利品",
    type = "CLIENT_2281"
  },
  [2282] = {
    error_ui = 1,
    id = 2282,
    tips = "无可展示图片",
    type = "CLIENT_2282"
  },
  [2283] = {
    error_ui = 1,
    id = 2283,
    tips = "请击败该层领袖",
    type = "CLIENT_2283"
  },
  [2284] = {
    error_ui = 1,
    id = 2284,
    tips = "该角色未镶嵌符文",
    type = "CLIENT_2284"
  },
  [2285] = {
    error_ui = 1,
    id = 2285,
    tips = "不能购买相同饰品",
    type = "CLIENT_2285"
  },
  [2286] = {
    error_ui = 1,
    id = 2286,
    tips = "不能购买相同奇珍",
    type = "CLIENT_2286"
  },
  [2287] = {
    error_ui = 1,
    id = 2287,
    tips = "剩余次数不足",
    type = "CLIENT_2287"
  },
  [2288] = {
    error_ui = 1,
    id = 2288,
    tips = "片语等级已满",
    type = "CLIENT_2288"
  },
  [2289] = {
    error_ui = 1,
    id = 2289,
    tips = "当前不需要恢复",
    type = "CLIENT_2289"
  },
  [2290] = {
    error_ui = 1,
    id = 2290,
    tips = "无可升级片语",
    type = "CLIENT_2290"
  },
  [2291] = {
    error_ui = 1,
    id = 2291,
    tips = "次数不足",
    type = "CLIENT_2291"
  },
  [2292] = {
    error_ui = 1,
    id = 2292,
    tips = "诅咒值不足",
    type = "CLIENT_2292"
  },
  [2293] = {
    error_ui = 1,
    id = 2293,
    tips = "能力未收录",
    type = "CLIENT_2293"
  },
  [2294] = {
    error_ui = 1,
    id = 2294,
    tips = "命运之匣不足",
    type = "CLIENT_2294"
  },
  [2295] = {
    error_ui = 1,
    id = 2295,
    tips = "请通关故事模式",
    type = "CLIENT_2295"
  },
  [2296] = {
    error_ui = 1,
    id = 2296,
    tips = "通关前置难度",
    type = "CLIENT_2296"
  },
  [2297] = {
    error_ui = 1,
    id = 2297,
    tips = "点数不足！",
    type = "CLIENT_2297"
  },
  [2298] = {
    error_ui = 1,
    id = 2298,
    tips = "该公会人数已满！",
    type = "CLIENT_2298"
  },
  [2299] = {
    error_ui = 1,
    id = 2299,
    tips = "该邀请已过期！",
    type = "CLIENT_2299"
  },
  [2300] = {
    error_ui = 1,
    id = 2300,
    tips = "加入公会成功！",
    type = "CLIENT_2300"
  },
  [2301] = {
    error_ui = 1,
    id = 2301,
    tips = "公会人数已满！",
    type = "CLIENT_2301"
  },
  [2302] = {
    error_ui = 1,
    id = 2302,
    tips = "操作过于频繁，请稍后再试！",
    type = "CLIENT_2302"
  },
  [2303] = {
    error_ui = 1,
    id = 2303,
    tips = "玩家已加入公会",
    type = "CLIENT_2303"
  },
  [2304] = {
    error_ui = 1,
    id = 2304,
    tips = "邀请成功！",
    type = "CLIENT_2304"
  },
  [2305] = {
    error_ui = 1,
    id = 2305,
    tips = "请先转让会长！",
    type = "CLIENT_2305"
  },
  [2306] = {
    error_ui = 1,
    id = 2306,
    tips = "请离成功！",
    type = "CLIENT_2306"
  },
  [2307] = {
    error_ui = 1,
    id = 2307,
    tips = "会长转让成功！",
    type = "CLIENT_2307"
  },
  [2308] = {
    error_ui = 1,
    id = 2308,
    tips = "当前成员已不在公会！",
    type = "CLIENT_2308"
  },
  [2309] = {
    error_ui = 1,
    id = 2309,
    tips = "已经是好友了！",
    type = "CLIENT_2309"
  },
  [2310] = {
    error_ui = 1,
    id = 2310,
    tips = "已发送申请！",
    type = "CLIENT_2310"
  },
  [2311] = {
    error_ui = 1,
    id = 2311,
    tips = "搜索不到成员！",
    type = "CLIENT_2311"
  },
  [2312] = {
    error_ui = 1,
    id = 2312,
    tips = "你已发送申请！",
    type = "CLIENT_2312"
  },
  [2313] = {
    error_ui = 1,
    id = 2313,
    tips = "当前公会人数已满！",
    type = "CLIENT_2313"
  },
  [2314] = {
    error_ui = 1,
    id = 2314,
    tips = "{1}不足",
    type = "CLIENT_2314"
  },
  [2315] = {
    error_ui = 1,
    id = 2315,
    tips = "一次最多使用{1}个道具",
    type = "CLIENT_2315"
  },
  [2316] = {
    error_ui = 1,
    id = 2316,
    tips = "同调{1}级解锁",
    type = "CLIENT_2316"
  },
  [2317] = {
    error_ui = 1,
    id = 2317,
    tips = "武器等级提升",
    type = "CLIENT_2317"
  },
  [2318] = {
    error_ui = 1,
    id = 2318,
    tips = "至少上阵{1}名角色",
    type = "CLIENT_2318"
  },
  [2319] = {
    error_ui = 1,
    id = 2319,
    tips = "单次最大可分解{1}件",
    type = "CLIENT_2319"
  },
  [2320] = {
    error_ui = 1,
    id = 2320,
    tips = "{1}不得超过{2}",
    type = "CLIENT_2320"
  },
  [2321] = {
    error_ui = 1,
    id = 2321,
    tips = "贸易站{1}级解锁",
    type = "CLIENT_2321"
  },
  [2322] = {
    error_ui = 1,
    id = 2322,
    tips = "{1}后解锁",
    type = "CLIENT_2322"
  },
  [2323] = {
    error_ui = 1,
    id = 2323,
    tips = "突破{1}后解锁",
    type = "CLIENT_2323"
  },
  [2324] = {
    error_ui = 1,
    id = 2324,
    tips = "好感度Lv{1}级解锁",
    type = "CLIENT_2324"
  },
  [2325] = {
    error_ui = 1,
    id = 2325,
    tips = "通关{1}后解锁",
    type = "CLIENT_2325"
  },
  [2326] = {
    error_ui = 1,
    id = 2326,
    tips = "{1}数量不足",
    type = "CLIENT_2326"
  },
  [2327] = {
    error_ui = 1,
    id = 2327,
    tips = "提交成功",
    type = "CLIENT_2327"
  },
  [2328] = {
    error_ui = 1,
    id = 2328,
    tips = "提交失败",
    type = "CLIENT_2328"
  },
  [2329] = {
    error_ui = 1,
    id = 2329,
    tips = "跳转成功",
    type = "CLIENT_2329"
  },
  [2330] = {
    error_ui = 1,
    id = 2330,
    tips = "跳转失败",
    type = "CLIENT_2330"
  },
  [2331] = {
    error_ui = 1,
    id = 2331,
    tips = "请选择需要重塑的武器",
    type = "CLIENT_2331"
  },
  [2332] = {
    error_ui = 1,
    id = 2332,
    tips = "冷却中，稍后再试",
    type = "CLIENT_2332"
  },
  [2333] = {
    error_ui = 1,
    id = 2333,
    tips = "现在还不能传送",
    type = "CLIENT_2333"
  },
  [2334] = {
    error_ui = 1,
    id = 2334,
    tips = "对方好友达上限",
    type = "CLIENT_2334"
  },
  [2335] = {
    error_ui = 1,
    id = 2335,
    tips = "已方好友达上限",
    type = "CLIENT_2335"
  },
  [2336] = {
    error_ui = 1,
    id = 2336,
    tips = "暂不支持搜索自己",
    type = "CLIENT_2336"
  },
  [2337] = {
    error_ui = 1,
    id = 2337,
    tips = "佩戴成功",
    type = "CLIENT_2337"
  },
  [2338] = {
    error_ui = 1,
    id = 2338,
    tips = "称号已卸下",
    type = "CLIENT_2338"
  },
  [2339] = {
    error_ui = 1,
    id = 2339,
    tips = "称号未解锁",
    type = "CLIENT_2339"
  },
  [2340] = {
    error_ui = 1,
    id = 2340,
    tips = "助战角色",
    type = "CLIENT_2340"
  },
  [2341] = {
    error_ui = 1,
    id = 2341,
    tips = "已固定角色出战",
    type = "CLIENT_2341"
  },
  [2342] = {
    error_ui = 1,
    id = 2342,
    tips = "已使用同角色出战",
    type = "CLIENT_2342"
  },
  [2343] = {
    error_ui = 1,
    id = 2343,
    tips = "数量不足",
    type = "CLIENT_2343"
  },
  [2344] = {
    error_ui = 1,
    id = 2344,
    tips = "请选择需要分解的本源",
    type = "CLIENT_2344"
  },
  [2345] = {
    error_ui = 1,
    id = 2345,
    tips = "请选择需要分解的武器",
    type = "CLIENT_2345"
  },
  [2346] = {
    error_ui = 1,
    id = 2346,
    tips = "未开放",
    type = "CLIENT_2346"
  },
  [2347] = {
    error_ui = 1,
    id = 2347,
    tips = "通关前置关卡",
    type = "CLIENT_2347"
  },
  [2348] = {
    error_ui = 1,
    id = 2348,
    tips = "未选择必选组",
    type = "CLIENT_2348"
  },
  [2349] = {
    error_ui = 1,
    id = 2349,
    tips = "不在开放时间内",
    type = "CLIENT_2349"
  },
  [2350] = {
    error_ui = 1,
    id = 2350,
    tips = "未选择插件",
    type = "CLIENT_2350"
  },
  [2351] = {
    error_ui = 1,
    id = 2351,
    tips = "重刻成功",
    type = "CLIENT_2351"
  },
  [2352] = {
    error_ui = 1,
    id = 2352,
    tips = "未选择材料",
    type = "CLIENT_2352"
  },
  [2353] = {
    error_ui = 1,
    id = 2353,
    tips = "商店未开启，敬请期待",
    type = "CLIENT_2353"
  },
  [2354] = {
    error_ui = 1,
    id = 2354,
    ignore_tips = 1,
    tips = "签名未生成",
    type = "XICODE_SIGN_NOT_FIND"
  },
  [2355] = {
    error_ui = 1,
    id = 2355,
    ignore_tips = 1,
    tips = "签名效验错误",
    type = "XICODE_SIGN_ERROR"
  },
  [2356] = {
    error_ui = 1,
    id = 2356,
    tips = "不能使用特殊符号",
    type = "CLIENT_2356"
  },
  [2357] = {
    error_ui = 1,
    id = 2357,
    tips = "关卡未开启",
    type = "PUZZLE_GAME_EPISODE_NOT_OPEN"
  },
  [2358] = {
    error_ui = 1,
    id = 2358,
    ignore_tips = 1,
    tips = "触发敏感字",
    type = "SENSITIVE_WORDS"
  },
  [2359] = {
    error_ui = 1,
    id = 2359,
    ignore_tips = 1,
    tips = "服务器注册人数上限",
    type = "SERVER_REGISTER_LIMIT"
  },
  [2360] = {
    error_ui = 1,
    id = 2360,
    tips = "训练成功",
    type = "CLIENT_2360"
  },
  [2361] = {
    error_ui = 1,
    id = 2361,
    ignore_tips = 1,
    tips = "无法购买此商品",
    type = "RECHARGE_PROJECT_IS_BAN"
  },
  [2362] = {
    error_ui = 1,
    id = 2362,
    tips = "古痕已满",
    type = "CLIENT_2362"
  },
  [2363] = {
    error_ui = 1,
    id = 2363,
    tips = "试用关卡未完成",
    type = "CLIENT_2363"
  },
  [2364] = {
    error_ui = 1,
    id = 2364,
    tips = "活动章未开放",
    type = "ACTY_MUSIC_GAME_NOT_OPEN"
  },
  [2365] = {
    error_ui = 1,
    id = 2365,
    tips = "活动节未开放",
    type = "ACTY_MUSCI_GAME_EPISODE_NOT_OPEN"
  },
  [2366] = {
    error_ui = 1,
    id = 2366,
    tips = "检测到当前楔石数量为负，楔石碎片无法使用，补足楔石数量≥0后恢复正常使用！",
    type = "NOT_TO_USE_DIAMOND"
  },
  [2367] = {
    error_ui = 1,
    id = 2367,
    tips = "角色突破二后解锁",
    type = "CLIENT_2367"
  },
  [2368] = {
    error_ui = 1,
    id = 2368,
    tips = "能力重塑次数已达上限",
    type = "ABILITY_REMODELING_MAX"
  },
  [2369] = {
    error_ui = 1,
    id = 2369,
    tips = "已被其他人使用",
    type = "CD_KEY_IS_USER"
  },
  [2370] = {
    error_ui = 1,
    id = 2370,
    tips = "兑换失败",
    type = "USE_SDK_CONPON_ERROR"
  },
  [2371] = {
    error_ui = 1,
    id = 2371,
    tips = "未通过关卡，无法查看",
    type = "CLIENT_2371"
  },
  [2472] = {
    error_ui = 1,
    id = 2472,
    tips = "没有可领取奖励",
    type = "COMPENSATE_NOT_AWARD"
  },
  [2573] = {
    error_ui = 1,
    id = 2573,
    tips = "当前已有高维演算生效",
    type = "EXIST_BATTLE_PASS_68"
  },
  [2674] = {
    error_ui = 1,
    id = 2674,
    tips = "当前已有高维演算生效",
    type = "EXIST_BATTLE_PASS_128"
  },
  [2775] = {
    error_ui = 1,
    id = 2775,
    tips = "存档名称字符长度过长",
    type = "CURSE_SAVE_NAME_MAX_LEN"
  },
  [2776] = {
    error_ui = 1,
    id = 2776,
    tips = "网络不佳",
    type = "CLIENT_2776"
  },
  [2777] = {
    error_ui = 1,
    id = 2777,
    tips = "不在活动时间内",
    type = "CLIENT_2777"
  },
  [2778] = {
    error_ui = 1,
    id = 2778,
    tips = "传送超时，即将返回主界面",
    type = "CLIENT_2778"
  },
  [2779] = {
    error_ui = 1,
    id = 2779,
    tips = "脱离卡死成功",
    type = "CLIENT_2779"
  },
  [2780] = {
    error_ui = 1,
    id = 2780,
    tips = "脱离卡死失败",
    type = "CLIENT_2780"
  },
  [2781] = {
    error_ui = 1,
    id = 2781,
    tips = "切换成功",
    type = "CLIENT_2781"
  },
  [2782] = {
    error_ui = 1,
    id = 2782,
    tips = "GM进入塔 信息有误",
    type = "CLIENT_2782"
  },
  [2783] = {
    error_ui = 1,
    id = 2783,
    tips = "该难度未解锁",
    type = "CLIENT_2783"
  },
  [2784] = {
    error_ui = 1,
    id = 2784,
    tips = "该关卡未解锁",
    type = "CLIENT_2784"
  },
  [2785] = {
    error_ui = 1,
    id = 2785,
    tips = "只可上阵一个助战角色",
    type = "CLIENT_2785"
  },
  [2786] = {
    error_ui = 1,
    id = 2786,
    tips = "超出加速时间上限制",
    type = "CLIENT_2786"
  },
  [2787] = {
    error_ui = 1,
    id = 2787,
    tips = "重铸成功",
    type = "CLIENT_2787"
  },
  [2788] = {
    error_ui = 1,
    id = 2788,
    tips = "请求过于频繁，请稍后再试",
    type = "TSI_SDK_RECHARGE_ERROR_1"
  },
  [2789] = {
    error_ui = 1,
    id = 2789,
    tips = "账号不存在，请核对后重新输入",
    type = "TSI_SDK_RECHARGE_ERROR_2"
  },
  [2790] = {
    error_ui = 1,
    id = 2790,
    tips = "账号信息不完整，请至会员中心补填",
    type = "TSI_SDK_RECHARGE_ERROR_3"
  },
  [2791] = {
    error_ui = 1,
    id = 2791,
    tips = "你的年龄未满8岁，无法进行本次充值",
    type = "TSI_SDK_RECHARGE_ERROR_4"
  },
  [2792] = {
    error_ui = 1,
    id = 2792,
    tips = "您已经超过未满16岁单次充值最大额度",
    type = "TSI_SDK_RECHARGE_ERROR_5"
  },
  [2793] = {
    error_ui = 1,
    id = 2793,
    tips = "您已经超过未满16岁本月充值最大额度",
    type = "TSI_SDK_RECHARGE_ERROR_6"
  },
  [2794] = {
    error_ui = 1,
    id = 2794,
    tips = "您已经超过未满18岁单次充值最大额度",
    type = "TSI_SDK_RECHARGE_ERROR_7"
  },
  [2795] = {
    error_ui = 1,
    id = 2795,
    tips = "您已经超过未满18岁本月充值最大额度",
    type = "TSI_SDK_RECHARGE_ERROR_8"
  },
  [2796] = {
    error_ui = 1,
    id = 2796,
    tips = "您的操作行为过于频繁，请稍后再次尝试",
    type = "TSI_SDK_RECHARGE_ERROR_9"
  },
  [2797] = {
    error_ui = 1,
    id = 2797,
    tips = "检测到您的账号存在安全性风险，请稍后再试",
    type = "TSI_SDK_RECHARGE_ERROR_10"
  },
  [2798] = {
    error_ui = 1,
    id = 2798,
    tips = "此兑换码无法在该平台使用",
    type = "TSI_COUPON_NOT_TO_USE_PLATFORM"
  },
  [2799] = {
    error_ui = 1,
    id = 2799,
    tips = "此关卡未开放",
    type = "ACTIVITY_MINI_GAME_NOT_OPEN"
  },
  [2800] = {
    error_ui = 1,
    id = 2800,
    tips = "该账号在别处登录",
    type = "CLIENT_2788"
  },
  [2801] = {
    error_ui = 1,
    id = 2801,
    tips = "服务器关闭",
    type = "CLIENT_2789"
  },
  [2802] = {
    error_ui = 1,
    id = 2802,
    tips = "该账号已被封禁",
    type = "CLIENT_2790"
  },
  [2803] = {
    error_ui = 1,
    id = 2803,
    tips = "与服务器断开连接",
    type = "CLIENT_2791"
  },
  [2804] = {
    error_ui = 1,
    id = 2804,
    tips = "该角色无法回退培养",
    type = "BUDDY_DEVELOP_NOT_CALL_BACK"
  },
  [2805] = {
    error_ui = 1,
    id = 2805,
    tips = "该武器无法回退培养",
    type = "WEAPON_DEVELOP_NOT_CALL_BACK"
  },
  [2806] = {
    error_ui = 1,
    id = 2806,
    tips = "没有回退培养奖励",
    type = "NOT_TO_FIND_DEVELOP_AWARD"
  },
  [2807] = {
    error_ui = 1,
    id = 2807,
    tips = "已被怪物发现",
    type = "ACTMINE_NEAR_ENEMY"
  },
  [2808] = {
    error_ui = 1,
    id = 2808,
    tips = "刷新时间过快",
    type = "MINESWEEPER_FLUSH_FREQUENT"
  },
  [2809] = {
    error_ui = 1,
    id = 2809,
    tips = "请通关当前关卡",
    type = "CLIENT_2809"
  },
  [2810] = {
    error_ui = 1,
    id = 2810,
    tips = "当前体力已满",
    type = "CLIENT_2810"
  },
  [2811] = {
    error_ui = 1,
    id = 2811,
    tips = "无法助力此玩家",
    type = "NOT_ASSIST_FREESTAMINE_UUID"
  },
  [60002] = {
    error_ui = 1,
    id = 60002,
    tips = "该玩家不存在",
    type = "ROLE_NOT_EXIST"
  },
  [60003] = {
    error_ui = 1,
    id = 60003,
    ignore_tips = 1,
    tips = "请求超时",
    type = "RPC_TIMEOUT"
  },
  [60009] = {
    error_ui = 0,
    id = 60009,
    ignore_tips = 1,
    tips = "请求失败",
    type = "RPC_FAILD"
  },
  [60040] = {
    error_ui = 0,
    id = 60040,
    ignore_tips = 1,
    tips = "发送缓存不足",
    type = "SEND_CACHE_SHORTED"
  },
  [60041] = {
    error_ui = 0,
    id = 60041,
    ignore_tips = 1,
    tips = "发送字节小于接收字节",
    type = "SENDBYTES_LT_RECVBYTES"
  },
  ABILITY_GAINED = nil,
  ABILITY_GRADE_IN_LINIT = nil,
  ABILITY_REMODELING_MAX = nil,
  ACCOUNT_ID_CARD_ERROR = nil,
  ACCOUNT_INFO_ERR = nil,
  ACHIEVEMENT_GROUNP_AWARD_REPLACE = nil,
  ACHIEVEMENT_GROUNP_NOT_AWARD = nil,
  ACHIEVEMENT_GROUNP_NOT_COMPLETE = nil,
  ACHIEVEMENT_PROGRESS_TASK_NOT_FOUND = nil,
  ACTIVITY_AWARD_GAINED = nil,
  ACTIVITY_CURSE_LOCKED = nil,
  ACTIVITY_CURSE_PRE_BLESS_LOCK = nil,
  ACTIVITY_DISVALID_DURATION = nil,
  ACTIVITY_END = nil,
  ACTIVITY_LEVEL_AWARD_GAINED = nil,
  ACTIVITY_MINI_GAME_NOT_OPEN = nil,
  ACTIVITY_NOT_FOUND = nil,
  ACTIVITY_SIGN_IN_AWARD_NOT_OPEN = nil,
  ACTIVITY_SIGN_IN_GAINED = nil,
  ACTIVITY_TASK_NO_DONE = nil,
  ACTMINE_NEAR_ENEMY = nil,
  ACTY_MUSCI_GAME_EPISODE_NOT_OPEN = nil,
  ACTY_MUSIC_GAME_NOT_OPEN = nil,
  ACTY_NO_EXISTEN = nil,
  ACTY_NO_OPEN = nil,
  ADVENTURE_CHECK_BUDDY_ERROE = nil,
  ALBUM_LOCK = nil,
  ALL_CHAT_CHANNEL_CROWDED = nil,
  ALREADY_APPLIED = nil,
  ALREADY_FRIEND = nil,
  ALREADY_LOGIN = nil,
  ALREADY_MATCH = nil,
  ALREADY_ON_BLACKLIST = nil,
  APPLY_FRIEND_CD = nil,
  ARCH_NO_EXISTEM = nil,
  ARCH_NO_OPEN = nil,
  ASSISTANT_HAVE_JOB = nil,
  ASSISTANT_MAX_LV = nil,
  ASSIST_BUDDY_INDEX = nil,
  ASSIST_BUDDY_RESHRESH_IN_CD = nil,
  ASSIST_ELEMENT_NOT_FOUND = nil,
  ASSIST_FIGHT_ELEMENT_NOT_PUSH = nil,
  ATTACHMENT_NOT_GET = nil,
  ATTACKER_NOT_ALIVE = nil,
  ATTACKER_NOT_FOUND = nil,
  ATTACKER_SKILL_NOT_FOUND = nil,
  AWARD_GROUP_NOT_FIND = nil,
  AWARD_NOT_FIND = nil,
  BAG_NOT_ENOUGHT = nil,
  BAG_OVERFLOW = nil,
  BATTLE_NETWORK_ERR = nil,
  BATTLE_PASS_NOT_OPEN = nil,
  BATTLE_PASS_NOT_OPEN_CIRCULATE_AWARD = nil,
  BATTLE_PASS_NOT_REACH_MAX_GRADE = nil,
  BATTLE_SHOP_NOT_FIND = nil,
  BATTLE_SKILL_MAJOR_NOT_FOUND = nil,
  BATTLE_SKILL_MISMATCH = nil,
  BATTLE_SKILL_NOT_FOUND = nil,
  BATTLE_SKILL_NOT_SELECT = nil,
  BATTLE_SKILL_POINT_NOT_ENOUGHT = nil,
  BATTLE_TREASURE_NOT_FIND = nil,
  BIRTHDAY_HAD_SET = nil,
  BLACKLIST_CANT_OPERATE_ON_SELF = nil,
  BLACKLIST_NUM_LIMIT = nil,
  BLESS_POS_LOCK = nil,
  BOSS_FIGHT_EPISODE_NOT_OPEN = nil,
  BREAKABLE_ID_INVAILD = nil,
  BUDDY_DEVELOP_NOT_CALL_BACK = nil,
  BUDDY_FASHION_NOT_FOUND = nil,
  BUDDY_FASHION_READ_REPEAT = nil,
  BUDDY_FASHION_WEAR_REPEAT = nil,
  BUDDY_MAX_ADVANCE_LV = nil,
  BUDDY_MAX_LV = nil,
  BUDDY_NOT_MAX_LV = nil,
  BUDDY_NOT_YET_GET = nil,
  BUDDY_REFINE_MAX_GRADE = nil,
  BUDDY_REFINE_NOT_MAX_GRADE = nil,
  BUDDY_RUNE_GRADE_MAX = nil,
  BUDDY_SET_ONE_RUNE = nil,
  BUDDY_TALENT_MAX_LV = nil,
  BUDDY_VOICE_IS_UNLOCKED = nil,
  BUDDY_VOICE_NOT_UNLOCK = nil,
  BUILDING_ADVENTURE_STATE_ERROR = nil,
  BUILDING_ADVENTURE_TASK_NOT_FINISH = nil,
  BUILDING_ADVENTURE_TASK_NOT_GAINED = nil,
  BUILDING_ADVENTURE_USING_REPEAT_BUDDY = nil,
  BUILDING_FACTORY_FULL = nil,
  BUILDING_FACTORY_WORKING = nil,
  BUILDING_MAX_LEVEL = nil,
  BUSSINESS_CARD_NOT_ACTIVE = nil,
  BUSSINESS_CARD_NOT_WEAR = nil,
  BUY_BATTLE_PASS_LIMIT_GRADE = nil,
  BUY_GIFT_NEED_BY_SDK = nil,
  BUY_GOOD_LIMIT = nil,
  CANNOT_FIND_PLAYER = nil,
  CANT_ADD_SELF_AS_FRIEND = nil,
  CANT_APPLY_FRIEND_TO_SELF = nil,
  CANT_GET_SELF_INFO = nil,
  CANT_KICKOUT_YOURSELF = nil,
  CARD_EVENT_CONTIION_NOT_OPEN = nil,
  CASE_WITH_EXHIBIT_TYPE_NOT_MATA = nil,
  CDKEY_MAX_USE_CNT = nil,
  CDKEY_NOT_FIND = nil,
  CDKEY_USED = nil,
  CD_KEY_GET_MUTEX_REWARD = nil,
  CD_KEY_GIFT_EXPIRE = nil,
  CD_KEY_IN_BAN_STATUS = nil,
  CD_KEY_IS_USER = nil,
  CHALLENGE_CARD_CANT_CHOOSE = nil,
  CHALLENGE_CARD_CANT_UNLOCK = nil,
  CHALLENGE_CARD_ISNT_CHOOSE = nil,
  CHALLENGE_CARD_NOT_END = nil,
  CHALLENGE_CARD_NOT_FOUND = nil,
  CHALLENGE_CARD_POOL_IS_EMPTY = nil,
  CHALLENGE_CARD_UNLOCK_REPEAT = nil,
  CHALLENGE_NOT_ENOUGH = nil,
  CHALLENGE_NOT_START = nil,
  CHALLENGE_REPEAT = nil,
  CHALLENGE_RING_CIRCLE_NOT_FOUND = nil,
  CHALLENGE_START_REPEATE = nil,
  CHALLENG_MULTIPLE_NOT_MATCH = nil,
  CHALLENG_MULTIPLE_NOT_OPEN = nil,
  CHANGE_STATE_NOT_ROOM = nil,
  CHAPTER_NODE_LOCK = nil,
  CHAPTER_NODE_NOT_PASS = nil,
  CHAPTER_NODE_SETTLED = nil,
  CHAPTER_SETTLEMENTED = nil,
  CHARTLET_FRAME_REPEAT = nil,
  CHARTLET_REPEAT = nil,
  CHAT_CHANNEL_NO_EXIST = nil,
  CHAT_CHANNEL_ROLE_NUM_LIMIT = nil,
  CHAT_MSG_INCLUDE_SENSITIVE_WORDS = nil,
  CHAT_MSG_LEN_LIMITED = nil,
  CHILD_MISSILE_LIMIT_CNT = nil,
  CHOOSE_REWARD_NOT_ENABLED = nil,
  CLIENT_2043 = nil,
  CLIENT_2044 = nil,
  CLIENT_2045 = nil,
  CLIENT_2046 = nil,
  CLIENT_2047 = nil,
  CLIENT_2048 = nil,
  CLIENT_2049 = nil,
  CLIENT_2050 = nil,
  CLIENT_2051 = nil,
  CLIENT_2052 = nil,
  CLIENT_2053 = nil,
  CLIENT_2054 = nil,
  CLIENT_2055 = nil,
  CLIENT_2056 = nil,
  CLIENT_2057 = nil,
  CLIENT_2058 = nil,
  CLIENT_2059 = nil,
  CLIENT_2060 = nil,
  CLIENT_2061 = nil,
  CLIENT_2062 = nil,
  CLIENT_2063 = nil,
  CLIENT_2064 = nil,
  CLIENT_2065 = nil,
  CLIENT_2066 = nil,
  CLIENT_2067 = nil,
  CLIENT_2068 = nil,
  CLIENT_2069 = nil,
  CLIENT_2070 = nil,
  CLIENT_2071 = nil,
  CLIENT_2072 = nil,
  CLIENT_2073 = nil,
  CLIENT_2074 = nil,
  CLIENT_2075 = nil,
  CLIENT_2076 = nil,
  CLIENT_2077 = nil,
  CLIENT_2078 = nil,
  CLIENT_2079 = nil,
  CLIENT_2080 = nil,
  CLIENT_2081 = nil,
  CLIENT_2082 = nil,
  CLIENT_2083 = nil,
  CLIENT_2084 = nil,
  CLIENT_2085 = nil,
  CLIENT_2086 = nil,
  CLIENT_2087 = nil,
  CLIENT_2088 = nil,
  CLIENT_2089 = nil,
  CLIENT_2090 = nil,
  CLIENT_2091 = nil,
  CLIENT_2092 = nil,
  CLIENT_2093 = nil,
  CLIENT_2094 = nil,
  CLIENT_2095 = nil,
  CLIENT_2096 = nil,
  CLIENT_2097 = nil,
  CLIENT_2098 = nil,
  CLIENT_2099 = nil,
  CLIENT_2100 = nil,
  CLIENT_2101 = nil,
  CLIENT_2102 = nil,
  CLIENT_2103 = nil,
  CLIENT_2104 = nil,
  CLIENT_2105 = nil,
  CLIENT_2106 = nil,
  CLIENT_2107 = nil,
  CLIENT_2108 = nil,
  CLIENT_2109 = nil,
  CLIENT_2110 = nil,
  CLIENT_2111 = nil,
  CLIENT_2112 = nil,
  CLIENT_2113 = nil,
  CLIENT_2114 = nil,
  CLIENT_2115 = nil,
  CLIENT_2116 = nil,
  CLIENT_2117 = nil,
  CLIENT_2118 = nil,
  CLIENT_2119 = nil,
  CLIENT_2120 = nil,
  CLIENT_2121 = nil,
  CLIENT_2122 = nil,
  CLIENT_2123 = nil,
  CLIENT_2124 = nil,
  CLIENT_2125 = nil,
  CLIENT_2126 = nil,
  CLIENT_2127 = nil,
  CLIENT_2128 = nil,
  CLIENT_2129 = nil,
  CLIENT_2130 = nil,
  CLIENT_2131 = nil,
  CLIENT_2132 = nil,
  CLIENT_2133 = nil,
  CLIENT_2134 = nil,
  CLIENT_2135 = nil,
  CLIENT_2136 = nil,
  CLIENT_2137 = nil,
  CLIENT_2138 = nil,
  CLIENT_2139 = nil,
  CLIENT_2140 = nil,
  CLIENT_2141 = nil,
  CLIENT_2142 = nil,
  CLIENT_2143 = nil,
  CLIENT_2144 = nil,
  CLIENT_2145 = nil,
  CLIENT_2146 = nil,
  CLIENT_2147 = nil,
  CLIENT_2148 = nil,
  CLIENT_2149 = nil,
  CLIENT_2150 = nil,
  CLIENT_2151 = nil,
  CLIENT_2152 = nil,
  CLIENT_2153 = nil,
  CLIENT_2154 = nil,
  CLIENT_2155 = nil,
  CLIENT_2156 = nil,
  CLIENT_2157 = nil,
  CLIENT_2158 = nil,
  CLIENT_2159 = nil,
  CLIENT_2160 = nil,
  CLIENT_2161 = nil,
  CLIENT_2162 = nil,
  CLIENT_2163 = nil,
  CLIENT_2164 = nil,
  CLIENT_2165 = nil,
  CLIENT_2166 = nil,
  CLIENT_2167 = nil,
  CLIENT_2168 = nil,
  CLIENT_2169 = nil,
  CLIENT_2170 = nil,
  CLIENT_2171 = nil,
  CLIENT_2172 = nil,
  CLIENT_2173 = nil,
  CLIENT_2174 = nil,
  CLIENT_2175 = nil,
  CLIENT_2176 = nil,
  CLIENT_2177 = nil,
  CLIENT_2178 = nil,
  CLIENT_2179 = nil,
  CLIENT_2180 = nil,
  CLIENT_2181 = nil,
  CLIENT_2182 = nil,
  CLIENT_2183 = nil,
  CLIENT_2184 = nil,
  CLIENT_2185 = nil,
  CLIENT_2186 = nil,
  CLIENT_2187 = nil,
  CLIENT_2188 = nil,
  CLIENT_2189 = nil,
  CLIENT_2190 = nil,
  CLIENT_2191 = nil,
  CLIENT_2192 = nil,
  CLIENT_2193 = nil,
  CLIENT_2194 = nil,
  CLIENT_2195 = nil,
  CLIENT_2196 = nil,
  CLIENT_2197 = nil,
  CLIENT_2198 = nil,
  CLIENT_2199 = nil,
  CLIENT_2200 = nil,
  CLIENT_2201 = nil,
  CLIENT_2202 = nil,
  CLIENT_2203 = nil,
  CLIENT_2204 = nil,
  CLIENT_2205 = nil,
  CLIENT_2206 = nil,
  CLIENT_2207 = nil,
  CLIENT_2208 = nil,
  CLIENT_2209 = nil,
  CLIENT_2210 = nil,
  CLIENT_2211 = nil,
  CLIENT_2212 = nil,
  CLIENT_2213 = nil,
  CLIENT_2214 = nil,
  CLIENT_2215 = nil,
  CLIENT_2216 = nil,
  CLIENT_2217 = nil,
  CLIENT_2218 = nil,
  CLIENT_2219 = nil,
  CLIENT_2220 = nil,
  CLIENT_2221 = nil,
  CLIENT_2222 = nil,
  CLIENT_2223 = nil,
  CLIENT_2224 = nil,
  CLIENT_2225 = nil,
  CLIENT_2226 = nil,
  CLIENT_2227 = nil,
  CLIENT_2228 = nil,
  CLIENT_2229 = nil,
  CLIENT_2230 = nil,
  CLIENT_2231 = nil,
  CLIENT_2232 = nil,
  CLIENT_2233 = nil,
  CLIENT_2234 = nil,
  CLIENT_2235 = nil,
  CLIENT_2236 = nil,
  CLIENT_2237 = nil,
  CLIENT_2238 = nil,
  CLIENT_2239 = nil,
  CLIENT_2240 = nil,
  CLIENT_2241 = nil,
  CLIENT_2242 = nil,
  CLIENT_2243 = nil,
  CLIENT_2244 = nil,
  CLIENT_2245 = nil,
  CLIENT_2246 = nil,
  CLIENT_2247 = nil,
  CLIENT_2248 = nil,
  CLIENT_2249 = nil,
  CLIENT_2250 = nil,
  CLIENT_2251 = nil,
  CLIENT_2252 = nil,
  CLIENT_2253 = nil,
  CLIENT_2254 = nil,
  CLIENT_2255 = nil,
  CLIENT_2256 = nil,
  CLIENT_2257 = nil,
  CLIENT_2258 = nil,
  CLIENT_2259 = nil,
  CLIENT_2260 = nil,
  CLIENT_2261 = nil,
  CLIENT_2262 = nil,
  CLIENT_2263 = nil,
  CLIENT_2264 = nil,
  CLIENT_2265 = nil,
  CLIENT_2266 = nil,
  CLIENT_2267 = nil,
  CLIENT_2268 = nil,
  CLIENT_2269 = nil,
  CLIENT_2270 = nil,
  CLIENT_2271 = nil,
  CLIENT_2272 = nil,
  CLIENT_2273 = nil,
  CLIENT_2274 = nil,
  CLIENT_2275 = nil,
  CLIENT_2276 = nil,
  CLIENT_2277 = nil,
  CLIENT_2278 = nil,
  CLIENT_2279 = nil,
  CLIENT_2280 = nil,
  CLIENT_2281 = nil,
  CLIENT_2282 = nil,
  CLIENT_2283 = nil,
  CLIENT_2284 = nil,
  CLIENT_2285 = nil,
  CLIENT_2286 = nil,
  CLIENT_2287 = nil,
  CLIENT_2288 = nil,
  CLIENT_2289 = nil,
  CLIENT_2290 = nil,
  CLIENT_2291 = nil,
  CLIENT_2292 = nil,
  CLIENT_2293 = nil,
  CLIENT_2294 = nil,
  CLIENT_2295 = nil,
  CLIENT_2296 = nil,
  CLIENT_2297 = nil,
  CLIENT_2298 = nil,
  CLIENT_2299 = nil,
  CLIENT_2300 = nil,
  CLIENT_2301 = nil,
  CLIENT_2302 = nil,
  CLIENT_2303 = nil,
  CLIENT_2304 = nil,
  CLIENT_2305 = nil,
  CLIENT_2306 = nil,
  CLIENT_2307 = nil,
  CLIENT_2308 = nil,
  CLIENT_2309 = nil,
  CLIENT_2310 = nil,
  CLIENT_2311 = nil,
  CLIENT_2312 = nil,
  CLIENT_2313 = nil,
  CLIENT_2314 = nil,
  CLIENT_2315 = nil,
  CLIENT_2316 = nil,
  CLIENT_2317 = nil,
  CLIENT_2318 = nil,
  CLIENT_2319 = nil,
  CLIENT_2320 = nil,
  CLIENT_2321 = nil,
  CLIENT_2322 = nil,
  CLIENT_2323 = nil,
  CLIENT_2324 = nil,
  CLIENT_2325 = nil,
  CLIENT_2326 = nil,
  CLIENT_2327 = nil,
  CLIENT_2328 = nil,
  CLIENT_2329 = nil,
  CLIENT_2330 = nil,
  CLIENT_2331 = nil,
  CLIENT_2332 = nil,
  CLIENT_2333 = nil,
  CLIENT_2334 = nil,
  CLIENT_2335 = nil,
  CLIENT_2336 = nil,
  CLIENT_2337 = nil,
  CLIENT_2338 = nil,
  CLIENT_2339 = nil,
  CLIENT_2340 = nil,
  CLIENT_2341 = nil,
  CLIENT_2342 = nil,
  CLIENT_2343 = nil,
  CLIENT_2344 = nil,
  CLIENT_2345 = nil,
  CLIENT_2346 = nil,
  CLIENT_2347 = nil,
  CLIENT_2348 = nil,
  CLIENT_2349 = nil,
  CLIENT_2350 = nil,
  CLIENT_2351 = nil,
  CLIENT_2352 = nil,
  CLIENT_2353 = nil,
  CLIENT_2356 = nil,
  CLIENT_2360 = nil,
  CLIENT_2362 = nil,
  CLIENT_2363 = nil,
  CLIENT_2367 = nil,
  CLIENT_2371 = nil,
  CLIENT_2776 = nil,
  CLIENT_2777 = nil,
  CLIENT_2778 = nil,
  CLIENT_2779 = nil,
  CLIENT_2780 = nil,
  CLIENT_2781 = nil,
  CLIENT_2782 = nil,
  CLIENT_2783 = nil,
  CLIENT_2784 = nil,
  CLIENT_2785 = nil,
  CLIENT_2786 = nil,
  CLIENT_2787 = nil,
  CLIENT_2788 = nil,
  CLIENT_2789 = nil,
  CLIENT_2790 = nil,
  CLIENT_2791 = nil,
  CLIENT_2809 = nil,
  CLIENT_2810 = nil,
  CLIENT_IP_IS_LOCK = nil,
  CLIENT_VERSION_IS_TOO_LOW = nil,
  COLLECT_AFTER_CLEAN_WAREHOUSE = nil,
  COMBINE_NUM_EMPTY = nil,
  COMPENSATE_NOT_AWARD = nil,
  CONCERN_BUDDY_LOCK = nil,
  CONDITION_NOT_COMPLETE = nil,
  CONFIG_ERROR = nil,
  CONSUME_NOT_EXIST = nil,
  CONTENT_SENSITIVE_WORD = nil,
  CONTENT_SENSITIVE_WORD_IN_PLAY_STORY = nil,
  COST_NOT_ENOUGHT = nil,
  CREATE_CHAT_CHANNEL_FAILED = nil,
  CREATE_RECHARGE_ORDER_FAILD = nil,
  CREATE_ROOM_FAIL = nil,
  CURSE_BAN_SHOP_BUY = nil,
  CURSE_CARD_FUNC_ERR = nil,
  CURSE_CARD_INDEX_ERR = nil,
  CURSE_CARD_NOT_FINISHED = nil,
  CURSE_CARD_NOT_FOUND = nil,
  CURSE_CARD_NOT_USE = nil,
  CURSE_CARD_POS_ERR = nil,
  CURSE_CARD_TYPE_ERR = nil,
  CURSE_DOOR_NOT_OPEN = nil,
  CURSE_EPISODE_EPI_NOT_HAVE_DESTINY_AWARD = nil,
  CURSE_EQUATION_BRANCH_SELECTED = nil,
  CURSE_EQUATION_INVAILD_BRANCH = nil,
  CURSE_EQUATION_NOT_REFRESH = nil,
  CURSE_EQUATION_SELECT_ERROR = nil,
  CURSE_EQUATION_SELECT_INDEX_ERROR = nil,
  CURSE_GOODS_HAD_BUY = nil,
  CURSE_GOODS_NOT_FOUND = nil,
  CURSE_HAD_CARD = nil,
  CURSE_OPTIONS_NOT_ACTIVITY = nil,
  CURSE_OPTIONS_NOT_OPEN_CHOOSE = nil,
  CURSE_RECUPERATION_LIMIT_STEP = nil,
  CURSE_RECUPERATION_USE_COUNT_LIMIT = nil,
  CURSE_REPEAT_OPTIONS_ACTION = nil,
  CURSE_RESTORE_CNT_LIMIT = nil,
  CURSE_SAVE_NAME_MAX_LEN = nil,
  CURSE_SHOP_REFRESH_CNT_LIMIT = nil,
  CURSE_SHOP_SLOT_GOOD_BUY = nil,
  CURSE_SHOP_SLOT_NOT_OPNE = nil,
  CURSE_SKIP_CARD_FAILED = nil,
  CURSE_VALUE_LIMIT = nil,
  DATA_LOADING = nil,
  DICTIONARY_LOCK = nil,
  DONT_SET_APPEAR = nil,
  DRAW_GROUP_DAY_LIMIT = nil,
  DRAW_GROUP_NOT_OPEN = nil,
  DRAW_POOL_CNT_NOT_ENOUGHT = nil,
  DRAW_POOL_NOT_OPEN = nil,
  DRAW_SELECT_CONDITION_ERROR = nil,
  DRAW_SELECT_ERROR = nil,
  DRAW_SELECT_REWARD_GAINED = nil,
  ENTITY_NOT_FOUND = nil,
  ENTRE_EVENT_NOT_FIND = nil,
  ENTRE_EVENT_NOT_GET_REWARD = nil,
  EPISODE_BOX_HAVE_GET_REWARD = nil,
  EPISODE_BOX_NOT_INTERACTIVE = nil,
  EPISODE_HAVE_GET_REWARD = nil,
  EPISODE_NOT_FOUND = nil,
  EPISODE_NOT_SET_ASSIST_BUDDY = nil,
  EPISODE_UNCOMPLETE = nil,
  EPI_IN_LOCK_STATUS = nil,
  EPI_NOT_TP_REVIVE = nil,
  EQUIP_CANT_DECOMPOSE = nil,
  EQUIP_CANT_WEAR = nil,
  EQUIP_FASHION_NOT_ACTIVE = nil,
  EQUIP_IN_LOCK = nil,
  EQUIP_MAX_LV = nil,
  EQUIP_NOT_MAX_LV = nil,
  EQUIP_NOT_RESHAPE = nil,
  EQUIP_TYPE_ERROR = nil,
  ERRCODE_UNDEFINED = nil,
  ERROR_ACCOUNT = nil,
  ERR_TOKEN = nil,
  EVENT_HAS_EACH = nil,
  EXCEED_WEEK_ACTY_BUDDY_RUNE_SET_DATA = nil,
  EXCHANGE_GOODS_NOT_FIND = nil,
  EXCHANGE_ITEMS_ERROR = nil,
  EXCHANGE_ITEMS_RULL_NOT_FIND = nil,
  EXCHANGE_SHOP_NOT_OPEN = nil,
  EXCHANGE_TIMES_NOT_ENOUGHT = nil,
  EXIST_A_TOWER = nil,
  EXIST_BATTLE_PASS_128 = nil,
  EXIST_BATTLE_PASS_68 = nil,
  FACE_NOT_FIND = nil,
  FAVOR_LEVEL_ARARD_GAINED = nil,
  FIGHT_COUNT_NOT_ENOUGHT = nil,
  FIGHT_TEAM_BUDDY_NOT_EXIST = nil,
  FIGHT_TEAM_NOT_EXIST = nil,
  FIRST_RECHARGE_AWARD_LOCK = nil,
  FIXED_BUDDY_NOT_EXIST_TEAM = nil,
  FORMATION_IS_LOCK = nil,
  FORMATION_NOT_FIND = nil,
  FREE_CHOOSE_DRAW_ID_NOT_OPEN = nil,
  FREE_CHOOSE_DRAW_NOT_USE = nil,
  FRIEND_APPLY_NOEXIST = nil,
  FRIEND_NOEXIST = nil,
  FRIEND_NUM_LIMIT = nil,
  FRIEND_PRESENT_REWARD_NOT_FOUND = nil,
  FRONT_EPISODE_NOT_FINISH = nil,
  FUNCTIONAL_NPC_CANT_INTERACT = nil,
  FUNCTIONAL_NPC_NOT_FOUND = nil,
  GEMSTONE_LOCK = nil,
  GEMSTONE_MAX_LEVEL = nil,
  GEMSTONE_REPEAT_EQUIP = nil,
  GEMSTONE_SLOT_NOT_FOUND = nil,
  GEMSTONE_UP_LEVEL_ERROR = nil,
  GET_AWARD_LIMIT = nil,
  GET_EVENT_NOT_BY_WAY = nil,
  GET_FRIEND_PRESENT_REWARD_DAY_LIMIT = nil,
  GET_ROOM_PLAYER_DATA_FAIL = nil,
  GET_SEGMENT_AWARD_AFTER_NOT_CHANGE_SEGMENT = nil,
  GIFT_BUY_CNT_IN_LIMIT = nil,
  GOLD_EQUIP_AWARD_GAINED = nil,
  GOLD_EQUIP_NOT_FOUND = nil,
  GOLD_EQUIP_NOT_OPEN_SELECT = nil,
  GOODS_QUOTA_NOT_ENOUGHT = nil,
  GUILD_APPLY_NOEXIST = nil,
  GUILD_CREATE_FAILED = nil,
  GUILD_IDEA_CONTAIN_SENSITIVE_WORD = nil,
  GUILD_IDEA_TOO_LONG = nil,
  GUILD_ISNOT_EMPTY = nil,
  GUILD_MEMBER_NUM_LIMIT = nil,
  GUILD_NAME_CONFLICT = nil,
  GUILD_NAME_CONTAIN_SENSITIVE_WORD = nil,
  GUILD_NAME_IS_EMPTY = nil,
  GUILD_NAME_TOO_LONG = nil,
  GUILD_NOT_GET_ONLINE_NUM = nil,
  GUILD_OPERATION_IN_CD = nil,
  HAD_BUY = nil,
  HAD_DROPED = nil,
  HAD_RESTORE_HP = nil,
  HAS_ACCEPT_GROUP_TASK = nil,
  HAVE_BUY_SENIOR_BATTLE_PASS = nil,
  HAVE_ORNAMENTS_ITEMS = nil,
  HELP_FIGHT_BUDDY_ERROR = nil,
  HELP_FIGHT_LIMIT = nil,
  HELP_FIGHT_POS_ERROR = nil,
  HERO_ALREADY_GOOUT = nil,
  HERO_IS_DEAD = nil,
  HERO_NOT_DEAD = nil,
  HERO_NOT_FIND_RUNE2_DATA = nil,
  HERO_NOT_FOUND = nil,
  HERO_NOT_SET_RUNE2 = nil,
  HIT_COUNT_ERROR = nil,
  HIVE_VERIFY_RECHARGE_ERROR = nil,
  HP_OVERFLOW = nil,
  ID_UUID_MISMATCH = nil,
  ILLEGAL_CONTENT = nil,
  IMPORTTANT_MAIL_MAX_CNT = nil,
  INFINITE_ENTRY_NOT_FOUND = nil,
  INFINITE_GROUP_NOT_FOUND = nil,
  INFINITE_GROUP_REPEAT = nil,
  INFINITE_MAST_ENTRY_NOT_SELECT = nil,
  INFINITE_NOT_FIND = nil,
  INFINITE_NOT_OPEN = nil,
  INFINITE_NOT_SELECT_OPTION = nil,
  INFINITE_PRIVILEGE_OPENED = nil,
  INFINITE_PRIVILEGE_PRE_NOT_OPEN = nil,
  INFINITE_SCORE_GAINED = nil,
  INFINITE_SCORE_LESS = nil,
  INFINITE_SCORE_REWARD_NOT_THROUGH = nil,
  INFINITE_SELECT_OPTION_ERROR = nil,
  INSUFFICIENT_CHAT_LV = nil,
  INVAILD_FIXED_BUDDY = nil,
  INVALID_CHAT_CHANNEL_ID = nil,
  INVALID_WORD = nil,
  INVITATION_EXPIRE = nil,
  INVITE_PLAYER_IN_CD = nil,
  IN_BAN_CHAT_STATE = nil,
  IN_CHAT_CD = nil,
  IN_CHOOSE_REWARD_STATUS = nil,
  IN_ROOM_NOT_TP_BY_MAP = nil,
  ISNOT_IN_A_GUILD = nil,
  IS_IN_WAR = nil,
  ITEM_CANNOT_COMBIME = nil,
  ITEM_NOT_FIND = nil,
  ITEM_NOT_RECOVER = nil,
  ITEM_RECOVER_NOT_ACTIVE = nil,
  JOURNEY_EVENT_PRE_NOT_DONE = nil,
  KITTEN_ESCAPE_EPISODE_NOT_OPEN = nil,
  KITTEN_ESCAPE_PASSED = nil,
  LACK_ACTY_CHOOSE_REWARD_CONFIG = nil,
  LEVEL_COND_NOT_COMPLETE = nil,
  LEVEL_REWARD_GAINED = nil,
  LINEAR_GAINED = nil,
  LINEAR_NOT_OPEN = nil,
  LINEAR_STAR_NOT_ENOUGH = nil,
  LOBBY_NETWORK_ERR = nil,
  LOGIN_FAILED = nil,
  MAGIC_DONT_PERMIT_MISSILEUUID = nil,
  MAGIC_DONT_PERMIT_SKILLUUID = nil,
  MAGIC_NOT_ALLOW = nil,
  MAGIC_NOT_FOUND = nil,
  MAIL_HAD_READ = nil,
  MAIN_TALENT_NOT_ACTIVATE = nil,
  MAP_TP_IN_IDENTICAL_FLOOR = nil,
  MARK_REPEAT = nil,
  MASK_USE_FORCE_MAIN_POS = nil,
  MATCH_JOIN_FAIL = nil,
  MATCH_PARAM_ERR = nil,
  MATERIAL_DAY_NOT_CHOOSE_DROP = nil,
  MATERIAL_DROP_ERROR = nil,
  MATERIAL_ERROR = nil,
  MATERIAL_NOT_CHOOSE_DROP = nil,
  MATERIAL_NOT_FIND = nil,
  MATERIAL_NOT_OPEN = nil,
  MATERIAL_NOT_SWEEP = nil,
  MAX_NAME_SIZE = nil,
  MAX_QUOTATION_SIZE = nil,
  MAX_REFRESH_COUNT = nil,
  MINESWEEPER_FLUSH_FREQUENT = nil,
  MISSILE_DONT_PERMIT_SKILLUUID = nil,
  MISSILE_NOT_FOUND = nil,
  MISSILE_TARGET_NOT_FOUND = nil,
  MONKEY_FONT_COUNT_MAX = nil,
  MONKEY_NOT_RUNING = nil,
  MONKEY_QUESTION_COMPLETE = nil,
  MONKEY_QUESTION_DONED = nil,
  MONKEY_QUESTION_PARSING = nil,
  MONKEY_TYPE_WRITER_QUESTION_NOT_OPEN = nil,
  MONKEY_TYPE_WRITER_RUNNING = nil,
  MONKEY_UNIT_COUNT_NOT_MAX = nil,
  MONKEY_WRITER_MAX_LEVEL = nil,
  MONSTER_ARCH_LOCK = nil,
  MONTHLY_CARD_DAY_LIMIT = nil,
  MOVE_VIDEO_LOCK = nil,
  MUSEUM_ACHIEVE_REWARD_NOT_OPEN = nil,
  MUSEUM_EXHIBIT_COUNT_LIMIT = nil,
  MUSEUM_FACTORY_MAX_LV = nil,
  MUSEUM_MAKE_FORMULA_NOT_OPEN = nil,
  MUSEUM_POS_NOT_OPEN = nil,
  NAME_CONTAIN_SENSITIVE_WORD = nil,
  NEWBIE_PRIVILEGE_NOT_FOUND = nil,
  NOTICE_READ_REPEAT = nil,
  NOT_ACHIEVE_EPI_STAT = nil,
  NOT_ACTIVE_MONTHLY_CARD = nil,
  NOT_ALLOW_CREATE_ROLE = nil,
  NOT_ASSIST_FREESTAMINE_UUID = nil,
  NOT_AT_GET_PRIVILEGE_REWARD_TIME = nil,
  NOT_BRANCH_TASK = nil,
  NOT_BUT_NEWBIE_PRIVILEGE_GIFT = nil,
  NOT_BUY_GIFT_BY_FACINGID = nil,
  NOT_BUY_GIFT_BY_SDK = nil,
  NOT_BUY_SHOPPING = nil,
  NOT_CAN_ADD_GREED_KILL = nil,
  NOT_CARGO_BLESS = nil,
  NOT_CHAPTER = nil,
  NOT_CHILD_MISSILE_ID = nil,
  NOT_CHOOSE_SECT = nil,
  NOT_COMMPLE_REWARD_CONDITION = nil,
  NOT_FIND_ABILITY_DROP = nil,
  NOT_FIND_BUDDY_REFINE_REPLACE_ENTRY = nil,
  NOT_FIND_FIGHT_BUDDY = nil,
  NOT_FIND_GIFT_CONFIG = nil,
  NOT_FIND_ITEM = nil,
  NOT_FIND_ORNAMENTS_SOURCE = nil,
  NOT_FIND_RECEIVE_REWARD = nil,
  NOT_FIND_ROOM = nil,
  NOT_FIND_RUNE2_CAST_DATA = nil,
  NOT_FIND_RUNE2_SOURCE = nil,
  NOT_FIND_SDKKEY_ID = nil,
  NOT_FIND_SDKKEY_ITEM = nil,
  NOT_FIND_SDKKEY_TYPE = nil,
  NOT_FIND_SECT = nil,
  NOT_FOUND_FLUSH_ENTRY = nil,
  NOT_FOUND_GEMSTONE = nil,
  NOT_FOUND_GEMSTONE_CONSUME = nil,
  NOT_FOUND_RELIC = nil,
  NOT_FOUNT_FIGHT_TEAM = nil,
  NOT_HAVE_MATCH_PLAYER = nil,
  NOT_IN_BUY_GIFT_TIME = nil,
  NOT_IN_NEW_BIE_PRIVILEGE = nil,
  NOT_IN_WAR = nil,
  NOT_IS_STORE = nil,
  NOT_LOGIN = nil,
  NOT_LONG_CHAPTER = nil,
  NOT_OPEN_SWEEP = nil,
  NOT_READ_NEWBIE_STORY = nil,
  NOT_RECEIVA_STAR_REWARD = nil,
  NOT_SETTING_FORMATION = nil,
  NOT_TOWER_TP_REVIVE_ROOM = nil,
  NOT_TO_FIND_ACCOUNT_ID_CARD = nil,
  NOT_TO_FIND_DEVELOP_AWARD = nil,
  NOT_TO_FIND_PARAM = nil,
  NOT_TO_FIND_RECHARGE_ORDER = nil,
  NOT_TO_FIND_SDK_ACCOUNT_DATA = nil,
  NOT_TO_USE_DIAMOND = nil,
  NOT_TO_USE_PLATFORM_RECHARGE_FUNC = nil,
  NOT_TO_USE_UGSDK_ACCOUNT_SIMULATED_RECHARGE = nil,
  NOT_USE_ITEM = nil,
  NOT_USE_RECUPERATION_FUN = nil,
  NO_FIND_DISCARD_ITEM = nil,
  NO_HAS_GREED_KILL = nil,
  NO_HAS_MATCH = nil,
  NO_PERMISSION = nil,
  NO_REPEAT_USE_ITEM = nil,
  NPC_GOODS_HAD_BUY = nil,
  NPC_GOODS_NOT_FOUND = nil,
  NPC_IS_NOT_SHOP_TYPE = nil,
  OBJECT_NOT_FOUND = nil,
  OK = nil,
  ORANSMENT_NOT_ACTIVE = nil,
  ORNAMENT_GAINED = nil,
  ORNAMENT_SELECT_FINISH = nil,
  OTHERSIDE_FRIEND_NUM_LIMIT = nil,
  OWNED_A_GUILD = nil,
  PARAM_ERROR = nil,
  PARENT_MISSILE_NOT_FOUND = nil,
  PARTICIPATE_WEEK_ACTY_PVP = nil,
  PERMISSION_DENIED = nil,
  PLATFORM_AUTH_FAILED = nil,
  PLATFORM_NOT_LOGIN_SERVER = nil,
  PLATFORM_RECHARGE_DATA_ERROR = nil,
  PLAYER_DATA_ERR = nil,
  PLAYER_IN_BAN_STATUS = nil,
  PLAYER_IN_ROOM = nil,
  PLAYER_IN_WAR = nil,
  PLOT_PREHEAT_CLICKED = nil,
  PLOT_PREHEAT_UNLOCKED = nil,
  PREFAB_TEAM_ID_ERROR = nil,
  PREFAB_TEAM_NAME_ERROR = nil,
  PREFAB_TEASM_MAIN_POS_NOT_EXIST = nil,
  PREFAB_TEASM_SIZE_ERROR = nil,
  PROSPERITY_MAX_LV = nil,
  PROTO_ERROR = nil,
  PUZZLE_CONSUME_ID_ERROR = nil,
  PUZZLE_CONSUME_NOT_FOUND = nil,
  PUZZLE_CONSUME_USE_SELF = nil,
  PUZZLE_DECOMPOSE_ERROR = nil,
  PUZZLE_DELETE_ERROR = nil,
  PUZZLE_GAME_EPISODE_NOT_OPEN = nil,
  PUZZLE_NOT_PLACE_IN = nil,
  PUZZLE_PLACE_IN_ERROR = nil,
  PUZZLE_PLACE_OUT_ERROR = nil,
  PVP_CHANGE_SEGMENT_CNT_LIMIT = nil,
  PVP_NOT_LACK_SEGMENT = nil,
  PVP_SEGEMTN_NOT_FIND = nil,
  PVP_SEGMENT_NOT_OPEN = nil,
  PVP_SEGMENT_POND_NOT_FOUND = nil,
  PVP_SEGMENT_POND_NOT_PLAYER = nil,
  RANK_OBJECT_NOT_FOUND = nil,
  RECEIVE_AWARD_REPEAT = nil,
  RECHARGE_LIMIT_TEXT_1 = nil,
  RECHARGE_LIMIT_TEXT_2 = nil,
  RECHARGE_ORDER_DATA_NOT_MATCH = nil,
  RECHARGE_ORDER_DELIVER_GOODS_ERROR = nil,
  RECHARGE_ORDER_HAVE = nil,
  RECHARGE_ORDER_WAS_CANCEL = nil,
  RECHARGE_ORDER_WAS_DELIVERED = nil,
  RECHARGE_PREVENT_ADDICTION = nil,
  RECHARGE_PROJECT_IS_BAN = nil,
  RECHARGE_PROJECT_NOT_OPEN = nil,
  RECUPERATION_ORNAMENT_NOT_GAIN = nil,
  REFINE_UPGRADE_NOT_SATISFY_CFG_LV = nil,
  REFRESH_ABILITY_DROP_ERROR = nil,
  REJOIN_CHAT_CHANNEL = nil,
  RELIC_ALREADY_MAX_LV = nil,
  RELIC_ENTRY_NOT_EXIST = nil,
  RELIC_ENTRY_REFLUSH_ERROR = nil,
  RELIC_ENTRY_REPEAT_ERROR = nil,
  RELIC_NOT_INLAY = nil,
  RELIC_SLOT_LOCK = nil,
  RELIC_UP_USE_SELF = nil,
  REPEAT_SEND_FRIEND_REWARD = nil,
  REQUEST_FREQUENT = nil,
  REQ_FREQUENCY_TOO_HIGH = nil,
  ROLE_IN_WAR = nil,
  ROLE_NOT_EXIST = nil,
  ROLE_NOT_FIND = nil,
  ROLE_NOT_IN_BAN_STATUS = nil,
  ROLE_NOT_IN_CHAT_CHANNEL = nil,
  ROLE_NOT_IN_GUILD = nil,
  ROOM_CHANGE_PLAYER_STATE_FAIL = nil,
  ROOM_DISSATISFY_ACTY_LV = nil,
  ROOM_HAVE_IDENTICAL_ROLE = nil,
  ROOM_INVITE_MESSAGE_OVERDUE = nil,
  ROOM_IN_CREATE_TIME = nil,
  ROOM_IN_WAR = nil,
  ROOM_JOINWAR_PLAYER_NOTREADY = nil,
  ROOM_NOT_LAUNCH = nil,
  ROOM_NOT_TP_BY_MAP = nil,
  ROOM_NO_PLAYERS_TO_INVITE = nil,
  ROOM_PLAYER_DATA_FAIL = nil,
  ROOM_PLAYER_FULL = nil,
  ROOM_PLAYER_NOT_CHANGESTATE = nil,
  ROOM_PLAYER_NOT_FIND = nil,
  RPC_FAILD = nil,
  RPC_TIMEOUT = nil,
  RUNE2_ITEM_LACK_DATA = nil,
  RUNE_SET_UP_REPEAT = nil,
  SDK_IOS_RECHARGE_ORDER_ERROR = nil,
  SDK_VERIFY_ACCOUNT_ERROR = nil,
  SDK_VERIFY_DEVICE_ERROR = nil,
  SEARCH_PLAYER_HAS_GUILD = nil,
  SENDBYTES_LT_RECVBYTES = nil,
  SEND_CACHE_SHORTED = nil,
  SENSITIVE_WORDS = nil,
  SERVER_IS_BUSY = nil,
  SERVER_MAINTENANCE = nil,
  SERVER_OPEN_EQUIPMENT_RESTRICTION = nil,
  SERVER_REGISTER_LIMIT = nil,
  SERVER_STARTING = nil,
  SERVER_TESTING = nil,
  SETTLEMENT_NODE_FAIL = nil,
  SHOP_BAN_BUY = nil,
  SIGN_IN_OVERFLOW = nil,
  SIGN_REPEAT = nil,
  SKILL_MAX_LEVEL = nil,
  SKILL_NOT_ACTIVE = nil,
  SKILL_NOT_FOUND = nil,
  SKILL_UUID_REPEAT = nil,
  SKILL_VIRTUAL_MAX_LEVEL = nil,
  SPROTO_NOT_IN_PRODUCT_ENV = nil,
  STRANGER_HELP_CNT_LIMIT = nil,
  SUB_MODULE_SHOW_CASE_NOT_OPEN = nil,
  SUB_MUSEUM_MODULE_MAX_LV = nil,
  SYSTEM_NOT_OPEN = nil,
  TALENT_ACTIVATE = nil,
  TALENT_ACTIVATING_ERROR = nil,
  TALENT_CAREER_NOT_MATCH = nil,
  TALENT_EFFECT_NOT_ACTIVATE = nil,
  TALENT_NOT_FIRST = nil,
  TALENT_NOT_FOUND_IN_TREE = nil,
  TALENT_TREE_ACTIVATE_REPEAT = nil,
  TALENT_TREE_NOT_ACTIVATE = nil,
  TARGET_ENTITY_NOT_FOUND = nil,
  TARGET_NOT_IN_YOUR_BLACKLIST = nil,
  TASK_COMPLETE = nil,
  TASK_GET_REWARD = nil,
  TASK_NOT_FOUND = nil,
  TASK_NOT_ORNAMENT_SELECT = nil,
  TASK_NOT_PICK = nil,
  TASK_UNCOMPLETE = nil,
  TEAM_BUDDY_NOT_EXIST = nil,
  TEAM_BUDDY_NOT_GAINED = nil,
  TEAM_LIMIT_NOT_CONDITION = nil,
  TEAM_MAX_COUNT = nil,
  TEAM_NAME_TOO_LONG = nil,
  TEAM_REPEAT_BUDDY = nil,
  TEXT_SENSITIVE_WORDS = nil,
  TICKET_TIMEOUT = nil,
  TITLE_ALREADY_ACTIVATED = nil,
  TITLE_ALREADY_NOT_ACTIVATED = nil,
  TITLE_ALREADY_USING = nil,
  TITLE_GAINED_HIGHER = nil,
  TITLE_NOT_USING = nil,
  TODAY_ALREADY_SET_SCORE = nil,
  TOWER_ALREADY_IN_ROOM = nil,
  TOWER_BEGIN_ROOM_ERROR = nil,
  TOWER_CUR_FLOOR_NOT_PASS = nil,
  TOWER_ENTER_ERROR = nil,
  TOWER_FLOOR_NOT_FIND = nil,
  TOWER_NOT_FIND = nil,
  TOWER_NOT_LIQUIDATION = nil,
  TOWER_NOT_MATCH = nil,
  TOWER_PREV_FLOOR_NOT_FIGHT_THROUGH = nil,
  TOWER_ROLE_FLOOR_IDX_ERROR = nil,
  TOWER_ROLE_ROOM_NUM_ERROR = nil,
  TOWER_ROOMS_DISCONNECTED = nil,
  TOWER_ROOM_ALREADY_FIGHT_THROUGH = nil,
  TOWER_ROOM_NOT_FIGHT_THROUGH = nil,
  TOWER_ROOM_NOT_FIND = nil,
  TP_ROOM_BY_MAP_IN_BAN = nil,
  TREASURE_BOX_GEN_FAILD = nil,
  TREASURE_BOX_NOT_EMPTY = nil,
  TREASURE_CHEST_SELECT_ERROR = nil,
  TREASURE_IS_OBTAINED = nil,
  TREASURE_NOT_EXIST = nil,
  TREASURE_NOT_FINISH = nil,
  TSI_COUPON_NOT_TO_USE_PLATFORM = nil,
  TSI_SDK_RECHARGE_ERROR_1 = nil,
  TSI_SDK_RECHARGE_ERROR_10 = nil,
  TSI_SDK_RECHARGE_ERROR_2 = nil,
  TSI_SDK_RECHARGE_ERROR_3 = nil,
  TSI_SDK_RECHARGE_ERROR_4 = nil,
  TSI_SDK_RECHARGE_ERROR_5 = nil,
  TSI_SDK_RECHARGE_ERROR_6 = nil,
  TSI_SDK_RECHARGE_ERROR_7 = nil,
  TSI_SDK_RECHARGE_ERROR_8 = nil,
  TSI_SDK_RECHARGE_ERROR_9 = nil,
  UNKNOWN_ERROR = nil,
  UNLOCK_FAIL = nil,
  UNPACK_ERROR = nil,
  UNREGISTERED_AUTH_REQUEST = nil,
  USE_BANED_BUDDY = nil,
  USE_BANED_POS = nil,
  USE_NOT_IN_SETTING_BUDDY = nil,
  USE_SDK_CONPON_ERROR = nil,
  VICTIM_NOT_ALIVE = nil,
  VICTIM_NOT_FOUND = nil,
  WEAPON_DEVELOP_NOT_CALL_BACK = nil,
  WEEK_ACTY_BUDDY_REPEAT = nil,
  WEEK_ACTY_PVP_IN_END = nil,
  WEEK_ACTY_PVP_LOCK = nil,
  WEEK_ACTY_PVP_NOT_OPEN = nil,
  WEEK_ACTY_PVP_NOT_USE_ASSISTANT = nil,
  WEEK_ACTY_PVP_STAGE_NOT_OPEN = nil,
  XICODE_SIGN_ERROR = nil,
  XICODE_SIGN_NOT_FIND = nil
}
t.ABILITY_GAINED = t[1971]
t.ABILITY_GRADE_IN_LINIT = t[1850]
t.ABILITY_REMODELING_MAX = t[2368]
t.ACCOUNT_ID_CARD_ERROR = t[1959]
t.ACCOUNT_INFO_ERR = t[101]
t.ACHIEVEMENT_GROUNP_AWARD_REPLACE = t[1756]
t.ACHIEVEMENT_GROUNP_NOT_AWARD = t[1757]
t.ACHIEVEMENT_GROUNP_NOT_COMPLETE = t[1758]
t.ACHIEVEMENT_PROGRESS_TASK_NOT_FOUND = t[1766]
t.ACTIVITY_AWARD_GAINED = t[1842]
t.ACTIVITY_CURSE_LOCKED = t[2039]
t.ACTIVITY_CURSE_PRE_BLESS_LOCK = t[2020]
t.ACTIVITY_DISVALID_DURATION = t[1622]
t.ACTIVITY_END = t[1840]
t.ACTIVITY_LEVEL_AWARD_GAINED = t[1974]
t.ACTIVITY_MINI_GAME_NOT_OPEN = t[2799]
t.ACTIVITY_NOT_FOUND = t[1621]
t.ACTIVITY_SIGN_IN_AWARD_NOT_OPEN = t[2021]
t.ACTIVITY_SIGN_IN_GAINED = t[2030]
t.ACTIVITY_TASK_NO_DONE = t[1841]
t.ACTMINE_NEAR_ENEMY = t[2807]
t.ACTY_MUSCI_GAME_EPISODE_NOT_OPEN = t[2365]
t.ACTY_MUSIC_GAME_NOT_OPEN = t[2364]
t.ACTY_NO_EXISTEN = t[1113]
t.ACTY_NO_OPEN = t[1114]
t.ADVENTURE_CHECK_BUDDY_ERROE = t[1984]
t.ALBUM_LOCK = t[1122]
t.ALL_CHAT_CHANNEL_CROWDED = t[1504]
t.ALREADY_APPLIED = t[1703]
t.ALREADY_FRIEND = t[1400]
t.ALREADY_LOGIN = t[1004]
t.ALREADY_MATCH = t[1646]
t.ALREADY_ON_BLACKLIST = t[1692]
t.APPLY_FRIEND_CD = t[1401]
t.ARCH_NO_EXISTEM = t[1116]
t.ARCH_NO_OPEN = t[1117]
t.ASSISTANT_HAVE_JOB = t[1865]
t.ASSISTANT_MAX_LV = t[1864]
t.ASSIST_BUDDY_INDEX = t[1808]
t.ASSIST_BUDDY_RESHRESH_IN_CD = t[1810]
t.ASSIST_ELEMENT_NOT_FOUND = t[1807]
t.ASSIST_FIGHT_ELEMENT_NOT_PUSH = t[1903]
t.ATTACHMENT_NOT_GET = t[1093]
t.ATTACKER_NOT_ALIVE = t[1035]
t.ATTACKER_NOT_FOUND = t[1037]
t.ATTACKER_SKILL_NOT_FOUND = t[1034]
t.AWARD_GROUP_NOT_FIND = t[1023]
t.AWARD_NOT_FIND = t[1024]
t.BAG_NOT_ENOUGHT = t[1071]
t.BAG_OVERFLOW = t[1025]
t.BATTLE_NETWORK_ERR = t[1739]
t.BATTLE_PASS_NOT_OPEN = t[1893]
t.BATTLE_PASS_NOT_OPEN_CIRCULATE_AWARD = t[1895]
t.BATTLE_PASS_NOT_REACH_MAX_GRADE = t[1896]
t.BATTLE_SHOP_NOT_FIND = t[1074]
t.BATTLE_SKILL_MAJOR_NOT_FOUND = t[1605]
t.BATTLE_SKILL_MISMATCH = t[1626]
t.BATTLE_SKILL_NOT_FOUND = t[1421]
t.BATTLE_SKILL_NOT_SELECT = t[1420]
t.BATTLE_SKILL_POINT_NOT_ENOUGHT = t[1625]
t.BATTLE_TREASURE_NOT_FIND = t[1408]
t.BIRTHDAY_HAD_SET = t[1109]
t.BLACKLIST_CANT_OPERATE_ON_SELF = t[1690]
t.BLACKLIST_NUM_LIMIT = t[1689]
t.BLESS_POS_LOCK = t[1125]
t.BOSS_FIGHT_EPISODE_NOT_OPEN = t[2006]
t.BREAKABLE_ID_INVAILD = t[1663]
t.BUDDY_DEVELOP_NOT_CALL_BACK = t[2804]
t.BUDDY_FASHION_NOT_FOUND = t[1412]
t.BUDDY_FASHION_READ_REPEAT = t[1413]
t.BUDDY_FASHION_WEAR_REPEAT = t[1414]
t.BUDDY_MAX_ADVANCE_LV = t[1627]
t.BUDDY_MAX_LV = t[1031]
t.BUDDY_NOT_MAX_LV = t[1030]
t.BUDDY_NOT_YET_GET = t[1415]
t.BUDDY_REFINE_MAX_GRADE = t[1710]
t.BUDDY_REFINE_NOT_MAX_GRADE = t[1712]
t.BUDDY_RUNE_GRADE_MAX = t[1744]
t.BUDDY_SET_ONE_RUNE = t[1789]
t.BUDDY_TALENT_MAX_LV = t[1826]
t.BUDDY_VOICE_IS_UNLOCKED = t[1686]
t.BUDDY_VOICE_NOT_UNLOCK = t[1685]
t.BUILDING_ADVENTURE_STATE_ERROR = t[1983]
t.BUILDING_ADVENTURE_TASK_NOT_FINISH = t[1985]
t.BUILDING_ADVENTURE_TASK_NOT_GAINED = t[1982]
t.BUILDING_ADVENTURE_USING_REPEAT_BUDDY = t[1980]
t.BUILDING_FACTORY_FULL = t[1993]
t.BUILDING_FACTORY_WORKING = t[1979]
t.BUILDING_MAX_LEVEL = t[1981]
t.BUSSINESS_CARD_NOT_ACTIVE = t[1792]
t.BUSSINESS_CARD_NOT_WEAR = t[1793]
t.BUY_BATTLE_PASS_LIMIT_GRADE = t[1899]
t.BUY_GIFT_NEED_BY_SDK = t[1680]
t.BUY_GOOD_LIMIT = t[1123]
t.CANNOT_FIND_PLAYER = t[1719]
t.CANT_ADD_SELF_AS_FRIEND = t[1406]
t.CANT_APPLY_FRIEND_TO_SELF = t[1405]
t.CANT_GET_SELF_INFO = t[1693]
t.CANT_KICKOUT_YOURSELF = t[1707]
t.CARD_EVENT_CONTIION_NOT_OPEN = t[1972]
t.CASE_WITH_EXHIBIT_TYPE_NOT_MATA = t[1882]
t.CDKEY_MAX_USE_CNT = t[1108]
t.CDKEY_NOT_FIND = t[1106]
t.CDKEY_USED = t[1107]
t.CD_KEY_GET_MUTEX_REWARD = t[1963]
t.CD_KEY_GIFT_EXPIRE = t[1128]
t.CD_KEY_IN_BAN_STATUS = t[1127]
t.CD_KEY_IS_USER = t[2369]
t.CHALLENGE_CARD_CANT_CHOOSE = t[1631]
t.CHALLENGE_CARD_CANT_UNLOCK = t[1651]
t.CHALLENGE_CARD_ISNT_CHOOSE = t[1635]
t.CHALLENGE_CARD_NOT_END = t[1636]
t.CHALLENGE_CARD_NOT_FOUND = t[1633]
t.CHALLENGE_CARD_POOL_IS_EMPTY = t[1632]
t.CHALLENGE_CARD_UNLOCK_REPEAT = t[1652]
t.CHALLENGE_NOT_ENOUGH = t[1058]
t.CHALLENGE_NOT_START = t[1620]
t.CHALLENGE_REPEAT = t[1619]
t.CHALLENGE_RING_CIRCLE_NOT_FOUND = t[1634]
t.CHALLENGE_START_REPEATE = t[1637]
t.CHALLENG_MULTIPLE_NOT_MATCH = t[1825]
t.CHALLENG_MULTIPLE_NOT_OPEN = t[1824]
t.CHANGE_STATE_NOT_ROOM = t[2018]
t.CHAPTER_NODE_LOCK = t[1780]
t.CHAPTER_NODE_NOT_PASS = t[1776]
t.CHAPTER_NODE_SETTLED = t[1777]
t.CHAPTER_SETTLEMENTED = t[1799]
t.CHARTLET_FRAME_REPEAT = t[2036]
t.CHARTLET_REPEAT = t[2032]
t.CHAT_CHANNEL_NO_EXIST = t[1501]
t.CHAT_CHANNEL_ROLE_NUM_LIMIT = t[1506]
t.CHAT_MSG_INCLUDE_SENSITIVE_WORDS = t[1507]
t.CHAT_MSG_LEN_LIMITED = t[2013]
t.CHILD_MISSILE_LIMIT_CNT = t[1090]
t.CHOOSE_REWARD_NOT_ENABLED = t[1741]
t.CLIENT_2043 = t[2043]
t.CLIENT_2044 = t[2044]
t.CLIENT_2045 = t[2045]
t.CLIENT_2046 = t[2046]
t.CLIENT_2047 = t[2047]
t.CLIENT_2048 = t[2048]
t.CLIENT_2049 = t[2049]
t.CLIENT_2050 = t[2050]
t.CLIENT_2051 = t[2051]
t.CLIENT_2052 = t[2052]
t.CLIENT_2053 = t[2053]
t.CLIENT_2054 = t[2054]
t.CLIENT_2055 = t[2055]
t.CLIENT_2056 = t[2056]
t.CLIENT_2057 = t[2057]
t.CLIENT_2058 = t[2058]
t.CLIENT_2059 = t[2059]
t.CLIENT_2060 = t[2060]
t.CLIENT_2061 = t[2061]
t.CLIENT_2062 = t[2062]
t.CLIENT_2063 = t[2063]
t.CLIENT_2064 = t[2064]
t.CLIENT_2065 = t[2065]
t.CLIENT_2066 = t[2066]
t.CLIENT_2067 = t[2067]
t.CLIENT_2068 = t[2068]
t.CLIENT_2069 = t[2069]
t.CLIENT_2070 = t[2070]
t.CLIENT_2071 = t[2071]
t.CLIENT_2072 = t[2072]
t.CLIENT_2073 = t[2073]
t.CLIENT_2074 = t[2074]
t.CLIENT_2075 = t[2075]
t.CLIENT_2076 = t[2076]
t.CLIENT_2077 = t[2077]
t.CLIENT_2078 = t[2078]
t.CLIENT_2079 = t[2079]
t.CLIENT_2080 = t[2080]
t.CLIENT_2081 = t[2081]
t.CLIENT_2082 = t[2082]
t.CLIENT_2083 = t[2083]
t.CLIENT_2084 = t[2084]
t.CLIENT_2085 = t[2085]
t.CLIENT_2086 = t[2086]
t.CLIENT_2087 = t[2087]
t.CLIENT_2088 = t[2088]
t.CLIENT_2089 = t[2089]
t.CLIENT_2090 = t[2090]
t.CLIENT_2091 = t[2091]
t.CLIENT_2092 = t[2092]
t.CLIENT_2093 = t[2093]
t.CLIENT_2094 = t[2094]
t.CLIENT_2095 = t[2095]
t.CLIENT_2096 = t[2096]
t.CLIENT_2097 = t[2097]
t.CLIENT_2098 = t[2098]
t.CLIENT_2099 = t[2099]
t.CLIENT_2100 = t[2100]
t.CLIENT_2101 = t[2101]
t.CLIENT_2102 = t[2102]
t.CLIENT_2103 = t[2103]
t.CLIENT_2104 = t[2104]
t.CLIENT_2105 = t[2105]
t.CLIENT_2106 = t[2106]
t.CLIENT_2107 = t[2107]
t.CLIENT_2108 = t[2108]
t.CLIENT_2109 = t[2109]
t.CLIENT_2110 = t[2110]
t.CLIENT_2111 = t[2111]
t.CLIENT_2112 = t[2112]
t.CLIENT_2113 = t[2113]
t.CLIENT_2114 = t[2114]
t.CLIENT_2115 = t[2115]
t.CLIENT_2116 = t[2116]
t.CLIENT_2117 = t[2117]
t.CLIENT_2118 = t[2118]
t.CLIENT_2119 = t[2119]
t.CLIENT_2120 = t[2120]
t.CLIENT_2121 = t[2121]
t.CLIENT_2122 = t[2122]
t.CLIENT_2123 = t[2123]
t.CLIENT_2124 = t[2124]
t.CLIENT_2125 = t[2125]
t.CLIENT_2126 = t[2126]
t.CLIENT_2127 = t[2127]
t.CLIENT_2128 = t[2128]
t.CLIENT_2129 = t[2129]
t.CLIENT_2130 = t[2130]
t.CLIENT_2131 = t[2131]
t.CLIENT_2132 = t[2132]
t.CLIENT_2133 = t[2133]
t.CLIENT_2134 = t[2134]
t.CLIENT_2135 = t[2135]
t.CLIENT_2136 = t[2136]
t.CLIENT_2137 = t[2137]
t.CLIENT_2138 = t[2138]
t.CLIENT_2139 = t[2139]
t.CLIENT_2140 = t[2140]
t.CLIENT_2141 = t[2141]
t.CLIENT_2142 = t[2142]
t.CLIENT_2143 = t[2143]
t.CLIENT_2144 = t[2144]
t.CLIENT_2145 = t[2145]
t.CLIENT_2146 = t[2146]
t.CLIENT_2147 = t[2147]
t.CLIENT_2148 = t[2148]
t.CLIENT_2149 = t[2149]
t.CLIENT_2150 = t[2150]
t.CLIENT_2151 = t[2151]
t.CLIENT_2152 = t[2152]
t.CLIENT_2153 = t[2153]
t.CLIENT_2154 = t[2154]
t.CLIENT_2155 = t[2155]
t.CLIENT_2156 = t[2156]
t.CLIENT_2157 = t[2157]
t.CLIENT_2158 = t[2158]
t.CLIENT_2159 = t[2159]
t.CLIENT_2160 = t[2160]
t.CLIENT_2161 = t[2161]
t.CLIENT_2162 = t[2162]
t.CLIENT_2163 = t[2163]
t.CLIENT_2164 = t[2164]
t.CLIENT_2165 = t[2165]
t.CLIENT_2166 = t[2166]
t.CLIENT_2167 = t[2167]
t.CLIENT_2168 = t[2168]
t.CLIENT_2169 = t[2169]
t.CLIENT_2170 = t[2170]
t.CLIENT_2171 = t[2171]
t.CLIENT_2172 = t[2172]
t.CLIENT_2173 = t[2173]
t.CLIENT_2174 = t[2174]
t.CLIENT_2175 = t[2175]
t.CLIENT_2176 = t[2176]
t.CLIENT_2177 = t[2177]
t.CLIENT_2178 = t[2178]
t.CLIENT_2179 = t[2179]
t.CLIENT_2180 = t[2180]
t.CLIENT_2181 = t[2181]
t.CLIENT_2182 = t[2182]
t.CLIENT_2183 = t[2183]
t.CLIENT_2184 = t[2184]
t.CLIENT_2185 = t[2185]
t.CLIENT_2186 = t[2186]
t.CLIENT_2187 = t[2187]
t.CLIENT_2188 = t[2188]
t.CLIENT_2189 = t[2189]
t.CLIENT_2190 = t[2190]
t.CLIENT_2191 = t[2191]
t.CLIENT_2192 = t[2192]
t.CLIENT_2193 = t[2193]
t.CLIENT_2194 = t[2194]
t.CLIENT_2195 = t[2195]
t.CLIENT_2196 = t[2196]
t.CLIENT_2197 = t[2197]
t.CLIENT_2198 = t[2198]
t.CLIENT_2199 = t[2199]
t.CLIENT_2200 = t[2200]
t.CLIENT_2201 = t[2201]
t.CLIENT_2202 = t[2202]
t.CLIENT_2203 = t[2203]
t.CLIENT_2204 = t[2204]
t.CLIENT_2205 = t[2205]
t.CLIENT_2206 = t[2206]
t.CLIENT_2207 = t[2207]
t.CLIENT_2208 = t[2208]
t.CLIENT_2209 = t[2209]
t.CLIENT_2210 = t[2210]
t.CLIENT_2211 = t[2211]
t.CLIENT_2212 = t[2212]
t.CLIENT_2213 = t[2213]
t.CLIENT_2214 = t[2214]
t.CLIENT_2215 = t[2215]
t.CLIENT_2216 = t[2216]
t.CLIENT_2217 = t[2217]
t.CLIENT_2218 = t[2218]
t.CLIENT_2219 = t[2219]
t.CLIENT_2220 = t[2220]
t.CLIENT_2221 = t[2221]
t.CLIENT_2222 = t[2222]
t.CLIENT_2223 = t[2223]
t.CLIENT_2224 = t[2224]
t.CLIENT_2225 = t[2225]
t.CLIENT_2226 = t[2226]
t.CLIENT_2227 = t[2227]
t.CLIENT_2228 = t[2228]
t.CLIENT_2229 = t[2229]
t.CLIENT_2230 = t[2230]
t.CLIENT_2231 = t[2231]
t.CLIENT_2232 = t[2232]
t.CLIENT_2233 = t[2233]
t.CLIENT_2234 = t[2234]
t.CLIENT_2235 = t[2235]
t.CLIENT_2236 = t[2236]
t.CLIENT_2237 = t[2237]
t.CLIENT_2238 = t[2238]
t.CLIENT_2239 = t[2239]
t.CLIENT_2240 = t[2240]
t.CLIENT_2241 = t[2241]
t.CLIENT_2242 = t[2242]
t.CLIENT_2243 = t[2243]
t.CLIENT_2244 = t[2244]
t.CLIENT_2245 = t[2245]
t.CLIENT_2246 = t[2246]
t.CLIENT_2247 = t[2247]
t.CLIENT_2248 = t[2248]
t.CLIENT_2249 = t[2249]
t.CLIENT_2250 = t[2250]
t.CLIENT_2251 = t[2251]
t.CLIENT_2252 = t[2252]
t.CLIENT_2253 = t[2253]
t.CLIENT_2254 = t[2254]
t.CLIENT_2255 = t[2255]
t.CLIENT_2256 = t[2256]
t.CLIENT_2257 = t[2257]
t.CLIENT_2258 = t[2258]
t.CLIENT_2259 = t[2259]
t.CLIENT_2260 = t[2260]
t.CLIENT_2261 = t[2261]
t.CLIENT_2262 = t[2262]
t.CLIENT_2263 = t[2263]
t.CLIENT_2264 = t[2264]
t.CLIENT_2265 = t[2265]
t.CLIENT_2266 = t[2266]
t.CLIENT_2267 = t[2267]
t.CLIENT_2268 = t[2268]
t.CLIENT_2269 = t[2269]
t.CLIENT_2270 = t[2270]
t.CLIENT_2271 = t[2271]
t.CLIENT_2272 = t[2272]
t.CLIENT_2273 = t[2273]
t.CLIENT_2274 = t[2274]
t.CLIENT_2275 = t[2275]
t.CLIENT_2276 = t[2276]
t.CLIENT_2277 = t[2277]
t.CLIENT_2278 = t[2278]
t.CLIENT_2279 = t[2279]
t.CLIENT_2280 = t[2280]
t.CLIENT_2281 = t[2281]
t.CLIENT_2282 = t[2282]
t.CLIENT_2283 = t[2283]
t.CLIENT_2284 = t[2284]
t.CLIENT_2285 = t[2285]
t.CLIENT_2286 = t[2286]
t.CLIENT_2287 = t[2287]
t.CLIENT_2288 = t[2288]
t.CLIENT_2289 = t[2289]
t.CLIENT_2290 = t[2290]
t.CLIENT_2291 = t[2291]
t.CLIENT_2292 = t[2292]
t.CLIENT_2293 = t[2293]
t.CLIENT_2294 = t[2294]
t.CLIENT_2295 = t[2295]
t.CLIENT_2296 = t[2296]
t.CLIENT_2297 = t[2297]
t.CLIENT_2298 = t[2298]
t.CLIENT_2299 = t[2299]
t.CLIENT_2300 = t[2300]
t.CLIENT_2301 = t[2301]
t.CLIENT_2302 = t[2302]
t.CLIENT_2303 = t[2303]
t.CLIENT_2304 = t[2304]
t.CLIENT_2305 = t[2305]
t.CLIENT_2306 = t[2306]
t.CLIENT_2307 = t[2307]
t.CLIENT_2308 = t[2308]
t.CLIENT_2309 = t[2309]
t.CLIENT_2310 = t[2310]
t.CLIENT_2311 = t[2311]
t.CLIENT_2312 = t[2312]
t.CLIENT_2313 = t[2313]
t.CLIENT_2314 = t[2314]
t.CLIENT_2315 = t[2315]
t.CLIENT_2316 = t[2316]
t.CLIENT_2317 = t[2317]
t.CLIENT_2318 = t[2318]
t.CLIENT_2319 = t[2319]
t.CLIENT_2320 = t[2320]
t.CLIENT_2321 = t[2321]
t.CLIENT_2322 = t[2322]
t.CLIENT_2323 = t[2323]
t.CLIENT_2324 = t[2324]
t.CLIENT_2325 = t[2325]
t.CLIENT_2326 = t[2326]
t.CLIENT_2327 = t[2327]
t.CLIENT_2328 = t[2328]
t.CLIENT_2329 = t[2329]
t.CLIENT_2330 = t[2330]
t.CLIENT_2331 = t[2331]
t.CLIENT_2332 = t[2332]
t.CLIENT_2333 = t[2333]
t.CLIENT_2334 = t[2334]
t.CLIENT_2335 = t[2335]
t.CLIENT_2336 = t[2336]
t.CLIENT_2337 = t[2337]
t.CLIENT_2338 = t[2338]
t.CLIENT_2339 = t[2339]
t.CLIENT_2340 = t[2340]
t.CLIENT_2341 = t[2341]
t.CLIENT_2342 = t[2342]
t.CLIENT_2343 = t[2343]
t.CLIENT_2344 = t[2344]
t.CLIENT_2345 = t[2345]
t.CLIENT_2346 = t[2346]
t.CLIENT_2347 = t[2347]
t.CLIENT_2348 = t[2348]
t.CLIENT_2349 = t[2349]
t.CLIENT_2350 = t[2350]
t.CLIENT_2351 = t[2351]
t.CLIENT_2352 = t[2352]
t.CLIENT_2353 = t[2353]
t.CLIENT_2356 = t[2356]
t.CLIENT_2360 = t[2360]
t.CLIENT_2362 = t[2362]
t.CLIENT_2363 = t[2363]
t.CLIENT_2367 = t[2367]
t.CLIENT_2371 = t[2371]
t.CLIENT_2776 = t[2776]
t.CLIENT_2777 = t[2777]
t.CLIENT_2778 = t[2778]
t.CLIENT_2779 = t[2779]
t.CLIENT_2780 = t[2780]
t.CLIENT_2781 = t[2781]
t.CLIENT_2782 = t[2782]
t.CLIENT_2783 = t[2783]
t.CLIENT_2784 = t[2784]
t.CLIENT_2785 = t[2785]
t.CLIENT_2786 = t[2786]
t.CLIENT_2787 = t[2787]
t.CLIENT_2788 = t[2800]
t.CLIENT_2789 = t[2801]
t.CLIENT_2790 = t[2802]
t.CLIENT_2791 = t[2803]
t.CLIENT_2809 = t[2809]
t.CLIENT_2810 = t[2810]
t.CLIENT_IP_IS_LOCK = t[1987]
t.CLIENT_VERSION_IS_TOO_LOW = t[1097]
t.COLLECT_AFTER_CLEAN_WAREHOUSE = t[1976]
t.COMBINE_NUM_EMPTY = t[1746]
t.COMPENSATE_NOT_AWARD = t[2472]
t.CONCERN_BUDDY_LOCK = t[1115]
t.CONDITION_NOT_COMPLETE = t[1026]
t.CONFIG_ERROR = t[1028]
t.CONSUME_NOT_EXIST = t[1844]
t.CONTENT_SENSITIVE_WORD = t[1722]
t.CONTENT_SENSITIVE_WORD_IN_PLAY_STORY = t[1750]
t.COST_NOT_ENOUGHT = t[1027]
t.CREATE_CHAT_CHANNEL_FAILED = t[1505]
t.CREATE_RECHARGE_ORDER_FAILD = t[1948]
t.CREATE_ROOM_FAIL = t[1639]
t.CURSE_BAN_SHOP_BUY = t[2038]
t.CURSE_CARD_FUNC_ERR = t[1732]
t.CURSE_CARD_INDEX_ERR = t[1736]
t.CURSE_CARD_NOT_FINISHED = t[1737]
t.CURSE_CARD_NOT_FOUND = t[1730]
t.CURSE_CARD_NOT_USE = t[1851]
t.CURSE_CARD_POS_ERR = t[1734]
t.CURSE_CARD_TYPE_ERR = t[1731]
t.CURSE_DOOR_NOT_OPEN = t[1854]
t.CURSE_EPISODE_EPI_NOT_HAVE_DESTINY_AWARD = t[1944]
t.CURSE_EQUATION_BRANCH_SELECTED = t[1990]
t.CURSE_EQUATION_INVAILD_BRANCH = t[2041]
t.CURSE_EQUATION_NOT_REFRESH = t[1988]
t.CURSE_EQUATION_SELECT_ERROR = t[1991]
t.CURSE_EQUATION_SELECT_INDEX_ERROR = t[1989]
t.CURSE_GOODS_HAD_BUY = t[1728]
t.CURSE_GOODS_NOT_FOUND = t[1727]
t.CURSE_HAD_CARD = t[1733]
t.CURSE_OPTIONS_NOT_ACTIVITY = t[1946]
t.CURSE_OPTIONS_NOT_OPEN_CHOOSE = t[1942]
t.CURSE_RECUPERATION_LIMIT_STEP = t[1945]
t.CURSE_RECUPERATION_USE_COUNT_LIMIT = t[1852]
t.CURSE_REPEAT_OPTIONS_ACTION = t[1943]
t.CURSE_RESTORE_CNT_LIMIT = t[1725]
t.CURSE_SAVE_NAME_MAX_LEN = t[2775]
t.CURSE_SHOP_REFRESH_CNT_LIMIT = t[1941]
t.CURSE_SHOP_SLOT_GOOD_BUY = t[1940]
t.CURSE_SHOP_SLOT_NOT_OPNE = t[1939]
t.CURSE_SKIP_CARD_FAILED = t[1729]
t.CURSE_VALUE_LIMIT = t[1726]
t.DATA_LOADING = t[1003]
t.DICTIONARY_LOCK = t[1118]
t.DONT_SET_APPEAR = t[1051]
t.DRAW_GROUP_DAY_LIMIT = t[1724]
t.DRAW_GROUP_NOT_OPEN = t[1617]
t.DRAW_POOL_CNT_NOT_ENOUGHT = t[1618]
t.DRAW_POOL_NOT_OPEN = t[1616]
t.DRAW_SELECT_CONDITION_ERROR = t[1923]
t.DRAW_SELECT_ERROR = t[1924]
t.DRAW_SELECT_REWARD_GAINED = t[1925]
t.ENTITY_NOT_FOUND = t[1048]
t.ENTRE_EVENT_NOT_FIND = t[1836]
t.ENTRE_EVENT_NOT_GET_REWARD = t[1837]
t.EPISODE_BOX_HAVE_GET_REWARD = t[1961]
t.EPISODE_BOX_NOT_INTERACTIVE = t[1962]
t.EPISODE_HAVE_GET_REWARD = t[1994]
t.EPISODE_NOT_FOUND = t[1624]
t.EPISODE_NOT_SET_ASSIST_BUDDY = t[1806]
t.EPISODE_UNCOMPLETE = t[1057]
t.EPI_IN_LOCK_STATUS = t[1749]
t.EPI_NOT_TP_REVIVE = t[1754]
t.EQUIP_CANT_DECOMPOSE = t[1050]
t.EQUIP_CANT_WEAR = t[2042]
t.EQUIP_FASHION_NOT_ACTIVE = t[2040]
t.EQUIP_IN_LOCK = t[1660]
t.EQUIP_MAX_LV = t[1032]
t.EQUIP_NOT_MAX_LV = t[1033]
t.EQUIP_NOT_RESHAPE = t[1819]
t.EQUIP_TYPE_ERROR = t[1052]
t.ERRCODE_UNDEFINED = t[-1]
t.ERROR_ACCOUNT = t[1411]
t.ERR_TOKEN = t[1001]
t.EVENT_HAS_EACH = t[1838]
t.EXCEED_WEEK_ACTY_BUDDY_RUNE_SET_DATA = t[1774]
t.EXCHANGE_GOODS_NOT_FIND = t[1102]
t.EXCHANGE_ITEMS_ERROR = t[1022]
t.EXCHANGE_ITEMS_RULL_NOT_FIND = t[1021]
t.EXCHANGE_SHOP_NOT_OPEN = t[1101]
t.EXCHANGE_TIMES_NOT_ENOUGHT = t[1072]
t.EXIST_A_TOWER = t[1063]
t.EXIST_BATTLE_PASS_128 = t[2674]
t.EXIST_BATTLE_PASS_68 = t[2573]
t.FACE_NOT_FIND = t[1112]
t.FAVOR_LEVEL_ARARD_GAINED = t[1978]
t.FIGHT_COUNT_NOT_ENOUGHT = t[1061]
t.FIGHT_TEAM_BUDDY_NOT_EXIST = t[1912]
t.FIGHT_TEAM_NOT_EXIST = t[1919]
t.FIRST_RECHARGE_AWARD_LOCK = t[1947]
t.FIXED_BUDDY_NOT_EXIST_TEAM = t[1907]
t.FORMATION_IS_LOCK = t[1887]
t.FORMATION_NOT_FIND = t[1068]
t.FREE_CHOOSE_DRAW_ID_NOT_OPEN = t[1856]
t.FREE_CHOOSE_DRAW_NOT_USE = t[1855]
t.FRIEND_APPLY_NOEXIST = t[1402]
t.FRIEND_NOEXIST = t[1404]
t.FRIEND_NUM_LIMIT = t[1403]
t.FRIEND_PRESENT_REWARD_NOT_FOUND = t[1811]
t.FRONT_EPISODE_NOT_FINISH = t[1778]
t.FUNCTIONAL_NPC_CANT_INTERACT = t[1410]
t.FUNCTIONAL_NPC_NOT_FOUND = t[1409]
t.GEMSTONE_LOCK = t[1900]
t.GEMSTONE_MAX_LEVEL = t[1891]
t.GEMSTONE_REPEAT_EQUIP = t[1902]
t.GEMSTONE_SLOT_NOT_FOUND = t[1901]
t.GEMSTONE_UP_LEVEL_ERROR = t[1892]
t.GET_AWARD_LIMIT = t[1951]
t.GET_EVENT_NOT_BY_WAY = t[1839]
t.GET_FRIEND_PRESENT_REWARD_DAY_LIMIT = t[1812]
t.GET_ROOM_PLAYER_DATA_FAIL = t[1664]
t.GET_SEGMENT_AWARD_AFTER_NOT_CHANGE_SEGMENT = t[1986]
t.GIFT_BUY_CNT_IN_LIMIT = t[1674]
t.GOLD_EQUIP_AWARD_GAINED = t[2004]
t.GOLD_EQUIP_NOT_FOUND = t[2005]
t.GOLD_EQUIP_NOT_OPEN_SELECT = t[2015]
t.GOODS_QUOTA_NOT_ENOUGHT = t[1103]
t.GUILD_APPLY_NOEXIST = t[1705]
t.GUILD_CREATE_FAILED = t[1700]
t.GUILD_IDEA_CONTAIN_SENSITIVE_WORD = t[1715]
t.GUILD_IDEA_TOO_LONG = t[1696]
t.GUILD_ISNOT_EMPTY = t[1708]
t.GUILD_MEMBER_NUM_LIMIT = t[1704]
t.GUILD_NAME_CONFLICT = t[1699]
t.GUILD_NAME_CONTAIN_SENSITIVE_WORD = t[1714]
t.GUILD_NAME_IS_EMPTY = t[1695]
t.GUILD_NAME_TOO_LONG = t[1694]
t.GUILD_NOT_GET_ONLINE_NUM = t[1768]
t.GUILD_OPERATION_IN_CD = t[1709]
t.HAD_BUY = t[1085]
t.HAD_DROPED = t[1069]
t.HAD_RESTORE_HP = t[1607]
t.HAS_ACCEPT_GROUP_TASK = t[1614]
t.HAVE_BUY_SENIOR_BATTLE_PASS = t[1897]
t.HAVE_ORNAMENTS_ITEMS = t[1755]
t.HELP_FIGHT_BUDDY_ERROR = t[1922]
t.HELP_FIGHT_LIMIT = t[1992]
t.HELP_FIGHT_POS_ERROR = t[1921]
t.HERO_ALREADY_GOOUT = t[1805]
t.HERO_IS_DEAD = t[1087]
t.HERO_NOT_DEAD = t[1066]
t.HERO_NOT_FIND_RUNE2_DATA = t[1683]
t.HERO_NOT_FOUND = t[1086]
t.HERO_NOT_SET_RUNE2 = t[1667]
t.HIT_COUNT_ERROR = t[1039]
t.HIVE_VERIFY_RECHARGE_ERROR = t[1997]
t.HP_OVERFLOW = t[1088]
t.ID_UUID_MISMATCH = t[1059]
t.ILLEGAL_CONTENT = t[1676]
t.IMPORTTANT_MAIL_MAX_CNT = t[1094]
t.INFINITE_ENTRY_NOT_FOUND = t[1872]
t.INFINITE_GROUP_NOT_FOUND = t[1871]
t.INFINITE_GROUP_REPEAT = t[1873]
t.INFINITE_MAST_ENTRY_NOT_SELECT = t[1870]
t.INFINITE_NOT_FIND = t[1417]
t.INFINITE_NOT_OPEN = t[1874]
t.INFINITE_NOT_SELECT_OPTION = t[1875]
t.INFINITE_PRIVILEGE_OPENED = t[1716]
t.INFINITE_PRIVILEGE_PRE_NOT_OPEN = t[1717]
t.INFINITE_SCORE_GAINED = t[1868]
t.INFINITE_SCORE_LESS = t[1869]
t.INFINITE_SCORE_REWARD_NOT_THROUGH = t[1867]
t.INFINITE_SELECT_OPTION_ERROR = t[1876]
t.INSUFFICIENT_CHAT_LV = t[1509]
t.INVAILD_FIXED_BUDDY = t[1911]
t.INVALID_CHAT_CHANNEL_ID = t[1503]
t.INVALID_WORD = t[1679]
t.INVITATION_EXPIRE = t[1713]
t.INVITE_PLAYER_IN_CD = t[1661]
t.IN_BAN_CHAT_STATE = t[1126]
t.IN_CHAT_CD = t[1510]
t.IN_CHOOSE_REWARD_STATUS = t[1742]
t.IN_ROOM_NOT_TP_BY_MAP = t[1771]
t.ISNOT_IN_A_GUILD = t[1701]
t.IS_IN_WAR = t[1060]
t.ITEM_CANNOT_COMBIME = t[1769]
t.ITEM_NOT_FIND = t[1084]
t.ITEM_NOT_RECOVER = t[1764]
t.ITEM_RECOVER_NOT_ACTIVE = t[1765]
t.JOURNEY_EVENT_PRE_NOT_DONE = t[1955]
t.KITTEN_ESCAPE_EPISODE_NOT_OPEN = t[2002]
t.KITTEN_ESCAPE_PASSED = t[2003]
t.LACK_ACTY_CHOOSE_REWARD_CONFIG = t[1740]
t.LEVEL_COND_NOT_COMPLETE = t[1822]
t.LEVEL_REWARD_GAINED = t[1823]
t.LINEAR_GAINED = t[1858]
t.LINEAR_NOT_OPEN = t[2016]
t.LINEAR_STAR_NOT_ENOUGH = t[1859]
t.LOBBY_NETWORK_ERR = t[1738]
t.LOGIN_FAILED = t[1006]
t.MAGIC_DONT_PERMIT_MISSILEUUID = t[1040]
t.MAGIC_DONT_PERMIT_SKILLUUID = t[1041]
t.MAGIC_NOT_ALLOW = t[1720]
t.MAGIC_NOT_FOUND = t[1042]
t.MAIL_HAD_READ = t[1070]
t.MAIN_TALENT_NOT_ACTIVATE = t[1508]
t.MAP_TP_IN_IDENTICAL_FLOOR = t[1773]
t.MARK_REPEAT = t[1610]
t.MASK_USE_FORCE_MAIN_POS = t[1908]
t.MATCH_JOIN_FAIL = t[2014]
t.MATCH_PARAM_ERR = t[1647]
t.MATERIAL_DAY_NOT_CHOOSE_DROP = t[1803]
t.MATERIAL_DROP_ERROR = t[1927]
t.MATERIAL_ERROR = t[1067]
t.MATERIAL_NOT_CHOOSE_DROP = t[1802]
t.MATERIAL_NOT_FIND = t[1416]
t.MATERIAL_NOT_OPEN = t[1835]
t.MATERIAL_NOT_SWEEP = t[1926]
t.MAX_NAME_SIZE = t[1111]
t.MAX_QUOTATION_SIZE = t[1110]
t.MAX_REFRESH_COUNT = t[1075]
t.MINESWEEPER_FLUSH_FREQUENT = t[2808]
t.MISSILE_DONT_PERMIT_SKILLUUID = t[1043]
t.MISSILE_NOT_FOUND = t[1044]
t.MISSILE_TARGET_NOT_FOUND = t[1608]
t.MONKEY_FONT_COUNT_MAX = t[2007]
t.MONKEY_NOT_RUNING = t[2028]
t.MONKEY_QUESTION_COMPLETE = t[2024]
t.MONKEY_QUESTION_DONED = t[2037]
t.MONKEY_QUESTION_PARSING = t[2026]
t.MONKEY_TYPE_WRITER_QUESTION_NOT_OPEN = t[2027]
t.MONKEY_TYPE_WRITER_RUNNING = t[2012]
t.MONKEY_UNIT_COUNT_NOT_MAX = t[2023]
t.MONKEY_WRITER_MAX_LEVEL = t[2029]
t.MONSTER_ARCH_LOCK = t[1119]
t.MONTHLY_CARD_DAY_LIMIT = t[1681]
t.MOVE_VIDEO_LOCK = t[1121]
t.MUSEUM_ACHIEVE_REWARD_NOT_OPEN = t[1881]
t.MUSEUM_EXHIBIT_COUNT_LIMIT = t[1880]
t.MUSEUM_FACTORY_MAX_LV = t[1883]
t.MUSEUM_MAKE_FORMULA_NOT_OPEN = t[1878]
t.MUSEUM_POS_NOT_OPEN = t[1866]
t.NAME_CONTAIN_SENSITIVE_WORD = t[1675]
t.NEWBIE_PRIVILEGE_NOT_FOUND = t[1817]
t.NOTICE_READ_REPEAT = t[1104]
t.NOT_ACHIEVE_EPI_STAT = t[1779]
t.NOT_ACTIVE_MONTHLY_CARD = t[1977]
t.NOT_ALLOW_CREATE_ROLE = t[1763]
t.NOT_ASSIST_FREESTAMINE_UUID = t[2811]
t.NOT_AT_GET_PRIVILEGE_REWARD_TIME = t[1818]
t.NOT_BRANCH_TASK = t[1781]
t.NOT_BUT_NEWBIE_PRIVILEGE_GIFT = t[1821]
t.NOT_BUY_GIFT_BY_FACINGID = t[1672]
t.NOT_BUY_GIFT_BY_SDK = t[1671]
t.NOT_BUY_SHOPPING = t[1898]
t.NOT_CAN_ADD_GREED_KILL = t[1657]
t.NOT_CARGO_BLESS = t[1124]
t.NOT_CHAPTER = t[1775]
t.NOT_CHILD_MISSILE_ID = t[1092]
t.NOT_CHOOSE_SECT = t[1831]
t.NOT_COMMPLE_REWARD_CONDITION = t[1894]
t.NOT_FIND_ABILITY_DROP = t[1833]
t.NOT_FIND_BUDDY_REFINE_REPLACE_ENTRY = t[2022]
t.NOT_FIND_FIGHT_BUDDY = t[1083]
t.NOT_FIND_GIFT_CONFIG = t[2025]
t.NOT_FIND_ITEM = t[1666]
t.NOT_FIND_ORNAMENTS_SOURCE = t[1747]
t.NOT_FIND_RECEIVE_REWARD = t[1682]
t.NOT_FIND_ROOM = t[1640]
t.NOT_FIND_RUNE2_CAST_DATA = t[1684]
t.NOT_FIND_RUNE2_SOURCE = t[1687]
t.NOT_FIND_SDKKEY_ID = t[1678]
t.NOT_FIND_SDKKEY_ITEM = t[1670]
t.NOT_FIND_SDKKEY_TYPE = t[1668]
t.NOT_FIND_SECT = t[1832]
t.NOT_FOUND_FLUSH_ENTRY = t[1904]
t.NOT_FOUND_GEMSTONE = t[1889]
t.NOT_FOUND_GEMSTONE_CONSUME = t[1890]
t.NOT_FOUND_RELIC = t[1828]
t.NOT_FOUNT_FIGHT_TEAM = t[1906]
t.NOT_HAVE_MATCH_PLAYER = t[1654]
t.NOT_IN_BUY_GIFT_TIME = t[1673]
t.NOT_IN_NEW_BIE_PRIVILEGE = t[1820]
t.NOT_IN_WAR = t[1049]
t.NOT_IS_STORE = t[1800]
t.NOT_LOGIN = t[1073]
t.NOT_LONG_CHAPTER = t[1814]
t.NOT_OPEN_SWEEP = t[1877]
t.NOT_READ_NEWBIE_STORY = t[1612]
t.NOT_RECEIVA_STAR_REWARD = t[1748]
t.NOT_SETTING_FORMATION = t[1888]
t.NOT_TOWER_TP_REVIVE_ROOM = t[1723]
t.NOT_TO_FIND_ACCOUNT_ID_CARD = t[1958]
t.NOT_TO_FIND_DEVELOP_AWARD = t[2806]
t.NOT_TO_FIND_PARAM = t[1996]
t.NOT_TO_FIND_RECHARGE_ORDER = t[1952]
t.NOT_TO_FIND_SDK_ACCOUNT_DATA = t[1957]
t.NOT_TO_USE_DIAMOND = t[2366]
t.NOT_TO_USE_PLATFORM_RECHARGE_FUNC = t[1995]
t.NOT_TO_USE_UGSDK_ACCOUNT_SIMULATED_RECHARGE = t[1960]
t.NOT_USE_ITEM = t[1973]
t.NOT_USE_RECUPERATION_FUN = t[1849]
t.NO_FIND_DISCARD_ITEM = t[2033]
t.NO_HAS_GREED_KILL = t[1658]
t.NO_HAS_MATCH = t[1656]
t.NO_PERMISSION = t[2011]
t.NO_REPEAT_USE_ITEM = t[1653]
t.NPC_GOODS_HAD_BUY = t[1753]
t.NPC_GOODS_NOT_FOUND = t[1752]
t.NPC_IS_NOT_SHOP_TYPE = t[1751]
t.OBJECT_NOT_FOUND = t[1029]
t.OK = t[0]
t.ORANSMENT_NOT_ACTIVE = t[2031]
t.ORNAMENT_GAINED = t[1970]
t.ORNAMENT_SELECT_FINISH = t[1967]
t.OTHERSIDE_FRIEND_NUM_LIMIT = t[1721]
t.OWNED_A_GUILD = t[1698]
t.PARAM_ERROR = t[1056]
t.PARENT_MISSILE_NOT_FOUND = t[1091]
t.PARTICIPATE_WEEK_ACTY_PVP = t[1784]
t.PERMISSION_DENIED = t[1706]
t.PLATFORM_AUTH_FAILED = t[1601]
t.PLATFORM_NOT_LOGIN_SERVER = t[1905]
t.PLATFORM_RECHARGE_DATA_ERROR = t[1998]
t.PLAYER_DATA_ERR = t[1816]
t.PLAYER_IN_BAN_STATUS = t[1743]
t.PLAYER_IN_ROOM = t[1642]
t.PLAYER_IN_WAR = t[1659]
t.PLOT_PREHEAT_CLICKED = t[2019]
t.PLOT_PREHEAT_UNLOCKED = t[2034]
t.PREFAB_TEAM_ID_ERROR = t[1913]
t.PREFAB_TEAM_NAME_ERROR = t[1914]
t.PREFAB_TEASM_MAIN_POS_NOT_EXIST = t[1918]
t.PREFAB_TEASM_SIZE_ERROR = t[1915]
t.PROSPERITY_MAX_LV = t[1863]
t.PROTO_ERROR = t[1008]
t.PUZZLE_CONSUME_ID_ERROR = t[1936]
t.PUZZLE_CONSUME_NOT_FOUND = t[1935]
t.PUZZLE_CONSUME_USE_SELF = t[1937]
t.PUZZLE_DECOMPOSE_ERROR = t[1933]
t.PUZZLE_DELETE_ERROR = t[1938]
t.PUZZLE_GAME_EPISODE_NOT_OPEN = t[2357]
t.PUZZLE_NOT_PLACE_IN = t[1931]
t.PUZZLE_PLACE_IN_ERROR = t[1934]
t.PUZZLE_PLACE_OUT_ERROR = t[1932]
t.PVP_CHANGE_SEGMENT_CNT_LIMIT = t[1930]
t.PVP_NOT_LACK_SEGMENT = t[1929]
t.PVP_SEGEMTN_NOT_FIND = t[1791]
t.PVP_SEGMENT_NOT_OPEN = t[1928]
t.PVP_SEGMENT_POND_NOT_FOUND = t[1794]
t.PVP_SEGMENT_POND_NOT_PLAYER = t[1795]
t.RANK_OBJECT_NOT_FOUND = t[1790]
t.RECEIVE_AWARD_REPEAT = t[1609]
t.RECHARGE_LIMIT_TEXT_1 = t[1968]
t.RECHARGE_LIMIT_TEXT_2 = t[1969]
t.RECHARGE_ORDER_DATA_NOT_MATCH = t[1999]
t.RECHARGE_ORDER_DELIVER_GOODS_ERROR = t[2000]
t.RECHARGE_ORDER_HAVE = t[1949]
t.RECHARGE_ORDER_WAS_CANCEL = t[1954]
t.RECHARGE_ORDER_WAS_DELIVERED = t[1953]
t.RECHARGE_PREVENT_ADDICTION = t[1950]
t.RECHARGE_PROJECT_IS_BAN = t[2361]
t.RECHARGE_PROJECT_NOT_OPEN = t[1669]
t.RECUPERATION_ORNAMENT_NOT_GAIN = t[1965]
t.REFINE_UPGRADE_NOT_SATISFY_CFG_LV = t[1711]
t.REFRESH_ABILITY_DROP_ERROR = t[1853]
t.REJOIN_CHAT_CHANNEL = t[1502]
t.RELIC_ALREADY_MAX_LV = t[1830]
t.RELIC_ENTRY_NOT_EXIST = t[1827]
t.RELIC_ENTRY_REFLUSH_ERROR = t[1843]
t.RELIC_ENTRY_REPEAT_ERROR = t[1845]
t.RELIC_NOT_INLAY = t[1847]
t.RELIC_SLOT_LOCK = t[1846]
t.RELIC_UP_USE_SELF = t[1829]
t.REPEAT_SEND_FRIEND_REWARD = t[1813]
t.REQUEST_FREQUENT = t[1615]
t.REQ_FREQUENCY_TOO_HIGH = t[102]
t.ROLE_IN_WAR = t[1055]
t.ROLE_NOT_EXIST = t[60002]
t.ROLE_NOT_FIND = t[1007]
t.ROLE_NOT_IN_BAN_STATUS = t[1745]
t.ROLE_NOT_IN_CHAT_CHANNEL = t[1500]
t.ROLE_NOT_IN_GUILD = t[1702]
t.ROOM_CHANGE_PLAYER_STATE_FAIL = t[1641]
t.ROOM_DISSATISFY_ACTY_LV = t[1650]
t.ROOM_HAVE_IDENTICAL_ROLE = t[1648]
t.ROOM_INVITE_MESSAGE_OVERDUE = t[2017]
t.ROOM_IN_CREATE_TIME = t[1649]
t.ROOM_IN_WAR = t[2009]
t.ROOM_JOINWAR_PLAYER_NOTREADY = t[1645]
t.ROOM_NOT_LAUNCH = t[2010]
t.ROOM_NOT_TP_BY_MAP = t[1772]
t.ROOM_NO_PLAYERS_TO_INVITE = t[1662]
t.ROOM_PLAYER_DATA_FAIL = t[2008]
t.ROOM_PLAYER_FULL = t[1643]
t.ROOM_PLAYER_NOT_CHANGESTATE = t[1655]
t.ROOM_PLAYER_NOT_FIND = t[1644]
t.RPC_FAILD = t[60009]
t.RPC_TIMEOUT = t[60003]
t.RUNE2_ITEM_LACK_DATA = t[1665]
t.RUNE_SET_UP_REPEAT = t[1788]
t.SDK_IOS_RECHARGE_ORDER_ERROR = t[1956]
t.SDK_VERIFY_ACCOUNT_ERROR = t[1861]
t.SDK_VERIFY_DEVICE_ERROR = t[1884]
t.SEARCH_PLAYER_HAS_GUILD = t[1718]
t.SENDBYTES_LT_RECVBYTES = t[60041]
t.SEND_CACHE_SHORTED = t[60040]
t.SENSITIVE_WORDS = t[2358]
t.SERVER_IS_BUSY = t[1677]
t.SERVER_MAINTENANCE = t[1600]
t.SERVER_OPEN_EQUIPMENT_RESTRICTION = t[1860]
t.SERVER_REGISTER_LIMIT = t[2359]
t.SERVER_STARTING = t[1603]
t.SERVER_TESTING = t[1735]
t.SETTLEMENT_NODE_FAIL = t[1782]
t.SHOP_BAN_BUY = t[1964]
t.SIGN_IN_OVERFLOW = t[1613]
t.SIGN_REPEAT = t[1100]
t.SKILL_MAX_LEVEL = t[1815]
t.SKILL_NOT_ACTIVE = t[1604]
t.SKILL_NOT_FOUND = t[1045]
t.SKILL_UUID_REPEAT = t[1046]
t.SKILL_VIRTUAL_MAX_LEVEL = t[1857]
t.SPROTO_NOT_IN_PRODUCT_ENV = t[1848]
t.STRANGER_HELP_CNT_LIMIT = t[1809]
t.SUB_MODULE_SHOW_CASE_NOT_OPEN = t[1879]
t.SUB_MUSEUM_MODULE_MAX_LV = t[1862]
t.SYSTEM_NOT_OPEN = t[1606]
t.TALENT_ACTIVATE = t[1089]
t.TALENT_ACTIVATING_ERROR = t[1082]
t.TALENT_CAREER_NOT_MATCH = t[1080]
t.TALENT_EFFECT_NOT_ACTIVATE = t[1095]
t.TALENT_NOT_FIRST = t[1096]
t.TALENT_NOT_FOUND_IN_TREE = t[1081]
t.TALENT_TREE_ACTIVATE_REPEAT = t[1419]
t.TALENT_TREE_NOT_ACTIVATE = t[1418]
t.TARGET_ENTITY_NOT_FOUND = t[1047]
t.TARGET_NOT_IN_YOUR_BLACKLIST = t[1691]
t.TASK_COMPLETE = t[1054]
t.TASK_GET_REWARD = t[1797]
t.TASK_NOT_FOUND = t[1796]
t.TASK_NOT_ORNAMENT_SELECT = t[1966]
t.TASK_NOT_PICK = t[1975]
t.TASK_UNCOMPLETE = t[1053]
t.TEAM_BUDDY_NOT_EXIST = t[1916]
t.TEAM_BUDDY_NOT_GAINED = t[1920]
t.TEAM_LIMIT_NOT_CONDITION = t[2001]
t.TEAM_MAX_COUNT = t[1099]
t.TEAM_NAME_TOO_LONG = t[1098]
t.TEAM_REPEAT_BUDDY = t[1917]
t.TEXT_SENSITIVE_WORDS = t[2035]
t.TICKET_TIMEOUT = t[1688]
t.TITLE_ALREADY_ACTIVATED = t[1759]
t.TITLE_ALREADY_NOT_ACTIVATED = t[1761]
t.TITLE_ALREADY_USING = t[1762]
t.TITLE_GAINED_HIGHER = t[1760]
t.TITLE_NOT_USING = t[1767]
t.TODAY_ALREADY_SET_SCORE = t[1120]
t.TOWER_ALREADY_IN_ROOM = t[1018]
t.TOWER_BEGIN_ROOM_ERROR = t[1016]
t.TOWER_CUR_FLOOR_NOT_PASS = t[1801]
t.TOWER_ENTER_ERROR = t[1064]
t.TOWER_FLOOR_NOT_FIND = t[1011]
t.TOWER_NOT_FIND = t[1010]
t.TOWER_NOT_LIQUIDATION = t[1062]
t.TOWER_NOT_MATCH = t[1065]
t.TOWER_PREV_FLOOR_NOT_FIGHT_THROUGH = t[1015]
t.TOWER_ROLE_FLOOR_IDX_ERROR = t[1019]
t.TOWER_ROLE_ROOM_NUM_ERROR = t[1020]
t.TOWER_ROOMS_DISCONNECTED = t[1017]
t.TOWER_ROOM_ALREADY_FIGHT_THROUGH = t[1014]
t.TOWER_ROOM_NOT_FIGHT_THROUGH = t[1013]
t.TOWER_ROOM_NOT_FIND = t[1012]
t.TP_ROOM_BY_MAP_IN_BAN = t[1770]
t.TREASURE_BOX_GEN_FAILD = t[1629]
t.TREASURE_BOX_NOT_EMPTY = t[1628]
t.TREASURE_CHEST_SELECT_ERROR = t[1834]
t.TREASURE_IS_OBTAINED = t[1407]
t.TREASURE_NOT_EXIST = t[1630]
t.TREASURE_NOT_FINISH = t[1804]
t.TSI_COUPON_NOT_TO_USE_PLATFORM = t[2798]
t.TSI_SDK_RECHARGE_ERROR_1 = t[2788]
t.TSI_SDK_RECHARGE_ERROR_10 = t[2797]
t.TSI_SDK_RECHARGE_ERROR_2 = t[2789]
t.TSI_SDK_RECHARGE_ERROR_3 = t[2790]
t.TSI_SDK_RECHARGE_ERROR_4 = t[2791]
t.TSI_SDK_RECHARGE_ERROR_5 = t[2792]
t.TSI_SDK_RECHARGE_ERROR_6 = t[2793]
t.TSI_SDK_RECHARGE_ERROR_7 = t[2794]
t.TSI_SDK_RECHARGE_ERROR_8 = t[2795]
t.TSI_SDK_RECHARGE_ERROR_9 = t[2796]
t.UNKNOWN_ERROR = t[1009]
t.UNLOCK_FAIL = t[1638]
t.UNPACK_ERROR = t[1002]
t.UNREGISTERED_AUTH_REQUEST = t[1602]
t.USE_BANED_BUDDY = t[1909]
t.USE_BANED_POS = t[1910]
t.USE_NOT_IN_SETTING_BUDDY = t[1886]
t.USE_SDK_CONPON_ERROR = t[2370]
t.VICTIM_NOT_ALIVE = t[1036]
t.VICTIM_NOT_FOUND = t[1038]
t.WEAPON_DEVELOP_NOT_CALL_BACK = t[2805]
t.WEEK_ACTY_BUDDY_REPEAT = t[1798]
t.WEEK_ACTY_PVP_IN_END = t[1786]
t.WEEK_ACTY_PVP_LOCK = t[1783]
t.WEEK_ACTY_PVP_NOT_OPEN = t[1785]
t.WEEK_ACTY_PVP_NOT_USE_ASSISTANT = t[1885]
t.WEEK_ACTY_PVP_STAGE_NOT_OPEN = t[1787]
t.XICODE_SIGN_ERROR = t[2355]
t.XICODE_SIGN_NOT_FIND = t[2354]
return t
