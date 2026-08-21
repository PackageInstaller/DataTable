local var_0_0 = class("EducateBuyCollectCommand", pm.SimpleCommand)

var_0_0.TYPE = {
	POLAROID = 3,
	ENDING = 1,
	MEMORY = 2
}

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.type
	local var_1_2 = var_1_0.id
	local var_1_3 = getProxy(PlayerProxy)

	if var_1_0.cost > getProxy(PlayerProxy):getData().gold then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	local var_1_4 = getProxy(EducateProxy)

	if var_1_0.type == var_0_0.TYPE.ENDING and table.contains(var_1_4:GetAllEndings(), var_1_0.id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_already owned"))

		return
	end

	if var_1_0.type == var_0_0.TYPE.MEMORY and table.contains(var_1_4:GetMemories(), var_1_0.id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_already owned"))

		return
	end

	if var_1_0.type == var_0_0.TYPE.POLAROID and table.contains(var_1_4:GetPolaroidList(), var_1_0.id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_already owned"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(27049, {
		type = var_1_0.type,
		ids = var_1_0.id
	}, 27050, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_0:consume({
				gold = var_0
			})
			var_1_3:updatePlayer(var_0)
			switch(var_1_1, {
				[var_0_0.TYPE.ENDING] = function()
					var_1_4:AddEndingFromBuy(var_1_2)
					var_1_4:AddEndingBuyCnt()

					return
				end,
				[var_0_0.TYPE.MEMORY] = function()
					var_1_4:AddMemory(var_1_2)
					var_1_4:AddMemoryBuyCnt()

					return
				end,
				[var_0_0.TYPE.POLAROID] = function()
					for iter_5_0, iter_5_1 in ipairs(pg.child_polaroid.get_id_list_by_group[pg.child_polaroid[var_1_2].group]) do
						var_1_4:AddPolaroid(iter_5_1)
					end

					var_1_4:AddPolaroidBuyCnt()

					return
				end
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("child_buy_collect_success"))
			arg_1_0:sendNotification(GAME.EDUCATE_BUY_COLLECT_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate buy collect error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
