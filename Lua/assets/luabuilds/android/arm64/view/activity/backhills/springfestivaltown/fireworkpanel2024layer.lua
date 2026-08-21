local var_0_0 = class("FireworkPanel2024Layer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "FireworkPanelUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.leftPanel = arg_2_0._tf:Find("main/left_panel")
	arg_2_0.rightPanel = arg_2_0._tf:Find("main/right_panel")
	arg_2_0.fireBtn = arg_2_0.rightPanel:Find("fire_btn")

	setText(arg_2_0.rightPanel:Find("tip"), i18n("activity_yanhua_tip7"))

	arg_2_0.leftItem = arg_2_0.leftPanel:Find("scrollrect/content/item_tpl")
	arg_2_0.leftItems = arg_2_0.leftPanel:Find("scrollrect/content")
	arg_2_0.leftUIList = UIItemList.New(arg_2_0.leftItems, arg_2_0.leftItem)
	arg_2_0.rightItem = arg_2_0.rightPanel:Find("content/item_tpl")
	arg_2_0.rightItems = arg_2_0.rightPanel:Find("content")
	arg_2_0.rightUIList = UIItemList.New(arg_2_0.rightItems, arg_2_0.rightItem)
	arg_2_0.arrowsTF = arg_2_0.rightPanel:Find("arrows")

	arg_2_0:initData()

	return
end

function var_0_0.initData(arg_3_0)
	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FIREWORK)

	assert(var_3_0 and not var_3_0:isEnd(), "烟花活动(type92)已结束")

	arg_3_0.unlockCount = var_3_0:getData1()
	arg_3_0.unlockIds = var_3_0:getData1List()
	arg_3_0.allIds = pg.activity_template[var_3_0.id].config_data[3]
	arg_3_0.actId = var_3_0.id
	arg_3_0.playerId = getProxy(PlayerProxy):getData().id
	arg_3_0.orderIds = arg_3_0:getLocalData()

	return
end

function var_0_0.getLocalData(arg_4_0)
	for iter_4_0 = 1, #arg_4_0.allIds do
		local var_4_0 = PlayerPrefs.GetInt("fireworks_" .. arg_4_0.actId .. "_" .. arg_4_0.playerId .. "_pos_" .. iter_4_0)

		if var_4_0 ~= 0 then
			table.insert({}, var_4_0)
		end
	end

	return {}
end

function var_0_0.setLocalData(arg_5_0)
	for iter_5_0 = 1, #arg_5_0.allIds do
		local var_5_0 = arg_5_0.orderIds[iter_5_0] or 0

		PlayerPrefs.SetInt("fireworks_" .. arg_5_0.actId .. "_" .. arg_5_0.playerId .. "_pos_" .. iter_5_0, var_5_0)
	end

	return
end

function var_0_0.didEnter(arg_6_0)
	onButton(arg_6_0, arg_6_0._tf:Find("main/mask"), function()
		arg_6_0:emit(var_0_0.ON_CLOSE)

		return
	end)
	onButton(arg_6_0, arg_6_0.rightPanel:Find("close_btn"), function()
		arg_6_0:emit(var_0_0.ON_CLOSE)

		return
	end)
	onButton(arg_6_0, arg_6_0.fireBtn, function()
		arg_6_0:emit(var_0_0.ON_CLOSE)

		return
	end)
	arg_6_0:initLeft()
	arg_6_0:initRight()
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	return
end

function var_0_0.initLeft(arg_10_0)
	setActive(arg_10_0.leftPanel:Find("empty"), #arg_10_0.unlockIds == 0)
	setActive(arg_10_0.leftPanel:Find("scrollrect"), #arg_10_0.unlockIds > 0)
	arg_10_0.leftUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = "lock"

			if arg_11_1 + 1 <= #arg_10_0.unlockIds then
				var_11_0 = tostring(arg_10_0.unlockIds[arg_11_1 + 1])
			end

			arg_11_2.name = var_11_0

			if var_11_0 == "lock" then
				setActive(arg_11_2:Find("firework"), false)
			else
				local var_11_1 = tonumber(arg_11_2.name)

				setActive(arg_11_2:Find("firework"), true)
				setActive(arg_11_2:Find("firework/selected"), (table.contains(arg_10_0.orderIds, var_11_1)))
				GetImageSpriteFromAtlasAsync(Item.getConfigData(var_11_1).icon, "", (arg_11_2:Find("firework/icon")))
				onButton(arg_10_0, arg_11_2, function()
					arg_10_0:onLeftClick(var_11_1, var_0)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	arg_10_0.leftUIList:align(#arg_10_0.allIds)

	return
end

function var_0_0.initRight(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.allIds - 2 do
		cloneTplTo(arg_13_0.arrowsTF:Find("tpl"), arg_13_0.arrowsTF)
	end

	arg_13_0.rightUIList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = "null"

			if arg_14_1 + 1 <= #arg_13_0.orderIds then
				var_14_0 = tostring(arg_13_0.orderIds[arg_14_1 + 1])
			end

			arg_14_2.name = var_14_0

			local var_14_1 = arg_14_2:Find("icon")

			setActive(arg_14_2:Find("add"), var_14_0 == "null")

			if var_14_0 == "null" then
				setActive(var_14_1, false)
			else
				local var_14_2 = tonumber(arg_14_2.name)

				setActive(var_14_1, true)
				GetImageSpriteFromAtlasAsync(Item.getConfigData(var_14_2).icon, "", var_14_1)
				onButton(arg_13_0, var_14_1, function()
					arg_13_0:onRightClick(var_14_2)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	arg_13_0.rightUIList:align(#arg_13_0.allIds)

	return
end

function var_0_0.onLeftClick(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 then
		table.removebyvalue(arg_16_0.orderIds, arg_16_1)
	else
		table.insert(arg_16_0.orderIds, arg_16_1)
	end

	arg_16_0:setLocalData()
	arg_16_0.leftUIList:align(#arg_16_0.allIds)
	arg_16_0.rightUIList:align(#arg_16_0.allIds)

	return
end

function var_0_0.onRightClick(arg_17_0, arg_17_1)
	table.removebyvalue(arg_17_0.orderIds, arg_17_1)
	arg_17_0:setLocalData()
	arg_17_0.leftUIList:align(#arg_17_0.allIds)
	arg_17_0.rightUIList:align(#arg_17_0.allIds)

	return
end

function var_0_0.willExit(arg_18_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_18_0._tf)

	if arg_18_0.contextData.onExit then
		arg_18_0.contextData.onExit()
	end

	return
end

return var_0_0
