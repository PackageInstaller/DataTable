local AncientsGuessCell = class("AncientsGuessCell", require("app.fairyGUI.ancients.UI_AncientsGuessCell"))

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0:updateCell(arg_2_1)
	local var_2_0 = 3

	if g.core.model.User.ancientsData:getRoundTeamsMap()[arg_2_1.round] and not g.core.model.User.ancientsData:isInStageShowTime(arg_2_1.round) then
		if arg_2_1.support_team_id == 0 then
			var_2_0 = 0
		else
			var_2_0 = 2

			for iter_2_0, iter_2_1 in ipairs(g.core.model.User.ancientsData:getRoundTeamsMap()[arg_2_1.round]) do
				if iter_2_1 == arg_2_1.support_team_id then
					var_2_0 = 1
				end
			end
		end
	end

	self.m_bet_resultController:setSelectedIndex(var_2_0)
	self.m_Comp_left:updateView({
		isLeft = true,
		data = arg_2_1
	})
	self.m_Comp_right:updateView({
		isLeft = false,
		data = arg_2_1
	})
end

return var_0_0
