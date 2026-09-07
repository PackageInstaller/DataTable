local ChangeMedalDisplayCommand = class("ChangeMedalDisplayCommand", pm.SimpleCommand)

function ChangeMedalDisplayCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().medalList
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = var_1_1:getData().displayTrophyList

	while 0 < 5 do
		if var_1_0[0] ~= var_1_2[0] then
			break
		end

		if 0 == 5 then
			return
		end
	end

	local var_1_4 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(var_1_4, iter_1_1)
	end

	pg.ConnectionMgr.GetInstance():Send(17401, {
		fixed_const = 1,
		medal_id = var_1_0
	}, 17402, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:updatePlayerMedalDisplay(var_1_0)
			pg.TipsMgr.GetInstance():ShowTips(i18n("change_display_medal_success"))
			self:sendNotification(GAME.CHANGE_PLAYER_MEDAL_DISPLAY_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ChangeMedalDisplayCommand
