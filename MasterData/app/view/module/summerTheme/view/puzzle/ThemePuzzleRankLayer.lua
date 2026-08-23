local ThemePuzzleRankLayer = class("ThemePuzzleRankLayer", require("app.fairyGUI.summerThemeGame.UI_ThemePuzzleRankLayer"), function()
	return fgui.GComponent:create({
		resName = "ThemePuzzleRankLayer",
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		isFullScreen = true,
		pkgName = "summerThemeGame"
	}, ...)
end)
local var_0_1 = g.core.model.User.themeData

function ThemePuzzleRankLayer:ctor(arg_2_1)
	self._activeThemeValue = arg_2_1 and arg_2_1.themeValue
	self._themePuzzleData = var_0_1:getThemeData(self._activeThemeValue):getThemePuzzleData()
	self._phase = self._themePuzzleData:getCurPhase()
	self._phaseRankData = {}

	self:_initRegisterUI()
end

function ThemePuzzleRankLayer:_initRegisterUI()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankListRenderer))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
end

function ThemePuzzleRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvCommonRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onRcvCommonRank, self)

	for iter_4_0, iter_4_1 in pairs((self._themePuzzleData:getPhaseRankIds())) do
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 50,
			id = iter_4_1.num
		})
	end

	self:_updateMainView()
end

function ThemePuzzleRankLayer:_onRcvCommonRank(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = self._themePuzzleData:getPhaseIdByRankId(arg_5_3.id)

	if var_5_0 then
		self._phaseRankData[var_5_0] = self._phaseRankData[var_5_0] or {}

		local var_5_1 = clone(arg_5_3.rank_units)
		local var_5_2 = self._themePuzzleData:getPhasePuzzleInfo(var_5_0).base_time

		for iter_5_0 = 1, #var_5_1 do
			var_5_1[iter_5_0].score = g.core.lang:get(405802, {
				time = var_5_2 - var_5_1[iter_5_0].score
			})
		end

		self._phaseRankData[var_5_0] = {
			rank = var_5_1,
			myRank = arg_5_3.self_rank
		}
	end

	self:_updateMainView()
end

function ThemePuzzleRankLayer:_updateMainView()
	local var_6_0 = self._themePuzzleData:getPhasePuzzleInfo(self._phase)

	if var_6_0 then
		self.m_tabController:setSelectedIndex(math.max(0, var_6_0.rank_idx - 1))
	end

	self._rankData = self._phaseRankData[self._phase]

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
		local var_6_1 = self._themePuzzleData:getPhasePuzzleInfo(iter_6_0)

		if var_6_1 then
			self["m_phaseTab" .. iter_6_0]:setTitle(var_6_1.phase_name)
		end
	end
end

function ThemePuzzleRankLayer:_onRankListRenderer(arg_7_1, arg_7_2)
	if self._rankData.rank[arg_7_1 + 1] then
		arg_7_2:updateRankCell(self._rankData.rank[arg_7_1 + 1])
	end
end

function ThemePuzzleRankLayer:_onChangeTabCtrl()
	self._phase = self.m_tabController:getSelectedIndex() + 1
	self._rankData = self._phaseRankData[self._phase]

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

return ThemePuzzleRankLayer
