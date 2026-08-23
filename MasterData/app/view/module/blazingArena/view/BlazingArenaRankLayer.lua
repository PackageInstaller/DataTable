local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.blazingArenaData
local BlazingArenaRankLayer = class("BlazingArenaRankLayer", require("app.fairyGUI.blazingArena.UI_BlazingArenaRankLayer"), function()
	return fgui.GComponent:create({
		resName = "BlazingArenaRankLayer",
		pkgPath = "ui/blazingArena/blazingArena",
		isFullScreen = true,
		pkgName = "blazingArena"
	}, ...)
end)

function BlazingArenaRankLayer:ctor(arg_2_1)
	self._rankList = {}
	self._seasonAwardList = var_0_1:getRankRewardList()
	self._myAwardList = {}

	self:_initListView()
	self:_initView()
end

function BlazingArenaRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_RANKLIST, self._updateRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateRankList, self)
	g.core.network.GameNetProxy:send_C2S_BlazingArena_RankList({})
end

function BlazingArenaRankLayer:_initView(arg_4_1)
	self:addBg("bg/common/pic_bb_beijing.jpg")

	local var_4_0 = var_0_1:getCurRank()

	self.m_rankText:setText(var_4_0 <= 0 and g.core.lang:get(113014) or var_4_0)
	self.m_tipsText:setText(g.core.lang:get(431422, {
		hour = var_0_0:getDateObject((var_0_1:getActivityShowTime())).hour
	}))
	self.m_tabSelController:setSelectedIndex(0)

	for iter_4_0 = 1, #self._seasonAwardList do
		if self._seasonAwardList[iter_4_0].minRank <= var_4_0 and var_4_0 <= self._seasonAwardList[iter_4_0].maxRank then
			self._myAwardList = self._seasonAwardList[iter_4_0].data

			self.m_myAwardList:setNumItems(#self._myAwardList)

			break
		end
	end
end

function BlazingArenaRankLayer:_initListView()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
	self.m_seasonAwardList:setVirtual()
	self.m_seasonAwardList:setItemRenderer(handler(self, self._onRenderSeasonAwardList))
	self.m_myAwardList:setVirtual()
	self.m_myAwardList:setItemRenderer(handler(self, self._onRenderMyAwardList))
	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
end

function BlazingArenaRankLayer:_onRenderRankList(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._rankList[arg_6_1 + 1], arg_6_1 + 1)
end

function BlazingArenaRankLayer:_onRenderSeasonAwardList(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._seasonAwardList[arg_7_1 + 1], arg_7_1 + 1)
end

function BlazingArenaRankLayer:_onRenderMyAwardList(arg_8_1, arg_8_2)
	self._myAwardList[arg_8_1 + 1].scaleIndex = 5

	arg_8_2:updateIcon(self._myAwardList[arg_8_1 + 1])
end

function BlazingArenaRankLayer:_onTabSelChanged()
	local var_9_0 = self.m_tabSelController:getSelectedIndex()

	if var_9_0 == 0 then
		self.m_rankList:setNumItems(#self._rankList)
		self.m_rankList:transitionShowCells("enter_left", 0.03)
	elseif var_9_0 == 1 then
		self.m_seasonAwardList:setNumItems(#self._seasonAwardList)
		self.m_seasonAwardList:transitionShowCells("enter_left", 0.03)
	end
end

function BlazingArenaRankLayer:_updateRankList()
	self._rankList = var_0_1:getRankList()

	self.m_rankList:setNumItems(#self._rankList)
end

return BlazingArenaRankLayer
