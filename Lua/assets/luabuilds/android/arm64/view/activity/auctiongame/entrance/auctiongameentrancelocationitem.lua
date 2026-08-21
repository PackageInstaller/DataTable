local var_0_0 = class("AuctionGameEntranceLocationItem", import("view.base.BasePanel"))

var_0_0.SELECTED_LOCATION = "AuctionGameEntranceLocationItem::SELECTED_LOCAITON"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2
	arg_1_0.id = arg_1_3

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	setText(arg_2_0.uiUnselectedLockText, i18n("auction_not_enough_assets", StringHelper.ForamtNumberK(pg.auction_session[arg_2_0.id].threshold)))
	onButton(arg_2_0, arg_2_0.uiButton, function()
		if AuctionGameTools.GetCurrencyCnt() >= pg.auction_session[arg_2_0.id].threshold == false then
			return
		end

		getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):SetLocationTip(arg_2_0.id)
		arg_2_0:emit(AuctionGameEntranceLocationItem.SELECTED_LOCATION, arg_2_0.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_4_0, arg_4_1)
	getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):SetLocationTip(arg_4_1)
	arg_4_0:RefreshState()
	arg_4_0:SetSelected(arg_4_1 == arg_4_0.id)

	return
end

function var_0_0.SetSelected(arg_5_0, arg_5_1)
	setActive(arg_5_0.uiSelectedGo, arg_5_1)
	setActive(arg_5_0.uiUnselectedGo, not arg_5_1)

	if AuctionGameTools.GetCurrencyCnt() >= pg.auction_session[arg_5_0.id].threshold then
		setActive(arg_5_0.uiUnlockImage, arg_5_1)
		setActive(arg_5_0.uiLockImage, not arg_5_1)
	else
		setActive(arg_5_0.uiUnlockImage, false)
		setActive(arg_5_0.uiLockImage, false)
	end

	return
end

function var_0_0.RefreshState(arg_6_0)
	local var_6_0 = AuctionGameTools.GetCurrencyCnt() >= pg.auction_session[arg_6_0.id].threshold

	setActive(arg_6_0.uiUnselectedLockGo, not var_6_0)
	setActive(arg_6_0.uiSelectedLockGo, not var_6_0)
	setActive(arg_6_0.uiSelectedUnLockGo, var_6_0)
	arg_6_0:RefreshTip()

	return
end

function var_0_0.RefreshTip(arg_7_0)
	setActive(arg_7_0.uiTipGo, getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):GetLocationTip(arg_7_0.id))

	return
end

function var_0_0.willExit(arg_8_0)
	arg_8_0:detach()

	return
end

return var_0_0
