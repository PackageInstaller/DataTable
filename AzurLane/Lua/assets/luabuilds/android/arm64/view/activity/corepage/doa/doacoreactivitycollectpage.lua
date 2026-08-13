class = var_0_10000

local var_0_0 = "DOACoreActivityCollectPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.templatePage.CoreAwardTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.btnList = var_1.Find(var_1_1, "btn_list")

	local var_1_2 = arg_1_0.bg

	arg_1_0.itemPanel = var_1.Find(var_1_2, "item_panel")

	local var_1_3 = arg_1_0.itemPanel

	arg_1_0.togglesTF = var_1.Find(var_1_3, "toggles")

	local var_1_4 = arg_1_0.itemPanel

	arg_1_0.content = var_1.Find(var_1_4, "item_list/content")
	UIItemList = var_1

	local var_1_5 = var_1.New
	local var_1_6 = arg_1_0.content
	local var_1_7 = arg_1_0.content

	arg_1_0.itemList = var_1_5(var_1_6, var_4.Find(var_1_7, "tpl"))
	DOACoreActivityMsgBox = var_1
	arg_1_0.msgBox = var_1.New(arg_1_0._tf, arg_1_0.event)

	return
end

function var_0_1.GetTogglesDropTypes(arg_2_0)
	local var_2_0 = {}

	DROP_TYPE_EQUIP = var_1_10002
	var_2_0[1] = var_1_10002
	DROP_TYPE_SPWEAPON = var_1_10002
	var_2_0[2] = var_1_10002

	return var_2_0
end

function var_0_1.OnClickItem(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.msgBox

	var_2.ExecuteAction(var_3_0, "Show", {
		drop_type = arg_3_1.config.type,
		drop_id = arg_3_1.config.drop_id,
		count = arg_3_1.count,
		count_limit = arg_3_1.config.count,
		skipable_list = arg_3_1.config.link_params
	})

	return
end

function var_0_1.AddSpecialBtnListener(arg_4_0)
	local var_4_0 = arg_4_0.activity
	local var_4_1 = var_1.getConfig(var_4_0, "config_client")
	local var_4_2 = arg_4_0.btnList

	arg_4_0.furnitureThemeBtn = var_2.Find(var_4_2, "furniture_theme")

	if arg_4_0.furnitureThemeBtn and var_4_1.furniture_theme_link then
		onButton = var_2

		local var_4_3 = arg_4_0
		local var_4_4 = arg_4_0.furnitureThemeBtn

		local function var_4_5()
			local var_5_0 = var_4_1.furniture_theme_link[1]
			local var_5_1 = var_0[2]
			local var_5_2 = var_0[3]
			local var_5_3 = arg_4_0

			var_4.DoSkip(var_5_3, var_5_0, var_5_1)

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_4_3, var_4_4, var_4_5, var_1_10007)
	end

	local var_4_6 = arg_4_0.btnList

	arg_4_0.medalBtn = var_2.Find(var_4_6, "medal")

	if arg_4_0.medalBtn and var_4_1.medal_link then
		onButton = var_2

		local var_4_7 = arg_4_0
		local var_4_8 = arg_4_0.medalBtn

		local function var_4_9()
			local var_6_0 = var_4_1.medal_link[1]
			local var_6_1 = var_0[2]
			local var_6_2 = var_0[3]
			local var_6_3 = arg_4_0

			var_4.DoSkip(var_6_3, var_6_0, var_6_1)

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_4_7, var_4_8, var_4_9, var_1_10007)
	end

	local var_4_10 = arg_4_0.btnList

	arg_4_0.equipSkinBoxBtn = var_2.Find(var_4_10, "equip_skin_box")

	if arg_4_0.equipSkinBoxBtn and var_4_1.equipskin_box_link then
		Drop = var_2

		local var_4_11 = var_2.New({
			type = var_4_1.equipskin_box_link.drop_type,
			id = var_4_1.equipskin_box_link.drop_id
		})
		local var_4_12 = var_2.getOwnedCount(var_4_11)

		onButton = var_4_0

		local var_4_13 = arg_4_0
		local var_4_14 = arg_4_0.equipSkinBoxBtn

		local function var_4_15()
			local var_7_0 = arg_4_0.msgBox

			var_0.ExecuteAction(var_7_0, "Show", {
				drop_type = var_4_1.equipskin_box_link.drop_type,
				drop_id = var_4_1.equipskin_box_link.drop_id,
				count = var_4_12,
				skipable_list = var_4_1.equipskin_box_link.list
			})

			return
		end

		SFX_PANEL = var_1_10008

		var_4_0(var_4_13, var_4_14, var_4_15, var_1_10008)
	end

	return
end

function var_0_1.OnHideFlush(arg_8_0)
	local var_8_0 = arg_8_0.msgBox

	if var_1.isShowing(var_8_0) then
		local var_8_1 = arg_8_0.msgBox

		var_1.Hide(var_8_1)
	end

	return
end

function var_0_1.OnDestroy(arg_9_0)
	if arg_9_0.msgBox then
		local var_9_0 = arg_9_0.msgBox

		var_1.Hide(var_9_0)

		local var_9_1 = arg_9_0.msgBox

		var_1.Destroy(var_9_1)

		arg_9_0.msgBox = nil
	end

	return
end

return var_0_1
