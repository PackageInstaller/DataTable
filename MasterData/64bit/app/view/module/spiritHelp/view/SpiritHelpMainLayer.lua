local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.const.ConstMgr.SpineConst
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.model.User.spiritHelpData
local SpiritHelpMainLayer = class("SpiritHelpMainLayer", require("app.fairyGUI.spiritHelp.UI_SpiritHelpMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "spiritHelp",
		isFullScreen = true,
		pkgPath = "ui/spiritHelp/spiritHelp",
		resName = "SpiritHelpMainLayer"
	}, ...)
end)

function SpiritHelpMainLayer:ctor()
	self._doingList = {}
	self._playList = {}
	self._otherList = {}
	self._curDoingIndex = 0
	self._schedule = nil
	self._isPlayListTran = false

	self:initView()
	self.m_enterTransition:play()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.SPIRIT_HELP)
end

function SpiritHelpMainLayer:initView()
	self:addBg("bg/spiritHelp/bg_xiaozhushou.jpg")
	self.m_topBar:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.SPIRIT_HELP)
	self.m_playList:setVirtual()
	self.m_playList:setItemRenderer(handler(self, self._onPlayListRenderer))
	self.m_playList:setItemProvider(handler(self, self._onPlayListItemProvider))
	self.m_otherList:setVirtual()
	self.m_otherList:setItemRenderer(handler(self, self._onOtherListRenderer))
	self.m_otherList:setItemProvider(handler(self, self._onOtherListItemProvider))
	self:addListen(self.m_playList)
	self:addListen(self.m_otherList)
	self.m_historyBtn:addClickListener(handler(self, self._onClickHistoryBtn))
	self.m_startBtn:addClickListener(handler(self, self._onClickStartBtn))
	self.m_allSelectBtn:addClickListener(handler(self, self._onClickAllClickBtn))
	self.m_showCompController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCompChanged))

	self._showKnight = DrawKnight.new({
		isAlphaNode = true,
		isShowBg = true,
		scale = 0.8,
		resId = 400100
	})

	self.m_knightComp:addChild(self._showKnight)
	self._showKnight:setAlphaRect(var_0_1.MASK_TYPE.HORIZON, cc.rect(-500, 0, 900, 0), 150)
end

function SpiritHelpMainLayer:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "doing_pop_end" then
		self:updateScrollView()

		return true
	elseif arg_4_1 == "change_count_refresh" then
		self:updateAllCost()

		return true
	elseif arg_4_1 == "sub_select_change" then
		var_0_4:refreshAllDoBtnState()
		self.m_allSelectBtn:setSelected(var_0_4:getAllDoBtn())

		return true
	end
end

function SpiritHelpMainLayer:_onPlayListItemProvider(arg_5_1)
	return "ui://spiritHelp/" .. self._playList[arg_5_1 + 1]:getItemName()
end

function SpiritHelpMainLayer:_onOtherListItemProvider(arg_6_1)
	return "ui://spiritHelp/" .. self._otherList[arg_6_1 + 1]:getItemName()
end

function SpiritHelpMainLayer:_onPlayListRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateHelpCell(self._playList[arg_7_1 + 1])
end

function SpiritHelpMainLayer:_onOtherListRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateHelpCell(self._otherList[arg_8_1 + 1])
end

function SpiritHelpMainLayer:_onClickAllClickBtn()
	local var_9_0 = self.m_allSelectBtn:isSelected()

	var_0_4:setAllDoIsSelect(var_9_0)

	if var_9_0 then
		for iter_9_0, iter_9_1 in ipairs(((self.m_showCompController:getSelectedIndex() == 0 and self.m_playList or self.m_otherList):getChildren())) do
			iter_9_1:playAllSelectEffect()
		end
	end

	self:updateScrollView()
end

function SpiritHelpMainLayer:_onClickStartBtn()
	if #var_0_4:getCurDoingList() == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(409511))

		return
	end

	if var_0_0:secondsToTommorrow(var_0_0:getTime()) <= 20 or var_0_0:secondsFromToday() <= 5 then
		g.core.module.ModuleManager:tip(g.core.lang:get(409520))

		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.spiritHelp.view.SpiritHelpDoingPop").new(), {
		ignoreTouch = true,
		touchDisappear = false
	})
end

function SpiritHelpMainLayer:_onClickHistoryBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.spiritHelp.view.SpiritHelpHistoryPop").new()))
end

function SpiritHelpMainLayer:_onCompChanged()
	self:updateScrollView()
end

function SpiritHelpMainLayer:onLoad()
	var_0_3:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRIT_HELP_GETINFO, handler(self, self.onGetInfo), self)
	var_0_3:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
	g.core.network.GameNetProxy:send_C2S_SpiritHelp_GetInfo({})
end

function SpiritHelpMainLayer:_onCrossDay()
	g.core.network.GameNetProxy:send_C2S_SpiritHelp_GetInfo({})
end

function SpiritHelpMainLayer:onGetInfo()
	self:updateView()
	self.m_allSelectBtn:setSelected(var_0_4:getAllDoBtn())
	self.m_battleSpeed:updateView()
end

function SpiritHelpMainLayer:updateView()
	self._playList = {}
	self._otherList = {}

	for iter_16_0, iter_16_1 in pairs((var_0_4:getAllOpenDoList())) do
		table.insert((iter_16_1:getInfo().tab == 1 or nil) and (self._playList or self._otherList), iter_16_1)
	end

	self:updateScrollView()
	self:updateAllCost()
end

function SpiritHelpMainLayer:updateAllCost()
	local var_17_0 = var_0_4:getAllCostList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if self["m_cost" .. iter_17_0] then
			self["m_cost" .. iter_17_0]:updateByTVS(iter_17_1)
		else
			break
		end
	end

	self.m_allCostNumController:setSelectedIndex(math.clamp(#var_17_0, 0, 2))
end

function SpiritHelpMainLayer:updateScrollView()
	if self.m_showCompController:getSelectedIndex() == 0 then
		self.m_playList:setNumItems(#self._playList)

		if not self._isPlayListTran then
			self._isPlayListTran = true

			self.m_playList:transitionShowCells("enter_right", 0.03)
		end
	else
		self.m_otherList:setNumItems(#self._otherList)
	end
end

function SpiritHelpMainLayer:onRemoved()
	var_0_4:saveDoJsonData()
	var_0_4:saveSpeedJsonData()
end

return SpiritHelpMainLayer
