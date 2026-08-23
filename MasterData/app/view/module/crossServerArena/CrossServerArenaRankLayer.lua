local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.crossServerArenaData
local var_0_3 = g.core.const.ConstMgr.CrossServerArenaConst

local function var_0_4(arg_1_0)
	return arg_1_0 + 1
end

local CrossServerArenaRankLayer = class("CrossServerArenaRankLayer", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaRankLayer"), function()
	return fgui.GComponent:create({
		resName = "CrossServerArenaRankLayer",
		pkgPath = "ui/crossServerArena/crossServerArena",
		isFullScreen = true,
		pkgName = "crossServerArena"
	})
end)

function CrossServerArenaRankLayer:ctor()
	self:_initData()
	self:_initList()
	self:_initView()
end

function CrossServerArenaRankLayer:_initData()
	self._rankList = {}
	self._dayAwardList = var_0_2:getDayAwardList() or {}
	self._seasonAwardList = var_0_2:getSeasonAwardList() or {}
end

function CrossServerArenaRankLayer:_initList()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
	self.m_dayAwardList:setVirtual()
	self.m_dayAwardList:setItemRenderer(handler(self, self._onRenderDayAwardList))
	self.m_seasonAwardList:setVirtual()
	self.m_seasonAwardList:setItemRenderer(handler(self, self._onRenderSeasonAwardList))
	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
end

function CrossServerArenaRankLayer:_initView()
	self:addBg("bg/common/pic_bb_beijing.jpg")

	local var_6_0 = var_0_2:getCurRank()

	self.m_rankText:setText(var_6_0 <= 0 and g.core.lang:get(302501) or var_6_0)

	self._rankList = var_0_2:getRankList()

	self.m_rankList:setNumItems(#self._rankList)
end

function CrossServerArenaRankLayer:_onRenderRankList(arg_7_1, arg_7_2)
	local var_7_0 = var_0_4(arg_7_1)

	if self._rankList[var_7_0].robot_base_id and self._rankList[var_7_0].robot_base_id > 0 then
		self._rankList[var_7_0].snapshot = var_0_2:createRobotSnapshot((g.core.config.chief_arena_robot_info.get(self._rankList[var_7_0].robot_base_id)))
	end

	arg_7_2:updateCell(var_7_0, self._rankList[var_7_0])
end

function CrossServerArenaRankLayer:_onRenderDayAwardList(arg_8_1, arg_8_2)
	local var_8_0 = var_0_4(arg_8_1)

	arg_8_2:updateCell(var_8_0, self._dayAwardList:at(var_8_0))
end

function CrossServerArenaRankLayer:_onRenderSeasonAwardList(arg_9_1, arg_9_2)
	arg_9_2:updateCell(arg_9_1 + 1, self._seasonAwardList:at(arg_9_1 + 1))
end

function CrossServerArenaRankLayer:_onArenaGetRankList()
	self._rankList = var_0_2:getRankList()

	self.m_rankList:setNumItems(#self._rankList)
end

function CrossServerArenaRankLayer:_onTabSelChanged()
	local var_11_0 = self.m_tabSelController:getSelectedIndex()

	if var_11_0 == var_0_3.CTRL_TAB_RANK then
		self.m_rankList:setNumItems(#self._rankList)
		self.m_rankList:transitionShowCells("enter_left", 0.03)
	elseif var_11_0 == var_0_3.CTRL_TAB_DAY_AWARD then
		self.m_dayAwardList:setNumItems(self._dayAwardList:getLength())
		self.m_dayAwardList:transitionShowCells("enter_left", 0.03)
	elseif var_11_0 == var_0_3.CTRL_TAB_SEASON_AWARD then
		self.m_tipsText:setText(var_0_2:getEndTimeString())
		self.m_seasonAwardList:setNumItems(self._seasonAwardList:getLength())
		self.m_seasonAwardList:transitionShowCells("enter_left", 0.03)
	end
end

function CrossServerArenaRankLayer:_onCrossDayUpdate()
	if var_0_2:getSeasonStatus() == var_0_3.CTRL_NONE_SEASON then
		g.core.module.ModuleManager:popToRoot()

		return
	end
end

function CrossServerArenaRankLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_CHIEF_ARENA_GETRANKLIST, self._onArenaGetRankList, self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	g.core.network.GameNetProxy:send_C2S_ChiefArena_GetRankList({})
end

return CrossServerArenaRankLayer
