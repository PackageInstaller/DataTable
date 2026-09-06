-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/model/AssignmentModel.lua

module("logic.extensions.assignment.model.AssignmentModel", package.seeall)

local AssignmentModel = class("AssignmentModel", BaseListModel)

function AssignmentModel:ctor()
	AssignmentModel.super.ctor(self)
end

function AssignmentModel:onInit()
	AssignmentModel.super.onInit(self)

	self._assignment = nil
end

function AssignmentModel:onReset()
	AssignmentModel.super.onReset(self)

	self._outPet = nil
	self._assignment = nil
	self._refreshTimes = {}
	self._box = nil
	self._taskInfo = nil
end

function AssignmentModel:setAssignmentData(taskInfos, boxId, boxProgress, todayTaskRefreshTimes, todayBoxRefreshTimes)
	self._outPet = {}

	local content = {}

	for i = 1, #taskInfos do
		local task = AssignmentConfig.instance:getDispatchTask(taskInfos[i].taskId)

		if task == nil then
			FloatWordMgr.instance:show("无对应任务信息，请检查服务器返回数据是否有误")

			break
		end

		task.status = taskInfos[i].taskStatus

		if taskInfos[i].petIds ~= nil and task.status ~= 4 then
			for _, id in ipairs(taskInfos[i].petIds) do
				table.insert(self._outPet, id)
			end
		end

		task.endTimeMillis = math.floor(taskInfos[i].endTimeMillis / 1000)

		if task.status == 2 then
			if ServerTime.now() >= task.endTimeMillis then
				task.status = 0
			elseif self._maxEndTimeMillis == nil or task.endTimeMillis > self._maxEndTimeMillis then
				GlobalDispatcher:dispatch(GlobalNotify.SetPushOpen, {
					3
				}, task.endTimeMillis - ServerTime.now())

				self._maxEndTimeMillis = tonumber(task.endTimeMillis)
			end
		end

		task.isPerfect = taskInfos[i].isPerfect

		table.insert(content, task)
	end

	content = ArraySort.sortOn(content, {
		"status",
		"taskQuality"
	}, {
		ArraySort.NONE,
		ArraySort.DESCENDING
	})
	self._assignment = content
	self._refreshTimes = {
		todayTaskRefreshTimes,
		todayBoxRefreshTimes
	}

	printInfo("test AssignmentModel:setAssignmentData", self._refreshTimes)

	content = AssignmentConfig.instance:getDispatchPrizeBox(boxId)

	if content == nil then
		FloatWordMgr.instance:show("无对应宝箱信息，请检查服务器返回数据是否有误")

		return nil
	end

	if boxProgress > content.progress then
		boxProgress = content.progress
	end

	content.boxProgress = boxProgress
	self._box = content
end

function AssignmentModel:refreshAssignemt(task)
	local newAssignment = {}

	for _, v in ipairs(self._assignment) do
		if v.status ~= 1 then
			table.insert(newAssignment, v)
		end
	end

	for _, v in ipairs(task) do
		v.status = 1
		v.endTimeMillis = 0

		table.insert(newAssignment, v)
	end

	newAssignment = ArraySort.sortOn(newAssignment, {
		"status",
		"taskQuality"
	}, {
		ArraySort.NONE,
		ArraySort.DESCENDING
	})
	self._assignment = newAssignment
end

function AssignmentModel:setAssignmentStatus(taskId, isPerfect, endTimeMillis)
	for i = 1, #self._assignment do
		if self._assignment[i].taskId == taskId then
			self._assignment[i].status = 2
			self._assignment[i].isPerfect = isPerfect
			self._assignment[i].endTimeMillis = endTimeMillis / 1000

			if self._maxEndTimeMillis == nil or self._assignment[i].endTimeMillis > self._maxEndTimeMillis then
				GlobalDispatcher:dispatch(GlobalNotify.SetPushOpen, {
					3
				}, self._assignment[i].endTimeMillis - ServerTime.now())

				self._maxEndTimeMillis = self._assignment[i].endTimeMillis
			end

			ArraySort.sortOn(self._assignment, {
				"status",
				"taskQuality"
			}, {
				ArraySort.NONE,
				ArraySort.DESCENDING
			})

			break
		end
	end
end

function AssignmentModel:getAssignment()
	return self._assignment
end

function AssignmentModel:getBox()
	return self._box
end

function AssignmentModel:newBox(boxId, boxProgress)
	content = boxId ~= nil and AssignmentConfig.instance:getDispatchPrizeBox(boxId) or self._box
	content.boxProgress = boxProgress ~= nil and boxProgress or 0
	self._box = content
end

function AssignmentModel:setRefreshTimes(refreshType, times)
	self._refreshTimes[refreshType] = times
end

function AssignmentModel:getRefreshTimes(refreshType)
	if refreshType == nil then
		return self._refreshTimes
	else
		return self._refreshTimes[refreshType] or 0
	end
end

function AssignmentModel:removeOutPet(petIds)
	for _, v in ipairs(petIds) do
		for i = 1, #self._outPet do
			if v == self._outPet[i] then
				table.remove(self._outPet, i)

				break
			end
		end
	end
end

function AssignmentModel:getOutPet()
	return self._outPet
end

function AssignmentModel:addOutPet(petIds)
	for i, v in ipairs(petIds) do
		table.insert(self._outPet, v)
	end
end

function AssignmentModel:gainTaskStatus(taskId)
	for i = 1, #self._assignment do
		if self._assignment[i].taskId == taskId then
			self._assignment[i].status = 4

			table.sort(self._assignment, function(a, b)
				return a.status < b.status
			end)

			break
		end
	end
end

function AssignmentModel:addNewTask(newTaskId)
	for i, v in ipairs(self._assignment) do
		if v.taskId == newTaskId then
			table.remove(self._assignment, i)

			break
		end
	end

	if newTaskId and newTaskId > 0 then
		local task = AssignmentConfig.instance:getDispatchTask(newTaskId)

		if task == nil then
			FloatWordMgr.instance:show("派遣任务Id:" .. newTaskId .. " 无对应信息")

			return
		end

		task.status = 1
		task.endTimeMillis = 0

		if task.status == 2 and ServerTime.now() >= task.endTimeMillis then
			task.status = 0
		end

		task.isPerfect = false

		table.insert(self._assignment, task)

		self._assignment = ArraySort.sortOn(self._assignment, {
			"status",
			"taskQuality"
		}, {
			ArraySort.NONE,
			ArraySort.DESCENDING
		})
	end
end

function AssignmentModel:saveOnekeyInfos(infos)
	self._onekeyInfos = infos
end

function AssignmentModel:gaveOnekeyInfos()
	return self._onekeyInfos
end

AssignmentModel.instance = AssignmentModel.New()

return AssignmentModel
