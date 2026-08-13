class = var_0_10000

local var_0_0 = "ZumaPTShopScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ZumaPTShopUI"
end

function var_0_1.getBGM(arg_2_0)
	return "cw-story"
end

function var_0_1.init(arg_3_0)
	arg_3_0:initData()
	arg_3_0:findUI()
	arg_3_0:addListener()

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:updatePTPanel()
	arg_4_0:updateGoodPanel()

	return
end

function var_0_1.onBackPressed(arg_5_0)
	arg_5_0:closeView()

	return
end

function var_0_1.willExit(arg_6_0)
	return
end

function var_0_1.initData(arg_7_0)
	ActivityConst = var_1_10001
	arg_7_0.actID = var_1_10001.MINIGAME_ZUMA_PT_SHOP_ID
	LaunchBallActivityMgr = var_1

	local var_7_0 = var_1.GetGamePtId

	ActivityConst = var_1_10002
	arg_7_0.ptID = var_7_0(var_1_10002.MINIGAME_ZUMA)
	id2ItemId = var_1
	arg_7_0.ptItemID = var_1(arg_7_0.ptID)
	arg_7_0.actShopVO = nil
	arg_7_0.goodVOListForShow = nil
	pg = var_1
	arg_7_0.goodIDList = var_1.activity_template[arg_7_0.actID].config_data
	arg_7_0.goodTFList = {}

	arg_7_0:updateData()

	return
end

function var_0_1.findUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.tpl = var_1.Find(var_8_0, "Tpl")

	local var_8_1 = arg_8_0._tf

	arg_8_0.containerTF = var_1.Find(var_8_1, "Shop/Panel/ScrollView/Viewport/Content")

	local var_8_2 = arg_8_0._tf

	arg_8_0.backBtn = var_1.Find(var_8_2, "Adapt/Back")

	local var_8_3 = arg_8_0._tf

	arg_8_0.helpBtn = var_1.Find(var_8_3, "Adapt/Help")

	local var_8_4 = arg_8_0._tf

	arg_8_0.ptInfoIcon = var_1.Find(var_8_4, "Shop/PTInfo/Icon")

	local var_8_5 = arg_8_0._tf

	arg_8_0.ptInfoCountText = var_1.Find(var_8_5, "Shop/PTInfo/Count")
	setText = var_1

	local var_8_6 = arg_8_0.tpl
	local var_8_7 = var_2.Find(var_8_6, "Tip")

	i18n = var_8_6

	var_1(var_8_7, var_8_6("islandshop_tips2"))

	return
end

function var_0_1.addListener(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.backBtn

	local function var_9_2()
		local var_10_0 = arg_9_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_9_0, var_9_1, var_9_2, var_1_10005)

	onButton = var_1_10001

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.helpBtn

	local function var_9_5()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_11_2.type = var_2_10003
		i18n = var_2_10003
		var_11_2.helps = var_2_10003("card_pairs_help_tip")

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_9_3, var_9_4, var_9_5, var_1_10005)

	UIItemList = var_1_10001
	arg_9_0.goodUIItemList = var_1_10001.New(arg_9_0.containerTF, arg_9_0.tpl)

	local var_9_6 = arg_9_0.goodUIItemList

	var_1.make(var_9_6, function(arg_12_0, arg_12_1, arg_12_2)
		arg_12_1 = arg_12_1 + 1
		UIItemList = var_2_10003

		local var_12_0

		if arg_12_0 == var_2_10003.EventInit then
			var_12_0 = arg_9_0.goodTFList
			var_12_0[arg_12_1] = arg_12_2
			onButton = var_12_0

			local var_12_1 = arg_9_0
			local var_12_2 = arg_12_2

			local function var_12_3()
				isActive = var_3_10000

				local var_13_0 = arg_12_2
				local var_13_2

				if not var_3_10000(var_1.Find(var_13_0, "Mask")) then
					local var_13_1 = arg_9_0

					var_13_2 = var_13_2.emit
					ZumaPTShopMediator = var_13_0
					var_13_0 = var_13_0.OPEN_ZUMA_PT_SHOP_BUY_WINDOW

					local var_13_3 = arg_9_0

					var_13_2(var_13_1, var_13_0, var_3.getGoodVOByIndex(var_13_3, arg_12_1))
				else
					pg = var_13_2

					local var_13_4 = var_13_2.TipsMgr.GetInstance()
					local var_13_5 = var_0.ShowTips

					i18n = var_13_0

					var_13_5(var_13_4, var_13_0("launchball_minigame_shop"))
				end

				return
			end

			SFX_PANEL = var_2_10007

			var_12_0(var_12_1, var_12_2, var_12_3, var_2_10007)
		else
			UIItemList = var_12_0

			if arg_12_0 == var_12_0.EventUpdate then
				local var_12_4 = arg_9_0

				var_3.updateTpl(var_12_4, arg_12_1, arg_12_2)
			end
		end

		return
	end)

	return
end

function var_0_1.updateData(arg_14_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_14_0 = var_1_10001(var_1_10002)
	local var_14_1 = var_1.getActivityById(var_14_0, arg_14_0.actID)

	ActivityShop = var_14_0
	arg_14_0.actShopVO = var_14_0.New(var_14_1)

	local var_14_2 = arg_14_0.actShopVO

	arg_14_0.goodVOListForShow = var_2.getSortGoods(var_14_2)

	return
end

function var_0_1.getGoodVOByIndex(arg_15_0, arg_15_1)
	return arg_15_0.goodVOListForShow[arg_15_1]
end

function var_0_1.updatePTPanel(arg_16_0)
	Drop = var_1_10001

	local var_16_0 = var_1_10001.New({
		type = 1,
		id = arg_16_0.ptID
	})
	local var_16_1 = var_1.getOwnedCount(var_16_0)

	setText = var_16_0

	var_16_0(arg_16_0.ptInfoCountText, var_16_1)

	return
end

function var_0_1.updateGoodPanel(arg_17_0)
	local var_17_0 = arg_17_0.goodUIItemList

	var_1.align(var_17_0, #arg_17_0.goodVOListForShow)

	return
end

function var_0_1.updateTpl(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2:Find("Item")
	local var_18_1 = arg_18_2:Find("Name/Name")
	local var_18_2 = arg_18_2:Find("PTCount")
	local var_18_3 = arg_18_2:Find("BuyCount")
	local var_18_4 = arg_18_0.goodVOListForShow[arg_18_1]

	Drop = var_8

	local var_18_5 = var_8.New({
		type = var_18_4:getConfig("commodity_type"),
		id = var_18_4:getConfig("commodity_id"),
		count = var_18_4:getConfig("num")
	})

	updateDrop = var_9

	var_9(var_18_0, var_18_5)

	setScrollText = var_9

	var_9(var_18_1, var_18_5:getName())

	local var_18_6 = var_18_4
	local var_18_7 = var_18_4.getConfig(var_18_6, "resource_num")

	setText = var_18_6

	var_18_6(var_18_2, var_18_7)

	local var_18_8 = var_18_4

	if var_18_4.getConfig(var_18_8, "num_limit") == 0 then
		setText = var_18_8

		local var_18_9 = var_18_3

		i18n = var_1_10013

		var_18_8(var_18_9, var_1_10013("common_no_limit"))
	else
		setText = var_18_8

		local var_18_10 = var_18_3

		math = var_1_10013

		var_18_8(var_18_10, var_1_10013.max(var_18_4:GetPurchasableCnt(), 0) .. "/" .. var_10)
	end

	local var_18_11 = arg_18_2:Find("Mask")
	local var_18_12 = var_11.Find(var_18_11, "Lock")
	local var_18_13 = var_11:Find("SellOut")

	if var_10 > 0 then
		local var_18_14 = var_18_4
		local var_18_15

		if not (var_18_4.GetPurchasableCnt(var_18_14) <= 0) then
			var_18_15 = false
		else
			var_18_15 = true
		end

		setActive = var_18_14

		var_18_14(var_11, var_18_15)

		setActive = var_18_14

		var_18_14(var_18_13, var_18_15)

		setActive = var_18_14

		var_18_14(var_18_12, false)

		return
	end
end

function var_0_1.updateTplByGoodID(arg_19_0, arg_19_1)
	local var_19_0 = 0

	ipairs = var_1_10003

	for iter_19_0, iter_19_1 in var_1_10003(arg_19_0.goodVOListForShow) do
		if iter_19_1.id == arg_19_1 then
			var_19_0 = iter_19_0
		end
	end

	local var_19_1 = arg_19_0.goodTFList[var_19_0]

	arg_19_0:updateTpl(var_19_0, var_19_1)

	return
end

return var_0_1
