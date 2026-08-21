-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataCollectWords.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityCollectWordsMisc = require("ClientData/ResOpActivityCollectWordsMisc")
local ResOpActivityCollectWordsPrivilege = require("ClientData/ResOpActivityCollectWordsPrivilege")
local ActivityDataCollectWords = Class("ActivityDataCollectWords", ActivityDataBase)
local FRIENDS_WORDS_DATA_REFRESH_TIME = 1

function ActivityDataCollectWords:ctor()
	self.serverData = {}
end

function ActivityDataCollectWords:updateClientData(actId)
	self.actId = actId
	self.miscData = ResOpActivityCollectWordsMisc[self.actId]
	self.privilegeData = ResOpActivityCollectWordsPrivilege[self.actId]
	self.fresh_tick = 0
	self.wordIDs = self.miscData.word_ids
	self.randomPropsID = self.miscData.random_prop_id
	self.orientationPropsID = self.miscData.orientation_prop_id
	self.hangUpMaxNum = self.miscData.hang_up_num
	self.bagLimit = self.miscData.bag_limit
	self.dropInterval = self.miscData.drop_interval
	self.isWordUnLock = false
	self.recoverWordsTimes = 0
	self.getFrinedWordsList = {}
	self.wordsBag = {}
	self.wordsQueue = {}
	self.privilegeList = {}
	self.getFrinedCount = 0
	self.mergeWordsTimes = 0
	self.sendFriendsList = {}
	self.friendSendRecords = {}
	self.skipCheckItemNew = true

	CurAvatar:registerItemChangedCallBack(self.randomPropsID, Slot(self.CurAvatarCheckNew, self))
	CurAvatar:registerItemChangedCallBack(self.orientationPropsID, Slot(self.CurAvatarCheckNew, self))

	self.otherPlayerInfo = {}
	self.mainDlgName = "activityCollectWordsDlg"
end

function ActivityDataCollectWords:updateRoleData(roleData)
	local collectWordsData = roleData.collect_words

	self.mergeWordsTimes = collectWordsData.compose_count
	self.privilegeList = {}

	if collectWordsData.privilege.limit ~= 0 then
		self.hangUpMaxData = self.privilegeData[collectWordsData.privilege.limit]
		self.hangUpMaxNum = self.hangUpMaxData.value

		table.insert(self.privilegeList, self.hangUpMaxData.itemId)
	end

	if collectWordsData.privilege.time ~= 0 then
		self.dropIntervalData = self.privilegeData[collectWordsData.privilege.time]
		self.dropInterval = self.dropIntervalData.value

		table.insert(self.privilegeList, self.dropIntervalData.itemId)
	end

	if collectWordsData.privilege.score ~= 0 then
		self.scoreUpData = self.privilegeData[collectWordsData.privilege.score]
		self.scoreUp = self.scoreUpData.value

		table.insert(self.privilegeList, self.scoreUpData.itemId)
	end

	if collectWordsData.privilege.bag ~= 0 then
		self.bagUpData = self.privilegeData[collectWordsData.privilege.bag]
		self.bagLimit = self.bagUpData.value

		table.insert(self.privilegeList, self.bagUpData.itemId)
	end

	if collectWordsData.privilege.word_lock == 1 then
		self.wordLockData = self.privilegeData[1]
		self.isWordUnLock = true

		table.insert(self.privilegeList, self.wordLockData.itemId)
	end

	local word_cache = collectWordsData.word_cache

	self.fresh_tick = word_cache.fresh_tick

	for i, cost in ipairs(self.miscData.cost or {}) do
		local catch_num = 0
		local bag_num = 0

		for _, word in pairs(word_cache.word or {}) do
			if word.id == cost.id then
				catch_num = word.cache_num
				bag_num = word.bag_num
			end
		end

		self.wordsBag[i] = {
			id = cost.id,
			num = bag_num,
			costNum = cost.num
		}
		self.wordsQueue[i] = {
			id = cost.id,
			num = catch_num
		}
	end

	self.sendFriendsList = {}

	local refreshTick = ClientUtils.getServerTimeTodayStart()

	if collectWordsData.giving_info.giving_item and collectWordsData.giving_info.giving_item ~= 0 and refreshTick <= collectWordsData.giving_info.time then
		for i, data in pairs(collectWordsData.giving_info.giving_item or {}) do
			table.insert(self.sendFriendsList, data.uid)
		end
	end

	self.friendSendRecords = collectWordsData.recv_info.recv_item or {}

	if refreshTick <= collectWordsData.recv_info.time then
		self.getFrinedCount = collectWordsData.recv_info.recv_count or {}
	else
		self.getFrinedCount = 0
	end
end

function ActivityDataCollectWords:CurAvatarCheckNew(oldValue, newValue)
	if oldValue and newValue then
		if newValue <= oldValue then
			self.skipCheckItemNew = true

			return
		else
			self.skipCheckItemNew = false
		end
	end

	CurAvatar:checkUpActivityNew()
end

function ActivityDataCollectWords:checkNew()
	if self:checkQueueRedNew() or self:checkFriendSendRedNew() then
		return true
	end

	if self:checkAchiRedNew() then
		return true
	end

	if self.miscData.task_achieve_id then
		local actObj = CurAvatar:getActivityObj(self.miscData.task_achieve_id)

		if actObj and actObj.actData:checkNew() then
			return true
		end
	end

	if not self.skipCheckItemNew then
		return true
	end

	if CurAvatar:getItemNumById(self.randomPropsID) > 0 then
		return true
	end

	return false
end

function ActivityDataCollectWords:checkQueueRedNew()
	if self.wordsBag and self.wordsQueue then
		local bagNum = 0
		local can_get_queue = false

		for i = 1, 5 do
			local num = self.wordsBag[i] and self.wordsBag[i].num or 0

			bagNum = bagNum + num

			if self.wordsQueue[i] and self.wordsQueue[i].num > 0 then
				can_get_queue = true
			end
		end

		if bagNum < self.bagLimit and can_get_queue then
			return true
		end
	end

	return false
end

function ActivityDataCollectWords:checkFriendSendRedNew()
	if self.wordsBag then
		local can_get_friend = false

		for i, recv in pairs(self.friendSendRecords or {}) do
			if recv.status == Const.ACT_COLLECT_WORDS_FRIEND_SEND_NOT_GOT then
				can_get_friend = true

				break
			end
		end

		if self.getFrinedCount < Const.ACT_COLLECT_WORDS_GETFRIEND_NUM and can_get_friend then
			return true
		end
	end

	return false
end

function ActivityDataCollectWords:checkAchiRedNew()
	local achieve_actObj = CurAvatar:getActivityObj(self.miscData.achieve_id)

	if achieve_actObj then
		local svrData

		for _, sData in pairs(achieve_actObj.actData.serverData or {}) do
			svrData = sData
		end

		local nowProcess = svrData and svrData.progress or 0
		local nowGot = svrData and svrData.got or {}

		for actType, cData in pairs(achieve_actObj.actData.clientData or {}) do
			for i, data in ipairs(cData) do
				if nowProcess >= data.param and not nowGot[data.index] then
					return true
				end
			end
		end
	end

	return false
end

function ActivityDataCollectWords:checkMergeWords()
	local can_merge = true
	local times = 999

	if self.wordsBag then
		for i = 1, 5 do
			if self.wordsBag[i] then
				if self.wordsBag[i].num < self.wordsBag[i].costNum then
					can_merge = false
				end

				if times > self.wordsBag[i].num then
					times = self.wordsBag[i].num
				end
			else
				can_merge = false
			end
		end
	else
		can_merge = false
	end

	if times < 1 then
		can_merge = false
	end

	return can_merge, times
end

function ActivityDataCollectWords:onCollectWordsGetBuddyInfo(uidList)
	local activityFashionLotteryDlg = UIManager.tryGetUI("activityCollectWordsUseDlg")

	if activityFashionLotteryDlg then
		local lackWordFriendList = {}

		for i, v in ipairs(uidList or {}) do
			table.insert(lackWordFriendList, tostring(v))
		end

		activityFashionLotteryDlg:onCollectWordsGetBuddyInfo(true, lackWordFriendList, true)
	end
end

function ActivityDataCollectWords:onCollectWordsGetDeposit(itemId)
	local activityCollectWordsGetPanel = UIManager.tryGetUI("activityCollectWordsGetPanel")

	if activityCollectWordsGetPanel then
		activityCollectWordsGetPanel:onGetDeposit(itemId)
	end
end

function ActivityDataCollectWords:onCollectWordsRecvWord(itemId)
	local activityCollectWordsGetPanel = UIManager.tryGetUI("activityCollectWordsGetPanel")

	if activityCollectWordsGetPanel then
		activityCollectWordsGetPanel:onRecvWord(itemId)
	end
end

function ActivityDataCollectWords:onCollectWordsCompose(times)
	local activityCollectWordsDlg = UIManager.tryGetUI("activityCollectWordsDlg")

	if activityCollectWordsDlg then
		activityCollectWordsDlg:onComposeWords(times)
	end
end

function ActivityDataCollectWords:onStateChange(opActState)
	if self.actObject:inFreeze() then
		local mainDlg = UIManager.tryGetUI(self.mainDlgName)

		if mainDlg then
			mainDlg:refreshData()
		end
	elseif self.actObject.curState == Const.OPACT_STATE_CLOSE then
		local mainDlg = UIManager.tryGetUI(self.mainDlgName)

		if mainDlg then
			mainDlg:setVisible(false)
		end
	end
end

function ActivityDataCollectWords:checkOverFriendsDataRefreshTime()
	if not self.lastFriendRefreshTime or self.lastFriendRefreshTime + FRIENDS_WORDS_DATA_REFRESH_TIME < ClientUtils.getServerTime() then
		return true
	end

	return false
end

return ActivityDataCollectWords
