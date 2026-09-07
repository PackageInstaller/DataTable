local AuctionGameMainBidLayer = class("AuctionGameMainBidLayer", import("view.base.BaseUI"))

function AuctionGameMainBidLayer:getUIName()
	return "AuctionGameMainBidUI"
end

function AuctionGameMainBidLayer:init()
	self.bidEventCom = GetComponent(self.uiBidAnimationTf, typeof(DftAniEvent))

	self.bidEventCom:SetEndEvent(function()
		self:OnClickBidBtn()

		return
	end)
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)

	for iter_2_0 = 0, 9 do
		onButton(self, self[string.format("uiNumBtn%s", iter_2_0)], function()
			self:AddNum(iter_2_0)
			self:RefreshNumText()

			return
		end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	end

	onButton(self, self.uiBtn00, function()
		self:MultiplierNum(100)
		self:RefreshNumText()

		return
	end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	onButton(self, self.uiBtn000, function()
		self:MultiplierNum(1000)
		self:RefreshNumText()

		return
	end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	onButton(self, self.uiMultiplierBtn, function()
		self:MultiplierNum(self.multiplierNum)
		self:RefreshNumText()

		return
	end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	onButton(self, self.uiDeleteBtn, function()
		self:DeleteNum()
		self:RefreshNumText()

		return
	end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	onButton(self, self.uiClearBtn, function()
		self.inputNum = 0

		self:RefreshNumText()

		return
	end, AuctionGameConst.SOUND_EFFECT.BID_KEYPAD)
	onButton(self, self.uiBidBtn, function()
		if self.startBid == true then
			return
		end

		local var_11_0 = self.inputNum

		if self.bided then
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

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainMsgLayer,
			mediator = AuctionGameMainMsgMediator,
			data = {
				content = i18n("auction_game_bid_confirm", StringHelper.ForamtNumber(var_11_0)),
				comformCallback = function()
					self.startBid = true

					quickPlayAnimation(self.uiBidAnimationTf, "Anim_AuctionGameEntranceUI_matchBtn_click")

					return
				end
			}
		}))

		return
	end, AuctionGameConst.SOUND_EFFECT.BID)
	setText(self.uiCurrencyTitleText, i18n("auction_main_pt"))
	LoadSpriteAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):getConfig("config_client").itemID
	}):getIcon(), function(arg_13_0)
		if not IsNil(self.uiCurrencyIcon) then
			self.uiCurrencyIcon.sprite = arg_13_0
		end

		return
	end)
	setText(self.uiCurrencyText, StringHelper.ForamtNumber(AuctionGameTools.GetCurrencyCnt()))
	setText(self.uiClearText, i18n("auction_bid_keyboard_clear"))

	return
end

function AuctionGameMainBidLayer:didEnter()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.uiBg
		}
	})
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.EXPAND_POPUP)

	local var_14_0 = getProxy(AuctionGameProxy)
	local var_14_1 = var_14_0:GetRound()

	self.inputNum = var_14_1 <= 1 and 0 or var_14_0:GetRoundEventAndBidInfoList()[var_14_1 - 1][getProxy(PlayerProxy):getPlayerId()].bidValue or 0
	self.maxValue = AuctionGameTools.GetCurrencyCnt()

	self:RefreshUI()

	if var_14_1 >= 5 then
		setText(self.uiMultiplierDescText, i18n("auction_round_instant_buy", "--"))
	else
		setText(self.uiMultiplierDescText, i18n("auction_round_instant_buy", self.multiplierNum))
	end

	return
end

function AuctionGameMainBidLayer:RefreshUI()
	local var_15_0 = getProxy(AuctionGameProxy):GetRound()

	var_15_0 = var_15_0 == 0 and 1 or var_15_0
	self.multiplierNum = tonumber(pg.auction_round[var_15_0].one_hit)

	setText(self.uiMultiplierText, string.format("%s", self.multiplierNum))
	self:RefreshNumText()

	return
end

function AuctionGameMainBidLayer:AddNum(arg_16_1)
	if arg_16_1 == 0 and self.inputNum == 0 then
		return
	end

	self.inputNum = self.inputNum * 10 + arg_16_1

	if self.inputNum > self.maxValue then
		self.inputNum = self.maxValue
	end

	return
end

function AuctionGameMainBidLayer:DeleteNum()
	if self.inputNum == 0 then
		return
	end

	self.inputNum = math.floor(self.inputNum / 10)

	return
end

function AuctionGameMainBidLayer:MultiplierNum(arg_18_1)
	if self.inputNum == 0 then
		return
	end

	self.inputNum = math.ceil(self.inputNum * arg_18_1)

	if self.inputNum > self.maxValue then
		self.inputNum = self.maxValue
	end

	return
end

function AuctionGameMainBidLayer:RefreshNumText()
	setText(self.uiInputText, StringHelper.ForamtNumber(self.inputNum))

	return
end

function AuctionGameMainBidLayer:OnClickBidBtn()
	self.startBid = false

	local var_20_0 = getProxy(AuctionGameProxy)

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionBid(var_20_0:GetAuctionID(), var_20_0:GetRound(), pg.gameset.auction_bid_time.key_value - (var_20_0:GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime()), self.inputNum, 0))
	self:emit(AuctionGameMainBidMediator.BID, self.inputNum)

	return
end

function AuctionGameMainBidLayer:willExit()
	self:UnOverlayPanel(self._tf)
	self.bidEventCom:SetEndEvent(nil)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.COLLAPSE_POPUP)

	return
end

return AuctionGameMainBidLayer
