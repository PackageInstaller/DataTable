local NewSlgS2DefenderInfoComp = class("NewSlgS2DefenderInfoComp", require("app.fairyGUI.newSlg.UI_NewSlgS2DefenderInfoComp"))

function NewSlgS2DefenderInfoComp:ctor()
	self._content = nil
	self._userMap = {}
	self._teams = {}
	self._defTeams = {}
	self._cityId = 0

	self.m_teamList:setVirtual(self)
	self.m_teamList:setItemRenderer(handler(self, self._onRenderListTeamCell))
	self.m_teamList:setTouchable(false)
	self.m_defList:setVirtual(self)
	self.m_defList:setItemRenderer(handler(self, self._onRenderDefList))
	self.m_defList:setTouchable(false)
end

function NewSlgS2DefenderInfoComp:updateView(arg_2_1, arg_2_2)
	self._content = arg_2_1
	self._teams = arg_2_1.teams or {}

	dump(arg_2_1)

	self._defTeams = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.def_teams or {}) do
		if not iter_2_1.characters then
			table.insert(self._defTeams, iter_2_1)
		end
	end

	self._cityId = arg_2_2

	self.m_defTxt:setText(g.core.lang:get(429660, {
		num = #self._defTeams
	}))

	local var_2_0 = g.core.model.User.newSlgData:getCityOccupyAllianceId(arg_2_2) > 0

	self.m_realGroup:setVisible(true)

	if not var_2_0 then
		self.m_defGroup:setPosition(0, 2)
		self.m_emptyGroup:setVisible(false)
		self.m_realGroup:setVisible(false)
		self.m_teamList:setVisible(false)
	elseif #self._teams == 0 then
		self.m_defGroup:setPosition(0, 288)
		self.m_emptyGroup:setVisible(true)
		self.m_teamList:setVisible(false)
	else
		self.m_emptyGroup:setVisible(false)
		self.m_teamList:setVisible(true)
		self.m_teamList:setNumItems(#self._teams)
		self.m_teamList:setHeight(#self._teams * 112)
		self.m_defGroup:setPosition(self.m_defGroup:getPosition().x, self.m_teamList:getPosition().y + self.m_teamList:getHeight() + 10)
	end

	self.m_defList:setNumItems(#self._defTeams)
	self.m_defList:resizeToFit(#self._defTeams)
end

function NewSlgS2DefenderInfoComp:_onRenderDefList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._defTeams[arg_3_1 + 1])
end

function NewSlgS2DefenderInfoComp:_onRenderListTeamCell(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._teams[arg_4_1 + 1], self._teams[arg_4_1 + 1].uid)
end

function NewSlgS2DefenderInfoComp:_updateUserSnap()
	self:updateView(self._content, self._cityId)
end

function NewSlgS2DefenderInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateUserSnap), self)
end

return NewSlgS2DefenderInfoComp
