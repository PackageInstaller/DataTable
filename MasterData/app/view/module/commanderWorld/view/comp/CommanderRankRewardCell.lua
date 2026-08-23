local CommanderRankRewardCell = class("CommanderRankRewardCell", require("app.fairyGUI.commanderWorld.UI_CommanderRankRewardCell"))

function CommanderRankRewardCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function CommanderRankRewardCell:ctor()
	self._personRewardData = {}
	self._guildRewardData = {}

	self.m_personList:setVirtual()
	self.m_personList:setItemRenderer(handler(self, self._onPersonRewardItemRender))
	self.m_guildList:setVirtual()
	self.m_guildList:setItemRenderer(handler(self, self._onGuildRewardItemRender))
end

function CommanderRankRewardCell:updateRankRewardCell(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self._personRewardData = arg_3_1
	self._guildRewardData = arg_3_2

	self.m_rankIndexComp:updateRankIndex({
		rank = arg_3_4
	})

	if arg_3_3 == 1 then
		self.m_personList:setNumItems(#self._personRewardData[1])
		self.m_typeController:setSelectedIndex(0)
	elseif arg_3_3 == 2 then
		self.m_guildList:setNumItems(#self._guildRewardData[1])
		self.m_typeController:setSelectedIndex(1)
	end

	self.m_hasBgController:setSelectedIndex(arg_3_4 % 2 ~= 0 and 1 or 0)
end

function CommanderRankRewardCell:_onPersonRewardItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateIcon({
		type = self._personRewardData[1][arg_4_1 + 1].rewardType,
		value = self._personRewardData[1][arg_4_1 + 1].rewardValue,
		size = self._personRewardData[1][arg_4_1 + 1].rewardNum
	})
end

function CommanderRankRewardCell:_onGuildRewardItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateIcon({
		type = self._guildRewardData[1][arg_5_1 + 1].rewardType,
		value = self._guildRewardData[1][arg_5_1 + 1].rewardValue,
		size = self._guildRewardData[1][arg_5_1 + 1].rewardNum
	})
end

return CommanderRankRewardCell
