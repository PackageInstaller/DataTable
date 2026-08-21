local var_0_0 = class("BuildCommaderCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = var_1_0.tip
	local var_1_3 = getProxy(CommanderProxy)
	local var_1_4 = getProxy(PlayerProxy):getData()
	local var_1_5 = getProxy(BagProxy)
	local var_1_6 = {}

	for iter_1_0, iter_1_1 in ipairs((getProxy(CommanderProxy):getPoolById(var_1_0.id):getConsume())) do
		local var_1_7

		if iter_1_1[1] == DROP_TYPE_RESOURCE then
			if var_1_4:getResById(iter_1_1[2]) < iter_1_1[3] then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

				return
			end
		elseif iter_1_1[1] == DROP_TYPE_ITEM and var_1_5:getItemCountById(iter_1_1[2]) < iter_1_1[3] then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

			do return end

			var_1_7 = var_1_6
		end

		table.insert(var_1_6, (Drop.Create(iter_1_1)))
	end

	pg.ConnectionMgr.GetInstance():Send(25002, {
		boxid = var_1_0.id
	}, 25003, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:updateBox((CommanderBox.New(arg_2_0.box)))

			for iter_2_0, iter_2_1 in ipairs(var_1_6) do
				arg_1_0:sendNotification(GAME.CONSUME_ITEM, iter_2_1)
			end

			arg_1_0:sendNotification(GAME.COMMANDER_ON_BUILD_DONE)

			if var_1_2 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("commander_build_done"))
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_build_erro", arg_2_0.result))
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end)

	return
end

return var_0_0
