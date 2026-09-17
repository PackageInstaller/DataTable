require("data.language_constants_community")

L_DIAMOND = "魂晶"
L_GOLD = "图灵新钞"
L_DIAMOND_LACK = L_DIAMOND .. "不足"
L_GOLD_LACK = "图灵新钞不足"
L_TVT_FIGHT = ""
L_LOADING_MSG = {
	Loading_Bar_Text = "游戏加载中, 此过程不会消耗流量...",
	start = {
		{
			msg = "班长身份识别",
			fontsize = 24,
			color = cc.c3b(242, 242, 242)
		}
	},
	startnet = {
		{
			msg = "学籍档案数据库信息读取中",
			fontsize = 24,
			color = cc.c3b(242, 242, 242)
		}
	},
	netsuccess = {
		{
			msg = "> 认证通过",
			fontsize = 20,
			color = cc.c3b(146, 208, 80)
		}
	},
	startloadtexture = {
		{
			msg = "> 信号连接正常",
			fontsize = 20,
			color = cc.c3b(146, 208, 80)
		}
	},
	texturesuccess = {
		{
			msg = "> 解除武装魂器安全限制",
			fontsize = 20,
			color = cc.c3b(146, 208, 80)
		},
		{
			msg = "> 载入影像资料",
			fontsize = 20,
			color = cc.c3b(146, 208, 80)
		}
	},
	audiosuccess = {
		{
			msg = "> 载入成功",
			fontsize = 20,
			color = cc.c3b(146, 208, 80)
		},
		{
			msg = "> 3",
			fontsize = 20,
			color = cc.c3b(146, 208, 80)
		},
		{
			msg = "> 2",
			fontsize = 20,
			color = cc.c3b(146, 208, 80)
		},
		{
			msg = "> 1",
			fontsize = 20,
			color = cc.c3b(146, 208, 80)
		}
	},
	startoffline = {
		"> 战斗舱门开启",
		"> 离线战斗收益结算"
	},
	startpv = {
		"> FBI WARNING",
		"> Federal Law provides severe civil and criminal penalties for not 18+"
	}
}
L_GO_BUY_DIAMOND = {
	button = "前往充值",
	des = "建议氪金护肝~v~",
	title = L_DIAMOND .. "不足"
}
L_GO_BUY_GOLD = {
	button = "前往挖矿",
	title = L_GOLD_LACK,
	des = "建议" .. L_DIAMOND .. "挖矿~v~"
}
L_GO_CONTRACT = {
	title = "无出战角色",
	button = "出战角色",
	des = "需要与学员签订契约并指派出战！"
}
L_GO_LAB_SMELT = {
	title = "背包已满",
	button = "前往熔炼",
	des = "清理物品,减轻负载!"
}
L_GO_BUY_TICKETS_TWIST = {
	title = "扭蛋券不足",
	button = "前往商城",
	des = "建议商城购买~v~"
}
L_GO_BUY_BAGLIMIT_ELEMENT = {
	title = "拓展符文背包",
	button = "拓展背包",
	des = "符文背包剩余空间不足！！！"
}
L_GO_BUY_BAGLIMIT_COMPONENT = {
	title = "零件背包已满",
	button = "拓展背包",
	des = "零件背包剩余空间不足！！！"
}
L_GO_BUY_BAGLIMIT_EATABLE = {
	title = "食物背包已满",
	button = "拓展背包",
	des = "食物背包剩余空间不足！！！"
}
L_GO_BUY_BAGLIMIT_WEAPON = {
	title = "武器背包已满",
	button = "拓展背包",
	des = "武器背包剩余空间不足！！！"
}
L_GO_BUY_BAGLIMIT_HORCRUX = {
	title = "魂器背包已满",
	button = "拓展背包",
	des = "魂器背包剩余空间不足！！！"
}
L_GO_BUY_SCOREARENA_TIMES = {
	button = "确 定",
	des = "当前刷新次数不足！是否通过消耗" .. L_DIAMOND .. "来刷新？"
}
L_REFRESH_MARKET = {
	{
		more = "今日剩余次数：",
		title = "刷新商店",
		button = "刷新商店",
		des = "立刻刷新喵酱商店的物品~"
	},
	{
		more = "今日已經刷新次数：",
		title = "刷新任务",
		button = "刷新任务",
		des = "立刻刷新十个勤工俭学任务~"
	},
	[4] = {
		more = "今日剩余次数：",
		title = "刷新零件打造",
		button = "刷新打造",
		des = "立刻刷新四个新零件~"
	},
	[5] = {
		more = "今日剩余次数：",
		title = "刷新符文打造",
		button = "刷新打造",
		des = "立刻刷新四个新符文~"
	},
	[6] = {
		more = "今日剩余次数：",
		title = "刷新商店",
		button = "刷新商店",
		des = "立刻刷新芯片商店的物品~"
	}
}
L_QUICK_FIGHT = {
	more_2 = "剩余次数：%d/%d",
	button = "快速搜寻",
	more = "今日剩余次数：%d/%d",
	title = "快速搜寻",
	des = "快速获得2小时收益"
}
L_QUICK_FINISH_HELP_ADVENTURE = {
	more = "打工剩余时间：",
	title = "快速完成打工",
	button = "快速完成",
	des = "立刻完成打工，土豪就要任性~v~"
}
L_QUICK_FINISH_GEM = {
	more = "生产剩余时间：",
	title = "快速完成升级",
	button = "快速完成",
	des = "立刻完成车间升级，土豪就要任性~v~"
}
L_QUICK_FINISH_COMPOUND = {
	more = "合成剩余时间：",
	title = "快速完成合成",
	button = "快速完成",
	des = "立刻完成芯片合成，土豪就要任性~v~"
}
L_ADD_BAGLIMIT_ELEMENT = {
	more = "最多拥有200格负重",
	title = "购买8格符文背包",
	button = "购买8格",
	des = "立即购买8格符文背包，让符文不再溢出~"
}
L_ADD_INSTANCE_TIMES = {
	title = "增加挑战次数",
	button = "确 认",
	des = "花费" .. L_DIAMOND .. "增加一次挑战次数"
}
L_MAX_BAGLIMIT_ELEMENT = "符文背包已达最大上限"
L_ADD_BAGLIMIT_COMPONENT = {
	titleImage = "BagLayer_refresh.png",
	button = "购买负重",
	title = "增加仓库" .. BAG_ADD_WEIGHT .. "负重",
	des = "消耗魂晶购买仓库" .. BAG_ADD_WEIGHT .. "负重",
	more = "最多可购买" .. BAG_ADD_WEIGHT * BAG_MAX_ADD_TIME[1] .. "负重"
}

setmetatable(L_ADD_BAGLIMIT_COMPONENT, {
	__call = function(self, arg_1_1)
		return {
			button = self.button,
			title = self.title,
			titleImage = self.titleImage,
			des = self.des,
			more = "最多可购买" .. BAG_ADD_WEIGHT * BAG_MAX_ADD_TIME[arg_1_1] .. "负重"
		}
	end
})

L_MAX_BAGLIMIT_ELEMENT = "零件背包已达最大上限"
L_SMELT_LOCKED = "(已锁定)"
L_COMPONENT_INTRO = "零件评分："
L_ELEMENT_INTRO = "符文等级："
L_LOCK = "锁定"
L_UNLOCK = "解锁"
L_STRING_FORMATH_UNLOCK = "%s解锁"
L_DETACH_COMPONENT = {
	title = "卸下已安装零件",
	button = "卸下零件",
	des = "卸下已安装零件，要消耗" .. L_GOLD .. "哟=v="
}
L_CHANGE_COMPONENT = {
	title = "替换已安装零件",
	button = "替换零件",
	des = "替换已安装零件，要消耗" .. L_GOLD .. "哟=v="
}
L_NO_TIMES = "护肝护肝，明日再来"
L_COMPONENT_TWIST = {
	button = "购买&开启",
	title = "扭蛋券不足",
	titleImage = "TwisteggLayer_refresh.png"
}
L_CORE_RESET = {
	button = "购买&使用",
	title = "假条不足"
}
L_QUICK_FINISH_UNLOCK_ROOM = {
	button = "购买&加速",
	title = "加速协议不足",
	titleImage = "title_item.png"
}
L_SKIN_CARD = {
	button = "购 买",
	title = "服装兑换卷不足"
}
L_GIFT_CARD = {
	button = "购 买",
	title = "礼物兑换卷不足"
}
L_FURNITURE_CARD = {
	button = "购 买",
	title = "家具币不足"
}
L_COMPONENT_QUICKFIGHT = {
	title = "速搜寻券不足",
	button = "购买&开启",
	des = "消耗" .. L_DIAMOND .. "购买快速搜寻券, 直接开启"
}
L_UNLOCK_RESEARCH = {
	title = "解锁条目",
	button = "解锁",
	des = "解锁研发条目"
}
L_MORE_GIFT = {
	more = "下次不再弹窗提示",
	title = "送礼次数不足",
	button = "购买&送礼",
	des = "消耗" .. L_DIAMOND .. "额外送礼"
}
L_INSTANCE_LAYER = {
	guankanorob = "该关卡未达到扫荡条件",
	trainlocked = "该副本暂未开放",
	guankalocked = "需要通关上一关卡",
	instancelocked = "该副本尚未解锁",
	activitylocked = "活动副本尚未开启哦",
	pagelocked = "需要通关上一章节"
}
L_ADVENTURE_NAMES = {
	TR_1 = "疾风领域",
	AD_1 = "急速射击",
	TR_2 = "烈焰领域",
	TR_4 = "光耀领域",
	AD_7 = "劳动祭副本",
	TR_3 = "波涛领域",
	AD_3 = "控制领域",
	AD_5 = "稳定输出",
	AD_6 = "究极吸血",
	AD_8 = "十阶副本",
	AD_2 = "领域狂暴",
	AD_4 = "坚若磐石",
	AC_1 = " FIGHT！\n国庆大乱斗",
	TR_5 = "暗影领域",
	AC_2 = "中秋祭！\n科技无差别",
	AC_3 = "狩猎大赛"
}
L_ADVENTURE_DROPNAMES = {
	TR_1 = "奖励风·助战碎片",
	AD_1 = "奖励射手专属零件",
	TR_2 = "奖励火·助战碎片",
	TR_4 = "奖励光·助战碎片",
	AD_7 = "",
	TR_3 = "奖励水·助战碎片",
	AD_3 = "奖励辅助专属零件",
	AD_5 = "奖励战士专属零件",
	AD_6 = "奖励刺客专属零件",
	AD_8 = "",
	AD_2 = "奖励法师专属零件",
	AD_4 = "奖励坦克专属零件",
	AC_1 = "通关奖励扭蛋券",
	TR_5 = "奖励暗·助战碎片",
	AC_2 = "通关获取学院月饼",
	AC_3 = "获取芯片,电路图\n  魂晶,挑战券"
}
L_TRAIN_LOCKED_WORDS = {
	TR_1 = "周一/周末开放哦!",
	TR_5 = "周五/周末开放哦!",
	TR_4 = "周四/周末开放哦!",
	TR_3 = "周三/周末开放哦!",
	TR_2 = "周二/周末开放哦!"
}
L_MARKET_TAG_TYPE = {
	"推荐",
	"新品",
	"热销",
	"限时"
}
L_SHOW_ROLE_INFO_1 = {
	"血量",
	"攻击",
	"攻速",
	"防御",
	"闪避",
	"暴击",
	"强击",
	"奥义",
	"加伤",
	"免伤"
}
L_SHOW_ROLE_INFO_2 = {
	"血量资质",
	"攻击资质",
	"每秒攻击",
	"受到的普攻伤害",
	"普攻闪避概率",
	"普攻暴击概率",
	"普攻强击概率",
	"每秒回血,加强部分大招",
	"造成所有伤害加深",
	"受到所有伤害减免"
}
L_SHOW_ROLE_INFO_3 = {
	强击 = "(伤害1.5倍,优于闪避)",
	闪避 = "(受伤减半,优于暴击)",
	暴击 = "(伤害翻倍,无视防御)"
}
L_SCIENCE_NAME = {
	ATTACK = "攻击",
	XP = "奥义",
	HP = "生命"
}
L_TWIST_DES = {
	[TWISTEGGS_TYPE.normal] = {
		[1] = "50%概率获得魂器碎片",
		[2] = "50%概率获得食材"
	},
	[TWISTEGGS_TYPE.wind] = {
		[1] = "40%概率魂器，50%概率武器",
		[2] = "10%概率获得学员或五星武器"
	},
	[TWISTEGGS_TYPE.fire] = {
		[1] = "40%概率魂器，50%概率武器",
		[2] = "10%概率获得学员或五星武器"
	},
	[TWISTEGGS_TYPE.water] = {
		[1] = "40%概率魂器，50%概率武器",
		[2] = "10%概率获得学员或五星武器"
	},
	[TWISTEGGS_TYPE.light] = {
		[1] = "40%概率魂器，50%概率武器",
		[2] = "10%概率获得学员或五星武器"
	},
	[TWISTEGGS_TYPE.dark] = {
		[1] = "40%概率魂器，50%概率武器",
		[2] = "10%概率获得学员或五星武器"
	},
	[TWISTEGGS_TYPE.recommend] = {
		[1] = "40%概率魂器，50%概率武器",
		[2] = "10%概率获得学员或五星武器"
	}
}
L_WEAPON_POS_NAME = {
	"金属改造",
	"机械改造",
	"能源改造",
	"内核改造",
	"外载改造"
}
L_UNLOCK_DORMROOM_DES = {
	more = "这房价已经很良心了好吗~",
	title = "解锁宿舍房间",
	button = "开房",
	des = "没房子还想开后宫??!!"
}
L_HANDOFMIDAS_TIPS = {
	[1] = "累计挖矿的增益次数,挖矿倍率提高",
	[2] = "免费挖矿同样享受挖矿效率的增益",
	[3] = "每天首次挖矿免费，不消耗" .. L_DIAMOND
}
NEED_SANVALUE = "   学员精神力不足\n请放置于宿舍快速回复"
L_ADD_ARENA_TIMES = {
	title = "回复竞赛次数",
	button = "确认购买",
	des = "花费" .. L_DIAMOND .. "回复次数"
}
L_SERVANT_BREAKLIMIT = {
	bntstr = "共 振",
	title = "角色进阶"
}
L_SWIMCOST = {
	title = "体能锻炼"
}
L_LAB_UPGRADE = {
	bntstr = "确认升级",
	title = "车间升级"
}
L_WEAPON_UPGRADE = {
	bntstr = "升 星",
	title = "魂武升星"
}
L_LOGIN_PLAYER = {
	congratulation = "你已经被魂器学院正式录取为本批次新生，谨向你表示热烈祝贺！\n请持本录取通知书准时来校报到！",
	button_in = "进入学院",
	name_too_long = "名字过长>_<",
	unlock = "%s100级解锁"
}
L_LOGOUT_PLAYER = {
	title = "切换角色",
	button = "确认登出",
	des = "登出当前角色"
}
L_TIME_FORMAT = {
	"%d天%02d时",
	"%02d时%02d分",
	"%02d分",
	"少于1分钟",
	"%02d分%02d秒"
}
L_TIME_FORMAT_DAYNHOUR = "%02d天%02d时"
L_TIME_FORMAT_HOURMIN = "%02d小时%02d分钟"
L_TIME_FORMAT_MINSEC = "%02d分钟%02d秒"
L_TIME_FORMAT_DAYHOURMIN = "%02d天%02d小时%02d分钟"
L_TIME_FORMAT_HOURMINSEC = "%02d小时%02d分钟%02d秒"
L_TIME_REST = "剩余："
L_TIME_REST2 = "剩余"
L_TIME = "时间: "
L_TIME_TEXT = {
	"%d天%d小时",
	"%d小时%d分钟",
	"%d分钟",
	"%d分钟%d秒",
	"%d秒"
}
L_TIME_SINGLE = {
	Day = "%d天",
	Hour = "%d小时",
	HourStr3V3 = "%s小时",
	Less = "剩余时间小于1分钟",
	Minute = "%d分钟"
}
L_TIME_SINGLE_R = "当前已充值: %d天"
L_TIME_TEXT_SIMPLE = {
	Day = "天",
	Hour = "时",
	Second = "秒"
}
L_DATE_TEXT = "%s月%s日"
L_WEEK_TEXT = {
	[0] = "周日",
	"周一",
	"周二",
	"周三",
	"周四",
	"周五",
	"周六",
	"周日"
}
L_WEEK_TEXT_SIMPLE = {
	["0"] = "日",
	["1"] = "一",
	["6"] = "六",
	["2"] = "二",
	["5"] = "五",
	["3"] = "三",
	["7"] = "日",
	["4"] = "四"
}
L_NUMBER_TEXT = {
	"一",
	"二",
	"三",
	"四",
	"五",
	"六",
	"七",
	"八",
	"九",
	"十"
}
L_SIGN_DATE = {
	"第一日",
	"第二日",
	"第三日",
	"第四日",
	"第五日",
	"第六日",
	"第七日"
}
L_SYSTEM_UNLOCK_WORD = {
	MarketLayer = "商城",
	MainLayer = "主城",
	SmeltLayer = "熔炼",
	PhotoWeaponLayer = "武器详情",
	EquipLayer = "装备",
	SchoolAreaLayer = "学院",
	PhotoFileHelpGirlLayer = "详情",
	SchoolDeanOfficeLayer = "教务处",
	SignLayer = "签到",
	MailLayer = "邮箱",
	HandOfMidasLayer = "挖矿",
	FightResultLayerNew = "缓存背包",
	HorcruxCommandLayer = "魂器研发",
	SupermarketLayer = "充值",
	ActivityPointLayer = "活动积分兑换",
	ActivityMenuLayer = "活动菜单",
	ActivityEntranceLayer = "活动汇总",
	EquipLayer_ListButton = "装备",
	MarketLayerActive = "活动商店",
	ScoreArenaLayer = "对战演习",
	ClassupdateLayer = "个人信息",
	BagMaterialLayer = "材料背包",
	HelpfigureLayer = "助战",
	AdventureLayer = "物资筹备",
	BagLayer = "仓库",
	SchoolCinemaLayer = "放映室",
	DormitoryLayer = "宿舍",
	ArenaLayer = "抢位赛",
	PhotoGoodsLayer = "物品图鉴",
	BagPartLayer = "零件背包",
	SchoolTrainLayer = "训练室",
	SchoolSwimLayer = "游泳馆",
	RechargeLayer = "充值",
	SchoolFileLayer = "图书馆",
	LabMenuLayer = "科研系统",
	BagWeaponLayer = "魂武背包",
	ActivityExploreLayer_Liuli_Explore = "琉璃演唱会",
	RankLayer = "排行",
	DormitoryLayer_group2 = "宿舍2",
	LabMakeLayer = "制造车间",
	WareHouseLayer = "仓库",
	ActivityLayer = "活动",
	PhotoFileLayer = "档案图鉴",
	TopPlotListLayer = "任务",
	HorcruxLayer = "魂器背包",
	ActivityTaskLayer = "活动任务",
	BagFurnitureLayer = "家具背包",
	PhotoMemoryLayer = "剧情图鉴",
	TwisteggLayer = "扭蛋",
	TaskLayer = "任务",
	ChooseLayer = "战斗"
}
L_BUTTON_TEXT = {
	Accelerate = "加 速",
	continue_got = "继续领取",
	Bought = "已售完",
	Up_Star = "升 星",
	Switch = "替 换",
	Regisit = "注 册",
	Materil_Sold = "出售",
	Exit_Game = "退 出",
	Sell = "卖 掉",
	Adjust = "校 准",
	Advance = "跃 迁",
	Use = "使 用",
	Compound = "合成",
	UnGet = "领 取",
	Cancel = "取消",
	Interrupt = "中 断",
	Continue = "继续冒险",
	Buy = "购 买",
	Up_Grade = "共 振",
	Got = "已领取",
	OC = "超 频",
	Can_cel = "取 消",
	Decoration = "装 修",
	CanGet = "可领取",
	Sure = "确 定",
	Bind = "绑 定",
	Close = "关 闭",
	Dress = "穿 戴",
	goto_quick_fight = "前往搜寻",
	Delete = "删 除",
	Send_Gift = "送 礼",
	Not_Enough = "不 足",
	Strengthen = "强 化",
	Comfirm = "确 认",
	Use_Bag = {
		Ten = "使用10",
		Single = "使用"
	},
	Battle_Array_Btn = {
		GetResults = "领取成果",
		Patrol = "驻守挂机",
		Set_Now_Team = "设为先遣",
		Retreat_Team = "撤回小队",
		Sent_team = "确认派出"
	},
	Midas_Btn = {
		[1] = "免费挖矿",
		[2] = "挖 矿"
	},
	Horcrux_Btn = {
		Decompose = "分解",
		Advance = "共 振",
		Level_Up = "升 级",
		Unload = "卸下",
		Break_Through = "突 破"
	},
	Item_Panel_Btn = {
		Choose = "选择",
		Equip = "装备",
		Restore = "还原",
		Comfirm_Comsume = "确认消耗",
		Switch = "替换",
		Details = "详情",
		Strenthen = "强化",
		Sure = "确认",
		Unload = "卸下"
	},
	BAG_TITLE = {
		"分解",
		"出售",
		"出售",
		"分解",
		[19] = "出售"
	}
}
L_PLAYER_DATA_TYPE = {
	Postcard = "明信片",
	Weapons = "魂武",
	Exp = "经验",
	SpecailJumpTower = "综合模拟战",
	TVTScore = "团体赛分数",
	Explorecoin = "探险币",
	Horcrux_Card = "魂卡",
	ArenaScore = "积分赛分数",
	Tech = "科技点",
	Horcrux = "魂器",
	Girls = "学员",
	Energy = "能量",
	Draw_Card = "扭蛋券",
	Active = "活跃点",
	Honor = "荣誉点",
	Diamond = L_DIAMOND,
	Gold = L_GOLD,
	Extradiamond = "额外赠送" .. L_DIAMOND,
	Accumulate_Diamond = "累计" .. L_DIAMOND
}
L_COMMON_WARNING = {
	Used_Up = "%s不足QAQ",
	Time_Lock = "开放",
	Using = "装备中",
	Material_Lack = "材料不足",
	Locking = "尚未解锁"
}
L_FUNCTION_DEVELOPING = "敬请期待"
L_BOSS_FIGHT_NO_EFFECT = "无特殊效果"
L_CLEAR_ALL = "已通关"
L_CLEAR_CHAPTER = "通关"
L_ROLE_HANGUPING = "正在挂机, 不能探险"
L_OTHER_ITEM = "其他"
L_SKILL_CD = "冷却时间"
L_TALK_STRING = "第   %d   幕"
L_QUALITY_STAR = "星"
L_CLICK_CONTINUE = "点击继续"
L_FUNCTION_NO_OPEN = "功能暂未开放QAQ"
L_CLICK_BLANK_EXIT = "点击空白处退出"
L_UNLOCK_NEEDING = "解锁需要："
L_LOGIN_TIPS = {
	Input_Account = "请输入账号",
	Get_VerifyCode = "获取验证码",
	Player_Account = "玩家账号：",
	Guest = "游客#",
	Account_Tip = "用户名由数字与字母组成，6-24位",
	Input_PhoneNumber = "请输入手机号码",
	Phone_Passw_Tip = "密码由数字与字母组成,6-12位",
	Input_Passw = "请输入密码",
	Passw_Tip = "密码由数字与字母组成， 6-24位",
	Input_Email_Account = "请输入邮箱账号",
	Input_VerifyCode = "请输入验证码",
	Input_Test_Account = "请输入账号名字"
}
L_LOGIN_WARNING = {
	Common = "用户名或密码错误>_<",
	Guest = "该账号已被绑定"
}
L_LOGIN_REGIST_WARNING = {
	Unknow_Error = "发生未知错误，请重试",
	Email_Regist_Fail = "邮箱注册暂未开放",
	Email_Bind_Fail = "邮箱绑定暂不开放",
	Account_Warning = {
		"绑定账号不能为空",
		"用户名长度需要6-24位",
		"用户名不能为纯数字",
		"用户名须由字母和数字组成",
		"该用户名已被使用！"
	},
	Passw_Warning = {
		"密码不能为空",
		"两次输入密码不一致！！！",
		"密码长度需要6-24位",
		"密码须由字母和数字组成"
	},
	VerifyCode_Warning = {
		"请输入验证码...",
		"验证码获取失败,请重试",
		"电话格式不正确",
		"电话号码未被绑定"
	},
	PhoneNum_Warning = {
		"已绑定手机",
		"手机号错误",
		"密码长度需要6-12位",
		"未绑定",
		"手机号已被绑定==="
	},
	Email_Account_Warning = {
		"邮箱账号输入错误",
		"密码长度需要6-12位",
		"邮箱账号不存在，请重新输入"
	},
	Test_Account_Warning = {
		"用户名长度需要6-24位",
		"用户名不能为纯数字",
		"用户名须由字母和数字组成"
	},
	Regist_Warning = {
		[1] = "账号未注册,请先注册",
		[2] = "注册失败~~~"
	},
	Activition_Code_Warning = {
		[1] = "注册失败！激活码不存在",
		[2] = "注册失败！激活码已被使用"
	},
	Find_Account_Back = {
		[1] = "请输入新密码",
		[2] = "请再次输入密码"
	}
}
L_LOGIN_BIND_SUCCESS = "绑定账号成功"
L_PHONE_REGIST_SUCCESS = "手机注册成功: "
L_LOGIN_CHANGE_PASSW_MSG = {
	"密码修改成功",
	"密码格式错误",
	"验证失败"
}
L_BIND_PLAYER2ACCOUNT_WARNING = {
	nil,
	"账号不存在",
	"账号已被绑定",
	"无有效游戏id",
	"游戏角色已绑定其他账号"
}
L_BIND_PHONE2ACCOUNT_MSG = {
	"手机绑定成功: ",
	"账号无效。。。",
	"当前为游客账号, 不能绑定手机===",
	"手机号已被绑定===",
	"账号已绑定其他手机",
	"当前账号未登录。。。"
}
L_ACTIVITYINFO_NAME = {
	nil,
	"开服活动",
	nil,
	"琉璃活动",
	"自动弹出的签到活动",
	nil,
	"卡米拉活动",
	"万圣节活动",
	nil,
	"双十一活动",
	"妮妮法活动",
	nil,
	nil,
	nil,
	nil,
	"情人节活动"
}
L_ACTIVITY = "活动"
L_ACTIVITY_END = "活动已结束"
L_ACTIVITY_TIME_STR = {
	Week_Open = "周%s开启",
	End = "%s结束",
	Open = "%s开启"
}
L_ACTIVITY_REST_TIME = "距结束还剩%d天"
L_ACTIVITY_CLOSE = "活动已关闭"
L_ACTIVITY_OUT_OF_TIME = "活动过期"
L_ACTIVITY_START_TIME = "将于10月17日0时开启"
L_ACTIVITY_HAD_JOINED = "已参加过的此活动"
L_ACTIVITY_EXPLORE_END = "活动探险已关闭"
L_ACTIVITY_EXPLORE_BUY_TIMES = {
	Used_Out = "购买次数用完",
	title = "获取次数",
	button = "购买",
	des = "该本今日次数已用完,是否花费%d魂晶补充%d次"
}
L_ACTIVITY_EXPLORE_CLOSE = "活动尚未开启"
L_ACTIVITY_EXPLORE_ONCE = "该本只能挑战一次~"
L_ACTIVITY_EXPLORE_START = "%s后开启"
L_ACTIVITY_EXPLORE_NAME = "演唱会大作战"
L_ACTIVITY_EXPLORE_COST = {
	Is_Once = "仅限一次挑战",
	Times = "消耗次数: ",
	Ticket = "消耗门票:"
}
L_ACTIVITY_POINT_UNAWARD = "未领取"
L_ACTIVITY_POINT_UNLOCK = "点解锁"
L_ACTIVITY_POINT_EXCHANGE_NIL = "活动无积分兑换"
L_ACTIVITY_GET_ALL_AWARD = "当前奖励已全部领取"
L_ACTIVITY_POINT_GOTO_TASK = "前往任务"
L_ACTIVITY_SIGN_BTN = "签 到"
L_ACTIVITY_SIGN_FINISH = "已签到"
L_ACTIVITY_SIGN_END = "签到完成"
L_ACTIVITY_SIGN_CLOSE = "签到活动已结束"
L_ACTIVITY_SIGN_TIPS = "Tips:每日领取签到奖励，集齐门票参加演唱会吧"
L_ACTIVITY_SIGN_TODAY = {
	Finish = "今日已签到",
	Error = "无法签到,0x0007",
	Nil = "今日无签到"
}
L_ACTIVITY_SIGN_REMEDY_DIALOG = {
	Title = "操作确认",
	Content = "消耗%d" .. L_DIAMOND .. "可以进行补签，是否补签？"
}
L_ACTIVITY_SIGN_STATE = {
	[0] = "暂无活动签到",
	{
		[0] = "无活动签到",
		nil,
		nil,
		"今日已签到",
		"活动签到已全部完成",
		[6] = L_DIAMOND_LACK
	},
	"该活动签到已结束"
}
L_ACTIVITY_FIRST_ENTER = "演唱会预告"
L_ACTIVITY_HAD_OPEND = "演唱会开启"
L_ACTIVITY_SIGN_CONFIRM = {
	Des = "当前页面已经更新，请点击确认后再次操作",
	Title = "页面更新"
}
L_ACTIVITY_SIGN51_BTN = "打 卡"
L_ACTIVITY_SIGN51_FINISH = "已打卡"
L_ACTIVITY_SIGN51_END = "打卡完成"
L_ACTIVITY_SIGN51_CLOSE = "打卡活动已结束"
L_ACTIVITY_STAGE_TASK_LIST = {
	[0] = "活动阶段任务未开启",
	nil,
	"活动阶段任务已结束"
}
L_ACTIVITY_TASK_LIST = {
	[0] = "该活动无活动任务!",
	nil,
	nil,
	"任务列表阶段尚未开启",
	"任务列表阶段已结束"
}
L_ACTIVITY_TASK_SWITCH_BTN_LOCK = "尚\n未\n解\n锁"
L_ACTIVITY_TASK_COMPLETE_DATA = {
	Complete_Num = "完成：",
	Pt_Label = "我的PT："
}
L_ACTIVITY_TASK_COMFIRM_AWARDS = {
	[0] = "该活动没有任务",
	nil,
	"该活动已结束",
	"请先领取上一任务奖励",
	"任务无效"
}
L_ACIVITY_INFO = {
	[4] = {
		name = "琉璃活动"
	},
	[2] = {
		name = "开服活动实际id为6"
	},
	[5] = {
		name = "自动弹出的签到活动"
	}
}
L_EXPEDITION_WARNING = {
	[1] = "缺乏物资，请等待明日物资刷新~"
}
L_EXPEDITION_EXAMINE = "考核"
L_EXPEDITION_INADVENTURE = "正在探险"
L_EXPEDITION_TOWER_FLOOR_NOT_BOSS = "第<span style=color: rgb(0, 255, 252);>%d</span>层</p>"
L_EXPEDITION_TOWER_FLOOR_BOSS = "第<span style=color: rgb(219, 12, 16);>%d</span>层</p>"
L_EXPEDITION_TOWER_FLOOR_BOSS_SUCCESS = "第<span style=color: rgb(197, 134, 255);>%d</span>层</p>"
L_EXPEDITION_TOWER_FLOOR_NOW = "第<span style=color: rgb(255, 240, 0);>%d</span>层</p>"
L_ADVENTURE_WARNING = {
	"",
	"试炼未解锁",
	"试炼未到开放时间",
	"今日挑战次数已用完, 请明日再来",
	"章节未解锁",
	"等级需要达到",
	"级才能挑战",
	"当月爬塔已重置，请重头开始挑战！"
}
L_ADVENTURE_EXAMINE = "考核"
L_ADVENTURE_INADVENTURE = "正在探险"
L_ADVENTURE_TOWER_FLOOR_NOT_BOSS = "第<span style=color: rgb(0, 255, 252);>%d</span>层</p>"
L_ADVENTURE_TOWER_FLOOR_BOSS = "第<span style=color: rgb(219, 12, 16);>%d</span>层</p>"
L_ADVENTURE_TOWER_FLOOR_BOSS_SUCCESS = "第<span style=color: rgb(197, 134, 255);>%d</span>层</p>"
L_ADVENTURE_TOWER_FLOOR_NOW = "第<span style=color: rgb(255, 240, 0);>%d</span>层</p>"
L_ARENA_MSG = {
	Chance_Left = "还有%d次挑战机会！",
	Rank_Detail = {
		"第 %d 名:",
		"第 %d ~ %d 名:",
		"第 %d 名后:"
	},
	Award_Detail = "奖励:%d" .. L_DIAMOND .. " + %d荣誉点",
	Addition_Tip = {
		info = "11111111111111111",
		title = "奖励说明"
	}
}
L_ARENA_WARNING = {
	Begin_Fight = {
		"",
		"BLACK ID",
		"次数不足",
		"出战阵容角色为空~",
		"无效阵容~",
		"正在被挑战O~O",
		"尚未解锁~",
		"4月1日后开启，敬请期待"
	}
}
L_ARENA_BUY_TIME = {
	Common = "还有10次挑战机会",
	Fail = "今天已经购买次数已用光，明天再买吧~",
	Success = "增加次数成功~~",
	Add = "%d" .. L_DIAMOND .. "回复1次试炼次数",
	Diamond_Lack = L_DIAMOND_LACK
}
L_ARENA_DETAIL = "详 情"
L_BAG_NAME = {
	"武器背包",
	"",
	"零件背包",
	"家具背包",
	"材料背包"
}
L_BAG_WARNING = {
	Bag_Status_Warning = "仓库负重购买已达上限",
	Add_Content_Warning = {
		[1] = "仓库负重上限提高%d",
		[3] = "仓库已达上限",
		[2] = L_DIAMOND_LACK
	}
}
L_BAG_SET_ITEM_OVER_WEIGHT = "物品已放入仓库(负重上限)"
L_EXP_TICKET_MSG = {
	Use_Fail = "使用经验券失败！ QAQ",
	Gain_EXP = "获得了%d经验！！！",
	Not_Enough = "经验券不足 QAQ"
}
L_GOLD_BAG_MSG = {
	Gain_Gold = "获得%d" .. L_GOLD .. "！",
	Gain_Str = L_GOLD .. " X%d"
}
L_COMPONENT_CHIP_MSG = {
	"",
	"需使用零件碎片进行合成",
	"零件碎片不足, 需要5个"
}
L_GIFT_MSG = {
	Add_Favor = "增加%d点好感度",
	Cloth_Effect = "服装赠送效果：(快去学员界面换装吧!)",
	Gift_Effect = "礼物赠送效果："
}
L_FOOD_ATTR = {
	taste = "味",
	sweet = "甜",
	hot = "辣",
	salty = "咸",
	color = "色",
	smell = "香",
	sour = "酸"
}
L_FOOD_TOTAL_SCORE = "总分: "
L_SELECT_EQUIP_MSG = {
	Non_Items = "道具已经全部选完了！",
	Choose_Cancel = "取消",
	Choose_More = "多选",
	Unselected_Furniture = "未选中任何家具QAQ",
	Unselected_Resource = "未选中任何材料QAQ",
	Weapon_Unlock = "魂武已解除锁定模式",
	Title = "描述",
	Unselected_Weapon = "未选中任何魂武QAQ",
	Choose_Confirm = "操作确认",
	Weapon_Lock = "魂武已锁定！",
	Unselected_Parts = "未选中任何物品QAQ",
	Component = {
		Decompose_Fail = "零件分解失败！",
		UnLock = "零件已解除锁定模式",
		Using = "零件已装备！",
		Unselected = "未选择分解零件！",
		Lock = "零件已锁定！"
	},
	Items_Include_Orange_Or_RedQuality = {
		[6] = "所选道具包含红色品质道具，是否执行该操作？",
		[5] = "所选道具包含橙色品质道具，是否执行该操作？"
	}
}
L_BARRAGE_MSG = {
	Input = "输入弹幕-.-",
	Warning = {
		Out_Length = "弹幕不可输入超过20字",
		Senstive_Word = "您的弹幕有敏感词哟~~~"
	}
}
L_FIGHT_CAPACITY_MSG = {
	Required_Capacity_2 = "(需求战力： ",
	Recommend_Capacity = "推荐战力：",
	total = "总战力:",
	title = "战力不足",
	Common = "战力:",
	button = "继续出战",
	Own_Capacity = "我方战力：",
	Required_Capacity = "需求战力：",
	des = "阵容未达到地图推荐标准,是否继续出战"
}
L_ATTR_RESTRAIN_MSG = {
	title = "属性克制",
	button = "继续出战",
	des = "阵容中有多位学员属性被地图属性克制,是否继续出战"
}
L_SYSTEM_UNLOCK_WORD_SIMPLE = {
	MainLayer = L_SYSTEM_UNLOCK_WORD.MainLayer,
	HandOfMidasLayer = L_SYSTEM_UNLOCK_WORD.HandOfMidasLayer,
	SignLayer = L_SYSTEM_UNLOCK_WORD.SignLayer,
	MailLayer = L_SYSTEM_UNLOCK_WORD.MailLayer,
	RechargeLayer = L_SYSTEM_UNLOCK_WORD.RechargeLayer,
	SupermarketLayer = L_SYSTEM_UNLOCK_WORD.RechargeLayer,
	TwisteggLayer = L_SYSTEM_UNLOCK_WORD.TwisteggLayer,
	HelpfigureLayer = L_SYSTEM_UNLOCK_WORD.HelpfigureLayer,
	ChooseLayer = L_SYSTEM_UNLOCK_WORD.ChooseLayer,
	EquipLayer = L_SYSTEM_UNLOCK_WORD.EquipLayer,
	TaskLayer = L_SYSTEM_UNLOCK_WORD.TaskLayer,
	BagLayer = L_SYSTEM_UNLOCK_WORD.BagLayer,
	AdventureLayer = L_SYSTEM_UNLOCK_WORD.AdventureLayer,
	DormitoryLayer = L_SYSTEM_UNLOCK_WORD.DormitoryLayer,
	SmeltLayer = L_SYSTEM_UNLOCK_WORD.SmeltLayer,
	ArenaLayer = L_SYSTEM_UNLOCK_WORD.ArenaLayer,
	RankLayer = L_SYSTEM_UNLOCK_WORD.RankLayer,
	MarketLayer = L_SYSTEM_UNLOCK_WORD.MarketLayer
}
L_MODE_DIFFICULTY = {
	"",
	"普通",
	"困难",
	"极难"
}
L_SIGNATURE_WARNING = {
	Sign_Out_Length = "签名须在20字符以内QAQ",
	Sign_Box_Nil = "你还没有个性签名QAQ",
	Sign_Sensitive = "您的签名有敏感词哟",
	Sign_Bottom = "不超过20字符"
}
L_NICKNAME_WARNING = {
	Nickname_Long = "昵称长度必须小于七个字符或汉字",
	Nickname_Sensitive = "昵称含有敏感词哟",
	Nickname_illegal = "昵称不得包含特殊字符QAQ",
	Nickname_Nil = "请输入昵称",
	Nickname_Short = "昵称不能为空"
}
L_MEDAL_WARNING = {
	Set_Failed = "设置失败QAQ",
	Empty = "勋章空空,完成任务即可获得~"
}
L_CDK_WARNING = {
	Use_Failed = "兑换码不可使用"
}
L_WORD_SENSITIVE = "你输入的文字含有敏感词哟"
L_COMPOUNDLAB_INFO = {
	"开始合成",
	"芯片与电路图不符",
	"芯片与电路图量不足",
	L_GOLD .. "数量不足",
	"芯片已满级",
	"尚未拥有该物品"
}
L_QUICK_GAIN_MSG = {
	Quick_gain_Failure = "快速收获失败",
	Quick_gain_Success = "快速收获成功",
	Gain_Jingti = "收获晶体",
	Quick_gain = "快速收获",
	Popmsg_Label = {
		button = "确认",
		title = "恭喜获得"
	}
}
L_COMPOUNDLAB_LEVEL_UP = {
	Throw_Error = "labtype与server端不符",
	Lab_Level_Up = "车间升级",
	Lab_Level_Uping = "车间正在升级",
	Complete_Level_Up = "已完成升级",
	Level_Uping = "正在升级",
	Warning = {
		nil,
		"有其他车间正在升级~~~",
		"该车间未解锁~~~",
		nil,
		"升级物品不足",
		"该车间已满级",
		"能量车间等级不足~~~~"
	},
	Attr = {
		[2] = "合成速度",
		[1] = "车间等级"
	}
}
L_COMPONENT_TEXT = {
	Suit_Effect = "【套装效果】",
	No_equip = "未装备零件",
	No_Suit_Effect = "未组成零件套装",
	Component = "零件",
	Component_Score = "潜力：",
	UpInfo = {
		value = "当前",
		name = {
			[1] = "零件等级",
			[2] = "任意副属性加成"
		}
	},
	prefix_str = {
		"主属性：",
		"副属性：",
		"主:",
		"副:",
		"生效主属性：",
		"生效副属性：",
		"主属性",
		"副属性"
	},
	Warning = {
		nil,
		"零件已经强化至满级!",
		"魂能结晶不足，请补充！",
		L_GOLD_LACK .. "，请补充！",
		"需要魂器娘达到XXX级解锁"
	},
	Button_Label = {
		"装 备",
		"已装备",
		"强 化",
		"已满级",
		"锁定",
		"解锁",
		"替 换",
		"校 准",
		"已校准",
		"构 筑"
	},
	Sort_Order = {
		"品质升序",
		"品质降序",
		"等级升序",
		"等级降序"
	}
}
L_COMPONENT_AUTO_EQUIP = "已自动装备"
L_COMPONENT_CANNOT_EQUIP = "巡逻中的学员使用中,无法装备"
L_COMPONENT_CANNOT_Unload = "学员巡逻中,无法卸下零件"
L_COMPONENT_CHANGE = {
	title = "零件装备",
	button = "确 定",
	des = "确定要更换已经被装备的零件吗"
}
L_COMPONENT_RANK = {
	"初级",
	"高级",
	"特级"
}
L_DIALOG_TITLE = {
	"下线通知",
	"异地登录通知",
	"账号状态异常",
	"检查网络",
	"更新通知",
	"确定退出",
	"切换账号"
}
L_DORM_UNLOCK_MATERIAL = "解锁房间需要材料"
L_DORM_UNLOCK_ROOM_WARNING = {
	nil,
	"房间已经解锁",
	"前置房间未解锁",
	"解锁材料不足"
}
L_DORM_UNLOCK_LIVING_ROOM_WARNING = {
	[2] = "房间已经解锁",
	[3] = L_GOLD_LACK
}
L_DORM_SETTLE_IN_WARNING = {
	nil,
	"房间还未解锁",
	"学员未解锁",
	"学员已经在宿舍了"
}
L_DORM_MOVE_AWAY_WARNING = {
	[2] = "房间里没人",
	[3] = "学员正忙"
}
L_DORM_LEAVE_DR_WARNING = {
	[0] = "餐厅无人~~",
	nil,
	"餐厅接了8桌了,该休息了~",
	nil,
	nil,
	"用餐学员未解锁",
	"用餐学员状态异常~"
}
L_DORM_SEND_GIFT_WARNING = {
	[4] = "今日送礼次数已达上限",
	[5] = L_DIAMOND_LACK
}
L_DORM_RENOVATION_MSG = {
	Move_Away_Tip = "手还没牵呢,就想把人家赶出去?!!",
	Buy_Dorm_Tip = "要想开后宫,先买房子,后装修~",
	No_Change = "好像没改什么~"
}
L_DORM_TOUCH_EVENT_MSG = {
	BUILDING = "建造中~~",
	EXPLORING = "外出探险执勤中~",
	PLOT = "好像有事在校园里等你~",
	NEXTLOCK = "解锁成功~~",
	TRAVELBACK = {
		labels = {
			button = "确认",
			title = "探险获得"
		}
	}
}
L_GIFT_PANEL = {
	activity = "体力",
	favor = "好感度"
}
L_MOVE_AWAY_FROM_DORM = {
	Role = "确定将%s移出宿舍?",
	Favor_rest = "还有%d好感币没有收取哦~"
}
L_DORMROOM_FAVOR = {
	title = "获取好感币",
	button = "获 取",
	des = "%s对装修还算满意,可获得%d好感币"
}
L_DORMROOM_ADD_FAVOR_FROM_POOL_WARNING = {
	[2] = "好感缓存池为空"
}
L_DORMROOM_SEND_GIFT = {
	Lack_Gift = "赠礼不足",
	Gain_Gift = "点击前往获得礼物",
	itemName = "礼物",
	Rest_Extra = "今日剩余额外次数: %d次",
	Interaciton_Used_Up = "预览互动次数已用完",
	Rest_Common = "今日剩余: %d次",
	No_Rest = "送礼次数都用完了,明日再来吧~",
	Button_Lock = "还未解锁",
	Gain_Des = "学院商城补给处购买",
	Favor_Event_End = "好感事件已触发"
}
L_DORMROOM_DEBUG_FAVOR = "debug加好感"
L_DROPCACHE_LAYER_MSG = {
	Component = {
		[0] = "装备失败",
		"零件装备成功",
		"零件装备对象出错",
		"零件装备位置出错",
		"职阶不足",
		"零件已装备",
		"零件所属学员未契约",
		"通用零件暂时无法在此界面装备"
	},
	Weapon = {
		Wear_Fail = "装备失败",
		Wear_Success = "装备成功",
		Button_Label = {
			[1] = "装 备",
			[2] = "卸 下"
		}
	}
}
L_DROP_LIST = "掉落详情"
L_DROP_DETAIL = {
	Show_Probability = "概率公示",
	Label = {
		des = "收益提升",
		title = "通关奖励"
	}
}
L_SP_GIRL_DES = "学员（特殊作战形态）"
L_DROP_PREVIEW_TEXT = {
	Suggest_str = "推荐%s科技：%d",
	Drop_List_Label = {
		FIGHTTYPE_NORMAL = {
			[1] = "领主奖励：",
			[2] = "领主掉落："
		},
		FIGHTTYPE_ADVENTURE = {
			"副本奖励：",
			"首通掉落翻倍",
			"可能掉落：",
			"副本掉落："
		}
	}
}
L_DROP_PREVIEW_CONFIRM_LABEL = {
	Sweep = "扫 荡",
	Rest_Time = "（剩余%d次）",
	Adventure = "进入探险",
	Boss = "挑战领主"
}
L_EXPLOREMAP_AREA = "区域"
L_EXPLORE_TITLE_SHOW_STR = {
	SPECIAL_EVENT = "神秘事件",
	NORMAL_DROP = "普通掉落",
	ROGUE_SP_TILE2 = "星星",
	ROGUE_SP_TILE1 = "宝箱"
}
L_EXPLORE_FINISH_ERROR = {
	nil,
	"探险数据不存在",
	"委托任务结束报错",
	"活动结束报错"
}
L_EXPLORE_EVENT_RESULT_ERROR = {
	"地图数据不存在",
	"未满足触发条件",
	nil,
	nil,
	"限时活动已经结束"
}
L_EXPLORE_BY_ACTIVITY = {
	[0] = "活动探险未开放",
	nil,
	nil,
	"活动探险id不存在",
	"该关卡只能探险一次",
	"门票不足",
	"开启时间未到",
	"该关卡每日探险次数已用尽",
	"前置关卡未通关"
}
L_EXPLOREMAP_EXIT_MSG = {
	Exit_Button_Finish = {
		title = "返航",
		button = "确认返航",
		des = "是否确认返航\n(退出后将无法再次进入)"
	},
	Exit_Button_Unfinish = {
		title = "撤退",
		button = "确认撤退",
		des = "是否中途撤退\n(中途撤退将无法保留当前进度)"
	},
	Exit_Button_Rogue = {
		title = "暂离",
		button2 = "重置位置",
		button = "确认暂离",
		des = "暂离会保存当前探险进度，重置位置将保留物品获取、怪物进度，仅重置回初始地点。"
	}
}
L_EXPLOREMAP_BOX_TITLE_CLASS = {
	SKILL_BOOK = "职业技能书箱",
	ACTIVITY_MONEY = "应援棒",
	MONEY = "探险货币",
	LAB_MATERIALS = "礼物箱",
	SPECIAL_ENEMY = "秘藏守护者",
	COMPONENT = "零件",
	ENERGY_BATTERY = "能量电池",
	CHIP = "职业模块箱",
	GOLD_BOX = "钞票箱",
	KEY = "探险磁卡",
	COMPONENT_CHIP = "零件芯片",
	WEAPON = "通用魂武箱",
	RANDOM_EVENT = "随机事件",
	ACTIVITY_ITEM = "剧情物品",
	LOCK_BOX = "泛用魂器箱"
}
L_EXPLOREMAP_BAG = {
	Empty = "空空如也~"
}
L_EXPLOREMAP_AIM = {
	TalkSp = "路径锁已打开, 继续前进",
	Title = {
		[1] = "关卡目标",
		[2] = "支线目标"
	}
}
L_EXPLOREMAP_ROOM = {
	Room_SP_Name = "9号密室",
	TalkSp = "被锁住了,得想办法过去!",
	Room_state = {
		[2] = "已被怪物封印",
		[3] = "目前无法到达"
	}
}
L_EXPLOREMAP_TRIGGER_EVENT = {
	Team_Energe_Minus = "团队能量-%d",
	Team_Energe_Plus = "团队能量+%d",
	Popmsg_Label = {
		title = "探险信息",
		button = "确认",
		des = ""
	}
}
L_EXPLORETALK_SHOWNAME = {
	Show_Name = {
		[1] = "魂器师",
		[2] = "旁白"
	}
}
L_EXPLORETALK_ME = "我"
L_EXPLORE_CONTROLLER_OPEN = "似乎有某处的机关被打开了"
L_EXPLORE_TASK = {
	Need = "任务需求",
	Comsume = "需要消耗:",
	Sure_Btn = "确认",
	Clue = "线索"
}
L_EXPLORE_POKEBALL_BUY = {
	title = "EMP不足",
	button = "购买&捕捉",
	des = "消耗" .. L_DIAMOND .. "购买1枚EMP,捕捉魂器"
}
L_EXPLORE_MSG = {
	Dead_Des = "死球啦!从来吧!",
	Title = "探险信息"
}
L_EXPLORE_NEED_KEY = "消耗物品"
L_FIGHT_CAPACITY = "战斗力"
L_FIGHT_CAPACITY_ATTR = {
	[1] = "血量:",
	[2] = "攻击:"
}
L_FIGHT_CAPACITY_CHANGE_VALUE = {
	Girls = {
		[1] = "（属性相同学员属性增加）",
		[2] = "（属性不同学员属性增加减半）"
	}
}
L_UNLOCK_AUTO_FIGHT = "通关%s解锁自动战斗"
L_FIGHT_NEXT_CHAPTER = {
	Next_Lock = "下一章未解锁",
	End = "当前章节已结束, 敬请期待"
}
L_FIGHT_STAGE = "阶段%d   伤害增幅:%s"
L_NIGHTMARE_LOCK = "极难难度尚未解锁"
L_FIGHT_RESULT_TITLE = {
	Hangup_Title = {
		"搜寻时长",
		"作战地点",
		"搜寻收益",
		"预计收益",
		"消耗材料"
	},
	Drop_Title = {
		[1] = "缓存负重: ",
		[2] = "收 取"
	},
	Offline_Title = {
		"离线时长: ",
		"作战地点: ",
		"离线收益: "
	},
	Item_Title = {
		[1] = "获得物品"
	}
}
L_FIGHTNEW_MSG = {
	Cache_Title = "缓存物品 缓存负重：",
	Warning = {
		[1] = "材料背包已满，请及时清理",
		[2] = "背包负重已到上限"
	}
}
L_FIGHT_RESULT_DROP_RARE = "当前关卡 (%s) 特异物资"
L_FIGHT_RESULT_LEVLE_DROP_DATA = {
	raredata = "特异物资",
	sciencedata = "科研材料",
	commondata = "综合",
	componentdata = "零件"
}
L_SERVANT_CHIP_MSG = {
	Chip_Need = "需要%d个碎片"
}
L_SERVANT_COMPOSE = "消耗%d个碎片合成学生证"
L_GUIDENEW_CLOSE_BTN = "点击关闭"
L_POPGUIDE_TIME_LABEL = "秒后,点击关闭~"
L_SHOW_HORCRUX_INFO = {
	skill1Des = "这个魂器很懒，什么都没学会。",
	skill1Name = "咸鱼",
	skill2Des = "这个魂器喜欢划水，不能掌握更多的技能了。",
	skill2Name = "划水"
}
L_SHOW_HORCRUX_SKILL = "魂器技能"
L_HORCRUX_LOCK = {
	Lock = "魂器锁定完毕",
	Unlock = "魂器解锁完毕"
}
L_HORCRUC_STATE = {
	"魂器已锁定",
	"魂器编队中",
	"魂器打工中"
}
L_HORCRUX_TOUCH_MSG = {
	Error = "发生未知错误。code:",
	Material_Out = "材料已经选完啦",
	Hasowner = "该魂器已经被装备啦",
	Busy = "学院CPU一次处理不了那么多啦",
	Unlock = "魂器已解除锁定模式",
	Level = {
		"魂器等级限制，请前往突破。",
		"魂器等级限制，请先升级。",
		"魂器已满级"
	}
}
L_HORCRUX_LEVEL_UP_MSG = {
	Star = "所选魂器包含%d星魂器，是否执行该操作？",
	Locked = "所选魂器包含已锁定魂器，是否执行该操作？",
	Dialog = "操作确认",
	Class = "所选魂器包含%d阶魂器，是否执行该操作？",
	Level = "所选魂器包含%d级魂器，是否执行该操作？",
	Error = "魂器合成粗错："
}
L_HORCRUX_BREAK_LIMIT = {
	Level_Max = "魂器已满破",
	Limit_Des = "班长达到:%s可突破",
	Btn_Str = "魂器突破",
	Label_Str = {
		"等级上限：",
		"攻击：",
		"血量："
	},
	Warning = {
		nil,
		"魂器等级不足",
		"已满级",
		"班长等级不足",
		"材料不足",
		L_GOLD_LACK,
		"魂器已满阶"
	},
	Aptitude_Str = {
		"当前阶级:",
		"攻击资质:",
		"血量资质:"
	}
}
L_HORCRUX_LV_UP_AUTO_SELECT = {
	"没有狗粮魂器",
	"没有符合自动选择条件的魂器。",
	"没有经验道具"
}
L_HORCRUX_LV_UP_SELECT_NIL = {
	"没有选择狗粮魂器",
	"没有选择经验道具",
	"请先突破",
	"未选中魂器娘~"
}
L_HORCRUX_CHIP_MSG = {
	Chip_Need = "需要%d个碎片"
}
L_HORCRUX_COMPOSE = "消耗%d个碎片合成魂器"
L_HORCRUX_DECOMPOSE = {
	Get = "获得",
	NOT_SUPPORTED = "无\n法\n分\n解",
	Warning = {
		[2] = "魂器战斗中",
		[3] = "魂器锁定中"
	},
	Get_Material = {
		[1] = "分解(",
		[2] = ")魂器获得以下物品"
	}
}
L_HORCRUX_ATTR_MAX = "已满阶"
L_HORCRUXSELECT_BOTTOM_LIST = {
	Btn_Str = "魂器详情",
	Unload = "卸下",
	Select = "选择"
}
L_HORCRUXSELECT_WARNING = {
	nil,
	"无效魂器",
	"魂器属性与出战学员不符",
	"魂器已经在所选阵容中",
	nil,
	"魂器已经在其他编队，挖墙脚功能还没做",
	"队伍巡逻中,无法变更"
}
L_HORCRUXSELECT_CHANGE = {
	Within_Team = "魂器已在阵容中",
	Within_Other_Team_Default = "您当前选择的魂器已在队伍中\n是否进行更换",
	Within_Other_Team = "您当前选择的魂器已在队伍%d\n是否进行更换",
	Horcrux_Patrol = {
		[1] = "      您当前选择的魂器正在驻守挂机中\n是否完成驻守并进行更换"
	},
	Girls_Patrol = "      您当前选择的学员正在驻守挂机中\n是否消耗%d" .. L_DIAMOND .. "快速完成或者中断驻守, 并进行更换"
}
L_HORCRUXSELECT_SURE_BTN = {
	{
		"出战",
		"替换",
		"卸下",
		"替换"
	},
	{
		"",
		"选择",
		"当前魂器"
	},
	{
		"选择",
		"替换"
	}
}
L_HORCRUXSELECT_FIGHT_TAG = "编队中"
L_HORCRUXSELECT_WORK_TAG = "打工中"
L_HORCRUXSELECT_CUR_LABEL = "当前魂器"
L_HORCRUXSELECT_CACHED = "已占用"
L_LAB_UNLOCK_MSG = {
	LAB_TYPE_CENTER = "需要通关XXX关解锁",
	LAB_TYPE_ENERGY = "需要魂器娘达到XXX级解锁"
}
L_LAB_ROOM_KIND = {
	Produce = "加工车间",
	Research = "研发车间"
}
L_LAB_LOCK = "请解锁上一个车间"
L_LAB_UNLOCK_MATERIAL = "解锁车间需要材料"
L_LAB_GET = "可收取:"
L_LAB_MATERIAL_LACK = "材料或电力不足"
L_LAB_LEVEL = "车间等级"
L_LAB_LEVELUP = {
	Lab_Lv_Max = "该车间已满级",
	Lab_Lv_Up_Btn_Str = "车间升级",
	Lab_Lv_Up_Str = "车间正在升级",
	Level_Up_Str = "正在升级",
	Quick_Complete_Msg = {
		[0] = "快速收获失败",
		"快速完成成功",
		"labtype与server端不符",
		nil,
		"已完成升级"
	},
	Level_Up_Operate_Warning = {
		nil,
		"有其他车间正在升级~~~",
		"打造车间未解锁~~~",
		nil,
		"升级物品不足",
		"打造车间已满级",
		"能量车间等级不足~~~~"
	},
	Up_Info_Name = {
		[1] = "车间等级",
		[2] = "可打造零件品质"
	}
}
L_LABLINE_CHANGE_NUM = {
	More = "数量到达上限",
	Less = "数量不能更少了",
	Unselect = "未选择生产项目"
}
L_LABLINE_PRODUCE = {
	Collect_Nil = "没有可以收取的物品",
	Producing = "车间正在生产中",
	No_Working = "没有加工项目"
}
L_LABLINE_QUICK_FINISH = {
	Limit = "已达到加速上限",
	Success = "加速成功",
	Btn_Str = {
		[1] = "获  取",
		[2] = "加  速"
	}
}
L_LABRECIPE_DIFF_MODE = {
	"",
	"(普通)",
	"(困难)"
}
L_LAB_RESEARCH_WARNING = {
	[0] = "没有这个科研项目",
	nil,
	"科研项目已关闭",
	"武器数量不足",
	"武器等级不符合条件",
	"所需物品不足"
}
L_LAB_RECIPE_WARNING = {
	nil,
	"数量超出限制",
	"空id",
	"材料不足"
}
L_LAB_STOP_RECIPE = {
	[2] = "车间未在生产",
	[3] = "科技点不足"
}
L_LAB_COMPLETE_RECIPE = {
	[0] = "非法车间id",
	nil,
	"生产未完成",
	"没有可以收取的物品"
}
L_LAB_UNLOCK_NEW_RECIPE_SLOT = {
	[2] = "车间已经达到上限",
	[4] = "材料或电力不足",
	[3] = L_DIAMOND_LACK,
	[5] = L_GOLD_LACK
}
L_MAP_CITY_CHAPTERS = {
	Forbid = "通关前置关卡可解锁",
	Can_Unlock = "可解锁",
	Unlock_Day = "通关上一难度后，关卡将于%s月%s日解锁",
	Locking = "通关前置难度可解锁"
}
L_MAP_SP_CHAPTER = "代号:7"
L_LEVEL_RESULT_TITLE_LABELS = {
	FIGHT_EXPLORE_FAIL = "挑战失败",
	FIGHT_ADVENTURE_SUCCESS = "恭喜获得",
	FIGHT_EXPLORE_SUCCESS = "恭喜获得",
	FIGHT_AUTOCHESS_SUCCESS = "挑战成功",
	FIGHT_NORMAL_SUCCESS = "恭喜获得",
	FIGHT_ARENA_SUCCESS = "挑战成功",
	FIGHT_ARENA_FAIL = "挑战失败",
	FIGHT_ADVENTURE_FAIL = "副本失败",
	FIGHT_NORMAL_FAIL = "战斗失败"
}
L_LEVEL_RESULT_FIGHT_RESULT_WORDS = {
	FIGHT_ARENA_FAIL = "竞技场遗憾挑战失败~",
	FIGHT_ADVENTURE_FAIL = "副本遗憾失败~",
	FIGHT_EXPLORE_SUCCESS = "探险挑战成功~",
	FIGHT_AUTOCHSEE_FAIL = "自走棋挑战失败~",
	FIGHT_NORMAL_SUCCESS = "主线战斗胜利~~",
	FIGHT_EXPLORE_FAIL = "探险挑战失败~",
	FIGHT_ADVENTURE_SUCCESS = "副本挑战成功~~",
	FIGHT_NORMAL_FAIL = "呃,主线战斗失败了~"
}
L_MAIL_DEFAULT_TITLE = "致班长的一封信"
L_MAIL_DEFAULT_SENDER_NAME = "魂器学院校委会"
L_MAIL_DEFAULT_INFO = "你敢信，邮件内容忘写啦0.0"
L_MAIL_SENDER = "发件人:"
L_MAIL_EMPTY = "无可领取邮件"
L_MAIL_HAVEGOT = "邮件已领取"
L_MAIL_NIL = "邮件不存在"
L_MAIL_NO_AWARD = "无奖励邮件"
L_MARKET_MSG = {
	Own_Lack = "拥有数量不足",
	LEVEL_BUZU = "科技等级不足",
	END = "已下架",
	Nothing_To_Sell = "没东西能卖",
	Discount_Rest = "打折",
	Item_Lack = "物品不足",
	Surplus_Rest = "距下架",
	Sold_Out = "已售空QAQ",
	Rest_Time = "商品剩余时间：",
	Gift_Bag_Lack = "礼包数量不足！",
	Goods_Sended = "商品已发放"
}
L_MARKET_REFRESH = {
	Out_Of_Times = "今日刷新次数已用完",
	Auto_Refresh = "到点自动刷新",
	Rest_Time = "商品剩余时间：",
	Success = "刷新成功!!"
}
L_MARKET_REFRESH_WARNING = {
	[3] = "刷新次数用尽",
	[2] = L_DIAMOND_LACK
}
L_MARKET_BUY_WARNING = {
	nil,
	"商品已刷新",
	"购买次数不足",
	"货币不足",
	"优惠券无法使用",
	"优惠券不足",
	"商品已下架",
	"优惠券无法使用",
	"优惠券使用时间已过",
	"拥有本格皮肤后才能购买异格哦~"
}
L_MARKET_CURRENCY_LACK = {
	SMELT = "熔炼点不足",
	HORNOR = "荣誉点不足",
	EXPLORECOIN = "探险币不足"
}
L_MARKET_REFRESH_TIME = {
	Next_Time = "下次刷新时间",
	Time_Label_Day = "每天",
	Day = "号",
	No_Refresh = "不会自动刷新",
	Time_Label_Month = "每月",
	Refresh = "刷新",
	Time_Label_Week = "每周"
}
L_CV_UNSURE = "未公布"
L_MARKET_GOODS_LACK = "数量不足"
L_MARKET_CONFIRM_DIALOG = {
	title = "页面更新",
	des = "当前页面已经更新，请点击确认后再次操作"
}
L_POPLAYER_SHOP_LABELS = {
	SHOP_CURRENCY_GOLD = {
		title = "前往挖矿",
		button = "确认前往",
		des = "获取更多" .. L_GOLD
	},
	SHOP_CURRENCY_HORNOR = {
		title = "前往竞技场",
		button = "确认前往",
		des = "获取更多荣誉点"
	},
	SHOP_CURRENCY_EXPLORECOIN = {
		title = "前往探险",
		button = "确认前往",
		des = "获取更多探险币"
	},
	SHOP_CURRENCY_DIAMOND = {
		des = L_DIAMOND_LACK .. "，请前往氪金(*^▽^*)"
	}
}
L_MIDAS_UNLOCK = "通关第%s关后开启挖矿系统！"
L_MIDAS_BTN_LABEL = {
	title = "购买挖矿券",
	button = "购买&挖矿",
	des = "挖矿券不足,消耗%d" .. L_DIAMOND .. "购买%d张%s"
}
L_MIDAS_RANGEBAR = {
	Max_Count = "最大",
	Limit_Up = "距挖矿效率上限突破",
	Efficiency_Up = "距下次挖矿效率提升",
	Max_Title = "当前已达到最大倍率~"
}
L_MIDAS_TIPS = {
	No_Times = "今日挖矿次数已用完",
	Need_Vip = "必须有VIP才能继续",
	Ticket = "消耗挖矿券获得大量" .. L_GOLD,
	Diamond = "消耗" .. L_DIAMOND .. "获得大量" .. L_GOLD
}
L_MIDAS_TIMES = "次"
L_PUBLISH_NOTICE_TYPE = {
	"公告置顶",
	"公告",
	"活动置顶",
	"活动"
}
L_PUBLISH_NOTICE_NIL = "获取公告信息失败"
L_OFFLINE_EARNING = {
	Get_Tech = "获得科技点",
	Out_Of_Times = "超过%dH收益已满",
	Offline_Time = "离线时间",
	Title = "魂器学院",
	Get_Gold = "获得" .. L_GOLD
}
L_PATROL_LIST_LOCK = "奥杜因1-5解锁"
L_PATROL_QUICK_MSG = {
	title = "快速完成驻守",
	button = "快速完成",
	des = "是否使用%d" .. L_DIAMOND .. "快速完成本次驻守"
}
L_PATROL_GAIN_EVENT = {
	button = "确认",
	title = "特殊事件"
}
L_PATROL_CHAPTER_LEFT = "剩余次数:%d次"
L_PATROL_CHAPTER_NUM = "第%d章"
L_PATROL_RESULT = {
	Title_1 = "驻守时长：",
	Gain_Nil = "时间未到,没有获得物品",
	Title_2 = "作战地点："
}
L_PATROL_BTN = {
	{
		cancel = "一键上阵",
		reset = "撤回小队",
		quick = "前往驻守"
	},
	[3] = {
		cancel = "撤回小队",
		quick = "快速完成"
	}
}
L_PATROL_ONEKEY = {
	"一键领取",
	"一键加速"
}
L_PATROL_ONEKEY_ERROR = "没有已完成的驻守可供领取"
L_PHOTOFILE_HELPGIRL_DES = {
	{
		"魂器名",
		3
	},
	{
		"性格",
		1
	},
	{
		"爱好",
		4
	},
	{
		"年龄",
		2
	},
	{
		"生日",
		8
	},
	{
		"星座",
		9
	},
	{
		"身高",
		6
	},
	{
		"体重",
		7
	},
	{
		"三围",
		12
	},
	{
		"血型",
		5
	},
	{
		"喜欢色",
		11
	},
	{
		"喜欢的食物",
		10
	},
	{
		"理想",
		13
	},
	{
		"弱点",
		14
	},
	{
		"重要的人",
		15
	}
}
L_PHOTOFILE_OPERATE_FAIL = "操作失败 QAQ"
L_PHOTOFILE_FIGHT_ATTR_DATA = {
	"输出:",
	"生存:",
	"控制:",
	"灵巧:",
	"辅助:"
}
L_PHOTOFILE_HELPGIRL_FORBID_POINT = "这是禁止事项"
L_PHOTOFILE_ROLE_DES = {
	Girls = {
		{
			"全名",
			22
		},
		{
			"地区",
			2
		},
		{
			"生日",
			11
		},
		{
			"年龄",
			5
		},
		{
			"身高",
			9
		},
		{
			"血型",
			8
		},
		{
			"体重",
			10
		},
		{
			"爱好",
			7
		},
		{
			"喜欢的食物",
			13
		},
		{
			"喜欢的颜色",
			14
		}
	},
	Boss = {
		{
			"全名",
			2
		},
		{
			"地区",
			3
		},
		{
			"生日",
			8
		},
		{
			"年龄",
			5
		},
		{
			"身高",
			7
		},
		{
			"战斗形态",
			6
		}
	},
	NPC = {
		{
			"全名",
			1
		},
		{
			"地区",
			2
		},
		{
			"生日",
			9
		},
		{
			"年龄",
			4
		},
		{
			"身高",
			7
		},
		{
			"血型",
			6
		},
		{
			"体重",
			8
		},
		{
			"爱好",
			5
		},
		{
			"喜欢的食物",
			10
		},
		{
			"喜欢的颜色",
			11
		}
	},
	Enemy = {
		{
			"全名",
			2
		},
		{
			"地区",
			4
		},
		{
			"生日",
			3
		},
		{
			"年龄",
			5
		},
		{
			"身高",
			7
		},
		{
			"血型",
			8
		},
		{
			"体重",
			9
		},
		{
			"爱好",
			10
		},
		{
			"喜欢的食物",
			11
		},
		{
			"喜欢的颜色",
			12
		}
	},
	NIGHTMARE = {
		{
			"全名",
			2
		},
		{
			"地区",
			3
		},
		{
			"生日",
			8
		},
		{
			"年龄",
			5
		},
		{
			"身高",
			7
		},
		{
			"战斗形态",
			6
		}
	}
}
L_PHOTOFILE_DATA_BTN = {
	{
		"学 籍",
		"技 能",
		"武 器",
		"深层档案"
	},
	{
		"资 料",
		"技 能"
	}
}
L_PHOTOFILE_WEAPON_ATTR = {
	Sub = "副属性(满)",
	Main = "主属性(满)"
}
L_PHOTOFILE_LEFT_BTN_TEXT = {
	"魂武图鉴",
	"食物图鉴",
	"勋章图鉴",
	"零件图鉴"
}
L_PHOTO_SELECT_BUTTON_MODE = {
	[1] = "查看解锁",
	[2] = "查看全部"
}
L_PHOTO_OC_UNLOCK = "角色超频共振后解锁"
L_PHOTO_DEEP_FILE_NAME = {
	"能力评价",
	"客观履历",
	"附录",
	"深层档案I",
	"深层档案II",
	"深层档案III",
	"深层档案IV"
}
L_SCHOOL_FILE_LIST_NAME = {
	{
		"电磁",
		"热能",
		"量子",
		"光能",
		"暗物质",
		"虚数",
		"反物质",
		"异构",
		"正能量",
		"联动",
		"拟态"
	},
	{
		"原型姬",
		"家电",
		"上古神器",
		"装甲爆破",
		"蜘蛛重炮",
		"基金会",
		"科学家",
		"矩阵",
		"天眼",
		"蜂巢",
		"龙族",
		"异界",
		"庆典",
		"兽魂",
		"美食",
		"魔眼",
		"龙舟",
		"海洋",
		"周年庆",
		"umr",
		"万圣节",
		"装甲",
		"圣诞",
		"生肖",
		"子丑寅卯",
		"辰巳午未",
		"申酉戌亥",
		"拟态",
		"战争"
	},
	{
		"魂器学院",
		"Xmas",
		"军方",
		"基金会",
		"暗影",
		"矩阵ai",
		"天眼ai",
		"蜂巢ai",
		"装甲ai",
		"护卫ai",
		"战争ai",
		"阿瓦隆ai",
		"深海ai",
		"未来机械",
		"庆典",
		"梦魇",
		"人面",
		"生肖",
		"umr",
		"军方ai",
		"基金会ai",
		"爆破ai",
		"猎手",
		"刺杀者",
		"机兵",
		"守卫者",
		"矿场",
		"仿生"
	},
	{
		"电磁",
		"热能",
		"量子",
		"光能",
		"暗物质",
		"虚数",
		"反物质",
		"异构",
		"正能量",
		"联动",
		"拟态"
	}
}
L_SCHOOL_CINEMA_TIPS = {
	DREAM_SCHOOL = "是否前往梦境学区",
	MODE_LEVEL_LOCK = "关卡未解锁，是否前往战斗",
	DORMITORY = "学员好感等级不足，是否前往宿舍送礼",
	SERVANT_UNHAVE = "学员未拥有，是否前往扩招",
	DORMITORY1 = "是否前往宿舍"
}
L_SCULTURE_TYPE_LIST_NAME = {
	"学员",
	"势力",
	"梦境",
	"超频",
	"生日",
	"誓约",
	"情人节",
	"圣诞节",
	"万圣节",
	"愚人节",
	"元宵节",
	"春节",
	"元旦",
	"盛夏",
	"魂器",
	"Ai",
	"其他"
}
L_BARRAGE_TYPE_LIST_NAME = {
	"类别1",
	"类别2",
	"类别3",
	"类别4",
	"类别5",
	"类别6",
	"类别7"
}
L_PHOTOMEMERY_LEFT_BTN_TEXT = {
	"主线剧情",
	"支线剧情",
	"事件剧情"
}
L_PV_WARNING = {
	Platform_Win32 = "Win32不支持播放视频"
}
L_PLOT_MAIN = "主"
L_PLOT_BRANCH = "支"
L_PLOT_EVENT_FINISH = "任务已完成"
L_RECHARGE_DATA_EXTRA = "额外赠送"
L_RECHARGE_DATA_MONTHLY = {
	des3 = "天",
	des1 = "剩余"
}
L_RECHARGE_DATA_CARD = {
	des3 = "天",
	des1 = "剩余",
	limit = "限购一次"
}
L_RECHARGE_MONTH_CARD_ADD = "月卡已增加天数"
L_TEAM_TIPS = {
	Team = "队伍",
	Lock = "解锁需通关",
	TIPS_DES = "提示:长按立绘进入角色详情",
	Expansion_Labels = {
		title = "扩充阵容",
		button = "扩充阵容",
		des = "消费100" .. L_DIAMOND .. "扩充阵容"
	}
}
L_TEAM_Array_WARNING = {
	Team_Capcity_Lack = "阵容战斗力不足",
	Team_HangUp_Max = "挂机阵容已达上限",
	CONDITION_ERROR = "不满足驻守条件",
	Team_Empty = "阵容不能为空哦~",
	Team_Add = {
		[2] = "阵容数已达上限",
		[3] = L_DIAMOND_LACK
	},
	Type_Adventure = {
		[0] = "阵容id为空",
		"战斗阵容不能为空"
	},
	Type_Explore = {
		[0] = "阵容id为空",
		"探险阵容更不能为空",
		"当前阵容正在驻守"
	},
	Type_HangUp = {
		[2] = "先遣阵容不能为空",
		[3] = "阵容id为空",
		[0] = {
			title = "撤回小队",
			button = "撤回小队",
			des = "是否中途撤回小队。\n（撤回小队将无法获取本次驻守收益，次数返还）"
		}
	},
	Type_SwitchMode = {
		[2] = "挂机阵容不能为空",
		[3] = "阵容id为空"
	},
	Type_Arena = {
		[0] = "阵容id为空",
		"出战阵容不能为空",
		"队伍巡逻中"
	},
	Type_ScoreArena = {
		[0] = "阵容id为空",
		"出战阵容不能为空",
		"队伍巡逻中"
	},
	Type_Patrol = {
		[0] = "阵容id为空",
		"巡逻阵容不能为空",
		"此阵容正在主线挂机",
		"此阵容正在巡逻",
		"此阵容战斗力不足",
		"驻守阵容已达上限"
	}
}
L_Change_ARRAY_WARNING = {
	Unlock = "该栏位尚未解锁",
	Role_Nil = "请先配置出战学员",
	Forbid_Change_Role = "驻守状态不能更换学员",
	Forbid_Change_Horcrux = "驻守状态不能更换魂器"
}
L_TEAM = "编队"
L_TEAM_STATUS = {
	Free = "(当前队伍状态:空闲中)",
	Sent = "(当前队伍状态:前线先遣中)",
	HangUp = "(当前队伍状态:挂机中)"
}
L_TEAM_ATTR = {
	Attack = "攻击:+",
	Blood = "血量:+"
}
L_SPECIAL_TEAM_TIP = {
	Team = "α别动队"
}
L_SPECIAL_TEAM_WARNING = {
	Team_Nil = "探险阵容更不能为空",
	Lock_Parts = "无法更换芯片",
	Forbid_Change_Horcrux = "指定魂器不能更换",
	Lock_Weapon = "无法更换魂武",
	Pos_Lock_Girls = "该地物资无法补给更多的学员",
	Forbid_Change_Role = "指定学员不能更换",
	Assist_Girl_Nil = "请先配置出战学员",
	Test_Fight_UN_CHOOSE = "选择相应的学员后,会安排适合的魂器",
	Pos_Lock_Horcrux = "该地物资无法补给更多的魂器",
	Pos_Lock_Horcrux_Hp_Inherit = "出战魂器已锁定"
}
L_SCHOOL_AREA_LOCK = {
	btn_deanOffice = "通关%s解锁教务处",
	btn_laboratoryRoom = "通关%s解锁实验室",
	btn_study = "通关%s解锁研修室",
	btn_trainRoomTips = "通关%s解锁训练室",
	btn_afkLevel = "通关%s解锁协调台",
	btn_labRoomTips = "通关%s解锁加工厂"
}
L_SCHOOL_CINEMA_TYPE = {
	photoData = "主线剧情",
	postcardData = "事件剧情",
	explorePhotoData = "探险剧情"
}
L_SCHOOL_CINEMA_STRING = "第   %d   幕"
L_SCHOOL_CINEMA_DEFAULT_NAME = "霸王行动"
L_SCHOOL_ARCHIVES_NAME_TABLE = {
	cinema = "放映厅",
	bond = "图鉴室",
	fashionshow = "时装间",
	file = "档案室"
}
L_SCHOOL_FILE_NAME_TABLE = {
	ai = "AI",
	army = "军方",
	foundation = "基金会",
	killer = "暗影",
	college = "学院"
}
L_SCHOOL_SWIM_UNLOCK_SLOT = {
	Success = "解锁成功",
	Error = "错误代码：",
	Title = "解锁赛道",
	Des = {
		[2] = "花费200" .. L_DIAMOND .. "解锁一条赛道(%d/3)",
		[3] = "花费400" .. L_DIAMOND .. "解锁一条赛道(%d/3)"
	}
}
L_SCHOOL_SWIM_TOUCH_EVENT = {
	Zero_Unlock = "只有三个泳池",
	Unlock = {
		[1] = "游泳馆通关",
		[2] = "解锁"
	}
}
L_SCHOOL_SWIM_TRAIN = {
	Finish = "完成",
	Waiting = "等待指令",
	Cancel = "学员已经上岸了，别点了",
	Quick_Finish = "加速完成"
}
L_SCHOOL_SWIM_BEGIN_TRAIN = {
	Gold_Lack = "钞票不足"
}
L_SCHOOL_SWIM_SHOW_SKIL_UP = {
	Textlist = {
		"精",
		"神",
		"力",
		"："
	}
}
L_SCHOOL_SWIM_POP_STRENG_MSG = {
	bntstr = "游泳训练",
	bnt2str = "离开游泳馆",
	labels = {
		{
			name = "精神力："
		}
	}
}
L_SCHOOL_SWIM_FITNESS_LV = {
	Title = "游泳锻炼",
	Des_Max = "精神力已到达最大值：",
	Des_No_Max = {
		[1] = "精神力提升：",
		[2] = "提升至"
	}
}
L_SCHOOL_TRAINROOM_HIDE = "当前房间全部为空！"
L_SCHOOL_TRAINROOM_UNLOCK_SLOT = {
	Error = "错误代码：",
	Success = "解锁成功~~"
}
L_SCHOOL_TRAINROOM_RETURN_MATERIAL = {
	Failure = "返回套餐消耗失败！",
	Success = "当前角色已满级，返回套餐消耗！"
}
L_SCHOOL_TRAINROOM_QUICK_FINISH = {
	Failure = "加速失败",
	Success = "加速成功"
}
L_SCHOOL_TRAINROOM_START = "训练开始！"
L_SCHOOL_TRAINROOM_QUICK_LABEL = {
	title = "加速完成训练",
	button = "加速完成",
	des = "是否使用%d" .. L_GOLD .. "加速完成本次训练"
}
L_SCHOOL_TRAINROOM_REMOVE = "确定将%s移出训练室?"
L_SCORE_AREAN_GROUT_NAME = {
	"萌新组",
	"菜鸟组",
	"精英组",
	"学霸组",
	"肝帝组"
}
L_SCORE_AREAN_VICTOR = "今日胜场"
L_SCORE_AREAN_NO_RANK = "未上榜"
L_SCORE_AREAN_REFRESH_TIMES = {
	Out_Of_Times = "刷新次数已用光~",
	Sure_Refresh = "是否确认使用刷新次数来刷新匹配阵容?"
}
L_SCORE_AREAN_ENEMY = {
	Awardsvalue = "战胜积分：",
	Fightpoint = "战力："
}
L_SCORE_AREAN_AWARD_DATA = {
	"奖励:",
	"魂晶 + ",
	"荣誉点"
}
L_SCORE_AREAN_SHOW_ADDUP_AWARD = "累计获胜%d场您将获得："
L_PVP_PREVIEW_WIDGET = {
	Confirm_btn = "确认挑战",
	Title = "挑战玩家"
}
L_PVP_RESULT_TIME = "战斗时长 "
L_PVP_RESULT_RANK = "排名:"
L_PVP_RESULT_NO_RANK = "未上榜"
L_PVP_RESULT_AWARD = {
	Honor = "荣誉点:+",
	Score = "积分:+"
}
L_SETTING_CUSTOMER_SERVE = "亲爱的班长大人~\n\n欢迎入学魂器学院,我是泥萌的院长傲娇姬 （才不是yuanjiao姬）~w~\n\n在游戏过程中,班长如果有遇到任何问题,或是有好的建议,都可以找官方管理员反馈,我们都会很认真地考虑哒！而且还可以跟喵酱和学长学姐们玩耍哦~w~\n\n总之,欢迎反馈,欢迎打call！\n\n在我们共同的努力下,魂器学院一定会成为大家最有爱的二次元学院！爱泥萌！比心！(づ￣3￣)づ╭@～"
L_SETTING_OTHER_FUNCTION = {
	"BUG反馈",
	"问卷调查",
	"请输入兑换码"
}
L_SETTING_CDK_WARNING = {
	"兑换码不能为空QAQ",
	"兑换码已被使用",
	"兑换码无效",
	"兑换码使用失败"
}
L_SHARE_MSG = {
	"分享成功",
	"分享失败",
	"取消操作",
	"网络连接失败"
}
L_SHARE_INFO = {
	Text = "Friends 快来一起 Play♂Play",
	Site = "魂器学院 - 护肝养肾的放置类游戏~",
	Comment = "无",
	Title = "魂器学院 - 护肝养肾的放置类游戏~"
}
L_SHOWGIRL_SKIN_LACK = "该角色暂无更多立绘"
L_SHOWGIRL_CANT_CHANGE = "看板娘相同无法变更"
L_SHOWGIRL_BOTTOM_LIST = {
	[1] = "更换看板娘",
	[2] = "获取看板娘"
}
L_SHOWGIRL_SWITCH_WARNING = {
	[0] = "因为不可抗力失败了QAQ",
	nil,
	"该角色未解锁QAQ",
	"该角色魂武未解锁QAQ"
}
L_SIGN_FORBID = "不可签到"
L_SIGN_AWARD_DETAIL = "奖励详情"
L_SIGN_NEXT_TIME = "下次签到倒计时"
L_SIGN_TODAY_END = "今日签到奖励已领完"
L_SIGN_TOTAL_END = "已获取全部累计签到奖励"
L_SIGN_REST = "还差%d次获得 "
L_SIGN_TOTAL_REST = "次可获得奖励"
L_SIGN_DAY_BY_DAY = "班长要一天一天来凹~"
L_SIGN_WARNING = {
	[2] = "今日签到次数已用完",
	[3] = "签到时间未到"
}
L_SIGN_ACCUMULATE_DATE = "累计%d日"
L_SIGN_TOTAL_DATE = "累计签到%d日"
L_IS_MEND_SIGN = "是否进行补签？"
L_IS_MEND_SIGN2 = "是否使用补签券补签？"
L_IS_MEND_SIGN3 = "年卡用户每月最后一天可以免费补签！"
L_MEND_SIGN_BUTTON = "补签"
L_SIGNED_YET = "已签到"
L_MEND_SIGNED_YET = "已补签"
L_ACCUMU_SIGN_UNREADY = "签到天数未达成"
L_ACCUMU_AWARD_YET = "累计签到奖励已领取"
L_SIGN_ILLEGAL = "非法请求！"
L_SMELT = "熔炼"
L_SMELT_NO_OPEN = "抱歉,尚未开启"
L_SMELT_RUN_MSG = {
	[0] = "熔炼失败~~~",
	nil,
	"需要至少一个进行熔炼！！！"
}
L_SMELT_SHOW_RESULT = {
	Return = "返还",
	Num = " 熔炼点+"
}
L_SMELT_REFRESH_TIME_MAX = "今日刷新次数已用完，请明日再来!"
L_BAG_MAX = "背包空间不足"
L_SOULS_ATTR_PANEL_STR = {
	"攻击",
	"血量",
	"攻速",
	"移速",
	"射程",
	"防御",
	"击退",
	"击退减免",
	"暴击",
	"闪避",
	"伤害加深",
	"伤害抵抗",
	"每秒恢复"
}
L_SOULS_LEFTUP_ATTR_PANEL_STR = {
	"战力",
	"攻击",
	"血量",
	"攻速",
	"射程"
}
L_SOULS_ATTR_STR = {
	"攻击",
	"血量",
	"奥义"
}
L_SOULS_J = {
	"高级部件模块",
	"主属：随机"
}
L_SOULS_CENTRE_LV = "核心等级."
L_SOULS_DOWN_PANEL = {
	Button_Label = {
		"学员特色",
		"推荐阵容",
		"推荐装备"
	}
}
L_SOULS_CONFIRM_DIALOG = {
	"操作确认",
	"降低战力会导致驻守小队提前归来，是否继续? ",
	nil,
	"花费%d礼品卡购买"
}
L_SOULS_COMPONENT_TOUCH_WARNING = {
	"学员核心等级不足",
	"当前职介不足~~~",
	"操作确认",
	"降低战力会导致驻守小队提前归来，是否继续? ",
	"芯片与角色职业不符！"
}
L_SOULS_BREAK_LIMIT = {
	Level_Max = "学员已满阶",
	Advance = "学员进阶",
	Science = "总共振点",
	Now_Level = "当前阶级",
	Point = "科技值",
	NeedContent = "%s振后获取",
	Aptitude = {
		[1] = "血量资质",
		[2] = "攻击资质"
	},
	Warning = {
		nil,
		"角色无效",
		"角色已满",
		"角色卡数量不足"
	}
}
L_OC_LIMIT = {
	nil,
	"角色无效",
	"超频未开启",
	"材料数量不足",
	"未达到超频条件"
}
L_SOULS_GRADE = "%d档增幅"
L_SOULS_OVERCLOCK = "超频"
L_SOULS_BREAK_TIMES = "%d阶"
L_SOULS_BREAKOUT_MAX = "学员突破次数已达上限"
L_BREAKOUT_HANDEL = {
	advance_success = "进修成功",
	Success = "突破成功",
	Name = {
		"需求等级",
		"科技：",
		"攻击：",
		"血量：",
		"已满破"
	},
	Button_Msg = {
		title = "前往进阶",
		button = "确认前往",
		des = "提升玩家阶级"
	}
}
L_GIRL_SELECT_SWITCH = "更 换"
L_GIRL_SELECT_SECRET = "秘密orz"
L_GIRL_SELECT_BTN = {
	"学员替换",
	"黯然下场",
	"闪亮登场",
	"学员详情"
}
L_GIRL_SELECT_WORD = {
	SELECT_GIRL_DORMITORY = "闪亮登场",
	SELECT_GIRL_SWIM = "放入泳池",
	SELECT_GIRL_TRAIN = "派出训练",
	SELECT_GIRL_QUICKFIGHT = "学员替换",
	SELECT_GIRL_HOME = "看板娘预览",
	SELECT_GIRL_DATABASE = "选择学员"
}
L_GIRL_SELECT_GIRL_STATE = {
	Patrol_Only = "该学员为挂机编队中唯一学员",
	In_Team = "处于编队%d中，是否进行更换？",
	Patroling = "您当前选择的学员正在驻守挂机中。",
	Patrol_Finish = "您当前选择的学员已驻守完毕。"
}
L_GIRL_SELECT_CHANGE_WARNING = {
	TvtDef_Waring = "进攻队伍%d号不能为空",
	Define_Waring = "防守队伍不能为空",
	Train_Warning = "技能等级已MAX",
	Swing_Waring = "精神力上限已MAX",
	TvtAtk_Waring = "进攻队伍%d号不能为空",
	Patrol_Finish = "    您当前选择的魂姬正在驻守挂机中是否完成驻守并进行更换",
	Attack_Waring = "进攻队伍不能为空",
	Clear_Waring = {
		"当前阵容为先遣阵容, 不能清空",
		"当前阵容为竞技场防守阵容, 不能清空",
		"队伍巡逻中,无法变更",
		"当前阵容为挂机阵容, 不能清空",
		"当前角色已在阵容中, 不能更换"
	},
	Change_Waring = {
		[2] = "您当前选择的魂姬已在队伍",
		[3] = "是否进行更换"
	},
	Patrol_Unfinish = "    您当前选择的魂姬正在驻守挂机中是否消耗%d" .. L_DIAMOND .. "快速完成或者中断驻守, 并进行更换",
	Explore_Waring = {
		Level_Lack = "等级不足",
		Spirit = "精神力不足",
		Exploring = "正在探险"
	}
}
L_GIRL_SELECT_CELL = {
	Name_Label = "依文洁琳",
	arenaDefence = "防守编队",
	arenaAttack = "进攻编队",
	fightlabel = "编队二",
	skillLevelLabel = "未强化",
	favoriteLabel = "心Lv.2",
	Update = {
		"技能LV:",
		"编队",
		"心Lv.",
		"精神力LV:"
	}
}
L_GIRL_INFO_TABLE = {
	"职阶：",
	"等级：",
	"战力：",
	"攻击：",
	"血量："
}
L_SOUL_STRENGTH_PANEL_BTN_TITLE = {
	nil,
	nil,
	"已满级",
	"不足",
	"突破上限"
}
L_SOUL_STRENGTH_LEVEL_LACK = "等级不足"
L_SOUL_STRENGTH_TECH_LACK = "科技点不足"
L_SOUL_STRENGTH_HOLIDAY_FORBID = "等级大于0时才可以重置等级"
L_TWISTEGG_LOADING = {
	{
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	},
	{
		"欧",
		"气",
		"加",
		"成",
		"："
	}
}
L_NO_MEDAL = "尚未佩戴任何勋章"
L_PUBLICITY_TABLE = {
	"MR学员",
	"UR学员",
	"SR学员",
	"SP学员",
	"MR魂器",
	"UR魂器",
	"SR魂器",
	"R魂器",
	"SP魂器"
}
L_PUBLICITY_PROBABILITY = {
	Total = "综合概率",
	Detail = "详细概率"
}
L_WEAPON_QUALITY_LIST = {
	"破损",
	"普通",
	"精良",
	"稀有",
	"史诗",
	"传说"
}
L_WEAPON_STAR = {
	Weapon_Full = "武器星级已满",
	Star_Full = "已满星"
}
L_WEAPON_LEVEL = {
	Level_Up_Fail = "升级需要对应材料哦~",
	LEVEL_MAX = "已满级",
	Weapon_Lv_Max = "武器已满级",
	Select_Lv_Max = "武器升无可升"
}
L_WEAPON_RANGE_UP = {
	Waiting_Up = "待突破",
	Up = "突破"
}
L_WEAPON_STRENGTHEN = {
	Strengthen = "强化",
	Material_Lack = "无可用升级材料~~",
	Strengthen_2 = "强  化",
	Fail = {
		nil,
		"武器需要突破",
		"材料不足",
		L_GOLD_LACK,
		"武器已满级",
		nil,
		"魂姬需要突破"
	}
}
L_WEAPON_BREAK_THROUGH_FAIL = {
	nil,
	nil,
	"材料不足",
	"已满级",
	L_GOLD_LACK,
	"角色等阶不够"
}
L_WEAPON_UPGRADED_TIP = "升星消耗同类同星级武器,或者同星级魂武核心\n分解武器概率获得魂武核心"
L_WEAPON_UPGRADE_FAIL = {
	nil,
	"升星物品不存在",
	"升星物品不匹配",
	"消耗物品有空星",
	"已满星",
	"消耗武器数量不足"
}
L_WEAPON_UPGRADE_MATERIAL_LOCK = {
	"所选魂武包含已锁定魂武",
	"所选魂武包含已升级魂武",
	"所选魂武包含已升星魂武"
}
L_WEAPON_UP_QUALITY_WARNING = {
	nil,
	nil,
	nil,
	nil,
	"材料不足",
	"魂武未满星",
	"魂武未达到要求等级",
	"魂武装备中"
}
L_WEAPON_UP_QUALITY_INFO = {
	Star = "最大星级:",
	Level = "最大等级:"
}
L_WEAPON_UPGRADE_SURE = {
	Comfirm = "，是否执行该操作？",
	Title = "操作确认"
}
L_WEAPON_SHOW_GET_WAYS = "获取途径"
L_WEAPON_ATTR_STR = L_SOULS_ATTR_STR
L_WEAPON_CHANGE_CONFIRM_DIALOG = L_SOULS_CONFIRM_DIALOG
L_WEAPON_UNLOAD_CONFIRM_DIALOG = {
	Msg = "卸下后队伍战力不足将结算驻守挂机奖励",
	Title = "操作确认"
}
L_WEAPON_NO_EQUIP = "未装备魂武"
L_WEAPON_CHANGE = {
	title = "零件魂武",
	button = "确 定",
	des = "确定要更换已经被装备的魂武吗"
}
L_WEAPON_CANNOT_Unload = "学员巡逻中,无法卸下武器"
L_WEAPON_LOCK = "武器已上锁~"
L_WEAPON_EXP_STR = "经验加成: "
L_WEAPON_UNIVERSE = "通用武器"
L_DISPLAY_DEFAULT = "显示待定"
L_ROLE_WEAPON_SUCCESS = "成功~~~"
L_ROD_INFO_POP = "使用时间：2020.11.07-2020.11.19"
L_CHANGE_FIGURE_MSG = {
	Des = "选择已签订契约的武器娘",
	Title = "更换防守阵容"
}
L_CHAT_MSG = {
	Me = "我",
	Send_Application = "申请已发送",
	Shetuan_Nil = "还未加入社团请先加入社团",
	Cannot_Send_Application = "升至7年级方可加入社团",
	Send_Nil = "发送内容不能为空",
	asname = {
		"傲娇派",
		"次元狂",
		"大天国"
	}
}
L_CHEST_LAYER = {
	Text = "战斗加速1分钟!!!"
}
L_ROLE_CONVERSATION_TYPE_DES = {
	[ROLE_CONVERSATION_TYPE.home] = "获取学员",
	[ROLE_CONVERSATION_TYPE.changeShowgilr] = "任命助理",
	[ROLE_CONVERSATION_TYPE.mainTouch] = "对话",
	[ROLE_CONVERSATION_TYPE.fight] = "编入队伍",
	[ROLE_CONVERSATION_TYPE.passlevel] = "获胜",
	[ROLE_CONVERSATION_TYPE.lose] = "失败",
	[ROLE_CONVERSATION_TYPE.dormTouch] = "宿舍对话",
	[ROLE_CONVERSATION_TYPE.favorUpgrade] = "好感升级",
	[ROLE_CONVERSATION_TYPE.gift] = "赠送礼物",
	[ROLE_CONVERSATION_TYPE.changeDress] = "换装",
	[ROLE_CONVERSATION_TYPE.angry] = "生气",
	[ROLE_CONVERSATION_TYPE.win] = "胜利",
	[ROLE_CONVERSATION_TYPE.dormDaily] = "宿舍对话",
	[ROLE_CONVERSATION_TYPE.dormFirst] = "宿舍欢迎",
	[ROLE_CONVERSATION_TYPE.xp] = "终级技能",
	[ROLE_CONVERSATION_TYPE.marry] = "誓约"
}
L_WEAPON_MAIN_ATTR = "改造属性"
L_WEAPON_MAIN_ATTR_EFFECTIVE = "生效" .. L_WEAPON_MAIN_ATTR
L_WEAPON_SUB_ATTR = "升星属性"
L_WEAPON_SUB_ATTR_EFFECTIVE = "生效" .. L_WEAPON_MAIN_ATTR
L_EQUIPLAYER_OUTREAK = "输出"
L_EQUIPLAYER_SURVIVAL = "生存"
L_EQUIPLAYER_CONTROL = "控制"
L_EQUIPLAYER_DEXTERITY = "灵巧"
L_EQUIPLAYER_SUPPORT = "辅助"
L_EQUIPLAYER_CHARACTER = "角色简述"
L_EQUIPLAYER_RECOMMEND = "推荐培养"
L_STAR_UP = "升 星"
L_WEAPON_SELECT_MAX_STAR = "购买数量超过升星上限所需"
L_VISITOR = "游客"
L_ACCOUNTMGR_BIND_RETURN = {
	"手机绑定成功: ",
	"账号无效。。。",
	"当前为游客账号, 不能绑定手机===",
	"手机号已被绑定===",
	"账号已绑定其他手机",
	"当前账号未登录。。。"
}
L_ACCOUNTMGR_PHONE_RETURN = {
	[2] = "电话格式不正确",
	[3] = "电话号码未被绑定"
}
L_ACCOUNTMGR_PASSWD_RETURN = {
	[0] = "验证失败",
	"密码修改成功",
	"密码格式错误"
}
L_VISITOR = "游客"
L_ACCOUNTMGR_BIND_RETURN = {
	"手机绑定成功: ",
	"账号无效。。。",
	"当前为游客账号, 不能绑定手机===",
	"手机号已被绑定===",
	"账号已绑定其他手机",
	"当前账号未登录。。。"
}
L_ACCOUNTMGR_PHONE_RETURN = {
	[2] = "电话格式不正确",
	[3] = "电话号码未被绑定"
}
L_ACCOUNTMGR_PASSWD_RETURN = {
	[0] = "验证失败",
	"密码修改成功",
	"密码格式错误"
}
L_REDBAG_OVERTIME = "不在领红包时间"
L_BACHELOR_UNRUNNING = "抢券尚未开始"
L_GET_ACTIVITY_ERROR = "获取活动数据异常"
L_GIFT_BAG = "礼包"
L_SUPER_VALUE = "超值"
L_NO_DISCOUNT = "不享受优惠券加成"
L_ACTIVITY_AWARD_GETED = "物品已领取!"
L_LEFT_TIME_SPACE = "剩余时间:"
L_ACTIVITY_ALL_FINISHED = "活动关卡已全部完成!"
L_ACTIVITY_DATA_ERROR = "服务端客户端数据不同步！"
L_NO_BRIEF_INTRO = "暂无简介"
L_CLICK_TOO_QUICK = "点击频率过快，请休息一下"
L_GET_REDBAG_FAIL = "领取红包失败"
L_ROB_BOUPONS_RESULT = {
	nil,
	"已经参与过本轮抢红包",
	"本次抢红包已经结束",
	"红包已经被抢光",
	"获取数据失败",
	"今日参与次数达到上限"
}
L_BUY_TIMES_SUCCESS = "购买次数成功"
L_BUY_TIMES_LIMITED = "今日购买已到上限"
L_BUY_TIMES_OVERSIZE = "剩余次数不大于30才能购买"
L_BUY_TIMES_MSG = {
	button = "确认购买",
	des = "花费%d" .. L_DIAMOND .. "购买1次试炼次数",
	more = "%d" .. L_DIAMOND .. "回复1次~~~~"
}
L_BUY_TIMES_MSG_MODETYPE_2 = {
	button = "确认购买",
	des = "花费%d" .. L_DIAMOND .. "购买5次试炼次数",
	more = "%d" .. L_DIAMOND .. "回复5次~~~~",
	buy_open_week_days = "支付%d" .. L_DIAMOND .. "可以临时开放一天。",
	buy_open_week_days_more = "%d" .. L_DIAMOND .. "开放一天~~~~"
}
L_EXPLORING = "正在探险"
L_PHYSICAL_POWER = "体力: "
L_MAIN_PLOT = "主\n线\n剧\n情"
L_EXPLORE_PLOT = "探\n险\n剧\n情"
L_EVENT_PLOT = "事\n件\n剧\n情"
L_LAYER = "层"
L_PROPERTY = "属性:"
L_FREE_FOR_CHARGE = "本次免费"
L_EATABLE_GROUP_NAME = {
	"蛋糕",
	"布丁",
	"寿司"
}
L_FIRE_ON = "要先开火哦~~"
L_COOK_RAW = "是生的"
L_COOK_COKE = "是焦的"
L_GIVEUP_RETURN_FOOD = "放弃返还食材"
L_STRENGTHEN_ERR_MSG = {
	[0] = "未解锁QAQ",
	nil,
	"核心需进阶QAQ",
	"总共振点数不足,请前往获取(共振)学员",
	"班长等级不足QAQ,请前往快速搜寻升级",
	"使用协调等级中, 请先下阵",
	"还需%s点共振点，共振任意学员以获取",
	"已达等级上限, 后续等级将取当前协调等级",
	"班长科技点不足QAQ,可前往快速搜寻获取"
}
L_CORE2SERVE_MSG = {
	nil,
	"核心不可进阶QAQ",
	"班长达到%s%d级方可进阶QAQ",
	"班长阶级不足QAQ",
	"学员进阶所需" .. L_GOLD_LACK .. "QAQ",
	"学员突破材料不足QAQ"
}
L_PATROL_NO_HOLIDAY = "巡逻中的学员无法重置状态"
L_UNLOCK_SUCCESS = "解锁成功"
L_DORMROOM_QUICK_UNLOCK_MSG = {
	[2] = "房间未在建设中",
	[3] = "加速材料不足"
}
L_DORMROOM_CHANGE_FURNTURE_MSG = {
	nil,
	"房间未解锁",
	"背景不能卸下",
	"装修材料不足"
}
L_FAVOR_POOL_EMPTY = "好感币缓存池为空"
L_EXPLORE_PROGRESS = "探险进度 "
L_EXPLORE_BEGIN_MSG = {
	nil,
	"该地点尚未解锁~~~",
	"格点处于危险状态~~~",
	nil,
	nil,
	"选取学员错误~~~~",
	"学员体力不足~~~"
}
L_COMSUME_PHYSICAL_POWER = "消耗体力: "
L_REST = "剩余"
L_DIFFICULT_NAME = {
	"简单难度",
	"普通难度",
	"困难难度",
	"极难难度"
}
L_UNLOCK_BY_PROGRESS = "需要根据任务进度解锁该区域"
L_WEAPON_FRAGMENT = "概率出现武器图纸"
L_MEMBER_LV_LOW = "小队成员等级不足"
L_TOTAL_CAPACITY_LOW = "综合战力不足"
L_CALLBACK_TEAM_MSG = {
	title = "召回探险小队",
	button = "确认召回",
	des = "学员持续探险了%dh\n(每0.5h有一次收获)"
}
L_SPIRIT_CAPACITY = "精神力: "
L_LV = "级"
L_INFO_NEEDTIME = "需要: %d小时"
L_MAP_LOCK = "地图未解锁"
L_AIRSHIP_HANGUP = "飞船%d挂机中"
L_AIRSHIP_FINISH = "飞船%d已完成"
L_AIRSHIP_RETURN = "呼叫塔台,请求返航"
L_PASS_NOMAL_UNLOCK = "通关该地图普通难度即可解锁~"
L_LEVELS = "关卡"
L_SUIT = "套装"
L_ALL = "全部"
L_ASCENDING = "升序"
L_DESCENDING = "降序"
L_SORT = "排序"
L_ASCEN_OR_DESCEN = "升降序"
L_SORT_TYPE = "排序类型"
L_FILTER = "筛选"
L_SORT_COLOR = {
	"白",
	"绿",
	"蓝",
	"紫",
	"橙",
	"红"
}
L_SORT_STAR = {
	[0] = "初始",
	"一星",
	"二星",
	"三星",
	"四星",
	"五星",
	"六星",
	"七星",
	"八星",
	"九星"
}
L_SORT_ATTR = {
	[0] = "无属性",
	"电磁",
	"热能",
	"量子",
	"光能",
	"暗物质",
	"虚数",
	"反物质",
	"食灵",
	"Umaru",
	"异构",
	"正能量",
	"拟态",
	"异世界",
	linkage = "联动",
	other = "其他"
}
L_FILTER_STR = {
	COMPONENT_BAGLAYER = {
		[2] = {
			[3] = L_SORT_COLOR[3],
			[4] = L_SORT_COLOR[4],
			[5] = L_SORT_COLOR[5]
		}
	},
	MATRIAL_BAGLAYER = {
		{
			other = "突破素材",
			special_supply = "特殊补给",
			lab_matrial = "科研材料",
			piece = "魂器碎片"
		},
		L_SORT_COLOR
	},
	BASICMATRIAL_BAGLAYER = {
		{
			other = "突破素材",
			activity_item = "活动物品",
			consume = "消耗品",
			breakout_item = "突破素材",
			special_supply = "特殊补给"
		},
		L_SORT_COLOR
	},
	LABMATRIAL_BAGLAYER = {
		{
			lab_matrial = "科研材料",
			piece = "魂器碎片"
		},
		L_SORT_COLOR
	},
	FURNITURE_BAGLAYER = {
		{
			skin = "皮肤",
			furniture = "家具",
			gift = "礼物"
		},
		L_SORT_COLOR
	},
	WEAPON_BAGLAYER = {
		{
			special = "专属",
			all = "通用"
		},
		L_SORT_COLOR,
		L_SORT_STAR
	},
	HORCRUX_LAYER = {
		L_SORT_ATTR,
		{
			L_SORT_STAR[1],
			L_SORT_STAR[2],
			L_SORT_STAR[3],
			L_SORT_STAR[4],
			L_SORT_STAR[5],
			L_SORT_STAR[6],
			L_SORT_STAR[7],
			L_SORT_STAR[8],
			L_SORT_STAR[9]
		}
	},
	AI_MONSTER_BAGLAYER = {
		{
			"X\nm\na\ns",
			"矩阵",
			"天眼",
			"蜂巢"
		},
		L_SORT_COLOR
	},
	COMPONENT_ITEMPANEL = {
		[2] = {
			[3] = L_SORT_COLOR[3],
			[4] = L_SORT_COLOR[4],
			[5] = L_SORT_COLOR[5],
			[6] = L_SORT_COLOR[6]
		}
	},
	WEAPON_ITEMPANEL = {
		{
			special = "专属",
			all = "通用"
		},
		L_SORT_COLOR,
		L_SORT_STAR
	},
	WEAPON_EXP_ITEMPANEL = {
		L_SORT_COLOR
	},
	WEAPON_UPGRADE_ITEMPANEL = {
		L_SORT_COLOR
	},
	DORMROOM_FURNITURE_ITEMPANEL = {
		{
			"背景",
			"箱子",
			"床",
			"挂件",
			"窗户"
		},
		L_SORT_COLOR
	},
	SERVANT = {
		{
			wind = L_SORT_ATTR[1],
			fire = L_SORT_ATTR[2],
			water = L_SORT_ATTR[3],
			light = L_SORT_ATTR[4],
			dark = L_SORT_ATTR[5],
			imaginary = L_SORT_ATTR[6],
			devil = L_SORT_ATTR[7],
			shiling = L_SORT_ATTR[8],
			umaru = L_SORT_ATTR[9],
			zerosupperession = L_SORT_ATTR[10],
			linkage = L_SORT_ATTR.linkage,
			other = L_SORT_ATTR.other,
			mimicry = L_SORT_ATTR[12]
		}
	},
	MAJOR = {
		{
			[1] = "学员",
			[2] = "教职"
		}
	},
	LAB_RD = {
		{
			blueprint = "蓝图",
			project = "项目"
		}
	},
	DORMITORY = {
		{
			[1] = "学员"
		}
	}
}
L_FILTER_TYPE_STR = {
	COMPONENT_BAGLAYER = {
		"属性",
		"品质",
		"套装效果"
	},
	MATRIAL_BAGLAYER = {
		"类别",
		"品质"
	},
	BASICMATRIAL_BAGLAYER = {
		"类别",
		"品质"
	},
	AI_MONSTER_BAGLAYER = {
		"阵营",
		"品质"
	},
	LABMATRIAL_BAGLAYER = {
		"类别",
		"品质"
	},
	FURNITURE_BAGLAYER = {
		"宿舍道具",
		"品质"
	},
	WEAPON_BAGLAYER = {
		"职业",
		"品质",
		"星级"
	},
	HORCRUX_LAYER = {
		"属性",
		"星级",
		"稀有度",
		"是否聚合"
	},
	COMPONENT_ITEMPANEL = {
		"主属",
		"品质",
		"套装效果"
	},
	WEAPON_ITEMPANEL = {
		"职业",
		"品质",
		"星级"
	},
	WEAPON_EXP_ITEMPANEL = {
		"品质"
	},
	WEAPON_UPGRADE_ITEMPANEL = {
		"职业",
		"品质",
		"星级"
	},
	DORMROOM_FURNITURE_ITEMPANEL = {
		"宿舍道具",
		"品质"
	},
	SERVANT = {
		"天赋",
		"稀有度",
		"职业",
		"其它"
	},
	MAJOR = {
		"类型"
	},
	DORMITORY = {
		"类型"
	},
	SPRINGTASKLISTLAYER = {
		"王志鹏1",
		"王志鹏2",
		"王志鹏3",
		"王志鹏4",
		"王志鹏5"
	},
	LANRERNTASKLISTLAYER = {
		"阶段1",
		"阶段二"
	},
	CHAPTERLAMIATASKLISTLAYER = {
		"阶段1",
		"阶段二"
	}
}
L_FILTER_SORT_STR = {
	COMPONENT_BAGLAYER = {
		"品质",
		"潜力",
		"强化等级",
		"位置"
	},
	MATRIAL_BAGLAYER = {
		"类别",
		"品质",
		"数量"
	},
	BASICMATRIAL_BAGLAYER = {
		"类别",
		"品质",
		"数量"
	},
	AI_MONSTER_BAGLAYER = {
		[1] = "品质",
		[2] = "数量"
	},
	LABMATRIAL_BAGLAYER = {
		"类别",
		"品质",
		"数量"
	},
	FURNITURE_BAGLAYER = {
		"类别",
		"品质",
		"数量"
	},
	WEAPON_BAGLAYER = {
		"品质",
		"强化等级",
		"星级"
	},
	HORCRUX_LAYER = {
		"等级",
		"星级",
		"初始攻击资质",
		"初始血量资质",
		"攻击",
		"血量"
	},
	COMPONENT_ITEMPANEL = {
		"品质",
		"潜力",
		"强化等级",
		"位置"
	},
	WEAPON_ITEMPANEL = {
		"品质",
		"强化等级",
		"星级"
	},
	WEAPON_EXP_ITEMPANEL = {
		[1] = "品质"
	},
	WEAPON_UPGRADE_ITEMPANEL = {
		"品质",
		"强化等级",
		"星级"
	},
	DORMROOM_FURNITURE_ITEMPANEL = {
		"品质",
		"数量",
		"价格"
	},
	SERVANT = {
		"等级",
		"入学时间",
		[3] = "共振",
		[10] = "稀有度"
	},
	MAJOR = {
		[1] = "等级"
	},
	DORMITORY = {
		[1] = "好感度"
	},
	COMPONENT_STRENGTHEN = {
		"品质",
		"强化等级",
		"潜力",
		"位置"
	}
}

setmetatable(L_FILTER_STR.SERVANT[1], {
	__index = function(arg_2_0, arg_2_1)
		if type(arg_2_1) == "number" then
			return L_SORT_ATTR[ATTR_INDEX[arg_2_1]]
		end
	end
})

L_FAVOR = "好感"
L_SHOP = "商店"
L_TWISTEGG = "扭蛋"
L_EXPLORE = "冒险"
L_NO_OPEN = "暂未开放"
L_FINISH_LEVEL_UNLOCK = "通关%s%s开启%s"
L_CANNOT_JUMP_SAME = "相同界面不能互相跳转"
L_HORCRUX_SKILL = "魂器技能"
L_ITEM_CONFIG_NAME = {
	ITEMPANEL_TYPE_ROLE_COMPONENT = "零件背包",
	ITEMPANEL_TYPE_WEAPON_STRENGTHEN = "强化材料背包",
	ITEMPANEL_TYPE_COOK_ADD_FOOD = "食物仓库",
	ITEMPANEL_TYPE_DORM_FURNITURE = "家具仓库",
	ITEMPANEL_TYPE_UPGRADE_WEAPON = "武器背包",
	ITEMPANEL_TYPE_MEDAL = "勋章",
	ITEMPANEL_TYPE_SMELT_COMPONENT = "零件熔炼",
	ITEMPANEL_TYPE_ROLE_WEAPON = "武器背包"
}
L_COMPONENT_EFFECT = {
	nil,
	"冷却",
	nil,
	"减伤",
	"增伤"
}
L_COMPONENT_ATTR = {
	"攻击",
	"血量",
	"奥义强度",
	"强击",
	"暴击",
	"闪避",
	"防御",
	"能量抵抗",
	"攻击%",
	"血量%"
}
L_COMPONENT_SORT = {
	"潜力",
	"阶级",
	"品质",
	"强化等级",
	"位置",
	"角色"
}
L_CAREER_LIST = {
	assassin = "刺客",
	shooter = "射手",
	witcher = "法师",
	fighter = "战士",
	tank = "坦克",
	support = "辅助",
	melee = "近战",
	remote = "远程"
}
L_ITEMPANEL_SORT_STR = {
	level2 = "等级",
	quality = "品质",
	number = "数量",
	nowStars = "当前星级",
	level = "强化等级"
}
L_ITEMPANEL_FILTER_TYPE_STR = {
	ITEMPANEL_TYPE_ROLE_COMPONENT = {
		"套装效果",
		"品质",
		"属性"
	},
	ITEMPANEL_TYPE_SMELT_COMPONENT = {
		"套装效果",
		"角色类型",
		"攻击类型"
	},
	ITEMPANEL_TYPE_ROLE_WEAPON = {
		"当前星级",
		"品质"
	},
	ITEMPANEL_TYPE_WEAPON_STRENGTHEN = {
		"品质"
	},
	ITEMPANEL_TYPE_UPGRADE_WEAPON = {
		"品质"
	},
	ITEMPANEL_TYPE_COOK_ADD_FOOD = {
		"品质"
	},
	ITEMPANEL_TYPE_DORM_FURNITURE = {
		"家具类型"
	}
}
L_COST = "消耗"
L_GET_EXP = "获得经验:"
L_CHECK_MORE = "查看更多"
L_ADD_FAVOR_COIN_HOUR = "每小时增加%d枚好感币"
L_WEAPON_HAVE_LOCKED = "魂武已锁定！"
L_FREE_BUY = "免单"
L_ATTR_HIDE = "属性暂时未知"
L_DES_HIDE = "相关描述暂属机密文件"
L_ATTR_TOTAL = "总属性"
L_ATTR_EFFECT = "生效属性"
L_SOLD_FAIL = "出售失败QAQ"
L_ELECTRIC_LACK = "电力不足"
L_LAYER_UNLOCKED = "通关%s解锁"
L_LAYER_UNLOCKED2 = "通关%s%s解锁"
L_NO_WAY_GET = "暂时没有提供获得该物品的方法"
L_SPECIAL_ACTION = "特别行动"
L_PASS_TIME = "通关时间:"
L_CITY_DEFAULT_DES = "小住为佳，小楼春暖"
L_OPEN_WEEKLY = "每周%s开启"
L_BRANCH_CANNOT_QUICK_FIND = "该支线不能快速搜寻"
L_QUICK_FIND_CONDITION = "需要通关第%d章才能进行快速搜寻"
L_NO_NOTICE = "暂无公告！"
L_START_BUY = "开放购买"
L_PATROL_CONDITION = "需要通关%s才能驻守"
L_PATROL_TIMES_USEDOUT = "此章节驻守次数已用完"
L_BUFF_CONTANT_TIME = "持续%s秒"
L_BUFF_SUPERPOSITION = "最多叠加%d层。"
L_BUFF_DISPEL_FORBID = "【此状态无法被驱散】"
L_POPCHAPTERS_PATROL_BTN = {
	Team_Lack = "小队数量不足~",
	Tims_Lack = "此章节驻守次数已用完~",
	UNPASS = "未通关",
	Des = "(驻守以6倍挂机速度获取物品)"
}
L_HAVE_ATE = "已喂食"
L_CANNOT_EAT = "食材不足,不能喂食~~"
L_FOOD_NAME = "名称:"
L_FOOD_NUM = "拥有数量:"
L_FOOD_FULL_SCORE = "总分: 100(食物健康)"
L_EAT_NO_FIGHT = "出战便不能喂食喽~~"
L_EAT_TIME_NO_YET = "未到喂食时间~"
L_FOOD_HEALTH = "食物健康"
L_FOOD_UNHEALTH = "食物还生着或者焦了,喂食请谨慎"
L_FOOD_LACK = "食材不足"
L_NO_PAN = "锅具不齐备~"
L_COOK_WARNING = {
	[2] = "锅具不齐备~",
	[3] = "食材不齐备~"
}
L_EAT = "喂食"
L_BATTERY_LACK = "电池数量不足！"
L_ELECTRIC = "电"
L_GO_CONFIG_DES = {
	quick_find = "前往快速搜寻",
	recycle_shop = "前往回收商店",
	horcrux_compound = "魂器碎片合成",
	twist = "前往扭蛋",
	sell = "前往出售物品",
	midas = "前往挖矿"
}
L_POPGOGAIN_SYSTEM_CLOSE = {
	InstanceLayer = "暂不开放副本系统~~",
	ShareLayer = "暂不开放分享系统~~"
}
L_GIRL_MAX = "学员已达最大上限"
L_HOLIDAY_SCRIP_LACK = "假条数量不足"
L_BUY_SCRIP = "消耗%d魂晶购买%d张%s"
L_BUY_SCRIP_OTHER = "消耗%d%s购买%d张%s"
L_HOLIDAY_CONFIRM = {
	des = "重置将会使学员等级变为0级，并退还所有升级材料",
	title = "重置确认"
}
L_ITEM_NAME_DEFAULT = "劈里啪啦劈里啪啦~"
L_ITEM_INFO_LOCK = "机密信息，尚未公布"
L_ITEM_NUMBER = "拥有数量："
L_ITEM_WEIGHT = "负重："
L_ITEM_SURE_BTN = "确认"
L_QUICK_HANGUP_RESULT = {
	nil,
	"挂机券不足~~~",
	"今日快速搜寻次数已用光",
	"挂机券不足 QAQ",
	"需要通关第%d章才能进行快速挂机"
}
L_QUICK_HANGUP_BUY = "消耗%d魂晶购买%d张挂机券"
L_QUICK_HANGUP_FORBID = "该支线不能快速挂机"
L_QUICK_HANGUP_LISSTIME = "今日剩余次数（%d/%d）"
L_RESEARCH_MAKE = {
	Btn_Str = "制 作"
}
L_COB_NIL = "暂未获取任何卡券"
L_HEAD_SOUL_NIL = "未拥有头像QAQ"
L_SERVANT_BREAKOUT_MSG = {
	Skill = "技能",
	No_Level_Limit = "未达到当前等级上限",
	Times_Limit = "突破次数已上限"
}
L_CONDITON_NO_ENOUGH = "未满足条件"
L_GET_NEW_SKILL = "获得技能："
L_REPLACE_MATERIAL = "以下可替代消耗 "
L_EXP_OVERFLOW = "该学员已到达玩家等级，溢出的经验值中的50%将转化为科技点。"
L_TRAIN_TO_EXP = "训练%d小时可获得%s经验"
L_GIRL_LEVEL_LIMIT = "学员等级已到玩家限制等级，无法升级"
L_POP_INTRO_TITLE = {
	[13] = "【人物介绍】："
}
L_LEVEL_MAX = "已满级"
L_ARRIVE_LIMIT = "达到限制"
L_WEAPON_UP_BTN = "改 造"
L_ARRIVE_LEVEL_LIMIT = "已到达等级上限"
L_RECHARGE_GET_INFO = {
	[2] = "正式服不接受测试版客户端请求",
	[3] = "充值系统未开启"
}
L_RECHARGE_RESPONSE = {
	[200] = "连接错误~~~~"
}
L_RECHARGE_SURE_BACK = {
	Des = "获得%s",
	Title = "确认消费"
}
L_VERSION = "版本: %s"
L_CHECK_DATA_TITLE = {
	Skill = "校验技能数据",
	Model = "校验模型数据",
	Task = "校验任务数据",
	Drops = "校验掉落数据",
	Items = "校验物品数据",
	Other_Dialog = "校验其他对话数据",
	Travel = "校验旅行数据",
	Twist_Egg = "扭蛋概率检查",
	Cook = "校验厨房数据",
	Full_Screen_Dialog = "校验全屏对话数据",
	Enemy = "校验怪物数据",
	Entrust_Random = "检测随机委托",
	Entrust = "检测委托",
	Data = "校验数据文件",
	Create_Advanture_Data = "生成冒险数据",
	Advanture = "校验冒险数据"
}
L_CHECK_DATA_STR = {
	Skill = "检查技能和buff引用的status是否为空, 检查技能引用的buff是否为空",
	Model = "检查model中cfg, 立绘, q版, 头像, 检查怪物model是否为空",
	Task = "检查任务id是否存在",
	Drops = "检查关卡,商城,任务掉落是否为空, 检查掉落是否只有个id",
	Create_Data = "生成数据",
	Other_Dialog = "检查三层结构是否完整, 宿舍对话是否有误",
	Travel = "对应城市的事件池id不存在;探险对话不存在",
	Twist_Egg = "根据dropdata检查扭蛋各项掉率",
	Cook = "单人食谱是否有客人存在;食谱中taste的num与weight不一一对应",
	Full_Screen_Dialog = "检查全屏对话中的立绘和表情",
	Enemy = "检查关卡引用的怪物是否为空",
	Advanture = "检查冒险数据以及图片",
	Items = "检查各处引用的itemid是否为空, 检查itemData引用的图标是否存在",
	Data = "检查data文件和cfg文件是否出现语法错误"
}
L_CHECK_END = "检查完毕"
L_CHECK_TASK_DATA = {
	tasktypeStr = {
		"主线",
		"日常",
		"成就",
		"新手"
	}
}
L_NO_IMAGE = "缺少图片: "
L_NEW_ACHIEVEMENT = "解锁新成就"
L_LOGOUT_MSG = {
	{
		Info = "\n学院放假维护中，可以安心休息啦(`W`)",
		Title = "下线通知"
	},
	{
		Info = "\n学院AI助理检测到你已在其他设备登录~",
		Title = "异地登录通知"
	},
	{
		Info = "\n学院检测到你有异常违纪行为，请重新登录！",
		Title = "账号状态异常"
	},
	{
		Info = "\n与魂器终端失去连接，请检查网络后重新登陆！",
		Title = "检查网络"
	},
	{
		Info = "\n课程内容已更新, 请退出更新",
		Title = "更新通知"
	},
	{
		Info = "\n您的体验时间已到，请进行实名认证",
		Title = "下线通知"
	}
}
L_LOGIN_EXIT_DIALOG = {
	Content = "班长大人，确定离开魂器学院吗？",
	Title = "确定退出"
}
L_LOGIN_CLOSE_SERVE = "学院放假"
L_INPUT_ACTIVATION_CODE = "请输入激活码"
L_CONNECT_FAIL = "魂器终端连接失败，请检查网络>_<"
L_ACTIVATION_CODE_ERROR = {
	nil,
	"激活码为空",
	"激活码已被使用",
	"激活码不存在"
}
L_REGISIT_CLOSE = "暂未开放账号注册"
L_VICTOR = "胜"
L_ARENA_CREDITS = "竞赛积分:"
L_NAME_LENGTH_LIMIT = "名字(最多七个字)"
L_DISCOUNT = "折"
L_RECYCLE = "回收"
L_LIMIT = "限定"
L_WAITING_SELL = "预售中"
L_SPSKILL_TYPE = {
	[1] = "大招/",
	[2] = "技能/"
}
L_FIRE_UNIT_REST = "灭火装置剩余%d个"
L_FIRE_UNIT_LACK = "灭火装置不足！"
L_MONITOR = "班长"
L_SKIP_EVENT = "是否确认跳过剧情?"
L_TASK_TYPE_BTN = {
	TASK_TYPE_NORMAL = "主\n线\n任\n务",
	TASK_TYPE_ACHIEVE = "成\n就\n任\n务",
	TASK_TYPE_DAILY = "日\n常\n任\n务",
	TASK_TYPE_CAREER = "新\n手\n任\n务"
}
L_SOUL = "魂"
L_BARRAGE_TO_REPLY = "输入弹幕回复"
L_SEND = "发送"
L_TIPS_LAST_PAGE = "上一页"
L_TIPS_NEXT_PAGE = "下一页"
L_TEST_DATA = "1-5 奥杜因(困难)"
L_CLASSUP_MSG = {
	[1] = "完成当前升学任务方可进阶~",
	[2] = "还有升学任务未领取~"
}
L_PLOT_CLASS_STR = {
	BATTLEPASS = "战术指令",
	ACHIEVE = "成就",
	RESOURCES = "资源",
	CHALLENGE = "挑战",
	CAREER = "升学",
	NORMAL = "剧情",
	ACTIVITY = "活动",
	ITEM = "物品",
	ROLE = "角色",
	DAILY = "日常",
	MOVE = "行动"
}
L_CLASSUP_FORBID = "条件未达成QAQ"
L_ROOM_NUM_LIMIT = "房间个数上限"
L_TWISTEGG_FAIL_WORD = {
	wind = "扭蛋券不足",
	water = "扭蛋券不足",
	fire = "扭蛋券不足",
	recommend = "扭蛋券不足",
	light = "扭蛋券不足",
	dark = "扭蛋券不足",
	normal = "今日剩余免费次数不足"
}
L_TWISTEGG_FIRST_SINGLE_USED = "新手扭蛋单次机会已用过~"
L_TWISTEGG_FIRST_TEN_USED = "新手扭蛋十连机会已用过~"
L_TWISTEGG_FREE = {
	Ten = "十次免费次数",
	Single = "一次免费次数"
}
L_TWISTEGG_DAILY_FREE = "免费%d次"
L_TWISTEGG_TOTAL_FREE = {
	Ten = "免费%d次十连",
	Single = "免费%d次扩招"
}
L_ZHANG = "张"
L_MEI = "枚"
L_GE = "个"
L_TWISTEGG_COST = {
	Ten = "十张",
	One = "一张",
	Money = "钞票"
}
L_TWISTEGG_ITEMS_MSG = {
	nil,
	nil,
	"蛋池未开放",
	"蛋池未解锁",
	"蛋池已抽光",
	"需要先选择角色"
}
L_TWISTEGG_LACK_OF_COST = {
	Cost_Diamond_Des = "消耗魂晶购买扭蛋券~",
	Cost_Gold = "消耗%d图灵新钞购买%d张%s",
	Buy_Success = "购买成功!",
	Need = {
		[1] = "还需要",
		[2] = "张"
	}
}
L_TWISTEGG_PROBILITY_UP = "概率UP"
L_SPECIAL_TYPE = "特殊作战形态"
L_GIFT = "礼物"
L_FURNITURE = "家具"
L_TECH_MATERIAL = "科研材料"
L_UNLOCKFIGURE_NEW = "哇塞，你获得了一个新的"
L_UNLOCKFIGURE_BACK_BTN = "武器娘"
L_UPDATE_CHECKING = "正在检查游戏版本..."
L_UPDATE_IS_NEW = "游戏已是最新版本"
L_UPDATE_WARNING = {
	"当前无网络连接",
	"当前使用WIFI连接",
	"当前使用移动数据网络"
}
L_UPDATE_DOWNLOAD = "下载更新"
L_UPDATE_DATA_SIZE = "有更新可下载(共计%dMB), %s"
L_UPDATE_DOWNLOAD_NEW_CLIENT = "下载新客户端"
L_UPDATE_HAVE_NEW_CLIENT = "有新客户端可用，是否前往下载？"
L_UPDATE_NET_FAIL = "网络错误"
L_UPDATE_FAIL = "更新失败"
L_UPDATE_SUCCESS = "更新成功!!!"
L_UPDATE_DECOMPRESS_FAIL = "解压失败"
L_UPDATING_DOWNLOADING = "正在下载更新包(%d%%)"
L_WEAPON_SELECT_MAX_STAR = "购买数量超过升星上限所需"
L_SUBSTITUTION_WARNING = {
	"必须选择一人上场",
	"极限拟练次数不足，请明日再来挑战~",
	"当前没有正在进行的极限挑战哦~"
}
L_SUBSTITUTION_ENTER_WARING = "班长需要达到大学才能参与极限拟练"
L_WEAPON_SELECT_MAX_STAR = "购买数量超过升星上限所需"
L_ACTIVITY_NINIFA = {
	CUMULATIVE_MANUFACTURING = "累计制造",
	START_COMPOUND = "开始制造",
	ILLUSTRATE_TITLE = "配方手册",
	ITEM_NOT_ENOUGH = "班长提供的道具数量不足了哎",
	OTHER_ERROR = "未知错误",
	PARA_ERROR = "参数非法！",
	CAN_NOT_GO_BOSS = "请班长先完成前三楼的任务凹",
	ACTIVITY_OUTDATA = "活动过期",
	BUY_TOMANY_TIME = "今日不能再购买啦，班长请注意身体嗷！",
	MATERIALS_NOT_ENOUGH = "班长，人家的武器还没有被塞满呐~~",
	CAN_NOT_BUY_TIME = "班长的挑战次数还是满的呐！",
	RECORD_TITLE = "制造记录",
	COMPOUND_NUM = "制作次数",
	DIF_QUALITY = "不品质道具不能参与合成呐",
	CUMULATIVE_COMPOUND = "累计制造结果"
}
L_SET_TWIST_TEN = "十连确认弹窗"
L_TWIST_TEN_POP = {
	[6800101] = {
		titleImage = "TwisteggLayer_ten_pop.png",
		title = "十连确认",
		button = "十连确认",
		des = "消耗扭蛋券进行扩招"
	},
	[6800601] = {
		titleImage = "TwisteggLayer_ten_pop.png",
		title = "十连确认",
		button = "十连确认",
		des = "消耗礼品卡进行扩招"
	},
	[6800602] = {
		titleImage = "TwisteggLayer_ten_pop.png",
		title = "十连确认",
		button = "十连确认",
		des = "消耗愚人币500进行扩招"
	},
	[6800603] = {
		titleImage = "TwisteggLayer_ten_pop.png",
		title = "十连确认",
		button = "十连确认",
		des = "消耗补给凭证10进行扩招"
	},
	other = {
		titleImage = "TwisteggLayer_ten_pop.png",
		title = "十连确认",
		button = "十连确认",
		des = "消耗%s进行扩招"
	}
}
L_CORE_ADVANCE_DES = "等级上限提升: "
L_CORE_ADVANCE_NAME = "进 修"
L_CORE_UP_DES = {
	[1] = "突破获取:",
	[2] = "进修获取:"
}
L_SOULS_ADVANCE_MAX = "学员进修次数已达上限"
L_5_10_LOCK = "5-10解锁"
L_TALKLEVEL_LOCK = "通关" .. L_5_10_LOCK
L_ACTIVITY_TWOEGG_PT = {
	UN_COMPLETE = "臭弟弟，没完成就想白嫖？",
	IS_END = "活动阶段任务已结束",
	UN_START = "活动阶段任务未开启",
	ERROR = "ERROR!!该活动无活动任务!"
}
L_ACTIVITY_DOULE_HOLIDAY = {
	GET_DATA_FAIL = "获取科技树数据失败",
	NEED_UP_FRONT = "请先升级该技能的前置技能！",
	FULL_LEVEL = "  （已升满）",
	NODE_CUR_DEFENSE = "节点当前防御：",
	CEHUA_TIANBIOA = "我觉得是因为策划没填表",
	TECHNOLOGY_TREE = "病毒科技",
	LEVEL_UP_FAIL = "升级失败!",
	PASSIVE_LEVEL_UP_SUCCESS = "“%s”升级成功",
	HUI_SHUO_DESC = "是否消耗%s魂晶重置所有科技，\n并返还所有病毒科技点。",
	COST_NOT_ENOUGT = "升级该技能所需要的病毒科技点不足！",
	CHECK_FOR_GET = "点击对应科技获取详细信息，升级科技将消耗病毒科技点。",
	ROUND = "回合",
	NOT_HAVE_TEC = "班长还没有升级任何科技，没有必要重置。",
	DIM_NOT_ENOUGH = "魂晶不足！",
	UNPASSIVE_UNLOCK = ",解锁技能“%s”",
	LEVEL_MAX = "该技能已经升至最高等级！",
	NEED_UP_FRONT_LAYER = "需要上层科技至少升级三次！",
	HUI_SHUO = "回溯"
}
L_BUY_SHOP_LOCK = "模拟侵蚀《%s》可购买"
L_PASS_PLAGUE = "模拟侵蚀"
L_CAN_BUY = "可购买"
L_DOUBLEHOLIDAY_WOLDCITYLAYER = {
	NOSTART = "未开始",
	TIPS_8 = "模拟系统装载中，将在第二阶段开启",
	NO_SKILL = "未知技能",
	TIPS_3 = "预计",
	NODAMAGE = "还未开始破坏",
	HAVEFECODE = "已完全破译",
	TIPS_12 = "对",
	SCIENE = "科研中心",
	TIPS_4 = "后完全破坏",
	RESET_CITY = "城市重置成功！",
	TIPS_5 = "后完全破译",
	TIPS_13 = "破坏度达到",
	TIPS_14 = "奖励已领取",
	NOW_VIRUS = "当前病毒因子:",
	USE_SUCESS = "使用成功",
	TIPS_15 = "阶段一活动已结束！",
	NODECODE = "还未开始破译",
	AGAIN_PLAY = "重新模拟",
	CLEAR_SKILL_CD = "技能cd清除成功!",
	NONEWS = "暂无新消息",
	TIPS_6 = "是否确认重新模拟？(重新模拟可以获得",
	TIPS_1 = "物品不足，是否消耗",
	SIMULATED_INTRUSION = "没有AI可供模拟入侵",
	TIPS_7 = "个Xmas制造因子)",
	TIPS_16 = "活动期间剩余购买次数：",
	TIPS_11 = "后增加1TB病毒)",
	TIPS_9 = "使用道具立即获得60TB的病毒",
	HAVEDAMAGE = "节点已被破坏",
	TIPS_10 = "今日剩余购买次数：",
	BUY_AND_USE = "购买并使用",
	TIPS_2 = "魂晶来使用技能",
	UNLOCK = "城市未解锁！",
	PUSHVIRUS = {
		"病毒投放失败！",
		"投放病毒成功！",
		"病毒数量不足！",
		"节点防御过高，病毒投放失败！",
		"节点容量不足！",
		"城市未解锁，病毒投放失败！"
	},
	USE_SKILL = {
		"技能释放失败!",
		"技能释放成功!",
		"技能冷却中!",
		"技能不存在！",
		"目标选择错误！",
		"目标节点还未投放病毒！",
		"目标节点已被完全破坏！"
	},
	SKILL_TIPS = {
		"时间加速",
		"消耗1个加速模组，将该城市的Xmas病毒在10分钟内进行10倍加速侵入&繁殖",
		"花费50魂晶，将该城市的Xmas病毒在10分钟内进行10倍加速侵入&繁殖",
		"清除冷却时间",
		"消耗",
		"魂晶清除冷却时间"
	},
	NAME_INFO = {
		"新手城",
		"巴哈姆特",
		"耶梦加得",
		"派森",
		"洛加尔",
		"库库尔坎",
		"尼德霍格",
		"奥杜因"
	}
}
L_ADVENTURE_IS_ONCE_FIGHT = "考核已通关"
L_GIFT_RUN_HOURSE_LIGHT = setmetatable({
	[1] = "“%s”燃放了%s庆祝元旦，可点击前往“%s”地图抽奖哦！",
	[2] = "“%s”燃放了%s庆祝，可点击前往“%s”地图抽奖哦！"
}, {
	__index = function(arg_3_0, arg_3_1)
		return "“%s”燃放了%s庆祝，可点击前往“%s”地图抽奖哦！"
	end
})
L_FIREWORKS_TIPS = "提示:长按物品显示详情"
L_BARRAGE_GIFT_LACK = "弹幕礼物不足"
L_BARRAGE_GIFT_NOT_START = "应援活动暂未开启。"
L_BARRAGE_GIFT_END = "应援活动已结束。"
L_CHAPTER_UN_LOCK = "该关卡尚未解锁！"
L_JUMP_TO_FAIL = "跳转失败！"
L_JUMP_TO_SUCCESS = "跳转成功！"
L_BIANHUA_HIDE_TASK_TILE_88043001 = "黑商向你发送了好友请求"
L_BIANHUA_HIDE_TASK_TILE_880411001 = "传送老油条"
L_BIANHUA_HIDE_TASK_TILE_890410002 = "街机里的童年回忆"
L_BIANHUA_HIDE_TASK_TILE_890412003 = "藏在活动主页的神秘数字"
L_BIANHUA_HIDE_TASK_TILE_88091035 = "徽章Get☆Daze"
L_BIANHUA_HIDE_TASK_TILE_88091037 = "最伟大的外卖员"
L_BIANHUA_ADVEN_OUT = "呐呐呐~班长大人只能挑战一次呐~~"
L_ADVANTURE = "试炼"
L_BATTLE_PASS = {
	UN_KNOW_PASS = "物资筹备中，请耐心等待~",
	GET_LIST_FAILED = "获取通行证列表信息失败",
	GET_REWARD = "领取奖励",
	GET_REWARD_FAILED = "该奖励已经被领取",
	GET_ALL_REWARD = "全部领取",
	NOT_HAVE_LEVEL = "该奖励已经被领取",
	NOT_REWARD_CAN_GET = "不存在可领取的奖励",
	FAIL = "领取等级奖励失败"
}
L_DECOMPOSE = "分解"
L_DECOMPOSE_NULL_HORCRUX = "未选择" .. L_DECOMPOSE .. "魂器"
L_CONFIRM_DECOMPOSE = "确认" .. L_DECOMPOSE
L_DECOMPOSE_EXIST_UNMATCH_HORCRUX = "存在魂器无法分解"
TASK_REWARD_ONEKEY_WARN = "没有任务可以完成"
ACTIVITY_NIANSHOU_WARN = "不在活动时间内"
NIANHOU_PT = "惊吓值"
NIANSHOU_REWARD_WARN = {
	[3] = "奖励已领取",
	[0] = ACTIVITY_NIANSHOU_WARN,
	[2] = NIANHOU_PT .. "不足"
}
NIANSHOU_ITEM_DES = {
	[1] = "造成",
	[2] = NIANHOU_PT
}
L_TIME_FORMAT_DAYHOURMIN_NIANSHOU = "%02d天%02d小时%02d分"
L_TIME_FORMAT_HOURMINSEC_NIANSHOU = "%02d小时%02d分钟%02d秒"
L_SPRING_COLLECTION_INFINITE_TIMES = "无限次"
L_SPRING_COLLECTION_SHORT_OF_WORD = "需要集齐词组才可以领取哦~"
L_SPRING_COLLECTION_FULL_WORD = "已放满了哦~"
L_SPRING_COLLECTION_NOT_FULL_WORD = "放满物品后才可以进行兑换哦"
L_MODE_STAR_REWARD_FAIL = {
	[2] = "已经领过该奖励",
	[3] = "没有达到要求星数"
}
L_CAREER = {
	FIG = "战士",
	DEX = "射手",
	ASS = "刺客",
	STR = "坦克",
	INT = "法师",
	SUP = "辅助"
}
L_POPULARITY = "共振点"
L_VALENTINE_RANK_VALUE1 = "应援值"
L_VALENTINE_RANK_VALUE2 = "人气值"
L_ACTIVITY_VALENTINE_GOTO_LEVEL = "前往应援"
L_MODE_DIFFICULTY_LAMIA = {
	[1] = "简单",
	[2] = L_MODE_DIFFICULTY[2],
	[3] = L_MODE_DIFFICULTY[3],
	[4] = L_MODE_DIFFICULTY[4]
}
L_CURRENT_SKIN_UNBLE_TO_BUY = "当前皮肤无法购买"
L_REFRESH_RNAKLIST = "提示：数据每小时刷新"
L_NO_NEW_CHAPTER = "暂无新章节！"
L_ACTIVITY_VALENTINE_GOTO_LEVEL = "前往应援"
L_MARRY_DES = {
	FAVOR1 = "好感度达到%d级",
	RING = "拥有一枚"
}
L_MARRY_BNT_STR = {
	[1] = "誓约",
	[2] = "回顾仪式"
}
L_MARRY_ERR = {
	nil,
	"已经举行过誓约仪式",
	"缺少誓约戒指",
	"好感度未达到%d级"
}
L_ACTIVITY_NOT_OPEN = "活动暂未开放哦，敬请期待"
L_ACTIVITY_MARRY_LEVEL = "升级%d级，可立刻解锁%d件物资"
L_BUY_BATTLEPASS_VIP = {
	"购买成功",
	"购买失败，参数错误",
	"购买失败，不能购买该档次vip",
	"购买失败，已购买该vip",
	"购买失败，所需礼品卡不足",
	"购买失败，优惠券不可使用"
}
L_BUY_BATTLEPASS_LEVEL = {
	nil,
	"购买失败，参数错误",
	"购买失败，购买等级超过最高等级",
	"购买失败，所需魂晶不足"
}
L_ACTIVITY_NOT_OPEN = "活动暂未开放哦，敬请期待"
L_MARRY_BUY = {
	des1 = "是否消耗",
	title = "购买戒指",
	button = "购买并使用",
	des2 = "购买誓约戒指?"
}
L_MARRY_SCIENCE = {
	"科技值",
	"下一级",
	"(提升好感等级增加科技值)",
	"攻击",
	"血量"
}
L_MARRY_RANK_LIMIT = "应援榜截至于5月25日23:59"
L_MAX_LEVLE = "已经是最高等级"
L_LEVEL_UP_ZERO = "班长好好看鸭！不能提升零级鸭！"
L_BUY_LIMIT = "限购"
L_MAX_LEVLE = "已经是最高等级"
L_NOT_SELECT_BARRAGEGIFT = "没有选择礼物"
L_ACTIVITY_NO_QUESTION = "该活动没有题目！"
L_ACTIVITY_QUESTION_TIME_OUT = "该题回答时间已过，请重进当前界面"
L_ACTIVITY_HAD_ANSWER = "班长已经作答过了哦！"
L_ACTIVITY_NOTICE_ANSWER = "请先答此题"
L_LESS_TIME_REFISH = "剩余%s刷新"
L_SPECIAL_JUMPTOWERLAYER = {
	shiling = "食灵",
	other1 = "需要全部学员为",
	other2 = "属性",
	ceng = "第%d层",
	umaru = L_SORT_ATTR[9],
	zerosupperession = L_SORT_ATTR[10]
}
L_SPECIAL_WEEKENDADVENTURELAYER = {
	tips = "",
	lock_time = "挑战次数不足，购买门票后挑战！",
	Rest_Time = "购买次数已达上限：",
	left_time = "剩余挑战次数:",
	recommend_level = "推荐等级："
}
L_PATROL_ARRAY_ONEKEY = "没有符合要求的学员了"
L_PATROL_SELECT_TIPS = "提示:长按立绘进入角色详情"
L_ACTIVITY_RETURN_LAYER = {
	no_buff = "暂无挂机效率加成"
}
L_ACTIVITY_QUESTION = {
	PT_ENOUGH = "班长已经有足够的学分啦！",
	PT_YICHU = "班长购买的学分会溢出鸭！"
}
L_ACTIVITY_WIDE_WAKE = {
	SP = "稀有补给",
	HUR = "魂器补给",
	TWIST_TICKET_NUM = "补给凭证  %d",
	ORD = "普通补给",
	MATERIAL = "材料补给"
}
L_SUBSTITUTION_LEVEL_OPEN = "当前等级未解锁！"
L_SUBSTITUTION_LEVEL_LOCK = "挑战中不能修改难度！"
L_SUBSTITUTION_CONTINUE_FIGHT = "继续挑战"
L_SUBSTITUTION_FIGHT = "挑 战"
L_SUBSTITUTION_ARRAY_LOCK = "当前队伍已锁定！"
L_SUBSTITUTION_ARRAY_UP = "该队伍已上阵！"
L_SUBSTITUTION_ARRAY_LEVEL_OPEN = "当前正在挑战其他难度！"
L_SUBSTITUTION_ARRAY_LEVEL_LOCK = "难度未解锁！"
L_SUBSTITUTION_ARRAY_ROLE_NUM = "需要上阵五名学员！"
L_SUBSTUTUTION_NULL = "当前没有超频战场领主可以挑战"
L_SUBSTITUTION_INVALID = "当前关卡未开放"
L_SUBSTITUTION_OPEN_TIME = "开放时间："
L_SUBSTITUTION_RESET_TIP = {
	des = "是否需要重置上一个队伍的进度",
	title = "重置进度"
}
L_SKILL_BK_GET = "突破后获取"
L_SKILL_OC_GET = "超频后获取"
L_ACTIVITY_NOT_MODEL_TIME = "活动模块时间未配置"
L_BATTLEPASS_BUY = {
	des_2 = "确定使用折扣券花费%d%s购买%s吗",
	title = "购买确认",
	button = "确 定",
	des = "确定花费%d%s购买%s吗"
}
L_DAMAGE_TYPE = {
	"机械伤害",
	"能量伤害",
	"混合伤害"
}
L_SPINE_NOT_HAVE_ANI = "模型%s没有填写spine动作！！！"
L_FRIEND_LISTLAYER = {
	friend_num = "好友数量"
}
L_FRIEND_SYSTEM = {
	get_award_success = "成功领取%d个友情点",
	day_online = "天前",
	is_on_my_friend = "对方不是好友",
	min_online = "分钟前",
	online = "在线",
	get_gift_limit = "今天已达到领取上限",
	no_get_or_send_gift = "暂时没有可领取和送礼的!",
	max_onlie = "天以上",
	sec_online = "1分钟前",
	send_all_gift = "成功给所有班长送礼！",
	no_can_get = "没有赞可领取",
	get_fail = "领取失败",
	send_fail = "送礼失败",
	hour_online = "小时前",
	send_gift_success = "成功给对方送礼！"
}
L_FRIEND_MANAGEMENT_LAYER = {
	input_right_uid = "请输入正确的编号",
	no_exist_player = "玩家不存在",
	recommend_tips = "推荐好友",
	add_is_friend = "对方已经是好友了",
	igrone_apply = "已忽略对方的好友申请qwq",
	my_uid = "我的编号:",
	add_friend_fail = "申请好友失败!",
	apply_invalid = "申请已失效~",
	friend_max = "已达到好友数量上限了~",
	accept_fail = "添加失败",
	recomment_flash_success = "刷新推荐好友成功！",
	accept_n_friend_success = "成功添加%d个好友",
	input_tips = "请输入想要搜索的班长编号哦~",
	is_friend_tip = "已是好友",
	operate_fail = "操作失败~",
	applying = "申请中",
	no_apply_data = "当前没有需要处理的好友申请哦~",
	add_all_tips = "是否接受全部好友申请",
	apply_list_limit = "对方申请列表已满",
	accept_friend_success = "已成功成为好友~",
	apply_list_limit_tips = "申请人数",
	add_max_limit = "今天可申请的数量已达到上限，明天再申请吧~",
	target_friend_max_limit = "对方好友已满",
	add_friend_success = "申请成功，耐心等待对方接受哦~",
	friend_limit = "对方好友数量已达到上限",
	recomment_flash_fail = "刷新失败",
	add_is_self = "不能申请自己为好友",
	limit_search_self = "不能搜索自己哦~",
	ignore_all_tips = "是否忽略全部好友申请"
}
L_FRIEND_INTRODUCE_LAYER = {
	chapter_progress_tips = "关卡",
	delet_sure_tips = "是否从好友列表中移除该玩家？",
	delet_friend_fail = "删除好友失败!",
	rolenum_tips = "学员",
	rolenum_tips_1 = "数量",
	class_lable = "班级",
	sigment_tips = "个性签名:",
	array_tips = "先遣队伍展示",
	chapter_progress_1 = "进度",
	arean_rank_tips = "抢位赛",
	no_signment_tips = "该好友暂无个性签名！",
	socre_dw_tips = "积分赛",
	applying_tips = "申请中，请耐心等待对方接受哦~",
	socre_dw_tips_1 = "当前段位",
	no_rank_arean = "未上榜",
	arean_rank_tips_1 = "当前排名",
	delet_friend_success = "删除好友成功~"
}
L_MAX_LEVLE = "满级"
L_RECHARGE_DAY = "每日%s時"
L_RECHARGE_WEEK = "每周"
L_RECHARGE_MONTH = "每月%s日"
L_RECHARGE_REFRESH = "更新"
L_RECHARGE_BUY_LIMIT = "购买次数已达上限"
L_RECHARGE_CARD_LIMIT = "黑金卡不能重复购买"
L_RECHARGE_OUT_TIME = "充值选项已过期，刷新界面"
L_RECHARGE_GRADE_LIMIT = "班长等级不足"
L_RECAHRGE_GOODS_UNAVAILABLE = "商品当前不可购买"
L_OWN_TICKET = "拥有"
L_FLOP_WARNING = {
	nil,
	L_COMMON_WARNING.Material_Lack,
	"本轮活动已结束",
	"该物品已获取",
	"物品获取失败",
	"翻牌已经刷新"
}
L_FLOP_BUY_KEY_WARNING = {
	[2] = "本轮活动已结束",
	[4] = "物品获取失败",
	[3] = L_DIAMOND_LACK
}
L_GO_SHOP_FOR_GIFTBAG = "购买礼包"
L_HORCRUX_UPSTAR_LACK = "材料不足"
L_STAR_LEVEL = "星级"
L_NEED_MATERIAL = "需要材料"
L_SKILL_STRENGTH = "技能增强"
L_MAX_LEVEL = "最大星级"
L_NEED_TYPE = "相同的星级和\n   种类"
L_NEED_ATTR = "相同的星级和\n元素"
L_FLOP_TURNS_NOW = "当前第  %s/%s  轮"
L_FLOP_RESET_WARNING = {
	[2] = "无法进入下一轮",
	[3] = "已是最后一轮"
}
L_FLOP_TIPS = "注：点击卡牌寻觅宝物"
L_FLOP_TURNS_IN_DETAILS = "第%d轮"
L_FLOP_TURNS_DOWN = "第%d轮及以后"
L_FLOP_CHAMPION_TIP = "本轮最高奖励"
L_FLOP_FURNITURE_TIP = "第%d~%d轮集齐家具"
L_AVAON_VISUAL = {
	jishi = "倒计时:",
	used_score = "(已兑换分数:%d)",
	fen_lock = "%d分",
	tips_3 = "%d年%d月%d日开启",
	have_get = "已领取",
	tips_2 = "当再次取得更高的分数后，领取的奖励为对应差额的「源点」",
	chapter_score = "当前得分:",
	no_award = "暂无奖励领取",
	array_power = "队伍战力：%s",
	array_score = "当前得分：%s(满)",
	score_tips = "总得分",
	array_score_end = "当前得分：%s(~)",
	tips_1 = "将根据当前的最高分数获得对应的「源点」,1分可兑换1个「源点」"
}
L_TVT_BEHAND_SEASON = "赛季暂未开始"
L_TVT_BEHAND_SEASON_2 = "团体赛将于 17:00 开启！"
L_TVT_NOT_RANK = "暂无排名"
L_TVT_NOT_OPEN = "暂未开启"
L_TVT_DEFENCE_ARRAY_NIL = "%d号队伍为空，请设置至少一名学员。"
L_TVT_DEFENCE_ARRAY = "请先设置队伍！"
L_TVT_ATTACK_ARRAY_NIL = "%d号队伍为空，请设置至少一名学员。"
L_TVT_ATTACK_ARRAY = "请先设置队伍！"
L_TVT_MATCH_ENEMY_TIMES = "今日挑战次数已达上限！"
L_TVT_CLOSE_ON_ACCOUNT = "当前属于结算时间，，请稍后再来！"
L_TVT_CURRENT_HAVE_SET = "当前队伍已设置！"
L_TVT_EIXT_TITLE = "取消匹配"
L_TVT_REFUSE_TITLE = "购买匹配次数"
L_TVT_REFUSE_DESC = "确定购买%s次匹配次数吗？\n班长本次购买将消耗%d魂晶！"
L_TVT_CAN_NOT_REFUSE = "今日购买次数已经达到上限！"
L_TVT_EIXT_CONFIRM_1 = "确定取消匹配吗？\n班长现在还剩余%d次不消耗挑战次数的取消机会！"
L_TVT_EIXT_CONFIRM_2 = "确定取消匹配吗？\n本次挑战次数将不会返还！"
L_TVT_CAN_NOT_REFUSE_2 = "购买后将超过次数上限！"
L_TVT_TEAM_TIPS = {
	Lock = "锁定",
	Team = {
		"先锋队",
		"近卫队",
		"压阵队"
	}
}
L_TVT_GETTED_AWARD = "暂无可领取奖励"
L_SEASON_LESS_TIME = "赛季剩余时间："
L_SEASON_END = "本赛季已经结束"
L_TVT_UNKOCK = "通关困难巴哈姆特4-10后解锁"
L_AREAN_UNLOCK = "通关%s后解锁"
L_TVT_SEASON_END = "当前是休赛期！"
L_TVT_AUTO_LOCK = "团体战一键编队功能暂未开启 - -"
L_TVT_FIGHT_TWO_SEASON = "赛季已经结束，本场比赛无效！"
L_LEVEL_MODE_DIF = {
	"普通",
	"困难",
	"噩梦",
	"地狱"
}
L_TVT_FIGHT = {
	[1] = "前往对战",
	[2] = "休赛期"
}
L_TVT_FIGHT_AGAIN = "再次匹配"
L_TVT_GOTO_SHOP = "确认"
L_TVT_LAST_RANK = "竞赛积分：  "
L_WORD_COLLECT_TIMES_LIMIT = "兑换结束"
L_WORD_COLLECT_TIPS = "选择任意三个字放入栏中进行兑换"
L_WORD_COLLECT_SURE_DETAIL = {
	des = "确认消耗物品并兑换奖励吗？",
	title = "兑换确认"
}
L_SWIM_NAME = "劈波斩浪"
L_SWIM_MAIN_LAYER_TITLE = "本轮情报"
L_SWIM_TEAM_NAMES = {
	"A队 ｜ %s",
	"B队 ｜ %s",
	"C队 ｜ %s",
	"D队 ｜ %s"
}
L_SWIM_TEAM_NAME_2 = {
	"A队",
	"B队",
	"C队",
	"D队"
}
L_SWIM_SCORE = "积分："
L_SWIM_BUFF_DES = "【%s】：%s"
L_SWIM_RANK_LIST = "逐场名次 ： %s"
L_WEEK_RECORD_DES = "每第七天21:00根据积分排名并发放奖励"
L_SWIM_GOTO_SHOP = "获取泳装皮肤"
L_SWIM_TEAM_INFO = "参赛选手一览"
L_SWIM_SHOOSE_TITLE_MODLE = "请选择一位学员进行应援吧"
L_SWIM_SHOOSE_TIP_MODLE = "猜中第一名可获得"
L_SWIM_SHOOSE_TITLE_TEAM = "请选择队伍进行应援吧"
L_SWIM_SHOOSE_TIP_TEAM = "最高可得"
L_SWIM_VOTE_RATE = "应援率"
L_SWIM_VOTE_MODEL_DAILTY_1 = "*每日两场应援，分别为8:00-14:00,15:00-21:00"
L_SWIM_VOTE_MODEL_DAILTY_2 = "*应援率根据所有玩家投票变化，应援率不影响比赛胜率。"
L_SWIM_VOTE_WEEK_DAILTY_1 = "*每轮应援投票时间截至第六天13:59，将在第七天21:00根据每组积分进行结算"
L_SWIM_VOTE_WEEK_DAILTY_2 = "请先应援，开赛前可以修改应援"
L_SWIM_VOTE_BTN_SHOW = "观看比赛"
L_SWIM_WEEK_RECORE = {
	[1] = "轮应援奖励：%d",
	[2] = "领取"
}
L_VOTES_RESULT = {
	[1] = "应援失败。"
}
L_SWIM_REWARD_TITLE = "%s 日 %s"
L_SWIM_REWARD_TITLE_WEEK = "轮应援奖励"
L_SWIM_SCHEDULE = {
	[1] = "早场",
	[2] = "晚场"
}
L_SWIM_VOTE_FAIL = {
	"已经参与过应援",
	"未在应援时间",
	"请选择所有队伍",
	"修改应援",
	"应援"
}
L_SWIM_VOTE_SUCC = "应援成功"
L_SWIM_END_TIME = "距应援结束 "
L_SWIM_START_TIME = "距应援开始 "
L_SWIM_RECORD_TITLE = "应援记录"
L_SWIM_START_TIME_2 = "距离开始："
L_TIME_TWO = "剩余时间："
L_ACTIVITY_TOTAL_RECHARGE = "继续充值%d元即可领取下一档奖励"
L_ACTIVITY_TOTAL_TWIST = "继续扩招%d次即可领取下一档奖励"
L_ACTIVITY_TOTAL_CONSUME_DIAMOND = "继续消耗%d魂晶即可领取下一档奖励"
L_ACTIVITY_TOTAL_CONSUME_GIFTCARD = "继续消耗%d礼品卡即可领取下一档奖励"
L_ACTIVITY_TOTAL_OPEN_BAG = "继续购买%d个新春福袋即可领取下一档奖励"
L_ACTIVITY_TOTAL_HAVE_SKIN = "继续获取%d个皮肤即可领取下一档奖励"
L_ACTIVITY_TOTAL_AWARD = "请领取已完成的奖励"
L_ACTIVITY_TOTAL_CONSUME_ROULETTE_KEYITEM = "继续消耗%d转盘币即可领取下一档奖励"
L_ACTIVITY_MARRY_LEVEL_2 = "级升级，可立刻解锁以下物资"
L_SWIM_TIME_END_VOTE = "当前已无比赛可应援"
L_TWIST_AGAIN_MAG = {
	title = "确认重新抽取",
	button = "确 认",
	des = "是否获取新的十次招生\n注意：会覆盖上次招生结果"
}
L_TWIST_GAIN_MAG = {
	titleNewImage = "public/title/title_operation_comfirm.png",
	button = "确 认",
	des = "是否确认本次招生结果为最终结果"
}
L_POPCARDBUFFLAYER = {
	shop_2 = "道具使用成功！",
	mail_tips = "回归奖励通过邮件发送",
	tips_privilege_1 = "特权挂机经验+",
	tips_privilege_2 = "特权挂机科技点收益+",
	title = "挂机效率加成详情",
	tips_2 = "挂机收益+",
	tips_privilege_3 = "特权挂机图灵新钞收益+",
	day = "%d日",
	shop_1 = "道具不足!",
	nobuff = "暂无加成",
	shop_3 = "道具使用失败！",
	tips_3 = "挂机收益+",
	class = "%(学籍加成)",
	tips_1 = "挂机收益+"
}
L_ROLE_TYPE_MAJOR = "學員"
L_ROLE_TYPE_HORCRUX = "魂器"
L_TWIST_EGG_ALL = "已抽光"
L_ROULETTE_PHASE = ""
L_ROULETTE_FREE = "首次免费"
L_ACTIVITY_ART_LBL_PLAYER = "个人贡献"
L_ACTIVITY_ART_LBL_DAILY = "今日剩余"
L_ACTIVITY_ART_LBL_DAILY_NIL = "无限制"
L_ACTIVITY_ART_LBL_CON = "贡献+"
L_ACTIVITY_ART_SEVER_PER = "全服贡献：%s"
L_ACTIVITY_ART_SEVER_1 = "全服贡献未达到！"
L_ACTIVITY_TO_START = "距开始"
L_ACTIVITY_NEED_CHOOSE = "请先选择画笔！"
L_ACTIVITY_ART_NOT_START = "开启时间：10月11日"
L_TVT_FIGHT_BTN_LOCK = "请先完成本场比赛！"
L_ACTIVITY_ART_CHOOSE = {
	"所需道具不足！",
	"绘制成功！",
	"已经完成绘制"
}
L_ACTIVITY_DRAW_RESULT = {
	"应援成功！",
	"当前已过应援时间",
	"使用道具不存在",
	"画笔不足",
	"该画笔超出今日使用限制"
}
L_ACTIVITY_RANK_LIST_RESULT = {
	nil,
	"应援结束后才能领取排行榜奖励！",
	"奖励已经领取",
	"未参与过活动，无法领取奖励"
}
L_ADVENTURE_INFINITE_LAYER = {
	noarray = "阵容信息错误",
	roleuptitle = "学员得分加成",
	noinfinite = "不是无限竞速模式",
	tips1 = "加成不可叠加",
	roleupscore = "当队伍中编入积分加成学员时，可以额外获得积分",
	tips2 = "以下学员分数提高%d"
}
L_ACTIVITY_ART_RANK = "排行奖励"
L_ACTIVITY_ART_RANK_DETAIL_1 = "10月23日排行计算阶段结束后，班长可根据自己所在的排名领取奖励~"
L_ACTIVITY_ART_RANK_DETAIL_2 = "活动结束后，将无获取途径，请及时领取哦！"
L_WATCH_REAWARD = "查看獎勵"
L_QIAN = "前"
L_INPUT_NEED_NUM = "请输入纯数字！"
L_INPUT_NEED_NUM_MAX = "单次最多使用1000"
L_EXPLORE_ERROR_NEW = {
	[0] = "活动探险未开放",
	nil,
	"活动已关闭!",
	"活动关卡已全部完成!",
	"已通关不能重复刷!",
	"关卡类型不是探险",
	"未到时间",
	"时间已过",
	"每日探险次数已用尽",
	"探险门票不足",
	"未解锁"
}
L_PRICE = {
	[1] = "原价%s元",
	[2] = "现价%s元"
}
L_ACTIVITY_SHOPITEM_NIL = "该礼包今日已无库存！"
L_RECHARGE_GET_SCORE = "立即获得%d积分"
L_RECHARGE_TOTAL_LACK = "累計储值金额未达到"
L_CHOOSE_RECHARGE_DES = "购买后可从下方选择1种道具"
L_CHOOSE_LAYER_DES = "·请在下方选择1种道具"
L_RANDOM_LAYER_DES = "·将在下方随机掉落1种道具"
L_MANKEY = "%d元"
L_STATEMENT = "点击查看“服务条款”及“隐私条款”, 登录即同意"
L_TWIST_UNLOCK_BUY_LIMIT = {
	"购买上限为100抽",
	"达到大学以上或历史充值达到6元，购买上限解锁到200抽",
	"达到研究生以上或历史充值达到100元，购买上限解锁到300抽",
	"达到研究生且干物妹支援等级达到30级，或者历史充值达到300元，购买上限解锁到400抽",
	"历史充值达到1000元，购买上限解锁到500抽",
	"历史充值达到1500元，购买上限解锁到600抽",
	"历史充值达到2000元，购买上限解锁到700抽",
	"历史充值达到2500元，购买上限解锁到800抽",
	"历史充值达到3000元，购买上限解锁到900抽"
}
L_ADVENTURER_RANDOMLAYER = {
	"结束时间:%d年%d月%d日%02d:%02d:%02d",
	"物资筹备",
	"元素搜集",
	"职业考核",
	"积分赛",
	"抢位赛",
	"团队赛",
	[70] = "芯片武装"
}
ACTIVITY_LEVEL_MAP = {
	UP_STRING = "提高",
	GET_REWARD = "领取奖励",
	SCORE_UP_TITLE_2 = "以下学员",
	STAR = "星",
	STAR_NUM_HAVE_GOT = "领取奖励",
	STAR_NUM_TOTAL = "累计获得",
	SCORE_UP_TITLE_1 = {
		"攻击力",
		"血量",
		"血量和攻击力"
	}
}
L_LAMIYA_CHAPTER = {
	activity_end = "活动已结束~",
	activity_no_open = "活动暂未开放哦，敬请期待~",
	no_new_chapter = "暂无新章节！",
	end_time = "灾难倒计时:"
}
L_UPGRAGDE_WEAPON = {
	NULL = "没有足够的万能魂武",
	FULL = "升星所需资源已经足够"
}
L_PT_PROCEED_AWARD_FAIL = {
	[3] = "已领取",
	[4] = "未达成"
}
L_TIMESIGN_TIME = "%d月%d至%d月%d日"
L_TIMESIGN_OPEN = "距离开启还有"
L_TIMESIGN_ONLINE_TIME = "在线%d分钟"
L_TIMESIGN_SUPPLEMENT = "消耗%d魂晶进行补签"
L_TIMESIGN_FREE_SERVICE = "福利:"
L_TODAY_BUY_LIMIT = "今日限购："
L_TOWEEK_BUY_LIMIT = "本周限购："
L_TOMONTH_BUY_LIMIT = "本月限购："
L_COLLECT_RANDOM_UN_ENOUGH = "没有足够的："
L_UNICERSAL_WORD = "万能麻将x"
L_WORD_COLLECT_TITLE = "使用确认"
L_WORD_COLLECT_DES = "现有麻将不足，是否消耗万能麻将%d个补足？"
L_BUY_ONE = "购买一次"
L_BUY_FIVE = "购买五次"
L_COLLECT_REDOM_UN_ONEN = "该功能将于%s年%s月%s日%s时开启!"
L_BOSS_UN_ONEN = "该功能将于%s年%s月%s日开启!"
L_SEND_GIFT = "送出"
L_ONE_LEFT_TIME_SPACE = "剩余时间: "
L_BOND_TIPS = {
	"伙伴组合缺少学员",
	"不满足激活羁绊的条件",
	"不满足升级羁绊的条件",
	STILL_LOCK = "尚未解锁",
	LEVEL = "可升级",
	NO_MATCH = "条件未满足",
	ACTIVE = "可激活",
	NO_MATCH_TO_JUMP = {
		"学员未全部激活，是否前往扩招?",
		"组合内成员未全部达到3振，是否跳转到扩招?",
		"组合内成员未全部达到5振，是否跳转到扩招?"
	},
	DETAIL_PANEL = {
		GOTO_BOND = "前往激活",
		TITLE = "伙伴效果"
	}
}
TOWER_ROLE_LIMIT = "可上阵:"
L_TOWER_DEFENCE_COST_ERROR = {
	nil,
	"关卡异常2",
	"关卡异常3",
	"关卡异常4",
	"关卡异常5",
	"魂晶不足",
	"必杀不足"
}
L_TOWER_DEFENCE_COST_LABElS = {
	title = "购买装备",
	button = "购买&使用",
	des = "消费%d" .. L_DIAMOND .. "购买装备"
}
L_TOWER_DEFENCE_SELECT_DES = "长按可查看角色"
L_TOWER_DEFENCE_FREE_XP_STR = "免费次数 ×"
L_TOWER_DEFENCE_SELECT_ERROR = "未选择任何学员"
L_TOWER_DEFENCE_SELECT_ERROR2 = "学员超过上限"
L_CONTENT = "负重 "
L_SELL_RESULT_LABEL = "出售后将获得以下物品"
L_ORDER_DESC = "每隔一段时间都会获取新订单请求，达到订单上限后将停止获取哦。"
L_ORDER_COUNT = "订单数量："
L_ORDER_REFSH_COUNT = "积压订单数量："
L_ORDER_DELETE_RESULT = {
	[1] = "取消订单成功！",
	[2] = "取消订单失败，订单无效！"
}
L_ORDRE_DELETE_DES = {
	DES = "确认取消该订单吗？",
	TITLE = "取消确认"
}
L_ORDRE_REFSH_DES = {
	SUCCESS = "兑换成功",
	TITLE = "刷新确认",
	DES = "确认消耗一个%s立刻补充一个订单吗？"
}
L_ORDER_REFSH_RESULT = {
	"刷新成功！",
	"订单足够不需刷新！",
	"订单刷新所需道具不足！"
}
L_PATROLING = "驻守中:"
L_SELL_RESULT_LABEL = "出售后将获得以下物品"
L_ACTIVITY_QUESTION_END = "答题活动已结束。"
L_FOOL_RECHARGE = "班长本次活动期间暂未充值,是否前往充值？"
L_TVT_ADD = "本次"
L_TVT_GO_BUG = "魂晶不足，点击前往购买！"
L_USE_ONE = "使用一次"
L_USE_FIVE = "使用五次"
L_RE_SHOWGRIL = "恢复"
L_SELL_RESULT_LABEL = "出售后将获得以下物品"
L_ACTIVITY_LEVEL_BUFF = "凭证获得+200/每人"
L_ACTIVITY_LEVEL_NUM = "每日次数："
L_COST_POWER = "消耗电量"
L_BOSS_SKILL = "领主技能"
L_EXPLORE_OFFER_LIMIT = "关卡限制"
L_OFFER_SEARCH = "搜索中:"
L_OFFER_READY = "库存:"
L_OFFER_CONDITION_ERROE1 = "上阵学员有非限制元素"
L_OFFER_CONDITION_ERROE2 = "上阵学员必须有限定学员"
L_OFFER_CANCEL_TBL = {
	title = "是否放弃",
	button = "确认放弃",
	des = "是否放弃本次悬赏令"
}
L_ACTIVITY_ADV_1 = "首次通关不消耗次数"
L_ACTIVITY_ADV_2 = "确认消耗%d魂晶并兑换次数吗？"
L_ACTIVITY_ADV_3 = "今日购买次数已到达上限！"
L_ACTIVITY_ADV_4 = "当前可用次数已满!"
L_RE_SHOWGRIL = "恢复"
L_TODAY = "今天"
L_USE_CLOTHES_ONE_KEY = "确认角色界面、宿舍、看板娘选择界面都更换为该皮肤"
L_USE_CLOTHES_ONE_KEY1 = "更换成功！"
L_USE_CLOTHES_ONE_KEY2 = "更换失败，未解锁相应魂姬！"
L_ACTIVITY_STUDY_1 = "已达成："
L_ACTIVITY_STUDY_2 = "未达成："
L_ACTIVITY_STUDY = {
	"请先完成前置条件！",
	nil,
	"完成所有任务才能获取学员！",
	nil,
	nil,
	"完成所有任务才能获取学员卡！"
}
L_DO_ACTIVITY_STUDY = {
	"任务完成！",
	"没有学员正在研究！",
	"该任务已经完成!",
	"道具数量不足!",
	"该任务索引不存在!"
}
L_CHANGE_ACTIVITY_STUDY = {
	"变更成功！",
	"该角色入学研修未解锁!",
	"时间限制还未结束!",
	"切换学员功能冷却中!",
	"该角色已研究完成!",
	nil,
	"已完成全部研修!",
	"前置需求未达成!"
}
L_FINISH_ACTIVITY_STUDY = {
	[2] = "没有角色在研究!",
	[3] = "对应任务未全部完成!"
}
L_USE_CLOTHES_ONE_KEY2 = "更换失败，未解锁相应魂姬！"
L_USE_CLOTHES_ONE_KEY3 = "不能更换相同的皮肤！"
L_ACTIVITY_ADV_4 = "当前可用次数已满!"
L_RE_SHOWGRIL = "恢复"
L_TODAY = "今天"
L_STABLESCORE = "以下学员代币数量加成与共振数量成正比"
L_ACTIVITY_POINT = "活动积分："
L_WORD_COLLECT_SURE_DETAIL_1 = "确认消耗%s购买吗？"
L_ADVANCE_POP = {
	DAMAGE_STR = "攻击资质",
	TITLE2 = "消耗材料",
	HP_STR = "其他资质",
	TITLE1 = "属性变化"
}
L_SERVANT_ADVANCE_ERROR = {
	nil,
	"共振未满级",
	"稀有度已满级",
	"数据异常",
	"材料不足"
}
L_BUCUNZAI = "奖励不存在"
L_CV = "声优/"
L_ROULETTE_NUM = "已抽取%s次"
L_LOL_SHARE_TASK_DES = "%s(%d/%d)"
L_JUMP_TO = "前往完成"
L_LOL_SHARE_NOT_ENOUGH = "该礼盒有效点击未达目标"
L_SHARE_TITLE_2022 = "魂器学院元旦宝箱，百分百中奖"
L_SHARE_DESC_2022 = "点击即可抽取扭蛋券、翻盘道具等珍贵道具，领取戳我: "
L_QINGXUANZE = "请选择要领取的奖励"
L_BATTTLEPASS_ITEM_ZERO = "等级继承道具数量为零"
L_COPY_TO_CLIPBOARD = "一键复制"
L_ROULETTE_EMPTY = "当前转盘已抽空"
L_TESTFIGHT_RESULT = {
	[2] = "该学员已在试用队伍中！"
}
L_UNLOCK_SCHOOL_STUDY_DES = "研修室需要独特学员(%d/8),超凡学员(%d/6)"
L_GUIDE_MAIN_DEBUG = {
	[-3] = "评论引导：未通过关卡1-10",
	[-1] = "评论引导：已经触发过，并没有点击下次再说",
	[-2] = "评论引导：点了下次再说，但没到时间"
}
L_DAILY_WEEKLY_REFRESH = "刷新"
L_DAILY_WEEKLY_REFRESH_DES = "是否进行刷新（今日剩余%s次）"
L_DAILY_WEEKLY_BOX_ACTIVE_NUM_TIPS = "还需%d活跃度可以领取"
L_ALL_TIME = "福利"
L_NET_ERROR = "网络故障！请刷新界面后重试！"
L_BP_SIGN = {
	"提前签到",
	"是否消耗%d魂晶,提前签到",
	"确认签到",
	"补签",
	"是否补签",
	"确认补签",
	"班长要一天一天来懊~"
}
GUIDEPHONELAYER_CONSTANTS = {
	[1] = "一本记录了学院内各种事项的神秘笔记，对新入学的班长可能会有帮助"
}
L_MANAGE_MONEY_INVEST = {
	nil,
	"参数错误！",
	"投资时间已过~",
	"班长资金不够哦~",
	"班长资金不够哦~"
}
L_MANAGE_MONEY_GET_REWARD = {
	nil,
	"参数错误！",
	"班长未进行过该投资~",
	"班长已经领取过该投资啦~",
	"次日可领取哦~~"
}
L_MANAGE_MONEY_LOCK = "后解锁"
L_TWIST_RETURN_GET_REWARD = {
	[2] = "参数错误！",
	[3] = "班长已经领取过今日返还~"
}
L_MONOPOLY = {
	"图灵新钞",
	"魂晶",
	"增益",
	"减益",
	"战斗胜利，从对手处获得了",
	"战斗失败，支付给对手",
	"对手获得了",
	"对手失去了",
	"对手花费了%s图灵新钞，将城堡升到%s级。",
	"花费了%s%s，将城堡升到%s级。",
	"对手来到我们所在的场地，抢夺我们",
	"来到对手当前所在的场地，成功抢夺",
	"来到了对手的城堡领地，支付",
	"对手来到了我们的城堡领地，支付",
	"对手的一个城堡等级提高了。",
	"一个城堡等级提高了。",
	"对手的一个城堡等级降低了。",
	"一个城堡等级降低了。",
	"获得了%s%s效果",
	"来到了奖励格，获得道具。",
	"当前需要处理事件",
	"该关卡将在",
	"开启",
	"本次投掷事件列表",
	"操作过快",
	"不存在",
	"类型",
	"当前玩家金币为",
	"剩余时间:%s天%s小时",
	"第%s关",
	"第1关",
	"普通建筑",
	"级城堡",
	"等级已达上限",
	"高级建筑",
	"高等",
	"先选择要投掷的数字",
	"剩余时间: 0天0小时",
	"第%s关开启自动投骰",
	"前进%s步",
	"修建资金不足,可参与其它活动获得资金",
	"对手在城堡中翻找，得到了%s图灵新钞",
	"一阵大风吹来，吹走了对手%s图灵新钞",
	"对手花费了%s图灵新钞，将城堡升到%s级。",
	"花费了%s图灵新钞，将城堡升到%s级。",
	"花费了%s魂晶，将城堡升到%s级。",
	"对手来到我们所在的场地，失去了%s图灵新钞",
	"来到对手当前所在的场地，成功抢夺%s图灵新钞",
	"来到了对手的城堡领地，支付%s图灵新钞。",
	"对手来到了我们的城堡领地，支付%s图灵新钞。",
	"对手呼朋引伴，帮忙修建，对手的一个城堡等级提高一级。",
	"好运来临，城堡周围的人帮我们进行修建，一个城堡等级提高一级。",
	"狂风来临，袭击了对方的城堡，一个城堡等级降低一级。",
	"狂风来临，袭击了我们的城堡，一个城堡等级降低一级。",
	"符仪灵光一闪，得到增益效果",
	"符仪感到一阵困惑，得到减益效果",
	"移除Buff",
	"个",
	"从天而降一份礼物，获得了",
	"大富翁胜利了，从对手处得到%s图灵新钞。",
	"大富翁失败了，给予对手%s图灵新钞。"
}
L_AUTO_CHESS = {
	restart = "x%d 刷新",
	noservant = "班长请先进行招募！",
	selectmoney = "所需货币不足！",
	content = "共振:",
	maxUpStar = "%d振学员最多升星至%d星",
	selectSucc = "招募成功！",
	upstarsucc = "升星成功！",
	maxstar = "当前已经是最高星级",
	cantUpStar = "所需学员数量不足"
}
L_QUICKFORMATIONLAYER = {
	"队伍%s",
	"扩展队伍",
	"全队天赋相同时获得加成",
	"出战学员固定",
	"点击下阵",
	"必须保留一名学员",
	"无法重复上阵",
	"%s号位",
	"属性",
	"筛选",
	"确认编队",
	"提示",
	"确认",
	"        是否还原最初编队?",
	"请选择上阵位置",
	"学员未解锁",
	"助战中",
	"助战队伍中",
	ALL = "全部",
	OTHER = "其他",
	INDEX = {
		"1st",
		"2nd",
		"3th",
		"4th",
		"5th"
	},
	MAPTEXT = {
		mimicry = "拟态",
		fire = "热能",
		positive = "正能量",
		null = "电磁",
		water = "量子",
		light = "光能",
		dark = "暗物质",
		imaginary = "虚数",
		zerosupperession = "异构",
		wind = "电磁",
		other = "其它",
		devil = "反物质"
	}
}
L_HELP_BATTLE = {
	"战士",
	"射手",
	"法师",
	"坦克",
	"刺客",
	"辅助",
	[127] = "等级达到%d",
	[131] = "一键助战成功",
	[120] = "前往更改",
	[130] = "助战人数已满",
	[100] = "编队",
	[129] = "处于编队中",
	[128] = "%s开启",
	[101] = "攻击力",
	[121] = "配置错误",
	[102] = "血量",
	[103] = "双防",
	[133] = "助战已满",
	[126] = "未解锁",
	[125] = "通关%s",
	[124] = "暂未开放",
	[123] = "学员未解锁",
	[122] = "类型错误",
	[132] = "助战学员职业不符合"
}
L_HELP_BATTLE_FORMATION = {
	"解锁需通关",
	"%s特殊加成",
	"攻击力",
	"血量",
	"防御",
	"能量防御",
	"治疗量",
	"助战学员固定",
	"上阵人数已满",
	"编队中"
}
L_BASE_FORMATION = {
	"战斗队伍",
	"助战编队",
	"助战学员将提供攻击与血量加成",
	"编辑队伍",
	"队伍战力:",
	"队伍",
	"确认派出",
	"扩展队伍",
	"全队天赋相同时获得加成",
	"没有更多符合的学员, 是否前往扭蛋?",
	"暂时没有符合条件的装备啦~",
	"与先遣阵容相同，无需更换",
	"确认派出"
}
L_URBANDEFENSE = {
	"活动未开始",
	"当前城市不可守护",
	"当前城市已完成守护",
	"失败，上阵学员有误",
	"失败，战斗token错误",
	"驻守中，暂时无法上阵",
	"当前城市未受到攻击，无法支援",
	"已完成支援，正在驻守中"
}
L_POPCONTRACTATTRDETAILLAYER = {
	"共振点系统说明",
	"获取途径",
	"超凡",
	"独特",
	"学员",
	"◆解锁新学员可获得1共振点",
	"◆学员超频可获得2共振点",
	"◆1、2、3、4、5振，每次共振可获得1共振点",
	"普通",
	"精英",
	"学员",
	"◆跃迁至超凡后适用上述规则",
	"◆每1共振点提供     %攻击&血量加成",
	"◆5个学员等级达到         ，将使用协调等级同步格子里学员的等级，每获得20点共振点提升5等级上限，目前最高等级上限为400级",
	"300级后",
	"0.15",
	"效果说明",
	"当前点数",
	"当前等级上限",
	"当前加成"
}
L_FALSE_LEVEL = "低等级学员将提升至300级"
L_RETURN_BUFF = "学员攻击力&血量提高30%"
L_BOUGHT = "已购买"
L_RECHARGE_BOUGHT_LOCK = "购买前置礼包后方可解锁该礼包"
L_OFFLINE_LEVEL = "离线时间:%s"
L_OFFLINE_TIME = "当前关卡:%s"
L_UNLOCK_DAY = "%s天后解锁"
L_ONLINE_TIME = "今日在线时长:%s分钟"
L_FLOP_NEXT_TURN = {
	title = "前往确认",
	button = "确 定",
	des = "进入下层将无法返回,确认前往吗"
}
L_ACTIVITY_GARRISON = {
	"未解锁",
	"等级达到%d后解锁",
	"待驻守",
	"倒计时",
	"已完成",
	"驻守点%d",
	"驻守时间: %s",
	"奖励加成+%d%%",
	"未获得",
	"指定学员",
	"无法更换指定学员",
	"暂未拥有该学员",
	"暂未解锁,请提升派遣等级",
	"%s级解锁",
	"确认取消当前驻守的学员吗？",
	"撤退",
	"该学员驻守中",
	"驻守中",
	"经验: %d/%d",
	"完成当前页面所有任务可以升级驻守等级。<div fontcolor=#fffc5c></div><div fontcolor=#fffc5c></div>当前驻守等级可以<div fontcolor=#fffc5c>上阵%d名</div>学员提升驻守等级可以提高上限哦。",
	"完成",
	"%d/%d",
	"经验值",
	"任务已完成",
	"剩余时间: %s"
}
L_HORCRUX_DEVOUR = {
	"魂器装备",
	"学员达到<span style=color: rgb(255,0,0);>%d级</span>解锁",
	"尚未聚合",
	"当前技能",
	"可聚合技能",
	"请先选择魂器",
	"聚合魂器",
	"需要先选择第一个被吞噬的魂器",
	"魂器处于锁定或装备状态中",
	"星级需不小于%d星,等级需不小于%d级",
	"请先选择需要吞噬的魂器",
	"吞噬需要消耗的材料不足",
	"聚合成功",
	"%s",
	"%s",
	"基础属性提升",
	"技能提升",
	"替换魂器",
	"新增魂器",
	nil,
	nil,
	"学员不存在",
	"魂器不存在",
	"魂器锁定",
	"配置错误",
	"魂器等级或者星级不满足要求",
	"材料不足",
	"有新技能未二次确认",
	"魂器属性和学员属性不匹配",
	"失败，指定的魂器位置未解锁",
	"异构学员吞噬限制",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"生命",
	"攻击",
	"额外消耗",
	"确认聚合",
	"取消聚合",
	"使用 [%d星] 及以上魂器获取技能",
	"暂未解锁",
	"技能聚合",
	"技能顶替",
	"卸下确认",
	"是否确定卸下魂器？卸下后的魂器可在魂器仓库查看。",
	"推荐:",
	"取消聚合不会消耗提供技能的魂器。",
	"不存在需要二次确认的技能",
	"Server Error",
	"魂器信息错误",
	"魂器属性提升翻倍"
}
L_JUMP_TOWER_RESET_DES = {
	des = "确认购买并重置? 本次花费%s魂晶。",
	title = "购买确认"
}
L_AFKLEVEL_LAYER = {
	lock_1 = "提前解锁消耗",
	xietiao = "协调等级",
	lock = "解锁需通关",
	time_lock = "未到解锁时间",
	lock_2 = "解锁消耗"
}
L_AFKLEVEL_LEVELUP_RESULT = {
	nil,
	"当前不能升级, 请刷新界面!",
	"已达当前最大等级限制!",
	"材料不足!",
	"总共振等级不足!"
}
L_AFKLEVEL_LEVELUP_DO = {
	des = "确认消耗材料，提升至下一等级？",
	title = "升级确认"
}
L_AFKLEVEL_SERVANT_UP = {
	nil,
	"该栏位未解锁!",
	"该栏位已有学员!",
	"并未获得该学员!",
	"该栏位冷却中!",
	"该学员已在其他栏位!"
}
L_AFKLEVEL_SERVANT_DOWN = {
	nil,
	"该栏位未解锁!",
	"该栏位还没有学员!",
	"消耗所需钻石不足!",
	"该学员正在驻守挂机中!"
}
L_AFKLEVEL_SERVANT_DOWN_DO = {
	des = "确认消耗%d魂晶，下阵学员？",
	title = "下阵确认"
}
L_AFKLEVEL_CLEAR_CD_REWULT = {
	nil,
	"该栏位未解锁!",
	"该栏位还没有进入冷却!",
	"消耗所需钻石不足!"
}
L_AFKLEVEL_CLEAR_CD_DO = {
	des = "确认消耗%d魂晶，清除上阵冷却？",
	title = "清除确认"
}
L_AFKLEVEL_UNLOCK_SLOT_DO = {
	des = "确认消耗%d魂晶，提前解下一栏位？",
	title = "提前解锁确认"
}
L_AFKLEVEL_UNLOCK_SLOT_REWULT = {
	[2] = "全部栏位已解锁!",
	[3] = "消耗所需钻石不足!"
}
L_WAKEFUND_GET_FREE_REWARDS = "领取福利"
L_SURPLUS_LEVEL = "还剩%s关"
L_WEEK_OPEN = "每周%s开放"
L_FAILED_UNLOCKED = "失败，已经解锁"
L_ADVANTURE_UP_DROP = "%s倍掉落"
L_RESET_SOUL_IN_AFK = "该学员正在协调等级中，请先停止协调!"
L_SCHOOL_STUDY_GO = {
	title = "学员不足",
	button = "确 定",
	des = "当前同元素学员不足，是否前往扩招？"
}
L_HORCRUX_NFO_GO = {
	title = "魂器不足",
	button = "确 定",
	des = "魂器数量不足，是否前往扩招？"
}
L_UNLOCK_ACTIVITY = {
	"您还未获得",
	"请前往活动中获取哟"
}
L_ACTIVITY_BOSS_FIGHT_LOCK = "当前关卡正在驻守中!"
L_ACTIVITY_BOSS_FIGHT_FO = "阵容不能为空!"
L_TWISTEGG_CHANGE = {
	"主题切换",
	"元素切换"
}
L_FIGHT_RESULT_BUTTON = {
	"前往下一层"
}
L_UNLOCK_PLOT = "剧情未解锁"
L_FAILED_PLOT = "观看剧情失败"
L_FAVOR_EVENT = {
	"等级",
	"好感度等级.",
	"解锁",
	"宿舍旅行事件解锁",
	"学员好感度%d级解锁"
}
L_FIGHTLAYER = {
	"波数 %d/%d",
	"通关M-N领取",
	"还剩X关"
}
L_HORCRUX_MANAGER = {
	"材料魂器已被锁定，操作无效",
	"材料魂器处于编队中，操作无效",
	"材料魂器处于抢位赛编队中，操作无效"
}
L_GRILSELECTLAYER = {
	"未选中任何学员",
	"未解锁"
}
L_EQUIPLAYER = {
	"卸下芯片",
	"卸下已聚合芯片将会使聚合效果消失，是否更换",
	"更换芯片",
	"更换已聚合芯片将会使聚合效果消失，是否更换",
	"暂时没有获取该角色的途径",
	"等级.",
	"超快",
	"快",
	"标准",
	"常\n态",
	"超\n频"
}
L_HORCRUXSELECTLAYER = {
	"您当前选择的魂器已被其他角色装备\n是否进行更换",
	"替换",
	"未装备",
	"未选择"
}
L_RESIDENTLAYER = {
	"后勤支援",
	"幸运翻牌",
	"幸运转盘"
}
L_LINKLAYER = {
	"剩余次数：%d/1(每周一0点恢复)",
	"班长是否消耗次数开启该活动30天？",
	"活动开启次数不足!",
	"活动开启成功!",
	"失败，点数不足!",
	"失败，活动不存在!",
	"活动已经开启，不需重复开启!",
	"活动尚未开启哦"
}
L_TWISTLAYER = {
	"限定扩招",
	"确   认",
	"常规",
	"本次切换将消耗：",
	"所需消耗道具不足,将额外使用:",
	"\n钻石*",
	"%s确认",
	"已抽光"
}
L_TWISTLAYER_WORDS = {
	"单抽",
	"二连",
	"三连",
	"四连",
	"五连",
	"六连",
	"七连",
	"八连",
	"九连",
	"十连"
}
L_TWISTMANAGER = {
	"失败，不能自选up",
	"钻石不足",
	"失败，当前up不可用"
}
L_TWIST_LEVEL = {
	"独特",
	"精英",
	"超凡",
	"普通",
	"概率提升",
	"独特学员",
	"超凡学员",
	"精英学员",
	"普通学员",
	"独特魂器",
	"超凡魂器",
	"精英魂器",
	"普通魂器",
	"服装",
	"礼物",
	"家具",
	"科研材料",
	"魂武核心",
	"魂器碎片",
	"科研补给箱",
	"特殊道具",
	"(概率提升)",
	"(正常概率)"
}
L_RETURNMANAGER = {
	"已经绑定召回码",
	"召回码错误，请重新输入",
	"今日已领取",
	"已过期"
}
L_AIATTACK = {
	"上阵次数已用完",
	"怪物已用完",
	"人口不足"
}
L_BIRTHDAY = {
	"大弹幕道具不足",
	"小弹幕道具不足",
	"道具使用出错",
	"还没有到%s的生日哦！",
	"已经祝贺过%s啦！"
}
L_BONDMGR = {
	"找不到羁绊组",
	"该档位已激活",
	"激活条件不满足"
}
L_COMPONENT = {
	"经验不足",
	"未装备3个零件",
	"3个零件的品质不同",
	"芯片品质为橙色以下",
	"所有零件不为同一个套装",
	"已聚合",
	"经验不足",
	"狗粮芯片使用中",
	"狗粮芯片被锁定"
}
L_CORE_MGR = {
	"科技点不足",
	"请先激活魂武",
	"魂武升级金币不足",
	"没有需要强化的芯片",
	"芯片强化金币不足",
	"魂姬等级不能大于班长等级",
	"突破消耗的所需金币不足",
	"角色等级已满级",
	"魂武已满级",
	"芯片已达当前等级上限"
}
L_DAILY_WEEKLY_MGR = {
	"剩余刷新次数不足",
	"任务不存在或已失效"
}
L_EXP_MGR = {
	"skillid 为空!!!",
	"模式不合法",
	"选择的房间索引不合法",
	"已经通关",
	"当前类型不对，不能选关",
	"模式不合法",
	"关卡不合法",
	"战斗结果不合法",
	"战斗编队不合法",
	"已没有可参战的学员，请重置",
	"触发事件不合法",
	"重复触发",
	"可供招募学员不足",
	"学员不可选",
	"上场人数已达上限"
}
L_EXPLORE_MGR = {
	"没有可领取的悬赏令",
	"可持有队列已满",
	"魂晶不足"
}
L_FRIEND_MGR = {
	"参数错误",
	"暂无宿舍可以访问"
}
L_GOTO_SYS_MGR = {
	"该跳转id已经弃用！",
	"这个id未在SYSTEMID定义"
}
L_INF_FIGHT_MGR = {
	"当前关卡不能扫荡",
	"挑战次数不足",
	"扫荡卷不足",
	"章节未通关",
	"需要订阅特权"
}
L_INVITE_MGR = {
	"先输入其他玩家邀请码才可以绑定哦~",
	"不能绑定自己的邀请码哦~",
	"已经绑定邀请码",
	"该玩家绑定数已达上限，请绑定其他玩家吧~",
	"邀请码有误，请重新输入！"
}
L_ITEM_MGR = {
	"服务端物品表没有:",
	"服务端物品类型不对,应该为33",
	"物品:",
	"没填choosegift_group",
	"的choosegift_group在choosegift_data找不到",
	"choosegift_data中找不到dropid_",
	"choosegift_data的dropid_",
	"在掉落表里找不到"
}
L_NOVICE_MGR = {
	"今日已领取",
	"已过期"
}
L_PATROL_MGR = {
	"没有奖励可以领取",
	"没有可派遣的队伍，请班长仔细检查人员配置",
	"已成功派遣队伍驻守",
	"没有可派遣的队伍，请班长仔细检查人员配置"
}
L_SHOP_MGR = {
	"配置错误"
}
ACTIVITY_SURVEY = {
	des = "完成填写问卷%d，即可获得奖励。"
}
L_OFFLINE_TIME_DES1 = "离线收益"
L_GAMEBACKLAYER = {
	[1] = "输入召回码领取额外奖励"
}
L_GO_NEXT_LEVEL = "前往下一关"
L_GO_NEXT_CHAPTER = "前往下一章"
L_FIGHT_AGAIN = "再次挑战"
L_SCORE_AREAN_CUR_GIFT = "当前排位奖励"
L_SCORE_AREAN_CUR_COUNT = "今日次数: "
L_SCORE_AREAN_MINE_ARRAY = "我方阵容"
L_FORMATIONMAINLAYER = {
	"确认派出",
	"开启挂机",
	"（当前队伍状态：挂机中）",
	"（当前队伍状态：空闲中）"
}
L_SOULSTRENGTHLAYER = {
	"学员强化",
	"等级.+1",
	"等级.+",
	"升学",
	"共振点不足",
	"等级：",
	"战力:",
	"等级.+10",
	"等级.+1",
	"突破：",
	"魂武：",
	"学员重置"
}
L_GLOBALFUNC = {
	"%d.%02d万",
	"%d.%d万",
	"%d万",
	"%d.%02d亿",
	"%d.%d亿",
	"%d亿"
}
L_PROFALL = {
	[1] = "概率掉落"
}
L_SIGNLAYER_LESS = "剩余%d天"
L_SIGNLAYER_LOCK = "未激活"
L_TWISTRESUTL = {
	[1] = "继续抽取",
	[2] = "剩余重抽次数:"
}
L_SIGNLAYER_LOCK = "未激活"
INVITE_INFO = "邀请小伙伴，分享自己的邀请码，\n小伙伴成功登录进入游戏并输入你的邀请码后，两者形成绑定关系。\n双方完成任务，即可领取奖励。\n最多同时绑定8名班长，绑定关系可主动解除。"
L_INVITE_MYMA = "我的邀请码："
L_INVITE_HAS_IN = "已邀请%d人"
L_INVITE_1 = "输入其他班长的邀请码就可以获得奖励啦"
L_INVITE_BIND_UID_RES = {
	"绑定成功",
	"已经绑定邀请码",
	"邀请码绑定到达上限",
	"输入的邀请码不正确",
	"等级已超过绑定限制",
	"只能绑定同服玩家"
}
L_INVITE_ONBTNSTATUS = {
	"请先绑定邀请码",
	"班长还未完成该任务哦",
	"邀请系统已刷新",
	"我的召回码：",
	"已绑定邀请码：",
	"当前输入邀请码：",
	"班长升学至初中后可生成召回码哦",
	"班长升学至初中后可生成邀请码哦",
	"已复制召回码到剪切板",
	"已复制邀请码到剪切板",
	"邀请码格式错误",
	"不能绑定自己的邀请码"
}
L_NOVICE_AWARD = {
	"累计充值",
	"元即可领取奖励",
	"继续充值",
	"元即可领取下一档奖励"
}
L_SETTING_LAYER = {
	"背景音乐",
	"游戏音效",
	"角色配音",
	"主城学员不可移动",
	"大招插入立绘",
	"屏蔽礼物特效",
	"个性化消息推送",
	"新活动",
	"离线收益",
	"驻守挂机",
	"科研项目",
	"兑换码：",
	"兑换",
	"live2d资源下载",
	"BUG反馈",
	"客服中心"
}
L_MIDAS_DES = {
	"今日剩余挖矿次数"
}
TOP_PLOT_LIST = {
	"当前有一个或多个任务已完成待领取",
	"完成所有升学任务即可升学",
	"完成所有升学任务的班长可以获得解锁奖励和新等级上限哦",
	"剩余刷新：",
	"完成所有升学任务的班长可以获得解锁奖励和新等级上限以及挂机收益加成哦"
}
L_TWISTBUBBLE = "%的班长已经抽取"
L_TWISTTIMES = {
	"还剩",
	"抽领奖",
	"奖励已抽完"
}
L_POPCOURSELAYER = {
	"该课程以学习完毕",
	"所需学员不足，是否前往扩充",
	"前置课程未满级",
	"玩家等级不足，是否前往主线",
	"该课程未升级",
	"将重置当前课程进度并返还所有课程消耗",
	"配置错误",
	"不能同时升级多个副课程",
	"解锁条件不满足",
	"已升到满级",
	"升级所需物品不足",
	"重置课程所需魂晶数量不足",
	"需要先重置后置课程"
}
L_COURSEMGR = {
	"%s达到%d级(",
	"拥有%d名学员(",
	"拥有%d名%s元素学员(",
	"班长等级达到%d级("
}
L_GO = "前往"
L_MAX_SCORE = "最高得分:"
L_PVP_TEST_FIGHT = "竞技模拟"
L_PVE_TEST_FIGHT = "人机模拟"
L_AFKLAYER = {
	"等级",
	"排名第五",
	"的学员决定列表中学员的等级"
}
L_LABLINELAYER = {
	[1] = "制作时间",
	[2] = "加工车间"
}
L_PVE_TEST_FIGHT = "人机模拟"
L_PIECE = "%s件"
L_COSTUME_ROOM_TASK = "皮肤数量不足,是否前往皮肤商店购买?"
L_COSTUME_ROOM_SELECT = {
	"全部学员",
	"已拥有学员",
	"未拥有学员",
	"全部皮肤",
	"已拥有皮肤",
	"未拥有皮肤",
	"异格"
}
L_CAN_BREAKOUT = "可共振"
L_TASK_INFO = "任务进度："
L_TASK_ALL_COM = "所有任务已完成"
L_BREAKOUT_DO_DES = "魂器碎片不足，请使用共轭碎片补足"
L_GONGESUIPIAN = "共轭碎片:"
L_HORCRUX_CANT_STAR = "魂器无法升星"
L_HORCRUX_QUES = "所选魂器包含稀有品质魂器，是否执行该操作？"
L_HAVE_CHOOSE = "已选中"
L_ADVENTURER_RANDOMLAYER[8] = "剩余挑战次数"
L_ADVENTURER_RANDOMLAYER[9] = "已持有"
L_ADVENTURER_RANDOMLAYER[10] = "待领取"
L_ADVENTURER_RANDOMLAYER[11] = "剧情  "
L_ADVENTURER_RANDOMLAYER[12] = "距离重置："
L_ADVENTURER_RANDOMLAYER[13] = "玩法说明"
L_SPECIAL_JUMP_TOWER = "下次重置："
L_FREE_REFARSH = "首次免费刷新"
L_EXPLORE_OFFER_POP = {
	"并重新获得一个",
	"级任务",
	"等级提升中"
}
L_SCORE_AREAM_DETAIL_1 = "积分赛刷新\n\n①每日0、12、18点各增加一次刷新次数（最大存储2次），每次刷新6名对手。\n②每周六积分赛重置后，会自动刷新一次对手。本周积分赛结束后将清除未消耗的刷新次数。\n③每日可使用魂晶购买3次刷新机会。\n\n挑战\n\n①单场比赛内不限制挑战次数，班长可以无限次挑战直到战胜对手\n②挑战胜利后，该对手不可再次挑战，同时可以获得相应的竞赛积分\n③挑战失败无法获得任何积分\n\n奖励\n\n①每日拥有3个累计胜利宝箱，当达到相应的胜利次数时即可领取，每天0点重置\n\n竞赛积分\n\n①竞赛积分是积分赛排名的参照，并划分段位\n②积分越高，排名越高，相同积分的根据到达该积分的时间顺序排名\n"
L_SCORE_AREAM_DETAIL_2 = "段位奖励：\n\n①每周六2:00根据当天0点排名进行奖励结算，届时将通过邮件发放奖励。实际到账时间可能有所延迟。\n②段位奖励如下:\n"
L_SCORE_AREAM_DETAIL_3 = {
	"肝帝组       奖励：    420     1000",
	"学霸组       奖励：    360      800",
	"精英组       奖励：    300      600",
	"菜鸟组       奖励：    240      400",
	"萌新组       奖励：    180      200"
}
L_SCORE_AREAM_DETAIL_4 = "积分组别"
L_SCORE_AREAM_DETAIL_5 = {
	"肝帝组           ",
	"学霸组           ",
	"精英组           ",
	"菜鸟组           ",
	"萌新组           "
}
L_SCORE_AREAM_DETAIL_6 = {
	"积分: 大于2500",
	"积分：1251-2500",
	"积分：601-1250",
	"积分：351-600",
	"积分：200-350"
}
L_POPACTDETAIL = {
	"天赋组队效果",
	"已激活",
	"所有效果",
	"没填</p>"
}
L_POPSHOWAEA = {
	[1] = "敌方战力:",
	[2] = "出战阵容角色为空~"
}
L_RESET = {
	"将重置当前所有已学课程并返还所有课程消耗",
	"重置",
	"将重置整个远征系统，是否重置？",
	"将重置整个系统，是否重置？",
	nil,
	"此操作将重置掉上一次保存之前的所有内容，是否重置？"
}
L_SCORE_AREAN_DES = {
	"本期结束时间",
	"每日胜场奖励：",
	"对战胜场：",
	"每日0，12，18点增加一次刷新次数",
	"刷新次数:"
}
L_TFT_TEAM_TIPS = {
	{
		subname1 = "",
		name = ""
	},
	{
		subname1 = "进攻阵容",
		name = "抢位赛"
	},
	{
		subname1 = "前锋队",
		name = "团体赛",
		subname2 = "近卫队",
		subname3 = "压阵队"
	},
	{
		subname1 = "队伍一",
		name = "超频战场",
		subname2 = "队伍二",
		subname5 = "队伍五",
		subname3 = "队伍三",
		subname4 = "队伍四"
	}
}
L_FRIEND_BRIEF_INDEX = {
	"等级",
	"年级",
	"社团名称"
}
L_FRIEND_RECORDS_INDEX = {
	"积分赛",
	"抢位赛",
	"关卡",
	"学员"
}
L_FRIEND_RECORDS_INDEX = {
	"抢位赛",
	"防守阵容",
	"团体赛",
	"前锋队",
	"近卫队",
	"压阵队",
	"超频战场",
	"队伍一",
	"队伍二",
	"队伍三",
	"队伍四",
	"队伍五"
}
L_EXPEDITION_LAYER = {
	"暂未招募任何学员",
	"暂未获得任何技能",
	"花费【远征物资】X%d购买%s",
	"物资不足",
	"远征物资：",
	"重置",
	"将重置整个远征系统，是否重置？",
	"当前：",
	"休息",
	"重装",
	"技能名字",
	"技能描述",
	"前往",
	"招募学员数不足",
	"请选择一个技能"
}
L_EXPEDITION_SELECT = {
	"可上阵已满",
	"对决"
}
L_TOWER_LIST = {
	"费用:",
	"未在战斗中",
	"大招释放时机未到",
	"角色未死亡",
	"费用不够",
	"已达上限",
	"未选中角色"
}
L_BIANHUA_CHAPTERNAME = {
	"序章",
	"彼岸花初现",
	"饿狼的邀约",
	"各自的选择",
	"尾\n声"
}
L_BIANHUA_STORY = {
	"特别篇"
}
L_ACTIVITY_SIGN_FML = "次日登录领取丰厚奖励"
L_TWISTEGG_COST_TICKET = "当前扭蛋券不足，是否消耗下方替代材料进行抽取"
L_FALLINGLAYER = {
	"分数",
	"没有jumpgame_conf_data",
	"历史最大记录",
	"当前得分",
	"最高记录：",
	"重新开始",
	"退出",
	"继续",
	"失败，已经领取过奖励",
	"失败，积分不足"
}
L_LEVEL = "关"
L_SKIN_GO_GAIN = {
	recharge = "礼包购买",
	shop = "商城购买"
}
L_LIULI_SIGN = "进入演唱会的道具不足，请签到获得"
L_MARKET_BUY_ONEKEY_FAIL = {
	"图灵新钞不足",
	"魂晶不足",
	"图灵新钞和魂晶不足"
}
L_MARKET_BUY_ONEKEY_EMPTY = {
	"图灵新钞价格物品出售完毕",
	"魂晶价格物品已出售完毕",
	"所有物品均已出售"
}
L_MARKET_BUY_ONEKEY_DES = {
	"是否一键购买所有物品",
	"图灵新钞价格物品",
	"魂晶价格物品"
}
L_HORCRUX_DELETE = {
	des = "确认分解稀有品质魂器",
	title = "分解确认"
}
L_COURSE_CULTIVATE = {
	"该课程未升级",
	"重置课程所需魂晶数量不足",
	"需要先重置后置课程"
}
L_NOVICELAYER = {
	"完成%d个任务免费获得SP学员远坂秋!",
	"完成%d个任务免费获得20扭蛋券!"
}
L_TILESPRITE = {
	"需要永雏塔菲才能传送！"
}
L_PASSWORDTILE = {
	"密码输入错误！"
}
L_SHOPSPRITE = {
	"赠:",
	"折",
	"剩余:",
	"未购买",
	"档",
	"累计达到%s元\n     即可获得",
	"每",
	"中"
}
L_CHAT_ENTRY = "[社团]"
L_SUPERMARKET_TIME_LIMIT = "前置购买未解锁"
L_SUPERMARKET_TIME_LIMIT_2 = "充值金额未达到"
L_SUPERMARKET_TIME_LIMIT_3 = "类型不为9"
L_SUPERMARKET_TIME_LIMIT_4 = "再充值"
L_SUPERMARKET_TIME_LIMIT_5 = "即可解锁"
L_SUPERMARKET_TIME_LIMIT_6 = "元"
L_SUPERMARKET_TIME_LIMIT_7 = "无法继续购入"
L_SUPERMARKET_TIME_LIMIT_8 = "当前特权订阅有效期至:"
L_SUPERMARKET_MARKET_SPRITE = "温馨、灿烂礼包每日"
L_RECOLLE_CTIONSSWEEPSTAKE_LAYER = "班长在学院的故事才刚刚开始哟~"
L_RECOLLE_CTIONSSWEEPSTAKE_LAYER_2 = "标题"
L_RECOLLE_CTIONSSWEEPSTAKE_LAYER_3 = "内容"
L_RECOLLE_CTIONSSWEEPSTAKE_LAYER_4 = "保存成功"
L_TOUCH_NIL = "点击空白区域继续"
L_ALLTIME = "常驻"
L_POP_UMARU_SCOREUP = "队伍中编入属性加成学员时，此学员战斗中可以获得额外的属性"
L_TWISTEGG_MORE = "扩 招"
L_TVT_RESULT = "第%d场"
L_TURNOVER_ITEMS = {
	"赠送礼物给学员",
	"目前拥有:",
	"物品数量不足"
}
L_RANSOVER_DUE_ITEM = {
	"过期物品回收",
	"班长~ 以下的物品已经过期，喵酱回收了哟",
	"获得收益"
}
L_TOWER_SKILL_SELECT = "请选择一个技能增益"
L_LEVEL_STR_TABLE = {
	"等级100",
	"等级150",
	"等级200",
	"等级250",
	"等级300",
	"等级350",
	"等级400",
	"等级450",
	"等级500",
	"等级600",
	"等级650",
	"等级700",
	"等级750",
	"等级800",
	"等级850",
	"等级900"
}
L_POPSKILL_DETAIL = {
	"3振次后获取",
	"5振次后获取",
	"少",
	"多",
	"需要能量:"
}
L_SCULTURE = {
	"动态",
	"静态"
}
L_PATROL_RESULT_1 = "已累计完成%d个作战计划"
L_PATROL_ONEKEY_RESULT = {
	"没有满足条件的关卡可驻守",
	"没有可派遣的队伍，请班长仔细检查人员配置"
}
L_NOVICE_PASSLEVEL_AWARD = {
	"没通过指定关卡",
	"奖励已领完"
}
L_NOVICE_AWARD_2 = {
	"请先领取前面的奖励",
	"没有充值过",
	"奖励已领完",
	"奖励选择错误"
}
L_INVITE_INFO = "    最多可同时绑定8名班长，与已绑班长解除关系，\n不会重置任务进度及奖励。"
L_INVITE_DETAIL = {
	"已复制召回码，快去分享给小伙伴吧",
	"是否解除绑定关系，解除后与该玩家不能再次绑定?"
}
L_HORCRUX_UPSTAR = {
	"魂器升星",
	"所选魂器有高星魂器，是否进行升星"
}
L_GAME_COMPOUND_LAYER = {
	"所需材料合成路径尚未解锁",
	"材料未解锁，是否前往%s",
	"实验室",
	"加工厂"
}
L_FRIETN_INTRO = "这个人很懒，什么都没留下"
L_FIGHT_RESULT_7 = "阵\n亡\n名\n单"
L_SHOW_TIPS = {
	GOLD_NOT_ENOUGH = "图灵新钞不足",
	ITEM_MAX = "没有更多该物品可分解",
	LACK_ITEM = "合成材料不足"
}
L_AOTU_CHOOSE = "自动选择"
L_COMPONENT_STRENGTHEN = {
	"芯片已达到等级上限",
	"已满足校准所需经验",
	"没有选择芯片",
	"校准所需经验不足",
	"包含%s过的芯片，是否继续强化",
	"包含%s过的芯片，是否继续校准",
	"校准",
	"强化",
	"校准道具不足",
	"需要经验",
	"聚合",
	"经验溢出"
}
L_COMPONENT_RES = {
	"该芯片已校准!",
	"芯片已经强化至满级!",
	"该芯片已经聚合，替换后将失去聚合效果"
}
L_RECHARGE_QIONGB = "累计充值金额不足"
L_OPEN_TIME = "开启时间"
L_AUTO_ARRAY = {
	"请选择队伍天赋"
}
L_ACTIVITY_SHARE = {
	"         距离班长开启元旦礼盒只差“一步”啦~ \n      点击下方“一键复制”并粘贴分享给其他班长，\n邀请4人成功拆解红包礼物即可获取元旦好礼！百分百中奖哦~\n\n",
	"魂器学院元旦宝箱,百分百中奖,点击即可抽取扭蛋券,翻牌道具等珍贵道具,领取戳我: "
}
L_THE_DAY = "第%s天"
L_MARRY_POP = {
	"注:誓约后可突破好感等级上限",
	"向你表达了爱慕之情"
}
L_EXPLORE_OFFER = "扫荡失败"
L_MAIN_CITY_BG_SELECT = {
	"是否购买该背景？",
	"已成功购买",
	"背景"
}
L_FORMATIONMAIN_TEST = {
	"选择敌方队伍学员",
	"选择我方队伍学员",
	"全队天赋相同时获得加成"
}
L_FORMATIONMAIN_OLD_SUB = "当前五个队伍仍然有空位\n是否确定要进行游戏"
L_GET_SOUL_A = "暂时没有获取该学员的途径"
L_NOT_EXIT_SKIN = "服装不存在"
L_FONSTUME_ROOM = {
	"每周首次分享",
	"养肝护肾，为AI发电!",
	"快加入魂器学院吧",
	"原始皮肤",
	"请先购买",
	"暂不可获得"
}
L_ACTIVITY_WAKEFUND_VIP_BUY = {
	"通过指定关卡，可获得大量扭蛋券奖励",
	"开启特殊补给",
	"无法重复购买！！！"
}
L_WARORDER_LAYER = {
	"战令系统已刷新",
	"剩余免费次数：",
	"是否刷新当前任务",
	"当前每次消耗10魂晶"
}
L_BIANHUA_CHAPTER = {
	"购买已达上限",
	"花费%d" .. L_DIAMOND .. "购买1次随机副本次数",
	"%d" .. L_DIAMOND .. "回复1次~~~~"
}
L_GAMEBACK_1 = "已输入召回码："
L_USE_LIMIT = "限用："
L_TOWER_DEFENCE_COST_RES = "通关后阵亡AI将不再返还"
L_ADD_FEN = "+%d/分"
L_SEASON = "赛季"
L_TEAM_SCORE = "队伍分数"
L_GO_OVERLOCK = "前往共振"
L_SETTING_LAYER_GLOBAL = {
	"缺陷反馈",
	"资源已下载完成",
	"已下载%.1f%%",
	"是否下载live2d资源(%s)",
	"live2d资源下载",
	"分享测试",
	"是否下载",
	"是否进入开发者模式",
	"正在检查资源...",
	"是否下载完整资源(%s)"
}
L_GET_OVERLOCK_SKIN = "角色完成超频后即可获得该皮肤"
L_SWIM_END = {
	"终",
	"点"
}
L_RECHARGE_DES_ABV = "以上礼包均计入累计充值活动中"
L_PRIVILEGE_SUCCESS = "订阅成功"
L_PRIVILEGE_FAIL = "扣款失败"
L_PHOTOFILE_FILE = {
	"超频后解锁",
	"好感等级达到",
	"级后解锁"
}
L_NOVICE_JUMP = "限定抽取"
L_MONOPOLY_NEW = {
	"后退%d步",
	"尚未探索的方块，可能会有意想不到的事情。",
	"货币id为空，注意检查",
	"未探索方块"
}
L_MARKET_ERSAN = {
	"是否消耗钻石刷新折扣皮肤?",
	"家具兑换券不足",
	"消耗%d魂晶补足%d张家具兑换券"
}
L_MAIL_NEW = {
	"领取附件",
	"社团系统已关闭~"
}
L_DACHENG = "达成"
L_XUEYUANYOULI = "学员有利"
L_INVITE_10086 = {
	"输入其他班长的UID就可以领取奖励啦~",
	"需输入UID",
	"绑定确认",
	"确认绑定该UID吗？绑定后将不可修改哦~",
	"已成功邀请",
	"我的UID：",
	"已绑定UID：",
	"班长已经不是新玩家啦~去邀请可以获得奖励哦~",
	"请先绑定UID才可以领取奖励哦~"
}
L_KEEP_HORCRUX = "保留一个重复魂器"
L_TWIST_LEVEL_SP = "优秀"
L_LEASCON_SUCC = {
	"基础课程生效中",
	"元素课程生效中"
}
L_STRENGTHCONFIRM = {
	"学员等级",
	"学员突破",
	"魂武等级",
	"未激活魂武",
	"上",
	"中",
	"下",
	"芯片·",
	"未装备芯片",
	"芯片等级"
}
L_FAST_SOUL_STRENGTH_SETTING = {
	"班长可选择下方强化内容，\n自动消耗对应材料进行强化。"
}
L_BTN_OPEN_TWICE_COM = "开启二次确认"
L_HAOGANBI = "好感币"
L_CHECK_PRIVACY = {
	"查看用户协议",
	"查看隐私政策",
	"查看第三方信息共享清单",
	"查看儿童隐私政策",
	"查看个人信息清单",
	"查看第三方sdk清单",
	"取消服务条款及隐私政策授权"
}
L_CHATROOM_TBL = {
	"小明",
	"佳俊小红",
	"陆地小黑",
	"小狗",
	"丹丹小青蛙",
	"陈睿小芝麻",
	"小飞机",
	"晶晶大白"
}
L_CHANGE_SHOW = {
	"当前没有战争模式关卡可以挑战",
	"当前没有关卡可以挑战"
}
L_BARTHDAY_WISH_DETIAL = "生日祝福详情"
L_BARTHDAY_WISH = "攻击和生命20%提升"
L_POS_NO_PLAYER = "魂器对应位置未设置角色"
L_AUTO_BIANDUI_FAIL = "自动编队失败"
L_SELECT_ALL = "全选:"
L_ACTRECHARGETP = {
	"第%d/%d期",
	"后结束",
	"第%d轮"
}
L_ACTIVIYT_LEVEL_WORR = "当前活动关卡modetype配置出错！！！"
L_NEW_DIAMOND_CARD_LESS_TIME = {
	[88003] = "年卡剩余时间:%s天",
	[88002] = "季卡剩余时间:%s天",
	[88001] = "月卡剩余时间:%s天",
	[20002] = "月卡剩余时间:%s天"
}
L_NEW_DIAMOND_CARD_TOTAL_TIME = "已累计%d天"
L_BOSSFIGHTLAYER = {
	"通关上一关解锁",
	"在每期结束后重置奖励",
	"还没达到奖励",
	"已经领过奖励",
	"通关%d轮获得奖励"
}
L_NEW_DIAMOND_CARD_TOTAL_TIME = "已累计%d天"
L_NEW_DIAMOND_CARD_TOTAL_DES = "阶段签到奖励"
L_EQUIP_ATTR_DES = {
	hp = "受学员的科技值及血量资质共同影响，具体为学员科技值*血量资质",
	range = "学员最大的攻击距离",
	damage = "受学员的科技值及攻击资质共同影响，具体为学员科技值*攻击资质",
	Tech = "学员数量,共振数会提升科技值，影响学员的攻击和生命属性。",
	attackspeed = "学员每秒钟普攻次数"
}
L_EQUIP_ATTR_SMALL_ATTR = {
	extra_attack = "提高所有造成的伤害",
	strike_damage_add = "提升角色强击时造成的伤害",
	reforce = "实际击退距离=击退距离-击退抵抗",
	extra_rage = "提升充能速率",
	defence = "减少受到的机械伤害",
	critical = "角色攻击发生暴击的几率，产生暴击时默认造成200%的伤害",
	healpoint = "每秒百分比恢复血量",
	dodge = "被攻击时有一定的机率发生闪避，闪避时默认受到50%的伤害",
	cri_damage_add = "提升角色暴击时造成的伤害",
	hematophagy = "造成伤害时恢复自身血量",
	extra_rage_const = "固定充能",
	damage_type = "受学员的属性影响，对不同属性有不同的增伤或被克制效果",
	extra_defence_const = "抵消一定量的伤害",
	extra_defence = "减少所有受到的机械和能量伤害",
	extra_attack_const = "额外造成一定量伤害",
	extra_heal_const = "额外恢复的血量",
	energydefence = "减少受到的能量伤害",
	hp_percent = "受学员的科技值及血量资质共同影响，具体为学员科技值*血量资质",
	dodge_damage_add = "减少闪避时受到的伤害",
	movingspeed = "每秒钟移动距离",
	damage_percent = "受学员的科技值及攻击资质共同影响，具体为学员科技值*攻击资质",
	force = "普攻时击退敌人的距离单位"
}
L_EQUIP_ATTR_SMALL_ATTR_NAME = {
	extra_defence = "额外减伤",
	dodge = "闪避率",
	extra_attack_const = "额外固定值伤害",
	extra_rage = "额外充能速率",
	extra_heal_const = "额外恢复固定生命值",
	healpoint = "每秒百分比恢复血量",
	reforce = "击退抵抗",
	hematophagy = "吸血",
	extra_attack = "额外伤害",
	dodge_damage_add = "闪避减伤",
	movingspeed = "移速",
	extra_rage_const = "额外充能值",
	force = "普攻时击退敌人的距离单位",
	extra_defence_const = "额外固定值伤害减免"
}
L_EQUIP_ATTR_DES_2 = "绿色数值为课程系统加成"
L_HORCRUX_DEVOUR_SELECT = {
	"任意属性魂器",
	"基础属性魂器"
}
L_BASE_FORMATION_ADD = {
	"配置助战"
}
L_FIGHT_RESULT_BUTTONS = {
	"挑战下一关",
	"挑战下一章"
}
L_STOP_ATUO_FIGHT = {
	"停止自动"
}
L_FORMATIONM_ONE = "独立编队"
L_SUPERMARKET_LIMITED_TIME_PACKAGE = {
	"购买后可领取",
	"还需累计登录",
	"天才能领取奖励",
	"请先领取每日奖励",
	"累计登录%s天可领取",
	"累计登录%s天获取",
	"次日发邮件,持续%s天",
	"剩余天数："
}
L_HOLIDAY_CONFIRM_1 = "材料返还:"
L_PRE_TO_MORE = "滑动显示更多"
L_PLAYER_CHARACTER = {
	"学员自动战斗中",
	"沉默中……",
	"怒气不足",
	"技能还未冷却"
}
L_ELECTRIC_SUPP = "充能"
L_POST_CARD = "名片框替换"
L_HOLIDAY_CONFIRM_2 = "图灵新钞返还:"
L_CHANGE_TIMES = "挑战次数："
L_ACTIVITY_EXCHAGE = "活动期间，不限次数"
L_ACTIVITY_EXCHAGE_ERROR = {
	"目前只支持芯片兑换！",
	"该道具数量不足！",
	"该道具已经存在在兑换列表!"
}
L_EXIT_GAME = "当前游戏未结束，退出将会结束游戏\n是否确认退出?"
L_RETURN = "返回"
L_SURE_EXIT = "确认退出"
L_EXP_OVERFLOW_1 = "该学员已到达突破限制，溢出的经验值中的50%将转化为科技点。"
L_HEXA_CHANGE_REAMIN = "剩余次数："
L_HEXA_MAX_LABEL = "最高纪录："
L_HEXA_CUR_LABEL = "本次得分："
L_EXP_OVERFLOW_1 = "该学员已到达突破限制，溢出的经验值中的50%将转化为科技点。"
L_BARRAGE_SEND_SUCCESS = "发送成功"
L_GUIDE_LEVEL_ASK_OLD = "我是魂器学院高手(精简引导)"
L_GUIDE_LEVEL_ASK_NEW = "我没玩过魂器学院(常规引导)"
L_SURPLUS_STAR = "还需%s颗星"
L_DELETE_READ = "删除已读"
L_RECHARGE_PERMANENT_LIM = {
	"每日%s/%s",
	"每周%s/%s",
	"每月%s/%s"
}
L_CONDITION_TEXT = "条件："
L_CONSUME_TEXT = "消耗："
L_LEVEL_MORE_UP = "等级强化"
L_POPSUBSCOREUP_LAYER_TEXT = {
	"本期积分加成",
	"当队伍中编成积分加成学员时，可以额外获得积分",
	"编成复数积分加成学员时，积分加成可累加",
	"以下学员分数提高25%"
}
L_SKIN_BUY = "购买"
L_SKIN_CHANGE = "穿戴"
L_IS_HAVE = "已拥有"
L_GO_TO_HAVE = "前往获取"
L_NOW_WEAR = "当前装扮"
L_GET_AFTER_OVERLOCK = "超频后获得"
L_MEMORY_CODE = "连续2次点出相同图标可将食物卡牌翻转，在倒计时内成功翻转所有食物卡牌即可通过挑战。"
L_MEMORY_CODE_START = "开始挑战"
L_NOT_ON_STAGE = "未上场"
L_IN_Time_CAN_BUY = "内可购买"
L_AREAN_UNLOCK_TIPS = "%s\n解锁"
L_NOT_HAVE_CARD = "暂未开通"
L_STUDENT_ADDITION = "学员属性加成"
L_INPUT_PHONE_NUM = "  输入手机号"
L_INPUT_PHONE_CODE = "  输入验证码"
L_PHONE_WAIT_TIME = "(%s)重新发送"
L_PHONE_NUMBER_ERROR = "请输入正确的手机号！"
L_SMS_PHONE_SUCCESS = "发送成功"
L_VERIFY_PHONE_SUCCESS = "验证成功！"
L_VERIFY_PHONE_FAIL = "验证失败！"
L_COMMONFLOP_TEXT = {
	"大奖已经选满了",
	"点击下方区域自选大奖哦",
	"该大奖已经被抽到了",
	"请选择三个大奖",
	"已经选择了该大奖",
	"选择成功",
	"必须选择三个大奖哦"
}
L_COMMONROULETTE_TEXT = {
	"已经选择了该大奖",
	"大奖已经选满了",
	"点击下方区域自选大奖哦",
	"请选择四个大奖",
	"还没有选择大奖哦~",
	"可以自选大奖哦！",
	"选择成功"
}
L_MAINLINE_GET_REWARD = "获得奖励"
L_MAINLINE_GO_TASK = "前往任务"
L_MAINLINE_GO_UPGRADE = "前往升学"
L_MAINLINE_UPGRADE_TASK = "升学任务"
L_COMMON_AIRPLANE_TEXT = {
	"完成轮次: %d/%d",
	"当前没有可领取的任务奖励哦~",
	"道具不足",
	"完成所有任务才能进入下一轮",
	"已经是最后一轮任务了",
	"当前层商店还未开启哦",
	"已经是最大层了",
	"已经达到购买限制了"
}
L_TOWER_SERVANT_DROPUP = "上阵以下学员获得奖励提高"
L_SCHOOL_STUDY_GO_2 = {
	title = "未通过关卡",
	button = "确 定",
	des = "当前需要关卡未通过，是否前往主线?"
}
L_COMPONENT_BREAK_REMAKE = {
	chooseBreak = "请至少选择一个芯片",
	breakComponent1 = "确定熔炼%d个芯片？",
	chooseRemake = "请选择要构筑的芯片",
	breakComponent2 = "将被转化为%d个通用芯片组件",
	remakeComponent = "是否确定构筑 %s(Lv.%d)",
	breakDes = "芯片熔炼"
}
L_TOWER_SERVANT_DROPUP = "上阵以下学员获得奖励提高"
L_COMPONENT_QUALITYS = {
	nil,
	nil,
	"蓝色品质",
	"紫色品质",
	"橙色品质"
}
L_SUPERMARKET_TIME_LIMIT_9 = "新档位"
L_ICP_BEIAN = "ICP备案/许可证号: 浙ICP备15028199号-3A"
L_EXPLORE_OFFER_TIPS = {
	"完成该委托的所有目标即可解锁扫荡~",
	"完成该委托的所有目标即可解锁扫荡~",
	"仅危机行动支持扫荡哦~",
	nil,
	nil,
	"仅订阅特权支持扫荡功能哦~"
}
L_TWIST_COUNT_NOW = {
	[0] = "距离一振还需<span style=color: rgb(246, 236, 137);>%s</span>个",
	"距离二振还需<span style=color: rgb(246, 236, 137);>%s</span>个",
	"距离三振还需<span style=color: rgb(246, 236, 137);>%s</span>个",
	"距离四振还需<span style=color: rgb(246, 236, 137);>%s</span>个",
	"距离满振还需<span style=color: rgb(246, 236, 137);>%s</span>个",
	"距离超频还需<span style=color: rgb(246, 236, 137);>%s</span>个"
}
L_TWIST_NO_COUNT_NOW = "<span style=color: rgb(246, 236, 137);>未拥有</span>"
L_EQUIP_COMPONENT_ONEKEY_SUCCESS = "一键装备芯片成功！"
L_EQUIP_COMPONENT_ONEKEY_FAIL = "一键装备失败"
L_EQUIP_COMPONENT_ONEKEY_EQUIPED = "该学员已经装备了芯片"
L_EQUIP_COMPONENT_ONEKEY_NOCOMPONENT = "没有可以装备的芯片"
L_ISLINKAGE = "联动"
