local ProtoHandler = import(".ProtoHandler")
local var_0_1 = {}
local var_0_2 = g.core.model.User.firstRechargeData
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.event.EventManager
local var_0_5 = g.core.model.User.activityPermanentRechargeData

function var_0_1.on_S2C_Recharge_GetRecharge(arg_1_0, arg_1_1, arg_1_2)
	if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
		g.core.model.User.rechargeGuideData:updateDirtyFlag()

		if arg_1_2.mc then
			g.core.model.User.activityMonthCardData:initCardData(arg_1_2.mc)
		end

		if arg_1_2.subs then
			g.core.model.User.activityLifeTimeCardData:updateSubscriptionStatus(arg_1_2.subs)
		end

		if arg_1_2.month_card_turn then
			g.core.model.User.activityMonthCardData:updateMonthCardTurn(arg_1_2.month_card_turn)
		end

		if arg_1_2.first_recharge then
			local var_1_0 = 0

			for iter_1_0, iter_1_1 in ipairs(arg_1_2.recharges or {}) do
				if iter_1_1.type == g.core.network.proto.RIT_RECHARGE_TOTAL then
					var_1_0 = iter_1_1.value
				end
			end

			var_0_2:updateRechargeData(arg_1_2.first_recharge)
			var_0_2:setTotalRechargeNum(var_1_0)
		end

		if arg_1_2.fund_recharge then
			g.core.model.User.activityFundData:updateFundData(arg_1_2.fund_recharge)
		end

		if arg_1_2.day_recharge then
			-- block empty
		end

		if arg_1_2.open_purchase then
			-- block empty
		end

		if arg_1_2.month_fund then
			-- block empty
		end

		if arg_1_2.new_total_recharge then
			-- block empty
		end

		if arg_1_2.week_gift_history then
			-- block empty
		end

		if arg_1_2.gift_recharges then
			g.core.model.User.giftData:updateServerInfo(arg_1_2.gift_recharges)
		end

		if arg_1_2.daily_sale then
			g.core.model.User.activityDailyBoxData:updateInfo(arg_1_2.daily_sale)
		end

		g.core.model.User.rechargeData:initRechargeData(arg_1_2)

		if arg_1_2.total_recharge then
			g.core.model.User.totalRechargeData:updateInfo(arg_1_2.total_recharge)
		end

		if arg_1_2.gm_total_recharge then
			g.core.model.User.gmTotalRechargeData:onS2CGetRecharge(arg_1_2.gm_total_recharge)
		end

		if arg_1_2.gm_first_recharge then
			g.core.model.User.rechargeData:onS2CGMDoubleRechargeIds(arg_1_2.gm_first_recharge)
		end

		if arg_1_2.daily_box_turn then
			g.core.model.User.activityDailyBoxData:updateAwardCfg(arg_1_2.daily_box_turn)
		end

		if arg_1_2.recharge_rebates then
			var_0_5:onUpdateRechargeProcess(arg_1_2.recharge_rebates)
		end

		if arg_1_2.limit_sale_recharges then
			g.core.model.User.doubleElevenData:updateBuyTimes(arg_1_2.limit_sale_recharges)
		end

		g.core.model.User.activityLifeTimeCardData:setReceived(true)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, false, arg_1_1, arg_1_2)
	end
end

function var_0_1.on_S2C_Recharge_UseMonthCard(arg_2_0, arg_2_1, arg_2_2)
	if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_USEMONTHCARD, false, arg_2_1, arg_2_2)
	end
end

function var_0_1.on_S2C_Recharge_UseSubRecharge(arg_3_0, arg_3_1, arg_3_2)
	if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
		g.core.model.User.activityLifeTimeCardData:updateReceiveStatus()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_USESUBRECHARGE, false, arg_3_1, arg_3_2)
	end
end

function var_0_1.on_S2C_Recharge_NotifySuccess(arg_4_0, arg_4_1, arg_4_2)
	if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(1173))
		g.core.model.User.rechargeGuideData:updateDirtyFlag()
		g.core.model.User.rechargeData:addTotalRecharge(arg_4_2)
		g.core.platform.PlatformProxy:checkAndSendPayAdEvent(arg_4_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS, false, arg_4_1, arg_4_2)
	end
end

function var_0_1.on_S2C_Recharge_GetFirstRechargeAward(arg_5_0, arg_5_1, arg_5_2)
	if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
		var_0_2:onGetFirstRechargeAward(arg_5_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFIRSTRECHARGEAWARD, false, arg_5_1, arg_5_2)
	end
end

function var_0_1.on_S2C_Recharge_First_Recharge_GetRechargeAward(arg_6_0, arg_6_1, arg_6_2)
	if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
		var_0_2:onGetFirstRechargeTimesAward(arg_6_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD, false, arg_6_1, arg_6_2)
	end
end

function var_0_1.on_S2C_Recharge_OpRecharge(arg_7_0, arg_7_1, arg_7_2)
	if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
		if g.core.common.ServerTime:getOpenTime() == 0 then
			return
		end

		local var_7_0 = g.core.model.User.rechargeData

		g.core.model.User.rechargeData:resetHasNewOrderId()

		if arg_7_2.first_recharge then
			var_0_2:updateRechargeData(arg_7_2.first_recharge)
		end

		if arg_7_2.fund_recharge then
			g.core.model.User.activityFundData:updateFundByOpRecharge(arg_7_2.fund_recharge)
		end

		if arg_7_2.day_recharge then
			g.core.model.User.dailyRechargeData:updateDailyByOpRecharge(arg_7_2.day_recharge)
		end

		if arg_7_2.month_card then
			g.core.model.User.activityMonthCardData:updateMonthData(arg_7_2.month_card)
		end

		if arg_7_2.sub_recharge then
			g.core.model.User.activityLifeTimeCardData:updateAfterOpRecharge(arg_7_2.sub_recharge)
		end

		if arg_7_2.open_purchase then
			g.core.model.User.openPurchaseData:updatePurchaseByOp(arg_7_2.open_purchase)
		end

		if arg_7_2.week_gift then
			g.core.model.User.weekGiftData:updatePurchaseByOp(arg_7_2.week_gift)
		end

		if arg_7_2.month_fund then
			g.core.model.User.monthlyFundData:updateMonthlyFundByOp(arg_7_2.month_fund)
		end

		if arg_7_2.new_total_recharge then
			-- block empty
		end

		if arg_7_2.gift then
			g.core.model.User.giftData:receiveGift(arg_7_2.gift)
		end

		if arg_7_2.daily_sale then
			g.core.model.User.activityDailyBoxData:updateInfoByOp(arg_7_2.daily_sale)
		end

		if arg_7_2.total_recharge then
			g.core.model.User.totalRechargeData:updateOpInfo(arg_7_2.total_recharge)
		end

		if arg_7_2.passcard then
			g.core.model.User.passCardData:updateRechargeState(arg_7_2.passcard)
		end

		if arg_7_2.push_gift then
			g.core.model.User.pushGiftData:updateGiftInfoByOp(arg_7_2.push_gift)
			g.core.model.User.hotSaleGMGiftData:updateGMGiftInfoByOp(arg_7_2.push_gift)
		end

		if arg_7_2.gm_total_recharge and arg_7_2.gm_total_recharge.insert then
			g.core.model.User.gmTotalRechargeData:onS2CGetRecharge(arg_7_2.gm_total_recharge.insert)
		end

		if arg_7_2.gm_first_recharge then
			var_7_0:onS2CGMDoubleRechargeIdsOP(arg_7_2.gm_first_recharge)
		end

		if arg_7_2.recharge_rebate then
			var_0_5:onUpdateRechargeProcess(arg_7_2.recharge_rebate)
		end

		if arg_7_2.limit_sale then
			g.core.model.User.doubleElevenData:updateBuyTimes({
				arg_7_2.limit_sale.update
			})
		end

		if arg_7_2.passcard_activity then
			g.core.model.User.gmPassCardData:updatePassCardRecharge(arg_7_2.passcard_activity)
		end

		if arg_7_2.fund_activity then
			g.core.model.User.gmFundData:updateFundRecharge(arg_7_2.fund_activity)
		end

		if arg_7_2.cultivate_activity_passcard then
			g.core.model.User.cultivateDataMgr:getCultivateData(arg_7_2.cultivate_activity_passcard.activity_id):getPassCardData():updatePassCardData({
				arg_7_2.cultivate_activity_passcard.passcard
			})
		end

		if arg_7_2.theme_passcard then
			g.core.model.User.themeData:getThemeData(arg_7_2.theme_passcard.activity_id):getPassCardData():updatePayNum(arg_7_2.theme_passcard.passcard_id, 1, true)
		end

		if arg_7_2.common_passcard then
			g.core.model.User.commonPassCardDataMgr:getPassCardData(arg_7_2.common_passcard.id):updatePassCardRecharge(arg_7_2.common_passcard)
			g.core.model.User.newSlgData:updatePassCardData(arg_7_2.common_passcard.id)
		end

		if arg_7_2.server_pass then
			g.core.model.User.serverPassActivityData:setPayStatue(arg_7_2.server_pass.tier)
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, false, arg_7_1, arg_7_2)
	end
end

function var_0_1.on_S2C_Recharge_GetFundRecharge(arg_8_0, arg_8_1, arg_8_2)
	if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
		g.core.model.User.activityFundData:updateFundData(arg_8_2.fund_recharge)
		g.core.model.User.activityFundData:updateWuShuangMaxLayer(arg_8_2.dead_battle)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGE, false, arg_8_1, arg_8_2)
	end
end

function var_0_1.on_S2C_Recharge_GetFundRechargeAward(arg_9_0, arg_9_1, arg_9_2)
	if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARD, false, arg_9_1, arg_9_2)
	end
end

function var_0_1.on_S2C_Recharge_GetFundRechargeAwardOneKey(arg_10_0, arg_10_1, arg_10_2)
	if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY, false, arg_10_1, arg_10_2)
	end
end

function var_0_1.on_S2C_Recharge_FundBuyNotify(arg_11_0, arg_11_1, arg_11_2)
	if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
		g.core.model.User.activityFundData:updateFundNumByNotify(arg_11_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_FUNDBUYNOTIFY, false, arg_11_1, arg_11_2)
	end
end

function var_0_1.on_S2C_Recharge_GetDayRechargeAward(arg_12_0, arg_12_1, arg_12_2)
	if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETDAYRECHARGEAWARD, false, arg_12_1, arg_12_2)
	end
end

function var_0_1.on_S2C_Recharge_GetTotalRechargeAward(arg_13_0, arg_13_1, arg_13_2)
	if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
		g.core.model.User.totalRechargeData:onS2CGetTotalRechargeAward(arg_13_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETTOTALRECHARGEAWARD, false, arg_13_1, arg_13_2)
	end
end

function var_0_1.on_S2C_Recharge_GetOpenPurchaseInfo(arg_14_0, arg_14_1, arg_14_2)
	if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
		g.core.model.User.openPurchaseData:updateServerInfo(arg_14_2.recharges)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETOPENPURCHASEINFO, false, arg_14_1, arg_14_2)
	end
end

function var_0_1.on_S2C_Recharge_GetWeekGiftInfo(arg_15_0, arg_15_1, arg_15_2)
	if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
		g.core.model.User.weekGiftData:updateServerInfo(arg_15_2.histories)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETWEEKGIFTINFO, false, arg_15_1, arg_15_2)
	end
end

function var_0_1.on_S2C_Recharge_GetOpenPurchaseAward(arg_16_0, arg_16_1, arg_16_2)
	if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETOPENPURCHASEAWARD, false, arg_16_1, arg_16_2)
	end
end

function var_0_1.on_S2C_Recharge_GetWeekGiftAward(arg_17_0, arg_17_1, arg_17_2)
	if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETWEEKGIFTAWARD, false, arg_17_1, arg_17_2)
	end
end

function var_0_1.on_S2C_ReturnPayOperator_GetInfo(arg_18_0, arg_18_1, arg_18_2)
	if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
		g.core.model.User.channelFeedbackData:updateServerInfo(arg_18_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RETURN_PAY_OPERATOR_GETINFO, false, arg_18_1, arg_18_2)
	end
end

function var_0_1.on_S2C_ReturnPayOperator_GetAward(arg_19_0, arg_19_1, arg_19_2)
	if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
		g.core.model.User.channelFeedbackData:getAward(arg_19_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RETURN_PAY_OPERATOR_GETAWARD, false, arg_19_1, arg_19_2)
	end
end

function var_0_1.on_S2C_Recharge_GetDayBoxAward(arg_20_0, arg_20_1, arg_20_2)
	if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETDAYBOXAWARD, false, arg_20_1, arg_20_2)
	end
end

function var_0_1.on_S2C_Recharge_GetMonthFundInfo(arg_21_0, arg_21_1, arg_21_2)
	if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
		g.core.model.User.monthlyFundData:updateMonthlyFunds(arg_21_2.recharges)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETMONTHFUNDINFO, false, arg_21_1, arg_21_2)
	end
end

function var_0_1.on_S2C_Recharge_GetMonthFundAward(arg_22_0, arg_22_1, arg_22_2)
	if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETMONTHFUNDAWARD, false, arg_22_1, arg_22_2)
	end
end

function var_0_1.on_S2C_Recharge_GetNewTotalRechargeInfo(arg_23_0, arg_23_1, arg_23_2)
	if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETNEWTOTALRECHARGEINFO, false, arg_23_1, arg_23_2)
	end
end

function var_0_1.on_S2C_Recharge_GetNewTotalRechargeAward(arg_24_0, arg_24_1, arg_24_2)
	if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETNEWTOTALRECHARGEAWARD, false, arg_24_1, arg_24_2)
	end
end

function var_0_1.on_S2C_Recharge_GetFreeGiftAward(arg_25_0, arg_25_1, arg_25_2)
	if ProtoHandler:onMsgProcess(arg_25_1, arg_25_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD, false, arg_25_1, arg_25_2)
	end
end

function var_0_1.on_S2C_Recharge_GetFreeDailySaleAward(arg_26_0, arg_26_1, arg_26_2)
	if ProtoHandler:onMsgProcess(arg_26_1, arg_26_2) then
		g.core.model.User.activityDailyBoxData:updateInfoByOp(arg_26_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEDAILYSALEAWARD, false, arg_26_1, arg_26_2)
	end
end

function var_0_1.on_S2C_Recharge_MonthCardTurnAward(arg_27_0, arg_27_1, arg_27_2)
	if ProtoHandler:onMsgProcess(arg_27_1, arg_27_2) then
		g.core.model.User.activityMonthCardData:updateMonthCardTurn(arg_27_2.month_card_turn)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_MONTHCARDTURNAWARD, false, arg_27_1, arg_27_2)
	end
end

function var_0_1.on_S2C_Recharge_GetGMTotalRechargeInfo(arg_28_0, arg_28_1, arg_28_2)
	if ProtoHandler:onMsgProcess(arg_28_1, arg_28_2) then
		g.core.model.User.gmTotalRechargeData:onS2CGetGMTotalRechargeInfo(arg_28_2)
	end
end

function var_0_1.on_S2C_Recharge_GetGMTotalRechargeAward(arg_29_0, arg_29_1, arg_29_2)
	if ProtoHandler:onMsgProcess(arg_29_1, arg_29_2) then
		g.core.model.User.gmTotalRechargeData:onS2CGetGMTotalRechargeAward(arg_29_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETGMTOTALRECHARGEAWARD, false, arg_29_1, arg_29_2)
	end
end

function var_0_1.on_S2C_Recharge_GetGMTotalRechargeTaskAward(arg_30_0, arg_30_1, arg_30_2)
	if ProtoHandler:onMsgProcess(arg_30_1, arg_30_2) then
		g.core.model.User.gmTotalRechargeData:onS2CGetGMTotalRechargeTaskAward(arg_30_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD, false, arg_30_1, arg_30_2)
	end
end

function var_0_1.on_S2C_Recharge_GetGMTotalRechargeTaskData(arg_31_0, arg_31_1, arg_31_2)
	if ProtoHandler:onMsgProcess(arg_31_1, arg_31_2) then
		g.core.model.User.gmTotalRechargeData:onS2CGetGMTotalRechargeTaskData(arg_31_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA, false, arg_31_1, arg_31_2)
	end
end

function var_0_1.on_S2C_Recharge_GetGMFirstRechargeInfo(arg_32_0, arg_32_1, arg_32_2)
	if ProtoHandler:onMsgProcess(arg_32_1, arg_32_2) then
		g.core.model.User.rechargeData:onS2CGMDoubleRechargeInfo(arg_32_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETGMFIRSTRECHARGEINFO, false, arg_32_1, arg_32_2)
	end
end

function var_0_1.on_S2C_Recharge_UpdateGMFirstRechargeInfo(arg_33_0, arg_33_1, arg_33_2)
	if ProtoHandler:onMsgProcess(arg_33_1, arg_33_2) then
		g.core.model.User.rechargeData:onS2CGMDoubleRechargeInfo(arg_33_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_UPDATEGMFIRSTRECHARGEINFO, false, arg_33_1, arg_33_2)
	end
end

function var_0_1.on_S2C_Recharge_DailyBoxTurnAward(arg_34_0, arg_34_1, arg_34_2)
	if ProtoHandler:onMsgProcess(arg_34_1, arg_34_2) then
		g.core.model.User.activityDailyBoxData:updateAwardCfg(arg_34_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECHARGE_DAILYBOXTURNAWARD, false, arg_34_1, arg_34_2)
	end
end

function var_0_1.on_S2C_Recharge_GetRechargeRebateInfo(arg_35_0, arg_35_1, arg_35_2)
	if ProtoHandler:onMsgProcess(arg_35_1, arg_35_2) then
		var_0_5:onRcvRechargeRebateInfo(arg_35_2)
		var_0_4:dispatchEvent(var_0_3.EVENT_NET_S2C_RECHARGE_GETRECHARGEREBATEINFO)
	end
end

function var_0_1.on_S2C_Recharge_UpdateRechargeRebateGMInfo(arg_36_0, arg_36_1, arg_36_2)
	if ProtoHandler:onMsgProcess(arg_36_1, arg_36_2) then
		var_0_5:onUpdateRechargeRebateGMInfo(arg_36_2)
		var_0_4:dispatchEvent(var_0_3.EVENT_NET_S2C_RECHARGE_UPDATERECHARGEREBATEGMINFO, false, arg_36_1, arg_36_2)
	end
end

function var_0_1.on_S2C_Recharge_GetRechargeRebateAward(arg_37_0, arg_37_1, arg_37_2)
	if ProtoHandler:onMsgProcess(arg_37_1, arg_37_2) then
		var_0_5:onRcvRechargeRebateAward(arg_37_2)
		var_0_4:dispatchEvent(var_0_3.EVENT_NET_S2C_RECHARGE_GETRECHARGEREBATEAWARD, false, arg_37_1, arg_37_2)
	end
end

function var_0_1.on_S2C_Recharge_BuyRechargeRebateGift(arg_38_0, arg_38_1, arg_38_2)
	if ProtoHandler:onMsgProcess(arg_38_1, arg_38_2) then
		var_0_5:onRcvDiamondBuyGiftInfo(arg_38_2)
		var_0_4:dispatchEvent(var_0_3.EVENT_NET_S2C_RECHARGE_BUYRECHARGEREBATEGIFT, false, arg_38_1, arg_38_2)
	end
end

function var_0_1.on_S2C_Recharge_RechargeRebateAwards(arg_39_0, arg_39_1, arg_39_2)
	if ProtoHandler:onMsgProcess(arg_39_1, arg_39_2) then
		var_0_4:dispatchEvent(var_0_3.EVENT_NET_S2C_RECHARGE_RECHARGEREBATEAWARDS, false, arg_39_1, arg_39_2)
	end
end

function var_0_1.on_S2C_Recharge_Award(arg_40_0, arg_40_1, arg_40_2)
	if ProtoHandler:onMsgProcess(arg_40_1, arg_40_2) then
		var_0_4:dispatchEvent(var_0_3.EVENT_NET_S2C_RECHARGE_AWARD, false, arg_40_1, arg_40_2)
	end
end

function var_0_1.on_S2C_Recharge_SubRechargeNotify(arg_41_0, arg_41_1, arg_41_2)
	if ProtoHandler:onMsgProcess(arg_41_1, arg_41_2) then
		var_0_4:dispatchEvent(var_0_3.EVENT_NET_S2C_RECHARGE_SUBRECHARGENOTIFY, false, arg_41_1, arg_41_2)
	end
end

function var_0_1.on_S2C_Recharge_GetAllDailySaleAward(arg_42_0, arg_42_1, arg_42_2)
	if ProtoHandler:onMsgProcess(arg_42_1, arg_42_2) then
		var_0_4:dispatchEvent(var_0_3.EVENT_NET_S2C_RECHARGE_GETALLDAILYSALEAWARD, false, arg_42_1, arg_42_2)
	end
end

function var_0_1.on_S2C_ReturnPay_GetInfo(arg_43_0, arg_43_1, arg_43_2)
	if ProtoHandler:onMsgProcess(arg_43_1, arg_43_2) then
		g.core.model.User.rechargeData:onS2CReturnPayGetInfo(arg_43_2)
	end
end

function var_0_1.on_S2C_ReturnPay_GetAward(arg_44_0, arg_44_1, arg_44_2)
	g.core.model.User.rechargeData:onS2CReturnPayGetAward(arg_44_2)
	var_0_4:dispatchEvent(var_0_3.EVENT_NET_S2C_RETURN_PAY_GETAWARD, false, arg_44_1, arg_44_2)
end

return var_0_1
