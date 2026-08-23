local var_0_0 = g.core.model.User.newSlgData
local NewSlgPvcFinalRankComp = class("NewSlgPvcFinalRankComp", require("app.fairyGUI.newSlg.UI_NewSlgPvcFinalRankComp"))

function NewSlgPvcFinalRankComp:ctor()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankItemRender))
end

function NewSlgPvcFinalRankComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self._updateRank), self)
end

function NewSlgPvcFinalRankComp:updateRankView(arg_3_1, arg_3_2)
	self._rankType = arg_3_2
	self._rankUnits = arg_3_1.rank_units

	self:_updateRank()
end

function NewSlgPvcFinalRankComp:setRankType(arg_4_1)
	self._rankType = arg_4_1
end

function NewSlgPvcFinalRankComp:_updateRank()
	if not self:isVisible() then
		return
	end

	if self._rankUnits and #self._rankUnits > 0 then
		if #self._rankUnits > 0 then
			self.m_rankList:setNumItems(#self._rankUnits)
			self.m_isEmptyController:setSelectedIndex(0)
		else
			self.m_rankList:setNumItems(0)
			self.m_isEmptyController:setSelectedIndex(1)
		end
	else
		self.m_rankList:setNumItems(0)
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function NewSlgPvcFinalRankComp:isRewardTab(arg_6_1)
	self._isReward = arg_6_1

	if arg_6_1 then
		self.m_typeController:setSelectedIndex(1)

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

function NewSlgPvcFinalRankComp:_updateReward()
	self._rewardData = var_0_0:getNewSlgCurrentRankReward(self._rankType)

	self.m_isEmptyController:setSelectedIndex(0)
	self.m_rankList:setNumItems(#self._rewardData)
end

function NewSlgPvcFinalRankComp:_onRankItemRender(arg_8_1, arg_8_2)
	if not self._isReward then
		self._rankUnits[arg_8_1 + 1].allianceId = self._rankUnits[arg_8_1 + 1].id

		arg_8_2:updateRankCell(self._rankUnits[arg_8_1 + 1], arg_8_1 + 1)
	elseif self._isReward then
		arg_8_2:updateRankCell(nil, arg_8_1 + 1, self._rewardData[arg_8_1 + 1])
	end
end

function NewSlgPvcFinalRankComp:setEmpty()
	self.m_isEmptyController:setSelectedIndex(1)
end

return NewSlgPvcFinalRankComp
