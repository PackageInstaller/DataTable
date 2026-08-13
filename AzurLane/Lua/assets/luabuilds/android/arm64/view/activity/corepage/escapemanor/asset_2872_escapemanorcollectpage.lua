class = var_0_10000

local var_0_0 = "EscapeManorCollectPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.DOA.DOACoreActivityCollectPage"))

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
	EscapeManorCollectMsgBox = var_1
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

	arg_2_0.equipSkinBoxBtn = var_2.Find(var_2_6, "equip_skin_box")

	if arg_2_0.equipSkinBoxBtn and var_2_1.equipskin_box_link then
		Drop = var_2

		local var_2_7 = var_2.New({
			type = var_2_1.equipskin_box_link.drop_type,
			id = var_2_1.equipskin_box_link.drop_id
		})
		local var_2_8 = var_2.getOwnedCount(var_2_7)

		onButton = var_2_0

		local var_2_9 = arg_2_0
		local var_2_10 = arg_2_0.equipSkinBoxBtn

		local function var_2_11()
			local var_4_0 = arg_2_0.msgBox

			var_0.ExecuteAction(var_4_0, "Show", {
				drop_type = var_2_1.equipskin_box_link.drop_type,
				drop_id = var_2_1.equipskin_box_link.drop_id,
				count = var_2_8,
				skipable_list = var_2_1.equipskin_box_link.list
			})

			return
		end

		SFX_PANEL = var_1_10008

		var_2_0(var_2_9, var_2_10, var_2_11, var_1_10008)
	end

	return
end

function var_0_1.UpdatePage(arg_5_0, arg_5_1)
	arg_5_0.curPage = arg_5_1
	Clone = var_1_10002
	arg_5_0.showDataList = var_1_10002(arg_5_0.dataList)
	table = var_2

	local var_5_0 = var_2.sort
	local var_5_1 = arg_5_0.showDataList

	CompareFuncs = var_1_10005

	var_5_0(var_5_1, var_1_10005({
		function(arg_6_0)
			return arg_6_0.count < arg_6_0.config.count and 0 or 1
		end,
		function(arg_7_0)
			return arg_7_0.config.order
		end,
		function(arg_8_0)
			return arg_8_0.id
		end
	}))

	local var_5_2 = arg_5_0.itemList

	var_2.align(var_5_2, #arg_5_0.showDataList)

	return
end

function var_0_1.OnUpdateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.showDataList[arg_9_1 + 1]
	local var_9_1 = arg_9_2:Find("icon_mask/icon")
	local var_9_2 = {
		type = var_9_0.config.type,
		id = var_9_0.config.drop_id
	}

	updateDrop = var_6

	var_6(var_9_1, var_9_2)

	onButton = var_6

	local var_9_3 = arg_9_0
	local var_9_4 = var_9_1

	local function var_9_5()
		local var_10_0 = arg_9_0

		var_0.OnClickItem(var_10_0, var_9_0)

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_9_3, var_9_4, var_9_5, var_1_10011)

	changeToScrollText = var_6

	local var_9_6 = arg_9_2:Find("name_mask/name")

	Drop = var_9_4

	local var_9_7 = var_9_4.New({
		type = var_9_0.config.type,
		id = var_9_0.config.drop_id
	})

	var_6(var_9_6, var_9.getName(var_9_7))
	arg_9_0:RefreshCountText(var_9_0, arg_9_2)

	GetOrAddComponent = var_6

	local var_9_8 = arg_9_2:Find("owner")

	typeof = var_9
	CanvasGroup = var_11
	var_6(var_9_8, var_9(var_11)).alpha = var_9_0.count == var_9_0.config.count and 0.5 or 1
	setActive = var_7

	var_7(arg_9_2:Find("new"), var_9_0.config.is_new == "1")

	if var_9_2.type == 4 then
		setActive = var_7

		var_7(arg_9_2:Find("got"), var_9_0.count >= 1)
	else
		setActive = var_7

		var_7(arg_9_2:Find("got"), var_9_0.count == var_9_0.config.count)
	end

	return
end

return var_0_1
