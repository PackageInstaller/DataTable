class = var_0_10000

local var_0_0 = "IslandShoppingCartLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShoppingCartUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.panel = var_1.Find(var_2_0, "panel")

	local var_2_1 = arg_2_0.panel

	arg_2_0.closeBtn = var_1.Find(var_2_1, "closeBtn")

	local var_2_2 = arg_2_0.panel

	arg_2_0.commodityList = var_1.Find(var_2_2, "commodityList/Viewport/Content")

	local var_2_3 = arg_2_0.panel

	arg_2_0.cancelBtn = var_1.Find(var_2_3, "cancelBtn")

	local var_2_4 = arg_2_0.panel

	arg_2_0.buyBtn = var_1.Find(var_2_4, "buyBtn")

	local var_2_5 = arg_2_0.buyBtn

	arg_2_0.consumeIcon = var_1.Find(var_2_5, "consume/icon")

	local var_2_6 = arg_2_0.buyBtn

	arg_2_0.consumeCount = var_1.Find(var_2_6, "consume/count")
	setText = var_1

	local var_2_7 = arg_2_0.panel
	local var_2_8 = var_2.Find(var_2_7, "title")

	i18n = var_2_7

	var_1(var_2_8, var_2_7("island_3Dshop_buy_confirm"))

	setText = var_1

	local var_2_9 = arg_2_0.cancelBtn
	local var_2_10 = var_2.Find(var_2_9, "text")

	i18n = var_2_9

	var_1(var_2_10, var_2_9("island_3Dshop_buy_return"))

	setText = var_1

	local var_2_11 = arg_2_0.buyBtn
	local var_2_12 = var_2.Find(var_2_11, "text")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("island_3Dshop_buy"))

	for iter_2_0 = 1, 3 do
		setText = var_1_10005

		local var_2_13 = arg_2_0.commodityList
		local var_2_14 = var_6.Find(var_2_13, "commodity" .. iter_2_0 .. "/normal/cost")

		i18n = var_2_13

		var_1_10005(var_2_14, var_2_13("island_3Dshop_buy_price"))

		setText = var_1_10005

		local var_2_15 = arg_2_0.commodityList
		local var_2_16 = var_6.Find(var_2_15, "commodity" .. iter_2_0 .. "/normal/have")

		i18n = var_2_15

		var_1_10005(var_2_16, var_2_15("island_3Dshop_buy_have"))
	end

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

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_3.Find(var_3_4, "bg")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_3, var_3_5, var_3_6, var_5)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.cancelBtn

	local function var_3_9()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_7, var_3_8, var_3_9, var_5)

	return
end

function var_0_1.SetUp(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1
	local var_7_2 = 0
	local var_7_3 = arg_7_1[1]
	local var_7_23

	if #var_5.GetItems(var_7_3) == 1 then
		for iter_7_0 = 1, 3 do
			local var_7_4 = arg_7_0.commodityList

			iter_7_3 = iter_7_3.Find(var_7_4, "commodity" .. iter_7_0)
			setActive = var_7_4

			var_7_4(iter_7_3:Find("normal"), iter_7_0 <= #arg_7_1)

			setActive = var_7_4

			var_7_4(iter_7_3:Find("nothing"), iter_7_0 > #arg_7_1)

			if iter_7_0 <= #arg_7_1 then
				local var_7_5 = arg_7_1[iter_7_0]

				GetImageSpriteFromAtlasAsync = var_11

				var_11(var_7_5:GetIcon(), "", iter_7_3:Find("normal/IslandItemTpl/icon_bg/icon"))

				setText = var_11

				var_11(iter_7_3:Find("normal/name"), var_7_5:GetName())

				setActive = var_11

				var_11(iter_7_3:Find("normal/count"), false)

				local var_7_7

				if #var_7_5:GetItems() == 1 then
					local var_7_6 = 0

					var_7_7 = var_7_5

					local var_7_8 = var_7_5.GetItems(var_7_7)[1][1]

					DROP_TYPE_ISLAND_FURNITURE = var_7_7

					local var_7_9

					if var_7_8 == var_7_7 then
						getProxy = var_7_8
						IslandProxy = var_7_7
						var_7_7 = var_7_8(var_7_7)
						var_7_7 = var_12.GetIsland(var_7_7)
						var_7_9 = var_12.GetAgoraAgency(var_7_7)
						var_7_7 = var_12.GetFurnitures(var_7_9)
						ipairs = var_7_9

						for iter_7_1, iter_7_2 in var_7_9(var_7_7) do
							if iter_7_2.id == var_7_5:GetItems()[1][2] then
								var_7_6 = iter_7_2.count

								break
							end
						end

						setActive = var_7_9
						var_1_10016 = iter_7_3

						var_7_9(iter_7_3.Find(var_1_10016, "normal/count"), true)

						setText = var_7_9
						var_1_10016 = iter_7_3

						local var_7_10 = iter_7_3.Find(var_1_10016, "normal/count")

						i18n = var_1_10016

						var_7_9(var_7_10, var_1_10016("island_3Dshop_no_have", var_7_6))
					else
						var_7_7 = var_7_5

						local var_7_11 = var_7_5.GetItems(var_7_7)[1][1]

						DROP_TYPE_ISLAND_DRESS = var_7_7

						if var_7_11 == var_7_7 then
							var_7_7 = var_7_5

							local var_7_12 = var_7_5.GetItems(var_7_7)[1][2]

							pg = var_7_7

							if var_7_7.island_dress_template[var_7_12].belongto == 2 then
								getProxy = var_7_7
								IslandProxy = var_7_9

								local var_7_13 = var_7_7(var_7_9)
								local var_7_14 = var_7_7.GetIsland(var_7_13)
								local var_7_15 = var_7_7.GetCharacterAgency(var_7_14)
								local var_7_16 = var_7_7.GetOwnDressCountByDressId(var_7_15, var_7_12)

								setActive = var_14
								var_1_10016 = iter_7_3

								var_14(iter_7_3.Find(var_1_10016, "normal/count"), true)

								setText = var_14
								var_1_10016 = iter_7_3

								local var_7_17 = iter_7_3.Find(var_1_10016, "normal/count")

								i18n = var_1_10016

								var_14(var_7_17, var_1_10016("island_3Dshop_no_have", var_7_16))
							end
						end
					end
				end

				local var_7_18 = var_7_5
				local var_7_19 = var_7_5.GetResourceConsume(var_7_18)

				GetImageSpriteFromAtlasAsync = var_7_18
				Drop = var_7_7

				local var_7_20 = var_7_7.New({
					type = var_7_19[1],
					id = var_7_19[2]
				})
				local var_7_21 = var_13.getIcon(var_7_20)
				local var_7_22 = ""

				var_1_10016 = iter_7_3

				var_7_18(var_7_21, var_7_22, iter_7_3.Find(var_1_10016, "normal/consumeIcon"))

				setText = var_7_18

				var_7_18(iter_7_3:Find("normal/consumeNum"), var_7_19[3])

				var_7_0 = var_7_19[1]
				var_7_1 = var_7_19[2]
				var_7_2 = var_7_2 + var_7_19[3]
				setActive = var_12

				var_12(iter_7_3:Find("normal/cost"), true)

				setActive = var_12

				var_12(iter_7_3:Find("normal/consumeIcon"), true)

				setActive = var_12

				var_12(iter_7_3:Find("normal/have"), false)
			end
		end
	else
		var_7_3 = arg_7_1[1]
		var_7_23 = var_7_23.GetItems(var_7_3)[1][1]
		DROP_TYPE_ISLAND_DRESS = var_7_3

		if var_7_23 == var_7_3 then
			var_7_3 = arg_7_1[1]
			var_7_23 = var_7_23.GetDisplayItems(var_7_3)

			for iter_7_3 = 1, 3 do
				local var_7_24 = arg_7_0.commodityList
				local var_7_25 = var_10.Find(var_7_24, "commodity" .. iter_7_3)

				setActive = var_7_24

				var_7_24(var_7_25:Find("normal"), iter_7_3 <= #var_7_23)

				setActive = var_7_24

				var_7_24(var_7_25:Find("nothing"), iter_7_3 > #var_7_23)

				if iter_7_3 <= #var_7_23 then
					local var_7_26 = var_7_23[iter_7_3][2]

					pg = var_12

					local var_7_27 = var_12.island_dress_template[var_7_26]

					GetImageSpriteFromAtlasAsync = var_13
					Drop = var_14

					local var_7_28 = var_14.New
					local var_7_29 = {}

					DROP_TYPE_ISLAND_DRESS = var_1_10016
					var_7_29.type = var_1_10016
					var_7_29.id = var_7_26

					local var_7_30 = var_7_28(var_7_29)

					var_13(var_14.getIcon(var_7_30), "", var_7_25:Find("normal/IslandItemTpl/icon_bg/icon"))

					setText = var_13

					var_13(var_7_25:Find("normal/name"), var_7_27.name)

					setActive = var_13

					var_13(var_7_25:Find("normal/count"), false)

					local var_7_31 = 0
					local var_7_32

					if var_7_27.belongto == 1 then
						getProxy = var_14
						IslandProxy = var_7_32
						var_7_32 = var_14(var_7_32)
						var_7_32 = var_14.GetIsland(var_7_32)
						var_1_10016 = var_14.GetDressUpAgency(var_7_32)
						var_7_31 = var_14.CheckOwnDress(var_1_10016, var_7_26) and 1 or 0
					elseif var_7_27.belongto == 2 then
						getProxy = var_14
						IslandProxy = var_7_32

						local var_7_33 = var_14(var_7_32)
						local var_7_34 = var_14.GetIsland(var_7_33)

						var_1_10016 = var_14.GetCharacterAgency(var_7_34)
						var_7_31 = var_14.GetOwnDressCountByDressId(var_1_10016, var_7_26)
					end

					setText = var_14
					var_1_10016 = var_7_25

					var_14(var_7_25.Find(var_1_10016, "normal/consumeNum"), var_7_31)

					setActive = var_14
					var_1_10016 = var_7_25

					var_14(var_7_25.Find(var_1_10016, "normal/cost"), false)

					setActive = var_14
					var_1_10016 = var_7_25

					var_14(var_7_25.Find(var_1_10016, "normal/consumeIcon"), false)

					setActive = var_14
					var_1_10016 = var_7_25

					var_14(var_7_25.Find(var_1_10016, "normal/have"), true)
				end
			end

			local var_7_35 = arg_7_1[1]

			var_7_0 = var_7_3.GetResourceConsume(var_7_35)[1]
			var_7_1 = var_7_3[2]
			var_7_2 = var_7_3[3]
		end
	end

	GetImageSpriteFromAtlasAsync = var_7_23
	Drop = var_7_3

	local var_7_36 = var_7_3.New({
		type = var_7_0,
		id = var_7_1
	})

	var_7_23(var_6.getIcon(var_7_36), "", arg_7_0.consumeIcon)

	setText = var_7_23

	var_7_23(arg_7_0.consumeCount, var_7_2)

	onButton = var_7_23

	local var_7_37 = arg_7_0
	local var_7_38 = arg_7_0.buyBtn

	local function var_7_39()
		local var_8_0 = {}

		ipairs = var_2_10001

		for iter_8_0, iter_8_1 in var_2_10001(arg_7_1) do
			table = var_2_10006

			var_2_10006.insert(var_8_0, {
				value2 = 1,
				key = iter_8_1.shopId,
				value1 = iter_8_1.id
			})
		end

		local var_8_1 = arg_7_0
		local var_8_2 = var_1.emit

		IslandMediator = var_3

		var_8_2(var_8_1, var_3.BUY_COMMODITY, var_8_0)

		return
	end

	SFX_PANEL = iter_7_3

	var_7_23(var_7_37, var_7_38, var_7_39, iter_7_3)

	return
end

function var_0_1.Refresh(arg_9_0)
	arg_9_0:SetUp(arg_9_0.commodities)

	return
end

function var_0_1.OnShow(arg_10_0, arg_10_1)
	arg_10_0:BlurPanel(arg_10_0._tf)

	arg_10_0.commodities = arg_10_1

	arg_10_0:SetUp(arg_10_0.commodities)

	return
end

function var_0_1.OnHide(arg_11_0)
	arg_11_0:UnOverlayPanel(arg_11_0._tf, arg_11_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	return
end

return var_0_1
