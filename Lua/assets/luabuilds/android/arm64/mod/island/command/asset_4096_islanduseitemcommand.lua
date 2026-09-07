local IslandUseItemCommand = class("IslandUseItemCommand", pm.SimpleCommand)

function IslandUseItemCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.count or 1
	local var_1_3 = var_1_0.arg or {}
	local var_1_4 = getProxy(IslandProxy):GetIsland()
	local var_1_5 = var_1_4:GetInventoryAgency()

	if var_1_2 > var_1_5:GetOwnCount(var_1_0.id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21026, {
		id = var_1_0.id,
		count = var_1_2,
		arg = var_1_3
	}, 21027, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.ship_list) do
				var_1_4:GetCharacterAgency():AddShip(IslandShip.New(iter_2_1))
			end

			var_1_5:RemoveItem(var_1_1, var_1_2)
			self:HandleUsageEffect(var_1_1, var_1_3)
			self:sendNotification(GAME.ISLAND_USE_ITEM_DONE, {
				dropData = IslandDropHelper.AddItems(arg_2_0)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function IslandUseItemCommand:HandleUsageEffect(arg_3_1, arg_3_2)
	local var_3_0 = IslandItem.StaticGetUsageType(arg_3_1)

	return
end

return IslandUseItemCommand
