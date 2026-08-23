local var_0_0 = g.core.model.User
local var_0_1 = g.core.lang
local BioHudTaskPart = class("BioHudTaskPart", require("app.fairyGUI.biography.UI_BioHudTaskPart"))

function BioHudTaskPart:ctor()
	self._ownerStage = nil
	self._refChapterInfo = nil
	self._refSubMission = nil
	self._autoType = 0
	self._isMainTaskFinish = false
	self._waitCount = 0
	self._lastTime = -1
	self._ticked = false
	self._currentMainTaskIndex = nil
	self._canTouchTask = true
	self._isCanShowTaskPopByVisible = true
	self.m_openTaskBtn = self.m_openBtn:getChild("openTaskBtn")
	self.m_openBtnState = self.m_openBtn:getController("state")

	self.m_autoMainBtn:addClickListener(handler(self, self._onAutoMainOneKeyClick))
	self.m_autoSubBtn:addClickListener(handler(self, self._onAutoSubOneKeyClick))

	local var_1_0 = g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_AUTO_CHALLENGE)

	self.m_autoMainBtn:setVisible(var_1_0)
	self.m_autoSubBtn:setVisible(var_1_0)
	self:_initDefaultData()
	self:_initRegisterUI()
end

function BioHudTaskPart:onLoad()
	self.m_openBtnState:setSelectedIndex(1)
	self.m_switchController:setSelectedIndex(1)

	self._isCanShowTaskPopByVisible = true
	self._ticked = false

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_FINISH, handler(self, self._onForceGuideEnd), self)
end

function BioHudTaskPart:onUnload()
	self._ownerStage = nil
	self._refChapterInfo = nil
	self._refSubMission = nil

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	self:cancelAllSchedule()
end

function BioHudTaskPart:startUp(arg_4_1)
	self._ownerStage = arg_4_1
end

function BioHudTaskPart:initChapterData(arg_5_1)
	self._refChapterInfo = arg_5_1

	local var_5_0 = g.core.model.User.bioData:getMission(1003)

	if self._refChapterInfo.id == 1 and var_5_0 and not var_5_0.finish then
		self._lastTime = os.time()

		self:newSchedule(handler(self, self._onCheckWeakGuideTime), 1)
	end
end

function BioHudTaskPart:_onForceGuideEnd()
	self._lastTime = os.time()
	self._ticked = false
end

function BioHudTaskPart:_onCheckWeakGuideTime()
	if self._ticked then
		return
	end

	local var_7_0 = os.time()

	if var_7_0 - self._lastTime > 3 then
		self._lastTime = var_7_0

		self:_checkTickWeakGuide()
	end
end

function BioHudTaskPart:_checkTickWeakGuide()
	local var_8_0 = g.core.model.User.bioData:getMission(1003)

	self._ticked = true

	if var_8_0 and not var_8_0.finish then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "BIO_STAGE_STAY",
			targetBtn = self
		})
	end
end

function BioHudTaskPart:refreshTask()
	self:_refreshMainTask()
	self:_refreshSubTask()
	self.m_autoController:setSelectedIndex(self._autoType)
	self.m_autoMainBtn:setVisible(self._autoType == 0)
	self.m_autoSubBtn:setVisible(self._autoType == 1)
end

function BioHudTaskPart:_initDefaultData()
	return
end

function BioHudTaskPart:_initRegisterUI()
	self.m_openBtn:addClickListener(handler(self, self._onOpenTaskClick))
	self.m_taskBtn:addClickListener(handler(self, self._onAutoMainClick))
	self.m_taskSubBtn:addClickListener(handler(self, self._onAutoSubClick))
	self.m_openTaskBtn:addClickListener(handler(self, self._onTaskPopClick))
end

function BioHudTaskPart:_refreshMainTask()
	self._ticked = false

	local var_12_0
	local var_12_1
	local var_12_2 = self:_checkChainState()

	self._autoType = var_12_2

	if var_12_2 == 2 then
		var_12_0 = var_0_1:get(302010)
		var_12_1 = var_0_1:get(302011)
	elseif var_12_2 == 1 then
		var_12_0 = var_0_1:get(302012)
		var_12_1 = var_0_1:get(302013)
	else
		local var_12_3 = var_0_0.bioData:getChain(self._refChapterInfo.chains[1])

		if self._currentMainTaskIndex and var_12_3.current ~= self._currentMainTaskIndex and self.m_renewal_001Transition then
			self._waitCount = self._waitCount + 1

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
			self.m_renewal_001Transition:play(handler(self, self._onAnimEnd))
		end

		self._currentMainTaskIndex = var_12_3.current

		local var_12_4 = var_0_0.bioData:getMission(var_12_3.missions[var_12_3.current])

		var_12_0 = var_12_4.name .. "（" .. var_12_3.current .. "/" .. #var_12_3.missions .. "）"
		var_12_1 = var_12_4.des
	end

	self.m_nameTxt:setText(var_12_0)
	self.m_descTxt:setText(var_12_1)
end

function BioHudTaskPart:_checkChainState()
	local var_13_0 = var_0_0.bioData:getChain(self._refChapterInfo.chains[1])

	self._isMainTaskFinish = var_13_0.finish

	if not var_13_0.finish then
		return 0
	end

	for iter_13_0 = 2, #self._refChapterInfo.chains do
		for iter_13_1, iter_13_2 in ipairs(var_0_0.bioData:getChain(self._refChapterInfo.chains[iter_13_0]).missions) do
			if not var_0_0.bioData:getMission(iter_13_2).finish then
				return 1
			end
		end
	end

	return 2
end

function BioHudTaskPart:_refreshSubTask()
	local var_14_0 = self:_getCurSubMission()

	if self._refSubMission and var_14_0 and var_14_0.id ~= self._refSubMission.id and self.m_renewal_002Transition then
		self._waitCount = self._waitCount + 1

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
		self.m_renewal_002Transition:play(handler(self, self._onAnimEnd))
	end

	self._refSubMission = var_14_0

	if var_14_0 == nil then
		self.m_nameSubTxt:setText(var_0_1:get(302014))
		self.m_descSubTxt:setText("")

		return
	end

	self.m_nameSubTxt:setText(var_14_0.name)
	self.m_descSubTxt:setText(var_14_0.unlock and var_14_0.des .. "（" .. var_14_0.value .. "/" .. var_14_0.max .. "）" or var_14_0.unlockType and var_0_0.bioData:getUnlockDesc(var_14_0["preset_type_" .. var_14_0.unlockType], var_14_0["preset_value_" .. var_14_0.unlockType]) or var_0_1:get(302015))

	if self._autoType == 1 and var_0_0.bioData:getChain(var_14_0.chain).type == 4 and not var_14_0.isLast and not var_14_0.isFirst then
		self._autoType = 2
	end
end

function BioHudTaskPart:_getCurSubMission()
	for iter_15_0, iter_15_1 in ipairs((self:_getSubChains())) do
		for iter_15_2, iter_15_3 in ipairs(iter_15_1.missions) do
			local var_15_0 = var_0_0.bioData:getMission(iter_15_3)

			if not var_15_0.finish then
				return var_15_0
			end
		end
	end

	return nil
end

function BioHudTaskPart:_getSubChains()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self._refChapterInfo.chains) do
		local var_16_1 = var_0_0.bioData:getChain(iter_16_1)

		if var_16_1.type == 2 or var_16_1.type == 4 then
			table.insert(var_16_0, var_16_1)
		end
	end

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		if arg_17_0.mission_priority ~= arg_17_1.mission_priority then
			return arg_17_0.mission_priority < arg_17_1.mission_priority
		end

		return false
	end)

	return var_16_0
end

function BioHudTaskPart:_openTaskPop(arg_18_1)
	if self._isCanShowTaskPopByVisible then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.biography.view.BioTaskPop").new(self._refChapterInfo, arg_18_1)))
	end
end

function BioHudTaskPart:_onTaskPopClick()
	self:_openTaskPop((self._autoType ~= 0 or nil) and self._refSubMission)
end

function BioHudTaskPart:_onAutoMainClick()
	if self._autoType == 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BIO_SEARCH_PATH_TARGET, false, {
			type = 1
		})
	else
		self:_openTaskPop(self._refSubMission)
	end
end

function BioHudTaskPart:_onAutoSubClick()
	if self._autoType == 1 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BIO_SEARCH_PATH_TARGET, false, {
			type = 2,
			mission = self._refSubMission
		})
	else
		self:_openTaskPop(self._refSubMission)
	end
end

function BioHudTaskPart:_onOpenTaskClick()
	if self._canTouchTask then
		self._canTouchTask = false

		if self.m_openBtnState:getSelectedIndex() == 0 then
			self.m_openBtnState:setSelectedIndex(1)

			if self.m_openTransition then
				self.m_openTransition:setTimeScale(1)

				self._waitCount = self._waitCount + 1

				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
				self.m_openTransition:play(handler(self, self._onAnimEnd))

				self._isCanShowTaskPopByVisible = true
			end
		else
			if self.m_closeTransition then
				self.m_openTransition:setTimeScale(0.84)

				self._waitCount = self._waitCount + 1

				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
				self.m_closeTransition:play(handler(self, self._onAnimEnd))

				self._isCanShowTaskPopByVisible = false
			end

			self.m_openBtnState:setSelectedIndex(0)
		end
	end
end

function BioHudTaskPart:getSubTaskMissionInfo()
	return self._refSubMission
end

function BioHudTaskPart:_onAutoMainOneKeyClick()
	fgui.UIPackage:addPackage("ui/infoPop/infoPop")

	local var_24_0 = fgui.UIPackage:createObject("biography", "BioAutoRunComp")

	var_24_0:setTaskType(0)
	var_24_0:setActionComp(self)
	var_24_0:setPosition(display.width / 2 + display.cx, display.height)
	g.core.layer.LayerManager:getGuideTopLayer():addChild(var_24_0)
end

function BioHudTaskPart:_onAutoSubOneKeyClick()
	fgui.UIPackage:addPackage("ui/infoPop/infoPop")

	local var_25_0 = fgui.UIPackage:createObject("biography", "BioAutoRunComp")

	var_25_0:setTaskType(1)
	var_25_0:setActionComp(self)
	var_25_0:setPosition(display.width / 2 + display.cx, display.height)
	g.core.layer.LayerManager:getGuideTopLayer():addChild(var_25_0)
end

function BioHudTaskPart:doAutoAction(arg_26_1)
	if arg_26_1 == 0 then
		if self._autoType == 0 then
			self:_onAutoMainClick()
		else
			return true
		end
	elseif arg_26_1 == 1 then
		if self._autoType == 1 then
			self:_onAutoSubClick()
		else
			return true
		end
	end
end

function BioHudTaskPart:_onAnimEnd()
	self._canTouchTask = true

	if self._waitCount > 0 then
		self._waitCount = self._waitCount - 1

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

function BioHudTaskPart:onUnload()
	if self._waitCount > 0 then
		for iter_28_0 = 1, self._waitCount do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end

		self._waitCount = 0
	end

	local var_28_0 = g.core.model.User.bioData:getMission(1003)

	if var_28_0 and not var_28_0.finish then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	end
end

return BioHudTaskPart
