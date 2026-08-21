local var_0_0 = class("SkinCoupunShoppingCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shopId
	local var_1_2 = var_1_0.cnt
	local var_1_3 = _.detect(getProxy(ShipSkinProxy):GetAllSkins(), function(arg_2_0)
		return arg_2_0.id == var_1_1
	end)

	if not var_1_3 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_shopId_noFound"))

		return
	end

	if not var_1_3:canPurchase() then
		return
	end

	local var_1_4 = var_1_3:getSkinId()
	local var_1_5 = getProxy(ShipSkinProxy)
	local var_1_6 = ShipSkin.New({
		id = var_1_4
	})
	local var_1_7 = SkinCouponActivity.GetSkinCouponActivities(var_1_0.shopId)

	if #var_1_7 == 0 then
		return
	end

	table.sort(var_1_7, CompareFuncs({
		function(arg_5_0)
			return -arg_5_0:GetDiscountPrice()
		end,
		function(arg_6_0)
			return arg_6_0.id
		end
	}))

	for iter_1_0, iter_1_1 in ipairs(var_1_7) do
		if iter_1_1:GetCanUsageCnt() > 0 then
			table.insert({}, {
				actId = iter_1_1.id,
				drop = Drop.New({
					type = DROP_TYPE_VITEM,
					id = iter_1_1:GetItemId(),
					count = iter_1_1:GetCanUsageCnt()
				}),
				discount = iter_1_1:GetDiscountPrice()
			})
		end
	end

	SkinCouponMultiMsgBox.New(pg.UIMgr.GetInstance().OverlayMain):ExecuteAction("Show", {
		itemList = {},
		skinId = var_1_4,
		skinName = ShipSkin.New({
			id = var_1_4
		}).skinName,
		price = var_1_3:getConfig("resource_num"),
		onYes = function(arg_3_0)
			if var_1_3:getConfig("resource_num") - arg_3_0.discount > getProxy(PlayerProxy):getRawData()[id2res(var_1_3:getConfig("resource_type"))] then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)

				return
			end

			pg.ConnectionMgr.GetInstance():Send(11202, {
				cmd = 1,
				activity_id = arg_3_0.actId,
				arg1 = var_1_1,
				arg2 = var_1_2,
				arg_list = {}
			}, 11203, function(arg_4_0)
				if arg_4_0.result == 0 then
					SkinCouponActivity.UseSkinCoupon(arg_3_0.actId)
					var_1_5:addSkin(var_1_6)

					local var_4_0 = getProxy(PlayerProxy):getData()

					var_4_0:consume({
						[id2res(var_1_3:getConfig("resource_type"))] = var_0
					})
					getProxy(PlayerProxy):updatePlayer(var_4_0)
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_buy_success"))
					arg_1_0:sendNotification(GAME.SKIN_COUPON_SHOPPING_DONE, {
						id = var_1_1,
						awards = {}
					})
				else
					pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_4_0.result] .. arg_4_0.result)
				end

				return
			end)

			return
		end
	})

	return
end

return var_0_0
