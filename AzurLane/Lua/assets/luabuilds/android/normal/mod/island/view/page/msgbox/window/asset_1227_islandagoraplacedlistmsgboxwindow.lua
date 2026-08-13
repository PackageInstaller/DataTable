class = var_0_10000

local var_0_0 = "IslandAgoraPlacedListMsgboxWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAgoraPlacedInfoMsgBox"
end

local function var_0_2(arg_2_0)
	local var_2_0 = {
		go = arg_2_0
	}
	local var_2_1 = arg_2_0.transform
	local var_2_2 = var_2.Find(var_2_1, "icon")
	local var_2_3 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005

	local var_2_4 = var_2_3(var_2_2, var_4(var_1_10005))
	local var_2_5 = arg_2_0.transform
	local var_2_6 = var_3.Find(var_2_5, "name")
	local var_2_7 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006

	local var_2_8 = var_2_7(var_2_6, var_5(var_1_10006))
	local var_2_9 = arg_2_0.transform
	local var_2_10 = var_4.Find(var_2_9, "count")
	local var_2_11 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007

	local var_2_12 = var_2_11(var_2_10, var_6(var_1_10007))
	local var_2_13 = arg_2_0.transform
	local var_2_14 = var_5.Find(var_2_13, "capacity")
	local var_2_15 = var_5.GetComponent

	typeof = var_7
	Text = var_1_10008

	local var_2_16 = var_2_15(var_2_14, var_7(var_1_10008))

	function var_2_0.Update(arg_3_0)
		var_2_8.text = arg_3_0.name
		var_2_12.text = "X" .. arg_3_0.count

		local var_3_0 = var_2_16

		var_3_0.text = arg_3_0.capacity
		LoadSpriteAsync = var_3_0

		var_3_0("island/IslandFurnitureIcon/" .. arg_3_0.icon, function(arg_4_0)
			var_2_4.sprite = arg_4_0

			return
		end)

		return
	end

	return var_2_0
end

function var_0_1.OnLoaded(arg_5_0)
	var_0_1.super.OnLoaded(arg_5_0)

	setText = var_1

	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_2.Find(var_5_0, "list/titles/1")

	i18n = var_5_0

	var_1(var_5_1, var_5_0("island_label_furniture"))

	setText = var_1

	local var_5_2 = arg_5_0._tf
	local var_5_3 = var_2.Find(var_5_2, "list/titles/2")

	i18n = var_5_2

	var_1(var_5_3, var_5_2("island_label_furniture_cnt"))

	setText = var_1

	local var_5_4 = arg_5_0._tf
	local var_5_5 = var_2.Find(var_5_4, "list/titles/3")

	i18n = var_5_4

	var_1(var_5_5, var_5_4("island_label_furniture_capacity"))

	local var_5_6 = arg_5_0._tf
	local var_5_7 = var_1.Find(var_5_6, "capacity")
	local var_5_8 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_5_0.capacityTxt = var_5_8(var_5_7, var_3(var_4))

	local var_5_9 = arg_5_0._tf
	local var_5_10 = var_1.Find(var_5_9, "list/scrollrect")

	arg_5_0.scrollRect = var_1.GetComponent(var_5_10, "LScrollRect")

	function arg_5_0.scrollRect.onInitItem(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.OnInitItem(var_6_0, arg_6_0)

		return
	end

	function arg_5_0.scrollRect.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.OnUpdateItem(var_7_0, arg_7_0, arg_7_1)

		return
	end

	arg_5_0.cards = {}

	return
end

function var_0_1.FlushBtn(arg_8_0, arg_8_1)
	return
end

function var_0_1.OnShow(arg_9_0)
	local var_9_0 = arg_9_0.settings

	i18n = var_1_10002
	var_9_0.content = var_1_10002("island_label_furniture_tip")

	var_0_1.super.OnShow(arg_9_0)

	local var_9_1 = arg_9_0.settings.list
	local var_9_2 = arg_9_0.settings.totalCnt

	arg_9_0:UpdateCapacity(var_9_1, var_9_2)
	arg_9_0:UpdateList(var_9_1)

	return
end

function var_0_1.UpdateCapacity(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = 0

	ipairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(arg_10_1) do
		var_10_0 = var_10_0 + iter_10_1.capacity
	end

	local var_10_1 = arg_10_0.capacityTxt

	i18n = var_5
	var_10_1.text = var_5("island_label_furniture_capacity_display") .. var_10_0 .. "/" .. arg_10_2

	return
end

function var_0_1.OnInitItem(arg_11_0, arg_11_1)
	local var_11_0 = var_0_2(arg_11_1)

	arg_11_0.cards[arg_11_1] = var_11_0

	return
end

function var_0_1.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	if not arg_12_0.cards[arg_12_2] then
		arg_12_0:OnInitItem(arg_12_2)

		var_12_0 = arg_12_0.cards[arg_12_2]
	end

	local var_12_1 = arg_12_0.settings.list[arg_12_1 + 1]

	var_12_0.Update(var_12_1)

	return
end

function var_0_1.UpdateList(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.scrollRect

	var_2.SetTotalCount(var_13_0, #arg_13_1)

	return
end

function var_0_1.OnDestroy(arg_14_0)
	var_0_1.super.OnDestroy(arg_14_0)

	ClearLScrollrect = var_1

	var_1(arg_14_0.scrollRect)

	return
end

return var_0_1
