local var_0_0 = g.core.model.User.pubgData
local PubgMapRankComp = class("PubgMapRankComp", require("app.fairyGUI.pubg.UI_PubgMapRankComp"))

function PubgMapRankComp:ctor()
	self._rankList = {}

	self:_initBtn()
	self:_initListView()
end

function PubgMapRankComp:_initBtn()
	self.m_downBtn:addClickListener(handler(self, self._onDownBtnClick))
end

function PubgMapRankComp:_initListView()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
end

function PubgMapRankComp:_onRenderRankList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._rankList[arg_4_1 + 1], arg_4_1 + 1)
end

function PubgMapRankComp:updateComp()
	self._rankList = var_0_0:getGamePlayerList()

	self.m_rankList:setNumItems(#self._rankList)

	local var_5_0, var_5_1 = var_0_0:getMyGameRankAndScore()

	self.m_myRankText:setText(var_5_0 > 0 and var_5_0 or g.core.lang:get(421024))
	self.m_myScoreText:setText(var_5_1)
end

function PubgMapRankComp:_onDownBtnClick()
	self.m_isDownController:setSelectedIndex(self.m_isDownController:getSelectedIndex() == 1 and 0 or 1)
end

return PubgMapRankComp
