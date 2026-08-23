local var_0_0 = g.core.model.User.themeData
local ThemeTurnCardRankLayer = class("ThemeTurnCardRankLayer", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnCardRankLayer"), function()
	return fgui.GComponent:create({
		resName = "ThemeTurnCardRankLayer",
		pkgName = "summerThemeGame",
		isFullScreen = true,
		pkgPath = "ui/summerThemeGame/summerThemeGame"
	})
end)

function ThemeTurnCardRankLayer:ctor(arg_2_1)
	self._activeThemeValue = arg_2_1 and arg_2_1.themeValue
	self._turnCardData = var_0_0:getThemeData(self._activeThemeValue):getTurnCardData()
	self._phase = self._turnCardData:getCurTurnCardPhase()

	self:_initRegisterUI()
end

function ThemeTurnCardRankLayer:_initRegisterUI()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankListRenderer))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
end

function ThemeTurnCardRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvCommonRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onRcvCommonRank, self)
	self._turnCardData:sendTurnCardCommonRankInfo()
	self:_updateMainView()
end

function ThemeTurnCardRankLayer:_onRcvCommonRank(arg_5_1, arg_5_2, arg_5_3)
	self._turnCardData:onS2CTurnCardCommonRank(arg_5_3)
	self:_updateMainView()
end

function ThemeTurnCardRankLayer:_updateMainView()
	local var_6_0 = self._turnCardData:getPhaseCardInfo(self._phase)

	if var_6_0 then
		self.m_tabController:setSelectedIndex(math.max(0, var_6_0.rank_idx - 1))
	end

	self._rankData = self._turnCardData:getRankListData(self._phase)

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

	local var_6_1 = self._turnCardData:getPhaseStartId()

	for iter_6_0 = 1, 3 do
		local var_6_2 = self._turnCardData:getPhaseCardInfo(var_6_1 + iter_6_0 - 1)

		if var_6_2 then
			self["m_phaseTab" .. iter_6_0]:setTitle(var_6_2.phase_name)
		end
	end
end

function ThemeTurnCardRankLayer:_onRankListRenderer(arg_7_1, arg_7_2)
	if self._rankData.rank[arg_7_1 + 1] then
		arg_7_2:updateRankCell(self._rankData.rank[arg_7_1 + 1])
	end
end

function ThemeTurnCardRankLayer:_onChangeTabCtrl()
	local var_8_0 = self._turnCardData:getPhaseCfgByIndex(self.m_tabController:getSelectedIndex() + 1)

	if var_8_0 then
		self._phase = var_8_0.phase or 1
	end

	self._rankData = self._turnCardData:getRankListData(self._phase)

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

return ThemeTurnCardRankLayer
