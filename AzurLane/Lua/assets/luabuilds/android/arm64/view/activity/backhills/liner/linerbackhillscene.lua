class = var_0_10000

local var_0_0 = "LinerBackHillScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillTemplate"))

var_0_1.optionsPath = {
	"top/btn_home"
}
ActivityConst = var_1
var_0_1.ACT_ID = var_1.LINER_ID
var_0_1.MINIGAME_ID = 65
ActivityConst = var_1
var_0_1.TASK_ACT_ID = var_1.LINER_SIGN_ID
ActivityConst = var_1
var_0_1.NAME_ID = var_1.LINER_NAMED_ID

function var_0_1.getUIName(arg_1_0)
	return "LinerBackHillUI"
end

function var_0_1.getBGM(arg_2_0)
	local var_2_0 = arg_2_0.activity

	return var_1.getConfig(var_2_0, "config_client").backHillBgm[var_0_1.IsDay() and "day" or "night"]
end

function var_0_1.IsDay()
	pg = var_1_10000

	local var_3_0 = var_1_10000.TimeMgr.GetInstance()
	local var_3_1 = var_0.GetServerHour(var_3_0)

	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_2 = var_1_10001(var_1_10003)
	local var_3_3 = var_1.getActivityById(var_3_2, var_0_1.ACT_ID)

	assert = var_3_0

	var_3_0(var_3_3 and not var_3_3:isEnd(), "not exist liner act, type: " .. var_0_1.ACT_ID)

	return var_3_1 >= var_3_3:getConfig("config_client").time[1] and var_3_1 < var_2[2]
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0._dayTF = var_1.Find(var_4_0, "day")

	local var_4_1 = arg_4_0._tf

	arg_4_0._nightTF = var_1.Find(var_4_1, "night")

	for iter_4_0 = 0, arg_4_0._dayTF.childCount - 1 do
		local var_4_2 = arg_4_0._dayTF
		local var_4_3 = var_5.GetChild(var_4_2, iter_4_0)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_4_3).name
		arg_4_0["day_" .. var_1_10006] = var_4_3
	end

	for iter_4_1 = 0, arg_4_0._nightTF.childCount - 1 do
		local var_4_4 = arg_4_0._nightTF
		local var_4_5 = var_5.GetChild(var_4_4, iter_4_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_4_5).name
		arg_4_0["night_" .. var_1_10006] = var_4_5
	end

	arg_4_0._map = arg_4_0._dayTF
	arg_4_0._upper = arg_4_0._nightTF

	local var_4_6 = arg_4_0._tf

	arg_4_0._log_tip = var_1.Find(var_4_6, "top/btn_log/tip")

	local var_4_7 = arg_4_0._tf

	arg_4_0._unlock = var_1.Find(var_4_7, "top/unlock_info")
	getProxy = var_1
	ActivityProxy = var_4_7

	local var_4_8 = var_1(var_4_7)

	arg_4_0.activity = var_1.getActivityById(var_4_8, var_0_1.ACT_ID)
	pg = var_1
	arg_4_0.timeMgr = var_1.TimeMgr.GetInstance()

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_4.Find(var_5_1, "top/btn_back")

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.emit(var_6_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_4.Find(var_5_5, "top/btn_help")

	local function var_5_7()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip["7th_main_tip"].tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_5_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5_5)
	arg_5_0:BindItemSkinShop()
	arg_5_0:BindItemBuildShip()
	arg_5_0:InitFacilityCross(arg_5_0._dayTF, arg_5_0._nightTF, "btn_game", function()
		local var_8_0 = arg_5_0
		local var_8_1 = var_0.emit

		LinerBackHillMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.GO_MINIGAME, var_0_1.MINIGAME_ID)

		return
	end)
	arg_5_0:InitFacilityCross(arg_5_0._dayTF, arg_5_0._nightTF, "btn_cruise", function()
		local var_9_0 = arg_5_0
		local var_9_1 = var_0.emit

		LinerBackHillMediator = var_2_10003

		local var_9_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_9_1(var_9_0, var_9_2, var_2_10004.LINER)

		PlayerPrefs = var_9_1

		var_9_1.SetString("LinerBackHillScene", var_0_1.GetDate())

		return
	end)

	local var_5_8 = arg_5_0

	arg_5_0.InitFacilityCross(var_5_8, arg_5_0._dayTF, arg_5_0._nightTF, "btn_task", function()
		local var_10_0 = arg_5_0
		local var_10_1 = var_0.emit

		LinerBackHillMediator = var_2_10003

		local var_10_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_10_1(var_10_0, var_10_2, var_2_10004.ACTIVITY, {
			id = var_0_1.TASK_ACT_ID
		})

		return
	end)

	getProxy = var_1
	ActivityProxy = var_5_8

	local var_5_9 = var_1(var_5_8)
	local var_5_10 = var_1.getActivityById(var_5_9, var_0_1.TASK_ACT_ID)
	local var_5_11 = var_1.getConfig(var_5_10, "config_client").preStory

	pg = var_5_9

	local var_5_12 = var_5_9.NewStoryMgr.GetInstance()
	local var_5_13 = not var_3.IsPlayed(var_5_12, var_5_11)

	onButton = var_5_10

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0._tf
	local var_5_16 = var_7.Find(var_5_15, "top/btn_log")

	local function var_5_17()
		if var_5_13 then
			pg = var_0

			local var_11_0 = var_0.TipsMgr.GetInstance()
			local var_11_1 = var_0.ShowTips

			i18n = var_2_10003

			var_11_1(var_11_0, var_2_10003("liner_activity_lock"))
		else
			local var_11_2 = arg_5_0
			local var_11_3 = var_0.emit

			LinerBackHillMediator = var_2_10003

			local var_11_4 = var_2_10003.GO_SUBLAYER

			Context = var_2_10004

			local var_11_5 = var_2_10004.New
			local var_11_6 = {}

			LinerLogBookMediator = var_2_10007
			var_11_6.mediator = var_2_10007
			LinerLogBookLayer = var_2_10007
			var_11_6.viewComponent = var_2_10007

			var_11_3(var_11_2, var_11_4, var_11_5(var_11_6))
		end

		return
	end

	SFX_PANEL = var_5_15

	var_5_10(var_5_14, var_5_16, var_5_17, var_5_15)

	setActive = var_5_10

	var_5_10(arg_5_0.day_btn_task, var_5_13)

	setActive = var_5_10

	var_5_10(arg_5_0.night_btn_task, var_5_13)

	setActive = var_5_10

	var_5_10(arg_5_0._unlock, var_5_13)

	setActive = var_5_10

	var_5_10(arg_5_0.day_btn_cruise, not var_5_13)

	setActive = var_5_10

	var_5_10(arg_5_0.night_btn_cruise, not var_5_13)

	setActive = var_5_10

	var_5_10(arg_5_0._dayTF, var_0_1.IsDay())

	setActive = var_5_10

	var_5_10(arg_5_0._nightTF, not var_0_1.IsDay())
	arg_5_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0._log_tip, var_0_1.LogTip())

	setActive = var_1_10001

	local var_12_0 = arg_12_0.day_btn_game

	var_1_10001(var_3.Find(var_12_0, "tip"), var_0_1.MiniGameTip())

	setActive = var_1_10001

	local var_12_1 = arg_12_0.night_btn_game

	var_1_10001(var_3.Find(var_12_1, "tip"), var_0_1.MiniGameTip())

	setActive = var_1_10001

	local var_12_2 = arg_12_0.day_btn_cruise

	var_1_10001(var_3.Find(var_12_2, "tip"), var_0_1.CruiseTip())

	setActive = var_1_10001

	local var_12_3 = arg_12_0.night_btn_cruise

	var_1_10001(var_3.Find(var_12_3, "tip"), var_0_1.CruiseTip())

	return
end

function var_0_1.GetDate()
	pg = var_1_10000

	local var_13_0 = var_1_10000.TimeMgr.GetInstance()
	local var_13_1 = var_0.STimeDescC

	pg = var_1_10003

	local var_13_2 = var_1_10003.TimeMgr.GetInstance()

	return var_13_1(var_13_0, var_3.GetServerTime(var_13_2), "%Y/%m/%d")
end

function var_0_1.LogTip()
	LinerLogBookLayer = var_1_10000

	return var_1_10000.IsTip()
end

function var_0_1.MiniGameTip()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_15_0 = var_1_10000(var_1_10002)

	return var_0.GetHubByGameId(var_15_0, var_0_1.MINIGAME_ID).count > 0
end

function var_0_1.CruiseTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_16_0 = var_1_10000(var_1_10002)
	local var_16_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_16_2 = var_16_1(var_16_0, var_1_10003.ACTIVITY_TYPE_LINER)
	local var_16_3 = var_0.IsFinishAllTime(var_16_2)

	PlayerPrefs = var_1_10001

	local var_16_4 = var_1_10001.GetString("LinerBackHillScene") == var_0_1.GetDate()

	return not var_16_3 and not var_16_4
end

function var_0_1.IsShowMainTip(arg_17_0)
	if arg_17_0 and not arg_17_0:isEnd() then
		local var_17_0

		if not var_0_1.LogTip() and not var_0_1.MiniGameTip() then
			var_17_0 = var_0_1.CruiseTip()
		end

		return var_17_0
	end

	return
end

function var_0_1.willExit(arg_18_0)
	return
end

return var_0_1
