local var_0_0 = g.core.model.User.blazingArenaData
local BlazingArenaFormationLayer = class("BlazingArenaFormationLayer", require("app.fairyGUI.blazingArena.UI_BlazingArenaFormationLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/blazingArena/blazingArena",
		resName = "BlazingArenaFormationLayer",
		pkgName = "blazingArena",
		isFullScreen = true
	}, ...)
end)

function BlazingArenaFormationLayer:ctor()
	self._formationType = g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA
	self._formationIndex = 1
	self._cdSchedule = nil

	self:_initView()
end

function BlazingArenaFormationLayer:_initView()
	self.m_saveBtn:addClickListener(handler(self, self._onSaveBtnClicked))
	self.m_nextBtn:addClickListener(handler(self, self._onNextBtnClicked))
	self.m_tabList:setVirtual(self)
	self.m_tabList:doFairyBatching(false)
	self.m_tabList:setItemRenderer(handler(self, self._onRenderTabItem))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickFormationTab))
	self.m_tabList:setNumItems(3)
	self:addBg("bg/blazingArena/bg_bljt_biandui.jpg", true, nil, 1)
end

function BlazingArenaFormationLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, self._onSaveSucc, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self.m_tabList:setSelectedIndex(self._formationIndex - 1)
	self:_updateFormationView()
	self.m_enterTransition:play(function()
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
		end, 0)
	end)
end

function BlazingArenaFormationLayer:onUnload()
	self._cdSchedule = nil
end

function BlazingArenaFormationLayer:_onRenderTabItem(arg_8_1, arg_8_2)
	arg_8_2:updateView(arg_8_1 + 1)
end

function BlazingArenaFormationLayer:_onClickFormationTab(arg_9_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_TALENT_LEVEL_UP)
	self:_onChangeTab((arg_9_1:getDataValue()))
end

function BlazingArenaFormationLayer:_onChangeTab(arg_10_1)
	if arg_10_1 + 1 == self._formationIndex then
		return
	end

	self._formationIndex = arg_10_1 + 1

	self:_updateFormationView()
	self.m_tabList:getChildAt((self.m_tabList:itemIndexToChildIndex(self._formationIndex - 1))):playEffectAnimation()
	self.m_formationIdxController:setSelectedIndex(arg_10_1)
end

function BlazingArenaFormationLayer:_onNextBtnClicked()
	self.m_tabList:setSelectedIndex(self._formationIndex)
	self:_onChangeTab(self._formationIndex)
end

function BlazingArenaFormationLayer:_onSaveBtnClicked()
	if self._cdSchedule then
		g.core.module.ModuleManager:tip(g.core.lang:get(2502))

		return
	end

	self:_doSaveFormation()
end

function BlazingArenaFormationLayer:_doSaveFormation()
	if var_0_0:isFormationValid() then
		self.m_teamComp:sendC2SFormationSave()
		g.core.module.ModuleManager:tip(g.core.lang:get(431416))
	elseif not g.core.model.User.mulFormationData:isModified(self._formationType) then
		g.core.module.ModuleManager:tip(g.core.lang:get(307058))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(431417))
	end

	g.core.module.ModuleManager:popComponent()
end

function BlazingArenaFormationLayer:_updateFormationView()
	self.m_teamComp:updateComp(self._formationType, self._formationIndex)
	self:_updatePreciousSuitBtn()

	local var_14_0 = var_0_0:getAllExpiredMember()

	if #var_14_0.typeList > 0 then
		for iter_14_0 = 1, #var_14_0.typeList do
			var_0_0:doTakeOffHelpMembers(var_14_0.typeList[iter_14_0], var_14_0.itemList[iter_14_0])
		end

		g.core.module.ModuleManager:tip(g.core.lang:get(431421))
	end
end

function BlazingArenaFormationLayer:_updatePreciousSuitBtn()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS) then
		if not self._preciousSuitBtn then
			self._preciousSuitBtn = fgui.UIPackage:createObject("base_new", "BasePreciousSuitBtn")

			self:addChild(self._preciousSuitBtn)
			self._preciousSuitBtn:setPosition(display.width - 126 - cc.Director:getInstance():getSafeAreaRect().x, display.height - 424)
		end

		self._preciousSuitBtn:setBtnFormationData(self._formationType, self._formationIndex)
	end
end

function BlazingArenaFormationLayer:_onSaveSucc(arg_16_1, arg_16_2, arg_16_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ALL, false)

	if self._cdTime == 0 then
		self._cdTime = 5
		self._cdSchedule = self:newSchedule(handler(self, self._updateBtnTitle), 1)

		self.m_saveBtn:setTitle(g.core.lang:get(307057, {
			time = self._cdTime
		}))
	end

	if self._hasSave then
		g.core.module.ModuleManager:tip(g.core.lang:get(307059))
	else
		self._hasSave = true
	end
end

function BlazingArenaFormationLayer:_onCrossDayUpdate()
	self:_updateFormationView()
end

function BlazingArenaFormationLayer:_updateBtnTitle()
	if self._cdTime > 0 then
		self.m_saveBtn:setTitle(g.core.lang:get(307057, {
			time = self._cdTime
		}))

		self._cdTime = self._cdTime - 1
	else
		self.m_saveBtn:setTitle(g.core.lang:get(307056))

		self._cdTime = 0

		if self._cdSchedule then
			self:cancelSchedule(self._cdSchedule)

			self._cdSchedule = nil
		end
	end
end

return BlazingArenaFormationLayer
