local var_0_0 = g.core.model.User.themeData
local ThemeGuessRankLayer = class("ThemeGuessRankLayer", require("app.fairyGUI.summerThemeGame.UI_ThemeGuessRankLayer"), function()
	return fgui.GComponent:create({
		resName = "ThemeGuessRankLayer",
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		isFullScreen = true,
		pkgName = "summerThemeGame"
	}, ...)
end)

function ThemeGuessRankLayer:ctor(arg_2_1)
	self._activeThemeValue = arg_2_1 and arg_2_1.themeValue
	self._themeGuessData = var_0_0:getThemeData(self._activeThemeValue):getThemeGuessData()
	self._phase = self._themeGuessData:getCurPhase()
	self._phaseRankData = {}

	self:_initRegisterUI()
end

function ThemeGuessRankLayer:_initRegisterUI()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankListRenderer))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
end

function ThemeGuessRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvCommonRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onRcvCommonRank, self)

	for iter_4_0, iter_4_1 in pairs((self._themeGuessData:getPhaseRankIds())) do
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 50,
			id = iter_4_1.num
		})
	end

	self:_updateMainView()
end

function ThemeGuessRankLayer:_onRcvCommonRank(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = self._themeGuessData:getPhaseIdByRankId(arg_5_3.id)

	if var_5_0 then
		local var_5_1

		if not self._phaseRankData[var_5_0] then
			self._phaseRankData[var_5_0] = {}
			var_5_1 = {}
		end

		var_5_1.rank = clone(arg_5_3.rank_units)
		var_5_1.myRank = arg_5_3.self_rank
		self._phaseRankData[var_5_0] = var_5_1
	end

	self:_updateMainView()
end

function ThemeGuessRankLayer:_updateMainView()
	local var_6_0 = self._themeGuessData:getPhaseGuessInfo(self._phase)

	if var_6_0 then
		self.m_tabController:setSelectedIndex(math.max(0, var_6_0.index - 1))
	end

	self._rankData = self._phaseRankData[self._themeGuessData:getIndexPhase(self._phase)]

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
		local var_6_1 = self._themeGuessData:getPhaseGuessInfo(iter_6_0)

		if var_6_1 then
			self["m_phaseTab" .. iter_6_0]:setTitle(var_6_1.phase_name)
		end
	end
end

function ThemeGuessRankLayer:_onRankListRenderer(arg_7_1, arg_7_2)
	if self._rankData.rank[arg_7_1 + 1] then
		arg_7_2:updateRankCell(self._rankData.rank[arg_7_1 + 1])
	end
end

function ThemeGuessRankLayer:_onChangeTabCtrl()
	self._rankData = self._phaseRankData[self._themeGuessData:getIndexPhase(self.m_tabController:getSelectedIndex() + 1)]

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
end

return ThemeGuessRankLayer
