class = var_0_10000

local var_0_0 = "AuctionGameEntranceLocationItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

var_0_1.SELECTED_LOCATION = "AuctionGameEntranceLocationItem::SELECTED_LOCAITON"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2
	arg_1_0.id = arg_1_3

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.auction_session[arg_2_0.id]

	setText = var_2

	local var_2_1 = arg_2_0.uiUnselectedLockText

	i18n = var_1_10005

	local var_2_2 = "auction_not_enough_assets"

	StringHelper = var_1_10008

	var_2(var_2_1, var_1_10005(var_2_2, var_1_10008.ForamtNumberK(var_2_0.threshold)))

	onButton = var_2

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiButton

	local function var_2_5()
		pg = var_2_10000

		local var_3_0 = var_2_10000.auction_session[arg_2_0.id]

		AuctionGameTools = var_1

		local var_3_1 = var_1.GetCurrencyCnt()

		if var_3_0.threshold <= var_3_1 == false then
			return
		end

		getProxy = var_2
		ActivityProxy = var_2_10004

		local var_3_2 = var_2(var_2_10004)
		local var_3_3 = var_2.getActivityByType

		ActivityConst = var_2_10006

		local var_3_4 = var_3_3(var_3_2, var_2_10006.ACTIVITY_TYPE_AUCTION_GAME)

		var_3.SetLocationTip(var_3_4, arg_2_0.id)

		local var_3_5 = arg_2_0
		local var_3_6 = var_4.emit

		AuctionGameEntranceLocationItem = var_7

		var_3_6(var_3_5, var_7.SELECTED_LOCATION, arg_2_0.id)

		return
	end

	SFX_PANEL = var_2_2

	var_2(var_2_3, var_2_4, var_2_5, var_2_2)

	return
end

function var_0_1.didEnter(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_4_0 = var_1_10002(var_1_10004)
	local var_4_1 = var_2.getActivityByType

	ActivityConst = var_1_10006

	local var_4_2 = var_4_1(var_4_0, var_1_10006.ACTIVITY_TYPE_AUCTION_GAME)

	var_3.SetLocationTip(var_4_2, arg_4_1)
	arg_4_0:RefreshState()
	arg_4_0:SetSelected(arg_4_1 == arg_4_0.id)

	return
end

function var_0_1.SetSelected(arg_5_0, arg_5_1)
	setActive = var_1_10002

	var_1_10002(arg_5_0.uiSelectedGo, arg_5_1)

	setActive = var_1_10002

	var_1_10002(arg_5_0.uiUnselectedGo, not arg_5_1)

	pg = var_1_10002

	local var_5_0 = var_1_10002.auction_session[arg_5_0.id]

	AuctionGameTools = var_3

	local var_5_1 = var_3.GetCurrencyCnt()

	if var_5_0.threshold <= var_5_1 then
		setActive = var_4

		var_4(arg_5_0.uiUnlockImage, arg_5_1)

		setActive = var_4

		var_4(arg_5_0.uiLockImage, not arg_5_1)
	else
		setActive = var_4

		var_4(arg_5_0.uiUnlockImage, false)

		setActive = var_4

		var_4(arg_5_0.uiLockImage, false)
	end

	return
end

function var_0_1.RefreshState(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.auction_session[arg_6_0.id]

	AuctionGameTools = var_2

	local var_6_1 = var_2.GetCurrencyCnt()
	local var_6_2 = var_6_0.threshold <= var_6_1

	setActive = var_3

	var_3(arg_6_0.uiUnselectedLockGo, not var_6_2)

	setActive = var_3

	var_3(arg_6_0.uiSelectedLockGo, not var_6_2)

	setActive = var_3

	var_3(arg_6_0.uiSelectedUnLockGo, var_6_2)
	arg_6_0:RefreshTip()

	return
end

function var_0_1.RefreshTip(arg_7_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)
	local var_7_1 = var_1.getActivityByType

	ActivityConst = var_1_10005

	local var_7_2 = var_7_1(var_7_0, var_1_10005.ACTIVITY_TYPE_AUCTION_GAME)

	setActive = var_1_10003

	var_1_10003(arg_7_0.uiTipGo, var_7_2:GetLocationTip(arg_7_0.id))

	return
end

function var_0_1.willExit(arg_8_0)
	arg_8_0:detach()

	return
end

return var_0_1
