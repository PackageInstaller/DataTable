class = var_0_10000

local var_0_0 = "FireworkPanel2024Layer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "FireworkPanelUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.leftPanel = var_1.Find(var_2_0, "main/left_panel")

	local var_2_1 = arg_2_0._tf

	arg_2_0.rightPanel = var_1.Find(var_2_1, "main/right_panel")

	local var_2_2 = arg_2_0.rightPanel

	arg_2_0.fireBtn = var_1.Find(var_2_2, "fire_btn")
	setText = var_1

	local var_2_3 = arg_2_0.rightPanel
	local var_2_4 = var_2.Find(var_2_3, "tip")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("activity_yanhua_tip7"))

	local var_2_5 = arg_2_0.leftPanel

	arg_2_0.leftItem = var_1.Find(var_2_5, "scrollrect/content/item_tpl")

	local var_2_6 = arg_2_0.leftPanel

	arg_2_0.leftItems = var_1.Find(var_2_6, "scrollrect/content")
	UIItemList = var_1
	arg_2_0.leftUIList = var_1.New(arg_2_0.leftItems, arg_2_0.leftItem)

	local var_2_7 = arg_2_0.rightPanel

	arg_2_0.rightItem = var_1.Find(var_2_7, "content/item_tpl")

	local var_2_8 = arg_2_0.rightPanel

	arg_2_0.rightItems = var_1.Find(var_2_8, "content")
	UIItemList = var_1
	arg_2_0.rightUIList = var_1.New(arg_2_0.rightItems, arg_2_0.rightItem)

	local var_2_9 = arg_2_0.rightPanel

	arg_2_0.arrowsTF = var_1.Find(var_2_9, "arrows")

	arg_2_0:initData()

	return
end

function var_0_1.initData(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_3_2 = var_3_1(var_3_0, var_1_10003.ACTIVITY_TYPE_FIREWORK)

	assert = var_3_0

	var_3_0(var_3_2 and not var_3_2:isEnd(), "烟花活动(type92)已结束")

	arg_3_0.unlockCount = var_3_2:getData1()
	arg_3_0.unlockIds = var_3_2:getData1List()
	pg = var_2
	arg_3_0.allIds = var_2.activity_template[var_3_2.id].config_data[3]
	arg_3_0.actId = var_3_2.id
	getProxy = var_2
	PlayerProxy = var_3

	local var_3_3 = var_2(var_3)

	arg_3_0.playerId = var_2.getData(var_3_3).id
	arg_3_0.orderIds = arg_3_0:getLocalData()

	return
end

function var_0_1.getLocalData(arg_4_0)
	local var_4_0 = {}

	for iter_4_0 = 1, #arg_4_0.allIds do
		PlayerPrefs = var_1_10006

		if var_1_10006.GetInt("fireworks_" .. arg_4_0.actId .. "_" .. arg_4_0.playerId .. "_pos_" .. iter_4_0) ~= 0 then
			table = var_7

			var_7.insert(var_4_0, var_1_10006)
		end
	end

	return var_4_0
end

function var_0_1.setLocalData(arg_5_0)
	for iter_5_0 = 1, #arg_5_0.allIds do
		local var_5_0

		if not arg_5_0.orderIds[iter_5_0] then
			var_5_0 = 0
		end

		PlayerPrefs = var_1_10006

		var_1_10006.SetInt("fireworks_" .. arg_5_0.actId .. "_" .. arg_5_0.playerId .. "_pos_" .. iter_5_0, var_5_0)
	end

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf

	var_1_10001(var_6_0, var_3.Find(var_6_1, "main/mask"), function()
		local var_7_0 = arg_6_0

		var_0.emit(var_7_0, var_0_1.ON_CLOSE)

		return
	end)

	onButton = var_1_10001

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.rightPanel

	var_1_10001(var_6_2, var_3.Find(var_6_3, "close_btn"), function()
		local var_8_0 = arg_6_0

		var_0.emit(var_8_0, var_0_1.ON_CLOSE)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_6_0, arg_6_0.fireBtn, function()
		local var_9_0 = arg_6_0

		var_0.emit(var_9_0, var_0_1.ON_CLOSE)

		return
	end)
	arg_6_0:initLeft()
	arg_6_0:initRight()

	pg = var_1

	local var_6_4 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_6_4, arg_6_0._tf)

	return
end

function var_0_1.initLeft(arg_10_0)
	setActive = var_1_10001

	local var_10_0 = arg_10_0.leftPanel

	var_1_10001(var_2.Find(var_10_0, "empty"), #arg_10_0.unlockIds == 0)

	setActive = var_1_10001

	local var_10_1 = arg_10_0.leftPanel

	var_1_10001(var_2.Find(var_10_1, "scrollrect"), #arg_10_0.unlockIds > 0)

	local var_10_2 = arg_10_0.leftUIList

	var_1.make(var_10_2, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_11_1 + 1
			local var_11_1 = "lock"

			if var_11_0 <= #arg_10_0.unlockIds then
				tostring = var_5
				var_11_1 = var_5(arg_10_0.unlockIds[var_11_0])
			end

			arg_11_2.name = var_11_1

			if var_11_1 == "lock" then
				setActive = var_5

				var_5(arg_11_2:Find("firework"), false)
			else
				tonumber = var_5

				local var_11_2 = var_5(arg_11_2.name)
				local var_11_3 = arg_11_2:Find("firework/icon")
				local var_11_4 = arg_11_2
				local var_11_5 = arg_11_2.Find(var_11_4, "firework/selected")

				setActive = var_11_4

				var_11_4(arg_11_2:Find("firework"), true)

				table = var_11_4

				local var_11_6 = var_11_4.contains(arg_10_0.orderIds, var_11_2)

				setActive = var_9

				var_9(var_11_5, var_11_6)

				GetImageSpriteFromAtlasAsync = var_9
				Item = var_10

				var_9(var_10.getConfigData(var_11_2).icon, "", var_11_3)

				onButton = var_9

				local var_11_7 = arg_10_0
				local var_11_8 = arg_11_2

				local function var_11_9()
					local var_12_0 = arg_10_0

					var_0.onLeftClick(var_12_0, var_11_2, var_11_6)

					return
				end

				SFX_PANEL = var_2_10013

				var_9(var_11_7, var_11_8, var_11_9, var_2_10013)
			end
		end

		return
	end)

	local var_10_3 = arg_10_0.leftUIList

	var_1.align(var_10_3, #arg_10_0.allIds)

	return
end

function var_0_1.initRight(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.allIds - 2 do
		cloneTplTo = var_1_10005

		local var_13_0 = arg_13_0.arrowsTF

		var_1_10005(var_6.Find(var_13_0, "tpl"), arg_13_0.arrowsTF)
	end

	local var_13_1 = arg_13_0.rightUIList

	var_1.make(var_13_1, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = arg_14_1 + 1
			local var_14_1 = "null"

			if var_14_0 <= #arg_13_0.orderIds then
				tostring = var_5
				var_14_1 = var_5(arg_13_0.orderIds[var_14_0])
			end

			arg_14_2.name = var_14_1

			local var_14_2 = arg_14_2
			local var_14_3 = arg_14_2.Find(var_14_2, "icon")

			setActive = var_14_2

			var_14_2(arg_14_2:Find("add"), var_14_1 == "null")

			if var_14_1 == "null" then
				setActive = var_14_2

				var_14_2(var_14_3, false)
			else
				tonumber = var_14_2

				local var_14_4 = var_14_2(arg_14_2.name)

				setActive = var_7

				var_7(var_14_3, true)

				GetImageSpriteFromAtlasAsync = var_7
				Item = var_8

				var_7(var_8.getConfigData(var_14_4).icon, "", var_14_3)

				onButton = var_7

				local var_14_5 = arg_13_0
				local var_14_6 = var_14_3

				local function var_14_7()
					local var_15_0 = arg_13_0

					var_0.onRightClick(var_15_0, var_14_4)

					return
				end

				SFX_PANEL = var_2_10011

				var_7(var_14_5, var_14_6, var_14_7, var_2_10011)
			end
		end

		return
	end)

	local var_13_2 = arg_13_0.rightUIList

	var_1.align(var_13_2, #arg_13_0.allIds)

	return
end

function var_0_1.onLeftClick(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 then
		table = var_1_10003

		var_1_10003.removebyvalue(arg_16_0.orderIds, arg_16_1)
	else
		table = var_1_10003

		var_1_10003.insert(arg_16_0.orderIds, arg_16_1)
	end

	arg_16_0:setLocalData()

	local var_16_0 = arg_16_0.leftUIList

	var_3.align(var_16_0, #arg_16_0.allIds)

	local var_16_1 = arg_16_0.rightUIList

	var_3.align(var_16_1, #arg_16_0.allIds)

	return
end

function var_0_1.onRightClick(arg_17_0, arg_17_1)
	table = var_1_10002

	var_1_10002.removebyvalue(arg_17_0.orderIds, arg_17_1)
	arg_17_0:setLocalData()

	local var_17_0 = arg_17_0.leftUIList

	var_2.align(var_17_0, #arg_17_0.allIds)

	local var_17_1 = arg_17_0.rightUIList

	var_2.align(var_17_1, #arg_17_0.allIds)

	return
end

function var_0_1.willExit(arg_18_0)
	pg = var_1_10001

	local var_18_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_18_0, arg_18_0._tf)

	if arg_18_0.contextData.onExit then
		arg_18_0.contextData.onExit()
	end

	return
end

return var_0_1
