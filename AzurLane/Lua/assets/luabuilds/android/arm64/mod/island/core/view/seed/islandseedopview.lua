class = var_0_10000

local var_0_0 = "IslandSeedOpView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..IslandBaseOpView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandSeedOpUI"
end

function var_0_1.OnInit(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._tf

	arg_2_0.seedSelectPlane = var_2.Find(var_2_0, "seed_select")

	local var_2_1 = arg_2_0._tf

	arg_2_0.seed_detals = var_2.Find(var_2_1, "seed_detals")
	UIItemList = var_2

	local var_2_2 = var_2.New
	local var_2_3 = arg_2_0.seedSelectPlane
	local var_2_4 = var_4.Find(var_2_3, "content")
	local var_2_5 = arg_2_0.seedSelectPlane

	arg_2_0.uiSeedItemList = var_2_2(var_2_4, var_5.Find(var_2_5, "content/itemSeed"))
	onButton = var_2

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0._tf

	local function var_2_8()
		setActive = var_2_10000

		var_2_10000(arg_2_0.seed_detals, false)

		local var_3_0 = arg_2_0

		var_0.ActiveSeedSelect(var_3_0, false)

		return
	end

	SFX_PANEL = var_2_5

	var_2(var_2_6, var_2_7, var_2_8, var_2_5)

	setActive = var_2

	var_2(arg_2_0.seed_detals, false)
	arg_2_0:ActiveSeedSelect(false)

	return
end

function var_0_1.ActiveSeedDetals(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0.seed_detals, arg_4_1)

	return
end

function var_0_1.ActiveSeedSelect(arg_5_0, arg_5_1)
	if arg_5_1 then
		local var_5_0 = arg_5_0:GetView()

		var_1_10002 = var_1_10002.GetSubView
		IslandOpView = var_1_10005

		local var_5_1 = var_1_10002(var_5_0, var_1_10005)

		var_1_10002 = var_1_10002.GetSeedBtnWorldPos(var_5_1)
		GameObject = var_1_10003

		local var_5_2 = var_1_10003.Find("UICamera")
		local var_5_3 = var_3.GetComponent

		typeof = var_1_10006
		Camera = var_1_10008

		local var_5_4 = var_5_3(var_5_2, var_1_10006(var_1_10008))
		local var_5_5 = var_3.WorldToScreenPoint(var_5_4, var_1_10002)

		LuaHelper = var_5_2

		local var_5_6 = var_5_2.ScreenToLocal(arg_5_0._tf, var_5_5, var_3)

		arg_5_0.seedSelectPlane.localPosition = var_5_6

		local var_5_7 = arg_5_0._tf

		var_6.SetAsLastSibling(var_5_7)
	end

	setActive = var_1_10002

	var_1_10002(arg_5_0.seedSelectPlane, arg_5_1)

	setActive = var_1_10002

	var_1_10002(arg_5_0._tf, arg_5_1)

	return
end

function var_0_1.RefreshSeedPlane(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.GetDataVO(var_6_0).slotData.configId

	pg = var_1_10003

	local var_6_2 = var_1_10003.island_production_slot[var_6_1].place

	pg = var_6_0

	local var_6_3 = var_6_0.island_production_place[var_6_2].seed_list

	getProxy = var_1_10005
	IslandProxy = var_1_10007

	local var_6_4 = var_1_10005(var_1_10007)
	local var_6_5 = var_5.GetIsland(var_6_4)
	local var_6_6 = var_5.GetInventoryAgency(var_6_5)
	local var_6_7 = {}

	ipairs = var_6_5

	for iter_6_0, iter_6_1 in var_6_5(var_6_3) do
		pg = var_1_10012
		var_1_10012 = var_1_10012.island_farm_seed[iter_6_1].itemid
		var_1_10015 = var_6_6

		if var_6_6.GetItemById(var_1_10015, var_1_10012) then
			table = var_1_10014

			var_1_10014.insert(var_6_7, iter_6_1)
		end
	end

	local var_6_8 = #var_6_7
	local var_6_9 = 30
	local var_6_10 = 40
	local var_6_11 = arg_6_0.seedSelectPlane
	local var_6_12 = var_10.Find(var_6_11, "content")
	local var_6_13 = var_10.GetComponent

	typeof = var_13
	GridLayoutGroup = var_1_10015

	local var_6_14 = var_6_13(var_6_12, var_13(var_1_10015)).cellSize.x
	local var_6_15 = var_10.cellSize.y

	math = var_13

	local var_6_16 = var_13.min(var_6_8, 7)

	math = var_1_10014

	local var_6_17 = var_1_10014.ceil(var_6_8 / 7)
	local var_6_18 = var_6_14 * var_6_16 + var_10.spacing.x * (var_6_16 - 1) + var_10.padding.right + var_6_10
	local var_6_19 = var_6_15 * var_6_17 + var_10.spacing.y * (var_6_17 - 1) + var_10.padding.bottom + var_6_9
	local var_6_20 = arg_6_0.seedSelectPlane
	local var_6_21 = var_17.Find(var_6_20, "content")

	Vector2 = var_18
	var_6_21.sizeDelta = var_18(var_6_18, var_6_19)

	local var_6_22 = arg_6_0.uiSeedItemList

	var_17.make(var_6_22, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = var_6_7[arg_7_1 + 1]

			setActive = var_4

			var_4(arg_7_2:Find("select"), arg_6_0.selectseedItemId == var_7_0)

			pg = var_4

			local var_7_1 = var_4.island_farm_seed[var_7_0].itemid
			local var_7_2 = var_6_6
			local var_7_3 = var_5.GetItemById(var_7_2, var_7_1)

			updateCustomDrop = var_6

			local var_7_4 = arg_7_2

			Drop = var_9

			local var_7_5 = var_9.New
			local var_7_6 = {}

			DROP_TYPE_ISLAND_ITEM = var_2_10012
			var_7_6.type = var_2_10012
			var_7_6.id = var_7_3.id
			var_7_6.count = var_7_3:GetCount()

			var_6(var_7_4, var_7_5(var_7_6))

			local var_7_7

			onButton = var_7_2

			local var_7_8 = arg_6_0
			local var_7_9 = arg_7_2

			local function var_7_10()
				if var_7_7 then
					var_7_7 = false

					return
				end

				local var_8_0 = arg_6_0

				var_8_0.selectseedItemId = var_7_0
				PlayerPrefs = var_8_0

				var_8_0.SetInt("island_last_selectItemId" .. var_6_2, arg_6_0.selectseedItemId)

				local var_8_1 = arg_6_0.uiSeedItemList

				var_0.align(var_8_1, var_6_8)

				local var_8_2 = arg_6_0
				local var_8_3 = var_0.GetView(var_8_2)
				local var_8_4 = var_0.GetSubView

				IslandOpView = var_3

				local var_8_5 = var_8_4(var_8_3, var_3)

				var_0.RefreshCurrentSlectSeed(var_8_5)

				local var_8_6 = arg_6_0

				var_0.ActiveSeedSelect(var_8_6, false)

				setActive = var_0

				var_0(arg_6_0.seed_detals, false)

				return
			end

			SFX_PANEL = var_12

			var_7_2(var_7_8, var_7_9, var_7_10, var_12)

			GetOrAddComponent = var_7_2

			local var_7_11 = arg_7_2

			typeof = var_7_9
			UILongPressTrigger = var_12

			local var_7_12 = var_7_2(var_7_11, var_7_9(var_12)).onLongPressed

			var_8.AddListener(var_7_12, function()
				var_7_7 = true
				setActive = var_3_10000

				var_3_10000(arg_6_0.seed_detals, true)

				local var_9_0 = arg_6_0.seed_detals

				var_9_0.position = arg_7_2.position
				setText = var_9_0

				local var_9_1 = arg_6_0.seed_detals
				local var_9_2 = var_2.Find(var_9_1, "bg/itemSeed/icon_bg/count_bg/count")
				local var_9_3 = var_7_3

				var_9_0(var_9_2, var_3.GetCount(var_9_3))

				local var_9_4 = var_7_3
				local var_9_5 = var_0.GetIcon(var_9_4)

				GetImageSpriteFromAtlasAsync = var_1

				local var_9_6 = "island/" .. var_9_5
				local var_9_7 = ""
				local var_9_8 = arg_6_0.seed_detals

				var_1(var_9_6, var_9_7, var_5.Find(var_9_8, "bg/itemSeed/icon_bg/icon"))

				local var_9_9 = arg_6_0.seed_detals
				local var_9_10

				var_9_10, setText = var_1.Find(var_9_9, "bg/detaiView/Viewport/detaiViewText"), var_9_4

				local var_9_11 = var_7_3

				var_9_4(var_9_10, var_5.GetDesc(var_9_11))

				setText = var_9_4

				local var_9_12 = arg_6_0.seed_detals
				local var_9_13 = var_4.Find(var_9_12, "bg/seedName")
				local var_9_14 = var_7_3

				var_9_4(var_9_13, var_5.GetName(var_9_14))

				return
			end)
		end

		return
	end)

	local var_6_23 = arg_6_0.uiSeedItemList

	var_17.align(var_6_23, var_6_8)

	return
end

function var_0_1.CheckSeedEmpty(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.GetDataVO(var_10_0).slotData.configId

	pg = var_1_10003

	local var_10_2 = var_1_10003.island_production_slot[var_10_1].place

	pg = var_10_0

	local var_10_3 = var_10_0.island_production_place[var_10_2].seed_list

	getProxy = var_1_10005
	IslandProxy = var_1_10007

	local var_10_4 = var_1_10005(var_1_10007)
	local var_10_5 = var_5.GetIsland(var_10_4)
	local var_10_6 = var_5.GetInventoryAgency(var_10_5)

	arg_10_0.selectseedItemId = nil
	PlayerPrefs = var_6

	if var_6.GetInt("island_last_selectItemId" .. var_10_2, 0) ~= 0 then
		pg = var_10_5
		var_10_5 = var_10_5.island_farm_seed[var_6].itemid

		if var_10_6:GetOwnCount(var_10_5) > 0 then
			arg_10_0.selectseedItemId = var_6

			return false
		end
	end

	ipairs = var_10_5

	for iter_10_0, iter_10_1 in var_10_5(var_10_3) do
		pg = var_1_10012
		var_1_10012 = var_1_10012.island_farm_seed[iter_10_1].itemid

		if var_10_6:GetItemById(var_1_10012) and var_13:GetCount() ~= 0 then
			arg_10_0.selectseedItemId = iter_10_1

			return false
		end
	end

	return true
end

return var_0_1
