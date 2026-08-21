local var_0_0 = class("AuctionGameMainEventLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AuctionGameMainEventUI"
end

function var_0_0.init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiBgBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiOkBtn, function()
		local var_4_0 = getProxy(AuctionGameProxy)

		if var_4_0:GetPersonalEventSelectedID() ~= 0 then
			return
		end

		if arg_2_0.selectedID == 0 then
			return
		end

		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionChooseEvent(var_4_0:GetAuctionID(), var_4_0:GetRound(), pg.gameset.auction_event_choose_time.key_value - (var_4_0:GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime()), arg_2_0.selectedID))
		arg_2_0:emit(AuctionGameMainEventMediator.EVENT_SELECTED_ID, arg_2_0.selectedID)

		return
	end, SFX_CONFIRM)

	arg_2_0.eventItemList = {}

	return
end

function var_0_0.didEnter(arg_5_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.EXPAND_POPUP)
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		pbList = {
			arg_5_0.uiBg
		}
	})

	local var_5_0 = getProxy(AuctionGameProxy)

	for iter_5_0, iter_5_1 in ipairs((var_5_0:GetPersonalEventList())) do
		arg_5_0.eventItemList[iter_5_0] = AuctionGameMainEventItem.New(arg_5_0[string.format("uiEventItemTf%s", iter_5_0)], arg_5_0)

		arg_5_0.eventItemList[iter_5_0]:didEnter(iter_5_1)
	end

	arg_5_0:OnSelectedID(_, var_5_0:GetPersonalEventSelectedID())

	arg_5_0.eventList = {
		arg_5_0:bind(AuctionGameMainEventItem.AUCTION_GAME_SELECTED_EVENT, handler(arg_5_0, arg_5_0.OnSelectedID))
	}

	return
end

function var_0_0.OnSelectedID(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.selectedID = arg_6_2

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.eventItemList) do
		iter_6_1:SetSelected(arg_6_2)
	end

	arg_6_0:RefreshOkBtn()

	return
end

function var_0_0.RefreshOkBtn(arg_7_0)
	if getProxy(AuctionGameProxy):GetPersonalEventSelectedID() ~= 0 then
		return
	end

	return
end

function var_0_0.willExit(arg_8_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.COLLAPSE_POPUP)
	arg_8_0:UnOverlayPanel(arg_8_0._tf)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.eventList) do
		arg_8_0:disconnect(iter_8_1)
	end

	arg_8_0.eventList = nil

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.eventItemList) do
		iter_8_3:willExit()
	end

	arg_8_0.eventItemList = nil

	return
end

return var_0_0
