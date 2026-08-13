class = var_0_10000

local var_0_0 = "RefundChargeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	PLATFORM_CODE = var_1_10002
	PLATFORM_JP = var_1_10003

	if var_1_10002 ~= var_1_10003 then
		PLATFORM_CODE = var_1_10002
		PLATFORM_US = var_1_10003

		if var_1_10002 == var_1_10003 then
			pg = var_1_10002

			local var_1_0 = var_1_10002.SdkMgr.GetInstance()

			if not var_2.YoStarCheckCanBuy(var_1_0) then
				originalPrint = var_2

				var_2("wait for a second, Do not click quickly~")

				return
			end
		end

		local var_1_1 = arg_1_1
		local var_1_2 = arg_1_1.getBody(var_1_1).shopId

		getProxy = var_1_1
		ShopsProxy = var_1_10006

		local var_1_3 = var_1_1(var_1_10006)
		local var_1_4

		if not var_4.getFirstChargeList(var_1_3) then
			var_1_4 = {}
		end

		if not var_1_2 then
			return
		end

		table = var_1_10006

		local var_1_5 = not var_1_10006.contains(var_1_4, var_1_2)

		Goods = var_1_3

		local var_1_6 = var_1_3.Create
		local var_1_7 = {
			shop_id = var_1_2
		}

		Goods = var_1_10010

		local var_1_8 = var_1_6(var_1_7, var_1_10010.TYPE_CHARGE)

		pg = var_8

		local var_1_9 = var_8.TrackerMgr.GetInstance()
		local var_1_10 = var_8.Tracking

		TRACKING_PURCHASE_CLICK = var_1_10011

		var_1_10(var_1_9, var_1_10011, var_1_2)

		pg = var_1_10

		local var_1_11 = var_1_10.ConnectionMgr.GetInstance()
		local var_1_12 = var_8.Send
		local var_1_13 = 11513
		local var_1_14 = {
			shop_id = var_1_2
		}

		PLATFORM = var_1_10013
		var_1_14.device = var_1_10013

		var_1_12(var_1_11, var_1_13, var_1_14, 11514, function(arg_2_0)
			if arg_2_0.result == 0 then
				if var_0.tradeNoPrev ~= arg_2_0.pay_id then
					PLATFORM_CODE = var_2_2
					PLATFORM_JP = var_2_3

					if var_2_2 ~= var_2_3 then
						PLATFORM_CODE = var_2_2
						PLATFORM_US = var_2_3

						local var_2_2, var_2_3

						if var_2_2 == var_2_3 then
							pg = var_2_2

							local var_2_0 = var_2_2.SdkMgr.GetInstance()

							if var_2_2.GetIsPlatform(var_2_0) then
								local var_2_1 = var_1_8

								var_2_2 = var_2_2.getConfig(var_2_1, "airijp_id")
								var_2_3 = arg_2_0.url

								local var_2_4 = arg_2_0.pay_id

								originalPrint = var_2_10004

								var_2_10004("请求购买的productId：" .. var_2_2)

								originalPrint = var_2_10004

								var_2_10004("请求购买的url：" .. var_2_3)

								originalPrint = var_2_10004

								var_2_10004("请求购买的id为：" .. var_2_4)

								pg = var_2_10004

								local var_2_5 = var_2_10004.SdkMgr.GetInstance()

								var_2_10004.YoStarPay(var_2_5, var_2_2, var_2_3, var_2_4)

								goto label_2_0
							end
						end

						do
							local var_2_6 = var_1_8

							if var_2_2.firstPayDouble(var_2_6) then
								var_2_2 = var_1_5
							end

							getProxy = var_2_3
							PlayerProxy = var_2_10004

							local var_2_7 = var_2_3(var_2_10004)
							local var_2_8 = var_2.getData(var_2_7)
							local var_2_9 = var_1_8
							local var_2_10 = var_2_10004.getConfig(var_2_9, "money") * 100
							local var_2_11 = var_1_8
							local var_2_12 = var_6.getConfig(var_2_11, "name")
							local var_2_13 = 0

							if var_2_2 then
								local var_2_14 = var_1_8

								var_2_13 = var_8.getConfig(var_2_14, "gem") * 2
							else
								local var_2_15 = var_1_8
								local var_2_16 = var_8.getConfig(var_2_15, "gem")
								local var_2_17 = var_1_8

								var_2_13 = var_2_16 + var_9.getConfig(var_2_17, "extra_gem")
							end

							local var_2_18 = arg_2_0.pay_id
							local var_2_19 = var_1_8
							local var_2_20 = var_9.getConfig(var_2_19, "subject")
							local var_2_21 = "-" .. var_2_8.id .. "-" .. var_2_18
							local var_2_22

							if not arg_2_0.url then
								var_2_22 = ""
							end

							local var_2_23

							if not arg_2_0.order_sign then
								var_2_23 = ""
							end

							pg = var_13

							local var_2_24 = var_13.SdkMgr.GetInstance()
							local var_2_25 = var_13.SdkPay
							local var_2_26 = var_1_8

							var_2_25(var_2_24, var_16.getConfig(var_2_26, "id_str"), var_2_10, var_2_12, var_2_13, var_2_18, var_2_20, var_2_21, var_2_8.name, var_2_22, var_2_23)
						end

						::label_2_0::

						var_2_2 = var_0
						var_2_2.tradeNoPrev = arg_2_0.pay_id
						pg = var_2_2

						local var_2_27 = var_2_2.TrackerMgr.GetInstance()

						var_2_2 = var_2_2.Tracking
						TRACKING_PURCHASE = var_2_10004

						var_2_2(var_2_27, var_2_10004, var_1_2)

						getProxy = var_2_2
						ShopsProxy = var_2_27

						local var_2_28 = var_2_2(var_2_27)

						var_2_2.addWaitTimer(var_2_28)

						if false then
							pg = var_2_2

							local var_2_29 = var_2_2.TipsMgr.GetInstance()
							local var_2_30 = var_1.ShowTips

							i18n = var_2_10004

							var_2_30(var_2_29, var_2_10004("charge_trade_no_error"))
						end

						goto label_2_1

						if arg_2_0.result == 6 then
							-- block empty
						else
							pg = var_1

							local var_2_31 = var_1.TipsMgr.GetInstance()
							local var_2_32 = var_1.ShowTips

							errorTip = var_2_10004

							var_2_32(var_2_31, var_2_10004("charge", arg_2_0.result))
						end

						::label_2_1::

						return
					end
				end
			end
		end)

		return
	end
end

return var_0_1
