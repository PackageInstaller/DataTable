-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\AchieveUpperSystems\\AchieveUpperSystemBranchTask.lua

local AchieveUpperSystemBase = require("Avatar/AvatarMixins/AchieveUpperSystems/AchieveUpperSystemBase")
local ResAchieve = require("ClientData/ResAchieve")
local AchieveUpperSystemBranch = Class("AchieveUpperSystemBranch", AchieveUpperSystemBase)

function AchieveUpperSystemBranch:initUpperSystem(svrData)
	self.groupAchieveList = {}
	self.groupFocusDict = {}
	self.conditionDict = {}

	for achieveId, achieveInfo in pairs(ResAchieve) do
		if not achieveInfo.trunk_flag then
			self.achieveDict[achieveId] = true

			table.insert(self.achieveList, achieveId)

			local groupId = achieveInfo.group_id

			if groupId then
				if not self.groupAchieveList[groupId] then
					self.groupAchieveList[groupId] = {}
				end

				table.insert(self.groupAchieveList[groupId], achieveId)
			end

			local conditionId = achieveInfo.condition_id

			if conditionId then
				self.conditionDict[achieveId] = conditionId
			end
		end
	end

	table.sort(self.achieveList, function(a, b)
		return a < b
	end)
	self:_sortGroupAchieveList()
	self:_calcGroupNowAchieve()
	self:_refreshRedDotEvent()
end

function AchieveUpperSystemBranch:onAchieveGot(achieveId)
	self:_calcGroupNowAchieve(achieveId)
	self:_refreshDlg()
	self:_refreshRedDotEvent()
end

function AchieveUpperSystemBranch:getSortedBranchList()
	local completeList = {}
	local inProcessList = {}
	local alreadyGotList = {}

	for _, achieveId in ipairs(self.achieveList) do
		local groupId = ResAchieve[achieveId].group_id

		if not groupId or achieveId == self.groupFocusDict[groupId] then
			local achieveData = ResAchieve[achieveId]

			if not achieveData.condition_id or not ConditionLimitManager.inLimitState(achieveData.condition_id) then
				local isQualify = CurAvatar.achieveQualify[achieveId]

				if not isQualify then
					table.insert(inProcessList, achieveId)
				else
					local isGot = CurAvatar.achieveAwardGot[achieveId]

					if not isGot then
						table.insert(completeList, achieveId)
					else
						table.insert(alreadyGotList, achieveId)
					end
				end
			end
		end
	end

	local sortedList = {}

	for _, stateList in ipairs({
		completeList,
		inProcessList,
		alreadyGotList
	}) do
		for i, achieveId in ipairs(stateList) do
			table.insert(sortedList, achieveId)
		end
	end

	return sortedList
end

function AchieveUpperSystemBranch:getGroupNextAchieve(achieveId)
	if not achieveId then
		return
	end

	local achieveInfo = ResAchieve[achieveId]

	if not achieveInfo or not achieveInfo.group_id then
		return
	end

	local groupId = achieveInfo.group_id
	local achieveList = self.groupAchieveList[groupId]

	for idx, id in ipairs(achieveList) do
		if id == achieveId then
			if idx ~= #achieveList then
				return achieveList[idx + 1]
			else
				return
			end
		end
	end
end

function AchieveUpperSystemBranch:_refreshDlg(...)
	local dlg = UIManager.getUI("achieveMainDlg", nil, false)

	if dlg then
		dlg:refreshAchieves()
	end
end

function AchieveUpperSystemBranch:_refreshRedDotEvent()
	local hasHint = false
	local realAchieve, isQualify, isGot, isLocked

	for achieveId, _ in pairs(self.achieveDict) do
		realAchieve = self:_getGroupNowAchieve(achieveId)
		realAchieve = realAchieve or achieveId
		isQualify = CurAvatar.achieveQualify[realAchieve]
		isGot = CurAvatar.achieveAwardGot[realAchieve]
		isLocked = false

		if self.conditionDict[realAchieve] then
			isLocked = ConditionLimitManager.inLimitState(self.conditionDict[realAchieve])
		end

		hasHint = isQualify and not isGot and not isLocked

		if hasHint then
			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_BRANCH_ACHIEVE, hasHint)
end

function AchieveUpperSystemBranch.sortGroupFunc(a, b)
	return a < b
end

function AchieveUpperSystemBranch:_sortGroupAchieveList(...)
	for groupId, groupList in pairs(self.groupAchieveList) do
		table.sort(groupList, self.sortGroupFunc)
	end
end

function AchieveUpperSystemBranch:_calcGroupNowAchieve(achieveId)
	if not achieveId then
		for groupId, _ in pairs(self.groupAchieveList) do
			self.groupFocusDict[groupId] = self:_calcGroupNow(groupId)
		end
	else
		local achieveInfo = ResAchieve[achieveId]

		if not achieveInfo or not achieveInfo.group_id then
			return
		end

		local groupId = achieveInfo.group_id

		self.groupFocusDict[groupId] = self:_calcGroupNow(groupId)
	end
end

function AchieveUpperSystemBranch:_getGroupNowAchieve(achieveId)
	if not achieveId then
		return
	end

	local achieveInfo = ResAchieve[achieveId]

	if not achieveInfo or not achieveInfo.group_id then
		return
	end

	local groupId = achieveInfo.group_id

	return self.groupFocusDict[groupId]
end

function AchieveUpperSystemBranch:_calcGroupNow(groupId)
	for i, achieveId in ipairs(self.groupAchieveList[groupId]) do
		local isQualify = CurAvatar.achieveQualify[achieveId]

		if not isQualify then
			return achieveId
		end

		local isGot = CurAvatar.achieveAwardGot[achieveId]

		if not isGot then
			return achieveId
		end

		if i == #self.groupAchieveList[groupId] then
			return achieveId
		end
	end
end

return AchieveUpperSystemBranch
