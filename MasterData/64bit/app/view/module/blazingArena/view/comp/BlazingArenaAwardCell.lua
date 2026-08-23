local BlazingArenaAwardCell = class("BlazingArenaAwardCell", require("app.fairyGUI.blazingArena.UI_BlazingArenaAwardCell"))

function BlazingArenaAwardCell:ctor()
	self._awardList = {}

	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
	self:_initListView()
end

function BlazingArenaAwardCell:_initListView()
	self.m_awardList:setVirtual()
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function BlazingArenaAwardCell:_onRenderAwardList(arg_3_1, arg_3_2)
	self._awardList[arg_3_1 + 1].scaleIndex = 4

	arg_3_2:updateIcon(self._awardList[arg_3_1 + 1])
end

function BlazingArenaAwardCell:updateCell(arg_4_1, arg_4_2)
	if not arg_4_1 then
		return
	end

	self.m_isShowBgController:setSelectedIndex(arg_4_2 % 2 == 0 and 1 or 0)

	local var_4_0 = arg_4_1.minRank
	local var_4_1 = arg_4_1.maxRank
	local var_4_2 = arg_4_1.minRank == arg_4_1.maxRank
	local var_4_3 = arg_4_1.minRank == arg_4_1.maxRank and var_4_0 <= 3

	if arg_4_1.minRank == arg_4_1.maxRank and var_4_0 <= 3 then
		self.m_rankIndexComp:updateRankIndex({
			rank = var_4_0
		})
	else
		self.m_rankText:setText((var_4_2 or nil) and (g.core.lang:get(302509, {
			rank = var_4_0
		}) or g.core.lang:get(302510, {
			rank1 = var_4_0,
			rank2 = var_4_1
		})))
	end

	self.m_isTopThreeController:setSelectedIndex(var_4_3 and 1 or 0)

	self._awardList = arg_4_1.data

	self.m_awardList:setNumItems(#self._awardList)
	self.m_awardList:resizeToFit(#self._awardList)
end

return BlazingArenaAwardCell
