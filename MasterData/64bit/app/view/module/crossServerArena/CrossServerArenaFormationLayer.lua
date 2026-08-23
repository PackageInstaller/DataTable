local var_0_0 = g.core.const.ConstMgr.LineUpConst.MulTeamType.CROSS_SERVER_ARENA
local var_0_1 = g.core.const.ConstMgr.CrossServerArenaConst
local var_0_2 = g.core.const.ConstMgr.CrossServerArenaConst.CD_TIME
local var_0_3 = g.core.model.User.crossServerArenaData
local var_0_4 = g.core.model.User.mulFormationData
local var_0_5 = g.core.module.ModuleManager
local CrossServerArenaFormationLayer = class("CrossServerArenaFormationLayer", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaFormationLayer"), function()
	return fgui.GComponent:create({
		pkgName = "crossServerArena",
		isFullScreen = true,
		pkgPath = "ui/crossServerArena/crossServerArena",
		resName = "CrossServerArenaFormationLayer"
	}, ...)
end)

function CrossServerArenaFormationLayer:ctor(arg_2_1)
	self._timerHandler = nil
	self._cdHandler = nil
	self._hasSave = true

	if arg_2_1 and arg_2_1.needSaveTip ~= nil then
		self._hasSave = arg_2_1.needSaveTip
	end

	self.m_topBarComp:setResInfoById(var_0_1.TOP_BAR_FORMATION_LAYER)
	self.m_topBarComp:setReturnCallBack(handler(self, self._onClickBack))
	self.m_topBarComp:setHomeCallBack(handler(self, self.onClickHome))

	self._formationIndex = 1
	self._cdTime = 0
	self._tabCellNode = {}

	self:_initView()
	self.m_teamComp:addBgByName()
	g.core.service.ServiceManager:getServiceByName("TipGuideService"):reset()
end

function CrossServerArenaFormationLayer:_onClickBack()
	self:_checkCloseLayer((handler(self, function()
		self.m_topBarComp:checkFullPageExitAnim()
	end)))
end

function CrossServerArenaFormationLayer:onClickHome()
	self:_checkCloseLayer((handler(self, function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
		var_0_5:switchModuleIntelligent(g.view.entrance.HOME)
	end)))
end

function CrossServerArenaFormationLayer:_checkCloseLayer(arg_7_1)
	self:dispatchCompEvent("CompEventCloseFormationLayer")

	local var_7_0

	if not var_0_4:isModified(var_0_0) then
		arg_7_1()

		do return end

		var_7_0 = {
			title = g.core.lang:get(302032),
			desc = g.core.lang:get(308034),
			onCancel = arg_7_1
		}
	end

	var_7_0.onConfirm = handler(self, function(arg_8_0)
		if arg_8_0._cdTime > 0 then
			var_0_5:tip(g.core.lang:get(2502))
		elseif var_0_3:isFormationValid() then
			arg_8_0.m_teamComp:sendC2SFormationSave()
		else
			var_0_5:tip(g.core.lang:get(411038))
		end

		arg_7_1()
	end)

	var_0_5:pushPopup(require("app.view.base.pop.BaseConfirmPop").new(var_7_0))
end

function CrossServerArenaFormationLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, self._onSaveSucc, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:_updateFormationView()
	self.m_enterTransition:play()
end

function CrossServerArenaFormationLayer:onUnload()
	if self._cdHandler then
		self:cancelSchedule(self._cdHandler)

		self._cdHandler = nil
	end
end

function CrossServerArenaFormationLayer:_initView()
	self.m_tabList:setVirtual()
	self.m_tabList:doFairyBatching(false)
	self.m_tabList:setItemRenderer(handler(self, self._renderTabItem))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickFormationTab))
	self.m_saveBtn:addClickListener(handler(self, self._onClickSaveBtn))
	self.m_tabList:setNumItems(var_0_1.FORMATION_NUM)
	self.m_tabList:setSelectedIndex(self._formationIndex - 1)
end

function CrossServerArenaFormationLayer:_renderTabItem(arg_12_1, arg_12_2)
	arg_12_2:updateView({
		index = arg_12_1 + 1,
		selectIndex = self._formationIndex
	})

	self._tabCellNode[arg_12_1 + 1] = arg_12_2
end

function CrossServerArenaFormationLayer:_onClickSaveBtn()
	if self._cdTime > 0 then
		var_0_5:tip(g.core.lang:get(2502))
	elseif not var_0_4:isModified(var_0_0) then
		var_0_5:tip(g.core.lang:get(307058))
	elseif g.core.model.User.crossServerArenaData:isFormationValid() then
		self.m_teamComp:sendC2SFormationSave()
	else
		var_0_5:tip(g.core.lang:get(411038))
	end
end

function CrossServerArenaFormationLayer:_onClickFormationTab(arg_14_1)
	local var_14_0 = arg_14_1:getDataValue()

	if var_14_0 + 1 == self._formationIndex then
		return
	end

	self._formationIndex = var_14_0 + 1

	self:_updateFormationView()
	self._tabCellNode[self._formationIndex]:playEffectAnimation()
end

function CrossServerArenaFormationLayer:_updateFormationView()
	self.m_teamComp:updateComp(var_0_0, self._formationIndex)
	self.m_teamComp:playAnimation()
	self:updatePreciousSuitBtn()

	local var_15_0 = var_0_3:getBuffInfo()

	if var_15_0 then
		local var_15_1, var_15_2 = var_0_3:getBuffGroupAndTalentSkillInfo(var_15_0.buff)

		self.m_buffGroupController:setSelectedIndex(var_15_1)
		self:addBg(g.core.common.Path:getChiefArenaBg(var_15_0.pic))
		self.m_buffTxt:enableRich()
		self.m_buffTxt:setText(g.core.lang:get(411033, {
			name = var_15_2.name,
			num = var_15_2.affect_value_1 / 10
		}))
	end
end

function CrossServerArenaFormationLayer:updatePreciousSuitBtn()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS) then
		if not self._preciousSuitBtn then
			self._preciousSuitBtn = fgui.UIPackage:createObject("base_new", "BasePreciousSuitBtn")

			self:addChild(self._preciousSuitBtn)
			self._preciousSuitBtn:setPosition(display.width - 126 - cc.Director:getInstance():getSafeAreaRect().x, display.height - 424)
		end

		self._preciousSuitBtn:setBtnFormationData(var_0_0, self._formationIndex)
	end
end

function CrossServerArenaFormationLayer:_onSaveSucc(arg_17_1, arg_17_2, arg_17_3)
	if self._cdTime == 0 then
		self._cdTime = var_0_2
		self._cdHandler = self:newSchedule(handler(self, self._updateBtnTitle), 1)

		self.m_saveBtn:setTitle(g.core.lang:get(307057, {
			time = self._cdTime
		}))
	end

	if self._hasSave then
		var_0_5:tip(g.core.lang:get(307059))
	else
		self._hasSave = true
	end
end

function CrossServerArenaFormationLayer:_onCrossDayUpdate()
	if var_0_3:getSeasonStatus() ~= var_0_1.CTRL_ON_SEASON then
		var_0_5:tip(g.core.lang:get(411013))
		var_0_5:popToRoot()
	end
end

function CrossServerArenaFormationLayer:_updateBtnTitle()
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

return CrossServerArenaFormationLayer
