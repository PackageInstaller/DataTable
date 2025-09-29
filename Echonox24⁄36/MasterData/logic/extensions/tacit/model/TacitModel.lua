-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tacit/model/TacitModel.lua

module("logic.extensions.tacit.model.TacitModel", package.seeall)

local TacitModel = class("TacitModel", BaseModel)
local heroDefaultId = 2000000
local taskDefaultId = 50000000

function TacitModel:ctor()
	TacitModel.super.ctor(self)

	self._tacitTaskId2Map = false
	self._tacitFirstStageTasks = false
	self._tacitSceonStageTasks = false
	self._tacitThirdStageTasks = false
	self._targetTask = false
	self._cacheItemMOList = {}
end

function TacitModel:onInit()
	self:setRewardingTask(nil)

	self._tacitTaskId2Map = {}
	self._tacitFirstStageTasks = {}
	self._tacitSceonStageTasks = {}
	self._tacitThirdStageTasks = {}
end

function TacitModel:onReset()
	self:setRewardingTask(nil)
	table.clear(self._tacitTaskId2Map)
	table.clear(self._tacitFirstStageTasks)
	table.clear(self._tacitSceonStageTasks)
	table.clear(self._tacitThirdStageTasks)
	table.clear(self._cacheItemMOList)
end

function TacitModel:initTacitTaskData(heroId, msg, primary)
	table.clear(self._tacitTaskId2Map)
	table.clear(self._tacitFirstStageTasks)
	table.clear(self._tacitSceonStageTasks)
	table.clear(self._tacitThirdStageTasks)

	local tacitCO = TacitConfig.instance:getTacitCO(heroId)

	if tacitCO then
		local privamary = msg.privamary

		self._targetTask = privamary

		self:_initTaskData(heroId, tacitCO, msg.tasks, primary)
	end

	GlobalDispatcher:dispatchEvent(EventType.TACIT_TASK_INIT_EVENT, heroId)
end

function TacitModel:initTargetTaskData(tasks, heroIds)
	local curTasks = {}

	if heroIds then
		for i = 1, #heroIds do
			for _, taskNo in ipairs(tasks) do
				local taskId = taskNo.id
				local heroShortId = tonumber(string.sub(taskId, 3, 5))
				local heroId = heroDefaultId + heroShortId

				if heroIds[i] == heroId then
					local taskStage = math.floor(taskId / 1000000) % 10
					local lastTaskId = tonumber(string.sub(taskId, 6, -1))
					local tempTacikID = tonumber(string.format("5%s", string.sub(taskId, 2, -1)))
					local taskCO = TacitConfig.instance:getTacitTaskCO(tempTacikID)

					if not taskCO then
						local taskCfgId = taskDefaultId + taskStage * 1000000 + lastTaskId

						taskCO = TacitConfig.instance:getTacitTaskCO(taskCfgId)
					end

					if taskCO then
						local mo = TacitTargetTaskMO.New(taskCO, heroId)

						mo:updateByAgent(taskNo)
						table.insert(curTasks, mo)
					end
				end
			end
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.TACIT_REFRESH_TARGET_TASK, curTasks)
end

function TacitModel:updateStageTips(taskId, progress)
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Tacit) then
		if Astral.OSDef.isEditor then
			printWarn(string.format("功能[%s]未开启，不弹出任务阶段完成提示", GameEnum.SystemEnum.Tacit))
		end

		return
	end

	local taskStage = math.floor(taskId / 1000000) % 10
	local lastTaskId = tonumber(string.sub(taskId, 6, -1))
	local heroShortId = tonumber(string.sub(taskId, 3, 5))
	local heroId = heroDefaultId + heroShortId
	local tempTacikID = tonumber(string.format("5%s", string.sub(taskId, 2, -1)))
	local taskCO = TacitConfig.instance:getTacitTaskCO(tempTacikID)

	if not taskCO then
		local taskCfgId = taskDefaultId + taskStage * 1000000 + lastTaskId

		taskCO = TacitConfig.instance:getTacitTaskCO(taskCfgId)
	end

	if enableLog then
		local taskCode = taskCO and taskCO.code or false

		printInfo("弹出印象任务进度======>", taskId, progress, heroId, taskCode)
	end

	if taskCO then
		local taskDesc, maxCount, isTaskGroup, sideTips

		if not string.nilorempty(taskCO.param) and taskCO.content > 0 then
			local newParam = string.gsub(taskCO.param, "${heroCode}", heroId)

			taskDesc, maxCount, isTaskGroup, sideTips = TaskUtil.parseContent(taskCO.content, newParam, heroId)
		end

		if not sideTips then
			printWarn("cloud not found tips content with task ID:", taskCfgId)

			return
		end

		sideTips = string.format(sideTips, progress)

		local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(heroId)
		local heroName = ""

		if heroInfoCO then
			heroName = heroInfoCO.name
		end

		local isFinish = maxCount == progress
		local titleContentKey = isFinish and "tip_tacit_finish_target" or "tip_tacit_progress_tips"
		local data = {
			iconName = "float_sign_1002",
			title = langF(titleContentKey, heroName),
			content = sideTips,
			anchor = CommEnum.AnchorEnum.Bottom
		}

		GlobalDispatcher:dispatchEvent(EventType.SHOW_SIDE_TIP, data)
	else
		printWarn("无法找到任务ID", taskId)
	end
end

function TacitModel:_sortTask(list)
	table.sort(list, function(task1, task2)
		if not task1 or not task2 then
			return false
		end

		local id1 = task1:getId()
		local id2 = task2:getId()

		if id1 ~= id2 then
			return id1 < id2
		end

		return false
	end)
end

function TacitModel:_initTaskData(heroId, tacitCO, taskLst, primaryId)
	local cfgStageTask = {
		tacitCO.firStageTasks or {},
		tacitCO.secStageTasks or {},
		tacitCO.thridStageTasks or {}
	}

	for _, taskNO in pairs(taskLst or {}) do
		if taskNO.id then
			local taskStage = math.floor(taskNO.id / 1000000) % 10

			for _, cfgTaskId in ipairs(cfgStageTask[taskStage] or {}) do
				if taskNO.id % 1000 == cfgTaskId % 1000 then
					local taskCO = TacitConfig.instance:getTacitTaskCO(cfgTaskId)

					if taskCO then
						local mo = TacitTaskMO.New(taskCO, heroId)

						mo:updateByAgent(taskNO, _)
						mo:setTarget(mo:getId() == primaryId)
						table.insert(self:getStageTaskLst(taskStage), mo)

						self._tacitTaskId2Map[mo:getId()] = mo
					end
				end
			end
		end
	end

	for i = 1, #cfgStageTask do
		self:_sortTask(self:getStageTaskLst(i))
	end
end

function TacitModel:updateTargetTask(taskId)
	self:setTargetTask(taskId)
	self:_setTargetTask(self._tacitFirstStageTasks, taskId)
	self:_setTargetTask(self._tacitSceonStageTasks, taskId)
	self:_setTargetTask(self._tacitThirdStageTasks, taskId)
end

function TacitModel:updateTask(taskId)
	self:_finishTask(self._tacitFirstStageTasks, taskId)
	self:_finishTask(self._tacitSceonStageTasks, taskId)
	self:_finishTask(self._tacitThirdStageTasks, taskId)
end

function TacitModel:_setTargetTask(list, taskId)
	for _, v in ipairs(list) do
		v:setTarget(v:getId() == taskId)
	end
end

function TacitModel:_finishTask(list, taskId)
	for _, v in ipairs(list) do
		if v:getId() == taskId then
			v:setFinish()

			break
		end
	end

	self:_sortTask(list)
end

function TacitModel:getTacitTaskMO(code)
	return self._tacitTaskId2Map[code] or false
end

function TacitModel:getStageTaskLst(stage)
	if stage == 1 then
		return self._tacitFirstStageTasks
	elseif stage == 2 then
		return self._tacitSceonStageTasks
	elseif stage == 3 then
		return self._tacitThirdStageTasks
	else
		printError("no define stage task :", stage)
	end

	return {}
end

function TacitModel:getFirstStageList()
	return self._tacitFirstStageTasks
end

function TacitModel:getSecondStageList()
	return self._tacitSceonStageTasks
end

function TacitModel:getThirdStageList()
	return self._tacitThirdStageTasks
end

function TacitModel:checkHasRedDot(stageIndex)
	local dataList = false
	local hasRedDot = false

	if stageIndex == 1 then
		dataList = self:getFirstStageList()
	elseif stageIndex == 2 then
		dataList = self:getSecondStageList()
	elseif stageIndex == 3 then
		dataList = self:getThirdStageList()
	end

	if dataList then
		for _, v in ipairs(dataList) do
			if v and v:getCanReward() and not v:getHasFinish() then
				hasRedDot = true

				break
			end
		end
	end

	return hasRedDot
end

function TacitModel:getTargetTask()
	return self._targetTask
end

function TacitModel:setTargetTask(taskId)
	self._targetTask = taskId
end

function TacitModel:setCacheItemMOList(itemMoList)
	self._cacheItemMOList = itemMoList
end

function TacitModel:hasCacheItemMOList()
	local len = self._cacheItemMOList and #self._cacheItemMOList or 0

	return len > 0
end

function TacitModel:popCacheItemMoList(callBack, callBackHandler)
	if self:hasCacheItemMOList() then
		local moList = TableUtil.deepCopy(self._cacheItemMOList)

		GainItemController.instance:openView(moList, false, nil, nil, false, callBack, callBackHandler)
		self:setCacheItemMOList(nil)
	elseif callBack then
		if callBackHandler then
			callBack(callBackHandler)
		else
			callBack()
		end
	end
end

function TacitModel:isAwakeTalentSkill(heroId, noReqMsg)
	if not heroId then
		return CommEnum.TalentSkillAwakeStatus.None
	end

	if not ItemUtil.isCharacterById(heroId) then
		return CommEnum.TalentSkillAwakeStatus.None
	end

	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if heroData then
		return heroData:getAwakeTalent() and CommEnum.TalentSkillAwakeStatus.Unlock or CommEnum.TalentSkillAwakeStatus.Locked
	end

	return CommEnum.TalentSkillAwakeStatus.Locked
end

function TacitModel:setRewardingTask(taskId)
	self._rewardingTaskId = taskId
end

function TacitModel:getRewardingTask()
	return self._rewardingTaskId
end

TacitModel.instance = TacitModel.New()

return TacitModel
