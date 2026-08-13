class = var_0_10000

local var_0_0 = "EducateUnlockTipLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.EducateBaseUI"))

var_0_1.UNLOCK_TYPE_SYSTEM = 1
var_0_1.UNLOCK_TYPE_SITE = 2
var_0_1.UNLOCK_TYPE_PLAN = 3
var_0_1.UNLOCK_NEW_SECRETARY = 4

function var_0_1.getUIName(arg_1_0)
	return "EducateUnlockTip"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "anim_root")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.anim = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "anim_root")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.animEvent = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0.animEvent

	var_1.SetEndEvent(var_2_6, function()
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, var_0_1.ON_CLOSE)

		return
	end)

	pg = var_1

	local var_2_7 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_7, arg_2_0._tf)

	local var_2_8 = arg_2_0._tf

	arg_2_0._tipTF = var_1.Find(var_2_8, "anim_root/tip")

	local var_2_9 = arg_2_0._tipTF

	arg_2_0.contentTF = var_1.Find(var_2_9, "tip_bg/layout/title/name")
	setText = var_1

	local var_2_10 = arg_2_0._tipTF
	local var_2_11 = var_2.Find(var_2_10, "tip_bg/layout/title/unlock")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("child_unlock_tip"))

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:setContent()

	return
end

function var_0_1.setContent(arg_5_0)
	local var_5_0 = ""

	switch = var_1_10002

	var_1_10002(arg_5_0.contextData.type, {
		[var_0_1.UNLOCK_TYPE_SYSTEM] = function()
			EducateTipHelper = var_2_10000
			var_5_0 = var_2_10000.system_tip_list[arg_5_0.contextData.single]

			return
		end,
		[var_0_1.UNLOCK_TYPE_SITE] = function()
			ipairs = var_2_10000

			for iter_7_0, iter_7_1 in var_2_10000(arg_5_0.contextData.list) do
				local var_7_0 = var_5_0

				pg = var_2_10006
				var_5_0 = var_7_0 .. var_2_10006.child_site[iter_7_1].name .. " "
			end

			return
		end,
		[var_0_1.UNLOCK_TYPE_PLAN] = function()
			ipairs = var_2_10000

			for iter_8_0, iter_8_1 in var_2_10000(arg_5_0.contextData.list) do
				local var_8_0 = var_5_0

				pg = var_2_10006
				var_5_0 = var_8_0 .. var_2_10006.child_plan[iter_8_1].name .. " "
			end

			return
		end,
		[var_0_1.UNLOCK_NEW_SECRETARY] = function()
			i18n = var_2_10000
			var_5_0 = var_2_10000("child_unlock_new_secretary")

			return
		end
	})

	setText = var_1_10002

	local var_5_1 = arg_5_0.contentTF

	shortenString = var_4

	var_1_10002(var_5_1, var_4(var_5_0, 15))

	return
end

function var_0_1.saveTipRecord(arg_10_0)
	switch = var_1_10001

	var_1_10001(arg_10_0.contextData.type, {
		[var_0_1.UNLOCK_TYPE_SYSTEM] = function()
			EducateTipHelper = var_2_10000

			var_2_10000.SaveSystemUnlockTip(arg_10_0.contextData.single)

			return
		end,
		[var_0_1.UNLOCK_TYPE_SITE] = function()
			ipairs = var_2_10000

			for iter_12_0, iter_12_1 in var_2_10000(arg_10_0.contextData.list) do
				EducateTipHelper = var_2_10005

				var_2_10005.SaveSiteUnlockTipId(iter_12_1)
			end

			return
		end,
		[var_0_1.UNLOCK_TYPE_PLAN] = function()
			ipairs = var_2_10000

			for iter_13_0, iter_13_1 in var_2_10000(arg_10_0.contextData.list) do
				EducateTipHelper = var_2_10005

				var_2_10005.SavePlanUnlockTipId(iter_13_1)
			end

			return
		end
	})

	return
end

function var_0_1.onBackPressed(arg_14_0)
	return
end

function var_0_1.willExit(arg_15_0)
	arg_15_0:saveTipRecord()

	pg = var_1

	local var_15_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_0, arg_15_0._tf)

	if arg_15_0.contextData.onExit then
		arg_15_0.contextData.onExit()
	end

	return
end

return var_0_1
