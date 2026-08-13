class = var_0_10000

local var_0_0 = "SkinExpireDisplayPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SkinOverDueUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "window/list/scrollrect/content")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uilist = var_2_0(var_2_2, var_4.Find(var_2_3, "window/list/scrollrect/content/tpl"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "window/button_container/confirm_btn")

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
	local var_3_9 = var_4.Find(var_3_8, "window/top/btnBack")

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

function var_0_1.Display(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.uilist

	var_2.make(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_8_1[arg_9_1 + 1]

			setText = var_4

			var_4(arg_9_2:Find("name/Text"), var_9_0:getConfig("name"))

			local var_9_1 = arg_9_2:Find("icon_bg/icon")

			LoadSpriteAsync = var_2_10005

			var_2_10005("qicon/" .. var_9_0:getIcon(), function(arg_10_0)
				IsNil = var_3_10001

				if not var_3_10001(arg_8_0._tf) then
					local var_10_0 = var_9_1
					local var_10_1 = var_1.GetComponent

					typeof = var_3_10004
					Image = var_3_10006
					var_10_1(var_10_0, var_3_10004(var_3_10006)).sprite = arg_10_0
				end

				return
			end)
		end

		return
	end)

	local var_8_1 = arg_8_0.uilist

	var_2.align(var_8_1, #arg_8_1)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.UIMgr.GetInstance()
	local var_11_1 = var_1.UnOverlayPanel
	local var_11_2 = arg_11_0._tf

	pg = var_1_10005

	var_11_1(var_11_0, var_11_2, var_1_10005.UIMgr.GetInstance()._normalUIMain)

	return
end

return var_0_1
