local var_0_0 = g.core.model.User.pubgData
local PubgGameRankCell = class("PubgGameRankCell", require("app.fairyGUI.pubg.UI_PubgGameRankCell"))

function PubgGameRankCell:ctor()
	return
end

function PubgGameRankCell:updateCell(arg_2_1, arg_2_2)
	self.m_hasBgController:setSelectedIndex(arg_2_2 % 2)

	if not arg_2_1 then
		return
	end

	self.m_nameText:setText(arg_2_1:getName())
	self.m_scoreText:setText(arg_2_1:getScore())
	self.m_fightValueText:setText(arg_2_1:getFightValue())
	self.m_rankComp:updateRankIndex({
		rank = arg_2_2 + 1
	})
	self.m_isSelfController:setSelectedIndex(arg_2_1:isMe() and 1 or 0)

	local var_2_0 = arg_2_1:getSnapShot()

	if var_2_0 then
		self.m_userIcon:updateAsUser(var_2_0)
		self.m_userIcon:setVisible(true)

		if not var_2_0.server_name or var_2_0.server_name == "" then
			self.m_serverText:setText(var_0_0:getRandomServerName())
		else
			self.m_serverText:setText(var_2_0.server_name)
		end
	else
		self.m_userIcon:setVisible(false)
		self.m_serverText:setText("")
	end
end

return PubgGameRankCell
