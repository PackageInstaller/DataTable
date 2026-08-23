local var_0_0 = g.core.model.User.themeData
local var_0_1 = g.core.event
local var_0_2 = g.core.const.ConstMgr.ThemeConst
local var_0_3 = g.core.config.activity_theme_display_info
local var_0_4 = 0
local var_0_5 = 1
local ThemeThirdBossRankPop = class("ThemeThirdBossRankPop", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossRankPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeThirdBossRankPop",
		pkgPath = "ui/summerThemeThirdBoss/summerThemeThirdBoss",
		isFullScreen = true,
		pkgName = "summerThemeThirdBoss"
	})
end)

function ThemeThirdBossRankPop:ctor(arg_2_1)
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

function ThemeThirdBossRankPop:onLoad()
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_NET_S2C_DEMON_BOSS_GETRANKLIST, handler(self, self._onNetGetRankList), self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CGetUserSnapShot), self)
	g.core.network.GameNetProxy:send_C2S_DemonBoss_GetRankList({
		size = 50,
		rank_type = 1,
		recruit_type = self._themeBossData:getRecruitType(),
		id = self._activeThemeValue
	})
end

function ThemeThirdBossRankPop:initData()
	self._themeBossData = var_0_0:getThemeData(self._activeThemeValue):getBossData()
	self._totalRewardArr = self._themeBossData:getTotalRanRewardList()
	self._displayInfo = var_0_3.get(self._activeThemeValue)
end

function ThemeThirdBossRankPop:initView()
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

function ThemeThirdBossRankPop:_onCrossDayUpdate()
	self._themeBossData = var_0_0:getThemeData(self._activeThemeValue):getBossData()

	self._themeBossData:refreshBossCrossDay()

	if self._themeBossData:getCurPhase() <= 0 then
		self:_timeEnd()

		return
	end

	self._totalRewardArr = self._themeBossData.totalRewardArr or {}

	if self.m_mainTabController:getSelectedIndex() == 1 then
		self.m_rankList:setNumItems(#self._totalRewardArr)
	end
end

function ThemeThirdBossRankPop:_timeEnd()
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function ThemeThirdBossRankPop:_onRankItemProvider(arg_8_1)
	if self.m_mainTabController:getSelectedIndex() == var_0_4 then
		return "ui://summerThemeThirdBoss/ThemeThirdBossRankScoreCell"
	else
		return "ui://summerThemeThirdBoss/ThemeThirdBossRankRewardCell"
	end
end

function ThemeThirdBossRankPop:_onRenderRankList(arg_9_1, arg_9_2)
	local var_9_0 = self.m_mainTabController:getSelectedIndex() == var_0_4 and self._totalScoreArr or self._totalRewardArr

	if var_9_0 then
		arg_9_2:refreshRankCell(var_9_0[arg_9_1 + 1], arg_9_1 + 1, self._userSnapShotDict[var_9_0[arg_9_1 + 1].id or 0])
	end
end

function ThemeThirdBossRankPop:_refreshListView()
	local var_10_0 = 0

	var_10_0 = self.m_mainTabController:getSelectedIndex() == var_0_4 and (self._totalScoreArr ~= nil and #self._totalScoreArr or 0) or #self._totalRewardArr

	if self._selfRank == 0 then
		self.m_numTxt:setText(g.core.lang:get(113014))
	else
		self.m_numTxt:setText(self._selfRank)
	end

	if var_10_0 == 0 then
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)
		self.m_rankList:setNumItems(var_10_0)

		if self._playListCellAni then
			self.m_rankList:transitionShowCells("enter_up", 0.03)

			self._playListCellAni = false
		end
	end
end

function ThemeThirdBossRankPop:_onMainTabRankChange(arg_11_1)
	self._playListCellAni = true

	self:_refreshListView()
end

function ThemeThirdBossRankPop:_onNetGetRankList(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if self.m_mainTabController:getSelectedIndex() == var_0_5 then
		return
	end

	if arg_12_4.id == self._activeThemeValue then
		self._totalScoreArr = arg_12_4.rank_units or {}
		self._selfRank = arg_12_4.self_rank

		table.sort(self._totalScoreArr, function(arg_13_0, arg_13_1)
			return arg_13_0.rank < arg_13_1.rank
		end)

		local var_12_0 = {}

		for iter_12_0, iter_12_1 in ipairs(self._totalScoreArr) do
			table.insert(var_12_0, iter_12_1.id)
		end

		if #var_12_0 > 0 then
			g.core.network.GameNetProxy:send_C2S_GetUserSnapShot({
				user_ids = var_12_0
			})
		else
			self:_refreshListView()
		end
	end
end

function ThemeThirdBossRankPop:_onS2CGetUserSnapShot(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self._userSnapShotDict = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_4.snapshots or {}) do
		self._userSnapShotDict[iter_14_1.id] = iter_14_1
	end

	self:_refreshListView()
end

return ThemeThirdBossRankPop
