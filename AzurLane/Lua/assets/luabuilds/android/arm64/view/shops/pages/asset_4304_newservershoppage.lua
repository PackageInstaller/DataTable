class = var_0_10000

local var_0_0 = "NewServerShopPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewServerShopPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "scrollView")

	arg_2_0.scrollrect = var_1.GetComponent(var_2_1, "LScrollRect")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "res_pt/Text")
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.resTxt = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0._tf

	arg_2_0.resIcon = var_1.Find(var_2_5, "res_pt/icon")

	local var_2_6 = {}
	local var_2_7 = arg_2_0._tf

	var_2_6[1] = var_2.Find(var_2_7, "pagefooter/tpl")
	arg_2_0.pagefooters = var_2_6
	arg_2_0.pagefooterWid = arg_2_0.pagefooters[1].rect.width
	arg_2_0.pagefooterStartPosX = arg_2_0.pagefooters[1].anchoredPosition.x
	NewServerShopPurchasePanel = var_1
	arg_2_0.purchasePage = var_1.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	NewServerShopMultiWindow = var_1
	arg_2_0.multiWindow = var_1.New(arg_2_0._tf, arg_2_0.event)
	NewServerShopSingleWindow = var_1
	arg_2_0.singleWindow = var_1.New(arg_2_0._tf, arg_2_0.event)

	local var_2_8 = arg_2_0._tf

	Vector3 = var_2
	var_2_8.localPosition = var_2(-6, -25)

	return
end

function var_0_1.UpdateRes(arg_3_0)
	local var_3_0 = arg_3_0.shop
	local var_3_1 = var_1.GetPtId(var_3_0)

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_3_2 = var_1_10002(var_1_10004)
	local var_3_3 = var_2.getRawData(var_3_2)
	local var_3_4 = var_2.getResource(var_3_3, var_3_1)

	arg_3_0.resTxt.text = var_3_4

	if not arg_3_0.isInitResIcon then
		arg_3_0.isInitResIcon = true
		GetImageSpriteFromAtlasAsync = var_4
		Drop = var_6

		local var_3_5 = var_6.New
		local var_3_6 = {}

		DROP_TYPE_RESOURCE = var_1_10009
		var_3_6.type = var_1_10009
		var_3_6.id = var_3_1

		local var_3_7 = var_3_5(var_3_6)

		var_4(var_6.getIcon(var_3_7), "", arg_3_0.resIcon)
	end

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0.cards = {}

	function arg_4_0.scrollrect.onInitItem(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.OnInitItem(var_5_0, arg_5_0)

		return
	end

	function arg_4_0.scrollrect.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_4_0

		var_2.OnUpdateItem(var_6_0, arg_6_0, arg_6_1)

		return
	end

	return
end

function var_0_1.OnInitItem(arg_7_0, arg_7_1)
	NewServerGoodsCard = var_1_10002

	local var_7_0 = var_1_10002.New(arg_7_1)

	onButton = var_1_10003

	local var_7_1 = arg_7_0
	local var_7_2 = var_7_0._tf

	local function var_7_3()
		local var_8_0 = arg_7_0

		var_0.OnClickCard(var_8_0, var_7_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_7_1, var_7_2, var_7_3, var_1_10008)

	arg_7_0.cards[arg_7_1] = var_7_0

	return
end

function var_0_1.OnClickCard(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.commodity
	local var_9_1 = var_2.IsOpening
	local var_9_2 = arg_9_0.shop
	local var_9_3, var_9_4 = var_9_1(var_9_0, var_6.GetStartTime(var_9_2))

	if not var_9_3 then
		local var_9_5 = var_9_4.day

		if 0 < var_9_5 then
			local var_9_6 = var_9_4.day

			i18n = var_6

			local var_9_7

			if not (var_9_6 .. var_6("word_date")) then
				var_9_7 = ""
			end

			local var_9_8 = var_9_7
			local var_9_9 = var_9_4.hour

			i18n = var_9_2

			local var_9_10 = var_9_8 .. var_9_9 .. var_9_2("word_hour")

			pg = var_9_9

			local var_9_11 = var_9_9.TipsMgr.GetInstance()
			local var_9_12 = var_7.ShowTips

			i18n = var_10

			var_9_12(var_9_11, var_10("newserver_shop_timelimit", var_9_10))

			do return end

			if var_2:Selectable() then
				local var_9_13 = arg_9_0.purchasePage

				var_5.ExecuteAction(var_9_13, "Show", var_2)
			else
				local var_9_14

				if var_2:getConfig("goods_purchase_limit") == 1 or var_2:getConfig("type") == 4 then
					var_9_14 = arg_9_0.singleWindow
				else
					var_9_14 = arg_9_0.multiWindow
				end

				var_9_14:ExecuteAction("Open", var_2, function(arg_10_0, arg_10_1, arg_10_2)
					local var_10_1

					if not arg_10_0:CanPurchase() then
						pg = var_10_1

						local var_10_0 = var_10_1.TipsMgr.GetInstance()

						var_10_1 = var_10_1.ShowTips
						i18n = var_2_10006

						var_10_1(var_10_0, var_2_10006("buy_countLimit"))

						return
					end

					pg = var_10_1

					local var_10_2 = var_10_1.m02
					local var_10_3 = var_3.sendNotification

					GAME = var_2_10006

					var_10_3(var_10_2, var_2_10006.NEW_SERVER_SHOP_SHOPPING, {
						id = arg_10_0.id,
						selectedList = arg_10_0:getConfig("goods"),
						count = arg_10_1
					})

					return
				end)
			end

			return
		end
	end
end

function var_0_1.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.cards[arg_11_2] then
		arg_11_0:OnInitItem(arg_11_2)
	end

	local var_11_0 = arg_11_0.cards[arg_11_2]
	local var_11_1 = arg_11_0.displays[arg_11_1 + 1]

	var_11_0:Update(var_11_1, arg_11_0.shop)

	return
end

function var_0_1.FetchShop(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	ShopsProxy = var_1_10004

	local var_12_0 = var_1_10002(var_1_10004)
	local var_12_1 = var_2.GetNewServerShop

	ActivityConst = var_1_10005

	if not var_12_1(var_12_0, var_1_10005.ACTIVITY_TYPE_NEWSERVER_SHOP) then
		pg = var_1_10003

		local var_12_2 = var_1_10003.m02
		local var_12_3 = var_3.sendNotification

		GAME = var_1_10006

		var_12_3(var_12_2, var_1_10006.GET_NEW_SERVER_SHOP, {
			callback = arg_12_1
		})
	else
		arg_12_1(var_2)
	end

	return
end

function var_0_1.SetShop(arg_13_0, arg_13_1)
	arg_13_0.shop = arg_13_1

	return
end

function var_0_1.Flush(arg_14_0)
	if arg_14_0.shop then
		arg_14_0:Show()
		arg_14_0:UpdatePageFooters()
		arg_14_0:UpdateRes()
	else
		arg_14_0:FetchShop(function(arg_15_0)
			if not arg_15_0 then
				return
			end

			arg_14_0.shop = arg_15_0

			local var_15_0 = arg_14_0

			var_1.Show(var_15_0)

			local var_15_1 = arg_14_0

			var_1.UpdatePageFooters(var_15_1)

			local var_15_2 = arg_14_0

			var_1.UpdateRes(var_15_2)

			return
		end)
	end

	return
end

local function var_0_2(arg_16_0, arg_16_1)
	local var_16_0

	if not arg_16_0.pagefooters[arg_16_1] then
		var_1_10003 = arg_16_0.pagefooters[1]
		Object = var_1_10004
		var_16_0 = var_1_10004.Instantiate(var_1_10003, var_1_10003.parent)
		arg_16_0.pagefooters[arg_16_1] = var_16_0
	end

	setActive = var_1_10003

	var_1_10003(var_16_0, true)

	return var_16_0
end

function var_0_1.UpdatePageFooters(arg_17_0)
	local var_17_0 = arg_17_0.shop
	local var_17_1 = var_1.GetPhases(var_17_0)

	arg_17_0.pagefooterTrs = {}

	for iter_17_0 = 1, #var_17_1 do
		var_1_10007 = var_0_2(arg_17_0, iter_17_0)

		arg_17_0:UpdatePageFooter(var_1_10007, iter_17_0)

		arg_17_0.pagefooterTrs[iter_17_0] = var_1_10007
	end

	for iter_17_1 = #var_17_1 + 1, #arg_17_0.pagefooters do
		setActive = var_1_10007

		var_1_10007(arg_17_0.pagefooters[iter_17_1], false)
	end

	local var_17_2

	if not arg_17_0.contextData.index then
		var_17_2 = 1
	end

	triggerButton = var_4

	var_4(arg_17_0.pagefooterTrs[var_17_2])

	return
end

local var_0_3 = 0

function var_0_1.UpdatePageFooter(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.pagefooterStartPosX + (var_0_3 + arg_18_0.pagefooterWid) * (arg_18_2 - 1)

	setAnchoredPosition = var_4

	var_4(arg_18_1, {
		x = var_18_0
	})

	GetSpriteFromAtlas = var_4

	local var_18_1 = var_4("ui/newservershopui_atlas", "p" .. arg_18_2)
	local var_18_2 = arg_18_1:Find("Text")
	local var_18_3 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	local var_18_4 = var_18_3(var_18_2, var_8(var_1_10010))

	var_18_4.sprite = var_18_1
	GetSpriteFromAtlas = var_18_4

	local var_18_5 = var_18_4("ui/newservershopui_atlas", "p" .. arg_18_2 .. "_s")
	local var_18_6 = arg_18_1:Find("mark")
	local var_18_7 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011
	var_18_7(var_18_6, var_9(var_1_10011)).sprite = var_18_5

	local var_18_8 = arg_18_1:Find("lock")
	local var_18_9

	if arg_18_2 ~= 1 then
		GetSpriteFromAtlas = var_18_9
		var_18_9 = var_18_9("ui/newservershopui_atlas", "p" .. arg_18_2 .. "_l")

		local var_18_10 = var_18_8
		local var_18_11 = var_18_8.GetComponent

		typeof = var_11
		Image = var_1_10013
		var_18_11(var_18_10, var_11(var_1_10013)).sprite = var_18_9
	end

	setActive = var_18_9

	local var_18_12 = var_18_8
	local var_18_13 = arg_18_0.shop

	var_18_9(var_18_12, not var_10.IsOpenPhase(var_18_13, arg_18_2))

	setActive = var_18_9

	var_18_9(arg_18_1:Find("tip"), arg_18_0:isPhaseTip(arg_18_2))
	arg_18_0:OnSwitch(arg_18_1, function()
		return arg_18_0.openIndex ~= arg_18_2
	end, function()
		local var_20_0 = arg_18_0

		var_0.SwitchPhase(var_20_0, arg_18_2)

		setActive = var_0

		local var_20_1 = arg_18_1
		local var_20_2 = var_2.Find(var_20_1, "tip")
		local var_20_3 = arg_18_0

		var_0(var_20_2, var_3.isPhaseTip(var_20_3, arg_18_2))

		return
	end)

	return
end

function var_0_1.OnSwitch(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.Find(var_21_0, "mark")

	local function var_21_2()
		if arg_21_0.markTr then
			setActive = var_0

			var_0(arg_21_0.markTr, false)
		end

		local var_22_0 = arg_21_0

		var_22_0.markTr = var_21_1
		setActive = var_22_0

		var_22_0(var_21_1, true)

		return
	end

	onButton = var_21_0

	local var_21_3 = arg_21_0
	local var_21_4 = arg_21_1

	local function var_21_5()
		if not arg_21_2() then
			return
		end

		var_21_2()
		arg_21_3()

		return
	end

	SFX_PANEL = var_1_10011

	var_21_0(var_21_3, var_21_4, var_21_5, var_1_10011)

	return
end

function var_0_1.SwitchPhase(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.shop
	local var_24_1 = var_2.GetPhases(var_24_0)[arg_24_1]

	arg_24_0.displays = var_2:GetOpeningGoodsList(var_24_1)
	table = var_1_10006

	var_1_10006.sort(arg_24_0.displays, function(arg_25_0, arg_25_1)
		if (arg_25_0:CanPurchase() and 1 or 0) == (arg_25_1:CanPurchase() and 1 or 0) then
			return arg_25_0.id < arg_25_1.id
		else
			return var_3 < var_2
		end

		return
	end)

	local var_24_2 = arg_24_0.scrollrect

	var_6.SetTotalCount(var_24_2, #arg_24_0.displays)

	arg_24_0.openIndex = arg_24_1

	arg_24_0:updateLocalRedDotData(arg_24_1)

	return
end

function var_0_1.Refresh(arg_26_0)
	arg_26_0:SwitchPhase(arg_26_0.openIndex)
	arg_26_0:UpdateRes()

	return
end

function var_0_1.isPhaseTip(arg_27_0, arg_27_1)
	if not arg_27_0.playerId then
		getProxy = var_27_2
		PlayerProxy = var_1_10004

		local var_27_0 = var_27_2(var_1_10004)

		arg_27_0.playerId = var_27_2.getData(var_27_0).id
	end

	if arg_27_1 ~= 1 then
		local var_27_1 = arg_27_0.shop
		local var_27_2

		if var_27_2.IsOpenPhase(var_27_1, arg_27_1) then
			PlayerPrefs = var_27_2

			if var_27_2.GetInt("newserver_shop_phase_" .. arg_27_1 .. "_" .. arg_27_0.playerId) ~= 0 then
				var_27_2 = false
			else
				var_27_2 = true
			end
		end

		return var_27_2
	end
end

function var_0_1.updateLocalRedDotData(arg_28_0, arg_28_1)
	if arg_28_0:isPhaseTip(arg_28_1) then
		PlayerPrefs = var_2

		var_2.SetInt("newserver_shop_phase_" .. arg_28_1 .. "_" .. arg_28_0.playerId, 1)

		local var_28_0 = arg_28_0
		local var_28_1 = arg_28_0.emit

		NewServerCarnivalMediator = var_5

		var_28_1(var_28_0, var_5.UPDATE_SHOP_RED_DOT)
	end

	return
end

function var_0_1.isTip(arg_29_0)
	if not arg_29_0.playerId then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_29_0 = var_1(var_1_10003)

		arg_29_0.playerId = var_1.getData(var_29_0).id
	end

	PlayerPrefs = var_1

	if var_1.GetInt("newserver_shop_first_" .. arg_29_0.playerId) == 0 then
		return true
	end

	pairs = var_1

	local var_29_1 = arg_29_0.shop

	for iter_29_0, iter_29_1 in var_1(var_3.GetPhases(var_29_1)) do
		if arg_29_0:isPhaseTip(iter_29_0) then
			return true
		end
	end

	return false
end

function var_0_1.OnDestroy(arg_30_0)
	arg_30_0.scrollrect.onInitItem = nil

	local var_30_0 = arg_30_0.scrollrect

	var_30_0.onUpdateItem = nil
	pairs = var_30_0

	for iter_30_0, iter_30_1 in var_30_0(arg_30_0.cards) do
		iter_30_1:Dispose()
	end

	arg_30_0.cards = nil

	local var_30_1 = arg_30_0.purchasePage

	var_1.Destroy(var_30_1)

	arg_30_0.purchasePage = nil

	local var_30_2 = arg_30_0.multiWindow

	var_1.Destroy(var_30_2)

	arg_30_0.multiWindow = nil

	local var_30_3 = arg_30_0.singleWindow

	var_1.Destroy(var_30_3)

	arg_30_0.singleWindow = nil

	var_0_1.super.OnDestroy(arg_30_0)

	return
end

return var_0_1
