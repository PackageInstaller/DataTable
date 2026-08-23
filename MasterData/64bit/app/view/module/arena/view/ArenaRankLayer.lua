local var_0_0 = g.core.const.ConstMgr.ArenaConst
local ArenaRankLayer = class("ArenaRankLayer", require("app.fairyGUI.arena.UI_ArenaRankLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/arena/arena",
		resName = "ArenaRankLayer",
		pkgName = "arena",
		isFullScreen = true
	})
end)

function ArenaRankLayer:ctor()
	self._myAwardList = {}
	self._rankList = {}
	self._awardList = nil
	self._arenaData = g.core.model.User.arenaData

	self:addBg("bg/common/pic_bb_beijing.jpg")
	self:_initListView()
	self:_initView()
end

function ArenaRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARENA_GETRANKLIST, self._onArenaGetRankList, self)
	g.core.network.GameNetProxy:send_C2S_Arena_GetRanklist({})
end

function ArenaRankLayer:_initListView()
	self.m_myAwardList:setVirtual()
	self.m_myAwardList:setItemRenderer(handler(self, self._onRenderMyAwardList))
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
end

function ArenaRankLayer:_onRenderMyAwardList(arg_5_1, arg_5_2)
	arg_5_2:updateByTVS(self._myAwardList[arg_5_1 + 1])
end

function ArenaRankLayer:_onRenderRankList(arg_6_1, arg_6_2)
	arg_6_2:updateCell(arg_6_1 + 1, self._rankList[arg_6_1 + 1])
end

function ArenaRankLayer:_onRenderAwardList(arg_7_1, arg_7_2)
	arg_7_2:updateCell(arg_7_1 + 1, (self._awardList:at(arg_7_1 + 1)))
end

function ArenaRankLayer:_initView()
	local var_8_0 = self._arenaData:getRank()

	self.m_rankText:setText(var_8_0 or g.core.lang:get(302501))

	local var_8_1 = var_8_0 and var_8_0 <= var_0_0.HAVE_AWARD_RANK

	self.m_isHaveAwardController:setSelectedIndex((var_8_0 and var_8_0 <= var_0_0.HAVE_AWARD_RANK or nil) and (var_0_0.CTRL_HAVE_AWARD or var_0_0.CTRL_NO_AWARD))

	if var_8_1 then
		self._myAwardList = {}

		local var_8_2 = self._arenaData:getRankRewardList():getRewardByRank()

		if var_8_2 then
			for iter_8_0 = 1, var_0_0.MAX_AWARD_NUM do
				if var_8_2["reward_type" .. iter_8_0] ~= 0 then
					table.insert(self._myAwardList, {
						type = var_8_2["reward_type" .. iter_8_0],
						value = var_8_2["reward_value" .. iter_8_0],
						size = var_8_2["reward_size" .. iter_8_0]
					})
				end
			end
		end

		self.m_myAwardList:setNumItems(#self._myAwardList)
	end
end

function ArenaRankLayer:_onTabSelChanged()
	local var_9_0 = self.m_tabSelController:getSelectedIndex()

	if var_9_0 == var_0_0.CTRL_TAB_AWARD then
		if not self._awardList then
			self._awardList = self._arenaData:getRankRewardList()

			self.m_awardList:setNumItems(self._awardList:getLength())
		end

		self.m_awardList:transitionShowCells("enter_left", 0.03)
	elseif var_9_0 == var_0_0.CTRL_TAB_RANK then
		self.m_rankList:transitionShowCells("enter_left", 0.03)
	end
end

function ArenaRankLayer:_onArenaGetRankList(arg_10_1, arg_10_2, arg_10_3)
	self._rankList = arg_10_3.users

	table.sort(self._rankList, function(arg_11_0, arg_11_1)
		return arg_11_0.rank < arg_11_1.rank
	end)
	self.m_rankList:setNumItems(#self._rankList)
	self.m_rankList:transitionShowCells("enter_left", 0.03)
end

return ArenaRankLayer
