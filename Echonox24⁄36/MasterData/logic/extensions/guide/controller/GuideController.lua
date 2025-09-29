-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/GuideController.lua

module("logic.extensions.guide.controller.GuideController", package.seeall)

local GuideController = class("GuideController", BaseController, IMainPopItem)

function GuideController:ctor()
	self._enableGuides = true
	self._toStartGuideSteps = {}
	self._curIndex = 0
	self._maxStep = 0
	self._isGuiding = false
	self._guideId = false
	self._forbidGuides = Astral.LocalStorage.Instance:GetString("GM_Forbid_Guide", "0") == "1"
	self._isGMStart = false

	local kGuideRoot = goutil.create("Guide")

	self._uiglobalTouchTrigger = Astral.UIGlobalTouchTrigger.Get(kGuideRoot)

	self._uiglobalTouchTrigger:AddGlobalListener(self._onDoClickScreen, self)

	self._clickTimes = 0
	self._totalTime = 3
	self._curTime = 0
	self._maxClickTimes = 10
	self._beginCampAdjust = false
	self._isDungeonRound = false
	self._isOperateUnitFinish = false
	self._isShowJumpGuide = false
	self._curBattleGuideList = {}
	self._allGuideMap = {}
	self._cacheGuideId = false
	self._triggerGuideFuncMap = {}
end

function GuideController:_registerGuideNotify()
	GlobalDispatcher:addEventListener(EventType.PLAYER_LEVEL_UP, self._onTriggerGuideByLevelUp, self)
	GlobalDispatcher:addEventListener(EventType.ENTER_DUNGEON, self._onTriggerGuideByEnterDungeon, self)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPENING_EVENT, self._onTriggerGuideByOpenView, self)
	BattleDispatcher:addEventListener(BattleEventType.OnBattleRoundUpdate, self._onUpdateBattleRound, self)
	BattleDispatcher:addEventListener(BattleEventType.OnBeginCampAdjustment, self._onBeginCampAdjustment, self)
	BattleDispatcher:addEventListener(BattleEventType.OnEndCampAdjustment, self._onEndCampAdjustment, self)
	BattleDispatcher:addEventListener(BattleEventType.OnOperateNextUnit, self._onOperateNextUnit, self)
	GlobalDispatcher:addEventListener(EventType.DISCONNENT_SERVER_EVENT, self._onDisconnectServer, self)
	BattleDispatcher:addEventListener(BattleEventType.OnBattleEnterFinish, self._onBattleEnterFinish, self)
	BattleDispatcher:addEventListener(BattleEventType.OnBattleFinish, self._onBattleExitFinish, self)
	BattleDispatcher:addEventListener(BattleEventType.OnBattleRestart, self._onBattleRestart, self)
	BattleDispatcher:addEventListener(BattleEventType.OnBeforeCampAdjustmentGuide, self._onBeforeCampAdjustmentGuide, self)
	BattleDispatcher:addEventListener(BattleEventType.OnRoundStartAnimDone, self._onRoundStartAnimDone, self)
	GlobalDispatcher:addEventListener(EventType.DUNGEON_CHAPTER_OR_DIFFICULTY_UPDATE, self._difficultyChange, self)
	GlobalDispatcher:addEventListener(EventType.ROGUE_GUIDE_INFO, self._triggerRogueGuide, self)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSING_EVENT, self._fwViewClosingEvent, self)
	GlobalDispatcher:addEventListener(EventType.VIEW_PAGE_CHAGNE_EVENT, self._onViewPageChange, self)
	GlobalDispatcher:addEventListener(EventType.STORY_ACTIVE_ATT_OPTION, self._onStoryActiveAttrOption, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_LV_UP_SUCESS, self.onEquipLevelUp, self)
	StoryDispatcher:addEventListener(StoryNotifyName.StoryExit, self.onFinishStory, self)
	DungeonDispatcher:addEventListener(DungeonEventType.OnPassPlotDungeonReply, self._handlePassedPlotDungeonRequest, self)
	GlobalDispatcher:addEventListener(EventType.LOAD_DUNGEON_DATA_FINISH, self._handleGetDungeonDataFinish, self)
end

function GuideController:_unregisterGuideNotity()
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPENING_EVENT, self._onTriggerGuideByOpenView, self)
	GlobalDispatcher:removeEventListener(EventType.PLAYER_LEVEL_UP, self._onTriggerGuideByLevelUp, self)
	GlobalDispatcher:removeEventListener(EventType.ENTER_DUNGEON, self._onTriggerGuideByEnterDungeon, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnBattleRoundUpdate, self._onUpdateBattleRound, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnBeginCampAdjustment, self._onBeginCampAdjustment, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnEndCampAdjustment, self._onEndCampAdjustment, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnOperateNextUnit, self._onOperateNextUnit, self)
	GlobalDispatcher:removeEventListener(EventType.DISCONNENT_SERVER_EVENT, self._onDisconnectServer, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnBattleEnterFinish, self._onBattleEnterFinish, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnBattleFinish, self._onBattleExitFinish, self)
	GlobalDispatcher:removeEventListener(EventType.DUNGEON_CHAPTER_OR_DIFFICULTY_UPDATE, self._difficultyChange, self)
	GlobalDispatcher:removeEventListener(EventType.ROGUE_GUIDE_INFO, self._triggerRogueGuide, self)
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSING_EVENT, self._fwViewClosingEvent, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnBattleRestart, self._onBattleRestart, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnBeforeCampAdjustmentGuide, self._onBeforeCampAdjustmentGuide, self)
	GlobalDispatcher:removeEventListener(EventType.VIEW_PAGE_CHAGNE_EVENT, self._onViewPageChange, self)
	GlobalDispatcher:removeEventListener(EventType.STORY_ACTIVE_ATT_OPTION, self._onStoryActiveAttrOption, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_LV_UP_SUCESS, self.onEquipLevelUp, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.StoryExit, self.onFinishStory, self)
	DungeonDispatcher:removeEventListener(DungeonEventType.OnPassPlotDungeonReply, self._handlePassedPlotDungeonRequest, self)
	GlobalDispatcher:removeEventListener(EventType.LOAD_DUNGEON_DATA_FINISH, self._handleGetDungeonDataFinish, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnRoundStartAnimDone, self._onRoundStartAnimDone, self)
end

function GuideController:onInit()
	self:_registerReasonFunc()
end

function GuideController:_registerReasonFunc()
	self._triggerGuideFuncMap[GuideEnum.TriggerType.EnterDungeon] = self._tryTriggerEnterDungeon
	self._triggerGuideFuncMap[GuideEnum.TriggerType.PlayerLevel] = self._tryTriggerPlayerLevel
	self._triggerGuideFuncMap[GuideEnum.TriggerType.OpenView] = self._tryTriggerOpenView
	self._triggerGuideFuncMap[GuideEnum.TriggerType.CloseUI] = self._tryTriggerCloseView
	self._triggerGuideFuncMap[GuideEnum.TriggerType.PageActive] = self._tryTriggerPageActive
	self._triggerGuideFuncMap[GuideEnum.TriggerType.ActiveStoryArrtOption] = self._tryTriggerActiveStoryArrtOption
	self._triggerGuideFuncMap[GuideEnum.TriggerType.EquipLevelUp] = self._tryTriggerEquipLevelUp
	self._triggerGuideFuncMap[GuideEnum.TriggerType.FinishStory] = self._tryTriggerFinishStory
	self._triggerGuideFuncMap[GuideEnum.TriggerType.WaitBattleStart] = self._tryTriggerBattleStart
	self._triggerGuideFuncMap[GuideEnum.TriggerType.BeforeCampAdjustment] = self._tryTriggerBeforeCampAdjustment
	self._triggerGuideFuncMap[GuideEnum.TriggerType.RoguelikeInPos] = self._tryTriggerRLInPos
	self._triggerGuideFuncMap[GuideEnum.TriggerType.RoguelikeInEvent] = self._tryTriggerRLInEvent
	self._triggerGuideFuncMap[GuideEnum.TriggerType.RoguelikeWithMonster] = self._tryTriggerRLByMonster
	self._triggerGuideFuncMap[GuideEnum.TriggerType.RoguelikeCalcReultByType] = self._tryTriggerRLCalcReultByType
	self._triggerGuideFuncMap[GuideEnum.TriggerType.RoguelikeActiveUI] = self._tryTriggerRLActiveUI
end

function GuideController:onReset()
	self:closeGuide()

	self._allGuideMap = {}
end

function GuideController:isGuiding()
	if self._forbidGuides then
		return false
	end

	return self._isGuiding
end

function GuideController:getCurGuideId()
	return self._guideId
end

function GuideController:isGMStartGuide()
	return self._isGMStart
end

function GuideController:getCurGuideCO()
	if not self._isGuiding then
		return false
	end

	return self._toStartGuideSteps[self._curIndex]
end

function GuideController:getMainPopType()
	return MainPopEnum.Type.Guide
end

function GuideController:onTriggerMainPop()
	self:_onTriggerGuide()
end

function GuideController:_IsEnterDungeonGuide()
	local guideMO = GuideModel.instance:getGuideMO(self._guideId)

	if not guideMO then
		return false
	end

	local isDungeon, roundIndex = self:_tryTriggerEnterDungeon(guideMO)

	if isDungeon and roundIndex > 0 then
		return true
	end

	return false
end

function GuideController:getEnterDungeonGuide()
	return self._isDungeonRound
end

function GuideController:setEnterDungeonGuide(state)
	self._isDungeonRound = state
end

function GuideController:_setExceptionCheckState(state)
	self._uiglobalTouchTrigger.enabled = state
end

function GuideController:initGuide()
	if not GuideModel.instance:isFinishedAllForceGuide() then
		ViewMgr.instance:preCreate(ViewName.ImageGuide)
		ViewMgr.instance:preCreate(ViewName.GuideView)
		self:_registerGuideNotify()
	end
end

function GuideController:isForbidGuides()
	return self._forbidGuides
end

function GuideController:forbidGuides(isEnable)
	if isEnable then
		self._forbidGuides = false

		Astral.LocalStorage.Instance:SetString("GM_Forbid_Guide", "0")
	else
		self._forbidGuides = true

		Astral.LocalStorage.Instance:SetString("GM_Forbid_Guide", "1")
	end
end

function GuideController:_checkHasNotFinish()
	for k, v in pairs(self._allGuideMap) do
		if v.isStart and not v.isEnd then
			return true
		end
	end

	return false
end

function GuideController:startGudie(guideId, stepId)
	local guideMO = GuideModel.instance:getGuideMO(guideId)

	if not guideMO then
		if enableErrorLog then
			printError("load guide data failed! guide id :" .. guideId)
		end

		return
	end

	if not self._allGuideMap[guideId] then
		self._allGuideMap[guideId] = {
			isEnd = false,
			isStart = false
		}
	end

	if self:_checkHasNotFinish() then
		self._cacheGuideId = guideId

		print("wait for last guide finish", guideId)

		return
	end

	if not self._allGuideMap[guideId].isStart then
		self._allGuideMap[guideId].isStart = true
	end

	self._guideId = guideId
	self._isGMStart = GuideModel.instance:isGMStartGuide(guideId)

	local guideCO = guideMO:getGuideCO()

	if guideCO.precondition > 0 then
		local preConditionGuideMO = GuideModel.instance:getGuideMO(guideCO.precondition)

		if not preConditionGuideMO then
			if enableLog then
				print("exec guide data failed! need finish precondition guide at first, guide id :" .. guideId)
			end

			self._allGuideMap[guideId] = {
				isEnd = false,
				isStart = false
			}

			return
		end

		if not preConditionGuideMO.isFinish then
			if enableLog then
				print("exec guide data failed! need finish precondition guide at first, guide id :" .. guideId)
			end

			self._allGuideMap[guideId] = {
				isEnd = false,
				isStart = false
			}

			return
		end
	end

	self._toStartGuideSteps = guideMO:getAllStepIds()

	if not stepId then
		self._curIndex = 1
	else
		self._curIndex = self:_getIndexByStepId(stepId)
	end

	if enableLog then
		print("current guide :" .. guideId .. "index" .. self._curIndex)
	end

	self._maxStep = self._toStartGuideSteps and #self._toStartGuideSteps or 0

	if self._maxStep <= 0 then
		if enableErrorLog then
			printError("guide stepIds could not be null! guide id :" .. guideId)
		end

		GuideModel.instance:setFinishGuide(guideId)
		self:closeGuide()

		return
	end

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_BLOCK_GYRO_CAM, true)
	GlobalDispatcher:dispatchEvent(EventType.START_GUIDE_STEP, guideId)
	UserUtil.uploadGuideBuryPoint(guideMO, true)
	self:_setExceptionCheckState(true)

	self._isDungeonRound = self:_IsEnterDungeonGuide()

	self:execNextStep(guideId)
end

function GuideController:_getIndexByStepId(curStepId)
	for index, stepId in ipairs(self._toStartGuideSteps) do
		if stepId == curStepId then
			return index
		end
	end

	return 1
end

function GuideController:execNextStep(guideId)
	if self._enableGuides and not self._forbidGuides then
		self._isGuiding = true

		if self._curIndex <= self._maxStep then
			print("start guide, guideId" .. guideId .. " _ index: " .. self._curIndex .. " stepId:" .. self._toStartGuideSteps[self._curIndex])
			GuideStepController.instance:execStep(guideId, self._toStartGuideSteps[self._curIndex])
		end
	else
		self._isGuiding = false

		print("counld not exec guide step")
	end
end

function GuideController:finishStep(guideId, stepId, force)
	local guideMO = GuideModel.instance:getGuideMO(guideId)

	if not guideMO then
		GuideStepController.instance:clearStep()
		self:closeGuide()

		return
	end

	local isBattleGuide = guideMO:getIsBattleGuide()

	if force then
		if enableWarnLog then
			printWarn("pass guide by exception skip! guide id :" .. guideId)
		end

		if isBattleGuide then
			table.insert(self._curBattleGuideList, guideId)
			guideMO:setGuideState(true)
			guideMO:trySetOpenSytemState(true)
			self:_finishExceptionByClient(guideId)

			if GuideModel.instance:isFinishedAllForceGuide() then
				self:_unregisterGuideNotity()
			end

			self:closeGuide()
			UserUtil.uploadGuideBuryPoint(guideMO, false, 2)
		else
			self:oneKeyFinishGuide(guideId, true, true, force)
		end

		return
	end

	local guideCO = guideMO:getGuideCO()

	if self._toStartGuideSteps then
		GuideModel.instance:finishStep(guideId, self._toStartGuideSteps[self._curIndex])
	end

	GuideStepController.instance:clearStep()

	if guideMO and not guideMO:getIsBattleGuide() and self._toStartGuideSteps[self._curIndex] == guideCO.saveStepId and not guideMO.isFinish then
		self:oneKeyFinishGuide(guideId, false, true, false)
	end

	if self._curIndex >= self._maxStep then
		if not guideMO.isFinish then
			if enableLog then
				print(string.format("<color=#00FF00>finish guide, guide ID:%s</color>", guideId))
			end

			if isBattleGuide then
				table.insert(self._curBattleGuideList, guideId)
				guideMO:setGuideState(true)
				guideMO:trySetOpenSytemState(true)

				if GuideModel.instance:isFinishedAllForceGuide() then
					self:_unregisterGuideNotity()
				end

				self:closeGuide()
				UserUtil.uploadGuideBuryPoint(guideMO, false, 1)
			else
				self:oneKeyFinishGuide(guideId, true, true, false)
			end
		else
			self:oneKeyFinishGuide(guideId, true, false, false)
		end

		return
	end

	print("finish step, guideId" .. guideId .. " _ index: " .. self._curIndex .. "total count :" .. self._maxStep)

	self._curIndex = self._curIndex + 1

	self:execNextStep(guideId)
end

function GuideController:closeGuide(isException)
	local guideMO = GuideModel.instance:getGuideMO(self._guideId)

	if guideMO then
		local isBattleGuide = guideMO:getIsBattleGuide()

		if isException then
			GuideModel.instance:setFinishGuide(self._guideId)

			if not isBattleGuide then
				local lastStepId = self._toStartGuideSteps[self._curIndex]

				GuideAgent.instance:sendFinishGuideRequest(self._guideId, 2, lastStepId)
				UserUtil.uploadGuideBuryPoint(guideMO, false, 2, lastStepId)
			else
				table.insert(self._curBattleGuideList, self._guideId)
				guideMO:setGuideState(true)
				guideMO:trySetOpenSytemState(true)
				self:_finishExceptionByClient(self._guideId)
			end
		end
	end

	print("结束引导-->关闭引导UI", isException)
	GlobalDispatcher:dispatchEvent(EventType.GUIDE_FINISH_STEP, self._guideId)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_BLOCK_GYRO_CAM, false)

	self._isShowJumpGuide = false
	self._toStartGuideSteps = {}
	self._enableGuides = true
	self._curIndex = 0
	self._maxStep = 0
	self._isGuiding = false

	ViewMgr.instance:close(ViewName.ImageGuide)
	ViewMgr.instance:close(ViewName.GuideView)
	GuideStepController.instance:clearStep()

	self._isGMStart = false
	self._isOperateUnitFinish = false
	self._curSelectUnit = false

	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Guide)
	self:_setExceptionCheckState(false)
	self:_onTriggerGuide()

	if self._guideId and self._allGuideMap[self._guideId] and self._allGuideMap[self._guideId].isStart and not self._allGuideMap[self._guideId].isEnd then
		self._allGuideMap[self._guideId].isEnd = true
	end

	self._guideId = false

	if self._cacheGuideId then
		self:startGudie(self._cacheGuideId)

		self._cacheGuideId = false
	end
end

function GuideController:_onTriggerGuideByLevelUp()
	print("trigger for level up")
	self:_onTriggerGuide()
end

function GuideController:_onTriggerGuideByEnterDungeon()
	print("trigger for enter dungeon")
	self:_onTriggerGuide()
end

function GuideController:_onTriggerGuideByOpenView(evt, viewName, opType, isBackOpen)
	print("trigger for open view", viewName)
	self:_onTriggerGuide()
end

function GuideController:_fwViewClosingEvent(evt, viewName, opType)
	print("trigger for close view", viewName)
	self:_onTriggerGuide()
end

function GuideController:_difficultyChange()
	print("trigger for view value change")
	self:_onTriggerGuide()
end

function GuideController:_onViewPageChange(evt, viewName, index)
	if string.nilorempty(viewName) or not index then
		return
	end

	print("trigger for view page change", viewName, index)

	local paramTb = {
		viewName = viewName,
		index = index
	}

	self:_checkExecGuide(paramTb)
end

function GuideController:_onStoryActiveAttrOption(evt, question)
	print("trigger for story active attr option", question)
	self:_checkExecGuide(question)
end

function GuideController:onEquipLevelUp(evt, equipId)
	print("trigger for equip level up", equipId)

	local equipUuid = tonumber(equipId)

	self:_checkExecGuide(equipUuid)
end

function GuideController:onFinishStory(evt, storyId)
	print("trigger for close story ", storyId)
	self:_checkExecGuide(storyId)
end

function GuideController:_handlePassedPlotDungeonRequest(evt)
	print("trigger for finish story dungeon")
	self:_checkExecGuide()
end

function GuideController:_handleGetDungeonDataFinish(evt)
	print("trigger for get dungeon data")
	self:_checkExecGuide()
end

function GuideController:_onRoundStartAnimDone(evt, currentRound)
	print("trigger for battle animation finish", currentRound)
	self:_checkExecGuide(currentRound)
end

function GuideController:_triggerRogueGuide(evt, guideType, param1, param2, param3)
	local rogueGuideTb = {
		guideType = guideType,
		param1 = param1,
		param2 = param2,
		param3 = param3
	}

	self:_checkExecGuide(rogueGuideTb)
end

function GuideController:_onTriggerGuide()
	self._beginCampAdjust = false
	self._beginCampAdjust = false

	self:_checkExecGuide()
end

function GuideController:_onUpdateBattleRound(currentRound, maxRound)
	self._beginCampAdjust = false
	self._updateRound = true
	self._curRound = currentRound
	self._isOperateUnitFinish = false
end

function GuideController:_onOperateNextUnit(evt, unit)
	self._isOperateUnitFinish = true

	if self._isOperateUnitFinish then
		self._curSelectUnit = unit

		self:_checkExecGuide()

		self._isOperateUnitFinish = false
		self._curSelectUnit = false
	end
end

function GuideController:_onBeginCampAdjustment()
	self._beginCampAdjust = true

	self:_checkExecGuide()
end

function GuideController:_onEndCampAdjustment()
	self._beginCampAdjust = false
end

function GuideController:_checkExecGuide(rogueGuideTb)
	if self._isGuiding then
		return
	end

	local list = GuideModel.instance:getDoingGuideIdList()
	local dst = {}

	if list then
		for i = 1, #list do
			local guideMO = GuideModel.instance:getGuideMO(list[i])
			local guideCO = guideMO:getGuideCO()

			if self:_checkTrigger(guideMO, rogueGuideTb) then
				if guideCO.precondition > 0 then
					local preConditionGuideMO = GuideModel.instance:getGuideMO(guideCO.precondition)

					if preConditionGuideMO and preConditionGuideMO.isFinish then
						table.insert(dst, list[i])
					end
				else
					table.insert(dst, list[i])
				end
			end
		end
	end

	local highestGuideId = GuideConfig.instance:getHighestPriorityGuideId(dst)

	if highestGuideId then
		self:startGudie(highestGuideId)
	else
		MainPopController.instance:showNextByGuide()
	end
end

function GuideController:_checkTrigger(guideMO, paramTb)
	if not guideMO then
		return false
	end

	local guideCO = guideMO:getGuideCO()

	if not guideCO then
		return false
	end

	if ViewMgr.instance:isOpen(ViewName.LoadingView) then
		return false
	end

	local triggerType = guideCO.triggerType
	local triggerFun = self._triggerGuideFuncMap[triggerType]

	if triggerFun then
		return triggerFun(self, guideMO, paramTb)
	elseif enableErrorLog then
		printError(string.format("unhandle guide trigger type in [%s] with [%s]", guideCO.id, triggerType))
	end

	return false
end

function GuideController:_tryTriggerEquipLevelUp(guideMO, equipId)
	if not equipId then
		return false
	end

	if type(equipId) ~= "number" then
		return false
	end

	local oldEquip = EquipIntensifyModel.instance:getEquipBeforeUpdate()
	local newEquip = EquipIntensifyModel.instance:getOperatingEquip()

	if oldEquip and newEquip then
		if enableLog then
			printInfo("guide => current equip id", newEquip:getItemId())
		end

		local hasHole = newEquip:getIsHoleUnlock(1)
		local oldLevel = oldEquip:getLevel()
		local newLevel = newEquip:getLevel()
		local list = EquipmentConfig.instance:getConstNumList("DiceOpenLevels")

		if newLevel >= list[1] and hasHole and oldLevel < list[1] then
			local part = newEquip:getPart()
			local moList = EquipIntensifyModel.instance:getAllPartD6Item(part)

			return moList and #moList > 0 or false
		end
	end

	return false
end

function GuideController:_tryTriggerActiveStoryArrtOption(guideMO, question)
	local guideCO = guideMO:getGuideCO()
	local paramstr = guideCO and guideCO.triggerParam or nil

	if not StoryController.instance:isInStory() then
		return false
	end

	if not ViewMgr.instance:isOpen(ViewName.StoryViewViewPresentor) then
		return
	end

	if not string.nilorempty(paramstr) and question then
		local questionKey = tonumber(paramstr)

		if questionKey == question then
			return true
		end
	end

	return false
end

function GuideController:_tryTriggerPageActive(guideMO, paramTb)
	local guideCO = guideMO:getGuideCO()
	local paramstr = guideCO.triggerParam

	if not string.nilorempty(paramstr) then
		local params = string.split(paramstr, "#")

		if #params ~= 2 then
			if enableErrorLog then
				printError("param is not allowed,guideId:" .. guideCO.id .. " params:" .. guideCO.triggerParam)
			end

			return false
		end

		local jumpId = tonumber(params[1])
		local pageIndex = tonumber(params[2])
		local jumpCo = SystemJumpConfig.instance:getJumpInfo(jumpId)

		if paramTb and ViewMgr.instance:isOpen(jumpCo.viewName) and jumpCo.viewName == paramTb.viewName and paramTb.index == pageIndex then
			return true
		end
	end

	return false
end

function GuideController:_tryTriggerEnterDungeon(guideMO)
	if SceneMgr.instance:getCurSceneType() ~= SceneType.Battle then
		return false, 0
	end

	local guideCO = guideMO:getGuideCO()

	if guideCO.triggerType ~= GuideEnum.TriggerType.EnterDungeon then
		return false, 0
	end

	local activeBattleFlow = BattleMgr.instance:getActiveBattleFlow()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if not dungeonCode and OOPUtil.isInstanceOf(activeBattleFlow, PrefaceBattleFlow) then
		local flow = PrefaceController.instance:getPrefaceBattleFlow()

		if flow then
			dungeonCode = flow.model:getDungeonCode()
		end
	end

	if dungeonCode then
		local params = string.split(guideCO.triggerParam, "#")
		local dungeonId = tonumber(params[1])
		local roundIndex = tonumber(params[2])
		local heroCode = tonumber(params[3] or 0)

		if dungeonId == dungeonCode and activeBattleFlow then
			local battleModel = BattleMgr.instance:getModel()
			local curBattleRound = battleModel and battleModel:getCurrentRound() or -1

			if roundIndex == -1 and curBattleRound == 0 and self._beginCampAdjust then
				return true, roundIndex
			elseif roundIndex >= 1 and curBattleRound == roundIndex and self._isOperateUnitFinish then
				if not self._curRound then
					return false, 0
				end

				if self._curSelectUnit and heroCode > 0 then
					local selectCode = self._curSelectUnit.property:getEntityCode()

					if heroCode == selectCode then
						return true, roundIndex
					end
				else
					return true, roundIndex
				end
			end
		end
	end

	return false, 0
end

function GuideController:_tryTriggerPlayerLevel(guideMO)
	local guideCO = guideMO:getGuideCO()
	local paramstr = guideCO.triggerParam

	if not string.nilorempty(paramstr) then
		local params = string.split(paramstr, "#")

		if #params ~= 2 then
			if enableErrorLog then
				printError("param is not allowed,guideId:" .. guideCO.id .. " params:" .. guideCO.triggerParam)
			end

			return false
		end

		local levelStr = params[1]
		local jumpId = tonumber(params[2])
		local jumpCo = SystemJumpConfig.instance:getJumpInfo(jumpId)

		if not string.nilorempty(levelStr) and jumpCo then
			local targetLevel = tonumber(levelStr)

			if targetLevel <= PlayerModel.instance:getLevel() and ViewMgr.instance:isOpen(jumpCo.viewName) then
				return true
			else
				return false
			end
		end
	end

	return false
end

function GuideController:_tryTriggerOpenView(guideMO)
	local guideCO = guideMO:getGuideCO()
	local paramstr = guideCO.triggerParam

	if not string.nilorempty(paramstr) then
		local params = string.split(paramstr, "#")

		if #params ~= 2 then
			if enableErrorLog then
				printError("param is not allowed,guideId:" .. guideCO.id .. " params:" .. guideCO.triggerParam)
			end

			return false
		end

		local dungeonId = tonumber(params[1])
		local viewNameJumpId = tonumber(params[2])
		local dungeonM0 = DungeonModel.instance:getDungeonMoById(dungeonId)
		local jumpCo = SystemJumpConfig.instance:getJumpInfo(viewNameJumpId)
		local viewName = false
		local extValue1 = false
		local extValue2 = false

		if jumpCo then
			viewName = jumpCo.viewName
			extValue1 = jumpCo.extValue1
			extValue2 = jumpCo.extValue2
		end

		local isFinish = PlayerModel.instance:getPrologueFinished()

		if viewName and ViewMgr.instance:isOpen(viewName) and viewName == ViewName.MainUIView and not isFinish then
			return false
		end

		local sceneFlow = SceneFace.instance:getCurSceneFlow()

		if sceneFlow and sceneFlow.model and sceneFlow.model:getSceneType() == SceneType.Dungeon and jumpCo then
			if extValue1 and extValue1 == "difficulty" then
				local difficulty = sceneFlow.model:getCurDifficulty()
				local chapterId = sceneFlow.model:getChapterId()
				local strList = string.split(jumpCo.extValue2, "-")
				local difficultyCfg = tonumber(strList[2])
				local chapterIdCfg = tonumber(strList[1])

				if chapterIdCfg == chapterId and difficultyCfg == difficulty and dungeonM0 and dungeonM0:hasPassed() and viewName and ViewMgr.instance:isOpen(viewName) then
					print("trigger guide by open view and dungeon", viewName)

					return true
				end
			end
		elseif dungeonM0 and dungeonM0:hasPassed() and not DungeonModel.instance:getIsInBattle() and viewName and ViewMgr.instance:isOpen(viewName) then
			print("trigger guide only open view ", viewName)

			return true
		end
	end

	return false
end

function GuideController:_tryTriggerCloseView(guideMO)
	local guideCO = guideMO:getGuideCO()
	local paramstr = guideCO.triggerParam

	if not string.nilorempty(paramstr) then
		local viewNameJumpId = tonumber(paramstr)
		local jumpCo = SystemJumpConfig.instance:getJumpInfo(viewNameJumpId)

		if jumpCo then
			viewName = jumpCo.viewName
		end

		if viewName and not ViewMgr.instance:isOpen(viewName) then
			return true
		end
	end

	return false
end

function GuideController:_tryTriggerFinishStory(guideMO, targetStoryId)
	local guideCO = guideMO:getGuideCO()
	local paramstr = guideCO.triggerParam

	if not string.nilorempty(paramstr) then
		local storyId = tonumber(paramstr)

		if targetStoryId == storyId then
			return true
		end
	end

	return false
end

function GuideController:_tryTriggerBattleStart(guideMO, curRoundIndex)
	if SceneMgr.instance:getCurSceneType() ~= SceneType.Battle then
		return false, 0
	end

	local activeBattleFlow = BattleMgr.instance:getActiveBattleFlow()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if not dungeonCode and OOPUtil.isInstanceOf(activeBattleFlow, PrefaceBattleFlow) then
		local flow = PrefaceController.instance:getPrefaceBattleFlow()

		if flow then
			dungeonCode = flow.model:getDungeonCode()
		end
	end

	if dungeonCode then
		local guideCO = guideMO:getGuideCO()
		local params = string.split(guideCO.triggerParam, "#")
		local dungeonId = tonumber(params[1])
		local roundIndex = tonumber(params[2])

		if dungeonId == dungeonCode and activeBattleFlow then
			if roundIndex == -1 and curRoundIndex == 0 then
				return true, roundIndex
			elseif roundIndex >= 1 and curRoundIndex == roundIndex then
				if not self._curRound then
					return false, 0
				end

				return true, roundIndex
			end
		end
	end

	return false, 0
end

function GuideController:_tryTriggerBeforeCampAdjustment(guideMO, dungeonCode)
	local activeBattleFlow = BattleMgr.instance:getActiveBattleFlow()

	if not activeBattleFlow then
		return false
	end

	local guideCO = guideMO:getGuideCO()
	local configDungeonCode = checkint(guideCO.triggerParam)

	return configDungeonCode == dungeonCode
end

function GuideController:_tryTriggerRLInPos(guideMO, rogueGuideTb)
	if not rogueGuideTb then
		return false
	end

	if type(rogueGuideTb) ~= "table" then
		return false
	end

	if rogueGuideTb.guideType ~= GuideEnum.GuideRoguelikeTriggerType.Coordinate then
		return false
	end

	local guideCO = guideMO:getGuideCO()
	local paramstr = guideCO.triggerParam

	if not string.nilorempty(paramstr) then
		local params = string.split(paramstr, "#")

		if #params ~= 3 then
			if enableErrorLog then
				printError("param is not allowed,guideId:" .. guideCO.id .. " params:" .. guideCO.triggerParam)
			end

			return false
		end

		local scriptId = tonumber(params[1])
		local mapId = tonumber(params[2])
		local pos = params[3]

		if rogueGuideTb.param1 ~= scriptId then
			return false
		end

		if rogueGuideTb.param2 ~= mapId then
			return false
		end

		if rogueGuideTb.param3 ~= pos then
			return false
		end

		return true
	end

	return false
end

function GuideController:_tryTriggerRLInEvent(guideMO, rogueGuideTb)
	if not rogueGuideTb then
		return false
	end

	if type(rogueGuideTb) ~= "table" then
		return false
	end

	if rogueGuideTb.guideType ~= GuideEnum.GuideRoguelikeTriggerType.Event then
		return false
	end

	local guideCO = guideMO:getGuideCO()
	local paramstr = guideCO.triggerParam

	if not string.nilorempty(paramstr) then
		local params = string.split(paramstr, "#")

		if #params ~= 1 then
			if enableErrorLog then
				printError("param is not allowed,guideId:" .. guideCO.id .. " params:" .. guideCO.triggerParam)
			end

			return false
		end

		local eventId = tonumber(params[1])

		if rogueGuideTb.param1 ~= eventId then
			return false
		end

		return true
	end

	return false
end

function GuideController:_tryTriggerRLByMonster(guideMO, rogueGuideTb)
	if not rogueGuideTb then
		return false
	end

	if type(rogueGuideTb) ~= "table" then
		return false
	end

	if rogueGuideTb.guideType ~= GuideEnum.GuideRoguelikeTriggerType.Monster then
		return false
	end

	local guideCO = guideMO:getGuideCO()
	local paramstr = guideCO.triggerParam

	if not string.nilorempty(paramstr) then
		local params = string.split(paramstr, "#")

		if #params ~= 1 then
			if enableErrorLog then
				printError("param is not allowed,guideId:" .. guideCO.id .. " params:" .. guideCO.triggerParam)
			end

			return false
		end

		local monsterId = tonumber(params[1])

		if rogueGuideTb.param1 ~= monsterId then
			return false
		end

		return true
	end

	return false
end

function GuideController:_tryTriggerRLCalcReultByType(guideMO, rogueGuideTb)
	if not rogueGuideTb then
		return false
	end

	if type(rogueGuideTb) ~= "table" then
		return false
	end

	if rogueGuideTb.guideType ~= GuideEnum.GuideRoguelikeTriggerType.JudgeType then
		return false
	end

	local guideCO = guideMO:getGuideCO()
	local paramstr = guideCO.triggerParam

	if not string.nilorempty(paramstr) then
		local params = string.split(paramstr, "#")

		if #params ~= 1 then
			if enableErrorLog then
				printError("param is not allowed,guideId:" .. guideCO.id .. " params:" .. guideCO.triggerParam)
			end

			return false
		end

		local curType = tonumber(params[1])

		if rogueGuideTb.param1 ~= curType then
			return false
		end

		return true
	end

	return false
end

function GuideController:_tryTriggerRLActiveUI(guideMO, rogueGuideTb)
	if not rogueGuideTb then
		return false
	end

	if type(rogueGuideTb) ~= "table" then
		return false
	end

	if rogueGuideTb.guideType ~= GuideEnum.GuideRoguelikeTriggerType.ActiveUI then
		return false
	end

	local guideCO = guideMO:getGuideCO()
	local paramstr = guideCO.triggerParam

	if not string.nilorempty(paramstr) then
		local params = string.split(paramstr, "#")

		if #params ~= 2 then
			if enableErrorLog then
				printError("param is not allowed,guideId:" .. guideCO.id .. " params:" .. guideCO.triggerParam)
			end

			return false
		end

		local jumpId = tonumber(params[1])
		local uiObjName = params[2]
		local curObj = rogueGuideTb.param2
		local jumpCo = SystemJumpConfig.instance:getJumpInfo(jumpId)

		if jumpCo and not string.nilorempty(uiObjName) and not goutil.isNil(curObj) then
			if curObj.activeSelf and curObj.name == uiObjName and ViewMgr.instance:isOpen(jumpCo.viewName) and jumpCo.viewName == rogueGuideTb.param1 then
				return true
			else
				return false
			end
		else
			return false
		end

		if rogueGuideTb.param1 ~= curType then
			return false
		end

		return true
	end

	return false
end

function GuideController:_onDoClickScreen()
	if not self._isGuiding then
		return
	end

	if BattleMgr.instance:isInBattle() and SkillPerformanceMgr.instance:isInPerformance() then
		return
	end

	if self._toStartGuideSteps then
		local guideStep = GuideConfig.instance:getGuideStepCO(self._guideId, self._toStartGuideSteps[self._curIndex])

		if guideStep and guideStep.completeType == GuideEnum.CompleteType.CloseFullImageGuide and guideStep.guideControlType == GuideEnum.GuideControlType.ShowFullScreenImageGuide then
			return
		end
	end

	if Time.time - self._curTime > self._totalTime then
		self._curTime = 0
		self._clickTimes = 0
	end

	self._clickTimes = self._clickTimes + 1

	if self._clickTimes == 1 then
		self._curTime = Time.time
	end

	if Time.time - self._curTime <= self._totalTime and self._clickTimes >= self._maxClickTimes then
		if self._guideId then
			self._clickTimes = 0
			self._curTime = Time.time

			if not self._isShowJumpGuide then
				local guideIds = ConstConfig.instance:getNumValuesByKey(ConstConfigKeyEnum.SpecialLotteryGuideId)

				if guideIds and #guideIds ~= 2 then
					if enableErrorLog then
						printError("GuideController::tryEnterFirstScene faild..")
					end

					return
				end

				local preconditionGuideId = guideIds[1]
				local secGuideId = guideIds[2]

				if self._guideId == preconditionGuideId then
					return
				elseif self._guideId == secGuideId then
					return
				end

				self._isShowJumpGuide = true

				GlobalDispatcher:dispatchEvent(EventType.SHOW_SKIP_GUIDE_INFO, true)
			end
		end

		return
	end
end

function GuideController:_onDisconnectServer()
	self:oneKeyFinishGuide(self._guideId, true, false, false)
end

function GuideController:_onBattleEnterFinish()
	self._curBattleGuideList = {}
end

function GuideController:_onBattleRestart(evt)
	self:_processBattleGuide(false)
end

function GuideController:_onBeforeCampAdjustmentGuide(evt, dungeonCode)
	self:_checkExecGuide(dungeonCode)
end

function GuideController:_onBattleExitFinish(key, isWin)
	local activeBattleFlow = BattleMgr.instance:getActiveBattleFlow()
	local dungeonFlow = DungeonController.instance:getDungeonBattleFlow()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	print("preupload guide info,current dungeon code:", dungeonCode)

	if dungeonFlow then
		local dungeonType = dungeonFlow.model:getDungeonType()

		dungeonCode = dungeonFlow.model:getDungeonCode()

		if dungeonType == CommEnum.DungeonType.HeroEarlyAccess then
			if enableLog then
				printInfo("GuideController::_onBattleExitFinish", dungeonType)
			end

			return
		end
	end

	if dungeonFlow and isWin then
		local dungeonId = dungeonFlow.model:getDungeonCode()

		self:checkHeroPowerInfoGuide(dungeonId)
	end

	if OOPUtil.isInstanceOf(activeBattleFlow, PrefaceBattleFlow) then
		local levelCode = activeBattleFlow:getBattleLevelCode()
		local allDungeonIds = ConstConfig.instance:getNumValuesByKey(ConstConfigKeyEnum.PrologueDungeons)

		if #allDungeonIds == 1 and allDungeonIds[1] == levelCode then
			self:_processBattleGuide(true, dungeonCode)

			return
		end
	end

	self:_processBattleGuide(isWin, dungeonCode)
end

function GuideController:_processBattleGuide(isWin, dungeonCode)
	if isWin then
		local list = GuideModel.instance:getAllGuides()

		for _, v in pairs(list) do
			local guideMO = v

			if not guideMO.isFinish and guideMO:isOnLine() and guideMO:getIsBattleGuide() then
				local guideCO = v:getGuideCO()

				if not string.nilorempty(guideCO.triggerParam) then
					local params = string.split(guideCO.triggerParam, "#")
					local dungeonId = tonumber(params[1])

					if dungeonId == dungeonCode then
						local hasContain = false

						for i = 1, #self._curBattleGuideList do
							if self._curBattleGuideList[i] == guideMO.id then
								hasContain = true

								break
							end
						end

						print("preupload guide id:", guideMO.id)

						if not hasContain then
							table.insert(self._curBattleGuideList, guideMO.id)
						end
					end
				end
			end
		end
	end

	if self._curBattleGuideList then
		local len = #self._curBattleGuideList

		if len > 0 then
			for i = 1, len do
				local guideId = self._curBattleGuideList[i]

				if isWin then
					local guideMO = GuideModel.instance:getGuideMO(guideId)
					local allStepS = guideMO:getAllStepIds()

					GuideAgent.instance:sendFinishGuideRequest(guideId, 1, allStepS[#allStepS])
				else
					local guideMO = GuideModel.instance:getGuideMO(guideId)

					if guideMO then
						guideMO:setGuideState(false)
						guideMO:trySetOpenSytemState(false)
					end
				end
			end
		end
	end

	table.clear(self._curBattleGuideList)

	self._curBattleGuideList = {}
end

function GuideController:passCurGuide()
	self:_onPassCurGuide()
	self:pauseGuideEvent(false)
end

function GuideController:updateJumpGuideInfo(active)
	self._isShowJumpGuide = active
end

function GuideController:_onPassCurGuide()
	self._isShowJumpGuide = false

	self:finishStep(self._guideId, nil, true)
	GlobalDispatcher:dispatchEvent(EventType.PASS_GUIDE_BY_CLICK, self._guideId)
end

function GuideController:finishRoguelikeGuides()
	local allRoguelikeGuideIds

	if allRoguelikeGuideIds then
		for _, v in pairs(allRoguelikeGuideIds) do
			self:finishStep(v, nil, true)
		end
	end
end

function GuideController:_onClosePassCurGuide()
	self._isShowJumpGuide = false

	self:pauseGuideEvent(false)
end

function GuideController:oneKeyFinishGuides()
	local list = GuideModel.instance:getAllGuides()

	for _, v in pairs(list) do
		local guideMO = v

		if not guideMO.isFinish then
			print("One key finish guides")
			self:oneKeyFinishGuide(guideId, true, true, true)
		end
	end
end

function GuideController:oneKeyFinishGuide(guideId, closeGuide, needSave, force)
	if needSave then
		GuideModel.instance:setFinishGuide(guideId)

		local passType = force and 2 or 1
		local guideMO = GuideModel.instance:getGuideMO(guideId)
		local lastStepId = self._toStartGuideSteps and self._toStartGuideSteps[self._curIndex] or 0

		GuideAgent.instance:sendFinishGuideRequest(guideId, passType, lastStepId)
		UserUtil.uploadGuideBuryPoint(guideMO, false, passType, lastStepId)
		self:finishLinkGuides(guideId, passType)

		if force then
			self:finishExceptionGuides(guideId)
		end
	end

	if GuideModel.instance:isFinishedAllForceGuide() then
		self:_unregisterGuideNotity()
	end

	if closeGuide then
		self:closeGuide()
	end
end

function GuideController:_finishExceptionByClient(guideId)
	self:_activeUIByException(guideId)

	local guideMO = GuideModel.instance:getGuideMO(guideId)

	if guideMO then
		local guideCO = guideMO:getGuideCO()

		if guideCO then
			local exceptionGuides = guideCO.exceptionGuides or {}

			for i = 1, #exceptionGuides do
				local curGuideId = exceptionGuides[i]
				local curGuideMo = GuideModel.instance:getGuideMO(curGuideId)

				if curGuideMo then
					local stepId = curGuideMo:getAllStepIds() and curGuideMo:getAllStepIds()[1] or 0

					GuideModel.instance:setFinishGuide(curGuideId)
					GuideModel.instance:setOpenSytemState(curGuideId, true)
					guideMO:setGuideState(true)
					table.insert(self._curBattleGuideList, curGuideId)
					self:_activeUIByException(curGuideId)
				end
			end
		end
	end
end

function GuideController:finishExceptionGuides(guideId)
	self:_activeUIByException(guideId)

	local guideMO = GuideModel.instance:getGuideMO(guideId)

	if guideMO then
		local guideCO = guideMO:getGuideCO()

		if guideCO then
			local exceptionGuides = guideCO.exceptionGuides or {}

			for i = 1, #exceptionGuides do
				local curGuideId = exceptionGuides[i]
				local curGuideMo = GuideModel.instance:getGuideMO(curGuideId)

				if curGuideMo then
					local stepId = curGuideMo:getAllStepIds() and curGuideMo:getAllStepIds()[1] or 0

					GuideModel.instance:setFinishGuide(curGuideId)
					GuideAgent.instance:sendFinishGuideRequest(curGuideId, 2, stepId)
					UserUtil.uploadGuideBuryPoint(guideMO, false, 2, stepId)
					self:_activeUIByException(curGuideId)
				end
			end
		end
	end
end

function GuideController:_activeUIByException(guideId)
	if not guideId then
		return
	end

	local curGuideMo = GuideModel.instance:getGuideMO(guideId)

	if curGuideMo then
		local stepIds = curGuideMo:getAllStepIds()

		for _, stepId in pairs(stepIds) do
			local stepCO = GuideConfig.instance:getGuideStepCO(guideId, stepId)

			if stepCO and stepCO.guideControlType == GuideEnum.GuideControlType.ActiveUI and not string.nilorempty(stepCO.guideControlParam) then
				local guideComponent = goutil.find(stepCO.guideControlParam)

				if guideComponent then
					goutil.setActive(guideComponent, true)
				end
			end
		end
	end
end

function GuideController:finishLinkGuides(guideId, passType)
	local guideMO = GuideModel.instance:getGuideMO(guideId)

	if guideMO then
		local guideCO = guideMO:getGuideCO()

		if guideCO then
			local linkToFinishs = guideCO.linkToFinish or {}

			for i = 1, #linkToFinishs do
				local curGuideId = linkToFinishs[i]
				local curGuideMo = GuideModel.instance:getGuideMO(curGuideId)

				if curGuideMo then
					local stepId = curGuideMo:getAllStepIds() and curGuideMo:getAllStepIds()[1] or 0

					GuideModel.instance:setFinishGuide(curGuideId)
					GuideAgent.instance:sendFinishGuideRequest(curGuideId, passType, stepId)
					UserUtil.uploadGuideBuryPoint(curGuideMo, false, passType, stepId)
					print("关联完成引导ID 类型 步骤ID", curGuideId, passType, stepId)
					self:_activeUIByException(curGuideId)
				end
			end
		end
	end
end

function GuideController:openGuideView(stepCO, callback, callbackSelf, guideBtnCallBack)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		GlobalDispatcher:dispatchEvent(EventType.TRIGGER_GUIDE, {
			stepCO = stepCO,
			callback = callback,
			callbackSelf = callbackSelf,
			btnCallBack = guideBtnCallBack
		})
	else
		ViewMgr.instance:openSpecialView(ViewName.GuideView, {
			stepCO = stepCO,
			callback = callback,
			callbackSelf = callbackSelf,
			btnCallBack = guideBtnCallBack
		})
	end
end

function GuideController:pauseGuideEvent(pauseGuideEvent)
	GlobalDispatcher:dispatchEvent(EventType.PAUSE_GUIDE_EVENT, pauseGuideEvent)
end

function GuideController:showJumpGuideDialog()
	return self._isShowJumpGuide
end

function GuideController:tryForceFinishGuide()
	local toFinishList = {}
	local list = GuideModel.instance:getDoingGuideIdList()

	if list then
		for i = 1, #list do
			local guideMO = GuideModel.instance:getGuideMO(list[i])
			local guideCO = guideMO:getGuideCO()

			if guideCO and guideMO:getIsBattleGuide() then
				local params = string.split(guideCO.triggerParam, "#")
				local dungeonId = tonumber(params[1])
				local hasFinishStages = PlayerModel.instance:getPrologueStages()
				local len = #hasFinishStages

				if len == 0 then
					local allDungeonIds = ConstConfig.instance:getNumValuesByKey(ConstConfigKeyEnum.PrologueDungeons)

					for j = 1, #allDungeonIds do
						if allDungeonIds[j] == dungeonId then
							table.insert(toFinishList, list[i])
						end
					end
				end

				local hasPass = DungeonMainLineChapterModel.instance:hasDungeonPassed(dungeonId)

				if hasPass then
					table.insert(toFinishList, list[i])
				end
			end
		end
	end

	if #toFinishList > 0 then
		for i = 1, #toFinishList do
			local guideId = toFinishList[i]
			local guideMO = GuideModel.instance:getGuideMO(guideId)

			if guideMO then
				local allStepS = guideMO:getAllStepIds()

				GuideAgent.instance:sendFinishGuideRequest(guideId, 2, allStepS[#allStepS])
				UserUtil.uploadGuideBuryPoint(guideMO, false, 2, allStepS[#allStepS])
			end
		end
	end
end

function GuideController:tryEnterFirstScene()
	local guideIds = ConstConfig.instance:getNumValuesByKey(ConstConfigKeyEnum.SpecialLotteryGuideId)

	if guideIds and #guideIds ~= 2 then
		if enableErrorLog then
			printError("GuideController::tryEnterFirstScene faild..")
		end

		self:_enterMainScene()

		return
	end

	local preconditionGuideId = guideIds[1]
	local targetGuideID = guideIds[2]
	local isPreconditionFinish = GuideModel.instance:isGuideFinish(preconditionGuideId)
	local isFinish = GuideModel.instance:isGuideFinish(targetGuideID)

	if isPreconditionFinish and isFinish then
		self:_enterMainScene()
	else
		local heroMo = HeroDepotModel.instance:getHeroInfoByID(2000016)

		if heroMo then
			self:oneKeyFinishGuide(preconditionGuideId, false, true, true)
			self:oneKeyFinishGuide(targetGuideID, false, true, true)
			self:_enterMainScene()

			return
		end

		if not isPreconditionFinish then
			ViewMgr.instance:preCreate(ViewName.PlayerCreateMain)
		end

		self:_enterLotteryScene()
	end
end

function GuideController:_enterMainScene()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function GuideController:_enterLotteryScene()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Lottery, false) then
		if enableLog then
			printInfo("功能未开启，先进主场景")
		end

		self:_enterMainScene()

		return
	end

	RetrieveController.instance:enterScene()
end

function GuideController:checkHeroPowerInfoGuide(curDungeonCode)
	local qinHeDuArgs = ConstConfig.instance:getStrValueByKey(ConstConfigKeyEnum.SpecialQinHeDuArgKey)
	local qinheArgArray = string.split(qinHeDuArgs, "#")

	if qinheArgArray and #qinheArgArray ~= 4 then
		if enableErrorLog then
			printError("GuideController::checkHeroPowerInfoGuide faild,SpecialQinHeDuArgKey in const.")
		end

		return
	end

	local dungeonId = tonumber(qinheArgArray[1])

	if curDungeonCode ~= dungeonId then
		return
	end

	local heroId = tonumber(qinheArgArray[2])
	local tempNode = string.split(qinheArgArray[3], "-")
	local firstNodeInfo = {
		nodeCount = tonumber(tempNode[1]),
		guideId = tonumber(tempNode[2])
	}

	tempNode = string.split(qinheArgArray[4], "-")

	local secNodeInfo = {
		nodeCount = tonumber(tempNode[1]),
		guideId = tonumber(tempNode[2])
	}

	HeroPowerAgent.instance:sendHeroPowerInfoRequest(heroId, function()
		local curUnlockCount = CharacterAuthorityModel.instance:getAllNodeUnlockCount(heroId)

		if curUnlockCount == firstNodeInfo.nodeCount then
			local isFinish = GuideModel.instance:isGuideFinish(secNodeInfo.guideId)

			if not isFinish then
				self:oneKeyFinishGuide(secNodeInfo.guideId, false, true, true)
			end
		elseif curUnlockCount == secNodeInfo.nodeCount then
			local isFinish = GuideModel.instance:isGuideFinish(firstNodeInfo.guideId)

			if not isFinish then
				self:oneKeyFinishGuide(firstNodeInfo.guideId, false, true, true)
			end
		else
			if curUnlockCount < secNodeInfo.nodeCount then
				return
			end

			local isFirstFinish = GuideModel.instance:isGuideFinish(firstNodeInfo.guideId)

			if not isFirstFinish then
				self:oneKeyFinishGuide(firstNodeInfo.guideId, false, true, true)
			end

			local isSecFinish = GuideModel.instance:isGuideFinish(secNodeInfo.guideId)

			if not isSecFinish then
				self:oneKeyFinishGuide(secNodeInfo.guideId, false, true, true)
			end
		end
	end, self)
end

function GuideController:canTriggerGuide(curDungeonId, curRoundIndex)
	local list = GuideModel.instance:getDoingGuideIdList()

	if list then
		for i = 1, #list do
			local guideMO = GuideModel.instance:getGuideMO(list[i])
			local guideCO = guideMO:getGuideCO()

			if guideCO and guideMO:getIsBattleGuide() then
				local params = string.split(guideCO.triggerParam, "#")
				local dungeonId = tonumber(params[1])
				local roundIndex = tonumber(params[2])

				if curDungeonId == dungeonId and roundIndex == curRoundIndex then
					return true
				end
			end
		end
	end

	return false
end

GuideController.instance = GuideController.New()

return GuideController
