class = var_0_10000

local var_0_0 = "IslandShoppingCartLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

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
	local var_2_8 = var_3.Find(var_2_7, "title")

	i18n = var_4

	var_1(var_2_8, var_4("island_3Dshop_buy_confirm"))

	setText = var_1

	local var_2_9 = arg_2_0.cancelBtn
	local var_2_10 = var_3.Find(var_2_9, "text")

	i18n = var_4

	var_1(var_2_10, var_4("island_3Dshop_buy_return"))

	setText = var_1

	local var_2_11 = arg_2_0.buyBtn
	local var_2_12 = var_3.Find(var_2_11, "text")

	i18n = var_4

	var_1(var_2_12, var_4("island_3Dshop_buy"))

	for iter_2_0 = 1, 3 do
		setText = var_2_11

		local var_2_13 = arg_2_0.commodityList
		local var_2_14 = var_7.Find(var_2_13, "commodity" .. iter_2_0 .. "/normal/cost")

		i18n = var_1_10008

		var_2_11(var_2_14, var_1_10008("island_3Dshop_buy_price"))

		setText = var_2_11

		local var_2_15 = arg_2_0.commodityList
		local var_2_16 = var_7.Find(var_2_15, "commodity" .. iter_2_0 .. "/normal/have")

		i18n = var_1_10008

		var_2_11(var_2_16, var_1_10008("island_3Dshop_buy_have"))
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

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_4.Find(var_3_4, "bg")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_3_4

	var_1_10001(var_3_3, var_3_5, var_3_6, var_3_4)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.cancelBtn

	local function var_3_9()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_3_4

	var_1_10001(var_3_7, var_3_8, var_3_9, var_3_4)

	return
end

function var_0_1.SetUp(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1
	local var_7_2 = 0
	local var_7_3 = arg_7_1[1]
	local var_7_17

	if #var_5.GetItems(var_7_3) == 1 then
		for iter_7_0 = 1, 3 do
			var_1_10011 = arg_7_0.commodityList

			local var_7_4 = var_9.Find(var_1_10011, "commodity" .. iter_7_0)

			setActive = var_1_10010

			var_1_10010(var_7_4:Find("normal"), iter_7_0 <= #arg_7_1)

			setActive = var_1_10010

			var_1_10010(var_7_4:Find("nothing"), iter_7_0 > #arg_7_1)

			if iter_7_0 <= #arg_7_1 then
				var_1_10010 = arg_7_1[iter_7_0]
				GetImageSpriteFromAtlasAsync = var_1_10011

				var_1_10011(var_1_10010:GetIcon(), "", var_7_4:Find("normal/IslandItemTpl/icon_bg/icon"))

				setText = var_1_10011

				var_1_10011(var_7_4:Find("normal/name"), var_1_10010:GetName())

				setActive = var_1_10011

				local var_7_5 = var_7_4

				var_1_10011(var_7_4.Find(var_7_5, "normal/count"), false)

				local var_7_6 = var_1_10010
				local var_7_7, var_7_8

				if #var_1_10010.GetItems(var_7_6) == 1 then
					var_1_10011 = 0
					var_7_7 = var_1_10010
					var_7_8 = var_1_10010.GetItems(var_7_7)[1][1]
					DROP_TYPE_ISLAND_FURNITURE = var_7_6

					if var_7_8 == var_7_6 then
						getProxy = var_7_8
						IslandProxy = var_7_7
						var_7_7 = var_7_8(var_7_7)
						var_7_7 = var_7_8.GetIsland(var_7_7)
						var_7_5 = var_7_8.GetAgoraAgency(var_7_7)
						var_7_6 = var_7_8.GetFurnitures(var_7_5)
						ipairs = var_7_7

						for iter_7_1, iter_7_2 in var_7_7(var_7_6) do
							if iter_7_2.id == var_1_10010:GetItems()[1][2] then
								var_1_10011 = iter_7_2.count

								break
							end
						end

						setActive = var_7_7
						iter_7_2 = var_7_4

						var_7_7(var_7_4.Find(iter_7_2, "normal/count"), true)

						setText = var_7_7
						iter_7_2 = var_7_4

						local var_7_9 = var_7_4.Find(iter_7_2, "normal/count")

						i18n = var_17

						var_7_7(var_7_9, var_17("island_3Dshop_no_have", var_1_10011))
					else
						var_7_7 = var_1_10010
						var_7_8 = var_1_10010.GetItems(var_7_7)[1][1]
						DROP_TYPE_ISLAND_DRESS = var_7_6

						if var_7_8 == var_7_6 then
							var_7_7 = var_1_10010
							var_7_8 = var_1_10010.GetItems(var_7_7)[1][2]
							pg = var_7_6

							if var_7_6.island_dress_template[var_7_8].belongto == 2 then
								getProxy = var_13
								IslandProxy = var_7_5

								local var_7_10 = var_13(var_7_5)
								local var_7_11 = var_13.GetIsland(var_7_10)
								local var_7_12 = var_13.GetCharacterAgency(var_7_11)

								var_1_10011 = var_13.GetOwnDressCountByDressId(var_7_12, var_7_8)
								setActive = var_7_7
								iter_7_2 = var_7_4

								var_7_7(var_7_4.Find(iter_7_2, "normal/count"), true)

								setText = var_7_7
								iter_7_2 = var_7_4

								local var_7_13 = var_7_4.Find(iter_7_2, "normal/count")

								i18n = var_17

								var_7_7(var_7_13, var_17("island_3Dshop_no_have", var_1_10011))
							end
						end
					end
				end

				var_1_10011 = var_1_10010:GetResourceConsume()
				GetImageSpriteFromAtlasAsync = var_7_8
				Drop = var_7_7

				local var_7_14 = var_7_7.New({
					type = var_1_10011[1],
					id = var_1_10011[2]
				})
				local var_7_15 = var_14.getIcon(var_7_14)
				local var_7_16 = ""

				iter_7_2 = var_7_4

				var_7_8(var_7_15, var_7_16, var_7_4.Find(iter_7_2, "normal/consumeIcon"))

				setText = var_7_8

				var_7_8(var_7_4:Find("normal/consumeNum"), var_1_10011[3])

				var_7_0 = var_1_10011[1]
				var_7_1 = var_1_10011[2]
				var_7_2 = var_7_2 + var_1_10011[3]
				setActive = var_12

				var_12(var_7_4:Find("normal/cost"), true)

				setActive = var_12

				var_12(var_7_4:Find("normal/consumeIcon"), true)

				setActive = var_12

				var_12(var_7_4:Find("normal/have"), false)
			end
		end
	else
		var_7_3 = arg_7_1[1]
		var_7_17 = var_7_17.GetItems(var_7_3)[1][1]
		DROP_TYPE_ISLAND_DRESS = var_1_10006

		if var_7_17 == var_1_10006 then
			var_7_3 = arg_7_1[1]
			var_7_17 = var_7_17.GetDisplayItems(var_7_3)

			for iter_7_3 = 1, 3 do
				local var_7_18 = arg_7_0.commodityList

				var_1_10010 = var_1_10010.Find(var_7_18, "commodity" .. iter_7_3)
				setActive = var_1_10011

				var_1_10011(var_1_10010:Find("normal"), iter_7_3 <= #var_7_17)

				setActive = var_1_10011

				local var_7_19 = var_1_10010

				var_1_10011(var_1_10010.Find(var_7_19, "nothing"), iter_7_3 > #var_7_17)

				if iter_7_3 <= #var_7_17 then
					var_1_10011 = var_7_17[iter_7_3][2]
					pg = var_7_18

					local var_7_20 = var_7_18.island_dress_template[var_1_10011]

					GetImageSpriteFromAtlasAsync = var_13
					Drop = var_7_19

					local var_7_21 = var_7_19.New
					local var_7_22 = {}

					DROP_TYPE_ISLAND_DRESS = iter_7_2
					var_7_22.type = iter_7_2
					var_7_22.id = var_1_10011

					local var_7_23 = var_7_21(var_7_22)

					var_13(var_15.getIcon(var_7_23), "", var_1_10010:Find("normal/IslandItemTpl/icon_bg/icon"))

					setText = var_13

					var_13(var_1_10010:Find("normal/name"), var_7_20.name)

					setActive = var_13

					var_13(var_1_10010:Find("normal/count"), false)

					local var_7_24 = 0
					local var_7_25

					if var_7_20.belongto == 1 then
						getProxy = var_14
						IslandProxy = var_7_25
						var_7_25 = var_14(var_7_25)
						var_7_25 = var_14.GetIsland(var_7_25)

						local var_7_26 = var_14.GetDressUpAgency(var_7_25)

						var_7_24 = var_14.CheckOwnDress(var_7_26, var_1_10011) and 1 or 0
					elseif var_7_20.belongto == 2 then
						getProxy = var_14
						IslandProxy = var_7_25

						local var_7_27 = var_14(var_7_25)
						local var_7_28 = var_14.GetIsland(var_7_27)
						local var_7_29 = var_14.GetCharacterAgency(var_7_28)

						var_7_24 = var_14.GetOwnDressCountByDressId(var_7_29, var_1_10011)
					end

					setText = var_14
					iter_7_2 = var_1_10010

					var_14(var_1_10010.Find(iter_7_2, "normal/consumeNum"), var_7_24)

					setActive = var_14
					iter_7_2 = var_1_10010

					var_14(var_1_10010.Find(iter_7_2, "normal/cost"), false)

					setActive = var_14
					iter_7_2 = var_1_10010

					var_14(var_1_10010.Find(iter_7_2, "normal/consumeIcon"), false)

					setActive = var_14
					iter_7_2 = var_1_10010

					var_14(var_1_10010.Find(iter_7_2, "normal/have"), true)
				end
			end

			local var_7_30 = arg_7_1[1]

			var_7_0 = var_6.GetResourceConsume(var_7_30)[1]
			var_7_1 = var_6[2]
			var_7_2 = var_6[3]
		end
	end

	GetImageSpriteFromAtlasAsync = var_7_17
	Drop = var_7_3

	local var_7_31 = var_7_3.New({
		type = var_7_0,
		id = var_7_1
	})

	var_7_17(var_7.getIcon(var_7_31), "", arg_7_0.consumeIcon)

	setText = var_7_17

	var_7_17(arg_7_0.consumeCount, var_7_2)

	onButton = var_7_17

	local var_7_32 = arg_7_0
	local var_7_33 = arg_7_0.buyBtn

	local function var_7_34()
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

		IslandMediator = iter_8_0

		var_8_2(var_8_1, iter_8_0.BUY_COMMODITY, var_8_0)

		return
	end

	SFX_PANEL = var_1_10010

	var_7_17(var_7_32, var_7_33, var_7_34, var_1_10010)

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
