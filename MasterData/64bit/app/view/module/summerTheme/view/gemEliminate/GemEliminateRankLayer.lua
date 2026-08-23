local var_0_0 = g.core.model.User.themeData
local GemEliminateRankLayer = class("GemEliminateRankLayer", require("app.fairyGUI.summerThemeGame.UI_GemEliminateRankLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		resName = "GemEliminateRankLayer",
		pkgName = "summerThemeGame",
		isFullScreen = true
	})
end)

function GemEliminateRankLayer:ctor(arg_2_1)
	self._activeThemeValue = arg_2_1 and arg_2_1.themeValue
	self._gemEliminateData = var_0_0:getThemeData(self._activeThemeValue):getGemEliminateData()
	self._phase = self._gemEliminateData:getPhaseId()

	self:_initRegisterUI()
end

function GemEliminateRankLayer:_initRegisterUI()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankListRenderer))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
end

function GemEliminateRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvCommonRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onRcvCommonRank, self)
	self._gemEliminateData:sendGemEliminateCommonRankInfo()
	self:_updateMainView()
end

function GemEliminateRankLayer:_onRcvCommonRank(arg_5_1, arg_5_2, arg_5_3)
	self._gemEliminateData:onS2CGemEliminateCommonRank(arg_5_3)
	self:_updateMainView()
end

function GemEliminateRankLayer:_updateMainView()
	self.m_tabController:setSelectedIndex(math.max(0, self._phase - 1))

	self._rankData = self._gemEliminateData:getPhaseRankData(self._phase)

	if self._rankData and self._rankData.rank then
		self.m_rankList:setNumItems(#self._rankData.rank)
		self.m_isEmptyController:setSelectedIndex(0)

		if self._rankData.myRank > 0 then
			self.m_myRankTxt:setText(g.core.lang:get(405803) .. g.core.lang:get(405804, {
				rank = self._rankData.myRank
			}))
		else
			self.m_myRankTxt:setText(g.core.lang:get(405803) .. g.core.lang:get(405805))
		end
	else
		self.m_rankList:setNumItems(0)
		self.m_isEmptyController:setSelectedIndex(1)
		self.m_myRankTxt:setText(g.core.lang:get(405803) .. g.core.lang:get(405805))
	end

	for iter_6_0 = 1, 3 do
		local var_6_0 = self._gemEliminateData:getPhaseInfoByPhase(iter_6_0)

		if var_6_0 then
			self["m_phaseTab" .. iter_6_0]:setTitle(var_6_0.phase_name)
		end
	end
end

function GemEliminateRankLayer:_onRankListRenderer(arg_7_1, arg_7_2)
	if self._rankData.rank[arg_7_1 + 1] then
		arg_7_2:updateRankCell(self._rankData.rank[arg_7_1 + 1])
	end
end

function GemEliminateRankLayer:_onChangeTabCtrl()
	self._phase = self.m_tabController:getSelectedIndex() + 1
	self._rankData = self._gemEliminateData:getPhaseRankData(self._phase)

	if self._rankData then
		self.m_rankList:setNumItems(#self._rankData.rank)
		self.m_isEmptyController:setSelectedIndex(0)

		if self._rankData.myRank > 0 then
			self.m_myRankTxt:setText(g.core.lang:get(405803) .. g.core.lang:get(405804, {
				rank = self._rankData.myRank
			}))
		else
			self.m_myRankTxt:setText(g.core.lang:get(405803) .. g.core.lang:get(405805))
		end
	else
		self.m_rankList:setNumItems(0)
		self.m_isEmptyController:setSelectedIndex(1)
		self.m_myRankTxt:setText(g.core.lang:get(405803) .. g.core.lang:get(405805))
	end
end

return GemEliminateRankLayer
