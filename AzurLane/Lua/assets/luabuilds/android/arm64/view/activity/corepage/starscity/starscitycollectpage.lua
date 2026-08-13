class = var_0_10000

local var_0_0 = "StarsCityCollectPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.EscapeManor.EscapeManorCollectPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	StarsCityCollectMsgBox = var_1
	arg_1_0.msgBox = var_1.New(arg_1_0._tf, arg_1_0.event)

	return
end

function var_0_1.AddSpecialBtnListener(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client")
	local var_2_2 = arg_2_0.btnList

	arg_2_0.furnitureThemeBtn = var_2.Find(var_2_2, "furniture_theme")

	if arg_2_0.furnitureThemeBtn and var_2_1.furniture_theme_link then
		onButton = var_2

		local var_2_3 = arg_2_0
		local var_2_4 = arg_2_0.furnitureThemeBtn

		local function var_2_5()
			local var_3_0 = var_2_1.furniture_theme_link[1]
			local var_3_1 = var_0[2]
			local var_3_2 = var_0[3]
			local var_3_3 = arg_2_0

			var_4.DoSkip(var_3_3, var_3_0, var_3_1)

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_2_3, var_2_4, var_2_5, var_1_10007)
	end

	local var_2_6 = arg_2_0.btnList

	arg_2_0.medalBtn = var_2.Find(var_2_6, "medal")

	if arg_2_0.medalBtn and var_2_1.medal_link then
		onButton = var_2

		local var_2_7 = arg_2_0
		local var_2_8 = arg_2_0.medalBtn

		local function var_2_9()
			local var_4_0 = var_2_1.medal_link[1]
			local var_4_1 = var_0[2]
			local var_4_2 = var_0[3]
			local var_4_3 = arg_2_0

			var_4.DoSkip(var_4_3, var_4_0, var_4_1)

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_2_7, var_2_8, var_2_9, var_1_10007)
	end

	local var_2_10 = arg_2_0.btnList

	arg_2_0.equipSkinBoxBtn = var_2.Find(var_2_10, "equip_skin_box")

	if arg_2_0.equipSkinBoxBtn and var_2_1.equipskin_box_link then
		Drop = var_2

		local var_2_11 = var_2.New({
			type = var_2_1.equipskin_box_link.drop_type,
			id = var_2_1.equipskin_box_link.drop_id
		})
		local var_2_12 = var_2.getOwnedCount(var_2_11)

		onButton = var_2_0

		local var_2_13 = arg_2_0
		local var_2_14 = arg_2_0.equipSkinBoxBtn

		local function var_2_15()
			local var_5_0 = arg_2_0.msgBox

			var_0.ExecuteAction(var_5_0, "Show", {
				drop_type = var_2_1.equipskin_box_link.drop_type,
				drop_id = var_2_1.equipskin_box_link.drop_id,
				count = var_2_12,
				skipable_list = var_2_1.equipskin_box_link.list
			})

			return
		end

		SFX_PANEL = var_1_10008

		var_2_0(var_2_13, var_2_14, var_2_15, var_1_10008)
	end

	return
end

return var_0_1
