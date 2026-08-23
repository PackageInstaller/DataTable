local var_0_0 = g.core.config.pubg_text_info
local var_0_1 = g.core.model.User.pubgData
local PubgLogTip = class("PubgLogTip", require("app.fairyGUI.pubg.UI_PubgLogTip"))

function PubgLogTip:updateViewComp(arg_1_1, arg_1_2)
	self.m_logTitle:setText(g.core.lang:getByString(arg_1_1.base_id and arg_1_1.base_id > 0 and var_0_0.get(arg_1_1.base_id).text or g.core.lang:get(430935), {
		name2 = "",
		name1 = ""
	}))
	self.m_winner:setUserData(var_0_1:getMapData():getUserById(arg_1_1.user_id or 0))
	self.m_loser:setUserData(var_0_1:getMapData():getUserById(arg_1_1.target_id or 0))

	if arg_1_2 then
		self.m_enterTransition:play()
	end
end

return PubgLogTip
