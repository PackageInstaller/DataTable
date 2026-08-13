class = var_0_10000

local var_0_0 = "IslandDrawAwardAllWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.View.page.msgbox.window.IslandBaseMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandDrawAwardAllMsgBox"
end

function var_0_1.OnInit(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.rtTitle

	i18n = var_1_10004

	var_1_10001(var_2_0, var_1_10004("island_draw_reward"))

	onButton = var_1_10001

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.btnClose

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_CANCEL = var_6

	var_1_10001(var_2_1, var_2_2, var_2_3, var_6)

	return
end

function var_0_1.OnShow(arg_4_0)
	var_0_1.super.OnShow(arg_4_0)
	arg_4_0:UpdateActivity(arg_4_0.settings.activity)

	return
end

function var_0_1.UpdateActivity(arg_5_0, arg_5_1)
	arg_5_0.activity = arg_5_1
	eachChild = var_1_10002

	var_1_10002(arg_5_0.rtRarities, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0.name
		local var_6_1 = arg_5_0.activity
		local var_6_2 = var_3.GetRankList(var_6_1, var_6_0)

		setText = var_2_10004

		local var_6_3 = arg_6_0:Find("title/Text")

		i18n = var_2_10007

		var_2_10004(var_6_3, var_2_10007("island_draw_" .. var_6_0))

		UIItemList = var_2_10004

		var_2_10004.StaticAlign(arg_6_0:Find("container"), arg_6_0:Find("container/tpl"), #var_6_2, function(arg_7_0, arg_7_1, arg_7_2)
			arg_7_1 = arg_7_1 + 1
			UIItemList = var_3_10003

			if arg_7_0 == var_3_10003.EventUpdate then
				unpack = var_3

				local var_7_0, var_7_1 = var_3(var_6_2[arg_7_1])

				pg = var_5

				local var_7_2 = var_5.island_draw_reward[var_7_0]

				Drop = var_3_10006

				local var_7_3 = var_3_10006.New({
					type = var_7_2.drop_type,
					id = var_7_2.drop_id
				})

				IslandShopDrawAwardPage = var_3_10007

				var_3_10007.ShowDropInfo(var_7_3, arg_7_2:Find("mask/Image"))

				setScrollText = var_7

				var_7(arg_7_2:Find("name/Text"), var_7_3:getName())

				setText = var_7

				local var_7_4 = arg_7_2:Find("got/got/Text")

				i18n = var_10

				var_7(var_7_4, var_10("island_draw_get"))

				setActive = var_7

				var_7(arg_7_2:Find("got"), not var_7_1)
			end

			return
		end)

		return
	end)

	return
end

return var_0_1
