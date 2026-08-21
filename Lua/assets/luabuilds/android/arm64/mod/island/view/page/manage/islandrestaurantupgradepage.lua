local var_0_0 = class("IslandRestaurantUpgradePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandRestaurantUpgradeUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.titleTF = arg_2_0._tf:Find("title/name/Text")

	local var_2_0 = arg_2_0._tf:Find("window/summary")

	setText(var_2_0:Find("title/Text"), i18n("island_manage_result_3"))

	arg_2_0.shelfTF = var_2_0:Find("shelf/info/value")

	setText(var_2_0:Find("shelf/info/name"), i18n("island_manage_slot"))

	arg_2_0.capacityTF = var_2_0:Find("capacity/info/value")

	setText(var_2_0:Find("capacity/info/name"), i18n("island_manage_food_cnt"))

	arg_2_0.percentTF = var_2_0:Find("percent/info/value")

	setText(var_2_0:Find("percent/info/name"), i18n("island_manage_sale_ratio"))

	arg_2_0.assistantTF = var_2_0:Find("assistant/info/value")

	setText(var_2_0:Find("assistant/info/name"), i18n("island_manage_worker_cnt"))

	arg_2_0.viewTF = arg_2_0._tf:Find("window/rank")
	arg_2_0.uiList = UIItemList.New(arg_2_0.viewTF:Find("content"), arg_2_0.viewTF:Find("content/tpl"))

	setText(arg_2_0._tf:Find("tip"), i18n("child_close_tip"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("mask"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	arg_3_0.uiList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			arg_5_2.name = pg.island_manage_rank[arg_3_0.rankIds[arg_5_1 + 1]].id

			LoadImageSpriteAsync("island/islandrestaurant/" .. pg.island_manage_rank[arg_3_0.rankIds[arg_5_1 + 1]].icon, arg_5_2:Find("icon"))
			setActive(arg_5_2:Find("dot/silder"), arg_5_1 + 1 ~= #arg_3_0.rankIds)
		elseif arg_5_0 == UIItemList.EventUpdate then
			arg_3_0:UpdataItem(arg_5_1, arg_5_2)
		end

		return
	end)

	arg_3_0.rankIds = pg.island_manage_rank.all

	table.sort(arg_3_0.rankIds)

	return
end

function var_0_0.OnShow(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:BlurPanel()

	arg_6_0.callback = arg_6_2
	arg_6_0.restId = arg_6_1.restId
	arg_6_0.oldSale = arg_6_1.oldSale
	arg_6_0.rest = getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurant(arg_6_0.restId)
	arg_6_0.level = arg_6_0.rest:GetRankLevel()
	arg_6_0.sales = arg_6_0.rest:GetSales()
	arg_6_0.expData = IslandRestaurant.GET_RNAK_EXPS(arg_6_0.restId)

	setText(arg_6_0.titleTF, arg_6_0.rest:getConfig("name"))
	arg_6_0:UpdataSummary()
	arg_6_0.uiList:align(#arg_6_0.rankIds)
	scrollTo(arg_6_0.viewTF, (arg_6_0.level - 1) / (#arg_6_0.rankIds - 3), 0)

	return
end

function var_0_0.UpdataItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.rankIds[arg_7_1]
	local var_7_1 = arg_7_0.expData[arg_7_0.rankIds[arg_7_1 + 1]]

	setActive(arg_7_2:Find("dot/finished"), arg_7_0.rankIds[arg_7_1 + 1] <= arg_7_0.level)

	local var_7_2 = arg_7_0.expData[var_7_0] or 0
	local var_7_3 = 0

	if var_7_1 ~= var_7_2 then
		var_7_3 = (arg_7_0.sales - var_7_2) / (var_7_1 - var_7_2)
	end

	setSlider(arg_7_2:Find("dot/silder"), 0, 1, var_7_3)

	return
end

function var_0_0.UpdataSummary(arg_8_0)
	local var_8_0 = pg.island_manage_rank[arg_8_0.level]
	local var_8_1 = pg.island_manage_rank[arg_8_0.level - 1]

	setText(arg_8_0.shelfTF:Find("base"), pg.island_manage_rank[arg_8_0.level - 1].slot_num[1])

	local var_8_3 = arg_8_0.shelfTF:Find("add")

	if var_8_0.slot_num[1] - var_8_1.slot_num[1] > 0 then
		local var_8_4 = "+" .. var_8_0.slot_num[1] - var_8_1.slot_num[1] or ""

		var_8_2(var_8_3, var_8_4)
		setText(arg_8_0.capacityTF:Find("base"), var_8_1.slot_num[2])

		local var_8_6 = arg_8_0.capacityTF:Find("add")

		if var_8_0.slot_num[2] - var_8_1.slot_num[2] > 0 then
			local var_8_7 = "+" .. var_8_0.slot_num[2] - var_8_1.slot_num[2] or ""

			var_8_5(var_8_6, var_8_7)
			setText(arg_8_0.percentTF:Find("base"), var_8_1.bonus_coefficient / 100 .. "%")

			local var_8_9 = arg_8_0.percentTF:Find("add")

			if (var_8_0.bonus_coefficient - var_8_1.bonus_coefficient) / 100 > 0 then
				local var_8_10 = "+" .. (var_8_0.bonus_coefficient - var_8_1.bonus_coefficient) / 100 .. "%" or ""

				var_8_8(var_8_9, var_8_10)
				setText(arg_8_0.assistantTF:Find("base"), var_8_1.assistant_num)

				local var_8_12 = arg_8_0.assistantTF:Find("add")

				if var_8_0.assistant_num - var_8_1.assistant_num > 0 then
					local var_8_13 = "+" .. var_8_0.assistant_num - var_8_1.assistant_num or ""

					var_8_11(var_8_12, var_8_13)

					return
				end
			end
		end
	end
end

function var_0_0.OnHide(arg_9_0)
	arg_9_0:UnBlurPanel()
	existCall(arg_9_0.callback)

	arg_9_0.callback = nil

	return
end

function var_0_0.OnDestroy(arg_10_0)
	arg_10_0:UnBlurPanel()

	return
end

return var_0_0
