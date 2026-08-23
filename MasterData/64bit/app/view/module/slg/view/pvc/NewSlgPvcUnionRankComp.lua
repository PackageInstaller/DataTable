local var_0_1 = g.core.model.User.newSlgData
local NewSlgPvcUnionRankComp = class("NewSlgPvcUnionRankComp", require("app.fairyGUI.newSlg.UI_NewSlgPvcUnionRankComp"))

function NewSlgPvcUnionRankComp:ctor()
	self._showRewardType = 0

	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankItemRender))
end

function NewSlgPvcUnionRankComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self._updateRank), self)
end

function NewSlgPvcUnionRankComp:updateRankView(arg_3_1, arg_3_2)
	self._rankType = arg_3_2
	self._rankUnits = arg_3_1.rank_units

	self:_updateRank()
end

function NewSlgPvcUnionRankComp:setRankType(arg_4_1)
	self._rankType = arg_4_1
end

function NewSlgPvcUnionRankComp:_updateRank()
	if self._rankUnits and #self._rankUnits > 0 then
		if #self._rankUnits > 0 then
			self.m_rankList:setNumItems(#self._rankUnits)
			self.m_emptyController:setSelectedIndex(1)
		else
			self.m_rankList:setNumItems(0)
			self.m_emptyController:setSelectedIndex(0)
		end
	else
		self.m_rankList:setNumItems(0)
		self.m_emptyController:setSelectedIndex(0)
	end
end

function NewSlgPvcUnionRankComp:isRewardTab(arg_6_1, arg_6_2)
	self._isReward = arg_6_1

	if arg_6_1 then
		self.m_typeController:setSelectedIndex(1)

		self._showRewardType = arg_6_2 == 2 and 6 or 5

		if g.core.model.User.newSlgData:getSName() == "S1" then
			self._showRewardType = 3
		end

		if self._rankType then
			self:_updateReward()
		end
	else
		if self._rankType then
			self:_updateRank()
		end

		self.m_typeController:setSelectedIndex(0)
	end
end

function NewSlgPvcUnionRankComp:_updateReward()
	self._rewardData = var_0_1:getNewSlgCurrentRankReward(self._showRewardType)

	self.m_emptyController:setSelectedIndex(1)
	self.m_rankList:setNumItems(#self._rewardData)
end

function NewSlgPvcUnionRankComp:_onRankItemRender(arg_8_1, arg_8_2)
	if not self._isReward then
		self._rankUnits[arg_8_1 + 1].allianceId = self._rankUnits[arg_8_1 + 1].id

		arg_8_2:updateRankCell(self._rankUnits[arg_8_1 + 1], arg_8_1 + 1)
	elseif self._isReward then
		arg_8_2:updateRankCell(nil, arg_8_1 + 1, self._rewardData[arg_8_1 + 1])
	end
end

return NewSlgPvcUnionRankComp
