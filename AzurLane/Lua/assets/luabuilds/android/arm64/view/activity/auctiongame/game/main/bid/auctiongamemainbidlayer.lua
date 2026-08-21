local var_0_0 = class("AuctionGameMainBidLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AuctionGameMainBidUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bidEventCom = GetComponent(arg_2_0.uiBidAnimationTf, typeof(DftAniEvent))

	arg_2_0.bidEventCom:SetEndEvent(function()
		arg_2_0:OnClickBidBtn()

		return
	end)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)

	for iter_2_0 = 0, 9 do
		onButton(arg_2_0, arg_2_0[string.format("uiNumBtn%s", iter_2_0)], function()
			arg_2_0:AddNum(iter_2_0)
			arg_2_0:RefreshNumText()

			return
		end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	end

	onButton(arg_2_0, arg_2_0.uiBtn00, function()
		arg_2_0:MultiplierNum(100)
		arg_2_0:RefreshNumText()

		return
	end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	onButton(arg_2_0, arg_2_0.uiBtn000, function()
		arg_2_0:MultiplierNum(1000)
		arg_2_0:RefreshNumText()

		return
	end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	onButton(arg_2_0, arg_2_0.uiMultiplierBtn, function()
		arg_2_0:MultiplierNum(arg_2_0.multiplierNum)
		arg_2_0:RefreshNumText()

		return
	end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	onButton(arg_2_0, arg_2_0.uiDeleteBtn, function()
		arg_2_0:DeleteNum()
		arg_2_0:RefreshNumText()

		return
	end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	onButton(arg_2_0, arg_2_0.uiClearBtn, function()
		arg_2_0.inputNum = 0

		arg_2_0:RefreshNumText()

		return
	end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	onButton(arg_2_0, arg_2_0.uiBidBtn, function()
		if arg_2_0.startBid == true then
			return
		end

		local var_11_0 = arg_2_0.inputNum

		if arg_2_0.bided then
			return
		end

		local var_11_1 = getProxy(AuctionGameProxy)

		if pg.TimeMgr.GetInstance():GetServerTime() < var_11_1:GetTimestamp() and var_11_1:GetAuctionState() ~= AuctionGameConst.AUCTION_PHASE.BID then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_wait_bid_phase"))

			return
		end

		local var_11_2 = pg.auction_session[var_11_1:GetAuctionID()].bottom_price

		if var_11_0 < var_11_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_min_bid", var_11_2))

			return
		end

		if var_11_0 > getProxy(AuctionGameBaseProxy).gold then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_exceeds_max_value"))

			return
		end

		arg_2_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainMsgLayer,
			mediator = AuctionGameMainMsgMediator,
			data = {
				content = i18n("auction_game_bid_confirm", StringHelper.ForamtNumber(var_11_0)),
				comformCallback = function()
					arg_2_0.startBid = true

					quickPlayAnimation(arg_2_0.uiBidAnimationTf, "Anim_AuctionGameEntranceUI_matchBtn_click")

					return
				end
			}
		}))

		return
	end, AuctionGameConst.SOUND_EFFECT.BID)
	setText(arg_2_0.uiCurrencyTitleText, i18n("auction_main_pt"))
	LoadSpriteAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):getConfig("config_client").itemID
	}):getIcon(), function(arg_13_0)
		if not IsNil(arg_2_0.uiCurrencyIcon) then
			arg_2_0.uiCurrencyIcon.sprite = arg_13_0
		end

		return
	end)
	setText(arg_2_0.uiCurrencyText, StringHelper.ForamtNumber(AuctionGameTools.GetCurrencyCnt()))
	setText(arg_2_0.uiClearText, i18n("auction_bid_keyboard_clear"))

	return
end

function var_0_0.didEnter(arg_14_0)
	arg_14_0:OverlayPanel(arg_14_0._tf, {
		pbList = {
			arg_14_0.uiBg
		}
	})
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.EXPAND_POPUP)

	local var_14_0 = getProxy(AuctionGameProxy)
	local var_14_1 = var_14_0:GetRound()

	if var_14_1 <= 1 then
		arg_14_0.inputNum = 0
	else
		local var_14_2 = getProxy(PlayerProxy)

		arg_14_0.inputNum = var_14_0:GetRoundEventAndBidInfoList()[var_14_1 - 1][var_14_2:getPlayerId()].bidValue or 0
	end

	arg_14_0.maxValue = AuctionGameTools.GetCurrencyCnt()

	arg_14_0:RefreshUI()

	if var_14_1 >= 5 then
		setText(arg_14_0.uiMultiplierDescText, i18n("auction_round_instant_buy", "--"))
	else
		setText(arg_14_0.uiMultiplierDescText, i18n("auction_round_instant_buy", arg_14_0.multiplierNum))
	end

	return
end

function var_0_0.RefreshUI(arg_15_0)
	local var_15_0 = getProxy(AuctionGameProxy):GetRound()

	var_15_0 = var_15_0 == 0 and 1 or var_15_0
	arg_15_0.multiplierNum = tonumber(pg.auction_round[var_15_0].one_hit)

	setText(arg_15_0.uiMultiplierText, string.format("%s", arg_15_0.multiplierNum))
	arg_15_0:RefreshNumText()

	return
end

function var_0_0.AddNum(arg_16_0, arg_16_1)
	if arg_16_1 == 0 and arg_16_0.inputNum == 0 then
		return
	end

	arg_16_0.inputNum = arg_16_0.inputNum * 10 + arg_16_1

	if arg_16_0.inputNum > arg_16_0.maxValue then
		arg_16_0.inputNum = arg_16_0.maxValue
	end

	return
end

function var_0_0.DeleteNum(arg_17_0)
	if arg_17_0.inputNum == 0 then
		return
	end

	arg_17_0.inputNum = math.floor(arg_17_0.inputNum / 10)

	return
end

function var_0_0.MultiplierNum(arg_18_0, arg_18_1)
	if arg_18_0.inputNum == 0 then
		return
	end

	arg_18_0.inputNum = math.ceil(arg_18_0.inputNum * arg_18_1)

	if arg_18_0.inputNum > arg_18_0.maxValue then
		arg_18_0.inputNum = arg_18_0.maxValue
	end

	return
end

function var_0_0.RefreshNumText(arg_19_0)
	setText(arg_19_0.uiInputText, StringHelper.ForamtNumber(arg_19_0.inputNum))

	return
end

function var_0_0.OnClickBidBtn(arg_20_0)
	arg_20_0.startBid = false

	local var_20_0 = getProxy(AuctionGameProxy)

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionBid(var_20_0:GetAuctionID(), var_20_0:GetRound(), pg.gameset.auction_bid_time.key_value - (var_20_0:GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime()), arg_20_0.inputNum, 0))
	arg_20_0:emit(AuctionGameMainBidMediator.BID, arg_20_0.inputNum)

	return
end

function var_0_0.willExit(arg_21_0)
	arg_21_0:UnOverlayPanel(arg_21_0._tf)
	arg_21_0.bidEventCom:SetEndEvent(nil)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.COLLAPSE_POPUP)

	return
end

return var_0_0
