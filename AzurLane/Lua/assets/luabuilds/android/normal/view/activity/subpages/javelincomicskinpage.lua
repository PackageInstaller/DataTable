class = var_0_10000

local var_0_0 = "JavelinComicSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

var_0_1.FADE_OUT_TIME = 1

function var_0_1.OnFirstFlush(arg_1_0)
	arg_1_0:InitView()
	arg_1_0:RegisterEvent()
	var_0_1.super.OnFirstFlush(arg_1_0)

	return
end

function var_0_1.InitView(arg_2_0)
	arg_2_0.animations = {}

	local var_2_0 = arg_2_0.bg

	arg_2_0.puzzle = var_1.Find(var_2_0, "Puzzle")

	local var_2_1 = arg_2_0

	arg_2_0.linkActId = arg_2_0.GetLinkId(var_2_1)
	getProxy = var_1
	ActivityProxy = var_2_1
	arg_2_0.activityProxy = var_1(var_2_1)
	Clone = var_1

	local var_2_2 = arg_2_0.activityProxy

	arg_2_0.chargeIDList = var_1(var_2.getActivityById(var_2_2, arg_2_0.linkActId).data1_list)
	Clone = var_1
	pg = var_2
	arg_2_0.puzzleIDList = var_1(var_2.activity_template[arg_2_0.linkActId].config_data)

	arg_2_0:CheckFinalAward()

	return
end

function var_0_1.RegisterEvent(arg_3_0)
	local var_3_0 = arg_3_0.bg

	arg_3_0.helpBtn = var_1.Find(var_3_0, "HelpBtn")
	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.helpBtn

	local function var_3_3()
		pg = var_2_10000

		if var_2_10000.gametip.comic_help then
			pg = var_0

			local var_4_0 = var_0.MsgboxMgr.GetInstance()
			local var_4_1 = var_0.ShowMsgBox
			local var_4_2 = {}

			MSGBOX_TYPE_HELP = var_2_10003
			var_4_2.type = var_2_10003
			pg = var_2_10003
			var_4_2.helps = var_2_10003.gametip.comic_help.tip

			var_4_1(var_4_0, var_4_2)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_1, var_3_2, var_3_3, var_1_10005)

	return
end

function var_0_1.GetLinkId(arg_5_0)
	pg = var_1_10001

	return var_1_10001.activity_const.JAVELIN_COMIC_PUZZLE_TASK.act_id
end

function var_0_1.OnUpdateFlush(arg_6_0)
	var_0_1.super.OnUpdateFlush(arg_6_0)

	local var_6_0 = arg_6_0.activityProxy

	arg_6_0.linkActivity = var_1.getActivityById(var_6_0, arg_6_0.linkActId)

	local var_6_1 = true

	for iter_6_0 = 1, #arg_6_0.puzzleIDList do
		local var_6_2 = arg_6_0.puzzle
		local var_6_3 = var_6.GetChild(var_6_2, iter_6_0 - 1)
		local var_6_4 = arg_6_0.puzzleIDList[iter_6_0]

		table = var_8

		local var_6_5 = var_8.contains(arg_6_0.linkActivity.data1_list, var_6_4)

		arg_6_0:UpdatePuzzle(var_6_3, var_6_5, var_6_4)

		if not var_6_5 then
			var_6_1 = false
		end
	end

	arg_6_0:UpdateMainView(var_6_1)

	return
end

function var_0_1.UpdatePuzzle(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 then
		table = var_1_10004

		if not var_1_10004.contains(arg_7_0.chargeIDList, arg_7_3) then
			table = var_1_10004

			var_1_10004.insert(arg_7_0.chargeIDList, arg_7_3)
			arg_7_0:DoPieceAnimation(arg_7_1, 0, 1, function()
				setActive = var_2_10000

				var_2_10000(arg_7_1, arg_7_2)

				local var_8_0 = arg_7_0

				var_0.CheckFinalAward(var_8_0)

				return
			end)

			goto label_7_0
		end
	end

	setActive = var_1_10004

	var_1_10004(arg_7_1, arg_7_2)

	::label_7_0::

	return
end

function var_0_1.DoPieceAnimation(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	LeanTween = var_1_10005

	if var_1_10005.isTweening(arg_9_1) then
		LeanTween = var_5

		local var_9_0 = var_5.cancel

		go = var_6

		var_9_0(var_6(arg_9_1), true)

		arg_9_0.animations[arg_9_1] = nil
	end

	local var_9_1 = arg_9_0.animations

	var_9_1[arg_9_1] = true
	LeanTween = var_9_1

	local var_9_2 = var_9_1.alpha(arg_9_1, arg_9_3, var_0_1.FADE_OUT_TIME)
	local var_9_3 = var_5.setFrom(var_9_2, arg_9_2)
	local var_9_4 = var_5.setOnComplete

	System = var_7

	var_9_4(var_9_3, var_7.Action(arg_9_4))

	return
end

function var_0_1.UpdateMainView(arg_10_0, arg_10_1)
	local var_10_0

	if #arg_10_0.chargeIDList == #arg_10_0.taskGroup then
		var_10_0 = "<color=#00FF00><size=48>" .. #arg_10_0.chargeIDList .. "</size></color><color=#00B8FF><size=28>     " .. #arg_10_0.taskGroup .. "</size></color>"
	else
		var_10_0 = "<color=#E75198><size=48>" .. #arg_10_0.chargeIDList .. "</size></color><color=#00B8FF><size=28>     " .. #arg_10_0.taskGroup .. "</size></color>"
	end

	setText = var_3

	var_3(arg_10_0.dayTF, var_10_0)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	var_0_1.super.OnDestroy(arg_11_0)

	pairs = var_1

	local var_11_0

	if not arg_11_0.animations then
		var_11_0 = {}
	end

	for iter_11_0, iter_11_1 in var_1(var_11_0) do
		LeanTween = var_1_10006

		if var_1_10006.isTweening(iter_11_0.gameObject) then
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_11_0.gameObject)
		end
	end

	arg_11_0.animations = nil

	return
end

function var_0_1.CheckFinalAward(arg_12_0)
	local var_12_0 = arg_12_0.activityProxy

	if #var_1.getActivityById(var_12_0, arg_12_0.linkActId).data1_list == #arg_12_0.puzzleIDList then
		if var_1.data1 == 0 then
			arg_12_0:FetchFinalAward()
		else
			arg_12_0:OnFetchFinalAwardDone()
		end
	end

	return
end

function var_0_1.FetchFinalAward(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.emit

	ActivityMediator = var_1_10003

	var_13_1(var_13_0, var_1_10003.EVENT_OPERATION, {
		cmd = 1,
		activity_id = arg_13_0.linkActId
	})

	return
end

function var_0_1.OnFetchFinalAwardDone(arg_14_0)
	return
end

return var_0_1
