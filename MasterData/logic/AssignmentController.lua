-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/controller/AssignmentController.lua

module("logic.extensions.assignment.controller.AssignmentController", package.seeall)

local AssignmentController = class("AssignmentController", BaseController)

function AssignmentController:ctor()
	AssignmentController.super.ctor(self)
end

function AssignmentController:onInit()
	AssignmentController.super.onInit(self)
end

function AssignmentController:onReset()
	AssignmentController.super.onReset(self)

	self._view = nil
end

function AssignmentController:open()
	UIStateManager.instance:push(ViewName.AssignmentView)
end

function AssignmentController:setRootView(view)
	self._view = view
end

function AssignmentController:AssigmentInfo(taskInfos, boxId, boxProgress, todayTaskRefreshTimes, todayBoxRefreshTimes)
	AssignmentModel.instance:setAssignmentData(taskInfos, boxId, boxProgress, todayTaskRefreshTimes, todayBoxRefreshTimes)

	if self._view then
		-- block empty
	end
end

function AssignmentController:analysisBoxCondition(condition, boxProgressEd)
	if condition == nil or condition == "" then
		return "累计完成" .. boxProgressEd .. "个以上任务即可领取奖励"
	else
		local s = string.split(condition, ":")

		return "累计完成" .. boxProgressEd .. "个" .. s[2] .. "星及以上任务即可领取奖励"
	end
end

function AssignmentController:dispatchPet(taskId, isPerfect, endTimeMillis)
	AssignmentModel.instance:setAssignmentStatus(taskId, isPerfect, endTimeMillis)
	self:goldBar()
end

function AssignmentController:refreshTask(taskIds, todayTaskRefreshTimes)
	local assignment = {}

	for _, taskId in ipairs(taskIds) do
		table.insert(assignment, AssignmentConfig.instance:getDispatchTask(taskId))
	end

	AssignmentModel.instance:refreshAssignemt(assignment)
	AssignmentModel.instance:setRefreshTimes(1, todayTaskRefreshTimes)

	if self._view then
		self._view:updateListData(AssignmentModel.instance:getAssignment())
		self._view:setRefreshTaskId(taskIds, todayTaskRefreshTimes)
	end
end

function AssignmentController:gainBoxPrize(boxId)
	AssignmentModel.instance:newBox(boxId)

	if self._view then
		self._view:updateBoxData(AssignmentModel.instance:getBox())
	end
end

function AssignmentController:refreshBox(boxId, todayBoxRefreshTimes)
	AssignmentModel.instance:newBox(boxId)
	AssignmentModel.instance:setRefreshTimes(2, todayBoxRefreshTimes)

	if self._view then
		self._view:refreshBox()
	end
end

function AssignmentController:isPoint(data, selected)
	if selected then
		return data.status == 1 and tonumber(data[6]) <= AssignmentDetailsModel.instance:getUsablePetNum()
	end

	return data.status == 1
end

function AssignmentController:goldBar()
	if self._view then
		self._view:onGoldBar()
	end
end

function AssignmentController:secondToDate(second)
	local date = ""
	local x = 0

	if second >= 3600 then
		x = second - second % 3600
		date = date .. (second - second % 3600) / 3600 .. "小时"
	end

	if second % 3600 >= 60 then
		date = date .. (second % 3600 - second % 60) / 60 .. "分钟"
	end

	if second % 60 > 0 then
		date = date .. second % 60 .. "秒"
	end

	return date
end

function AssignmentController:taskRefreshIsPlay(taskId, taskIds)
	if taskId == nil or taskIds == nil then
		return false
	end

	for _, v in ipairs(taskIds) do
		if taskId == v then
			return true
		end
	end

	return false
end

function AssignmentController.vipToPrize(prizeStr, mul)
	if mul == nil or mul <= 0 then
		mul = 1
	end

	local sp = string.split(prizeStr, ":")
	local count = tonumber(sp[3])
	local vipMul = VipModel.instance:getDispatchMissionGetRate() / 10000
	local num = count * (1 + vipMul - 1 + mul - 1)

	return string.format("%s:%s:%d", sp[1], sp[2], math.floor(num))
end

function AssignmentController:getCanGainTaskIds()
	local taskIds = {}
	local taskInfos = AssignmentModel.instance:getAssignment()

	if not taskInfos then
		return taskIds
	end

	local nowMs = ServerTime.now()

	for i, v in ipairs(taskInfos) do
		local ms = checknumber(v.endTimeMillis)

		if v.status ~= 4 and ms > 0 and ms <= nowMs then
			table.insert(taskIds, v.taskId)
		end
	end

	return taskIds
end

function AssignmentController:onClickOnekeyDipatch()
	self:_openOnekeyView()
end

function AssignmentController:onekeyGainPrize(handler, handlerObj, errHandler)
	local taskIds = self:getCanGainTaskIds()

	if #taskIds > 0 then
		self:sendGainTaskPrizeReq(taskIds, handler, handlerObj, errHandler)
	end
end

function AssignmentController:_openOnekeyView()
	UIStateManager.instance:push(ViewName.AssignmentonekeyView)
end

function AssignmentController:getOnekeyDispatchInfos()
	local datas = {}
	local tempTaskInfos = AssignmentModel.instance:getAssignment()

	if not tempTaskInfos then
		return datas
	end

	local isInUsePetIds = self:_initUsePetIds()
	local petCopy = self:_getCanDispatchPetMos(isInUsePetIds)

	if table.nums(petCopy) <= 0 then
		return datas
	end

	local taskInfos = {}

	for i, v in ipairs(tempTaskInfos) do
		if v.status == 1 then
			table.insert(taskInfos, v)
		end
	end

	table.sort(taskInfos, function(a, b)
		local taskCfgA = AssignmentConfig.instance:getDispatchTask(a.taskId)
		local taskCfgB = AssignmentConfig.instance:getDispatchTask(b.taskId)

		return taskCfgA.taskQuality > taskCfgB.taskQuality
	end)

	local needCheckDatas = {}

	for i, v in ipairs(taskInfos) do
		local taskCfg = AssignmentConfig.instance:getDispatchTask(v.taskId)
		local conditions = AssignmentDetailsController.instance:analysisCondition(taskCfg.detectorParam)
		local data = {
			taskCfg = taskCfg,
			petIds = {},
			conditions = conditions
		}

		for k, petMo in pairs(petCopy) do
			if self:_isConditionPet(petMo, conditions) then
				petCopy[petMo.petId] = nil

				table.insert(data.petIds, petMo.petId)
				self:_isConditionPassAdd(petMo, conditions)

				local isAllCondition = true

				for j, cond in ipairs(conditions) do
					isAllCondition = isAllCondition and cond.num >= cond[2]
				end

				if isAllCondition then
					break
				end
			end
		end

		if #data.petIds >= data.taskCfg.petNum then
			table.insert(datas, data)
		else
			table.insert(needCheckDatas, data)
		end
	end

	for i, data in ipairs(needCheckDatas) do
		for k, petMo in pairs(petCopy) do
			petCopy[petMo.petId] = nil

			table.insert(data.petIds, petMo.petId)

			local isAllCondition = #data.petIds >= data.taskCfg.petNum

			if isAllCondition then
				break
			end
		end

		if #data.petIds >= data.taskCfg.petNum then
			table.insert(datas, data)
		end
	end

	return datas
end

function AssignmentController:_initUsePetIds()
	local isInUsePetIds = {}
	local outPet = AssignmentModel.instance:getOutPet()

	if outPet then
		for i, petId in ipairs(outPet) do
			isInUsePetIds[petId] = true
		end
	end

	return isInUsePetIds
end

function AssignmentController:_getCanDispatchPetMos(isInUsePetIds)
	local petMos = {}
	local pets = BagPetsController.instance:getBagPets()

	for k, petMo in pairs(pets) do
		if not isInUsePetIds[petMo.petId] then
			petMos[petMo.petId] = petMo
		end
	end

	return petMos
end

function AssignmentController:_isConditionPet(pet, conditions)
	for i, condition in ipairs(conditions) do
		if condition.num < condition[2] then
			if condition[3] == "职业" then
				local x = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)

				if not string.find(x.job, condition[4]) then
					return false
				end
			end

			if condition[3] == "觉醒" and CharacterConfig.instance:getAwakenRareCfg(pet.awakenLv).starNum < tonumber(condition[4]) then
				return false
			end

			if condition[3] == "等级" and pet.level < tonumber(condition[4]) then
				return false
			end

			if condition[3] == "稀有度" then
				local x = CharacterConfig.instance:getPetCo(pet.raceId)

				if x.rare < tonumber(condition[4]) then
					return false
				end
			end

			if condition[3] == "属性" then
				local fisrtEle = PetSkinConfig.instance:getFisrtEleAttrIdx(pet.curFaceId)

				if fisrtEle ~= GameEnum.Races[condition[4]] then
					return false
				end
			end
		end
	end

	return true
end

function AssignmentController:_isConditionPassAdd(pet, conditions)
	for i, condition in ipairs(conditions) do
		if condition.num < condition[2] then
			if condition[3] == "职业" then
				local x = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)

				if string.find(x.job, condition[4]) then
					condition.num = condition.num + 1
				end
			end

			if condition[3] == "觉醒" and CharacterConfig.instance:getAwakenRareCfg(pet.awakenLv).starNum >= tonumber(condition[4]) then
				condition.num = condition.num + 1
			end

			if condition[3] == "等级" and pet.level >= tonumber(condition[4]) then
				condition.num = condition.num + 1
			end

			if condition[3] == "稀有度" then
				local x = CharacterConfig.instance:getPetCo(pet.raceId)

				if x.rare >= tonumber(condition[4]) then
					condition.num = condition.num + 1
				end
			end

			if condition[3] == "属性" then
				local fisrtEle = PetSkinConfig.instance:getFisrtEleAttrIdx(pet.curFaceId)

				if fisrtEle == GameEnum.Races[condition[4]] then
					condition.num = condition.num + 1
				end
			end
		end
	end
end

function AssignmentController:sendDispatchPetsReq(reqNos)
	self._cacheOutPets = {}

	for i, v in ipairs(reqNos) do
		for _, petId in ipairs(v.petIds) do
			table.insert(self._cacheOutPets, petId)
		end
	end

	PetDispatchAgent.instance:sendDispatchPetsReq(reqNos)
end

function AssignmentController:handleDispatchPetsRes(msg)
	AssignmentModel.instance:addOutPet(self._cacheOutPets)

	for i, v in ipairs(msg.results) do
		local isPerfect = v.isPerfect
		local endTimeMillis = v.endTimeMillis

		AssignmentController.instance:dispatchPet(v.taskId, isPerfect, endTimeMillis)
	end

	GlobalDispatcher:dispatch(GlobalNotify.RefreshDispatchData)
end

function AssignmentController:sendGainTaskPrizeReq(taskIds, handler, handlerObj, errHandler)
	PetDispatchAgent.instance:sendGainTaskPrizeReq(taskIds, handler, handlerObj, errHandler)
end

function AssignmentController:handleGainTaskPrizeRes(msg)
	local petIds = msg.petIds
	local boxProgress = msg.boxProgress
	local newTaskIds = msg.newTaskIds
	local oldTaskIds = msg.oldTaskIds

	self:_gainTaskPrize(petIds, boxProgress, oldTaskIds, newTaskIds, msg.boxId)
end

function AssignmentController:_gainTaskPrize(petIds, boxProgress, oldTaskIds, newTaskIds, boxId)
	AssignmentModel.instance:removeOutPet(petIds)
	AssignmentModel.instance:newBox(boxId, boxProgress)

	for i, id in ipairs(oldTaskIds) do
		AssignmentModel.instance:gainTaskStatus(id)
	end

	for i, newTaskId in ipairs(newTaskIds) do
		if newTaskId ~= oldTaskIds[i] then
			AssignmentModel.instance:addNewTask(newTaskId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.RefreshDispatchData)
end

function AssignmentController:getTaskPrizeTypeDatas()
	local lv = RoleModel.instance:getMyLevel()
	local cfgs = AssignmentConfig.instance:getPetDispatch()
	local dispatchPro = 0

	for i, v in ipairs(cfgs) do
		if lv >= v.levelSection then
			dispatchPro = v.dispatchPro
		end
	end

	if dispatchPro == 0 then
		dispatchPro = cfgs[1].dispatchPro
	end

	local proCfgs = AssignmentConfig.instance:getDispatchPro(dispatchPro)
	local allTaskCfgs = AssignmentConfig.instance:getDispatchTask()
	local taskPro2TaskPrizeTypes = {}

	for i, v in ipairs(allTaskCfgs) do
		taskPro2TaskPrizeTypes[v.taskPro] = taskPro2TaskPrizeTypes[v.taskPro] or {}
		taskPro2TaskPrizeTypes[v.taskPro][v.prizeType] = taskPro2TaskPrizeTypes[v.taskPro][v.prizeType] or {
			prizeType = v.prizeType,
			prizeTypeName = v.prizeTypeName
		}
	end

	local prizeTypeIds_kv = {}

	for k, v in pairs(proCfgs) do
		table.merge(prizeTypeIds_kv, taskPro2TaskPrizeTypes[v.taskPro])
	end

	return table.values(prizeTypeIds_kv)
end

function AssignmentController:getLastSelectTaskTypeIdMap()
	local typeDatas = AssignmentController.instance:getTaskPrizeTypeDatas()
	local typeIdMap = {}
	local isNeedInit = true
	local initCfg

	for i, v in ipairs(typeDatas) do
		if v.prizeTypeName == "潜能药水" then
			initCfg = v
		end

		local isSelect = self:getPrizeTypeIsSelect(v.prizeType)

		if isSelect then
			typeIdMap[v.prizeType] = v
			isNeedInit = false
		end
	end

	if isNeedInit and initCfg ~= nil then
		typeIdMap[initCfg.prizeType] = initCfg

		self:setPrizeTypeIsSelect(initCfg.prizeType, true)
	end

	return typeIdMap
end

function AssignmentController:getPrizeTypeIsSelect(prizeType)
	local key = self:getTaskTypeIsSelectSaveDataKey(prizeType)

	return checknumber(GameUtil.getUserData(key)) > 0
end

function AssignmentController:setPrizeTypeIsSelect(prizeType, isSelect)
	local key = self:getTaskTypeIsSelectSaveDataKey(prizeType)
	local saveValue = isSelect and 1 or 0

	GameUtil.saveUserData(key, saveValue)
end

function AssignmentController:getTaskTypeIsSelectSaveDataKey(prizeType)
	return string.format("Assignment_Task_Type_%s_Is_Select", prizeType)
end

function AssignmentController:getLastSavefreshTime()
	local useDataKey = "Assignment_Save_Fresh_Time"
	local curValue = checknumber(GameUtil.getUserData(useDataKey))

	if curValue <= 0 then
		self:setLastSavefreshTime(10)

		return 10
	end

	return curValue
end

function AssignmentController:setLastSavefreshTime(newValue)
	local useDataKey = "Assignment_Save_Fresh_Time"

	GameUtil.saveUserData(useDataKey, newValue)
end

AssignmentController.instance = AssignmentController.New()

return AssignmentController
