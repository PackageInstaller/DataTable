local var_0_0 = g.core.model.User.fogNightmareData:getFormationData()
local FogNightAssistantFriendIcon = class("FogNightAssistantFriendIcon", require("app.fairyGUI.fogNightmare.UI_FogNightAssistantFriendIcon"))

function FogNightAssistantFriendIcon:ctor()
	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)
end

function FogNightAssistantFriendIcon:updateFriendIcon(arg_2_1, arg_2_2)
	self._data = arg_2_1

	self.m_playerIcon:updateIcon({
		changeControllers = true,
		struct = arg_2_1.struct
	})
	self.m_playerIcon:setTouchable(false)

	if arg_2_2 then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	self.m_nameTxt:setText(arg_2_1.name)
	self.m_serverName:initRaceTextParams({
		scrollDirection = 1,
		moveType = 1,
		playMode = 2,
		pauseTime = 0.5,
		duration = 3,
		title = (arg_2_1.sid ~= g.core.platform.ServerListProxy:getSelectedServer().id or nil) and (arg_2_1.serverName or "")
	})

	local var_2_1 = self.m_serverName:getContainerSize()
	local var_2_2 = self.m_serverName:getTextSize()

	self.m_serverName:setTitleAlign("middle")

	if var_2_2.width > var_2_1.width then
		self.m_serverName:setMoveDistance(var_2_2.width - var_2_1.width)
		self.m_serverName:setStartPos(cc.p(var_2_2.width / 2, self.m_serverName:getTextPosition().y))
	end

	self.m_serverName:play()
end

function FogNightAssistantFriendIcon:_onClickIcon()
	return
end

return FogNightAssistantFriendIcon
