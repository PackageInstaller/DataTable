local ColoringAchieveCommand = class("ColoringAchieveCommand", pm.SimpleCommand)

function ColoringAchieveCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id

	pg.ConnectionMgr.GetInstance():Send(26002, {
		act_id = var_1_0.activityId,
		id = var_1_0.id
	}, 26003, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = PlayerConst.addTranDrop(arg_2_0.drop_list)
			local var_2_1 = getProxy(ColoringProxy)
			local var_2_2 = var_2_1:getColorGroup(var_1_1)

			var_2_2:setDrops(var_2_0)
			var_2_2:setState(ColorGroup.StateAchieved)
			var_2_1:checkState()
			self:sendNotification(GAME.COLORING_ACHIEVE_DONE, {
				drops = var_2_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("coloring_achieve", arg_2_0.result))
		end

		return
	end)

	return
end

return ColoringAchieveCommand
