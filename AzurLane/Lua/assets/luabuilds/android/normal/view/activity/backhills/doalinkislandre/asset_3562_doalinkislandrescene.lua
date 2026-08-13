class = var_0_10000

local var_0_0 = "DOALinkIslandReScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "DOALinkIslandReUI"
end

var_0_1.edge2area = {
	default = "map_middle",
	["2_2"] = "map_bridge"
}

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0._map = var_1.Find(var_2_1, "map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		var_1_10006 = arg_2_0._map
		var_1_10005 = var_1_10005.GetChild(var_1_10006, iter_2_0)
		go = var_1_10006
		var_1_10006 = var_1_10006(var_1_10005).name
		arg_2_0["map_" .. var_1_10006] = var_1_10005
	end

	local var_2_2 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_2, "ship")

	local var_2_3 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_3, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		var_1_10006 = arg_2_0._upper
		var_1_10005 = var_1_10005.GetChild(var_1_10006, iter_2_1)
		go = var_1_10006
		var_1_10006 = var_1_10006(var_1_10005).name
		arg_2_0["upper_" .. var_1_10006] = var_1_10005
	end

	arg_2_0.containers = {
		arg_2_0.map_middle
	}
	GraphPath = var_1

	local var_2_4 = var_1.New

	import = var_2
	arg_2_0.graphPath = var_2_4(var_2("GameCfg.BackHillGraphs.DOAIslandGraph"))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.GetComponentInParent

	typeof = var_3
	UnityEngine = iter_2_1

	local var_2_7

	var_2_7 = var_2_6(var_2_5, var_3(iter_2_1.Canvas)) and var_1.sortingOrder

	local var_2_8 = arg_2_0._map
	local var_2_9 = var_3.GetComponent

	typeof = var_1_10005
	UnityEngine = var_1_10006
	var_2_9(var_2_8, var_1_10005(var_1_10006.Canvas)).sortingOrder = var_2_7 - 3

	local var_2_10 = arg_2_0.map_tebiezuozhan
	local var_2_11 = var_3.GetComponent

	typeof = var_5
	UnityEngine = var_6
	var_2_11(var_2_10, var_5(var_6.Canvas)).sortingOrder = var_2_7 - 1

	local var_2_12 = arg_2_0.map_bridge
	local var_2_13 = var_3.GetComponent

	typeof = var_5
	UnityEngine = var_6
	var_2_13(var_2_12, var_5(var_6.Canvas)).sortingOrder = var_2_7 - 1

	local var_2_14 = arg_2_0._map
	local var_2_15 = var_3.Find(var_2_14, "DOAhoushan_hailang")

	pg = var_2_14

	var_2_14.ViewUtils.SetSortingOrder(var_2_15, var_2_7 - 2)

	getProxy = var_4
	MiniGameProxy = var_5
	arg_2_0.mgProxy = var_4(var_5)
	AutoLoader = var_4
	arg_2_0.loader = var_4.New()

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	var_1_10001(var_3_0, var_3.Find(var_3_1, "top/return_btn"), function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10001

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0._tf

	var_1_10001(var_3_2, var_3.Find(var_3_3, "top/return_main_btn"), function()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf

	var_1_10001(var_3_4, var_3.Find(var_3_5, "top/help_btn"), function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.doa_main.tip

		var_6_1(var_6_0, var_6_2)

		return
	end)

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.InitStudents

	ActivityConst = var_3

	var_3_7(var_3_6, var_3.MINIGAME_VOLLEYBALL, 2, 3)

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.GetDOA2MiniGameId

	ActivityConst = var_3

	local var_3_10 = var_3_9(var_3_8, var_3.MINIGAME_VOLLEYBALL)

	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "shatanpaiqiu", function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		var_7_1(var_7_0, var_2_10002.GO_MINI_GAME, var_3_10)

		return
	end)

	local var_3_11 = arg_3_0
	local var_3_12 = arg_3_0.GetDOA2MiniGameId

	ActivityConst = var_4

	local var_3_13 = var_3_12(var_3_11, var_4.MINIGAME_PENGPENGDONG)

	onButton = var_3_11

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0._upper
	local var_3_16 = var_5.Find(var_3_15, "pengpengdong")

	local function var_3_17()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		var_8_1(var_8_0, var_2_10002.GO_MINI_GAME, var_3_13)

		return
	end

	SFX_PANEL = var_7

	var_3_11(var_3_14, var_3_16, var_3_17, var_7)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "daoyvjianshe", function()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		DOALinkIslandReMediator = var_2_10002

		local var_9_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_9_3 = var_2_10003.ACTIVITY
		local var_9_4 = {}

		ActivityConst = var_2_10005
		var_9_4.id = var_2_10005.DOA_PT_ID

		var_9_1(var_9_0, var_9_2, var_9_3, var_9_4)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "bujishangdian", function()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		DOALinkIslandReMediator = var_2_10002

		local var_10_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_10_3 = var_2_10003.SHOP
		local var_10_4 = {}

		NewShopsScene = var_2_10005
		var_10_4.warp = var_2_10005.TYPE_ACTIVITY

		var_10_1(var_10_0, var_10_2, var_10_3, var_10_4)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huanzhuangshangdian", function()
		local var_11_0 = arg_3_0
		local var_11_1 = var_0.emit

		DOALinkIslandReMediator = var_2_10002

		local var_11_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_11_1(var_11_0, var_11_2, var_2_10003.SKINSHOP)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "xianshijianzao", function()
		local var_12_0 = arg_3_0
		local var_12_1 = var_0.emit

		DOALinkIslandReMediator = var_2_10002

		local var_12_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_12_1(var_12_0, var_12_2, var_2_10003.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jinianzhang", function()
		local var_13_0 = arg_3_0
		local var_13_1 = var_0.emit

		DOALinkIslandReMediator = var_2_10002

		local var_13_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_13_1(var_13_0, var_13_2, var_2_10003.DOA2_MEDAL_COLLECTION_SCENE)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "tebiezuozhan", function()
		pg = var_2_10000

		local var_14_0 = var_2_10000.activity_template

		ActivityConst = var_2_10001

		local var_14_1 = var_14_0[var_2_10001.DOA_PT_ID].config_client.fightLinkActID

		getProxy = var_1
		ChapterProxy = var_2_10002

		local var_14_2 = var_1(var_2_10002)
		local var_14_3, var_14_4 = var_1.getLastMapForActivity(var_14_2, var_14_1)

		if var_14_3 then
			local var_14_5 = var_1:getMapById(var_14_3)

			if not var_4.isUnlock(var_14_5) then
				pg = var_4

				local var_14_6 = var_4.TipsMgr.GetInstance()
				local var_14_7 = var_4.ShowTips

				i18n = var_2_10006

				var_14_7(var_14_6, var_2_10006("common_activity_end"))
			else
				local var_14_8 = arg_3_0
				local var_14_9 = var_4.emit

				DOALinkIslandReMediator = var_2_10006

				local var_14_10 = var_2_10006.GO_SCENE

				SCENE = var_2_10007

				var_14_9(var_14_8, var_14_10, var_2_10007.LEVEL, {
					chapterId = var_14_4,
					mapIdx = var_14_3
				})
			end

			return
		end
	end)
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_15_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)
	local var_15_1

	setActive = var_1_10003

	local var_15_2 = arg_15_0.upper_shatanpaiqiu
	local var_15_3 = var_4.Find(var_15_2, "tip")
	local var_15_4 = var_0_1.IsMiniActNeedTip

	ActivityConst = var_6

	var_1_10003(var_15_3, var_15_4(var_6.MINIGAME_VOLLEYBALL))

	setActive = var_1_10003

	local var_15_5 = arg_15_0.upper_pengpengdong
	local var_15_6 = var_4.Find(var_15_5, "tip")
	local var_15_7 = var_0_1.IsMiniActNeedTip

	ActivityConst = var_6

	var_1_10003(var_15_6, var_15_7(var_6.MINIGAME_PENGPENGDONG))

	local var_15_8 = var_15_0
	local var_15_9 = var_15_0.getActivityById

	ActivityConst = var_5

	local var_15_10 = var_15_9(var_15_8, var_5.MINIGAME_VOLLEYBALL)

	assert = var_15_8

	var_15_8(var_15_10)

	getProxy = var_15_8
	MiniGameProxy = var_5

	local var_15_11 = var_15_8(var_5)
	local var_15_12 = var_4.GetHubByHubId(var_15_11, var_15_10:getConfig("config_id"))

	assert = var_15_11

	var_15_11(var_15_12)

	local var_15_13 = arg_15_0.loader
	local var_15_14 = var_5.GetSpriteQuiet
	local var_15_15 = "ui/DOALinkIslandUI_atlas"

	tostring = var_8

	local var_15_16

	if not var_15_12.usedtime then
		var_15_16 = 0
	end

	local var_15_17 = var_8(var_15_16)
	local var_15_18 = arg_15_0.map_shatanpaiqiu

	var_15_14(var_15_13, var_15_15, var_15_17, var_9.Find(var_15_18, "Digit"), true)

	local var_15_19 = var_15_0
	local var_15_20 = var_15_0.getActivityById

	ActivityConst = var_15_15

	local var_15_21 = var_15_20(var_15_19, var_15_15.DOA_PT_ID)

	assert = var_15_19

	var_15_19(var_15_21)

	local var_15_22 = arg_15_0.upper_daoyvjianshe
	local var_15_23 = var_6.Find(var_15_22, "tip")
	local var_15_24 = var_15_21 and var_15_21:readyToAchieve()

	setActive = var_15_22

	var_15_22(var_15_23, var_15_24)

	local var_15_25 = arg_15_0.upper_jinianzhang
	local var_15_26 = var_7.Find(var_15_25, "tip")
	local var_15_27 = var_0_1.MedalTip()

	setActive = var_8

	var_8(var_15_26, var_15_27)

	return
end

function var_0_1.willExit(arg_16_0)
	arg_16_0:clearStudents()
	var_0_1.super.willExit(arg_16_0)

	return
end

function var_0_1.MedalTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_17_0 = var_1_10000(var_1_10001)
	local var_17_1 = var_0.getActivityByType

	ActivityConst = var_1_10002

	local var_17_2 = var_17_1(var_17_0, var_1_10002.ACTIVITY_TYPE_PUZZLA)

	Activity = var_17_0

	return var_17_0.IsActivityReady(var_17_2)
end

function var_0_1.IsShowMainTip(arg_18_0)
	local var_18_0

	if arg_18_0 then
		::label_18_0::

		var_1_10002 = arg_18_0
		var_18_0 = not arg_18_0.isEnd(var_1_10002)
	end

	if var_18_0 then
		getProxy = var_1_10002
		ActivityProxy = var_1_10003

		local var_18_1 = var_1_10002(var_1_10003)

		local function var_18_2()
			local var_19_0 = var_18_1
			local var_19_1 = var_0.getActivityById

			ActivityConst = var_2_10002

			local var_19_2

			var_19_2 = var_19_1(var_19_0, var_2_10002.DOA_PT_ID) and not var_0:isEnd() and var_0:readyToAchieve()

			return var_19_2
		end

		local var_18_3 = var_0_1.MedalTip

		local function var_18_4()
			local var_20_0 = var_0_1.IsMiniActNeedTip

			ActivityConst = var_2_10001

			return var_20_0(var_2_10001.MINIGAME_VOLLEYBALL)
		end

		local function var_18_5()
			local var_21_0 = var_0_1.IsMiniActNeedTip

			ActivityConst = var_2_10001

			return var_21_0(var_2_10001.MINIGAME_PENGPENGDONG)
		end

		local var_18_6

		if not var_18_2() and not var_18_3() and not var_18_4() then
			var_18_6 = var_18_5()
		end

		return var_18_6
	end

	return
end

function var_0_1.GetDOA2MiniGameId(arg_22_0, arg_22_1)
	pg = var_1_10002

	if not var_1_10002.activity_template[arg_22_1] then
		error = var_1_10003

		var_1_10003("未找到对应DOA活动ID")

		return nil
	end

	local var_22_0 = var_2.config_id

	pg = var_1_10004

	for iter_22_0 = #var_1_10004.mini_game.all, 1, -1 do
		pg = var_1_10008
		var_1_10008 = var_1_10008.mini_game.all[iter_22_0]
		pg = var_1_10009

		if var_1_10009.mini_game[var_1_10008] and var_1_10009.hub_id == var_22_0 then
			return var_1_10008
		end
	end

	error = var_4

	var_4("未找到对应DOA活动的miniGameID")

	return nil
end

return var_0_1
