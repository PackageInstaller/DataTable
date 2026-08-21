local var_0_0 = class("ChargeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
		local var_1_0 = pg.SdkMgr.GetInstance()

		if not var_1_0:YoStarCheckCanBuy() then
			originalPrint("wait for a second, Do not click quickly~")

			return
		end
	end

	local var_1_1 = arg_1_1:getBody().shopId
	local var_1_2 = getProxy(ShopsProxy)
	local var_1_3 = getProxy(ShopsProxy):getFirstChargeList() or {}

	if not var_1_1 then
		return
	end

	local var_1_4 = not table.contains(var_1_3, var_1_1)
	local var_1_5 = Goods.Create({
		shop_id = var_1_1
	}, Goods.TYPE_CHARGE)

	pg.TrackerMgr.GetInstance():Tracking(TRACKING_PURCHASE_CLICK, var_1_1)
	pg.ConnectionMgr.GetInstance():Send(11501, {
		shop_id = var_1_1,
		device = PLATFORM
	}, 11502, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_2.tradeNoPrev ~= arg_2_0.pay_id then
				if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US then
					local var_2_0 = pg.SdkMgr.GetInstance()

					if var_2_0:GetIsPlatform() then
						local var_2_1 = var_1_5:getConfig("airijp_id")

						originalPrint("请求购买的productId：" .. var_2_1)
						originalPrint("请求购买的url：" .. arg_2_0.url)
						originalPrint("请求购买的id为：" .. arg_2_0.pay_id)
						pg.SdkMgr.GetInstance():YoStarPay(var_2_1, arg_2_0.url, arg_2_0.pay_id)

						goto label_2_0
					end
				end

				do
					local var_2_2 = var_1_5:firstPayDouble() and var_1_4
					local var_2_3 = getProxy(PlayerProxy):getData()
					local var_2_4 = var_1_5:RawGetConfig("money") * 100
					local var_2_5 = var_1_5:getConfig("name")

					if PLATFORM_CODE == PLATFORM_CH then
						if pg.SdkMgr.GetInstance():GetChannelUID() == "21" and var_1_1 == 1001 then
							var_2_5 = "特许巡游凭证(202111)"
						end
					end

					local var_2_6 = 0

					var_2_6 = var_2_2 and var_1_5:getConfig("gem") * 2 or var_1_5:getConfig("gem") + var_1_5:getConfig("extra_gem")

					local var_2_7 = arg_2_0.pay_id
					local var_2_8 = arg_2_0.url or ""
					local var_2_9 = arg_2_0.order_sign or ""

					pg.SdkMgr.GetInstance():SdkPay(var_1_5:getConfig("id_str"), var_2_4, var_2_5, var_2_6, var_2_7, var_1_5:getConfig("subject"), "-" .. var_2_3.id .. "-" .. arg_2_0.pay_id, var_2_3.name, var_2_8, var_2_9)
				end

				::label_2_0::

				var_1_2.tradeNoPrev = arg_2_0.pay_id

				pg.TrackerMgr.GetInstance():Tracking(TRACKING_PURCHASE, var_1_1)
				getProxy(ShopsProxy):addWaitTimer()
				arg_1_0:sendNotification(GAME.CHARGE_OPERATION_DONE)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("charge_trade_no_error"))
			end
		else
			if arg_2_0.result == 15 then
				arg_1_0:sendNotification(GAME.CHARGE_OPERATION_DONE)
			end

			if arg_2_0.result == 6 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("charge_error_count_limit"))
			elseif arg_2_0.result == 10 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("charge_error_disable"))
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("charge", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_0
