-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\OpActivityObject.lua

local ChannelUtil = ChannelUtil
local EventConst = require("EventConst")
local ResOpActivityClientTemplate = require("ClientData/ResOpActivityClientTemplate")
local ResOpActivityTemplate = require("ClientData/ResOpActivityTemplate")
local ResOpActivityOpenMgr = require("ClientData/ResOpActivityOpenMgr")
local ResOpActivityReflux = require("ClientData/ResOpActivityReflux")
local ResEventTrigger = require("ClientData/ResEventTrigger")
local ActivityDataAchieve = require("Avatar/AvatarMixins/OpActivity/ActivityDataAchieve")
local ActivityDataGift = require("Avatar/AvatarMixins/OpActivity/ActivityDataGift")
local ActivityDataMonopoly = require("Avatar/AvatarMixins/OpActivity/ActivityDataMonopoly")
local ActivityDataShop = require("Avatar/AvatarMixins/OpActivity/ActivityDataShop")
local ActivityDataDeposit = require("Avatar/AvatarMixins/OpActivity/ActivityDataDeposit")
local ActivityDataBingo = require("Avatar/AvatarMixins/OpActivity/ActivityDataBingo")
local ActivityDataDraw = require("Avatar/AvatarMixins/OpActivity/ActivityDataDraw")
local ActivityDataPlot = require("Avatar/AvatarMixins/OpActivity/ActivityDataPlot")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ActivityDataWorldBoss = require("Avatar/AvatarMixins/OpActivity/ActivityDataWorldBoss")
local ActivityDataRechargeRebate = require("Avatar/AvatarMixins/OpActivity/ActivityDataRechargeRebate")
local ActivityDataReplacePool = require("Avatar/AvatarMixins/OpActivity/ActivityDataReplacePool")
local ActivityDataLottery = require("Avatar/AvatarMixins/OpActivity/ActivityDataLottery")
local ActivityDataArena = require("Avatar/AvatarMixins/OpActivity/ActivityDataArena")
local ActivityDataWishSignIn = require("Avatar/AvatarMixins/OpActivity/ActivityDataWishSignIn")
local ActivityDataSeasonTower = require("Avatar/AvatarMixins/OpActivity/ActivityDataSeasonTower")
local ActivityDataFirePlace = require("Avatar/AvatarMixins/OpActivity/ActivityDataFirePlace")
local ActivityDataStageDeposit = require("Avatar/AvatarMixins/OpActivity/ActivityDataStageDeposit")
local ActivityDataRentUp = require("Avatar/AvatarMixins/OpActivity/ActivityDataRentUp")
local ActivityDataPrivilege = require("Avatar/AvatarMixins/OpActivity/ActivityDataPrivilege")
local ActivityDataNewYearDinner = require("Avatar/AvatarMixins/OpActivity/ActivityDataNewYearDinner")
local ActivityDataHatsuneMiku = require("Avatar/AvatarMixins/OpActivity/ActivityDataHatsuneMiku")
local ActivityDataCircleBattle = require("Avatar/AvatarMixins/OpActivity/ActivityDataCircleBattle")
local ActivityDataClanClear = require("Avatar/AvatarMixins/OpActivity/ActivityDataClanClear")
local ActivityDataFashionLottery = require("Avatar/AvatarMixins/OpActivity/ActivityDataFashionLottery")
local ActivityDataCollectWords = require("Avatar/AvatarMixins/OpActivity/ActivityDataCollectWords")
local ActivityDataCatRace = require("Avatar/AvatarMixins/OpActivity/ActivityDataCatRace")
local ActivityDataNewMaze = require("Avatar/AvatarMixins/OpActivity/ActivityDataNewMaze")
local ActivityDataValentine = require("Avatar/AvatarMixins/OpActivity/ActivityDataValentine")
local ActivityDataSendHero = require("Avatar/AvatarMixins/OpActivity/ActivityDataSendHero")
local ActivityDataConsumeReplace = require("Avatar/AvatarMixins/OpActivity/ActivityDataConsumeReplace")
local ActivityDataFigureGuess = require("Avatar/AvatarMixins/OpActivity/ActivityDataFigureGuess")
local ActivityDataPetMaze = require("Avatar/AvatarMixins/OpActivity/ActivityDataPetMaze")
local ActivityDataTopPvp = require("Avatar/AvatarMixins/OpActivity/ActivityDataTopPvp")
local ActivityDataPetDraw = require("Avatar/AvatarMixins/OpActivity/ActivityDataPetDraw")
local ActivityDataManagement = require("Avatar/AvatarMixins/OpActivity/ActivityDataManagement")
local ActivityDataTurnTable = require("Avatar/AvatarMixins/OpActivity/ActivityDataTurnTable")
local ActivityDataBuyGiftDraw = require("Avatar/AvatarMixins/OpActivity/ActivityDataBuyGiftDraw")
local ActivityDataEquipRefine = require("Avatar/AvatarMixins/OpActivity/ActivityDataEquipRefine")
local ActivityDataDrawNewBieUp = require("Avatar/AvatarMixins/OpActivity/ActivityDataDrawNewBieUp")
local ActivityDataRandReplace = require("Avatar/AvatarMixins/OpActivity/ActivityDataRandReplace")
local ActivityDataDrawNewbieLight = require("Avatar/AvatarMixins/OpActivity/ActivityDataDrawNewbieLight")
local ActivityDataSneakBattle = require("Avatar/AvatarMixins/OpActivity/ActivityDataSneakBattle")
local ActivityDataEquipRecycle = require("Avatar/AvatarMixins/OpActivity/ActivityDataEquipRecycle")
local ActivityDataSeasonDraw = require("Avatar/AvatarMixins/OpActivity/ActivityDataSeasonDraw")
local EVENT_TRIGGER_ACT = {}

for _, info in pairs(ResEventTrigger) do
	if info.tmpl_id then
		EVENT_TRIGGER_ACT[info.tmpl_id] = info
	end
end

local OpActivityObject = Class("OpActivityObject")

function OpActivityObject:ctor(opId, actId, actType)
	self.opId = opId
	self.actType = actType

	self:createActData()
	self:_confirmActId(actId)

	self.curState = Const.OPACT_STATE_CLOSE

	self:onCheckUnlockActivity()
end

function OpActivityObject:createActData()
	if self.actType == Const.ACT_TYPE_ACHIEVE then
		self.actData = ActivityDataAchieve(self)
	elseif self.actType == Const.ACT_TYPE_GIFT then
		self.actData = ActivityDataGift(self)
	elseif self.actType == Const.ACT_TYPE_MONOPOLY then
		self.actData = ActivityDataMonopoly(self)
	elseif self.actType == Const.ACT_TYPE_SHOP then
		self.actData = ActivityDataShop(self)
	elseif self.actType == Const.ACT_TYPE_DEPOSIT then
		self.actData = ActivityDataDeposit(self)
	elseif self.actType == Const.ACT_TYPE_BINGO then
		self.actData = ActivityDataBingo(self)
	elseif self.actType == Const.ACT_TYPE_UPDRAW then
		self.actData = ActivityDataDraw(self)
	elseif self.actType == Const.ACT_TYPE_PLOT then
		self.actData = ActivityDataPlot(self)
	elseif self.actType == Const.ACT_TYPE_WORLD_BOSS then
		self.actData = ActivityDataWorldBoss(self)
	elseif self.actType == Const.ACT_TYPE_RECHARGE_REBATE then
		self.actData = ActivityDataRechargeRebate(self)
	elseif self.actType == Const.ACT_TYPE_REPLACE_POOL then
		self.actData = ActivityDataReplacePool(self)
	elseif self.actType == Const.ACT_TYPE_LOTTERY then
		self.actData = ActivityDataLottery(self)
	elseif self.actType == Const.ACT_TYPE_ARENA then
		self.actData = ActivityDataArena(self)
	elseif self.actType == Const.ACT_TYPE_WISH then
		self.actData = ActivityDataWishSignIn(self)
	elseif self.actType == Const.ACT_TYPE_SEASON_TOWER then
		self.actData = ActivityDataSeasonTower(self)
	elseif self.actType == Const.ACT_TYPE_FIREPLACE then
		self.actData = ActivityDataFirePlace(self)
	elseif self.actType == Const.ACT_TYPE_STAGE_DEPOSIT then
		self.actData = ActivityDataStageDeposit(self)
	elseif self.actType == Const.ACT_TYPE_RENT_UP then
		self.actData = ActivityDataRentUp(self)
	elseif self.actType == Const.ACT_TYPE_PRIVILEGE then
		self.actData = ActivityDataPrivilege(self)
	elseif self.actType == Const.ACT_TYPE_NEW_YEAR_DINNER then
		self.actData = ActivityDataNewYearDinner(self)
	elseif self.actType == Const.ACT_TYPE_Hatsune then
		self.actData = ActivityDataHatsuneMiku(self)
	elseif self.actType == Const.ACT_TYPE_CIRCLE_BATTLE then
		self.actData = ActivityDataCircleBattle(self)
	elseif self.actType == Const.ACT_TYPE_CLAN_CLEAR then
		self.actData = ActivityDataClanClear(self)
	elseif self.actType == Const.ACT_TYPE_FASHION_LOTTERY then
		self.actData = ActivityDataFashionLottery(self)
	elseif self.actType == Const.ACT_TYPE_COLLECT_WORDS then
		self.actData = ActivityDataCollectWords(self)
	elseif self.actType == Const.ACT_TYPE_CAT_RACE then
		self.actData = ActivityDataCatRace(self)
	elseif self.actType == Const.ACT_TYPE_NEW_MAZE then
		self.actData = ActivityDataNewMaze(self)
	elseif self.actType == Const.ACT_TYPE_VALENTINE then
		self.actData = ActivityDataValentine(self)
	elseif self.actType == Const.ACT_TYPE_SEND_HERO then
		self.actData = ActivityDataSendHero(self)
	elseif self.actType == Const.ACT_TYPE_CONSUME_REPLACE then
		self.actData = ActivityDataConsumeReplace(self)
	elseif self.actType == Const.ACT_TYPE_GUESS then
		self.actData = ActivityDataFigureGuess(self)
	elseif self.actType == Const.ACT_TYPE_PET_MAZE then
		self.actData = ActivityDataPetMaze(self)
	elseif self.actType == Const.ACT_TYPE_TOPPVP then
		self.actData = ActivityDataTopPvp(self)
	elseif self.actType == Const.ACT_TYPE_PET_DRAW then
		self.actData = ActivityDataPetDraw(self)
	elseif self.actType == Const.ACT_TYPE_MANAGEMENT then
		self.actData = ActivityDataManagement(self)
	elseif self.actType == Const.ACT_TYPE_TURNTABLE then
		self.actData = ActivityDataTurnTable(self)
	elseif self.actType == Const.ACT_TYPE_BUYGIFT_DRAW then
		self.actData = ActivityDataBuyGiftDraw(self)
	elseif self.actType == Const.ACT_TYPE_EQUIP_REFINE then
		self.actData = ActivityDataEquipRefine(self)
	elseif self.actType == Const.ACT_TYPE_DRAW_NEWBIE_UP then
		self.actData = ActivityDataDrawNewBieUp(self)
	elseif self.actType == Const.ACT_TYPE_RAND_REPLACE then
		self.actData = ActivityDataRandReplace(self)
	elseif self.actType == Const.ACT_TYPE_DRAW_NEWBIE_CAMP then
		self.actData = ActivityDataDrawNewbieLight(self)
	elseif self.actType == Const.ACT_TYPE_SNEAK_BATTLE then
		self.actData = ActivityDataSneakBattle(self)
	elseif self.actType == Const.ACT_TYPE_EQUIP_RECYCLE then
		self.actData = ActivityDataEquipRecycle(self)
	elseif self.actType == Const.ACT_TYPE_SEASON_DRAW then
		self.actData = ActivityDataSeasonDraw(self)
	else
		self.actData = ActivityDataBase(self)
	end
end

function OpActivityObject:_confirmActId(actId)
	self.actId = actId
	self.templateData = ResOpActivityTemplate[self.actId] or {}

	self.actData:updateClientData(self.actId)

	self.limitId = self.actData:getLimitId() or self.templateData.condition_id
	self.onceNewMode = self.templateData.once_new_mode
	self.limitIdGroup = self.actData:getlimitIdGroup() or {}

	if self.limitId then
		self.limitUnlockDesc = ConditionLimitManager.getLimitUnlockDesc(self.limitId)
	end

	if self.templateData.client_template then
		self.clientTemplateData = ResOpActivityClientTemplate[self.templateData.client_template[1]]
	end

	if ResOpActivityOpenMgr[actId] or ResOpActivityReflux[actId] or EVENT_TRIGGER_ACT[actId] then
		self.serverDecide = false
	else
		self.serverDecide = true
	end

	self:_addRDEvent()
end

function OpActivityObject:destroy()
	self.actData:unRegistRDEvent()
	self.actData:unRegistEndEvent()
	self.actData:destroy()
end

function OpActivityObject:updateMgrData(actType, actId, opActivityMgrItem, crossData)
	if self.actId ~= actId then
		self:_confirmActId(actId)
	end

	self.opActivityMgrItem = opActivityMgrItem

	self.actData:updateMgrData(opActivityMgrItem, crossData)

	if self.serverDecide then
		self:onStateChange(opActivityMgrItem.state)
		self:refreshEndTime()
	else
		self:checkClientState()
	end

	self:checkNew()
	self:onMgrDataReady()
end

function OpActivityObject:onMgrDataReady()
	self:onCheckLockActivity()
	self:onCheckUnlockActivity()
	self.actData:onMgrDataReady()
end

function OpActivityObject:updateSystemData(opActivitySystemItem)
	if self.actData then
		self.actData:updateSystemData(opActivitySystemItem)
	end
end

function OpActivityObject:onServerStateChange(opActState)
	if self.serverDecide then
		local neeResetUI = self:onStateChange(opActState)

		if neeResetUI then
			self:refreshUI()
		end

		self.actData:onServerStateChange(opActState)
	end
end

function OpActivityObject:updateRoleData(roleData, roleCommonData, fromDataUpdate)
	self.roleData = roleData
	self.roleCommonData = roleCommonData

	self.actData:updateRoleData(roleData, fromDataUpdate)
	self:checkClientState()

	if fromDataUpdate then
		self:refreshUI()
	end

	self:checkNew()
	self:onCheckLockActivity(fromDataUpdate)
end

function OpActivityObject:getActivityWindows()
	if self.actId and self.clientTemplateData then
		local templateType = self.clientTemplateData.template_type
		local config = UIConst.ACTIVITY_TEMPLATE_TYPE_CONFIG[templateType]

		if config then
			if config[2] == UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER then
				return UIManager.tryGetUI("activityMainDlg")
			elseif config[2] == UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW then
				return UIManager.tryGetUI(config[1])
			end
		end
	end
end

function OpActivityObject:getActivityRelatedWindows()
	if UIConst.ACTIVITY_RELATED_CONFIG[self.actId] then
		local windowName = UIConst.ACTIVITY_RELATED_CONFIG[self.actId][1]

		if windowName then
			return UIManager.tryGetUI(windowName), UIConst.ACTIVITY_RELATED_CONFIG[self.actId]
		end
	end
end

function OpActivityObject:refreshUI()
	if self.templateData.client_template then
		for _, tId in ipairs(self.templateData.client_template) do
			local clientTemplateData = ResOpActivityClientTemplate[tId]

			if clientTemplateData and clientTemplateData.template_type then
				local templateType = clientTemplateData.template_type
				local config = UIConst.ACTIVITY_TEMPLATE_TYPE_CONFIG[templateType]

				if config then
					if config[2] == UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER then
						local mainDlg = UIManager.tryGetUI("activityMainDlg")

						if mainDlg then
							mainDlg:updateActivityData(self)
						end
					elseif config[2] == UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW then
						local windowDlg = UIManager.tryGetUI(config[1])

						if windowDlg and windowDlg.updateActivityData then
							windowDlg:updateActivityData(self)
						end
					end
				end
			end
		end
	end

	if UIConst.ACTIVITY_RELATED_CONFIG[self.actId] then
		local windowName = UIConst.ACTIVITY_RELATED_CONFIG[self.actId][1]
		local windowDlg = windowName and UIManager.tryGetUI(windowName) or nil

		if windowDlg and windowDlg.updateRelatedActivityData then
			windowDlg:updateRelatedActivityData(self, UIConst.ACTIVITY_RELATED_CONFIG[self.actId][2])
		end
	end

	if UIConst.ACTIVITY_MUTIACHIEVE_RELATE_CONFIG[self.actId] then
		local windowName = UIConst.ACTIVITY_MUTIACHIEVE_RELATE_CONFIG[self.actId][1]
		local windowDlg = windowName and UIManager.tryGetUI(windowName) or nil

		if windowDlg and windowDlg.updateRelatedActivityData then
			windowDlg:updateRelatedActivityData(self, UIConst.ACTIVITY_MUTIACHIEVE_RELATE_CONFIG[self.actId][2])
		end
	end

	EventCenter.sendEvent(EventConst.ACTIVITY_DATA_CHANGE, self.opId, self.actType)
end

function OpActivityObject:checkClientState()
	if self.serverDecide then
		return
	end

	if self.opActivityMgrItem and self.roleCommonData then
		self:setEndTime(self.roleCommonData.end_time)

		if ClientUtils.getServerTime() >= self.endTime then
			if self.actData and self.actData.checkActivityExtraOpen then
				if self.actData:checkActivityExtraOpen() then
					self:onStateChange(Const.OPACT_STATE_OPEN)
				else
					self:onStateChange(Const.OPACT_STATE_CLOSE)
				end
			else
				self:onStateChange(Const.OPACT_STATE_CLOSE)
			end
		else
			self:onStateChange(Const.OPACT_STATE_OPEN)
		end
	else
		self:onStateChange(Const.OPACT_STATE_CLOSE)
	end
end

function OpActivityObject:onOpActSetFocusResp(focus)
	if not self.roleCommonData then
		self.roleCommonData = {}
	end

	local preFocus = self.roleCommonData.miss_focus

	self.roleCommonData.miss_focus = focus

	if (preFocus == nil or preFocus == 0) and focus == 1 and self.templateData and self.templateData.focus_avg then
		UIManager.playAVG(self.templateData.focus_avg)
	end
end

function OpActivityObject:isNewOpened()
	if self.actType == Const.ACT_TYPE_TOPPVP then
		return self.actData:isNewOpened()
	end

	if not self.roleCommonData or self.roleCommonData.miss_focus == 0 or self.roleCommonData.miss_focus == nil then
		return true
	else
		return false
	end
end

function OpActivityObject:setEndTime(endTime)
	if self.endTime ~= endTime then
		self.endTime = endTime

		self.actData:registEndEvent()
	end
end

function OpActivityObject:onStateChange(opActState)
	local oldState = self.curState

	self.curState = opActState

	if opActState ~= oldState then
		local needRefreshUI = true

		if opActState == Const.OPACT_STATE_OPEN then
			self:onStateOpen()
		else
			self:onStateNotOpen()

			if opActState == Const.OPACT_STATE_CLOSE then
				self:onStateClose()
			elseif opActState == Const.OPACT_STATE_FREEZE then
				-- block empty
			else
				needRefreshUI = false
			end
		end

		self:refreshEndTime()
		self.actData:onStateChange(opActState)

		return needRefreshUI
	end
end

function OpActivityObject:getPreOpenTime(...)
	if (self.curState == Const.OPACT_STATE_NONE or self.curState == Const.OPACT_STATE_PREOPEN) and self.opActivityMgrItem and self.opActivityMgrItem.time and self.opActivityMgrItem.time.opentime > ClientUtils.getServerTime() then
		return self.opActivityMgrItem.time.opentime - ClientUtils.getServerTime()
	end
end

function OpActivityObject:refreshEndTime()
	if self.curState == Const.OPACT_STATE_OPEN then
		if self.serverDecide and self.opActivityMgrItem then
			self:setEndTime(self.opActivityMgrItem.time.freezetime)

			if self.opActivityMgrItem.time.opentime then
				self.startTime = self.opActivityMgrItem.time.opentime
			end
		end
	elseif self.curState == Const.OPACT_STATE_FREEZE and self.serverDecide and self.opActivityMgrItem then
		self:setEndTime(self.opActivityMgrItem.time.closetime)

		if self.opActivityMgrItem.time.opentime then
			self.startTime = self.opActivityMgrItem.time.opentime
		end
	end
end

function OpActivityObject:getExtraClientTemplate(windowName)
	for _, tId in ipairs(self.templateData.client_template or {}) do
		local clientTemplate = ResOpActivityClientTemplate[tId]

		if clientTemplate and clientTemplate.template_type then
			local configData = UIConst.ACTIVITY_TEMPLATE_TYPE_CONFIG[clientTemplate.template_type]

			if configData and configData[1] == windowName then
				return clientTemplate
			end
		end
	end
end

function OpActivityObject:checkWindowReplace()
	if self.clientTemplateData and self.clientTemplateData.window_replace then
		for index = 1, #self.clientTemplateData.window_replace, 2 do
			local uiName = self.clientTemplateData.window_replace[index]
			local uiId = tonumber(self.clientTemplateData.window_replace[index + 1])

			UIManager.replacePrefabOfDlg(uiName, uiId)
		end
	end
end

function OpActivityObject:onStateOpen()
	self.inOpening = true

	self:checkWindowReplace()

	if self.templateData.recharge_id and self.templateData.replace_recharge_id then
		for index, rechargeId in ipairs(self.templateData.recharge_id) do
			local repId = self.templateData.replace_recharge_id[index]

			if repId then
				CurAvatar:addRechargeReplaced(rechargeId, repId, self)
			end
		end
	end

	CurAvatar:setActivityOpened(self.actType)
	self:checkNew()
end

function OpActivityObject:onStateNotOpen()
	if self.inOpening and self.templateData.recharge_id and self.templateData.replace_recharge_id then
		for index, rechargeId in ipairs(self.templateData.recharge_id) do
			local repId = self.templateData.replace_recharge_id[index]

			if repId then
				CurAvatar:delRechargeReplaced(rechargeId, repId, self)
			end
		end
	end

	self.inOpening = false
end

function OpActivityObject:checkJumpNotice()
	if self.limitId and ConditionLimitManager.inLimitState(self.limitId) then
		return self.limitUnlockDesc
	end

	if (self.curState == Const.OPACT_STATE_NONE or self.curState == Const.OPACT_STATE_PREOPEN) and self.opActivityMgrItem and self.opActivityMgrItem.time and self.opActivityMgrItem.time.opentime > ClientUtils.getServerTime() then
		return ClientUtils.getServerTimeData(self.opActivityMgrItem.time.opentime, Lang.get(44009))
	end
end

function OpActivityObject:onStateClose()
	self:checkNew()
end

function OpActivityObject:onCheckLockActivity(fromDataUpdate)
	if self.templateData.lock_act_id then
		for _, lockActId in ipairs(self.templateData.lock_act_id) do
			local actObj = CurAvatar:getActivityObj(lockActId)

			if actObj then
				actObj:onCheckUnlockActivity(fromDataUpdate)
			end
		end
	end
end

function OpActivityObject:onCheckUnlockActivity(fromDataUpdate)
	if self.templateData.unlock_act_id then
		if not self.lockedByActivity and fromDataUpdate then
			return
		end

		local unlockObj = CurAvatar:getActivityObj(self.templateData.unlock_act_id)

		if not unlockObj and self.actType == Const.ACT_TYPE_WISH then
			self.lockedByActivity = nil

			self:_unlockTrigger(fromDataUpdate)

			return
		end

		if self:checkActivityLockCondition(self.templateData.unlock_act_id, self.templateData.unlock_act_args) then
			if self.templateData.unlock_act2_id then
				if self:checkActivityLockCondition(self.templateData.unlock_act2_id, self.templateData.unlock_act2_args) then
					self.lockedByActivity = nil

					self:_unlockTrigger(fromDataUpdate)
				else
					self.lockedByActivity = true
				end
			else
				self.lockedByActivity = nil

				self:_unlockTrigger(fromDataUpdate)
			end
		else
			self.lockedByActivity = true
		end
	end
end

function OpActivityObject:checkActivityLockCondition(unlock_act_id, unlock_act_args)
	local actObj = CurAvatar:getActivityObj(unlock_act_id)

	if actObj and actObj.actType == Const.ACT_TYPE_ACHIEVE then
		local actData = actObj.actData
		local args = unlock_act_args or {}
		local argCount = #args
		local achieveType = args[1]
		local needProgress = args[2]

		if argCount == 0 then
			if actObj:isFinish() then
				return true
			else
				return false
			end
		elseif achieveType and needProgress and actData and needProgress <= actData:getAchieveProgress(achieveType, true) then
			return true
		else
			return false
		end
	elseif actObj and actObj.actType == Const.ACT_TYPE_GIFT then
		local args = unlock_act_args or {}
		local argCount = #args

		if argCount == 0 then
			if actObj:isFinish() then
				return true
			else
				return false
			end
		elseif argCount > 1 then
			local targetCount = args[argCount]
			local nowCount = 0

			for i = 1, argCount - 1 do
				local rechargeId = args[i]

				if actObj.actData and actObj.actData.serverData and actObj.actData.serverData[rechargeId] and actObj.actData.serverData[rechargeId].count then
					nowCount = nowCount + actObj.actData.serverData[rechargeId].count
				end
			end

			if targetCount <= nowCount then
				return true
			else
				return false
			end
		end
	elseif actObj and actObj.actType == Const.ACT_TYPE_SHOP then
		local args = unlock_act_args or {}
		local needRound = args[1] or 0
		local needLevel = args[2] or 0

		needLevel = needLevel - 1

		if actObj.actData and needRound <= (actObj.actData.nowRealRound or 0) and needLevel <= (actObj.actData.shopLevel or 0) then
			return true
		else
			return false
		end
	elseif actObj and actObj.actType == Const.ACT_TYPE_WISH then
		if actObj:isFinish() then
			return true
		elseif not actObj:isOpen() then
			return true
		else
			return false
		end
	else
		return false
	end
end

function OpActivityObject:_unlockTrigger(fromDataUpdate)
	if self:isValid() and (fromDataUpdate or self:isNewOpened()) then
		if self.actType == Const.ACT_TYPE_GIFT then
			CurAvatar:recordNewActivityUnlocked(self.actId)
		elseif self.actType == Const.ACT_TYPE_WISH then
			-- block empty
		end
	end
end

function OpActivityObject:checkNew()
	if not self.redDotId then
		return
	end

	if self:isValid() then
		if self.templateData.changed_new_notice and self.actData.checkChangedNew and self.actData:checkChangedNew(self:getChangedNewRecord()) then
			RedDotManager.setKeyState(self.redDotId, true)
		elseif self.onceNewMode == 1 and self:checkTodayOnceNew() then
			RedDotManager.setKeyState(self.redDotId, false)
		elseif self.onceNewMode == 2 and not self:checkTodayOnceNew() then
			RedDotManager.setKeyState(self.redDotId, true)
		else
			local hasNew = self.actData:checkNew()

			RedDotManager.setKeyState(self.redDotId, hasNew)
		end
	else
		RedDotManager.setKeyState(self.redDotId, false)
	end
end

function OpActivityObject:checkTodayOnceNew()
	local preLookTick = 0
	local recordData = CurAvatar:getClientUserData(Const.USER_KEY_ACTIVITY_CHANGED_NEW)[self.actId]

	if recordData and recordData.opId == self.opId then
		preLookTick = recordData.onceTick or 0
	end

	return ClientUtils.isTickToday(preLookTick)
end

function OpActivityObject:saveTodayOnceNew()
	if self.onceNewMode == 1 or self.onceNewMode == 2 then
		local allRecordData = CurAvatar:getClientUserData(Const.USER_KEY_ACTIVITY_CHANGED_NEW)
		local recordData = allRecordData[self.actId] or {}

		if recordData.opId ~= self.opId then
			recordData = {
				opId = self.opId
			}
		end

		recordData.onceTick = ClientUtils.getServerTime()
		allRecordData[self.actId] = recordData

		CurAvatar:setClientUserData(Const.USER_KEY_ACTIVITY_CHANGED_NEW, allRecordData)
		self:checkNew()
	end
end

function OpActivityObject:getChangedNewRecord()
	local recordData = CurAvatar:getClientUserData(Const.USER_KEY_ACTIVITY_CHANGED_NEW)[self.actId]

	if recordData and recordData.opId == self.opId then
		return recordData.record or {}
	else
		return {}
	end
end

function OpActivityObject:saveChangedNewRecord(record)
	local allRecordData = CurAvatar:getClientUserData(Const.USER_KEY_ACTIVITY_CHANGED_NEW)
	local recordData = allRecordData[self.actId] or {}

	if recordData.opId ~= self.opId then
		recordData = {
			opId = self.opId
		}
	end

	recordData.record = self.record
	allRecordData[self.actId] = recordData

	CurAvatar:setClientUserData(Const.USER_KEY_ACTIVITY_CHANGED_NEW, allRecordData)
	self:checkNew()
end

function OpActivityObject:_addRDEvent()
	if self.actId and self.actId > 0 and UIConst.ACTIVITY_RED_DOT_CONFIG[self.actId] then
		self.redDotId = UIConst.ACTIVITY_RED_DOT_CONFIG[self.actId]

		self.actData:registerRDEvent()
	end
end

function OpActivityObject:isOpen()
	if self.curState == Const.OPACT_STATE_OPEN or self.curState == Const.OPACT_STATE_FREEZE then
		if self.serverDecide then
			return true
		elseif self.actData and self.actData.checkActivityExtraOpen then
			return self.actData:checkActivityExtraOpen()
		else
			return ClientUtils.getServerTime() < self.endTime
		end
	else
		return false
	end
end

function OpActivityObject:inNoneState(...)
	return self.curState == Const.OPACT_STATE_NONE
end

function OpActivityObject:inOpenState()
	return self.curState == Const.OPACT_STATE_OPEN
end

function OpActivityObject:checkOpenTime(openDay)
	if openDay then
		if self:inOpenState() and self.startTime then
			return ClientUtils.getServerTime() <= self.startTime + openDay * Const.TIME_ONE_DAY
		else
			return false
		end
	else
		return self:inOpenState()
	end
end

function OpActivityObject:inCloseState(...)
	return self.curState == Const.OPACT_STATE_CLOSE
end

function OpActivityObject:inFreeze()
	return self.curState == Const.OPACT_STATE_FREEZE and self:isOpen()
end

local SPEC_OPERATE_ENABLE_DICT = {
	[Const.ACT_TYPE_ACHIEVE] = {
		[Const.OPACT_STATE_OPEN] = 1,
		[Const.OPACT_STATE_FREEZE] = 1
	},
	[Const.ACT_TYPE_DEPOSIT] = {
		[Const.OPACT_STATE_OPEN] = 1,
		[Const.OPACT_STATE_FREEZE] = 1
	},
	[Const.ACT_TYPE_RECHARGE_REBATE] = {
		[Const.OPACT_STATE_OPEN] = 1,
		[Const.OPACT_STATE_FREEZE] = 1
	},
	[Const.ACT_TYPE_UPDRAW] = {
		[Const.OPACT_STATE_OPEN] = 1,
		[Const.OPACT_STATE_FREEZE] = 1
	},
	[Const.OPACT_STATE_FREEZE] = {
		[Const.OPACT_STATE_OPEN] = 1,
		[Const.OPACT_STATE_FREEZE] = 1
	},
	[Const.ACT_TYPE_CLAN_CLEAR] = {
		[Const.OPACT_STATE_OPEN] = 1,
		[Const.OPACT_STATE_FREEZE] = 1
	},
	[Const.ACT_TYPE_COLLECT_WORDS] = {
		[Const.OPACT_STATE_OPEN] = 1,
		[Const.OPACT_STATE_FREEZE] = 1
	}
}

function OpActivityObject:isOperateEnable()
	if self.lockedByActivity then
		return false
	end

	if SPEC_OPERATE_ENABLE_DICT[self.actType] then
		return self:isValid()
	else
		local isUnlock = true
		local isOpen = false

		if self.limitId then
			isUnlock = not ConditionLimitManager.inLimitState(self.limitId)
		end

		if self.actType == Const.ACT_TYPE_LOTTERY and self.curState == Const.OPACT_STATE_FREEZE then
			isOpen = self.serverDecide and true or ClientUtils.getServerTime() < self.endTime
		end

		if self.curState == Const.OPACT_STATE_OPEN then
			isOpen = self.serverDecide and true or ClientUtils.getServerTime() < self.endTime
		end

		return isOpen and isUnlock
	end
end

function OpActivityObject:isValid()
	if self.limitId and ConditionLimitManager.inLimitState(self.limitId) then
		return false, self.limitUnlockDesc
	end

	return self:isValidExceptCondition(true)
end

local TMALL_ACT_ID = {
	[2997] = 1,
	[2995] = 1,
	[2996] = 1,
	[2999] = 1,
	[2998] = 1
}

function OpActivityObject:isValidExceptCondition()
	if self.lockedByActivity then
		return false, Lang.get(1922)
	end

	if not self:isOpen() then
		return false, Lang.get(1870)
	end

	if self.templateData and self.templateData.finish_hide == 1 and self:isFinish() then
		return false, Lang.get(1923)
	end

	if self.actData and self.actData.isDataValid and not self.actData:isDataValid() then
		return false, Lang.get(1870)
	end

	if TMALL_ACT_ID[self.actId] and (GameConfig.getChannelConfig(Const.REMOTE_CONFIG_HIDE_ACT_MALL) == 1 or VersionUtils.IsReviewVersion()) then
		return false, Lang.get(1870)
	end

	if self.actType == Const.ACT_TYPE_RECHARGE_REBATE then
		local isoP = self.actData and self.actData:isCanGet()

		return isoP
	else
		return true
	end
end

function OpActivityObject:isInConditionLimit(...)
	if self.limitId and ConditionLimitManager.inLimitState(self.limitId) then
		return true, self.limitUnlockDesc
	end

	return false
end

function OpActivityObject:isFinish()
	if self.actData and not self.actData:isOver() then
		return false
	end

	if self.templateData.relate_act and not self.templateData.finish_pass_relate then
		for _, relateId in ipairs(self.templateData.relate_act) do
			local relateObj = CurAvatar:getActivityObj(relateId)

			if relateObj and not relateObj:isFinish() then
				return false
			end
		end
	end

	return true
end

function OpActivityObject:isAllFinish()
	if self.actType == Const.ACT_TYPE_GIFT then
		return self:isFinish()
	else
		return self:isFinish() and not self:isNewOpened()
	end
end

function OpActivityObject:getState()
	return self.curState or Const.OPACT_STATE_CLOSE
end

function OpActivityObject:hasUI()
	return self.clientTemplateData
end

function OpActivityObject:getRemainOpenTime()
	if self.actData and self.actData.getRemainOpenTime then
		return self.actData:getRemainOpenTime()
	end

	if self.endTime then
		return self.endTime - ClientUtils.getServerTime()
	else
		return 0
	end
end

function OpActivityObject:getStartEndTime()
	return {
		self.startTime,
		self.endTime
	}
end

function OpActivityObject:willEnd()
	if self.actData and self.actData:willEnd() then
		return true
	end
end

function OpActivityObject:checkOnInit()
	if self.actData and self.actData.checkOnInit then
		self.actData:checkOnInit()
	end
end

function OpActivityObject:willEndCountDown()
	if self.actData then
		return self.actData:willEndCountDown()
	end

	return 0
end

return OpActivityObject
