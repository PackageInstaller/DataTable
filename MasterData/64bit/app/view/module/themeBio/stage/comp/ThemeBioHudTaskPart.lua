local var_0_0 = g.core.lang
local var_0_1 = g.core.model.User.themeData
local ThemeBioHudTaskPart = class("ThemeBioHudTaskPart", require("app.fairyGUI.themeBio.UI_ThemeBioHudTaskPart"))

function ThemeBioHudTaskPart:ctor()
	self._ownerStage = nil
	self._refChapterInfo = nil
	self._refSubMission = nil
	self._autoType = 0
	self._isMainTaskFinish = false
	self._currentMainTaskIndex = nil
	self._canTouchTask = true
	self._isCanShowTaskPopByVisible = true
	self.m_openTaskBtn = self.m_openBtn:getChild("openTaskBtn")
	self.m_openBtnState = self.m_openBtn:getController("state")

	self:_initRegisterUI()
end

function ThemeBioHudTaskPart:onLoad()
	self.m_openBtnState:setSelectedIndex(1)
	self.m_switchController:setSelectedIndex(1)

	self._isCanShowTaskPopByVisible = true
end

function ThemeBioHudTaskPart:onUnload()
	self._ownerStage = nil
	self._refChapterInfo = nil
	self._refSubMission = nil

	self:cancelAllSchedule()
end

function ThemeBioHudTaskPart:startUp(arg_4_1)
	self._ownerStage = arg_4_1
end

function ThemeBioHudTaskPart:initChapterData(arg_5_1, arg_5_2)
	self._refChapterInfo = arg_5_1
	self._activeThemeValue = arg_5_2
	self._themeBioData = var_0_1:getThemeData(self._activeThemeValue):getThemeBioData()
end

function ThemeBioHudTaskPart:refreshTask()
	self:_refreshMainTask()
	self:_refreshSubTask()
	self.m_autoController:setSelectedIndex(self._autoType)
end

function ThemeBioHudTaskPart:_initRegisterUI()
	self.m_openBtn:addClickListener(handler(self, self._onOpenTaskClick))
	self.m_taskBtn:addClickListener(handler(self, self._onAutoMainClick))
	self.m_taskSubBtn:addClickListener(handler(self, self._onAutoSubClick))
	self.m_openTaskBtn:addClickListener(handler(self, self._onTaskPopClick))
end

function ThemeBioHudTaskPart:_refreshMainTask()
	local var_8_0
	local var_8_1
	local var_8_2 = self:_checkChainState()

	self._autoType = var_8_2

	if var_8_2 == 2 then
		var_8_0 = var_0_0:get(409109)
		var_8_1 = var_0_0:get(409113)
	elseif var_8_2 == 1 then
		var_8_0 = var_0_0:get(409114)
		var_8_1 = var_0_0:get(409115)
	else
		local var_8_3 = self._themeBioData:getChain(self._refChapterInfo.chains[1])

		if self._currentMainTaskIndex and var_8_3.current ~= self._currentMainTaskIndex and self.m_renewal_001Transition then
			self.m_renewal_001Transition:play(handler(self, self._onAnimEnd))
		end

		self._currentMainTaskIndex = var_8_3.current

		local var_8_4 = self._themeBioData:getMission(var_8_3.missions[var_8_3.current])

		var_8_0 = var_8_4.name .. "（" .. var_8_3.current .. "/" .. #var_8_3.missions .. "）"
		var_8_1 = var_8_4.des
	end

	self.m_nameTxt:setText(var_8_0)
	self.m_descTxt:setText(var_8_1)
end

function ThemeBioHudTaskPart:_checkChainState()
	local var_9_0 = self._themeBioData:getChain(self._refChapterInfo.chains[1])

	self._isMainTaskFinish = var_9_0.finish

	if not var_9_0.finish then
		return 0
	end

	for iter_9_0 = 2, #self._refChapterInfo.chains do
		for iter_9_1, iter_9_2 in ipairs(self._themeBioData:getChain(self._refChapterInfo.chains[iter_9_0]).missions) do
			if not self._themeBioData:getMission(iter_9_2).finish then
				return 1
			end
		end
	end

	return 2
end

function ThemeBioHudTaskPart:_refreshSubTask()
	local var_10_0 = self:_getCurSubMission()

	if self._refSubMission and var_10_0 and var_10_0.id ~= self._refSubMission.id and self.m_renewal_002Transition then
		self.m_renewal_002Transition:play(handler(self, self._onAnimEnd))
	end

	self._refSubMission = var_10_0

	if var_10_0 == nil then
		self.m_haveSubController:setSelectedIndex(0)
		self.m_nameSubTxt:setText(var_0_0:get(409116))
		self.m_descSubTxt:setText("")

		return
	end

	self.m_haveSubController:setSelectedIndex(1)
	self.m_nameSubTxt:setText(var_10_0.name)
	self.m_descSubTxt:setText(var_10_0.unlock and var_10_0.des .. "（" .. var_10_0.value .. "/" .. var_10_0.max .. "）" or var_10_0.unlockType and self._themeBioData:getUnlockDesc(var_10_0["preset_type_" .. var_10_0.unlockType], var_10_0["preset_value_" .. var_10_0.unlockType]) or var_0_0:get(409117))

	if self._autoType == 1 and self._themeBioData:getChain(var_10_0.chain).type == 4 and not var_10_0.isLast and not var_10_0.isFirst then
		self._autoType = 2
	end
end

function ThemeBioHudTaskPart:_getCurSubMission()
	for iter_11_0, iter_11_1 in ipairs((self:_getSubChains())) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1.missions) do
			local var_11_0 = self._themeBioData:getMission(iter_11_3)

			if not var_11_0.finish then
				return var_11_0
			end
		end
	end

	return nil
end

function ThemeBioHudTaskPart:_getSubChains()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self._refChapterInfo.chains) do
		local var_12_1 = self._themeBioData:getChain(iter_12_1)

		if var_12_1.type == 2 or var_12_1.type == 4 then
			table.insert(var_12_0, var_12_1)
		end
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		if arg_13_0.mission_priority ~= arg_13_1.mission_priority then
			return arg_13_0.mission_priority < arg_13_1.mission_priority
		end

		return false
	end)

	return var_12_0
end

function ThemeBioHudTaskPart:_openTaskPop(arg_14_1)
	if self._isCanShowTaskPopByVisible then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.themeBio.view.ThemeBioTaskPop").new(self._refChapterInfo, arg_14_1, self._activeThemeValue)))
	end
end

function ThemeBioHudTaskPart:_onTaskPopClick()
	self:_openTaskPop((self._autoType ~= 0 or nil) and self._refSubMission)
end

function ThemeBioHudTaskPart:_onAutoMainClick()
	if self._autoType == 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BIO_SEARCH_PATH_TARGET, false, {
			type = 1
		})
	else
		self:_openTaskPop(self._refSubMission)
	end
end

function ThemeBioHudTaskPart:_onAutoSubClick()
	if self._autoType == 1 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BIO_SEARCH_PATH_TARGET, false, {
			type = 2,
			mission = self._refSubMission
		})
	else
		self:_openTaskPop(self._refSubMission)
	end
end

function ThemeBioHudTaskPart:_onOpenTaskClick()
	if self._canTouchTask then
		self._canTouchTask = false

		if self.m_openBtnState:getSelectedIndex() == 0 then
			self.m_openBtnState:setSelectedIndex(1)

			if self.m_openTransition then
				self.m_openTransition:setTimeScale(1)
				self.m_openTransition:play(handler(self, self._onAnimEnd))

				self._isCanShowTaskPopByVisible = true
			end
		else
			if self.m_closeTransition then
				self.m_openTransition:setTimeScale(0.84)
				self.m_closeTransition:play(handler(self, self._onAnimEnd))

				self._isCanShowTaskPopByVisible = false
			end

			self.m_openBtnState:setSelectedIndex(0)
		end
	end
end

function ThemeBioHudTaskPart:_onAnimEnd()
	self._canTouchTask = true
end

function ThemeBioHudTaskPart:getSubTaskMissionInfo()
	return self._refSubMission
end

return ThemeBioHudTaskPart
