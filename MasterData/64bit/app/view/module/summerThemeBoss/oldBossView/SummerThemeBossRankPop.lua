local var_0_0 = g.core.event
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local var_0_2 = g.core.config.activity_theme_display_info
local var_0_3 = g.core.model.User.themeData
local var_0_4 = 0
local var_0_6 = 0
local SummerThemeBossRankPop = class("SummerThemeBossRankPop", require("app.fairyGUI.summerThemeBoss.UI_SummerThemeBossRankPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/summerThemeBoss/summerThemeBoss",
		isFullScreen = true,
		pkgName = "summerThemeBoss",
		resName = var_0_1.THEME_ACTIVITY_BOSS_RANK_POP[1]
	})
end)

function SummerThemeBossRankPop:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_1.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_1.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._playListCellAni = true
	self._dayScoreArr = nil
	self._dayRewardArr = nil
	self._totalScoreArr = nil
	self._totalRewardArr = nil
	self._themeBossData = nil
	self._userSnapShotDict = {}
	self._selfRankDayScore = 0
	self._selfRankTotalScore = 0

	self:initDamageRank()
end

function SummerThemeBossRankPop:onLoad()
	self:_initRegisterUI()
	self._themeBossData:requestBossRankInfo()
	self:_changeMainTabUI()
	self:_changeSubTabUI()
	self:_refreshListView()
end

function SummerThemeBossRankPop:initDamageRank()
	self:_initDamageRankData()
	self:_initDamageRankUI()
end

function SummerThemeBossRankPop:_initDamageRankData()
	self._themeBossData = var_0_3:getThemeData(self._activeThemeValue):getBossData()
	self._dayRewardArr = self._themeBossData.dayRewardArr
	self._totalRewardArr = self._themeBossData.totalRewardArr
end

function SummerThemeBossRankPop:_initDamageRankUI()
	self:addBg("bg/common/pic_bb_beijing.jpg")

	self._displayInfo = var_0_2.get(self._activeThemeValue)

	self.m_topBarComp:setResInfoById(self._displayInfo.boss_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.boss_name)
	self.m_mainTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onMainTabRankChange))
	self.m_subTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSubTabRankChange))
	self.m_rankList:setVirtual()
	self.m_rankList:setItemProvider(handler(self, self._onRankItemTempl))
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
	self.m_subTabController:setSelectedIndex(1)
end

function SummerThemeBossRankPop:_initRegisterUI()
	var_0_0.EventManager:addEventListener(var_0_0.enum.EVENT_NET_S2C_DEMON_BOSS_GETRANKLIST, self._onNetGetRankList, self)
	var_0_0.EventManager:addEventListener(var_0_0.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CGetUserSnapShot), self)
end

function SummerThemeBossRankPop:_onRankItemTempl(arg_8_1)
	if self.m_mainTabController:getSelectedIndex() == var_0_4 then
		return "ui://summerThemeBoss/ThemeBossRankScoreCell"
	else
		return "ui://summerThemeBoss/ThemeBossRankRewardCell"
	end
end

function SummerThemeBossRankPop:_onRenderRankList(arg_9_1, arg_9_2)
	local var_9_0 = self.m_subTabController:getSelectedIndex()
	local var_9_1 = self.m_mainTabController:getSelectedIndex() == var_0_4 and (var_9_0 == var_0_6 and self._totalScoreArr or self._dayScoreArr) or var_9_0 == var_0_6 and self._totalRewardArr or self._dayRewardArr

	if var_9_1 then
		arg_9_2:refreshRankCell(var_9_1[arg_9_1 + 1], arg_9_1 + 1, self._userSnapShotDict[var_9_1[arg_9_1 + 1].id or 0])
	end
end

function SummerThemeBossRankPop:_refreshListView()
	local var_10_0 = self.m_subTabController:getSelectedIndex()
	local var_10_1 = 0

	var_10_1 = self.m_mainTabController:getSelectedIndex() == var_0_4 and (var_10_0 == var_0_6 and (self._totalScoreArr ~= nil and #self._totalScoreArr or 0) or self._dayScoreArr ~= nil and #self._dayScoreArr or 0) or var_10_0 == var_0_6 and #self._totalRewardArr or #self._dayRewardArr

	if var_10_1 == 0 then
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)
		self.m_rankList:setNumItems(var_10_1)

		if self._playListCellAni then
			self.m_rankList:transitionShowCells("enter_up", 0.03)

			self._playListCellAni = false
		end
	end
end

function SummerThemeBossRankPop:_changeMainTabUI()
	if self.m_mainTabController:getSelectedIndex() == var_0_4 then
		self.m_totalTab:setTitle(g.core.lang:get(405701))
		self.m_oneTab:setTitle(g.core.lang:get(405702))
	else
		self.m_totalTab:setTitle(g.core.lang:get(405701))
		self.m_oneTab:setTitle(g.core.lang:get(405702))
	end
end

function SummerThemeBossRankPop:_changeSubTabUI()
	local var_12_0 = 0

	if self.m_subTabController:getSelectedIndex() == var_0_6 then
		var_12_0 = self._selfRankTotalScore

		self.m_tipsTxt:setText(g.core.lang:get(405706))
	else
		var_12_0 = self._selfRankDayScore

		self.m_tipsTxt:setText(g.core.lang:get(405705))
	end

	if var_12_0 <= 0 then
		var_12_0 = g.core.lang:get(113014)
	end

	self.m_numTxt:setText(var_12_0)
end

function SummerThemeBossRankPop:_onMainTabRankChange(arg_13_1)
	self._playListCellAni = true

	self:_changeMainTabUI()
	self:_refreshListView()
end

function SummerThemeBossRankPop:_onSubTabRankChange(arg_14_1)
	self._playListCellAni = true

	self:_changeSubTabUI()
	self:_refreshListView()
end

function SummerThemeBossRankPop:_onNetGetRankList(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_3.id == self._activeThemeValue then
		if arg_15_3.rank_type == 0 then
			self._dayScoreArr = arg_15_3.rank_units or {}
			self._selfRankDayScore = arg_15_3.self_rank

			table.sort(self._dayScoreArr, function(arg_16_0, arg_16_1)
				return arg_16_0.rank < arg_16_1.rank
			end)

			local var_15_0 = {}

			for iter_15_0, iter_15_1 in ipairs(self._dayScoreArr) do
				table.insert(var_15_0, iter_15_1.id)
			end

			if #var_15_0 == 0 then
				self:_refreshListView()

				return
			end

			g.core.network.GameNetProxy:send_C2S_GetUserSnapShot({
				user_ids = var_15_0
			})
			self:_changeSubTabUI()
		elseif arg_15_3.rank_type == 1 then
			self._totalScoreArr = arg_15_3.rank_units or {}
			self._selfRankTotalScore = arg_15_3.self_rank

			table.sort(self._totalScoreArr, function(arg_17_0, arg_17_1)
				return arg_17_0.rank < arg_17_1.rank
			end)

			local var_15_1 = {}

			for iter_15_2, iter_15_3 in ipairs(self._totalScoreArr) do
				table.insert(var_15_1, iter_15_3.id)
			end

			if #var_15_1 == 0 then
				self:_refreshListView()

				return
			end

			g.core.network.GameNetProxy:send_C2S_GetUserSnapShot({
				user_ids = var_15_1
			})
			self:_changeSubTabUI()
		end
	end
end

function SummerThemeBossRankPop:_onS2CGetUserSnapShot(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	for iter_18_0, iter_18_1 in ipairs(arg_18_4.snapshots or {}) do
		self._userSnapShotDict[iter_18_1.id] = iter_18_1
	end

	self:_refreshListView()
end

return SummerThemeBossRankPop
