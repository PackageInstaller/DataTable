local var_0_0 = {}
local var_0_1 = {
	banner = "summary"
}

ActivityMediator = var_0_10002
var_0_1.event = var_0_10002.EVENT_GO_SCENE

local var_0_2 = {}

SCENE = var_0_10003
var_0_2[1] = var_0_10003.SUMMARY
var_0_1.data = var_0_2

function var_0_1.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_1_0 = var_1_10000(var_1_10002)
	local var_1_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	return var_1_1(var_1_0, var_1_10003.ACTIVITY_TYPE_SUMMARY) and not var_0:isEnd()
end

var_0_0[1] = var_0_1

local var_0_3 = {
	banner = "build_pray"
}

ActivityMediator = var_2
var_0_3.event = var_2.GO_PRAY_POOL
var_0_3.data = {}

function var_0_3.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10000(var_1_10002)
	local var_2_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_2_1(var_2_0, var_1_10003.ACTIVITY_PRAY_POOL) and not var_0:isEnd()
end

var_0_0[2] = var_0_3

local var_0_4 = {
	banner = "build_bisimai"
}

ActivityMediator = var_2
var_0_4.event = var_2.EVENT_GO_SCENE

local var_0_5 = {}

SCENE = var_3
var_0_5[1] = var_3.GETBOAT

local var_0_6 = {}

BuildShipScene = var_0_10004
var_0_6.projectName = var_0_10004.PROJECTS.ACTIVITY
var_0_5[2] = var_0_6
var_0_4.data = var_0_5

function var_0_4.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_3_0 = var_1_10000(var_1_10002)
	local var_3_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_3_1(var_3_0, var_1_10003.BUILD_BISMARCK_ID) and not var_0:isEnd()
end

var_0_0[3] = var_0_4

local var_0_7 = {
	banner = "activity_boss"
}

ActivityMediator = var_2
var_0_7.event = var_2.EVENT_GO_SCENE

local var_0_8 = {}

SCENE = var_0_6
var_0_8[1] = var_0_6.ACT_BOSS_BATTLE
var_0_8[2] = {
	showAni = true
}
var_0_7.data = var_0_8

function var_0_7.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_4_0 = var_1_10000(var_1_10002)
	local var_4_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	return var_4_1(var_4_0, var_1_10003.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2) and not var_0:isEnd()
end

function var_0_7.isTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_5_0 = var_1_10000(var_1_10002)
	local var_5_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	if not var_5_1(var_5_0, var_1_10003.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2) then
		return
	end

	local var_5_2 = false
	local var_5_3 = var_0

	if var_0.checkBattleTimeInBossAct(var_5_3) then
		var_5_2 = var_0.data2 ~= 1
	else
		local var_5_4 = var_0
		local var_5_5 = var_0.GetBindPtActID(var_5_4)

		getProxy = var_5_3
		ActivityProxy = var_1_10006

		local var_5_6 = var_5_3(var_1_10006)

		if var_4.getActivityById(var_5_6, var_5_5) then
			ActivityBossPtData = var_5_4

			local var_5_7 = var_5_4.New(var_4)

			var_5_2 = var_5.CanGetAward(var_5_7)
		end
	end

	return var_5_2
end

var_0_0[4] = var_0_7

local var_0_9 = {
	banner = "ming_paint"
}

ActivityMediator = var_2
var_0_9.event = var_2.EVENT_GO_SCENE

local var_0_10 = {}

SCENE = var_3
var_0_10[1] = var_3.COLORING
var_0_9.data = var_0_10

function var_0_9.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_6_0 = var_1_10000(var_1_10002)
	local var_6_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	return var_6_1(var_6_0, var_1_10003.ACTIVITY_TYPE_COLORING_ALPHA) and not var_0:isEnd()
end

function var_0_9.isTip()
	getProxy = var_1_10000
	ColoringProxy = var_1_10002

	local var_7_0 = var_1_10000(var_1_10002)

	return var_0.CheckTodayTip(var_7_0)
end

var_0_0[5] = var_0_9

local var_0_11 = {
	banner = "limit_skin"
}

ActivityMediator = var_2
var_0_11.event = var_2.EVENT_GO_SCENE

local var_0_12 = {}

SCENE = var_3
var_0_12[1] = var_3.SKINSHOP

local var_0_13 = {}

NewSkinShopScene = var_4
var_0_13.mode = var_4.MODE_EXPERIENCE
var_0_12[2] = var_0_13
var_0_11.data = var_0_12

function var_0_11.isShow()
	LOCK_SKIN_US = var_1_10000

	if var_1_10000 then
		pg = var_1_10000
		var_1_10000 = var_1_10000.gameset.levellimit_skinentrance.key_value
		getProxy = var_1_10001
		PlayerProxy = var_1_10003

		local var_8_0 = var_1_10001(var_1_10003)

		if var_1_10001.getRawData(var_8_0).level <= var_1_10000 then
			return false
		end
	end

	pg = var_1_10000

	local var_8_1 = var_1_10000.activity_banner.get_id_list_by_type

	GAMEUI_BANNER_12 = var_1_10001

	if var_8_1[var_1_10001] then
		::label_8_0::

		if #var_0 > 0 then
			_ = var_1_10001
			var_1_10001 = var_1_10001.any(var_0, function(arg_9_0)
				pg = var_2_10001

				local var_9_0 = var_2_10001.activity_banner[arg_9_0].time

				pg = var_2_10002

				local var_9_1 = var_2_10002.TimeMgr.GetInstance()

				return var_2.inTime(var_9_1, var_9_0)
			end)
		else
			var_1_10001 = false
		end

		if false then
			var_1_10001 = true
		end
	end

	return var_1_10001
end

function var_0_11.isTip()
	pg = var_1_10000

	local var_10_0 = var_1_10000.gameset.skin_ticket.key_value

	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_10_1 = var_1_10001(var_1_10003)
	local var_10_2 = var_1.getRawData(var_10_1)

	if not var_1.getResource(var_10_2, var_10_0) or not (0 < var_2) then
		return false
	end

	getProxy = var_10_1
	ShipSkinProxy = var_5

	local var_10_3 = var_10_1(var_5)
	local var_10_4 = var_3.GetAllSkins(var_10_3)

	_ = var_5

	local var_10_6

	if var_5.any(var_10_4, function(arg_11_0)
		local var_11_0 = arg_11_0:getConfig("genre")

		ShopArgs = var_2_10002

		local var_11_2

		if var_11_0 == var_2_10002.SkinShopTimeLimit then
			local var_11_1 = var_0

			var_11_2 = not var_1.hasSkin(var_11_1, arg_11_0:getSkinId())
		else
			var_11_2 = false
		end

		if false then
			var_11_2 = true
		end

		return var_11_2
	end) then
		getProxy = var_10_6
		SettingsProxy = var_7

		local var_10_5 = var_10_6(var_7)

		var_10_6 = var_10_6.ShouldTipTimeLimitSkinShop(var_10_5)
	end

	return var_10_6
end

var_0_0[6] = var_0_11

local var_0_14 = {
	banner = "banai_shop"
}

ActivityMediator = var_2
var_0_14.event = var_2.GO_SHOPS_LAYER

local var_0_15 = {}
local var_0_16 = {}

NewShopsScene = var_4
var_0_16.warp = var_4.TYPE_ACTIVITY
ActivityConst = var_4
var_0_16.actId = var_4.BISMARCK_PT_SHOP_ID
var_0_15[1] = var_0_16
var_0_14.data = var_0_15

function var_0_14.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_12_0 = var_1_10000(var_1_10002)
	local var_12_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_12_1(var_12_0, var_1_10003.BISMARCK_PT_SHOP_ID) and not var_0:isEnd()
end

var_0_0[7] = var_0_14

local var_0_17 = {
	banner = "bili_shop"
}

ActivityMediator = var_2
var_0_17.event = var_2.GO_SHOPS_LAYER

local var_0_18 = {}
local var_0_19 = {}

NewShopsScene = var_4
var_0_19.warp = var_4.TYPE_ACTIVITY
ActivityConst = var_4
var_0_19.actId = var_4.BILIBILI_PT_SHOP_ID
var_0_18[1] = var_0_19
var_0_17.data = var_0_18

function var_0_17.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_13_0 = var_1_10000(var_1_10002)
	local var_13_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_13_1(var_13_0, var_1_10003.BILIBILI_PT_SHOP_ID) and not var_0:isEnd()
end

var_0_0[8] = var_0_17
var_0_0[9] = {}

local var_0_20 = {
	banner = "commom_build"
}

ActivityMediator = var_2
var_0_20.event = var_2.EVENT_GO_SCENE

local var_0_21 = {}

SCENE = var_0_19
var_0_21[1] = var_0_19.GETBOAT

local var_0_22 = {}

BuildShipScene = var_4
var_0_22.projectName = var_4.PROJECTS.ACTIVITY
var_0_21[2] = var_0_22
var_0_20.data = var_0_21

function var_0_20.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_14_0 = var_1_10000(var_1_10002)
	local var_14_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_14_1(var_14_0, var_1_10003.FRANCE_RE_BUILD) and not var_0:isEnd()
end

var_0_0[10] = var_0_20

local var_0_23 = {
	banner = "commom_pt_shop"
}

ActivityMediator = var_2
var_0_23.event = var_2.GO_SHOPS_LAYER

local var_0_24 = {}
local var_0_25 = {}

NewShopsScene = var_4
var_0_25.warp = var_4.TYPE_ACTIVITY
ActivityConst = var_4
var_0_25.actId = var_4.FRANCE_RE_PT_SHOP
var_0_24[1] = var_0_25
var_0_23.data = var_0_24

function var_0_23.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_15_0 = var_1_10000(var_1_10002)
	local var_15_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_15_1(var_15_0, var_1_10003.FRANCE_RE_PT_SHOP) and not var_0:isEnd()
end

var_0_0[11] = var_0_23

local var_0_26 = {
	banner = "commom_skin_shop"
}

ActivityMediator = var_2
var_0_26.event = var_2.EVENT_GO_SCENE

local var_0_27 = {}

SCENE = var_0_25
var_0_27[1] = var_0_25.SKINSHOP
var_0_26.data = var_0_27

function var_0_26.isShow()
	pg = var_1_10000

	local var_16_0 = var_1_10000.TimeMgr.GetInstance()

	return var_0.inTime(var_16_0, {
		{
			{
				2019,
				6,
				27
			},
			{
				0,
				0,
				0
			}
		},
		{
			{
				2019,
				7,
				10
			},
			{
				23,
				59,
				59
			}
		}
	})
end

var_0_0[12] = var_0_26

local var_0_28 = {
	banner = "summer_feast"
}

ActivityMediator = var_2
var_0_28.event = var_2.EVENT_GO_SCENE

local var_0_29 = {}

SCENE = var_3
var_0_29[1] = var_3.SUMMER_FEAST
var_0_28.data = var_0_29

function var_0_28.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_17_0 = var_1_10000(var_1_10002)
	local var_17_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_17_1(var_17_0, var_1_10003.SUMMER_FEAST_ID) and not var_0:isEnd()
end

var_0_0[13] = var_0_28

local var_0_30 = {
	banner = "event_square"
}

ActivityMediator = var_2
var_0_30.event = var_2.EVENT_GO_SCENE

local var_0_31 = {}

SCENE = var_3
var_0_31[1] = var_3.NEWYEAR_SQUARE
var_0_30.data = var_0_31

function var_0_30.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_18_0 = var_1_10000(var_1_10002)
	local var_18_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_18_1(var_18_0, var_1_10003.NEWYEAR_ACTIVITY) and not var_0:isEnd()
end

var_0_0[14] = var_0_30

local var_0_32 = {
	banner = "LanternFestival"
}

ActivityMediator = var_2
var_0_32.event = var_2.GO_MINI_GAME
setmetatable = var_2
var_0_32.data = var_2({}, {
	__index = function(arg_19_0, arg_19_1)
		if arg_19_1 == 1 then
			getProxy = var_1_10002
			ActivityProxy = var_1_10004

			local var_19_0 = var_1_10002(var_1_10004)
			local var_19_1 = var_2.getActivityById

			ActivityConst = var_1_10005

			if var_19_1(var_19_0, var_1_10005.LANTERNFESTIVAL) and not var_2:isEnd() then
				arg_19_0[arg_19_1] = var_2:getConfig("config_client").miniGame

				return arg_19_0[arg_19_1]
			end
		end

		return nil
	end
})

function var_0_32.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_20_0 = var_1_10000(var_1_10002)
	local var_20_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_20_1(var_20_0, var_1_10003.LANTERNFESTIVAL) and not var_0:isEnd()
end

function var_0_32.isTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_21_0 = var_1_10000(var_1_10002)
	local var_21_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	if var_21_1(var_21_0, var_1_10003.LANTERNFESTIVAL) then
		local var_21_2 = var_0

		if not var_0.isEnd(var_21_2) then
			getProxy = var_1
			MiniGameProxy = var_21_2

			local var_21_3 = var_1(var_21_2)

			return var_1.GetHubByHubId(var_21_3, var_0:getConfig("config_id")).count > 0 and var_2.usedtime < 7
		end
	end

	return
end

var_0_0[15] = var_0_32

local var_0_33 = {
	banner = "encode_game"
}

ActivityMediator = var_2
var_0_33.event = var_2.GO_DECODE_MINI_GAME
var_0_33.data = {
	11
}

function var_0_33.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_22_0 = var_1_10000(var_1_10002)
	local var_22_1 = var_0.getActivitiesByType

	ActivityConst = var_1_10003

	local var_22_2 = var_22_1(var_22_0, var_1_10003.ACTIVITY_TYPE_MINIGAME)

	_ = var_1_10001

	return var_1_10001.detect(var_22_2, function(arg_23_0)
		return arg_23_0:getConfig("config_id") == 7
	end) and not var_1:isEnd()
end

function var_0_33.isTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_24_0 = var_1_10000(var_1_10002)
	local var_24_1 = var_0.getActivitiesByType

	ActivityConst = var_1_10003

	local var_24_2 = var_24_1(var_24_0, var_1_10003.ACTIVITY_TYPE_MINIGAME)

	_ = var_1_10001

	if var_1_10001.detect(var_24_2, function(arg_25_0)
		return arg_25_0:getConfig("config_id") == 7
	end) then
		local var_24_3 = var_1

		if not var_1.isEnd(var_24_3) then
			getProxy = var_2
			MiniGameProxy = var_24_3

			local var_24_4 = var_2(var_24_3)

			return var_2.GetHubByHubId(var_24_4, var_1:getConfig("config_id")) and var_3.id == 7 and var_3.count > 0
		end
	end

	return
end

var_0_0[16] = var_0_33

local var_0_34 = {
	banner = "air_fight"
}

ActivityMediator = var_2
var_0_34.event = var_2.EVENT_GO_SCENE

local var_0_35 = {}

SCENE = var_3
var_0_35[1] = var_3.AIRFORCE_DRAGONEMPERY
var_0_34.data = var_0_35

function var_0_34.isShow()
	do return false end

	getProxy = var_0
	ActivityProxy = var_1_10002

	local var_26_0 = var_0(var_1_10002)
	local var_26_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	return var_26_1(var_26_0, var_1_10003.ACTIVITY_TYPE_AIRFIGHT_BATTLE) and not var_0:isEnd()
end

function var_0_34.isTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_27_0 = var_1_10000(var_1_10002)
	local var_27_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	if var_27_1(var_27_0, var_1_10003.ACTIVITY_TYPE_AIRFIGHT_BATTLE) and not var_0:isEnd() then
		return var_0:readyToAchieve()
	end

	return
end

var_0_0[17] = var_0_34

local var_0_36 = {
	banner = "doa_medal"
}

ActivityMediator = var_2
var_0_36.event = var_2.EVENT_GO_SCENE

local var_0_37 = {}

SCENE = var_3
var_0_37[1] = var_3.DOA2_MEDAL_COLLECTION_SCENE
var_0_36.data = var_0_37

function var_0_36.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_28_0 = var_1_10000(var_1_10002)
	local var_28_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_28_1(var_28_0, var_1_10003.DOA_MEDAL_ACT_ID) and not var_0:isEnd()
end

function var_0_36.isTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_29_0 = var_1_10000(var_1_10002)
	local var_29_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	local var_29_2 = var_29_1(var_29_0, var_1_10003.DOA_MEDAL_ACT_ID)

	Activity = var_1_10001

	return var_1_10001.IsActivityReady(var_29_2)
end

var_0_0[18] = var_0_36

local var_0_38 = {
	banner = "meta_entrance_970112"
}

ActivityMediator = var_2
var_0_38.event = var_2.EVENT_GO_SCENE

local var_0_39 = {}

SCENE = var_3
var_0_39[1] = var_3.METACHARACTER
var_0_39[2] = {
	autoOpenShipConfigID = 9701121
}
var_0_38.data = var_0_39

function var_0_38.isShow()
	local var_30_0 = 0

	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10003

	local var_30_1 = var_1_10001(var_1_10003)

	return var_1.getMetaProgressVOByID(var_30_1, var_30_0) and var_1:isInAct()
end

function var_0_38.isTip()
	local var_31_0 = 0

	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10003

	local var_31_1 = var_1_10001(var_1_10003)
	local var_31_2 = var_1.getMetaProgressVOByID(var_31_1, var_31_0)

	if var_1.isPassType(var_31_2) then
		return false
	end

	if not var_1:isShow() then
		return false
	end

	local var_31_3 = false

	if var_1.metaPtData then
		var_1_10005 = var_1.metaPtData
		var_31_3 = var_3.CanGetAward(var_1_10005)
	end

	if var_31_3 == false then
		getProxy = var_3
		MetaCharacterProxy = var_1_10005

		local var_31_4 = var_3(var_1_10005)

		var_31_3 = var_3.getRedTag(var_31_4, var_31_0)
	end

	return var_31_3
end

var_0_0[19] = var_0_38

local var_0_40 = {
	banner = "activity_permanent"
}

ActivityMediator = var_2
var_0_40.event = var_2.ACTIVITY_PERMANENT
var_0_40.data = {}

function var_0_40.isShow()
	LOCK_PERMANENT_ENTER = var_1_10000

	return not var_1_10000
end

function var_0_40.isTip()
	PlayerPrefs = var_1_10000

	local var_33_0 = var_1_10000.GetString("permanent_time", "")

	pg = var_1_10001

	return var_33_0 ~= var_1_10001.gameset.permanent_mark.description
end

var_0_0[20] = var_0_40

local var_0_41 = {
	banner = "activity_miniprogram"
}

ActivityMediator = var_2
var_0_41.event = var_2.OPEN_MINI_PROGRAM
var_0_41.data = {}

function var_0_41.isShow()
	PLATFORM_CODE = var_1_10000
	PLATFORM_CH = var_1_10001

	if var_1_10000 == var_1_10001 then
		PermissionHelper = var_1_10000

		if var_1_10000.IsAndroid then
			LuaHelper = var_1_10000

			if var_1_10000.GetCHPackageType() ~= 1 then
				PermissionHelper = var_1_10000

				if var_1_10000.IsIOS() then
					getProxy = var_1_10000
					ActivityProxy = var_1_10002

					local var_34_0 = var_1_10000(var_1_10002)

					var_1_10000 = var_1_10000.IsActivityNotEnd
					getGameset = var_1_10003
					var_1_10000 = var_1_10000(var_34_0, var_1_10003("WeChat_Mini_Program")[1])

					if false then
						var_1_10000 = false
					end

					if false then
						var_1_10000 = true
					end
				end

				return var_1_10000
			end
		end
	end
end

function var_0_41.isTip()
	return false
end

var_0_0[21] = var_0_41

local var_0_42 = {
	banner = "doa_medal"
}

ActivityMediator = var_2
var_0_42.event = var_2.EVENT_GO_SCENE

local var_0_43 = {}

SCENE = var_3
var_0_43[1] = var_3.OTHERWORLD_BACKHILL
var_0_42.data = var_0_43

function var_0_42.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_36_0 = var_1_10000(var_1_10002)
	local var_36_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_36_1(var_36_0, var_1_10003.OTHER_WORLD_TERMINAL_BATTLE_ID) and not var_0:isEnd()
end

function var_0_42.isTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_37_0 = var_1_10000(var_1_10002)
	local var_37_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	local var_37_2 = var_37_1(var_37_0, var_1_10003.OTHER_WORLD_TERMINAL_BATTLE_ID)

	Activity = var_1_10001

	return var_1_10001.IsActivityReady(var_37_2)
end

var_0_0[22] = var_0_42

local var_0_44 = {
	banner = "cultivating_plant"
}

ActivityMediator = var_2
var_0_44.event = var_2.OPEN_CULTIVATING_PLANT
var_0_44.data = {}

function var_0_44.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_38_0 = var_1_10000(var_1_10002)
	local var_38_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	return var_38_1(var_38_0, var_1_10003.CULTIVATING_PLANT_ID) and not var_0:isEnd()
end

function var_0_44.isTip()
	CultivatingPlantTools = var_1_10000

	return var_1_10000.NeedShowRedPoint()
end

var_0_0[23] = var_0_44

local var_0_45 = {
	banner = "activity_escapemanor"
}

ActivityMediator = var_2
var_0_45.event = var_2.EVENT_GO_SCENE

local var_0_46 = {}

SCENE = var_3
var_0_46[1] = var_3.ACTIVITY
var_0_46[2] = {
	id = 51073
}
var_0_45.data = var_0_46

function var_0_45.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_40_0 = var_1_10000(var_1_10002)

	return var_0.getActivityById(var_40_0, 1) and not var_0:isEnd()
end

function var_0_45.isTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_41_0 = var_1_10000(var_1_10002)
	local var_41_1 = var_0.getActivityById(var_41_0, 1)

	Activity = var_1_10001

	return var_1_10001.IsActivityReady(var_41_1)
end

var_0_0[24] = var_0_45

local var_0_47 = {
	banner = "activity_auction"
}

ActivityMediator = var_2
var_0_47.event = var_2.EVENT_GO_SCENE

local var_0_48 = {}

SCENE = var_3
var_0_48[1] = var_3.ACTIVITY
var_0_48[2] = {
	id = 970002
}
var_0_47.data = var_0_48

function var_0_47.isShow()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_42_0 = var_1_10000(var_1_10002)

	return var_0.getActivityById(var_42_0, 18) and not var_0:isEnd()
end

function var_0_47.isTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_43_0 = var_1_10000(var_1_10002)
	local var_43_1 = var_0.getActivityById(var_43_0, 18)

	getProxy = var_1_10001
	ActivityProxy = var_3

	local var_43_2 = var_1_10001(var_3)
	local var_43_3 = var_1.getActivityById(var_43_2, 19)

	Activity = var_43_0

	local var_43_4

	if not var_43_0.IsActivityReady(var_43_1) then
		Activity = var_43_4
		var_43_4 = var_43_4.IsActivityReady(var_43_3)
	end

	return var_43_4
end

var_0_0[25] = var_0_47

return var_0_0
