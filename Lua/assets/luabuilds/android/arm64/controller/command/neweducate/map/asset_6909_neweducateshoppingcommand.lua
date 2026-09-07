local NewEducateShoppingCommand = class("NewEducateShoppingCommand", pm.SimpleCommand)

function NewEducateShoppingCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.goodId
	local var_1_2 = var_1_0.num
	local var_1_3 = var_1_0.isUpgradeEntry
	local var_1_4 = var_1_0.callback

	if getProxy(NewEducateProxy):GetCurChar():GetFSM():CheckPriorityStystem() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

		return
	end

	local var_1_5 = getProxy(NewEducateProxy)
	local var_1_6 = var_1_5:GetCurChar()
	local var_1_7 = NewEducateGoods.New(var_1_0.goodId):GetCostWithBenefit((var_1_6:GetGoodsDiscountInfos()))

	var_1_7.number = var_1_7.number * var_1_0.num

	if not var_1_6:IsMatch(var_1_7) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(29066, {
		id = var_1_0.id,
		shop = var_1_0.goodId,
		num = var_1_0.num
	}, 29067, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_5:Cost(var_1_7)
			var_1_6:GetFSM():GetState(NewEducateFSM.SYSTEM.MAP):AddBuyCnt(var_1_1, var_1_2)

			local var_2_0 = NewEducateDropHelper.HandleDrops(arg_2_0.drop)

			self:sendNotification(GAME.NEW_EDUCATE_SHOPPING_DONE, {
				drops = var_2_0,
				isUpgradeEntry = var_1_3
			})
			pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataSite(var_1_6.id, var_1_6:GetGameCnt(), var_1_6:GetRoundData().round, 4, var_1_1))
			existCall(var_1_4, var_2_0)
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_Shopping: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateShoppingCommand
