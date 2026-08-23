local var_0_0 = g.core.model.User.redCliffData
local RedCliffRankComp = class("RedCliffRankComp", require("app.fairyGUI.redCliff.UI_RedCliffRankComp"))

function RedCliffRankComp:ctor()
	self._rankList = {}

	self.m_isDownController:setSelectedIndex(1)
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
	self.m_downBtn:addClickListener(handler(self, self._onClickDownBtn))
end

function RedCliffRankComp:updateRankComp()
	self:_updateMyRankAndScore()

	self._rankList = var_0_0:getMatchRankList()

	self.m_rankList:setNumItems((math.max(#self._rankList, g.core.const.ConstMgr.RedCliffConst.MIN_RANK_LENGTH)))
end

function RedCliffRankComp:_updateMyRankAndScore()
	local var_3_0, var_3_1 = var_0_0:getMyRankAndScore()

	self.m_myRank:setText(var_3_0 > 0 and var_3_0 or g.core.lang:get(421024))
	self.m_myScore:setText(var_3_1)
end

function RedCliffRankComp:_onRenderRankList(arg_4_1, arg_4_2)
	arg_4_2:updateRankCell(self._rankList[arg_4_1 + 1], arg_4_1 + 1)
end

function RedCliffRankComp:_onClickDownBtn()
	self.m_isDownController:setSelectedIndex(self.m_isDownController:getSelectedIndex() == 1 and 0 or 1)
end

return RedCliffRankComp
