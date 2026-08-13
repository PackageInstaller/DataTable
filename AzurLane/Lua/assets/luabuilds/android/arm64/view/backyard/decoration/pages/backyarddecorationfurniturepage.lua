class = var_0_10000

local var_0_0 = "BackYardDecorationFurniturePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BackYardDecorationBasePage"))

var_0_1.SELECTED_FURNITRUE = "BackYardDecorationFurniturePage:SELECTED_FURNITRUE"

local function var_0_2(arg_1_0)
	if not var_0_1.PageTypeList then
		var_0_1.PageTypeList = {
			0,
			1,
			7,
			2,
			3,
			4,
			5,
			6,
			8
		}
	end

	return var_0_1.PageTypeList[arg_1_0]
end

function var_0_1.getUIName(arg_2_0)
	return "BackYardDecorationFurniturePage"
end

function var_0_1.OnFurnitureUpdated(arg_3_0, arg_3_1)
	pairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.cards) do
		local var_3_0 = iter_3_1.furniture

		if var_7.getConfig(var_3_0, "id") == arg_3_1:getConfig("id") then
			local var_3_1, var_3_2 = arg_3_0:GetPutCntByConfigId(arg_3_0.dorm, arg_3_1:getConfig("id"))

			iter_3_1:Flush(arg_3_1, var_3_1, var_3_2)
		end
	end

	return
end

function var_0_1.GetPutCntByConfigId(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 0
	local var_4_1 = {}

	pairs = var_1_10005

	for iter_4_0, iter_4_1 in var_1_10005(arg_4_1:GetThemeList()) do
		var_4_0 = var_4_0 + iter_4_1:GetSameFurnitureCnt(arg_4_2)

		if 0 < var_10 then
			table = var_11

			var_11.insert(var_4_1, iter_4_0)
		end
	end

	local var_4_2 = 0

	if #var_4_1 > 1 then
		getProxy = var_6
		DormProxy = iter_4_0
		var_4_2 = var_6(iter_4_0).floor
	elseif #var_4_1 == 1 then
		var_4_2 = var_4_1[1]
	end

	return var_4_0, var_4_2
end

function var_0_1.OnDisplayList(arg_5_0)
	arg_5_0.displays = arg_5_0:GetDisplays()

	arg_5_0:SortDisplays()

	return
end

function var_0_1.SortDisplays(arg_6_0)
	local var_6_0 = arg_6_0.contextData.filterPanel

	if not var_1.GetLoaded(var_6_0) then
		local var_6_1 = {}

		ipairs = var_1_10002

		for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.displays) do
			local var_6_2 = arg_6_0:GetPutCntByConfigId(arg_6_0.dorm, iter_6_1.configId)
			local var_6_3 = iter_6_1:GetOwnCnt()

			var_6_1[iter_6_1.id] = var_6_3 <= var_6_2 and 0 or 1
		end

		local var_6_4 = arg_6_0.orderMode

		table = var_3

		var_3.sort(arg_6_0.displays, function(arg_7_0, arg_7_1)
			if var_6_1[arg_7_0.id] == var_6_1[arg_7_1.id] then
				if (arg_7_0.newFlag and 1 or 0) == (arg_7_1.newFlag and 1 or 0) then
					local var_7_0 = var_6_4

					BackYardDecorationFilterPanel = var_2_10007

					if var_7_0 == var_2_10007.ORDER_MODE_ASC then
						return arg_7_0.id < arg_7_1.id
					else
						local var_7_1 = var_6_4

						BackYardDecorationFilterPanel = var_7

						if var_7_1 == var_7.ORDER_MODE_DASC then
							return arg_7_0.id > arg_7_1.id
						end
					end
				else
					return var_5 < var_4
				end
			else
				return var_2 < var_3
			end

			return
		end)
		arg_6_0:SetTotalCount()
	else
		local var_6_5 = arg_6_0.contextData.filterPanel

		var_1.setFilterData(var_6_5, arg_6_0:GetDisplays())

		local var_6_6 = arg_6_0.contextData.filterPanel

		var_1.filter(var_6_6)

		local var_6_7 = arg_6_0.contextData.filterPanel
		local var_6_8 = var_1.GetFilterData(var_6_7)

		arg_6_0:OnFilterDone(var_6_8)
	end

	return
end

function var_0_1.OnOrderModeUpdated(arg_8_0)
	arg_8_0:SortDisplays()

	return
end

function var_0_1.change2ScrPos(arg_9_0, arg_9_1)
	GameObject = var_1_10002

	local var_9_0 = var_1_10002.Find("UICamera")
	local var_9_1 = var_2.GetComponent(var_9_0, "Camera")
	local var_9_2 = arg_9_0:GetComponent("RectTransform")

	LuaHelper = var_9_0

	return (var_9_0.ScreenToLocal(var_9_2, arg_9_1, var_9_1))
end

function var_0_1.OnLoaded(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.bind

	BackYardDecorationPutlistPage = var_1_10004

	var_10_1(var_10_0, var_1_10004.SELECTED_FURNITRUE, function()
		local var_11_0 = arg_10_0

		var_0.ClearMark(var_11_0)

		return
	end)

	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.bind

	BackYardDecrationLayer = var_4

	var_10_3(var_10_2, var_4.INNER_SELECTED_FURNITRUE, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_10_0

		var_2.Selected(var_12_0, arg_12_1)

		return
	end)

	local var_10_4 = arg_10_0._tf

	arg_10_0.scrollRect = var_1.GetComponent(var_10_4, "LScrollRect")

	local function var_10_5()
		if arg_10_0.timer then
			local var_13_0 = arg_10_0.timer

			var_0.Stop(var_13_0)

			arg_10_0.timer = nil
		end

		return
	end

	local function var_10_6(arg_14_0)
		local var_14_0 = arg_10_0

		Timer = var_2_10002
		var_14_0.timer = var_2_10002.New(arg_14_0, 0.8, 1)

		local var_14_1 = arg_10_0.timer

		var_1.Start(var_14_1)

		return
	end

	local function var_10_7(arg_15_0)
		local var_15_0 = var_0_1.change2ScrPos
		local var_15_1 = arg_10_0._tf
		local var_15_2 = var_15_0(var_3.Find(var_15_1, "content"), arg_15_0.position)
		local var_15_3

		pairs = var_3

		for iter_15_0, iter_15_1 in var_3(arg_10_0.cards) do
			local var_15_4 = iter_15_1._bg
			local var_15_5 = iter_15_1._tf.localPosition.x
			local var_15_6 = iter_15_1._tf.localPosition.y

			Vector2 = var_2_10011
			var_2_10011 = var_2_10011(var_15_5 + var_15_4.rect.width / 2, var_15_6 + var_15_4.rect.height / 2)
			Vector2 = var_2_10012
			var_2_10012 = var_2_10012(var_15_5 + var_15_4.rect.width / 2, var_15_6 - var_15_4.rect.height / 2)
			Vector2 = var_13

			local var_15_7 = var_13(var_15_5 - var_15_4.rect.width / 2, var_15_6 - var_15_4.rect.height / 2)

			if var_15_2.x > var_15_7.x and var_15_2.x < var_2_10012.x and var_15_2.y > var_2_10012.y and var_15_2.y < var_2_10011.y then
				var_15_3 = iter_15_1

				break
			end
		end

		return var_15_3
	end

	GetOrAddComponent = var_4

	local var_10_8 = arg_10_0._tf

	typeof = var_1_10007
	EventTriggerListener = var_1_10009

	local var_10_9 = var_4(var_10_8, var_1_10007(var_1_10009))

	var_4.AddPointDownFunc(var_10_9, function(arg_16_0, arg_16_1)
		arg_10_0.downPosition = arg_16_1.position

		if var_10_7(arg_16_1) then
			var_10_5()
			var_10_6(function()
				arg_10_0.lock = true

				local var_17_0 = var_0._tf.position
				local var_17_1 = arg_10_0.contextData.furnitureDescMsgBox

				var_1.ExecuteAction(var_17_1, "SetUp", var_0.furniture, var_17_0)

				return
			end)
		end

		return
	end)
	var_4:AddPointUpFunc(function(arg_18_0, arg_18_1)
		var_10_5()

		if arg_10_0.lock then
			local var_18_0 = arg_10_0.contextData.furnitureDescMsgBox

			var_2.ExecuteAction(var_18_0, "Hide")

			onNextTick = var_2

			var_2(function()
				arg_10_0.lock = false

				return
			end)
		else
			local var_18_1 = arg_18_1.position

			Vector2 = var_2_10003

			if var_2_10003.Distance(var_18_1, arg_10_0.downPosition) > 1 then
				return
			end

			if var_10_7(arg_18_1) and var_3:HasMask() then
				local var_18_2 = var_3.furniture

				if var_4.isPaper(var_18_2) then
					local var_18_3 = arg_10_0
					local var_18_4 = var_4.emit

					BackYardDecorationMediator = var_2_10007

					var_18_4(var_18_3, var_2_10007.REMOVE_PAPER, var_3.furniture)

					goto label_18_0
				end
			end

			if var_3 and not var_3:HasMask() then
				Clone = var_4

				local var_18_5 = var_4(var_3.furniture)
				local var_18_6 = arg_10_0
				local var_18_7 = var_5.emit

				BackYardDecorationMediator = var_2_10008

				var_18_7(var_18_6, var_2_10008.ADD_FURNITURE, var_18_5)
			elseif var_3 and var_3:HasMask() then
				local var_18_8 = arg_10_0

				var_4.ClearMark(var_18_8)

				arg_10_0.selectedId = var_3.furniture.id

				var_3:UpdateMark(arg_10_0.selectedId)

				local var_18_9 = arg_10_0
				local var_18_10 = var_4.emit

				BackYardDecorationMediator = var_7

				var_18_10(var_18_9, var_7.ON_SELECTED_FURNITRUE, var_3.furniture.id)

				local var_18_11 = arg_10_0

				var_4.emit(var_18_11, var_0_1.SELECTED_FURNITRUE)
			end
		end

		::label_18_0::

		return
	end)

	return
end

function var_0_1.ClearMark(arg_20_0)
	pairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.cards) do
		iter_20_1:UpdateMark(-1)
	end

	arg_20_0.selectedId = nil

	return
end

function var_0_1.Selected(arg_21_0, arg_21_1)
	arg_21_0:ClearMark()

	pairs = var_2

	for iter_21_0, iter_21_1 in var_2(arg_21_0.cards) do
		if iter_21_1.furniture.id == arg_21_1 then
			iter_21_1:UpdateMark(arg_21_1)
		end
	end

	arg_21_0.selectedId = arg_21_1

	return
end

function var_0_1.OnInitItem(arg_22_0, arg_22_1)
	BackYardDecorationCard = var_1_10002

	local var_22_0 = var_1_10002.New(arg_22_1)

	arg_22_0.cards[arg_22_1] = var_22_0

	return
end

function var_0_1.OnUpdateItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0

	if not arg_23_0.cards[arg_23_2] then
		arg_23_0:OnInitItem(arg_23_2)

		var_23_0 = arg_23_0.cards[arg_23_2]
	end

	if not arg_23_0.lastDiaplys[arg_23_1 + 1] then
		return
	end

	local var_23_1, var_23_2 = arg_23_0:GetPutCntByConfigId(arg_23_0.dorm, var_4:getConfig("id"))
	local var_23_3 = var_23_0
	local var_23_4 = var_23_0.Update
	local var_23_5 = var_4
	local var_23_6 = var_23_1
	local var_23_7 = var_23_2
	local var_23_8

	if not arg_23_0.selectedId then
		var_23_8 = -1
	end

	var_23_4(var_23_3, var_23_5, var_23_6, var_23_7, var_23_8)
	var_23_0:PlayEnterAnimation()

	return
end

function var_0_1.GetDisplays(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = arg_24_0.dorm
	local var_24_2 = var_2.GetPurchasedFurnitures(var_24_1)
	local var_24_3 = var_0_2(arg_24_0.pageType)

	pg = var_24_1

	local var_24_4 = var_24_1.furniture_data_template.get_id_list_by_tag[var_24_3]

	ipairs = var_5

	for iter_24_0, iter_24_1 in var_5(var_24_4 or {}) do
		if var_24_2[iter_24_1] then
			table = var_1_10011

			var_1_10011.insert(var_24_0, var_10)
		end
	end

	return var_24_0
end

function var_0_1.OnFilterDone(arg_25_0, arg_25_1)
	arg_25_0.displays = arg_25_1

	arg_25_0:SetTotalCount()

	return
end

function var_0_1.SetTotalCount(arg_26_0)
	if not arg_26_0.searchKey or arg_26_0.searchKey == "" then
		arg_26_0.lastDiaplys = arg_26_0.displays
	else
		arg_26_0.lastDiaplys = {}
		ipairs = var_1

		for iter_26_0, iter_26_1 in var_1(arg_26_0.displays) do
			if iter_26_1:isMatchSearchKey(arg_26_0.searchKey) then
				table = var_6

				var_6.insert(arg_26_0.lastDiaplys, iter_26_1)
			end
		end
	end

	arg_26_0.scrollRect.enabled = true

	local var_26_0 = arg_26_0.scrollRect

	var_1.SetTotalCount(var_26_0, #arg_26_0.lastDiaplys)

	return
end

function var_0_1.OnSearchKeyChanged(arg_27_0)
	arg_27_0:SetTotalCount()

	return
end

function var_0_1.OnDestroy(arg_28_0)
	if arg_28_0.timer then
		local var_28_0 = arg_28_0.timer

		var_1.Stop(var_28_0)

		arg_28_0.timer = nil
	end

	pairs = var_1

	local var_28_1

	if not arg_28_0.cards then
		var_28_1 = {}
	end

	for iter_28_0, iter_28_1 in var_1(var_28_1) do
		iter_28_1:Dispose()
	end

	arg_28_0.cards = nil

	return
end

return var_0_1
