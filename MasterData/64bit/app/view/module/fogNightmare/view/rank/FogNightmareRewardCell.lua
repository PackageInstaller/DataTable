local FogNightmareRewardCell = class("FogNightmareRewardCell", require("app.fairyGUI.fogNightmare.UI_FogNightmareRewardCell"))

function FogNightmareRewardCell:ctor()
	self._rewardList = nil

	self.m_iconList:setVirtual()
	self.m_iconList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function FogNightmareRewardCell:_onRenderAwardList(arg_2_1, arg_2_2)
	self._rewardList[arg_2_1 + 1].scaleIndex = 4
	self._rewardList[arg_2_1 + 1].hideNum = false

	arg_2_2:updateIcon(self._rewardList[arg_2_1 + 1])
end

function FogNightmareRewardCell:updateCell(arg_3_1)
	if not next(arg_3_1) then
		return
	end

	if arg_3_1.minRank <= 3 then
		self.m_indexRank:setCtrlState("rank", {
			index = arg_3_1.minRank
		})
	else
		local var_3_0 = arg_3_1.minRank

		if arg_3_1.minRank ~= arg_3_1.maxRank then
			var_3_0 = var_3_0 .. "-" .. arg_3_1.maxRank
		end

		self.m_indexRank:setTitle(var_3_0)
		self.m_indexRank:setCtrlState("rank", {
			index = 0
		})
	end

	self._rewardList = arg_3_1.data

	self.m_iconList:setNumItems(#self._rewardList)
end

return FogNightmareRewardCell
