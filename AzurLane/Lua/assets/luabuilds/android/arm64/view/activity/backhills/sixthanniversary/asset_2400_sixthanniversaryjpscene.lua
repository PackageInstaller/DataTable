class = var_0_10000

local var_0_0 = "SixthAnniversaryJPScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "SixthAnniversaryJPUI"
end

var_0_1.edge2area = {
	default = "_SDPlace"
}

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0._bg = var_1.Find(var_2_1, "BG")

	local var_2_2 = arg_2_0._tf

	arg_2_0._map = var_1.Find(var_2_2, "map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		local var_2_3 = arg_2_0._map
		local var_2_4 = var_5.GetChild(var_2_3, iter_2_0)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_4).name
		arg_2_0["map_" .. var_1_10006] = var_2_4
	end

	local var_2_5 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_5, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_6 = arg_2_0._upper
		local var_2_7 = var_5.GetChild(var_2_6, iter_2_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_7).name
		arg_2_0["upper_" .. var_1_10006] = var_2_7
	end

	local var_2_8 = arg_2_0._tf

	arg_2_0._SDPlace = var_1.Find(var_2_8, "SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}

	local var_2_9 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_9, "ship")
	GraphPath = var_1

	local var_2_10 = var_1.New

	import = var_2_9
	arg_2_0.graphPath = var_2_10(var_2_9("GameCfg.BackHillGraphs.SixthAnniversaryJPGraph"))
	PLATFORM_CODE = var_1
	PLATFORM_JP = var_2

	if var_1 ~= var_2 then
		PLATFORM_CODE = var_1
		PLATFORM_CHT = var_2

		if var_1 == var_2 then
			setActive = var_1

			var_1(arg_2_0.map_shujuhuigu, true)

			setActive = var_1

			var_1(arg_2_0.upper_shujuhuigu, true)
		else
			setActive = var_1

			var_1(arg_2_0.map_shujuhuigu, false)

			setActive = var_1

			var_1(arg_2_0.upper_shujuhuigu, false)
		end

		return
	end
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/Back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SFX_CANCEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_4.Find(var_3_5, "top/Home")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.quickExitFunc(var_5_0)

		return
	end

	SFX_PANEL = var_3_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_3_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_4.Find(var_3_9, "top/Help")

	local function var_3_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.jp6th_biaohoushan_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_3_9

	var_1_10001(var_3_8, var_3_10, var_3_11, var_3_9)

	getProxy = var_1_10001
	ActivityProxy = var_3_8

	local var_3_12 = var_1_10001(var_3_8)
	local var_3_13 = var_1.getActivityById

	ActivityConst = var_3_10

	local var_3_14 = var_3_13(var_3_12, var_3_10.MINIGAME_ZUMA)

	arg_3_0:InitStudents(var_3_14 and var_3_14.id, 2, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jiujiuwenquan", function()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_7_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_7_1(var_7_0, var_7_2, var_2_10004.SIXTH_ANNIVERSARY_JP_HOTSPRING)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "shujuhuigu", function()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_8_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_8_1(var_8_0, var_8_2, var_2_10004.SUMMARY)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "shijiandiaocha", function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.SceneAnimMgr.GetInstance()
		local var_9_1 = var_0.SixthAnniversaryJPCoverGoScene

		SCENE = var_2_10003

		var_9_1(var_9_0, var_2_10003.SIXTH_ANNIVERSARY_JP_DARK)

		return
	end)
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:UpdateView()

	pg = var_2

	local var_3_15 = var_2.activity_template

	ActivityConst = var_3_12

	local var_3_16 = var_3_15[var_3_12.MINIGAME_ZUMA].config_client.biaohoushanstory

	pg = var_3

	local var_3_17 = var_3.NewStoryMgr.GetInstance()

	var_3.Play(var_3_17, var_3_16)

	return
end

function var_0_1.HotSpringTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_10_0 = var_1_10000(var_1_10002)
	local var_10_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_10_2 = var_10_1(var_10_0, var_1_10003.ACTIVITY_TYPE_HOTSPRING)

	Activity = var_1_10001

	return var_1_10001.IsActivityReady(var_10_2)
end

function var_0_1.ZumaTip()
	LaunchBallActivityMgr = var_1_10000

	local var_11_0 = var_1_10000.IsTip

	ActivityConst = var_1_10002

	local var_11_1

	if not var_11_0(var_1_10002.MINIGAME_ZUMA) then
		LaunchBallTaskMgr = var_11_1
		var_11_1 = var_11_1.GetRedTip()
	end

	return var_11_1
end

function var_0_1.UpdateView(arg_12_0)
	setActive = var_1_10001

	local var_12_0 = arg_12_0.upper_jiujiuwenquan

	var_1_10001(var_3.Find(var_12_0, "Tip"), var_0_1.HotSpringTip())

	setActive = var_1_10001

	local var_12_1 = arg_12_0.upper_shijiandiaocha

	var_1_10001(var_3.Find(var_12_1, "Tip"), var_0_1.ZumaTip())

	return
end

function var_0_1.willExit(arg_13_0)
	arg_13_0:clearStudents()
	var_0_1.super.willExit(arg_13_0)

	return
end

function var_0_1.IsShowMainTip(arg_14_0)
	if arg_14_0 and not arg_14_0:isEnd() then
		local var_14_0

		if not var_0_1.HotSpringTip() then
			var_14_0 = var_0_1.ZumaTip()
		end

		return var_14_0
	end

	return
end

function var_0_1.onBackPressed(arg_15_0)
	arg_15_0:emit(var_0_1.ON_HOME)

	return
end

return var_0_1
