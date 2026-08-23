local ValentinesDayVoteDetailsComp = class("ValentinesDayVoteDetailsComp", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteDetailsComp"))
local var_0_1 = g.core.model.User.valentinesDayVoteData

ValentinesDayVoteDetailsComp.KNIGHT_TOP_NUM = 3

function ValentinesDayVoteDetailsComp:ctor()
	self.m_knightList1:setIniter(self)
	self.m_knightList2:setVirtual(self)
	self.m_knightList1:setItemRenderer(handler(self, self._onItemRenderer1))
	self.m_knightList2:setItemRenderer(handler(self, self._onItemRenderer2))

	self._knightsData = var_0_1:getAllKnightsData()
	self._selectedIndex = 0
end

function ValentinesDayVoteDetailsComp:updateView(arg_2_1)
	if arg_2_1 then
		self._selectedIndex = arg_2_1.group or self._selectedIndex
	end

	self._knightsData = var_0_1:getAllKnightsData(self._selectedIndex)

	self.m_knightList1:setNumItems(self.KNIGHT_TOP_NUM)
	self.m_knightList2:setNumItems(#self._knightsData - self.KNIGHT_TOP_NUM)
	self.m_knightList2:resizeToFit(#self._knightsData - self.KNIGHT_TOP_NUM)
end

function ValentinesDayVoteDetailsComp:onLoad()
	self:updateView()
end

function ValentinesDayVoteDetailsComp:onUnload()
	return
end

function ValentinesDayVoteDetailsComp:_onItemRenderer1(arg_5_1, arg_5_2)
	if self._knightsData[arg_5_1 + 1] then
		arg_5_2:update(self._knightsData[arg_5_1 + 1], arg_5_1 + 1)
	end
end

function ValentinesDayVoteDetailsComp:_onItemRenderer2(arg_6_1, arg_6_2)
	if self._knightsData[arg_6_1 + 1 + self.KNIGHT_TOP_NUM] then
		arg_6_2:update(self._knightsData[arg_6_1 + 1 + self.KNIGHT_TOP_NUM], arg_6_1 + 1 + self.KNIGHT_TOP_NUM)
	end
end

return ValentinesDayVoteDetailsComp
