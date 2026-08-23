local UserBindAwardComp = class("UserBindAwardComp", require("app.fairyGUI.user.UI_UserBindAwardComp"))

function UserBindAwardComp:updateAward(arg_1_1)
	self.m_itemIcon:setURL(arg_1_1[1].bigIcon)
	self.m_numTxt:setText(arg_1_1[1].size)
end

function UserBindAwardComp:updateState(arg_2_1)
	if arg_2_1 then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return UserBindAwardComp
