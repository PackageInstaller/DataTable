class = var_0_10000

local var_0_0 = "IslandAwardDisplayPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.TYPE_COMMON = 1
var_0_1.TYPE_SHIP_SKILL = 2
var_0_1.TYPE_SHIP_BREAK = 3
var_0_1.TYPE_SIGN_GIFT = 4
var_0_1.AUTO_COLLECT = 5

function var_0_1.getUIName(arg_1_0)
	return "IslandAwardDisplayConatiner"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = var_0_1.TYPE_COMMON

	IslandAwardDisplayWindow = var_1_10003
	var_2_0[var_2_1] = var_1_10003.New(arg_2_0._tf)

	local var_2_2 = var_0_1.TYPE_SHIP_SKILL

	IslandAwardDisplay4ShipSkillWindow = var_3
	var_2_0[var_2_2] = var_3.New(arg_2_0._tf)

	local var_2_3 = var_0_1.TYPE_SHIP_BREAK

	IslandAwardDisplay4ShipBreakWindow = var_3
	var_2_0[var_2_3] = var_3.New(arg_2_0._tf)

	local var_2_4 = var_0_1.TYPE_SIGN_GIFT

	IslandAwardDisplay4SignGiftWindow = var_3
	var_2_0[var_2_4] = var_3.New(arg_2_0._tf)

	local var_2_5 = var_0_1.AUTO_COLLECT

	IslandAutoCollectAwardDisplayWindow = var_3
	var_2_0[var_2_5] = var_3.New(arg_2_0._tf)
	arg_2_0.windows = var_2_0

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		if not arg_3_0.window then
			return
		end

		if arg_3_0.playing then
			return
		end

		arg_3_0.playing = true

		local var_4_0 = arg_3_0.window

		var_0.PlayExitAniamtion(var_4_0, function()
			arg_3_0.playing = false

			if arg_3_0.callback then
				arg_3_0.callback()

				arg_3_0.callback = nil
			end

			local var_5_0 = arg_3_0

			var_0.Hide(var_5_0)

			return
		end)

		arg_3_0.window = nil

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	var_0_1.super.Show(arg_6_0)

	assert = var_2

	var_2(not arg_6_0:AnyWindowShowing(), "同时只能存在一个奖励界面")
	arg_6_0:HideWindows()

	local var_6_0

	if not arg_6_1.type then
		var_6_0 = var_0_1.TYPE_COMMON
	end

	arg_6_0.callback = arg_6_1.callback

	local var_6_1 = arg_6_0.windows[var_6_0]

	var_3.ExecuteAction(var_6_1, "Show", arg_6_1)

	arg_6_0.window = var_3

	return
end

function var_0_1.AnyWindowShowing(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.windows) do
		if iter_7_1:GetLoaded() and iter_7_1:isShowing() then
			return true
		end
	end

	return false
end

function var_0_1.HideWindows(arg_8_0)
	pairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0.windows) do
		arg_8_0:HideWindow(iter_8_1, iter_8_0)
	end

	return
end

function var_0_1.HideWindow(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1:GetLoaded() and arg_9_1:isShowing() then
		if arg_9_2 == var_0_1.TYPE_COMMON then
			arg_9_1:Hide()
		else
			arg_9_1:Destroy()
			arg_9_1:Reset()
		end
	end

	return
end

function var_0_1.Hide(arg_10_0)
	var_0_1.super.Hide(arg_10_0)
	arg_10_0:HideWindows()

	arg_10_0.callback = nil

	return
end

function var_0_1.OnDestroy(arg_11_0)
	local var_11_0 = arg_11_0.windows[var_0_1.TYPE_COMMON]

	if var_1.GetLoaded(var_11_0) and var_1:isShowing() then
		var_1:Destroy()

		window = var_2

		var_2:Reset()
	end

	return
end

return var_0_1
