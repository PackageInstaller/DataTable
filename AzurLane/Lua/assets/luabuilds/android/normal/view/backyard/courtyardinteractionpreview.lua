class = var_0_10000

local var_0_0 = "CourtyardInteractionPreview"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BackYardInterActionPreview"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "frame/close")

	local var_2_1 = arg_2_0._tf

	arg_2_0.mask = var_1.Find(var_2_1, "frame/mask")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Destroy(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Destroy(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	setText = var_1_10001

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_2.Find(var_3_6, "frame/title")

	i18n = var_3_6

	var_1_10001(var_3_7, var_3_6("word_preview"))

	return
end

function var_0_1.Show(arg_6_0, arg_6_1, arg_6_2)
	var_0_1.super.Show(arg_6_0)

	arg_6_0.storeyId = 999
	arg_6_0.furnitureId = arg_6_1
	pg = var_3

	local var_6_0 = var_3.ship_skin_template[arg_6_2]

	ShipGroup = var_4
	arg_6_0.shipId = var_4.getDefaultShipConfig(var_6_0.ship_group).id
	arg_6_0.shipSkinId = arg_6_2
	Vector2 = var_5
	arg_6_0.furniturePosition = var_5(0, 0)
	arg_6_0.step = 0
	arg_6_0.instance = nil

	arg_6_0:SetUp()

	return
end

function var_0_1.SetUp(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0.mask, false)

	CourtYardBridge = var_1_10001

	local var_7_0 = var_1_10001.New
	local var_7_1 = arg_7_0
	local var_7_2 = arg_7_0.GenCourtYardData

	id = var_1_10004
	arg_7_0.instance = var_7_0(var_7_2(var_7_1, var_1_10004))

	local var_7_3 = arg_7_0.instance
	local var_7_4 = var_1.GetController(var_7_3)
	local var_7_5 = arg_7_0.instance
	local var_7_6 = var_2.GetView(var_7_5)
	local var_7_7 = arg_7_0:GetPutFurniture()
	local var_7_8 = 0

	Timer = var_1_10005
	arg_7_0.timer = var_1_10005.New(function()
		if arg_7_0.step == 2 then
			local var_8_0 = var_7_4
			local var_8_1 = var_0.GetStorey(var_8_0)

			if var_0.GetFurniture(var_8_1, var_7_7.id) and not var_0:AnySlotIsLoop() and not var_0:IsInteractionState() then
				GetOrAddComponent = var_1
				var_2_10003 = var_7_6

				local var_8_2 = var_2.GetRect(var_2_10003)

				typeof = var_2_10003
				CanvasGroup = var_2_10004

				local var_8_3 = var_1(var_8_2, var_2_10003(var_2_10004))

				var_8_3.alpha = 0
				setActive = var_8_3

				var_8_3(arg_7_0.mask, true)

				onButton = var_8_3

				local var_8_4 = arg_7_0

				var_2_10003 = arg_7_0.mask

				local function var_8_5()
					local var_9_0 = arg_7_0

					var_9_0.step = 1
					setActive = var_9_0

					var_9_0(arg_7_0.mask, false)

					return
				end

				SFX_PANEL = var_2_10005

				var_8_3(var_8_4, var_2_10003, var_8_5, var_2_10005)

				arg_7_0.step = 3
			end
		end

		if arg_7_0.step == 1 then
			local var_8_6 = var_7_6
			local var_8_7 = var_0.GetCurrStorey(var_8_6)

			if var_0.ItemsIsLoaded(var_8_7) then
				local var_8_8 = arg_7_0

				var_0.StartInteraction(var_8_8, var_7_4)

				GetOrAddComponent = var_0

				local var_8_9 = var_7_6
				local var_8_10 = var_1.GetRect(var_8_9)

				typeof = var_8_9
				CanvasGroup = var_2_10003
				var_0(var_8_10, var_8_9(var_2_10003)).alpha = 1
				arg_7_0.step = 2
			end
		end

		local var_8_11 = var_7_6

		if var_0.IsInit(var_8_11) then
			local var_8_12 = var_7_4

			if var_0.IsLoaed(var_8_12) and arg_7_0.step == 0 then
				local var_8_13 = arg_7_0

				var_8_13.step = 1
				GetOrAddComponent = var_8_13

				local var_8_14 = var_7_6
				local var_8_15 = var_1.GetRect(var_8_14)

				typeof = var_8_14
				CanvasGroup = var_2_10003
				var_8_13(var_8_15, var_8_14(var_2_10003)).alpha = 0

				local var_8_16 = var_7_4

				var_0.AddFurniture(var_8_16, var_7_7)

				local var_8_17 = var_7_4
				local var_8_18 = var_0.AddShip
				local var_8_19 = arg_7_0

				var_8_18(var_8_17, var_2.GetPutShip(var_8_19))
			end
		end

		return
	end, 0.01, -1)

	local var_7_9 = arg_7_0.timer

	var_5.Start(var_7_9)

	return
end

function var_0_1.RemoveTimer(arg_10_0)
	if arg_10_0.timer then
		local var_10_0 = arg_10_0.timer

		var_1.Stop(var_10_0)

		arg_10_0.timer = nil
	end

	return
end

function var_0_1.StartInteraction(arg_11_0, arg_11_1)
	if arg_11_0.shipId then
		arg_11_1:DragShip(arg_11_0.shipId)
		arg_11_1:DragShipEnd(arg_11_0.shipId, arg_11_0.furniturePosition)
	end

	return
end

function var_0_1.Hide(arg_12_0)
	var_0_1.super.Hide(arg_12_0)
	arg_12_0:RemoveTimer()

	if arg_12_0.instance then
		local var_12_0 = arg_12_0.instance

		var_1.Dispose(var_12_0)
	end

	arg_12_0.instance = nil

	return
end

function var_0_1.GenCourtYardData(arg_13_0)
	local var_13_0 = arg_13_0.storeyId
	local var_13_1 = 4
	local var_13_2 = {
		[var_13_0] = {
			id = var_13_0,
			level = var_13_1,
			furnitures = {},
			ships = {}
		}
	}

	Dorm = var_4

	local var_13_3 = var_4.StaticGetMapSize(var_13_1)
	local var_13_4 = {}

	CourtYardConst = var_1_10006
	var_13_4.system = var_1_10006.SYSTEM_VISIT
	var_13_4.storeys = var_13_2
	var_13_4.storeyId = var_13_0
	CourtYardConst = var_6
	var_13_4.style = var_6.STYLE_PREVIEW
	var_13_4.mapSize = var_13_3
	var_13_4.name = arg_13_0:getUIName()

	return var_13_4
end

function var_0_1.GetPutFurniture(arg_14_0)
	BackyardThemeFurniture = var_1_10001

	return (var_1_10001.New({
		id = 9999,
		isNewStyle = true,
		configId = arg_14_0.furnitureId,
		position = arg_14_0.furniturePosition
	}))
end

function var_0_1.GetPutShip(arg_15_0)
	if not arg_15_0.shipId or arg_15_0.shipId <= 0 then
		return {}
	end

	Ship = var_1

	return (var_1.New({
		id = arg_15_0.shipId,
		template_id = arg_15_0.shipId,
		skin_id = arg_15_0.shipSkinId
	}))
end

function var_0_1.OnDestroy(arg_16_0)
	arg_16_0:Hide()

	return
end

return var_0_1
