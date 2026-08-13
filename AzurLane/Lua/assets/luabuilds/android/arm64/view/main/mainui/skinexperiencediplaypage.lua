class = var_0_10000

local var_0_0 = "SkinExperienceDiplayPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ExSkinListUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "window/list/content")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uilist = var_2_0(var_2_2, var_4.Find(var_2_3, "window/list/content/tpl"))
	arg_2_0.skinTimers = {}

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "window/top/btnBack")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CANCEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_CANCEL = var_3_1

	var_1_10001(var_3_4, var_3_5, var_3_6, var_3_1)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0._tf
	local var_3_9 = var_4.Find(var_3_8, "window/button_container/confirm_btn")

	local function var_3_10()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_CANCEL = var_3_8

	var_1_10001(var_3_7, var_3_9, var_3_10, var_3_8)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)
	arg_7_0:Display(arg_7_1)

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_0, arg_7_0._tf)

	return
end

function var_0_1.Hide(arg_8_0)
	var_0_1.super.Hide(arg_8_0)

	pg = var_1

	local var_8_0 = var_1.UIMgr.GetInstance()
	local var_8_1 = var_1.UnOverlayPanel
	local var_8_2 = arg_8_0._tf

	pg = var_1_10005

	var_8_1(var_8_0, var_8_2, var_1_10005.UIMgr.GetInstance()._normalUIMain)

	return
end

function var_0_1.Display(arg_9_0, arg_9_1)
	arg_9_0:Clear()

	local var_9_0 = arg_9_0.uilist

	var_2.make(var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_9_1[arg_10_1 + 1]

			setText = var_4

			var_4(arg_10_2:Find("name/Text"), var_10_0:getConfig("name"))

			local var_10_1

			if arg_9_0.skinTimers[var_10_0.id] then
				var_10_1 = arg_9_0.skinTimers[var_10_0.id]

				var_4.Stop(var_10_1)
			end

			local var_10_2 = arg_9_0.skinTimers
			local var_10_3 = var_10_0.id

			Timer = var_10_1
			var_10_2[var_10_3] = var_10_1.New(function()
				skinTimeStamp = var_3_10000

				local var_11_0 = var_10_0
				local var_11_1 = var_3_10000(var_2.getRemainTime(var_11_0))

				setText = var_3_10001

				local var_11_2 = arg_10_2

				var_3_10001(var_3.Find(var_11_2, "time/Text"), var_11_1)

				return
			end, 1, -1)

			local var_10_4 = arg_9_0.skinTimers[var_10_0.id]

			var_4.Start(var_10_4)
			arg_9_0.skinTimers[var_10_0.id].func()

			local var_10_5 = arg_10_2:Find("icon_bg/icon")

			LoadSpriteAsync = var_5

			var_5("qicon/" .. var_10_0:getIcon(), function(arg_12_0)
				IsNil = var_3_10001

				if not var_3_10001(arg_9_0._tf) then
					local var_12_0 = var_10_5
					local var_12_1 = var_1.GetComponent

					typeof = var_3_10004
					Image = var_3_10006
					var_12_1(var_12_0, var_3_10004(var_3_10006)).sprite = arg_12_0
				end

				return
			end)
		end

		return
	end)

	local var_9_1 = arg_9_0.uilist

	var_2.align(var_9_1, #arg_9_1)

	return
end

function var_0_1.Clear(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.skinTimers) do
		iter_13_1:Stop()
	end

	arg_13_0.skinTimers = {}

	return
end

function var_0_1.OnDestroy(arg_14_0)
	arg_14_0:Clear()

	arg_14_0.skinTimers = nil

	return
end

return var_0_1
