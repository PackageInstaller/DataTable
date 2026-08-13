class = var_0_10000

local var_0_0 = "WorldShopLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.Listeners = {
	onUpdateGoods = "updateGoods"
}
var_0_1.optionsPath = {
	"adapt/top/title/option"
}

function var_0_1.getUIName(arg_1_0)
	return "WorldShopUI"
end

function var_0_1.getBGM(arg_2_0)
	return "story-richang"
end

function var_0_1.init(arg_3_0)
	pairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(var_0_1.Listeners) do
		arg_3_0[iter_3_0] = function(...)
			var_0_1[iter_3_1](arg_3_0, ...)

			return
		end
	end

	local var_3_0 = arg_3_0._tf

	arg_3_0.btnBack = var_1.Find(var_3_0, "adapt/top/title/back_button")

	local var_3_1 = arg_3_0._tf

	arg_3_0.rtRes = var_1.Find(var_3_1, "adapt/middle/content/res")

	local var_3_2 = arg_3_0._tf

	arg_3_0.rtResetTime = var_1.Find(var_3_2, "adapt/middle/content/resetTimer")

	local var_3_3 = arg_3_0._tf

	arg_3_0.rtResetTip = var_1.Find(var_3_3, "adapt/middle/content/resetTip")

	local var_3_4 = arg_3_0._tf

	arg_3_0.rtShop = var_1.Find(var_3_4, "adapt/middle/content/world_shop")
	UIItemList = var_1

	local var_3_5 = var_1.New
	local var_3_6 = arg_3_0.rtShop
	local var_3_7 = var_2.Find(var_3_6, "content")
	local var_3_8 = arg_3_0.rtShop

	arg_3_0.goodsItemList = var_3_5(var_3_7, var_3.Find(var_3_8, "content/item_tpl"))
	OriginShopSingleWindow = var_1
	arg_3_0.singleWindow = var_1.New(arg_3_0._tf, arg_3_0.event)
	OriginShopMultiWindow = var_1
	arg_3_0.multiWindow = var_1.New(arg_3_0._tf, arg_3_0.event)

	arg_3_0:OverlayPanel(arg_3_0._tf)

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.btnBack

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.rtRes

	local function var_5_5()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit
		local var_7_2 = var_0_1.ON_DROP
		local var_7_3 = {}

		DROP_TYPE_RESOURCE = var_2_10004
		var_7_3.type = var_2_10004
		WorldConst = var_2_10004
		var_7_3.id = var_2_10004.ResourceID

		var_7_1(var_7_0, var_7_2, var_7_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10005)

	local var_5_6 = arg_5_0.goodsItemList

	var_1.make(var_5_6, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_8_1 + 1

		UIItemList = var_2_10004

		if arg_8_0 == var_2_10004.EventUpdate then
			Goods = var_4

			local var_8_1 = var_4.Create
			local var_8_2 = arg_5_0.goodsList[var_8_0]

			Goods = var_2_10006

			local var_8_3 = var_8_1(var_8_2, var_2_10006.TYPE_WORLD)

			WorldGoodsCard = var_8_2

			local var_8_4 = var_8_2.New(arg_8_2)

			var_5.update(var_8_4, var_8_3)

			local var_8_5 = var_8_3
			local var_8_6 = var_8_3.getLimitCount(var_8_5)

			setText = var_8_5

			local var_8_7 = arg_8_2
			local var_8_8 = arg_8_2.Find(var_8_7, "item/count_contain/label")

			i18n = var_8_7

			var_8_5(var_8_8, var_8_7("activity_shop_exchange_count"))

			setText = var_8_5

			var_8_5(arg_8_2:Find("item/count_contain/count"), var_8_6 - var_8_3.buyCount .. "/" .. var_8_6)

			setTextColor = var_8_5

			local var_8_9 = arg_8_2
			local var_8_10 = arg_8_2.Find(var_8_9, "item/count_contain/count")

			Color = var_8_9

			local var_8_11 = var_8_9.New

			unpack = var_10
			ActivityGoodsCard = var_11

			var_8_5(var_8_10, var_8_11(var_10(var_11.DefaultColor)))

			setTextColor = var_8_5

			local var_8_12 = arg_8_2
			local var_8_13 = arg_8_2.Find(var_8_12, "item/count_contain/label")

			Color = var_8_12

			local var_8_14 = var_8_12.New

			unpack = var_10
			ActivityGoodsCard = var_11

			var_8_5(var_8_13, var_8_14(var_10(var_11.DefaultColor)))

			onButton = var_8_5

			local var_8_15 = arg_5_0
			local var_8_16 = arg_8_2

			local function var_8_17()
				nowWorld = var_3_10000

				local var_9_0 = var_3_10000()
				local var_9_1 = var_8_3
				local var_9_2 = var_1.getConfig(var_9_1, "genre")

				ShopArgs = var_9_1

				local var_9_3

				if var_9_2 == var_9_1.WorldCollection then
					var_9_3 = var_9_0
					var_9_3 = var_9_0.GetTaskProxy(var_9_3)

					if var_1.hasDoingCollectionTask(var_9_3) then
						pg = var_1
						var_9_3 = var_1.TipsMgr.GetInstance()

						local var_9_4 = var_1.ShowTips

						i18n = var_3

						var_9_4(var_9_3, var_3("world_collection_task_tip_1"))

						do return end

						goto label_9_0
					end
				end

				if var_8_3.id == 100000 then
					underscore = var_1

					local var_9_5 = var_1.any

					underscore = var_9_3

					if not var_9_5(var_9_3.values(var_9_0.pressingAwardDic), function(arg_10_0)
						return arg_10_0.flag
					end) then
						pg = var_1

						local var_9_6 = var_1.TipsMgr.GetInstance()
						local var_9_7 = var_1.ShowTips

						i18n = var_3

						var_9_7(var_9_6, var_3("world_complete_item_tip"))

						return
					end
				end

				::label_9_0::

				local var_9_8 = var_8_3

				if not var_1.canPurchase(var_9_8) then
					pg = var_1

					local var_9_9 = var_1.TipsMgr.GetInstance()
					local var_9_10 = var_1.ShowTips

					i18n = var_3

					var_9_10(var_9_9, var_3("buy_countLimit"))

					return
				end

				local var_9_11

				if not (var_8_6 > 1) or not arg_5_0.multiWindow then
					var_9_11 = arg_5_0.singleWindow
				end

				var_9_11:ExecuteAction("Open", var_8_3, function(arg_11_0, arg_11_1)
					local var_11_0 = arg_5_0
					local var_11_1 = var_2.emit

					WorldShopMediator = var_4_10004

					var_11_1(var_11_0, var_4_10004.BUY_ITEM, arg_11_0.id, arg_11_1)

					return
				end)

				return
			end

			SFX_PANEL = var_11

			var_8_5(var_8_15, var_8_16, var_8_17, var_11)
		end

		return
	end)
	arg_5_0:AddWorldListener()

	nowWorld = var_1

	local var_5_7 = var_1()

	arg_5_0:updateGoods(nil, nil, var_5_7:GetWorldShopGoodsDictionary())

	local var_5_8 = var_5_7
	local var_5_9 = var_5_7.IsReseted(var_5_8)

	setActive = var_5_8

	var_5_8(arg_5_0.rtResetTime, var_5_9)

	setActive = var_5_8

	var_5_8(arg_5_0.rtResetTip, not var_5_9)

	setText = var_5_8

	local var_5_10 = arg_5_0.rtResetTime
	local var_5_11 = var_4.Find(var_5_10, "number")

	math = var_5_10

	var_5_8(var_5_11, var_5_10.floor(var_5_7:GetResetWaitingTime() / 0))

	setText = var_5_8

	local var_5_12 = arg_5_0.rtResetTip
	local var_5_13 = var_4.Find(var_5_12, "info")

	i18n = var_5_12

	var_5_8(var_5_13, var_5_12("world_shop_preview_tip"))

	if var_5_9 then
		WorldGuider = var_5_8

		local var_5_14 = var_5_8.GetInstance()

		var_3.PlayGuide(var_5_14, "WorldG180")
	end

	return
end

function var_0_1.onBackPressed(arg_12_0)
	local var_12_0 = arg_12_0.singleWindow

	if var_1.isShowing(var_12_0) then
		local var_12_1 = arg_12_0.singleWindow

		var_1.Close(var_12_1)

		return
	end

	local var_12_2 = arg_12_0.multiWindow

	if var_1.isShowing(var_12_2) then
		local var_12_3 = arg_12_0.multiWindow

		var_1.Close(var_12_3)

		return
	end

	pg = var_1

	local var_12_4 = var_1.CriMgr.GetInstance()
	local var_12_5 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10003

	var_12_5(var_12_4, var_1_10003)

	triggerButton = var_12_5

	var_12_5(arg_12_0.btnBack)

	return
end

function var_0_1.willExit(arg_13_0)
	arg_13_0:UnOverlayPanel(arg_13_0._tf)
	arg_13_0:RemoveWorldListener()

	local var_13_0 = arg_13_0.singleWindow

	var_1.Destroy(var_13_0)

	local var_13_1 = arg_13_0.multiWindow

	var_1.Destroy(var_13_1)

	return
end

function var_0_1.setPlayer(arg_14_0, arg_14_1)
	arg_14_0.player = arg_14_1
	GetImageSpriteFromAtlasAsync = var_1_10002
	Drop = var_1_10003

	local var_14_0 = var_1_10003.New
	local var_14_1 = {}

	DROP_TYPE_RESOURCE = var_1_10005
	var_14_1.type = var_1_10005
	WorldConst = var_1_10005
	var_14_1.id = var_1_10005.ResourceID

	local var_14_2 = var_14_0(var_14_1)
	local var_14_3 = var_3.getIcon(var_14_2)
	local var_14_4 = ""
	local var_14_5 = arg_14_0.rtRes

	var_1_10002(var_14_3, var_14_4, var_5.Find(var_14_5, "icon"), true)

	setText = var_1_10002

	local var_14_6 = arg_14_0.rtRes
	local var_14_7 = var_3.Find(var_14_6, "number")
	local var_14_8 = arg_14_0.player
	local var_14_9 = var_4.getResource

	WorldConst = var_6

	var_1_10002(var_14_7, var_14_9(var_14_8, var_6.ResourceID))

	return
end

function var_0_1.AddWorldListener(arg_15_0)
	nowWorld = var_1_10001

	local var_15_0 = var_1_10001()
	local var_15_1 = var_1.AddListener

	World = var_1_10003

	var_15_1(var_15_0, var_1_10003.EventUpdateShopGoods, arg_15_0.onUpdateGoods)

	return
end

function var_0_1.RemoveWorldListener(arg_16_0)
	nowWorld = var_1_10001

	local var_16_0 = var_1_10001()
	local var_16_1 = var_1.RemoveListener

	World = var_1_10003

	var_16_1(var_16_0, var_1_10003.EventUpdateShopGoods, arg_16_0.onUpdateGoods)

	return
end

function var_0_1.updateGoods(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	pg = var_1_10004

	local var_17_0 = var_1_10004.TimeMgr.GetInstance()

	nowWorld = var_1_10005

	local var_17_1 = var_1_10005().expiredTime
	local var_17_2 = var_5:GetTaskProxy()
	local var_17_3 = {}

	pairs = var_1_10009

	for iter_17_0, iter_17_1 in var_1_10009(arg_17_3) do
		local var_17_4 = var_17_0
		local var_17_5 = var_17_0.inTime

		pg = var_1_10016

		if var_17_5(var_17_4, var_1_10016.shop_template[iter_17_0].time) then
			local var_17_6 = var_17_0
			local var_17_7 = var_17_0.inTime

			pg = var_1_10016

			if not var_17_7(var_17_6, var_1_10016.shop_template[iter_17_0].time, var_17_1 - 1) then
				-- block empty
			else
				if iter_17_0 == 100000 then
					nowWorld = var_14
					var_17_6 = var_14()

					if not var_14.IsReseted(var_17_6) then
						goto label_17_0
					end
				end

				pg = var_14

				local var_17_8 = var_14.shop_template[iter_17_0].genre

				ShopArgs = var_17_6

				if var_17_8 == var_17_6.WorldCollection and iter_17_1 == 0 then
					local var_17_9 = var_17_2

					var_17_8 = var_17_2.getRecycleTask
					pg = var_1_10016

					if var_17_8(var_17_9, var_1_10016.shop_template[iter_17_0].effect_args[2]) then
						goto label_17_0
					end
				end

				table = var_17_8

				var_17_8.insert(var_17_3, {
					id = iter_17_0,
					count = iter_17_1
				})
			end
		end

		::label_17_0::
	end

	table = var_9

	local var_17_10 = var_9.sort
	local var_17_11 = var_17_3

	CompareFuncs = var_11

	var_17_10(var_17_11, var_11({
		function(arg_18_0)
			pg = var_2_10001

			return var_2_10001.shop_template[arg_18_0.id].order
		end,
		function(arg_19_0)
			return arg_19_0.id
		end
	}))

	arg_17_0.goodsList = var_17_3

	local var_17_12 = arg_17_0.goodsItemList

	var_9.align(var_17_12, #arg_17_0.goodsList)

	return
end

return var_0_1
