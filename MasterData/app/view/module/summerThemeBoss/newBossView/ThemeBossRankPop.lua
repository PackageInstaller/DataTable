local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.event
local var_0_2 = g.core.const.ConstMgr.ThemeConst
local var_0_3 = g.core.config.activity_theme_display_info
local var_0_4 = 0
local var_0_5 = 1
local ThemeBossRankPop = class("ThemeBossRankPop", require("app.fairyGUI.summerThemeBoss.UI_ThemeBossRankPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/summerThemeBoss/summerThemeBoss",
		isFullScreen = true,
		pkgName = "summerThemeBoss",
		resName = var_0_2.THEME_ACTIVITY_BOSS_RANK_POP[2]
	})
end)

function ThemeBossRankPop:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_2.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_2.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._playListCellAni = true
	self._totalScoreArr = nil
	self._totalRewardArr = nil
	self._selfRank = 0
	self._themeBossData = nil
	self._userSnapShotDict = {}

	self:initData()
	self:initView()
end

function ThemeBossRankPop:onLoad()
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_NET_S2C_DEMON_BOSS_GETRANKLIST, handler(self, self._onNetGetRankList), self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CGetUserSnapShot), self)
	self._themeBossData:requestAutoBossRankInfo()
end

function ThemeBossRankPop:initData()
	self._themeBossData = var_0_0:getThemeData(self._activeThemeValue):getBossData()
	self._totalRewardArr = self._themeBossData.totalRewardArr
	self._displayInfo = var_0_3.get(self._activeThemeValue)
end

function ThemeBossRankPop:initView()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_topBarComp:setResInfoById(self._displayInfo.boss_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.boss_name)

	local var_5_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_5_1 = self.m_rankList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_5_0.x > 0 then
		var_5_1 = var_5_1 - var_5_0.x * 2
	end

	self.m_rankList:setWidth(var_5_1)
	self.m_topBg:setWidth(var_5_1)
	self.m_downBg:setWidth(var_5_1)
	self.m_lineBg:setWidth(var_5_1)
	self.m_rankList:setVirtual()
	self.m_rankList:setItemProvider(handler(self, self._onRankItemProvider))
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
	self.m_mainTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onMainTabRankChange))
end

function ThemeBossRankPop:_onCrossDayUpdate()
	self._themeBossData = var_0_0:getThemeData(self._activeThemeValue):getBossData()
	self._totalRewardArr = self._themeBossData.totalRewardArr

	if self.m_mainTabController:getSelectedIndex() == 1 then
		self.m_rankList:setNumItems(#self._totalRewardArr)
	end
end

function ThemeBossRankPop:_onRankItemProvider(arg_7_1)
	if self.m_mainTabController:getSelectedIndex() == var_0_4 then
		return "ui://summerThemeBoss/ThemeBossRankScoreCell"
	else
		return "ui://summerThemeBoss/ThemeBossRankRewardCell"
	end
end

function ThemeBossRankPop:_onRenderRankList(arg_8_1, arg_8_2)
	local var_8_0 = self.m_mainTabController:getSelectedIndex() == var_0_4 and self._totalScoreArr or self._totalRewardArr

	if var_8_0 then
		arg_8_2:refreshRankCell(var_8_0[arg_8_1 + 1], arg_8_1 + 1, self._userSnapShotDict[var_8_0[arg_8_1 + 1].id or 0])
	end
end

function ThemeBossRankPop:_refreshListView()
	local var_9_0 = 0

	var_9_0 = self.m_mainTabController:getSelectedIndex() == var_0_4 and (self._totalScoreArr ~= nil and #self._totalScoreArr or 0) or #self._totalRewardArr

	if self._selfRank == 0 then
		self.m_numTxt:setText(g.core.lang:get(113014))
	else
		self.m_numTxt:setText(self._selfRank)
	end

	if var_9_0 == 0 then
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)
		self.m_rankList:setNumItems(var_9_0)

		if self._playListCellAni then
			self.m_rankList:transitionShowCells("enter_up", 0.03)

			self._playListCellAni = false
		end
	end
end

function ThemeBossRankPop:_onMainTabRankChange(arg_10_1)
	self._playListCellAni = true

	self:_refreshListView()
end

function ThemeBossRankPop:_onNetGetRankList(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if self.m_mainTabController:getSelectedIndex() == var_0_5 then
		return
	end

	if arg_11_4.id == self._activeThemeValue then
		self._totalScoreArr = arg_11_4.rank_units or {}
		self._selfRank = arg_11_4.self_rank

		table.sort(self._totalScoreArr, function(arg_12_0, arg_12_1)
			return arg_12_0.rank < arg_12_1.rank
		end)

		local var_11_0 = {}

		for iter_11_0, iter_11_1 in ipairs(self._totalScoreArr) do
			table.insert(var_11_0, iter_11_1.id)
		end

		if #var_11_0 > 0 then
			g.core.network.GameNetProxy:send_C2S_GetUserSnapShot({
				user_ids = var_11_0
			})
		else
			self:_refreshListView()
		end
	end
end

function ThemeBossRankPop:_onS2CGetUserSnapShot(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self._userSnapShotDict = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_4.snapshots or {}) do
		self._userSnapShotDict[iter_13_1.id] = iter_13_1
	end

	self:_refreshListView()
end

return ThemeBossRankPop
