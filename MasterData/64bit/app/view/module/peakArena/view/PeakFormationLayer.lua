local var_0_0 = g.core.const.ConstMgr.LineUpConst.MulTeamType.PEAK_ARENA
local var_0_1 = 5
local var_0_2 = g.core.common.ServerTime
local var_0_3 = g.core.model.User.peakArenaData
local var_0_4 = g.core.model.User.mulFormationData
local var_0_5 = g.core.module.ModuleManager
local PeakFormationLayer = class("PeakFormationLayer", require("app.fairyGUI.peakArena.UI_PeakFormationLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/peakArena/peakArena",
		resName = "PeakFormationLayer",
		pkgName = "peakArena"
	}, ...)
end)

function PeakFormationLayer:ctor(arg_2_1)
	self._timerHandler = nil
	self._cdHandler = nil

	self.m_topBarComp:setResInfoById(301)
	self.m_topBarComp:setReturnCallBack(handler(self, self._onClickBack))
	self.m_topBarComp:setHomeCallBack(handler(self, self.onClickHome))

	self._formationIndex = 1
	self._defaultFormationNum = 3
	self._cdTime = 0
	self._canLineUp = false
	self._tabCellNode = {}

	self:_initView()
	self.m_teamComp:addBgByName()
	var_0_3:saveMulTeamEditBtnNewPointShowedState()
end

function PeakFormationLayer:_onClickBack()
	self:_checkCloseLayer((handler(self, function()
		self.m_topBarComp:checkFullPageExitAnim()
	end)))
end

function PeakFormationLayer:onClickHome()
	self:_checkCloseLayer((handler(self, function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
		var_0_5:switchModuleIntelligent(g.view.entrance.HOME)
	end)))
end

function PeakFormationLayer:_checkCloseLayer(arg_7_1)
	self:dispatchCompEvent("CompEventCloseFormationLayer")

	local function var_7_0()
		if self._formationSaved then
			g.core.network.GameNetProxy:send_C2S_PeakArena_GetFinalInfo({})
		end

		arg_7_1()
	end

	local var_7_1

	if not var_0_4:isModified(var_0_0) then
		var_7_0()

		do return end

		var_7_1 = {
			title = g.core.lang:get(302032),
			desc = g.core.lang:get(308034),
			onCancel = var_7_0
		}
	end

	var_7_1.onConfirm = handler(self, function(arg_9_0)
		if not arg_9_0._canLineUp then
			var_0_5:tip(g.core.lang:get(307060))
		elseif arg_9_0._cdTime > 0 then
			var_0_5:tip(g.core.lang:get(2502))
		else
			arg_9_0.m_teamComp:sendC2SFormationSave()
		end

		var_7_0()
	end)

	var_0_5:pushPopup(require("app.view.base.pop.BaseConfirmPop").new(var_7_1))
end

function PeakFormationLayer:onLoad()
	self:_updateFormationView()

	self._formationSaved = false

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, self._onSaveSucc, self)
	self:_updateTime()

	if var_0_3:getFormationCD() > 0 then
		self._timerHandler = self:newSchedule(handler(self, self._cd), 1)
	end
end

function PeakFormationLayer:onUnload()
	if self._timerHandler then
		self:cancelSchedule(self._timerHandler)

		self._timerHandler = nil
	end

	if self._cdHandler then
		self:cancelSchedule(self._cdHandler)

		self._cdHandler = nil
	end
end

function PeakFormationLayer:_initView()
	self.m_tabList:setVirtual()
	self.m_tabList:doFairyBatching(false)
	self.m_tabList:setItemRenderer(handler(self, self._renderTabItem))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickFormationTab))
	self.m_saveBtn:addClickListener(handler(self, self._onClickSaveBtn))
	self.m_tabList:setNumItems(self._defaultFormationNum)
	self.m_tabList:setSelectedIndex(self._formationIndex - 1)
end

function PeakFormationLayer:_updateTime()
	local var_13_0 = var_0_3:getFormationCD()

	if var_13_0 > 0 then
		self.m_timeText:setText(var_0_2:_secondToString(var_13_0))

		self._canLineUp = true
	else
		self.m_timeText:setText("00:00:00")

		self._canLineUp = false

		if self._timerHandler then
			self:cancelSchedule(self._timerHandler)

			self._timerHandler = nil
		end

		var_0_5:tip(g.core.lang:get(307062))
		var_0_5:popAllPopup()
	end
end

function PeakFormationLayer:_cd()
	self:_updateTime()
end

function PeakFormationLayer:_renderTabItem(arg_15_1, arg_15_2)
	arg_15_2:updateView({
		index = arg_15_1 + 1,
		selectIndex = self._formationIndex
	})
	table.insert(self._tabCellNode, arg_15_2)
end

function PeakFormationLayer:_onClickSaveBtn()
	if not self._canLineUp then
		var_0_5:tip(g.core.lang:get(307060))
	elseif self._cdTime > 0 then
		var_0_5:tip(g.core.lang:get(2502))
	elseif not var_0_4:isModified(var_0_0) then
		var_0_5:tip(g.core.lang:get(307058))
	else
		self.m_teamComp:sendC2SFormationSave()
	end
end

function PeakFormationLayer:_onClickFormationTab(arg_17_1)
	local var_17_0 = arg_17_1:getDataValue()

	if var_17_0 + 1 == self._formationIndex then
		return
	end

	self._formationIndex = var_17_0 + 1

	self:_updateFormationView()
	self._tabCellNode[self._formationIndex]:playEffectAnimation()
end

function PeakFormationLayer:_updateFormationView()
	self.m_teamComp:updateComp(var_0_0, self._formationIndex)
	self:updatePreciousSuitBtn()
	self.m_teamComp:playAnimation()
end

function PeakFormationLayer:updatePreciousSuitBtn()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS) then
		if not self._preciousSuitBtn then
			self._preciousSuitBtn = fgui.UIPackage:createObject("base_new", "BasePreciousSuitBtn")

			self:addChild(self._preciousSuitBtn)
			self._preciousSuitBtn:setPosition(display.width - 126 - cc.Director:getInstance():getSafeAreaRect().x, display.height - 424)
		end

		self._preciousSuitBtn:setBtnFormationData(var_0_0, self._formationIndex)
	end
end

function PeakFormationLayer:_onSaveSucc(arg_20_1, arg_20_2, arg_20_3)
	self._formationSaved = true

	if var_0_3:getFormationCD() > 0 and self._cdTime == 0 then
		self._cdTime = var_0_1
		self._cdHandler = self:newSchedule(handler(self, self._updateBtnTitle), 1)

		self.m_saveBtn:setTitle(g.core.lang:get(307057, {
			time = self._cdTime
		}))
	end

	var_0_5:tip(g.core.lang:get(307059))
end

function PeakFormationLayer:_updateBtnTitle()
	if self._cdTime > 0 then
		self.m_saveBtn:setTitle(g.core.lang:get(307057, {
			time = self._cdTime
		}))

		self._cdTime = self._cdTime - 1
	else
		self.m_saveBtn:setTitle(g.core.lang:get(307056))

		self._cdTime = 0

		if self._cdHandler then
			self:cancelSchedule(self._cdHandler)

			self._cdHandler = nil
		end
	end
end

return PeakFormationLayer
