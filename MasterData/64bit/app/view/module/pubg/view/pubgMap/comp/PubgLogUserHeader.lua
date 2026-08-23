local PubgLogUserHeader = class("PubgLogUserHeader", require("app.fairyGUI.pubg.UI_PubgLogUserHeader"))

function PubgLogUserHeader:setUserData(arg_1_1)
	self.m_userName:setText(arg_1_1:getName() or "")
	self.m_userHeader:getChild("icon"):updateAsUser(arg_1_1:getSnapShot())
end

return PubgLogUserHeader
