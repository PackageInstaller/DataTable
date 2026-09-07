local BuildCommaderCommand = class("BuildCommaderCommand", pm.SimpleCommand)

function BuildCommaderCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = var_1_0.tip
	local var_1_3 = getProxy(CommanderProxy)
	local var_1_4 = getProxy(PlayerProxy):getData()
	local var_1_5 = getProxy(BagProxy)
	local var_1_6 = {}

	for iter_1_0, iter_1_1 in ipairs((var_1_3:getPoolById(var_1_0.id):getConsume())) do
		if iter_1_1[1] == DROP_TYPE_RESOURCE then
			if var_1_4:getResById(iter_1_1[2]) < iter_1_1[3] then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

				return
			end
		elseif iter_1_1[1] == DROP_TYPE_ITEM and var_1_5:getItemCountById(iter_1_1[2]) < iter_1_1[3] then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

			return
		end

		table.insert(var_1_6, (Drop.Create(iter_1_1)))
	end

	pg.ConnectionMgr.GetInstance():Send(25002, {
		boxid = var_1_0.id
	}, 25003, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:updateBox((CommanderBox.New(arg_2_0.box)))

			for iter_2_0, iter_2_1 in ipairs(var_1_6) do
				self:sendNotification(GAME.CONSUME_ITEM, iter_2_1)
			end

			self:sendNotification(GAME.COMMANDER_ON_BUILD_DONE)

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

return BuildCommaderCommand
