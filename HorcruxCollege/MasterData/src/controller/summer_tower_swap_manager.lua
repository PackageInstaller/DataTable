local var_0_0 = {}
local network = require("network.network")
local var_0_2 = 0
local var_0_3 = 1
local var_0_5 = 97
local var_0_6 = 96

var_0_0.UIRef = nil
var_0_0.mainloop = nil
var_0_0.towerPanelInfo = {}
var_0_0.liveMonstersPool = {}
var_0_0.gameStatus = 0
var_0_0.swapTimes = 0
var_0_0.curTouchTowerItem = nil
var_0_0.curSwapTowerItem = false
var_0_0.starttime = 0
var_0_0.dispelCount = 0
var_0_0.fallCount = 0
var_0_0.combo = 0
var_0_0.moreDispel = 0
var_0_0.bossChannelIndex = 1
var_0_0.hp = 0
var_0_0.level = 0
var_0_0.score = 0

function var_0_0.initData(arg_1_0)
	var_0_0.swapTimes = 5
	var_0_0.hp = 5
	var_0_0.level = 1
	var_0_0.score = 0
end

function var_0_0:release()
	var_0_0.UIRef = nil
	var_0_0.towerPanelInfo = {}
	var_0_0.gameStatus = 0
	var_0_0.swapTimes = 0
	var_0_0.curTouchTowerItem = nil
	var_0_0.curSwapTowerItem = false
	var_0_0.starttime = 0
	var_0_0.dispelCount = 0
	var_0_0.fallCount = 0
	var_0_0.combo = 0
	var_0_0.moreDispel = 0
	var_0_0.bossChannelIndex = 1
	var_0_0.hp = 0
	var_0_0.level = 0
	var_0_0.score = 0

	self:unloop()
	self:cleanLiveMonster()
end

function var_0_0:startGame()
	self:createMainLoop()
end

function var_0_0:createMainLoop()
	self.mainloop = self.mainloop or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_5_0)
		self:gameUpdate(arg_5_0 * 2)
	end, 0, false)
end

function var_0_0:unloop()
	if self.mainloop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.mainloop)

		self.mainloop = nil
	end
end

function var_0_0:initTowerPanelInfo(arg_7_1, arg_7_2)
	self.towerPanelInfo = nil
	self.towerPanelInfo = {}

	for iter_7_0 = 1, arg_7_1 do
		local var_7_0 = {}

		for iter_7_1 = 1, arg_7_2 do
			table.insert(var_7_0, {
				InitLevel = 0,
				InitType = math.random(5)
			})
		end

		table.insert(self.towerPanelInfo, var_7_0)
	end

	return self.towerPanelInfo
end

function var_0_0.registeredUIRef(arg_8_0, arg_8_1)
	arg_8_0.UIRef = arg_8_1
end

function var_0_0:updateUIRef(arg_9_1)
	self.UIRef:updateUI()
end

function var_0_0:reduceHP()
	if self.hp == 0 then
		return
	elseif self.hp == 1 then
		self:unloop()
		self.UIRef:initEndPanel()
		AnalyticManager.beach_defense_exit({
			ctype = "fail",
			day = self.level,
			score = self.score
		})
		network:rpc("activity_update_towerswap_score", {
			activityid = 722,
			score = self.score
		}, function(arg_11_0)
			return
		end)
	end

	self.hp = self.hp - 1

	self:updateUIRef()
end

function var_0_0:registeredTowersInfo(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self.towerPanelInfo[arg_12_1][arg_12_2][arg_12_3] = arg_12_4
end

function var_0_0:itemTouchHandle(arg_13_1, arg_13_2, arg_13_3)
	if self.gameStatus == var_0_3 then
		return
	end

	if self.dispelCount ~= 0 or self.fallCount ~= 0 then
		return
	end

	if not self.curTouchTowerItem then
		self.curTouchTowerItem = arg_13_3
	elseif self.curTouchTowerItem ~= arg_13_3 then
		return
	end

	if arg_13_2 == ccui.TouchEventType.began then
		self.starttime = os.clock()

		return
	elseif arg_13_2 == ccui.TouchEventType.moved then
		self:TouchMoveHandle(arg_13_1, arg_13_2, arg_13_3)

		return
	elseif arg_13_2 == ccui.TouchEventType.ended then
		self.curTouchTowerItem = nil
	end

	self.curTouchTowerItem = nil

	self:TouchEndHandle(arg_13_1, arg_13_2, arg_13_3)
end

function var_0_0:TouchMoveHandle(arg_14_1, arg_14_2, arg_14_3)
	if self.curSwapTowerItem then
		self.curSwapTowerItem:Homing()
	end

	local var_14_0 = arg_14_1:getTouchMovePosition().x - arg_14_1:getTouchBeganPosition().x
	local var_14_1 = arg_14_1:getTouchMovePosition().y - arg_14_1:getTouchBeganPosition().y

	if math.abs(var_14_0) > math.abs(var_14_1) then
		var_14_0 = math.abs(var_14_0) > var_0_5 and var_0_5 * (math.abs(var_14_0) / var_14_0) or var_14_0

		arg_14_3:setPositionX(self.towerPanelInfo[arg_14_3.registrationX][arg_14_3.registrationY].positionX + var_14_0)
		arg_14_3:setPositionY(self.towerPanelInfo[arg_14_3.registrationX][arg_14_3.registrationY].positionY)

		if math.abs(var_14_0) < var_0_5 / 2 then
			self.curSwapTowerItem = nil

			return
		end

		if var_14_0 > 0 then
			if arg_14_3.registrationY == 6 then
				self.curSwapTowerItem = nil
			else
				self.curSwapTowerItem = self.towerPanelInfo[arg_14_3.registrationX][arg_14_3.registrationY + 1].towerItem

				self.curSwapTowerItem:setPositionX(self.towerPanelInfo[arg_14_3.registrationX][arg_14_3.registrationY + 1].positionX - var_14_0)
			end
		elseif arg_14_3.registrationY == 1 then
			self.curSwapTowerItem = nil
		else
			self.curSwapTowerItem = self.towerPanelInfo[arg_14_3.registrationX][arg_14_3.registrationY - 1].towerItem

			self.curSwapTowerItem:setPositionX(self.towerPanelInfo[arg_14_3.registrationX][arg_14_3.registrationY - 1].positionX - var_14_0)
		end
	else
		var_14_1 = math.abs(var_14_1) > var_0_6 and var_0_6 * (math.abs(var_14_1) / var_14_1) or var_14_1

		arg_14_3:setPositionX(self.towerPanelInfo[arg_14_3.registrationX][arg_14_3.registrationY].positionX)
		arg_14_3:setPositionY(self.towerPanelInfo[arg_14_3.registrationX][arg_14_3.registrationY].positionY + var_14_1)

		if math.abs(var_14_1) < var_0_6 / 2 then
			if self.curSwapTowerItem then
				self.curSwapTowerItem:Homing()
			end

			self.curSwapTowerItem = nil

			return
		end

		if var_14_1 > 0 then
			if arg_14_3.registrationX == 1 then
				self.curSwapTowerItem = nil
			else
				self.curSwapTowerItem = self.towerPanelInfo[arg_14_3.registrationX - 1][arg_14_3.registrationY].towerItem

				self.curSwapTowerItem:setPositionY(self.towerPanelInfo[arg_14_3.registrationX - 1][arg_14_3.registrationY].positionY - var_14_1)
			end
		elseif arg_14_3.registrationX == 6 then
			self.curSwapTowerItem = nil
		else
			self.curSwapTowerItem = self.towerPanelInfo[arg_14_3.registrationX + 1][arg_14_3.registrationY].towerItem

			self.curSwapTowerItem:setPositionY(self.towerPanelInfo[arg_14_3.registrationX + 1][arg_14_3.registrationY].positionY - var_14_1)
		end
	end
end

function var_0_0:TouchEndHandle(arg_15_1, arg_15_2, arg_15_3)
	if os.clock() - self.starttime <= 0.1 and math.abs(arg_15_1:getTouchEndPosition().x - arg_15_1:getTouchBeganPosition().x) < var_0_5 / 2 and math.abs(arg_15_1:getTouchEndPosition().y - arg_15_1:getTouchBeganPosition().y) < var_0_6 / 2 then
		if self.curSwapTowerItem then
			self.curSwapTowerItem:Homing()

			self.curSwapTowerItem = nil
		end

		arg_15_3:Homing()
		print("判断为点击")
		arg_15_3:clickHandle()

		return
	end

	if not self.curSwapTowerItem then
		arg_15_3:Homing()

		return
	end

	local var_15_0 = arg_15_3.registrationX

	arg_15_3:Swap(self.curSwapTowerItem.registrationX, self.curSwapTowerItem.registrationY)
	self.curSwapTowerItem:Swap(var_15_0, arg_15_3.registrationY)

	self.curSwapTowerItem = nil
	self.swapTimes = self.swapTimes - 1

	self:updateUIRef()
	self:checkDispel(arg_15_3, self.curSwapTowerItem)
end

function var_0_0:checkDispel(arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0 = 1, 6 do
		local var_16_2 = {}

		for iter_16_1 = 1, 6 do
			if self.towerPanelInfo[iter_16_0][iter_16_1].towerItem.level == 4 then
				var_16_2 = {}
			end

			if not var_16_2.type then
				var_16_2.type = self:getUsingType(iter_16_0, iter_16_1)
				var_16_2.number = 1
				var_16_2.indexs = {}

				table.insert(var_16_2.indexs, iter_16_1)
			elseif var_16_2.type == self:getUsingType(iter_16_0, iter_16_1) then
				var_16_2.number = var_16_2.number + 1

				table.insert(var_16_2.indexs, iter_16_1)
			else
				if var_16_2.number >= 3 then
					table.insert(var_16_1, {
						Row = iter_16_0,
						type = var_16_2.type,
						indexs = var_16_2.indexs
					})
					table.insert(var_16_0, {
						Row = iter_16_0,
						type = var_16_2.type,
						indexs = var_16_2.indexs
					})
				end

				var_16_2 = {
					number = 1,
					type = self:getUsingType(iter_16_0, iter_16_1),
					indexs = {
						iter_16_1
					}
				}
			end
		end

		if var_16_2.number and var_16_2.number >= 3 then
			table.insert(var_16_1, {
				Row = iter_16_0,
				type = var_16_2.type,
				indexs = var_16_2.indexs
			})
			table.insert(var_16_0, {
				Row = iter_16_0,
				type = var_16_2.type,
				indexs = var_16_2.indexs
			})
		end
	end

	local var_16_3 = {}

	for iter_16_2 = 1, 6 do
		local var_16_4 = {}

		for iter_16_3 = 1, 6 do
			if not var_16_4.type then
				var_16_4.type = self:getUsingType(iter_16_3, iter_16_2)
				var_16_4.number = 1
				var_16_4.indexs = {}

				table.insert(var_16_4.indexs, iter_16_3)
			elseif var_16_4.type == self:getUsingType(iter_16_3, iter_16_2) then
				var_16_4.number = var_16_4.number + 1

				table.insert(var_16_4.indexs, iter_16_3)
			else
				if var_16_4.number >= 3 then
					table.insert(var_16_3, {
						Columns = iter_16_2,
						type = var_16_4.type,
						indexs = var_16_4.indexs
					})
					table.insert(var_16_0, {
						Columns = iter_16_2,
						type = var_16_4.type,
						indexs = var_16_4.indexs
					})
				end

				var_16_4 = {
					number = 1,
					type = self:getUsingType(iter_16_3, iter_16_2),
					indexs = {
						iter_16_3
					}
				}
			end
		end

		if var_16_4.number and var_16_4.number >= 3 then
			table.insert(var_16_3, {
				Columns = iter_16_2,
				type = var_16_4.type,
				indexs = var_16_4.indexs
			})
			table.insert(var_16_0, {
				Columns = iter_16_2,
				type = var_16_4.type,
				indexs = var_16_4.indexs
			})
		end
	end

	local var_16_5 = {}
	local var_16_6 = {}
	local var_16_7 = {}

	for iter_16_4, iter_16_5 in pairs(var_16_0) do
		local var_16_8 = {}

		if iter_16_5.Row then
			for iter_16_6, iter_16_7 in pairs(iter_16_5.indexs) do
				table.insert(var_16_8, self.towerPanelInfo[iter_16_5.Row][iter_16_7].towerItem)

				if not vInTable(var_16_5, self.towerPanelInfo[iter_16_5.Row][iter_16_7].towerItem) then
					table.insert(var_16_5, self.towerPanelInfo[iter_16_5.Row][iter_16_7].towerItem)
				else
					table.insert(var_16_6, self.towerPanelInfo[iter_16_5.Row][iter_16_7].towerItem)
				end
			end
		else
			for iter_16_8, iter_16_9 in pairs(iter_16_5.indexs) do
				table.insert(var_16_8, self.towerPanelInfo[iter_16_9][iter_16_5.Columns].towerItem)

				if not vInTable(var_16_5, self.towerPanelInfo[iter_16_9][iter_16_5.Columns].towerItem) then
					table.insert(var_16_5, self.towerPanelInfo[iter_16_9][iter_16_5.Columns].towerItem)
				else
					table.insert(var_16_6, self.towerPanelInfo[iter_16_9][iter_16_5.Columns].towerItem)
				end
			end
		end

		table.insert(var_16_7, var_16_8)
	end

	var_0_0:dispel(var_16_6, var_16_7, var_16_5, arg_16_1, arg_16_2)
end

function var_0_0:dispel(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	if #arg_17_2 == 0 then
		if self.combo > 2 then
			self.swapTimes = self.swapTimes + self.combo - 1
		end

		self.combo = 0

		if self.swapTimes <= 0 then
			self:switchStatus(var_0_3)
		end

		self:updateUIRef()

		return
	end

	local var_17_0 = {}

	self.combo = self.combo + 1

	for iter_17_0, iter_17_1 in ipairs(arg_17_2) do
		if #iter_17_1 > 3 then
			self.moreDispel = self.moreDispel + #iter_17_1 - 3
		end

		local var_17_1 = 1

		for iter_17_2, iter_17_3 in ipairs(iter_17_1) do
			if vInTable(arg_17_1, iter_17_3) or arg_17_4 and arg_17_4 == iter_17_3 or arg_17_5 and arg_17_5 == iter_17_3 then
				var_17_1 = iter_17_2
			end
		end

		for iter_17_4, iter_17_5 in ipairs(iter_17_1) do
			if var_17_1 == iter_17_4 then
				table.insert(var_17_0, iter_17_5)
			else
				iter_17_5:setLevelMoveTo(iter_17_1[var_17_1].registrationX, iter_17_1[var_17_1].registrationY)
			end
		end
	end

	if #arg_17_1 > 0 then
		self.moreDispel = self.moreDispel + #arg_17_1 * 2
	end

	for iter_17_6, iter_17_7 in ipairs(arg_17_3) do
		if vInTable(var_17_0, iter_17_7) then
			iter_17_7:levelUp()
		else
			iter_17_7:deregistration()
		end
	end
end

function var_0_0:beginFalling()
	for iter_18_0 = 1, 6 do
		local var_18_0 = 0

		for iter_18_1 = 6, 1, -1 do
			if not self.towerPanelInfo[iter_18_1][iter_18_0].towerItem then
				var_18_0 = var_18_0 + 1
			elseif var_18_0 > 0 then
				self.towerPanelInfo[iter_18_1][iter_18_0].towerItem:fallDown(var_18_0)
			end
		end

		for iter_18_2 = var_18_0, 1, -1 do
			local var_18_1 = self.UIRef.towersPool:getObjectByMyType(math.random(5), TowerSprite)

			if not var_18_1:getParent() then
				self.UIRef.bg:addChild(var_18_1)
			end

			var_18_1:fallDownNew(var_18_0 - iter_18_2 + 1, iter_18_2, iter_18_0)
		end
	end
end

function var_0_0:addDispelCount()
	self.dispelCount = self.dispelCount + 1
end

function var_0_0:completeDispel()
	self.dispelCount = self.dispelCount - 1

	if self.dispelCount == 0 then
		self:beginFalling()
	end

	if self.moreDispel > 0 then
		self.swapTimes = self.swapTimes + self.moreDispel

		self:updateUIRef()
	end

	self.moreDispel = 0
end

function var_0_0:addFallCount()
	self.fallCount = self.fallCount + 1
end

function var_0_0:completeFall()
	self.fallCount = self.fallCount - 1

	if self.fallCount == 0 then
		self:checkDispel()
	end
end

function var_0_0:gameUpdate(arg_23_1)
	if self.gameStatus == var_0_2 then
		self:dayTimeUpdate(arg_23_1)
	else
		self:nightTimeUpdate(arg_23_1)
	end
end

function var_0_0.dayTimeUpdate(arg_24_0, arg_24_1)
	return
end

function var_0_0:nightTimeUpdate(arg_25_1)
	local var_25_0 = 0

	for iter_25_0, iter_25_1 in ipairs(self.UIRef.bulletsPool.activePool) do
		iter_25_1:update(arg_25_1)
	end

	local var_25_1 = {}

	for iter_25_2, iter_25_3 in ipairs(self.liveMonstersPool) do
		if not iter_25_3.dieAniEnd then
			var_25_0 = var_25_0 + 1

			table.insert(var_25_1, iter_25_3)
		end

		iter_25_3:updateFightState(arg_25_1)
	end

	self.liveMonstersPool = var_25_1

	if var_25_0 == 0 then
		self:switchStatus(var_0_2)
		self:cleanLiveMonster()
	end

	for iter_25_4, iter_25_5 in ipairs(self.towerPanelInfo) do
		for iter_25_6, iter_25_7 in ipairs(iter_25_5) do
			iter_25_7.towerItem:updateFightState(arg_25_1)
		end
	end
end

function var_0_0:switchStatus(arg_26_1)
	if self.gameStatus == arg_26_1 then
		return
	end

	self.gameStatus = arg_26_1

	if arg_26_1 == var_0_3 then
		self:initNightGame()
		self.UIRef:initNightTimeMask()
	elseif arg_26_1 == var_0_2 then
		self:passGameLevel()
		self.UIRef.nightMask:setVisible(false)
	end
end

function var_0_0:passGameLevel()
	self.level = self.level + 1
	self.swapTimes = 4

	network:rpc("activity_update_towerswap_score", {
		activityid = 722,
		score = self.score
	}, function(arg_28_0)
		return
	end)

	if self.level % 10 == 0 then
		self.bossChannelIndex = math.random(6)

		self.UIRef:showBossChannelTip()
	end

	self:updateUIRef()
end

function var_0_0:initNightGame(arg_29_1)
	if self.level % 10 == 0 then
		self.UIRef.monstersPool:getObjectByMyType(1, SummerTSMonster):registered()
		self.UIRef.bossChannelTip:setVisible(false)
	else
		for iter_29_0 = 1, self.level * 2 + 2 do
			self.UIRef.monstersPool:getObjectByMyType(0, SummerTSMonster):registered()
		end
	end

	for iter_29_1, iter_29_2 in ipairs(self.towerPanelInfo) do
		for iter_29_3, iter_29_4 in ipairs(iter_29_2) do
			iter_29_4.towerItem:switchState(1)
		end
	end
end

function var_0_0:getUsingType(arg_30_1, arg_30_2)
	return self.towerPanelInfo[arg_30_1][arg_30_2].towerItem.type * 5 + self.towerPanelInfo[arg_30_1][arg_30_2].towerItem.level + 1
end

function var_0_0:registLiveMonster(arg_31_1)
	table.insert(self.liveMonstersPool, arg_31_1)

	return #self.liveMonstersPool
end

function var_0_0.cleanLiveMonster(arg_32_0, arg_32_1)
	arg_32_0.liveMonstersPool = {}
end

function vInTable(arg_33_0, arg_33_1)
	if arg_33_0 == nil then
		return false
	end

	for iter_33_0, iter_33_1 in pairs(arg_33_0) do
		if iter_33_1 == arg_33_1 then
			return true
		end
	end

	return false
end

return var_0_0
