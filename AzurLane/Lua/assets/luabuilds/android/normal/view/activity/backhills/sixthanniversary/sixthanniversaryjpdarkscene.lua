class = var_0_10000

local var_0_0 = "SixthAnniversaryJPDarkScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.STATUS_LOCK = 1
var_0_1.STATUS_FOG = 2
var_0_1.STATUS_STORY = 3
var_0_1.STATUS_NOROMAL = 4
var_0_1.ARROW_ANIM_DELTA = 20
var_0_1.ARROW_ANIM_TIME = 0.5

function var_0_1.getUIName(arg_1_0)
	return "SixthAnniversaryJPDarkUI"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0._bg = var_1.Find(var_2_1, "BG")

	local var_2_2 = arg_2_0._tf

	arg_2_0.countText = var_1.Find(var_2_2, "top/Count/Text")
	setText = var_1

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "top/Count/explain")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("jp6th_lihoushan_pt1"))

	local var_2_5 = arg_2_0._tf

	arg_2_0.levelcontainer = var_1.Find(var_2_5, "upper")
	getProxy = var_1
	PlayerProxy = var_2_5

	local var_2_6 = var_1(var_2_5)

	arg_2_0.player = var_1.getRawData(var_2_6)
	ActivityConst = var_1
	arg_2_0.activityID = var_1.MINIGAME_ZUMA
	pg = var_1
	arg_2_0.config = var_1.activity_template[arg_2_0.activityID]
	arg_2_0.arrowPosYList = {}

	for iter_2_0 = 1, 7 do
		local var_2_7 = arg_2_0._tf
		local var_2_8 = var_5.Find

		tostring = var_1_10007

		local var_2_9 = var_2_8(var_2_7, var_1_10007(iter_2_0), arg_2_0.levelcontainer)

		arg_2_0.arrowPosYList[iter_2_0] = var_2_9:Find("arrow").localPosition.y
	end

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "top/Back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "top/Home")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.quickExitFunc(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_3.Find(var_3_9, "top/Help")

	local function var_3_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.jp6th_lihoushan_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_8, var_3_10, var_3_11, var_5)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0._tf
	local var_3_14 = var_3.Find(var_3_13, "top/Shop")

	local function var_3_15()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		SixthAnniversaryJPDarkMediator = var_2_10002

		local var_7_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.ZUMA_PT_SHOP)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_12, var_3_14, var_3_15, var_5)

	onButton = var_1_10001

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0._tf
	local var_3_18 = var_3.Find(var_3_17, "top/Task")

	local function var_3_19()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		SixthAnniversaryJPDarkMediator = var_2_10002

		local var_8_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003.LAUNCH_BALL_TASK)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_16, var_3_18, var_3_19, var_5)

	onButton = var_1_10001

	local var_3_20 = arg_3_0
	local var_3_21 = arg_3_0._tf
	local var_3_22 = var_3.Find(var_3_21, "BG/door")

	local function var_3_23()
		pg = var_2_10000

		local var_9_0 = var_2_10000.SceneAnimMgr.GetInstance()
		local var_9_1 = var_0.SixthAnniversaryJPCoverGoScene

		SCENE = var_2_10002

		var_9_1(var_9_0, var_2_10002.SIXTH_ANNIVERSARY_JP)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_20, var_3_22, var_3_23, var_5)

	local var_3_24 = arg_3_0

	arg_3_0.UpdateView(var_3_24)

	local var_3_25 = arg_3_0.config.config_client.lihoushanstory

	pg = var_3_24

	local var_3_26 = var_3_24.NewStoryMgr.GetInstance()

	var_2.Play(var_3_26, var_3_25)

	return
end

function var_0_1.UpdateView(arg_10_0)
	arg_10_0:UpdateLevels()
	arg_10_0:UpdateCount()
	arg_10_0:UpdateTaskTip()

	return
end

function var_0_1.UpdateLevels(arg_11_0)
	LaunchBallActivityMgr = var_1_10001
	arg_11_0.unlockCnt = var_1_10001.GetActivityDay(arg_11_0.activityID)
	LaunchBallActivityMgr = var_1
	arg_11_0.finishCnt = var_1.GetRoundCount(arg_11_0.activityID)
	LaunchBallActivityMgr = var_1
	arg_11_0.maxCnt = var_1.GetRoundCountMax(arg_11_0.activityID)

	local var_11_0

	if not (arg_11_0.finishCnt < arg_11_0.maxCnt) or not (arg_11_0.finishCnt + 1) then
		var_11_0 = -1
	end

	arg_11_0.curIndex = var_11_0

	for iter_11_0 = 1, 7 do
		local var_11_1 = arg_11_0._tf
		local var_11_2 = var_5.Find

		tostring = var_1_10007

		local var_11_3 = var_11_2(var_11_1, var_1_10007(iter_11_0), arg_11_0.levelcontainer)

		var_1_10007 = arg_11_0

		local var_11_4 = arg_11_0.GetLevelStatus(var_1_10007, iter_11_0)

		arg_11_0:UpdateLevelByStatus(var_11_3, var_11_4)
	end

	for iter_11_1 = 1, 3 do
		local var_11_5 = arg_11_0.levelcontainer
		local var_11_6 = var_5.Find(var_11_5, "role" .. iter_11_1)

		LaunchBallActivityMgr = var_11_5

		local var_11_7 = var_11_5.CheckZhuanShuAble(arg_11_0.activityID, iter_11_1)

		LaunchBallActivityMgr = var_1_10007
		var_1_10007 = var_1_10007.IsFinishZhuanShu(arg_11_0.activityID, iter_11_1)
		setActive = var_8

		var_8(var_11_6, var_11_7 and not var_1_10007)

		onButton = var_8

		local var_11_8 = arg_11_0
		local var_11_9 = var_11_6

		local function var_11_10()
			local var_12_0 = arg_11_0.config.config_client.roleStory[iter_11_1]

			pg = var_1

			local var_12_1 = var_1.NewStoryMgr.GetInstance()

			var_1.Play(var_12_1, var_12_0, function()
				LaunchBallActivityMgr = var_3_10000

				local var_13_0 = var_3_10000.OpenGame

				LaunchBallGameConst = var_3_10001

				var_13_0(var_3_10001.round_type_zhuanshu, iter_11_1)

				return
			end)

			return
		end

		SFX_PANEL = var_1_10012

		var_8(var_11_8, var_11_9, var_11_10, var_1_10012)
	end

	local var_11_11 = arg_11_0.levelcontainer
	local var_11_12 = var_1.Find(var_11_11, "endless")
	local var_11_13 = arg_11_0.finishCnt
	local var_11_14 = arg_11_0.maxCnt <= var_11_13

	setActive = var_3

	var_3(var_11_12, var_11_14)

	onButton = var_3

	local var_11_15 = arg_11_0
	local var_11_16 = var_11_12

	local function var_11_17()
		LaunchBallActivityMgr = var_2_10000

		local var_14_0 = var_2_10000.OpenGame

		LaunchBallGameConst = var_2_10001

		var_14_0(var_2_10001.round_type_wuxian, 1)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_11_15, var_11_16, var_11_17, var_1_10007)

	return
end

function var_0_1.GetLevelStatus(arg_15_0, arg_15_1)
	local var_15_0 = var_0_1.STATUS_NOROMAL

	if arg_15_1 <= arg_15_0.finishCnt then
		var_15_0 = var_0_1.STATUS_NOROMAL
	elseif arg_15_1 == arg_15_0.curIndex then
		if arg_15_1 <= arg_15_0.unlockCnt then
			local var_15_1 = arg_15_0.config.config_client.zumaStory[arg_15_1]

			pg = var_1_10004

			local var_15_2 = var_1_10004.NewStoryMgr.GetInstance()

			if var_4.IsPlayed(var_15_2, var_15_1) then
				var_15_0 = var_0_1.STATUS_NOROMAL
			else
				var_15_0 = var_0_1.STATUS_STORY
			end
		else
			var_15_0 = var_0_1.STATUS_LOCK
		end
	else
		var_15_0 = var_0_1.STATUS_FOG
	end

	return var_15_0
end

function var_0_1.UpdateLevelByStatus(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 == var_0_1.STATUS_LOCK then
		setActive = var_3

		var_3(arg_16_1:Find("lock"), true)

		setActive = var_3

		var_3(arg_16_1:Find("title/lock"), true)

		setActive = var_3

		var_3(arg_16_1:Find("fog"), false)

		setActive = var_3

		var_3(arg_16_1:Find("tag"), false)

		onButton = var_3

		local var_16_0 = arg_16_0
		local var_16_1 = arg_16_1

		function var_1_10006()
			pg = var_2_10000

			local var_17_0 = var_2_10000.TipsMgr.GetInstance()
			local var_17_1 = var_0.ShowTips

			i18n = var_2_10002

			var_17_1(var_17_0, var_2_10002("jp6th_lihoushan_time"))

			return
		end

		SFX_PANEL = var_1_10007

		var_3(var_16_0, var_16_1, var_1_10006, var_1_10007)
	elseif arg_16_2 == var_0_1.STATUS_FOG then
		setActive = var_3

		var_3(arg_16_1:Find("lock"), false)

		setActive = var_3

		var_3(arg_16_1:Find("title/lock"), false)

		setActive = var_3

		var_3(arg_16_1:Find("fog"), true)

		setActive = var_3

		var_3(arg_16_1:Find("tag"), false)

		onButton = var_3

		local var_16_2 = arg_16_0
		local var_16_3 = arg_16_1

		function var_1_10006()
			pg = var_2_10000

			local var_18_0 = var_2_10000.TipsMgr.GetInstance()
			local var_18_1 = var_0.ShowTips

			i18n = var_2_10002

			var_18_1(var_18_0, var_2_10002("jp6th_lihoushan_order"))

			return
		end

		SFX_PANEL = var_1_10007

		var_3(var_16_2, var_16_3, var_1_10006, var_1_10007)
	elseif arg_16_2 == var_0_1.STATUS_STORY then
		setActive = var_3

		var_3(arg_16_1:Find("lock"), false)

		setActive = var_3

		var_3(arg_16_1:Find("title/lock"), false)

		setActive = var_3

		var_3(arg_16_1:Find("fog"), false)

		setActive = var_3

		var_3(arg_16_1:Find("tag"), false)

		onButton = var_3

		local var_16_4 = arg_16_0
		local var_16_5 = arg_16_1

		function var_1_10006()
			local var_19_0 = arg_16_0.config.config_client.zumaStory

			tonumber = var_2_10001

			local var_19_1 = var_19_0[var_2_10001(arg_16_1.name)]

			pg = var_1

			local var_19_2 = var_1.NewStoryMgr.GetInstance()

			var_1.Play(var_19_2, var_19_1, function()
				local var_20_0 = arg_16_0

				var_0.UpdateLevels(var_20_0)

				return
			end)

			return
		end

		SFX_PANEL = var_1_10007

		var_3(var_16_4, var_16_5, var_1_10006, var_1_10007)
	elseif arg_16_2 == var_0_1.STATUS_NOROMAL then
		setActive = var_3

		var_3(arg_16_1:Find("lock"), false)

		setActive = var_3

		var_3(arg_16_1:Find("title/lock"), false)

		setActive = var_3

		var_3(arg_16_1:Find("fog"), false)

		setActive = var_3

		var_3(arg_16_1:Find("tag"), true)

		onButton = var_3

		local var_16_6 = arg_16_0
		local var_16_7 = arg_16_1

		function var_1_10006()
			LaunchBallActivityMgr = var_2_10000

			local var_21_0 = var_2_10000.OpenGame

			LaunchBallGameConst = var_2_10001

			local var_21_1 = var_2_10001.round_type_juqing

			tonumber = var_2_10002

			var_21_0(var_21_1, var_2_10002(arg_16_1.name))

			return
		end

		SFX_PANEL = var_1_10007

		var_3(var_16_6, var_16_7, var_1_10006, var_1_10007)
	end

	local var_16_8 = arg_16_1
	local var_16_9 = arg_16_1.Find(var_16_8, "arrow")

	LeanTween = var_16_8

	var_16_8.cancel(var_16_9.gameObject)

	tonumber = var_4

	if var_4(arg_16_1.name) == arg_16_0.curIndex then
		setLocalPosition = var_1_10006

		var_1_10006(var_16_9, {
			y = arg_16_0.arrowPosYList[var_4]
		})

		setActive = var_1_10006

		var_1_10006(var_16_9, true)

		LeanTween = var_1_10006

		local var_16_10 = var_1_10006.moveY(var_16_9, arg_16_0.arrowPosYList[var_4] + var_0_1.ARROW_ANIM_DELTA, var_0_1.ARROW_ANIM_TIME)

		var_1_10006.setLoopPingPong(var_16_10)
	else
		setActive = var_1_10006

		var_1_10006(var_16_9, false)
	end

	return
end

function var_0_1.UpdateCount(arg_22_0)
	setText = var_1_10001

	local var_22_0 = arg_22_0.countText

	LaunchBallActivityMgr = var_1_10003

	var_1_10001(var_22_0, var_1_10003.GetRemainCount(arg_22_0.activityID))

	return
end

function var_0_1.UpdateTaskTip(arg_23_0)
	setActive = var_1_10001

	local var_23_0 = arg_23_0.top
	local var_23_1 = var_2.Find(var_23_0, "Task/Tip")

	LaunchBallTaskMgr = var_23_0

	var_1_10001(var_23_1, var_23_0.GetRedTip())

	return
end

function var_0_1.onBackPressed(arg_24_0)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.emit

	SixthAnniversaryJPDarkMediator = var_1_10003

	local var_24_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_24_1(var_24_0, var_24_2, var_1_10004.SIXTH_ANNIVERSARY_JP)

	return
end

return var_0_1
