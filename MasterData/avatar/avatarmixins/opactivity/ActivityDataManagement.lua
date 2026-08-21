-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataManagement.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResBusinessDetail = require("ClientData/ResBusinessDetail")
local ResBusinessToyConfig = require("ClientData/ResBusinessToyConfig")
local ResBusinessOpAward = require("ClientData/ResBusinessOpAward")
local ResRandClient = require("ClientData/ResRandClient")
local ActivityDataManagement = Class("ActivityDataManagement", ActivityDataBase)

UIConst.enumResBusinessPermission = {
	UnlockToyQuality = 5,
	OrderMT = 9,
	NormalQualityRandom = 6,
	StaminaRecoverySpeed = 3,
	AssignToyType = 10,
	MultiProduce = 12,
	MultiCompose = 13,
	UnlockGrid = 1,
	UnlockToyType = 4,
	BreakOutFreeTimes = 8,
	BreakOutQualityRandom = 7,
	ImproveToyQuality = 11,
	StaminaLimit = 2
}

function ActivityDataManagement:updateClientData(actId)
	self.actId = actId
	self.miscData = ResBusinessDetail[actId]
	self.gridNum = self.miscData.grid_num
	self.productUseStamina = self.miscData.product_use_stamina
	self.staminaRefreshStep = self.miscData.stamina_recover_interval
	self.maxLucky = self.miscData.lucky_value_limit
	self.maxOrderNum = self.miscData.max_order_num
	self.orderItemList = {}

	for i = 1, #self.miscData.order_list do
		table.insert(self.orderItemList, self.miscData.order_list[i].id)
	end

	self.maxReceiveNum = self.miscData.stamina_receive_day_limit
	self.maxDonateNum = self.miscData.stamina_donated_day_limit
	self.assignToyTypeStageList = self.miscData.assign_toy_type_stage
	self.improveToyQualityStageList = self.miscData.improve_toy_quality_stage
	self.newUnlockPermissionDic = {}
	self.unlockToyTypeList = {}
	self.checkMultiProduceOpen = false
	self.checkMultiComposeOpen = false
	self.refreshStaminaRed = false
	self.checkStaminaRed = false
	self.checkBpRed = false
	self.checkOrderRed = false
	self.checkFriendRed = false
	self.relateActId = self.actObject.templateData.relate_act and self.actObject.templateData.relate_act[1] or 0

	CurAvatar:addActivityRelated(self.relateActId, self.mainDlgName, self.actId)
end

function ActivityDataManagement:updateRoleData(roleData)
	local serverData = roleData.business

	self.serverOpenNum = #serverData.grid or 0

	if not self.gridDataList then
		self.gridDataList = {}

		for pos, info in ipairs(serverData.grid) do
			if info.material and ResBusinessToyConfig[self.actId][info.material.type] then
				local id = info.material.type
				local quality = info.material.quality

				self.gridDataList[pos] = ResBusinessToyConfig[self.actId][id][quality]
			end
		end
	end

	self.curStamina = serverData.attr.stamina.storage
	self.lastStaminaRefreshTime = serverData.attr.stamina.last_refresh_time
	self.maxStamina = serverData.attr.stamina.stamina_limit
	self.staminaRecoverySpeed = serverData.attr.stamina.stamina_speed
	self.curLucky = serverData.attr.lucky.storage
	self.totalBreakOutTimes = serverData.attr.lucky.max_count
	self.usedBreakOutTimes = serverData.attr.lucky.use_count
	self.unlockToyQuality = serverData.conf.max_unlock_material_quality
	self.unlockToyTypeList = {}

	if serverData.conf.unlock_material_type then
		for i = 1, #serverData.conf.unlock_material_type do
			table.insert(self.unlockToyTypeList, serverData.conf.unlock_material_type[i].type)
		end
	end

	self.totalAssignToyTypeTimes = 0
	self.usedAssignToyTypeTimesCounter = nil
	self.assignToyType = 0
	self.totalImproveToyQualityTimes = 0
	self.usedImproveToyQualityTimesCounter = nil

	local permissionList = serverData.attr.privilege

	if permissionList then
		for i = 1, #permissionList do
			local permission = permissionList[i]

			if permission.type == UIConst.enumResBusinessPermission.AssignToyType then
				self.totalAssignToyTypeTimes = permission.max_count

				if permission.counter then
					self.usedAssignToyTypeTimesCounter = permission.counter
				end
			elseif permission.type == UIConst.enumResBusinessPermission.ImproveToyQuality then
				self.totalImproveToyQualityTimes = permission.max_count

				if permission.counter then
					self.usedImproveToyQualityTimesCounter = permission.counter
				end
			end
		end
	end

	self.checkMultiProduceOpen = false
	self.checkMultiComposeOpen = false

	if serverData.attr.func_bit then
		local list = ClientUtils.getBitsListFromByteString(serverData.attr.func_bit)

		if list and #list > 0 then
			for _, pos in pairs(list) do
				if pos == 1 then
					self.checkMultiProduceOpen = true
				elseif pos == 2 then
					self.checkMultiComposeOpen = true
				end
			end
		end
	end

	self.orderDataList = {}

	local orderList = serverData.order

	for i = 1, #orderList do
		local order = orderList[i]
		local orderData = {}

		orderData.gid = order.gid
		orderData.quality = order.quality
		orderData.refresh = 0

		if order.func_bit then
			local list = ClientUtils.getBitsListFromByteString(order.func_bit)

			if #list > 0 then
				for _, value in pairs(list) do
					if value == 1 then
						orderData.refresh = 1
					end
				end
			end
		end

		orderData.requireToyList = {}

		for j = 1, #order.require_material do
			local material = order.require_material[j]
			local type = material.material.type
			local quality = material.material.quality
			local materialData = {}

			materialData.toyConfig = ResBusinessToyConfig[self.actId][type][quality]
			materialData.num = material.count

			table.insert(orderData.requireToyList, materialData)
		end

		table.insert(self.orderDataList, orderData)
	end

	self.donateNextRefreshTime = 0
	self.donateDic = {}

	local staminaRecord = serverData.record.stamina
	local donatedRecord = staminaRecord.donated
	local serverTime = ClientUtils.getServerTime()

	if donatedRecord then
		self.donateNextRefreshTime = donatedRecord.next_refresh_tick

		if serverTime < self.donateNextRefreshTime then
			local list = donatedRecord.buddy_info

			if list then
				for i = 1, #list do
					local uid = list[i].buddy_uid

					self.donateDic[uid] = true
				end
			end
		end
	end

	self.receieveNum = 0
	self.receiveNextRefreshTime = 0
	self.receiveDic = {}

	local receiveRecord = staminaRecord.receive

	if receiveRecord then
		if receiveRecord.counter then
			self.receiveNextRefreshTime = receiveRecord.counter.next_reset_time

			if serverTime < self.receiveNextRefreshTime then
				self.receieveNum = receiveRecord.counter.count
			end
		end

		local list = receiveRecord.buddy_info

		if list then
			for i = 1, #list do
				local info = list[i]
				local t = {}
				local uid = info.buddy_uid

				t.receiveNum = info.buddy_give_count
				t.checkCanReceive = info.buddy_give_tick > info.receive_tick
				t.receiveTime = info.receive_tick
				self.receiveDic[uid] = t
			end
		end
	end
end

function ActivityDataManagement:checkBpFull()
	local checkFull = false

	if self.actObject.templateData.relate_act and #self.actObject.templateData.relate_act > 0 then
		local actId = self.actObject.templateData.relate_act[1]
		local relateActObj = CurAvatar:getActivityObj(actId)

		if relateActObj then
			local relateActData = relateActObj.actData

			for actType, cData in pairs(relateActData.clientData) do
				local curExp = relateActData:getAchieveProgress(actType)
				local maxExp = 0

				for index, data in ipairs(cData) do
					if maxExp < data.param then
						maxExp = data.param
					end
				end

				if maxExp <= curExp then
					checkFull = true
				end

				break
			end
		end
	end

	return checkFull
end

function ActivityDataManagement:checkNew()
	self.checkBpRed = false
	self.checkOrderRed = false
	self.checkFriendRed = false

	local checkActivityOpen = self.actObject:inOpenState()

	if self.actObject.roleData then
		if self.relateActId > 0 then
			local relateActObj = CurAvatar:getActivityObj(self.relateActId)

			if relateActObj then
				self.checkBpRed = relateActObj.actData:checkNew() or false
			end
		end

		if not self.refreshStaminaRed then
			self.refreshStaminaRed = true
			self.checkStaminaRed = self:getCurStamina() >= self.miscData.stamina_num_red
		end

		for i = 1, #self.orderDataList do
			local orderData = self.orderDataList[i]

			if self:checkOrderCanCommit(orderData) then
				self.checkOrderRed = true

				break
			end
		end

		if checkActivityOpen then
			local friendList = CurAvatar:getSortedFriends() or {}
			local donateDic = self:getDonateDic()
			local donateNum = utils.getTableElemCount(donateDic)

			if donateNum < self.maxDonateNum then
				for i = 1, #friendList do
					local data = friendList[i]
					local uid = data.uid

					if not donateDic[uid] then
						self.checkFriendRed = true

						break
					end
				end
			end

			if not self.checkFriendRed then
				local receiveNum = self:getReceieveNum()

				if receiveNum < self.maxReceiveNum then
					local receiveDic = self.receiveDic

					for i = 1, #friendList do
						local data = friendList[i]
						local uid = data.uid
						local receiveInfo = receiveDic[uid]

						if receiveInfo and receiveInfo.checkCanReceive then
							self.checkFriendRed = true

							break
						end
					end
				end
			end
		end
	end

	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:refreshBp()
		mainDlg:refreshRed()
	end

	local checkRed = self.checkStaminaRed or self.checkBpRed or self.checkOrderRed or self.checkFriendRed

	return checkRed
end

function ActivityDataManagement:refreshRed()
	local checkRed = self:checkNew()

	RedDotManager.setKeyState(self.actObject.redDotId, checkRed)
end

function ActivityDataManagement:onNewDay()
	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:refreshData()
	end
end

function ActivityDataManagement:clearStaminaRed()
	if self.checkStaminaRed then
		self.checkStaminaRed = false

		self:refreshRed()
	end
end

function ActivityDataManagement:getCurStamina()
	local serverTime = 0

	if self.actObject:inFreeze() and self.actObject.opActivityMgrItem then
		serverTime = self.actObject.opActivityMgrItem.time.freezetime
	else
		serverTime = ClientUtils.getServerTime()
	end

	local realStamina = self.curStamina

	if realStamina < self.maxStamina and serverTime > self.lastStaminaRefreshTime then
		local times = math.floor((serverTime - self.lastStaminaRefreshTime) / self.staminaRefreshStep)

		realStamina = times * self.staminaRecoverySpeed + realStamina

		if realStamina > self.maxStamina then
			realStamina = self.maxStamina
		end
	end

	return realStamina
end

function ActivityDataManagement:getDonateDic()
	local serverTime = ClientUtils.getServerTime()

	if serverTime > self.donateNextRefreshTime then
		self.donateDic = {}
	end

	return self.donateDic
end

function ActivityDataManagement:getReceieveNum()
	local serverTime = ClientUtils.getServerTime()

	if serverTime > self.receiveNextRefreshTime then
		self.receieveNum = 0
	end

	return self.receieveNum
end

function ActivityDataManagement:getSortedFriendList(friendList)
	if not friendList or #friendList <= 1 then
		return friendList
	end

	local num = #friendList

	for i = 1, num - 1 do
		for j = 1, num - i do
			local left = friendList[j]
			local right = friendList[j + 1]
			local leftReceiveData = self.receiveDic[left.uid]
			local leftNum = 0

			if leftReceiveData then
				leftNum = leftReceiveData.receiveNum or 0
			end

			local rightReceiveData = self.receiveDic[right.uid]
			local rightNum = 0

			if rightReceiveData then
				rightNum = rightReceiveData.receiveNum or 0
			end

			if leftNum < rightNum then
				friendList[j] = right
				friendList[j + 1] = left
			end
		end
	end

	return friendList
end

function ActivityDataManagement:getToyNum(itemId)
	local num = 0

	for i = 1, self.gridNum do
		local data = self.gridDataList[i]

		if data and data.item_id == itemId then
			num = num + 1
		end
	end

	return num
end

function ActivityDataManagement:checkOrderCanCommit(orderData)
	local commitToyPosList = {}
	local needToyDic = {}

	for i = 1, #orderData.requireToyList do
		local toy = orderData.requireToyList[i]

		needToyDic[toy.toyConfig.item_id] = toy.num
	end

	for i = 1, self.gridNum do
		local data = self.gridDataList[i]

		if data and needToyDic[data.item_id] and needToyDic[data.item_id] > 0 then
			table.insert(commitToyPosList, i)

			needToyDic[data.item_id] = needToyDic[data.item_id] - 1
		end
	end

	local check = true

	for k, v in pairs(needToyDic) do
		if v > 0 then
			check = false

			break
		end
	end

	return check, commitToyPosList
end

function ActivityDataManagement:checkGridsFull()
	local check = true

	for i = 1, self.serverOpenNum do
		local data = self.gridDataList[i]

		if not data then
			check = false

			break
		end
	end

	return check
end

function ActivityDataManagement:getMaxQuality(toyType)
	local config = ResBusinessToyConfig[self.actId][toyType]

	return #config
end

function ActivityDataManagement:getUsedAssignToyTypeTimes()
	if self.usedAssignToyTypeTimesCounter then
		local serverTime = ClientUtils.getServerTime()

		if serverTime < self.usedAssignToyTypeTimesCounter.next_reset_time then
			return self.usedAssignToyTypeTimesCounter.count
		end
	end

	return 0
end

function ActivityDataManagement:getLeftAssignToyTypeTimes()
	local res = self.totalAssignToyTypeTimes - self:getUsedAssignToyTypeTimes()

	return math.max(0, res)
end

function ActivityDataManagement:getUsedImproveToyQualityTimes()
	if self.usedImproveToyQualityTimesCounter then
		local serverTime = ClientUtils.getServerTime()

		if serverTime < self.usedImproveToyQualityTimesCounter.next_reset_time then
			return self.usedImproveToyQualityTimesCounter.count
		end
	end

	return 0
end

function ActivityDataManagement:getLeftImproveToyQualityTimes()
	local res = self.totalImproveToyQualityTimes - self:getUsedImproveToyQualityTimes()

	return math.max(0, res)
end

function ActivityDataManagement:getOrderExpByQuality(quality)
	local bonusId = ResBusinessOpAward[4][quality].award_id
	local bonus = ResRandClient[bonusId] or {}
	local showNums = bonus.show_nums or {}

	if #showNums > 1 then
		return showNums[1], showNums[2]
	elseif #showNums > 0 then
		return showNums[1], 0
	else
		return 0, 0
	end
end

function ActivityDataManagement:getToyDeleteExpByQuality(quality)
	local bonusId = ResBusinessOpAward[3][quality].award_id
	local bonus = ResRandClient[bonusId] or {}
	local showNums = bonus.show_nums or {}

	if #showNums > 0 then
		return showNums[1]
	else
		return 0
	end
end

function ActivityDataManagement:checkCanDelete()
	if #self.orderDataList < self.maxOrderNum then
		return false
	end

	for i = 1, #self.orderDataList do
		local orderData = self.orderDataList[i]

		if orderData.refresh == 0 then
			return false
		end
	end

	for i = 1, self.serverOpenNum do
		local gridData = self.gridDataList[i]

		if not gridData then
			return false
		end
	end

	self.hasItemDic = {}

	for i = 1, self.serverOpenNum do
		local gridData = self.gridDataList[i]

		if gridData.quality < self.unlockToyQuality then
			if self.hasItemDic[gridData.item_id] then
				return false
			else
				self.hasItemDic[gridData.item_id] = true
			end
		end
	end

	for i = 1, #self.orderDataList do
		local orderData = self.orderDataList[i]

		if self:checkOrderCanCommit(orderData) then
			return false
		end
	end

	return true
end

function ActivityDataManagement:checkCanOnlyRefreshOrder()
	if #self.orderDataList < self.maxOrderNum then
		return false
	end

	for i = 1, self.serverOpenNum do
		local gridData = self.gridDataList[i]

		if not gridData then
			return false
		end
	end

	self.hasItemDic = {}

	for i = 1, self.serverOpenNum do
		local gridData = self.gridDataList[i]

		if gridData.quality < self.unlockToyQuality then
			if self.hasItemDic[gridData.item_id] then
				return false
			else
				self.hasItemDic[gridData.item_id] = true
			end
		end
	end

	for i = 1, #self.orderDataList do
		local orderData = self.orderDataList[i]

		if self:checkOrderCanCommit(orderData) then
			return false
		end
	end

	for i = 1, #self.orderDataList do
		local orderData = self.orderDataList[i]

		if orderData.refresh == 0 then
			return true
		end
	end

	return false
end

function ActivityDataManagement:getMultiComposePosList()
	local maxQuality = math.min(self.unlockToyQuality - 1, 3)
	local list = {}
	local itemId2PosDic = {}

	for i = 1, self.serverOpenNum do
		local data = self.gridDataList[i]

		if data and maxQuality >= data.quality then
			local itemId = data.item_id

			if itemId2PosDic[itemId] and itemId2PosDic[itemId] > 0 then
				table.insert(list, {
					pos_from = i,
					pos_dest = itemId2PosDic[itemId]
				})

				itemId2PosDic[itemId] = nil
			else
				itemId2PosDic[itemId] = i
			end
		end
	end

	return list
end

function ActivityDataManagement:checkHaveStorehouseOrder()
	if #self.orderItemList > 0 then
		local num = CurAvatar:getItemNumById(self.orderItemList[1])

		if num > 0 then
			return true
		end
	end

	return false
end

function ActivityDataManagement:checkCanCommitOrder()
	if #self.orderDataList > 0 then
		local orderData = self.orderDataList[1]

		return self:checkOrderCanCommit(orderData)
	end

	return false
end

function ActivityDataManagement:onOpActBusinessMaterialProductResp(product_info)
	local posList = {}
	local dataList = {}

	for _, productInfo in ipairs(product_info) do
		local grid_pos = productInfo.grid_pos
		local grid = productInfo.grid
		local targetType = grid.material.type
		local quality = grid.material.quality
		local config = ResBusinessToyConfig[self.actId][targetType][quality]

		self.gridDataList[grid_pos] = config

		table.insert(posList, grid_pos)
		table.insert(dataList, config)
	end

	self.assignToyType = 0

	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:onOpActBusinessMaterialProductResp(posList, dataList)
	end
end

function ActivityDataManagement:onOpActBusinessMaterialComposeResp(info_list, move)
	local moveGrids = {}

	for _, info in ipairs(info_list) do
		local pos_from = info.pos_from
		local pos_dest = info.pos_dest
		local grid_from = info.grid_from
		local grid_dest = info.grid_dest

		self.gridDataList[pos_from] = nil

		local destData = ResBusinessToyConfig[self.actId][grid_dest.material.type][grid_dest.material.quality]

		self.gridDataList[pos_dest] = destData
	end

	for _, oneMove in ipairs(move.move_op) do
		self.gridDataList[oneMove.dest] = self.gridDataList[oneMove.from]
		self.gridDataList[oneMove.from] = nil
		moveGrids[oneMove.dest] = oneMove.from - oneMove.dest
		moveGrids[oneMove.from] = 0
	end

	self:refreshRed()

	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:onOpActBusinessMaterialComposeResp(info_list, moveGrids, self.gridDataList)
	end
end

function ActivityDataManagement:onOpActBusinessMaterialUpgradeResp(grid_pos, grid)
	local config = self.gridDataList[grid_pos]

	self.gridDataList[grid_pos] = ResBusinessToyConfig[self.actId][config.id][config.quality + 1]

	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:onOpActBusinessMaterialUpgradeResp(grid_pos, self.gridDataList)
	end
end

function ActivityDataManagement:onOpActBusinessMaterialDeleteResp(grid_pos, move)
	self.gridDataList[grid_pos] = nil

	local moveGrids = {}

	if move and move.move_op then
		for _, oneMove in ipairs(move.move_op) do
			self.gridDataList[oneMove.dest] = self.gridDataList[oneMove.from]
			self.gridDataList[oneMove.from] = nil
			moveGrids[oneMove.dest] = oneMove.from - oneMove.dest
			moveGrids[oneMove.from] = 0
		end
	end

	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:onOpActBusinessOrderDeleteResp(grid_pos, moveGrids, self.gridDataList)
	end
end

function ActivityDataManagement:onOpActBusinessStaminaReceiveResp(buddy_uid)
	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:onOpActBusinessStaminaReceiveResp(buddy_uid)
	end
end

function ActivityDataManagement:onOpActBusinessStaminaDonatedResp(buddy_uid)
	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:onOpActBusinessStaminaDonatedResp(buddy_uid)
	end
end

function ActivityDataManagement:onOpActBusinessOrderCommitResp(order_index, grid_pos, move)
	for _, pos in pairs(grid_pos) do
		self.gridDataList[pos] = nil
	end

	local moveGrids = {}

	if move and move.move_op then
		for _, oneMove in ipairs(move.move_op) do
			self.gridDataList[oneMove.dest] = self.gridDataList[oneMove.from]
			self.gridDataList[oneMove.from] = nil
			moveGrids[oneMove.dest] = oneMove.from - oneMove.dest
			moveGrids[oneMove.from] = 0
		end
	end

	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:onOpActBusinessOrderCommitResp(order_index, grid_pos, moveGrids, self.gridDataList)
	end
end

function ActivityDataManagement:onOpActBusinessOrderUpdateResp(order_index, order)
	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:onOpActBusinessOrderUpdateResp(order_index, order)
	end
end

function ActivityDataManagement:onOpActBusinessPermissionAddNotify(permission_type, param)
	if not param or #param <= 0 then
		return
	end

	self.newUnlockPermissionDic[permission_type] = self.newUnlockPermissionDic[permission_type] or {}

	for i = 1, #param do
		table.insert(self.newUnlockPermissionDic[permission_type], param[i])
	end

	if permission_type == UIConst.enumResBusinessPermission.UnlockGrid then
		self.serverOpenNum = param[1]
	elseif permission_type == UIConst.enumResBusinessPermission.StaminaLimit then
		self.maxStamina = param[1]
	elseif permission_type == UIConst.enumResBusinessPermission.StaminaRecoverySpeed then
		self.staminaRecoverySpeed = param[1]
	elseif permission_type == UIConst.enumResBusinessPermission.UnlockToyType then
		for i = 1, #param do
			table.insert(self.unlockToyTypeList, param[i])
		end
	elseif permission_type == UIConst.enumResBusinessPermission.UnlockToyQuality then
		self.unlockToyQuality = param[1]
	elseif permission_type == UIConst.enumResBusinessPermission.BreakOutQualityRandom then
		-- block empty
	elseif permission_type == UIConst.enumResBusinessPermission.BreakOutFreeTimes then
		self.totalBreakOutTimes = param[1]
	elseif permission_type == UIConst.enumResBusinessPermission.AssignToyType then
		self.totalAssignToyTypeTimes = param[1]
	elseif permission_type == UIConst.enumResBusinessPermission.ImproveToyQuality then
		self.totalImproveToyQualityTimes = param[1]
	elseif permission_type == UIConst.enumResBusinessPermission.MultiProduce then
		self.checkMultiProduceOpen = true
	elseif permission_type == UIConst.enumResBusinessPermission.MultiCompose then
		self.checkMultiComposeOpen = true
	end
end

return ActivityDataManagement
