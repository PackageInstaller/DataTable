local var_0_0 = g.core.event
local var_0_1 = 0
local var_0_3 = 0
local var_0_4 = 1
local RebelDamageRankPop = class("RebelDamageRankPop", require("app.fairyGUI.rebel.UI_RebelDamageRankPop"), function()
	return fgui.GComponent:create({
		resName = "RebelDamageRankPop",
		pkgPath = "ui/rebel/rebel",
		isFullScreen = true,
		pkgName = "rebel"
	})
end)

function RebelDamageRankPop:ctor(arg_2_1)
	self._playListCellAni = true
	self._oneDamageArr = nil
	self._oneDamageRewardArr = nil
	self._totalDamageArr = nil
	self._totalDamageRewardArr = nil
	self._selfRankOneDamage = 0
	self._selfRankTotalDamage = 0

	self:initDamageRank()
end

function RebelDamageRankPop:onLoad()
	self:_initRegisterUI()
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 50,
		id = g.core.network.proto.REBEL_TOTAL
	})
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 50,
		id = g.core.network.proto.REBEL_MAX
	})
	self:_changeMainTabUI()
	self:_changeSubTabUI()
	self:_refreshListView()
end

function RebelDamageRankPop:initDamageRank()
	self:_initDamageRankData()
	self:_initDamageRankUI()
end

function RebelDamageRankPop:_initDamageRankData()
	self._oneDamageRewardArr = g.core.config.rank_award_info.match(function(arg_6_0)
		return arg_6_0.rank_type == 5
	end)
	self._totalDamageRewardArr = g.core.config.rank_award_info.match(function(arg_7_0)
		return arg_7_0.rank_type == 4
	end)
end

function RebelDamageRankPop:_initDamageRankUI()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_topBarComp:setResInfoById(37)
	self.m_mainTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onMainTabRankChange))
	self.m_subTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSubTabRankChange))
	self.m_rankList:setVirtual()
	self.m_rankList:setItemProvider(handler(self, self._onRankItemTempl))
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
end

function RebelDamageRankPop:_initRegisterUI()
	var_0_0.EventManager:addEventListener(var_0_0.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onNetGetRankList, self)
	var_0_0.EventManager:addEventListener(var_0_0.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._refreshListView, self)
end

function RebelDamageRankPop:_onRankItemTempl(arg_10_1)
	if self.m_mainTabController:getSelectedIndex() == var_0_1 then
		return "ui://rebel/RebelRankDamageCell"
	else
		return "ui://rebel/RebelRankRewardCell"
	end
end

function RebelDamageRankPop:_onRenderRankList(arg_11_1, arg_11_2)
	local var_11_0 = self.m_subTabController:getSelectedIndex()
	local var_11_1 = self.m_mainTabController:getSelectedIndex() == var_0_1 and (var_11_0 == var_0_3 and self._totalDamageArr or self._oneDamageArr) or var_11_0 == var_0_3 and self._totalDamageRewardArr or self._oneDamageRewardArr

	if var_11_1 then
		arg_11_2:refreshRankCell(var_11_1[arg_11_1 + 1], arg_11_1 + 1)
	end
end

function RebelDamageRankPop:_refreshListView()
	local var_12_0 = self.m_subTabController:getSelectedIndex()
	local var_12_1 = 0

	var_12_1 = self.m_mainTabController:getSelectedIndex() == var_0_1 and (var_12_0 == var_0_3 and (self._totalDamageArr ~= nil and #self._totalDamageArr or 0) or self._oneDamageArr ~= nil and #self._oneDamageArr or 0) or var_12_0 == var_0_3 and #self._totalDamageRewardArr or #self._oneDamageRewardArr

	if var_12_1 == 0 then
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)
		self.m_rankList:setNumItems(var_12_1)

		if self._playListCellAni then
			self.m_rankList:transitionShowCells("enter_up", 0.03)

			self._playListCellAni = false
		end
	end
end

function RebelDamageRankPop:_changeMainTabUI()
	if self.m_mainTabController:getSelectedIndex() == var_0_1 then
		self.m_totalTab:setTitle(g.core.lang:get(303510))
		self.m_oneTab:setTitle(g.core.lang:get(303511))
	else
		self.m_totalTab:setTitle(g.core.lang:get(303512))
		self.m_oneTab:setTitle(g.core.lang:get(303513))
	end
end

function RebelDamageRankPop:_changeSubTabUI()
	if self.m_subTabController:getSelectedIndex() == var_0_3 then
		self.m_numTxt:setText(self._selfRankTotalDamage)
	else
		self.m_numTxt:setText(self._selfRankOneDamage)
	end
end

function RebelDamageRankPop:_onMainTabRankChange(arg_15_1)
	self._playListCellAni = true

	self:_changeMainTabUI()
	self:_refreshListView()
end

function RebelDamageRankPop:_onSubTabRankChange(arg_16_1)
	self._playListCellAni = true

	self:_changeSubTabUI()
	self:_refreshListView()
end

function RebelDamageRankPop:_onNetGetRankList(arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_3.rank_units then
		return
	end

	local var_17_0 = self.m_mainTabController:getSelectedIndex()
	local var_17_1 = self.m_subTabController:getSelectedIndex()

	if arg_17_3.id == g.core.network.proto.REBEL_MAX then
		self._oneDamageArr = arg_17_3.rank_units
		self._selfRankOneDamage = arg_17_3.self_rank

		table.sort(self._oneDamageArr, function(arg_18_0, arg_18_1)
			return arg_18_0.rank < arg_18_1.rank
		end)
		self:_changeSubTabUI()

		if var_17_0 == var_0_1 and var_17_1 == var_0_4 then
			self:_refreshListView()
		end
	elseif arg_17_3.id == g.core.network.proto.REBEL_TOTAL then
		self._totalDamageArr = arg_17_3.rank_units
		self._selfRankTotalDamage = arg_17_3.self_rank

		table.sort(self._totalDamageArr, function(arg_19_0, arg_19_1)
			return arg_19_0.rank < arg_19_1.rank
		end)
		self:_changeSubTabUI()

		if var_17_0 == var_0_1 and var_17_1 == var_0_3 then
			self:_refreshListView()
		end
	end
end

return RebelDamageRankPop
