class = var_0_10000

local var_0_0 = "AgoraDecorationSortPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAgoraDecSortUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "frame")
	local var_2_3 = arg_2_0._tf

	arg_2_0.sortUIItemList = var_2_0(var_2_2, var_4.Find(var_2_3, "frame/tpl"))

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

function var_0_1.Show(arg_5_0, arg_5_1, arg_5_2)
	var_0_1.super.Show(arg_5_0)

	arg_5_0.indexData = arg_5_1
	arg_5_0.callback = arg_5_2

	arg_5_0:InitList()

	return
end

function var_0_1.InitList(arg_6_0)
	local var_6_0 = arg_6_0.sortUIItemList

	var_1.make(var_6_0, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			AgoraFurnitureType = var_3

			local var_7_0 = var_3.SORT_LIST[arg_7_1 + 1]
			local var_7_1 = arg_6_0.indexData.sortKey == var_7_0

			setText = var_2_10005

			local var_7_2 = arg_7_2:Find("Text")

			setColorStr = var_2_10008
			AgoraFurnitureType = var_10

			var_2_10005(var_7_2, var_2_10008(var_10.Sort2CN(var_7_0), var_7_1 and "#393a3c" or "#7c7e81"))

			onButton = var_2_10005

			local var_7_3 = arg_6_0
			local var_7_4 = arg_7_2

			local function var_7_5()
				if arg_6_0.callback then
					arg_6_0.callback(var_7_0)
				end

				local var_8_0 = arg_6_0

				var_0.Hide(var_8_0)

				return
			end

			SFX_PANEL = var_10

			var_2_10005(var_7_3, var_7_4, var_7_5, var_10)
		end

		return
	end)

	local var_6_1 = arg_6_0.sortUIItemList
	local var_6_2 = var_1.align

	AgoraFurnitureType = var_4

	var_6_2(var_6_1, #var_4.SORT_LIST)

	return
end

function var_0_1.Hide(arg_9_0)
	var_0_1.super.Hide(arg_9_0)

	arg_9_0.callback = nil

	return
end

function var_0_1.OnDestroy(arg_10_0)
	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_1
