local var_0_0 = class("IslandAwardDisplayPage", import("view.base.BaseSubView"))

var_0_0.TYPE_COMMON = 1
var_0_0.TYPE_SHIP_SKILL = 2
var_0_0.TYPE_SHIP_BREAK = 3
var_0_0.TYPE_SIGN_GIFT = 4
var_0_0.AUTO_COLLECT = 5

function var_0_0.getUIName(arg_1_0)
	return "IslandAwardDisplayConatiner"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.windows = {
		[var_0_0.TYPE_COMMON] = IslandAwardDisplayWindow.New(arg_2_0._tf),
		[var_0_0.TYPE_SHIP_SKILL] = IslandAwardDisplay4ShipSkillWindow.New(arg_2_0._tf),
		[var_0_0.TYPE_SHIP_BREAK] = IslandAwardDisplay4ShipBreakWindow.New(arg_2_0._tf),
		[var_0_0.TYPE_SIGN_GIFT] = IslandAwardDisplay4SignGiftWindow.New(arg_2_0._tf),
		[var_0_0.AUTO_COLLECT] = IslandAutoCollectAwardDisplayWindow.New(arg_2_0._tf)
	}

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		if not arg_3_0.window then
			return
		end

		if arg_3_0.playing then
			return
		end

		arg_3_0.playing = true

		arg_3_0.window:PlayExitAniamtion(function()
			arg_3_0.playing = false

			if arg_3_0.callback then
				arg_3_0.callback()

				arg_3_0.callback = nil
			end

			arg_3_0:Hide()

			return
		end)

		arg_3_0.window = nil

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	var_0_0.super.Show(arg_6_0)
	assert(not arg_6_0:AnyWindowShowing(), "同时只能存在一个奖励界面")
	arg_6_0:HideWindows()

	local var_6_0 = arg_6_1.type or var_0_0.TYPE_COMMON

	arg_6_0.callback = arg_6_1.callback

	arg_6_0.windows[var_6_0]:ExecuteAction("Show", arg_6_1)

	arg_6_0.window = arg_6_0.windows[var_6_0]

	return
end

function var_0_0.AnyWindowShowing(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.windows) do
		if iter_7_1:GetLoaded() and iter_7_1:isShowing() then
			return true
		end
	end

	return false
end

function var_0_0.HideWindows(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.windows) do
		arg_8_0:HideWindow(iter_8_1, iter_8_0)
	end

	return
end

function var_0_0.HideWindow(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1:GetLoaded() and arg_9_1:isShowing() then
		if arg_9_2 == var_0_0.TYPE_COMMON then
			arg_9_1:Hide()
		else
			arg_9_1:Destroy()
			arg_9_1:Reset()
		end
	end

	return
end

function var_0_0.Hide(arg_10_0)
	var_0_0.super.Hide(arg_10_0)
	arg_10_0:HideWindows()

	arg_10_0.callback = nil

	return
end

function var_0_0.OnDestroy(arg_11_0)
	if arg_11_0.windows[var_0_0.TYPE_COMMON]:GetLoaded() and arg_11_0.windows[var_0_0.TYPE_COMMON]:isShowing() then
		arg_11_0.windows[var_0_0.TYPE_COMMON]:Destroy()
		window:Reset()
	end

	return
end

return var_0_0
