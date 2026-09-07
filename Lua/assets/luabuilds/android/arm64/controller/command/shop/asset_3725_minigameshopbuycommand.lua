local MiniGameShopBuyCommand = class("MiniGameShopBuyCommand", pm.SimpleCommand)

function MiniGameShopBuyCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = var_1_0.id
	local var_1_3 = 0
	local var_1_4 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_0.list) do
		var_1_4 = var_1_4 + iter_1_1.num
		var_1_3 = var_1_3 + pg.gameroom_shop_template[var_1_0.id].price * iter_1_1.num
	end

	if var_1_3 > getProxy(GameRoomProxy):getTicket() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("game_ticket_notenough"),
			onYes = function()
				self:sendNotification(GAME.GO_SCENE, SCENE.GAME_HALL)

				return
			end,
			onNo = function()
				return
			end
		})

		return
	end

	pg.ConnectionMgr.GetInstance():Send(26152, {
		goodsid = var_1_2,
		selected = var_1_0.list
	}, 26153, function(arg_4_0)
		if arg_4_0.result == 0 then
			local var_4_1 = {}

			var_4_1[id2res(GameRoomProxy.ticket_res_id)] = var_1_3 or 0

			getProxy(PlayerProxy):getRawData():consume(var_4_1)

			local var_4_2 = getProxy(ShopsProxy):getMiniShop()

			var_4_2:consume(var_1_2, var_1_4)
			getProxy(ShopsProxy):setMiniShop(var_4_2)
			self:sendNotification(GAME.MINI_GAME_SHOP_BUY_DONE, {
				list = PlayerConst.addTranDrop(arg_4_0.drop_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_4_0.result] .. arg_4_0.result)
		end

		return
	end)

	return
end

return MiniGameShopBuyCommand
