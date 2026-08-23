local FurnitureFriendRankCell = class("FurnitureFriendRankCell", require("app.fairyGUI.furniture.UI_FurnitureFriendRankCell"))

function FurnitureFriendRankCell:updateCellData(arg_1_1, arg_1_2)
	self.m_haveBgController:setSelectedIndex(arg_1_2 % 2)
	self.m_indexComp:updateRankIndex({
		rank = arg_1_2
	})

	local var_1_0 = arg_1_1:getBasicInfo()

	self.m_charmTxt:setText(arg_1_1:getCharmValue())
	self.m_nameTxt:setText(var_1_0.name)
	self.m_levelTxt:setText(g.core.lang:get(2052, {
		level = var_1_0.level
	}))
	self.m_headComp:updateAsUser(var_1_0)
	self.m_rankNumTxt:setText("")

	if not arg_1_1.isSelf and arg_1_1:isCrossServerFriend() then
		self.m_isCrossServerController:setSelectedIndex(1)
		self:_updateCrossServerView((arg_1_1:getServerName()))
	else
		self.m_isCrossServerController:setSelectedIndex(0)
	end
end

function FurnitureFriendRankCell:_updateCrossServerView(arg_2_1)
	self.m_serverName:initRaceTextParams({
		scrollDirection = 1,
		moveType = 1,
		playMode = 2,
		pauseTime = 0.5,
		duration = 3,
		title = arg_2_1 or ""
	})

	local var_2_0 = self.m_serverName:getContainerSize()
	local var_2_1 = self.m_serverName:getTextSize()

	self.m_serverName:setTitleAlign("left")

	if var_2_1.width > var_2_0.width then
		self.m_serverName:setMoveDistance(var_2_1.width - var_2_0.width)
		self.m_serverName:setStartPos(cc.p(0, self.m_serverName:getTextPosition().y))
	end

	self.m_serverName:play()
end

return FurnitureFriendRankCell
