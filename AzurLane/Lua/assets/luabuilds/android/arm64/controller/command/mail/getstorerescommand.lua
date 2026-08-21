local var_0_0 = class("GetStoreResCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.oil
	local var_1_2 = var_1_0.gold

	if var_1_0.oil == 0 and var_1_0.gold == 0 then
		return
	end

	local var_1_3, var_1_4 = CheckOverflow((GetItemsOverflowDic({
		Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResOil,
			count = var_1_0.oil
		}),
		Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold,
			count = var_1_0.gold
		})
	})))

	if not var_1_3 then
		switch(var_1_4, {
			gold = function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_mail"))

				return
			end,
			oil = function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title") .. i18n("resource_max_tip_mail"))

				return
			end,
			equip = function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("mail_takeAttachment_error_magazine_full"))

				return
			end,
			ship = function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("mail_takeAttachment_error_dockYrad_full"))

				return
			end
		})

		return
	end

	pg.ConnectionMgr.GetInstance():Send(30012, {
		oil = var_1_0.oil,
		gold = var_1_0.gold
	}, 30013, function(arg_6_0)
		if arg_6_0.result == 0 then
			getProxy(PlayerProxy):UpdatePlayerRes({
				{
					id = PlayerConst.ResOil,
					count = var_1_1
				},
				{
					id = PlayerConst.ResStoreOil,
					count = -var_1_1
				},
				{
					id = PlayerConst.ResGold,
					count = var_1_2
				},
				{
					id = PlayerConst.ResStoreGold,
					count = -var_1_2
				}
			})
			arg_1_0:sendNotification(GAME.GET_STORE_RES_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_6_0.result))
		end

		return
	end)

	return
end

return var_0_0
