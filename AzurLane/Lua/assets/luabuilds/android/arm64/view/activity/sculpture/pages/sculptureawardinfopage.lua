class = var_0_10000

local var_0_0 = "SculptureAwardInfoPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SculptureAwardInfoUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "frame/scrollrect/content")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uilist = var_2_0(var_2_2, var_4.Find(var_2_3, "frame/scrollrect/content/tpl"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	var_0_1.super.Show(arg_5_0)

	arg_5_0.activity = arg_5_1

	arg_5_0:UpdateList()

	setText = var_2

	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_4.Find(var_5_0, "frame/tip")

	i18n = var_1_10005

	var_2(var_5_1, var_1_10005("sculpture_close_tip"))

	return
end

function var_0_1.UpdateList(arg_6_0)
	local var_6_0 = arg_6_0.activity
	local var_6_1 = var_1.getConfig(var_6_0, "config_data")
	local var_6_2 = arg_6_0.uilist

	var_2.make(var_6_2, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_6_0

			var_3.UpdateCard(var_7_0, var_6_1[arg_7_1 + 1], arg_7_2)
		end

		return
	end)

	local var_6_3 = arg_6_0.uilist

	var_2.align(var_6_3, #var_6_1)

	return
end

function var_0_1.UpdateCard(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.activity
	local var_8_1 = var_3.GetAwards(var_8_0, arg_8_1)
	local var_8_2 = arg_8_0.activity
	local var_8_3 = var_4.GetResorceName(var_8_2, arg_8_1)
	local var_8_4 = arg_8_2:Find("icon/mask/image")
	local var_8_5 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	local var_8_6 = var_8_5(var_8_4, var_8(var_1_10010))

	LoadSpriteAtlasAsync = var_8_2

	var_8_2("SculptureRole/" .. var_8_3 .. "_normal", nil, function(arg_9_0)
		if arg_8_0.exited then
			return
		end

		var_8_6.sprite = arg_9_0

		local var_9_0 = var_8_6

		var_1.SetNativeSize(var_9_0)

		return
	end)

	setText = var_8_2

	local var_8_7 = arg_8_2:Find("Text")

	HXSet = var_9

	local var_8_8 = var_9.hxLan
	local var_8_9 = arg_8_0.activity

	var_8_2(var_8_7, var_8_8(var_11.GetAwardDesc(var_8_9, arg_8_1)))

	UIItemList = var_8_2

	local var_8_10 = var_8_2.New(arg_8_2:Find("awards"), arg_8_2:Find("awards/tpl"))

	var_6.make(var_8_10, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = var_8_1[arg_10_1 + 1]
			local var_10_1 = {
				type = var_10_0[1],
				id = var_10_0[2],
				count = var_10_0[3]
			}

			updateDrop = var_5

			var_5(arg_10_2, var_10_1)

			onButton = var_5

			local var_10_2 = arg_8_0
			local var_10_3 = arg_10_2

			local function var_10_4()
				local var_11_0 = arg_8_0
				local var_11_1 = var_0.emit

				BaseUI = var_3_10003

				var_11_1(var_11_0, var_3_10003.ON_DROP, var_10_1)

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_10_2, var_10_3, var_10_4, var_2_10010)
		end

		return
	end)
	var_6:align(#var_8_1)

	setActive = var_7

	local var_8_11 = arg_8_2
	local var_8_12 = arg_8_2.Find(var_8_11, "mask")
	local var_8_13 = arg_8_0.activity
	local var_8_14 = var_10.GetSculptureState(var_8_13, arg_8_1)

	SculptureActivity = var_8_11

	var_7(var_8_12, var_8_14 == var_8_11.STATE_FINSIH)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	return
end

return var_0_1
