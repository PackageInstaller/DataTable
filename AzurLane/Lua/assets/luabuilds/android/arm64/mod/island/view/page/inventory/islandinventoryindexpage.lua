class = var_0_10000

local var_0_0 = "IslandInventoryIndexPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandInventoryIndexUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "frame/list")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_0(var_2_2, var_4.Find(var_2_3, "frame/list/tpl"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_4, "frame/top/close_btn")

	local var_2_5 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_5, "frame/button_list/cancel")

	local var_2_6 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_6, "frame/button_list/confirm")
	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_3.Find(var_2_7, "frame/top/title")

	i18n = var_4

	var_1(var_2_8, var_4("child_filter_title"))

	setText = var_1

	local var_2_9 = arg_2_0.cancelBtn
	local var_2_10 = var_3.Find(var_2_9, "Text")

	i18n = var_4

	var_1(var_2_10, var_4("island_word_reset"))

	setText = var_1

	local var_2_11 = arg_2_0.confirmBtn
	local var_2_12 = var_3.Find(var_2_11, "Text")

	i18n = var_4

	var_1(var_2_12, var_4("word_ok"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.ResetData(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.confirmBtn

	local function var_3_11()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		IslandScene = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_INVENTORY_FILTER, arg_3_0.values)

		local var_7_2 = arg_3_0

		var_0.Hide(var_7_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	arg_3_0.btns = {}

	return
end

function var_0_1.Show(arg_8_0, arg_8_1)
	var_0_1.super.Show(arg_8_0)

	assert = var_2

	var_2(arg_8_1)

	arg_8_0.values = arg_8_1:GetData()

	local var_8_0 = arg_8_1:GetLayoutData()

	arg_8_0:Flush(var_8_0)

	return
end

function var_0_1.Flush(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.uiItemList

	var_2.make(var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_9_1[arg_10_1 + 1]
			local var_10_1 = arg_9_0
			local var_10_2 = var_4.InitLayout(var_10_1, var_10_0, arg_10_1 + 1, arg_10_2)

			table = var_2_10005

			var_2_10005.insert(arg_9_0.btns, var_10_2)
		end

		return
	end)

	local var_9_1 = arg_9_0.uiItemList

	var_2.align(var_9_1, #arg_9_1)

	return
end

function var_0_1.InitLayout(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	setText = var_1_10004

	var_1_10004(arg_11_3:Find("title/title"), arg_11_1.title)

	UIItemList = var_1_10004

	local var_11_0 = var_1_10004.New(arg_11_3:Find("buttons"), arg_11_3:Find("buttons/tpl"))
	local var_11_1 = {}

	var_11_0:make(function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_12_2:Find("Text"), arg_11_1.names[arg_12_1 + 1])

			setText = var_3

			var_3(arg_12_2:Find("mark/Text"), arg_11_1.names[arg_12_1 + 1])

			setActive = var_3

			var_3(arg_12_2:Find("line"), (not (arg_12_1 > 0) or arg_12_1 % 4 ~= 0) and arg_12_1 + 1 ~= #arg_11_1.list)

			local var_12_0 = arg_11_1.list[arg_12_1 + 1]
			local var_12_1 = arg_12_1 == 0

			onButton = var_5

			local var_12_2 = arg_11_0
			local var_12_3 = arg_12_2

			local function var_12_4()
				local var_13_0 = arg_11_0.values[arg_11_2]
				local var_13_1 = arg_11_1.mode

				IslandInventoryIndexData = var_3_10002

				if var_13_1 == var_3_10002.MODE_SINGLE then
					var_13_0 = var_12_0
				else
					IslandInventoryIndexData = var_13_1

					local var_13_2 = var_13_1.CheckSelectedAll(arg_11_1.list, var_13_0)
					local var_13_3 = arg_11_0

					var_13_0 = var_2.HandleMultiClick(var_13_3, var_12_0, var_13_0, var_13_2, var_12_1, arg_11_1.list[1])
				end

				local var_13_4 = arg_11_0

				var_1.FlushBtns(var_13_4, var_11_1, arg_11_1.list, var_13_0, arg_11_1.mode)

				arg_11_0.values[arg_11_2] = var_13_0

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_12_2, var_12_3, var_12_4, var_2_10010)

			table = var_5

			var_5.insert(var_11_1, {
				mark = arg_12_2:Find("trigger"),
				isAll = var_12_1
			})
		end

		return
	end)
	var_11_0:align(#arg_11_1.list)
	arg_11_0:FlushBtns(var_11_1, arg_11_1.list, arg_11_0.values[arg_11_2], arg_11_1.mode)

	return var_11_1
end

function var_0_1.HandleMultiClick(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	if arg_14_3 and arg_14_1 == arg_14_2 then
		-- block empty
	elseif arg_14_3 and arg_14_1 ~= arg_14_2 then
		arg_14_2 = arg_14_1
	elseif arg_14_4 then
		arg_14_2 = arg_14_5
	else
		bit = var_1_10006

		if var_1_10006.band(arg_14_2, arg_14_1) > 0 then
			bit = var_6
			arg_14_2 = var_6.bxor(arg_14_2, arg_14_1)
		else
			bit = var_6
			arg_14_2 = var_6.bor(arg_14_2, arg_14_1)
		end
	end

	arg_14_2 = arg_14_2 ~= 0 and arg_14_2 or arg_14_5

	return arg_14_2
end

function var_0_1.FlushBtns(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	IslandInventoryIndexData = var_1_10005

	if arg_15_4 == var_1_10005.MODE_SINGLE then
		ipairs = var_5

		for iter_15_0, iter_15_1 in var_5(arg_15_1) do
			local var_15_0 = arg_15_2[iter_15_0]

			triggerToggle = var_1_10011

			local var_15_1 = iter_15_1.mark

			bit = var_1_10014
			var_1_10014 = var_1_10014.band(var_15_0, arg_15_3) > 0

			var_1_10011(var_15_1, var_1_10014)
		end
	else
		IslandInventoryIndexData = var_5

		if arg_15_4 == var_5.MODE_MULTI then
			IslandInventoryIndexData = var_5

			if var_5.CheckSelectedAll(arg_15_2, arg_15_3) then
				ipairs = var_1_10006

				for iter_15_2, iter_15_3 in var_1_10006(arg_15_1) do
					triggerToggle = var_1_10011

					var_1_10011(iter_15_3.mark, iter_15_3.isAll)
				end
			else
				ipairs = var_1_10006

				for iter_15_4, iter_15_5 in var_1_10006(arg_15_1) do
					local var_15_2 = arg_15_2[iter_15_4]

					triggerToggle = var_1_10012

					local var_15_3 = iter_15_5.mark

					if not iter_15_5.isAll then
						bit = var_15

						local var_15_4

						if not (var_15.band(var_15_2, arg_15_3) > 0) then
							var_15_4 = false
						else
							var_15_4 = true
						end

						var_1_10012(var_15_3, var_15_4)
					end
				end
			end
		end
	end

	return
end

function var_0_1.ResetData(arg_16_0)
	ipairs = var_1_10001

	for iter_16_0, iter_16_1 in var_1_10001(arg_16_0.btns) do
		ipairs = var_1_10006

		for iter_16_2, iter_16_3 in var_1_10006(iter_16_1) do
			if iter_16_3.isAll then
				triggerButton = var_11

				var_11(iter_16_3.mark.parent)
			end
		end
	end

	return
end

function var_0_1.OnDestroy(arg_17_0)
	return
end

return var_0_1
