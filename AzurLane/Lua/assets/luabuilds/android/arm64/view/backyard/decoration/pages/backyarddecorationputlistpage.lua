class = var_0_10000

local var_0_0 = "BackYardDecorationPutlistPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BackYardDecorationBasePage"))

var_0_1.SELECTED_FURNITRUE = "BackYardDecorationPutlistPage:SELECTED_FURNITRUE"

function var_0_1.getUIName(arg_1_0)
	return "BackYardPutListPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.bind

	BackYardDecrationLayer = var_1_10004

	var_2_1(var_2_0, var_1_10004.INNER_SELECTED_FURNITRUE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.Selected(var_3_0, arg_3_1)

		return
	end)

	local var_2_2 = arg_2_0._tf

	arg_2_0._bg = var_1.Find(var_2_2, "frame")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/frame/scrollrect")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_4, "LScrollRect")

	local var_2_5 = arg_2_0._tf

	arg_2_0.scrollRectTF = var_1.Find(var_2_5, "frame/frame/scrollrect")

	local var_2_6 = arg_2_0._tf

	arg_2_0.emptyTF = var_1.Find(var_2_6, "frame/frame/empty")

	local var_2_7 = arg_2_0._tf

	arg_2_0.arr = var_1.Find(var_2_7, "frame/frame/arr")
	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_3.Find(var_2_8, "frame/title/Text")

	i18n = var_4

	var_1(var_2_9, var_4("courtyard_label_putlist_title"))

	return
end

function var_0_1.OnInit(arg_4_0)
	var_0_1.super.OnInit(arg_4_0)

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.arr

	local function var_4_5()
		local var_6_0 = arg_4_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_3, var_4_4, var_4_5, var_1_10006)

	local function var_4_6()
		if arg_4_0.timer then
			local var_7_0 = arg_4_0.timer

			var_0.Stop(var_7_0)

			arg_4_0.timer = nil
		end

		return
	end

	local function var_4_7(arg_8_0)
		local var_8_0 = arg_4_0

		Timer = var_2_10002
		var_8_0.timer = var_2_10002.New(arg_8_0, 0.8, 1)

		local var_8_1 = arg_4_0.timer

		var_1.Start(var_8_1)

		return
	end

	local function var_4_8(arg_9_0)
		local var_9_0 = var_0_1.change2ScrPos
		local var_9_1 = arg_4_0.scrollRectTF
		local var_9_2 = var_9_0(var_3.Find(var_9_1, "content"), arg_9_0.position)
		local var_9_3

		pairs = var_3

		for iter_9_0, iter_9_1 in var_3(arg_4_0.cards) do
			local var_9_4 = iter_9_1._tf.localPosition.x
			local var_9_5 = var_8.localPosition.y

			Vector2 = var_2_10011
			var_2_10011 = var_2_10011(var_9_4 + var_8.rect.width / 2, var_9_5 + var_8.rect.height / 2)
			Vector2 = var_2_10012
			var_2_10012 = var_2_10012(var_9_4 + var_8.rect.width / 2, var_9_5 - var_8.rect.height / 2)
			Vector2 = var_13

			local var_9_6 = var_13(var_9_4 - var_8.rect.width / 2, var_9_5 - var_8.rect.height / 2)

			if var_9_2.x > var_9_6.x and var_9_2.x < var_2_10012.x and var_9_2.y > var_2_10012.y and var_9_2.y < var_2_10011.y then
				var_9_3 = iter_9_1

				break
			end
		end

		return var_9_3
	end

	GetOrAddComponent = var_4_4

	local var_4_9 = arg_4_0.scrollRectTF

	typeof = var_1_10007
	EventTriggerListener = var_1_10009

	local var_4_10 = var_4_4(var_4_9, var_1_10007(var_1_10009))

	var_4.AddPointDownFunc(var_4_10, function(arg_10_0, arg_10_1)
		local var_10_0 = var_4_8(arg_10_1)

		arg_4_0.downPosition = arg_10_1.position

		if var_10_0 then
			var_4_6()
			var_4_7(function()
				arg_4_0.lock = true

				local var_11_0 = var_10_0._tf.position
				local var_11_1 = arg_4_0.contextData.furnitureDescMsgBox

				var_1.ExecuteAction(var_11_1, "SetUp", var_10_0.furniture, var_11_0, true)

				return
			end)
		end

		return
	end)
	var_4:AddPointUpFunc(function(arg_12_0, arg_12_1)
		var_4_6()

		if arg_4_0.lock then
			local var_12_0 = arg_4_0.contextData.furnitureDescMsgBox

			var_2.ExecuteAction(var_12_0, "Hide")

			onNextTick = var_2

			var_2(function()
				arg_4_0.lock = false

				return
			end)
		else
			local var_12_1 = arg_12_1.position

			Vector2 = var_2_10003

			if var_2_10003.Distance(var_12_1, arg_4_0.downPosition) > 1 then
				return
			end

			if var_4_8(arg_12_1) then
				local var_12_2 = arg_4_0
				local var_12_3 = var_4.emit

				BackYardDecorationMediator = var_2_10007

				var_12_3(var_12_2, var_2_10007.ON_SELECTED_FURNITRUE, var_3.furniture.id)
				var_3:MarkOrUnMark(arg_4_0.card.furniture.id)

				arg_4_0.selectedId = arg_4_0.card.furniture.id

				local var_12_4 = arg_4_0

				var_4.emit(var_12_4, var_0_1.SELECTED_FURNITRUE)
			end
		end

		return
	end)

	return
end

function var_0_1.ClearMark(arg_14_0)
	arg_14_0.selectedId = nil
	pairs = var_1

	for iter_14_0, iter_14_1 in var_1(arg_14_0.cards) do
		iter_14_1:MarkOrUnMark(arg_14_0.selectedId)
	end

	return
end

function var_0_1.Selected(arg_15_0, arg_15_1)
	arg_15_0:ClearMark()

	pairs = var_2

	for iter_15_0, iter_15_1 in var_2(arg_15_0.cards) do
		if iter_15_1.furniture and iter_15_1.furniture.id == arg_15_1 then
			iter_15_1:MarkOrUnMark(arg_15_1)

			break
		end
	end

	arg_15_0.selectedId = arg_15_1

	return
end

function var_0_1.change2ScrPos(arg_16_0, arg_16_1)
	GameObject = var_1_10002

	local var_16_0 = var_1_10002.Find("UICamera")
	local var_16_1 = var_2.GetComponent(var_16_0, "Camera")
	local var_16_2 = arg_16_0:GetComponent("RectTransform")

	LuaHelper = var_16_0

	return (var_16_0.ScreenToLocal(var_16_2, arg_16_1, var_16_1))
end

function var_0_1.OnInitItem(arg_17_0, arg_17_1)
	BackYardDecorationPutCard = var_1_10002

	local var_17_0 = var_1_10002.New(arg_17_1)

	arg_17_0.cards[arg_17_1] = var_17_0

	return
end

function var_0_1.OnUpdateItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0

	if not arg_18_0.cards[arg_18_2] then
		arg_18_0:OnInitItem(arg_18_2)

		var_18_0 = arg_18_0.cards[arg_18_2]
	end

	local var_18_1 = arg_18_0.displays[arg_18_1 + 1]

	var_18_0:Update(var_18_1, arg_18_0.selectedId)

	return
end

function var_0_1.OnDisplayList(arg_19_0)
	arg_19_0.displays = {}
	getProxy = var_1
	DormProxy = var_1_10003

	local var_19_0 = var_1(var_1_10003).floor
	local var_19_1 = arg_19_0.dorm
	local var_19_2 = var_2.GetTheme(var_19_1, var_19_0)
	local var_19_3 = {}

	if var_19_2 then
		var_19_3 = var_19_2:GetAllFurniture()
	end

	pairs = var_19_1

	for iter_19_0, iter_19_1 in var_19_1(var_19_3) do
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_19_4 = arg_19_0.displays

		Furniture = var_1_10012

		var_1_10009(var_19_4, var_1_10012.New({
			count = 1,
			id = iter_19_1.configId
		}))
	end

	table = var_4

	var_4.sort(arg_19_0.displays, function(arg_20_0, arg_20_1)
		return arg_20_0:getConfig("type") < arg_20_1:getConfig("type")
	end)

	setActive = var_4

	var_4(arg_19_0.emptyTF, #arg_19_0.displays == 0)

	arg_19_0.scrollRect.enabled = true

	local var_19_5 = arg_19_0.scrollRect

	var_4.SetTotalCount(var_19_5, #arg_19_0.displays)

	return
end

function var_0_1.Show(arg_21_0)
	var_0_1.super.Show(arg_21_0)

	local var_21_0 = arg_21_0._bg.anchoredPosition.x

	LeanTween = var_1_10002

	local var_21_1 = var_1_10002.value(arg_21_0._bg.gameObject, var_21_0, 0, 0.4)
	local var_21_2 = var_2.setOnUpdate

	System = var_5

	local var_21_3 = var_21_2(var_21_1, var_5.Action_float(function(arg_22_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_21_0._bg, {
			x = arg_22_0
		})

		return
	end))
	local var_21_4 = var_2.setOnComplete

	System = var_5

	var_21_4(var_21_3, var_5.Action(function()
		if arg_21_0.OnShow then
			arg_21_0.OnShow(true)
		end

		return
	end))

	if arg_21_0.OnShowImmediately then
		arg_21_0.OnShowImmediately()
	end

	return
end

function var_0_1.Hide(arg_24_0)
	local var_24_0 = -arg_24_0._bg.rect.width

	LeanTween = var_1_10002

	local var_24_1 = var_1_10002.value(arg_24_0._bg.gameObject, 0, var_24_0, 0.4)
	local var_24_2 = var_2.setOnUpdate

	System = var_5

	local var_24_3 = var_24_2(var_24_1, var_5.Action_float(function(arg_25_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_24_0._bg, {
			x = arg_25_0
		})

		return
	end))
	local var_24_4 = var_2.setOnComplete

	System = var_5

	var_24_4(var_24_3, var_5.Action(function()
		var_0_1.super.Hide(arg_24_0)

		if arg_24_0.OnShow then
			arg_24_0.OnShow(false)
		end

		return
	end))

	pairs = var_24_4

	for iter_24_0, iter_24_1 in var_24_4(arg_24_0.cards) do
		iter_24_1:Clear()
	end

	return
end

function var_0_1.OnDormUpdated(arg_27_0)
	arg_27_0:OnDisplayList()

	return
end

function var_0_1.OnDestroy(arg_28_0)
	if arg_28_0.timer then
		local var_28_0 = arg_28_0.timer

		var_1.Stop(var_28_0)

		arg_28_0.timer = nil
	end

	return
end

return var_0_1
