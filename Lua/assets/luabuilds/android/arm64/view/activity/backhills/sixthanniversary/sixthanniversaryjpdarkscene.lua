local var_0_0 = class("SixthAnniversaryJPDarkScene", import("view.base.BaseUI"))

var_0_0.STATUS_LOCK = 1
var_0_0.STATUS_FOG = 2
var_0_0.STATUS_STORY = 3
var_0_0.STATUS_NOROMAL = 4
var_0_0.ARROW_ANIM_DELTA = 20
var_0_0.ARROW_ANIM_TIME = 0.5

function var_0_0.getUIName(arg_1_0)
	return "SixthAnniversaryJPDarkUI"
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0.top = arg_2_0._tf:Find("top")
	arg_2_0._bg = arg_2_0._tf:Find("BG")
	arg_2_0.countText = arg_2_0._tf:Find("top/Count/Text")

	setText(arg_2_0._tf:Find("top/Count/explain"), i18n("jp6th_lihoushan_pt1"))

	arg_2_0.levelcontainer = arg_2_0._tf:Find("upper")
	arg_2_0.player = getProxy(PlayerProxy):getRawData()
	arg_2_0.activityID = ActivityConst.MINIGAME_ZUMA
	arg_2_0.config = pg.activity_template[arg_2_0.activityID]
	arg_2_0.arrowPosYList = {}

	for iter_2_0 = 1, 7 do
		local var_2_0 = arg_2_0._tf:Find(tostring(iter_2_0), arg_2_0.levelcontainer)

		arg_2_0.arrowPosYList[iter_2_0] = var_2_0:Find("arrow").localPosition.y
	end

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Back"), function()
		arg_3_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Home"), function()
		arg_3_0:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.jp6th_lihoushan_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Shop"), function()
		arg_3_0:emit(SixthAnniversaryJPDarkMediator.GO_SCENE, SCENE.ZUMA_PT_SHOP)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Task"), function()
		arg_3_0:emit(SixthAnniversaryJPDarkMediator.GO_SCENE, SCENE.LAUNCH_BALL_TASK)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("BG/door"), function()
		pg.SceneAnimMgr.GetInstance():SixthAnniversaryJPCoverGoScene(SCENE.SIXTH_ANNIVERSARY_JP)

		return
	end, SFX_PANEL)
	arg_3_0:UpdateView()
	pg.NewStoryMgr.GetInstance():Play(arg_3_0.config.config_client.lihoushanstory)

	return
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0:UpdateLevels()
	arg_10_0:UpdateCount()
	arg_10_0:UpdateTaskTip()

	return
end

function var_0_0.UpdateLevels(arg_11_0)
	arg_11_0.unlockCnt = LaunchBallActivityMgr.GetActivityDay(arg_11_0.activityID)
	arg_11_0.finishCnt = LaunchBallActivityMgr.GetRoundCount(arg_11_0.activityID)
	arg_11_0.maxCnt = LaunchBallActivityMgr.GetRoundCountMax(arg_11_0.activityID)

	if arg_11_0.finishCnt < arg_11_0.maxCnt then
		arg_11_0.curIndex = arg_11_0.finishCnt + 1 or -1

		for iter_11_0 = 1, 7 do
			arg_11_0:UpdateLevelByStatus(arg_11_0._tf:Find(tostring(iter_11_0), arg_11_0.levelcontainer), (arg_11_0:GetLevelStatus(iter_11_0)))
		end

		for iter_11_1 = 1, 3 do
			local var_11_0 = arg_11_0.levelcontainer:Find("role" .. iter_11_1)
			local var_11_1 = LaunchBallActivityMgr.IsFinishZhuanShu(arg_11_0.activityID, iter_11_1)

			setActive(var_11_0, LaunchBallActivityMgr.CheckZhuanShuAble(arg_11_0.activityID, iter_11_1) and not var_11_1)
			onButton(arg_11_0, var_11_0, function()
				pg.NewStoryMgr.GetInstance():Play(arg_11_0.config.config_client.roleStory[iter_11_1], function()
					LaunchBallActivityMgr.OpenGame(LaunchBallGameConst.round_type_zhuanshu, iter_11_1)

					return
				end)

				return
			end, SFX_PANEL)
		end

		local var_11_2 = arg_11_0.levelcontainer:Find("endless")

		setActive(var_11_2, arg_11_0.finishCnt >= arg_11_0.maxCnt)
		onButton(arg_11_0, var_11_2, function()
			LaunchBallActivityMgr.OpenGame(LaunchBallGameConst.round_type_wuxian, 1)

			return
		end, SFX_PANEL)

		return
	end
end

function var_0_0.GetLevelStatus(arg_15_0, arg_15_1)
	return arg_15_1 <= arg_15_0.finishCnt and var_0_0.STATUS_NOROMAL or arg_15_1 == arg_15_0.curIndex and (arg_15_1 <= arg_15_0.unlockCnt and (pg.NewStoryMgr.GetInstance():IsPlayed(arg_15_0.config.config_client.zumaStory[arg_15_1]) and var_0_0.STATUS_NOROMAL or var_0_0.STATUS_STORY) or var_0_0.STATUS_LOCK) or var_0_0.STATUS_FOG
end

function var_0_0.UpdateLevelByStatus(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 == var_0_0.STATUS_LOCK then
		setActive(arg_16_1:Find("lock"), true)
		setActive(arg_16_1:Find("title/lock"), true)
		setActive(arg_16_1:Find("fog"), false)
		setActive(arg_16_1:Find("tag"), false)
		onButton(arg_16_0, arg_16_1, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("jp6th_lihoushan_time"))

			return
		end, SFX_PANEL)
	elseif arg_16_2 == var_0_0.STATUS_FOG then
		setActive(arg_16_1:Find("lock"), false)
		setActive(arg_16_1:Find("title/lock"), false)
		setActive(arg_16_1:Find("fog"), true)
		setActive(arg_16_1:Find("tag"), false)
		onButton(arg_16_0, arg_16_1, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("jp6th_lihoushan_order"))

			return
		end, SFX_PANEL)
	elseif arg_16_2 == var_0_0.STATUS_STORY then
		setActive(arg_16_1:Find("lock"), false)
		setActive(arg_16_1:Find("title/lock"), false)
		setActive(arg_16_1:Find("fog"), false)
		setActive(arg_16_1:Find("tag"), false)
		onButton(arg_16_0, arg_16_1, function()
			pg.NewStoryMgr.GetInstance():Play(arg_16_0.config.config_client.zumaStory[tonumber(arg_16_1.name)], function()
				arg_16_0:UpdateLevels()

				return
			end)

			return
		end, SFX_PANEL)
	elseif arg_16_2 == var_0_0.STATUS_NOROMAL then
		setActive(arg_16_1:Find("lock"), false)
		setActive(arg_16_1:Find("title/lock"), false)
		setActive(arg_16_1:Find("fog"), false)
		setActive(arg_16_1:Find("tag"), true)
		onButton(arg_16_0, arg_16_1, function()
			LaunchBallActivityMgr.OpenGame(LaunchBallGameConst.round_type_juqing, tonumber(arg_16_1.name))

			return
		end, SFX_PANEL)
	end

	local var_16_0 = arg_16_1:Find("arrow")

	LeanTween.cancel(var_16_0.gameObject)

	local var_16_1 = tonumber(arg_16_1.name)

	if var_16_1 == arg_16_0.curIndex then
		setLocalPosition(var_16_0, {
			y = arg_16_0.arrowPosYList[var_16_1]
		})
		setActive(var_16_0, true)
		LeanTween.moveY(var_16_0, arg_16_0.arrowPosYList[var_16_1] + var_0_0.ARROW_ANIM_DELTA, var_0_0.ARROW_ANIM_TIME):setLoopPingPong()
	else
		setActive(var_16_0, false)
	end

	return
end

function var_0_0.UpdateCount(arg_22_0)
	setText(arg_22_0.countText, LaunchBallActivityMgr.GetRemainCount(arg_22_0.activityID))

	return
end

function var_0_0.UpdateTaskTip(arg_23_0)
	setActive(arg_23_0.top:Find("Task/Tip"), LaunchBallTaskMgr.GetRedTip())

	return
end

function var_0_0.onBackPressed(arg_24_0)
	arg_24_0:emit(SixthAnniversaryJPDarkMediator.GO_SCENE, SCENE.SIXTH_ANNIVERSARY_JP)

	return
end

return var_0_0
