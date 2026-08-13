class = var_0_10000

local var_0_0 = "VoteAwardWindowPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "VoteAwardWindowUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.currToggle = var_1.Find(var_2_0, "frame/toggle/curr")

	local var_2_1 = arg_2_0._tf

	arg_2_0.accToggle = var_1.Find(var_2_1, "frame/toggle/acc")
	VoteAwardPtWindow = var_1
	arg_2_0.ptWindow = var_1.New(arg_2_0._tf, arg_2_0)

	local var_2_2 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_2, "frame/close")
	setText = var_1

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "frame/title/Text")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("vote_lable_window_title"))

	setText = var_1

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_2.Find(var_2_5, "frame/panel/list/tpl/award1/mask/Text")

	i18n = var_2_5

	var_1(var_2_6, var_2_5("vote_lable_rearch"))

	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.Find(var_2_7, "frame/panel/list/tpl/award/mask/Text")

	i18n = var_2_7

	var_1(var_2_8, var_2_7("vote_lable_rearch"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onToggle = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.currToggle

	local function var_3_2(arg_4_0)
		local var_4_0 = arg_3_0.currPtData

		if arg_4_0 and var_4_0 then
			local var_4_1 = arg_3_0.ptWindow
			local var_4_2 = var_2.Show
			local var_4_3 = {}

			VoteAwardPtWindow = var_2_10005
			var_4_3.type = var_2_10005.TYPE_CURR
			var_4_3.dropList = var_4_0.dropList
			var_4_3.targets = var_4_0.targets
			var_4_3.level = var_4_0.level
			var_4_3.count = var_4_0.count

			var_4_2(var_4_1, var_4_3)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onToggle = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.accToggle

	local function var_3_5(arg_5_0)
		local var_5_0 = arg_3_0.accPtData

		if arg_5_0 and var_5_0 then
			local var_5_1 = arg_3_0.ptWindow
			local var_5_2 = var_2.Show
			local var_5_3 = {}

			VoteAwardPtWindow = var_2_10005
			var_5_3.type = var_2_10005.TYPE_ACC
			var_5_3.dropList = var_5_0.dropList
			var_5_3.targets = var_5_0.targets
			var_5_3.level = var_5_0.level
			var_5_3.count = var_5_0.count

			var_5_2(var_5_1, var_5_3)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.closeBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0._tf

	local function var_3_11()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	return
end

function var_0_1.Show(arg_8_0)
	var_0_1.super.Show(arg_8_0)

	arg_8_0.currPtData = arg_8_0:GenCurrPtData()

	local var_8_0 = arg_8_0

	arg_8_0.accPtData = arg_8_0.GenAccPtData(var_8_0)

	if arg_8_0.currPtData ~= nil then
		local var_8_1 = #arg_8_0.currPtData.targets
		local var_8_2

		if not (0 < var_8_1) then
			var_8_2 = false
		else
			var_8_2 = true
		end

		setActive = var_8_0

		var_8_0(arg_8_0.currToggle, var_8_2)

		if var_8_2 then
			triggerToggle = var_8_0

			var_8_0(arg_8_0.currToggle, true)
		else
			triggerToggle = var_8_0

			var_8_0(arg_8_0.accToggle, true)
		end

		pg = var_8_0

		local var_8_3 = var_8_0.UIMgr.GetInstance()

		var_2.BlurPanel(var_8_3, arg_8_0._tf)

		return
	end
end

function var_0_1.Hide(arg_9_0)
	var_0_1.super.Hide(arg_9_0)

	pg = var_1

	local var_9_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf, arg_9_0._parentTf)

	return
end

function var_0_1.GenCurrPtData(arg_10_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)
	local var_10_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if var_10_1(var_10_0, var_1_10003.ACTIVITY_TYPE_VOTE) and not var_1:isEnd() then
		local var_10_2 = var_1
		local var_10_3 = var_1.getConfig(var_10_2, "config_id")

		pg = var_10_2

		local var_10_4 = var_10_2.activity_vote[var_10_3]
		local var_10_5 = {}
		local var_10_6 = {}

		ipairs = var_1_10006

		for iter_10_0, iter_10_1 in var_1_10006(var_10_4.period_reward) do
			table = var_1_10011

			var_1_10011.insert(var_10_6, iter_10_1[1])
		end

		ipairs = var_6

		for iter_10_2, iter_10_3 in var_6(var_10_4.period_reward_display) do
			table = var_1_10011

			var_1_10011.insert(var_10_5, iter_10_3)
		end

		local var_10_7 = var_1.data2
		local var_10_8 = 0

		pairs = var_8

		for iter_10_4, iter_10_5 in var_8(var_10_6) do
			if iter_10_5 <= var_10_7 then
				var_10_8 = iter_10_4
			end
		end

		local var_10_9 = {}

		VoteAwardPtWindow = var_9
		var_10_9.type = var_9.TYPE_CURR
		var_10_9.dropList = var_10_5
		var_10_9.targets = var_10_6
		var_10_9.level = var_10_8
		var_10_9.count = var_10_7

		return var_10_9
	end

	return
end

function var_0_1.GenAccPtData(arg_11_0)
	local var_11_0

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_11_1 = var_1_10002(var_1_10003)
	local var_11_2 = var_2.getActivityById

	ActivityConst = var_1_10004

	if var_11_2(var_11_1, var_1_10004.VOTE_ENTRANCE_ACT_ID) and not var_2:isEnd() then
		local var_11_3 = var_2
		local var_11_4 = var_2.getConfig(var_11_3, "config_client")[1]

		getProxy = var_11_3
		ActivityProxy = var_5

		local var_11_5 = var_11_3(var_5)
		local var_11_6 = var_4.getActivityById(var_11_5, var_11_4)

		ActivityPtData = var_11_5
		var_11_0 = var_11_5.New(var_11_6)
	end

	return var_11_0
end

function var_0_1.OnDestroy(arg_12_0)
	if arg_12_0:isShowing() then
		arg_12_0:Hide()
	end

	if arg_12_0.ptWindow then
		arg_12_0.ptWindow = nil
	end

	return
end

return var_0_1
