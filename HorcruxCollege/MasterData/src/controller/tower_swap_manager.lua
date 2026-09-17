local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local activity_towerswap_conf = require("data.activity_towerswap_conf")
local var_0_4 = 0
local var_0_5 = 1
local var_0_7 = 95
local var_0_8 = 80

var_0_0.UIRef = nil
var_0_0.mainloop = nil
var_0_0.towerPanelInfo = {}
var_0_0.liveMonstersPool = {}
var_0_0.gameStatus = 0
var_0_0.swapTimes = 0
var_0_0.curTouchTowerItem = nil
var_0_0.curSwapTowerItem = false
var_0_0.starttime = 0
var_0_0.is_special_events = false
var_0_0.dispelCount = 0
var_0_0.fallCount = 0
var_0_0.becomeCount = 0
var_0_0.combo = 0
var_0_0.moreDispel = 0
var_0_0.bossChannelIndex = 1
var_0_0.hp = 0
var_0_0.level = 0
var_0_0.score = 0
var_0_0.maxScore = 0
var_0_0.game_start = false
var_0_0.physical = 0
var_0_0.max_physical = 0
var_0_0.revertArray = {}

function var_0_0.initData(arg_1_0, arg_1_1)
	network:rpc("activity_load_towerswap_data", {
		activityid = arg_1_1.activityId
	}, function(arg_2_0)
		hx_print("activity_load_towerswap_data")
		print_lua_table(arg_2_0)

		if not arg_1_0.UIRef then
			return
		end

		if arg_2_0.result == 1 then
			arg_1_0:release()

			arg_1_0.swapTimes = arg_2_0.level == 1 and 5 or 4
			arg_1_0.hp = arg_2_0.hp
			arg_1_0.level = arg_2_0.level
			arg_1_0.score = arg_2_0.score or 0
			arg_1_0.game_start = arg_2_0.game_start
			arg_1_0.physical = arg_2_0.physical
			arg_1_0.max_physical = arg_2_0.max_physical

			arg_1_0:initTowerPanelInfo(6, 6)

			for iter_2_0, iter_2_1 in ipairs(arg_1_0.towerPanelInfo) do
				for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
					iter_2_3.InitType = arg_2_0.towersInfo[iter_2_0 * 6 - 6 + iter_2_2].type
					iter_2_3.InitLevel = arg_2_0.towersInfo[iter_2_0 * 6 - 6 + iter_2_2].level
				end
			end

			if arg_1_1.callback then
				arg_1_1.callback()
			end

			arg_1_0.UIRef:initTowerPanelUI()
			arg_1_0.UIRef:updateUI()
			arg_1_0.UIRef:showBossChannelTip()

			if RoleDefault:getInstance():getBoolForKey("TowerSwapGuide", false) then
				arg_1_0:checkDispel()
				arg_1_0:startGame()
			else
				arg_1_0.UIRef:showGuidePanel()
			end
		end
	end)
end

function var_0_0:release()
	var_0_0.towerPanelInfo = {}
	var_0_0.gameStatus = 0
	var_0_0.swapTimes = 0
	var_0_0.curTouchTowerItem = nil
	var_0_0.curSwapTowerItem = false
	var_0_0.starttime = 0
	var_0_0.is_special_events = false
	var_0_0.dispelCount = 0
	var_0_0.fallCount = 0
	var_0_0.becomeCount = 0
	var_0_0.combo = 0
	var_0_0.moreDispel = 0
	var_0_0.bossChannelIndex = 1
	var_0_0.hp = 0
	var_0_0.level = 0
	var_0_0.score = 0
	var_0_0.maxScore = 0
	var_0_0.game_start = false
	var_0_0.revertArray = {}
	var_0_0.physical = 0
	var_0_0.max_physical = 0

	self:unloop()
	self:cleanLiveMonster()
end

function var_0_0:startGame()
	self:createMainLoop()
end

function var_0_0:createMainLoop()
	self.mainloop = self.mainloop or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_6_0)
		self:gameUpdate(arg_6_0)
	end, 0, false)
end

function var_0_0:unloop()
	if self.mainloop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.mainloop)

		self.mainloop = nil
	end
end

function var_0_0:initTowerPanelInfo(arg_8_1, arg_8_2)
	self.towerPanelInfo = {}

	for iter_8_0 = 1, arg_8_1 do
		local var_8_0 = {}

		for iter_8_1 = 1, arg_8_2 do
			table.insert(var_8_0, {})
		end

		table.insert(self.towerPanelInfo, var_8_0)
	end

	return self.towerPanelInfo
end

function var_0_0.loadTowerPanelInfo(arg_9_0)
	local var_9_0 = RoleDefault:getInstance():getStringForKey("towerSwapTypeInfo", "")
	local var_9_1 = RoleDefault:getInstance():getStringForKey("towerSwapLevelInfo", "")
end

function var_0_0:saveTowerPanelInfo()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self.towerPanelInfo) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
			table.insert(var_10_0, {
				type = iter_10_3.towerItem.type,
				level = iter_10_3.towerItem.level
			})
		end
	end

	print_lua_table(var_10_0)

	return var_10_0
end

function var_0_0.registeredUIRef(arg_11_0, arg_11_1)
	arg_11_0.UIRef = arg_11_1
end

function var_0_0:updateUIRef(arg_12_1)
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
		RoleDefault:getInstance():setIntegerForKey("TSBossChannelIndex", 0)
		network:rpc("activity_update_towerswap_score", {
			activityid = self.UIRef.activityId,
			score = self.score
		}, function(arg_14_0)
			return
		end)
		network:rpc("towerswap_game_failed", {
			activityid = self.UIRef.activityId
		}, function(arg_15_0)
			return
		end)
	end

	self.hp = self.hp - 1

	self:updateUIRef()
end

function var_0_0:registeredTowersInfo(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	self.towerPanelInfo[arg_16_1][arg_16_2][arg_16_3] = arg_16_4
end

function var_0_0:itemTouchHandle(arg_17_1, arg_17_2, arg_17_3)
	if not self.game_start then
		if arg_17_2 ~= ccui.TouchEventType.ended then
			if arg_17_2 == ccui.TouchEventType.canceled then
				LayerManager:pushInLayer("PopDoLayer", {
					surecallback = function()
						self:start_towerswap_game()
					end,
					labels = {
						titleImage = "title_warorder.png",
						des = "消耗一点体力值开始游戏"
					}
				})
			end
		end

		return
	end

	if self.gameStatus == var_0_5 then
		return
	end

	if self.dispelCount ~= 0 or self.fallCount ~= 0 or self.becomeCount ~= 0 then
		return
	end

	if self.is_special_events then
		return
	end

	if not self.curTouchTowerItem then
		self.curTouchTowerItem = arg_17_3
	elseif self.curTouchTowerItem ~= arg_17_3 then
		return
	end

	if arg_17_2 == ccui.TouchEventType.began then
		self.starttime = os.clock()

		return
	elseif arg_17_2 == ccui.TouchEventType.moved then
		self:TouchMoveHandle(arg_17_1, arg_17_2, arg_17_3)

		return
	elseif arg_17_2 == ccui.TouchEventType.ended then
		self.curTouchTowerItem = nil
	end

	self.curTouchTowerItem = nil

	self:TouchEndHandle(arg_17_1, arg_17_2, arg_17_3)
end

function var_0_0:TouchMoveHandle(arg_19_1, arg_19_2, arg_19_3)
	if self.curSwapTowerItem then
		self.curSwapTowerItem:Homing()
	end

	local var_19_0 = arg_19_1:getTouchMovePosition().x - arg_19_1:getTouchBeganPosition().x
	local var_19_1 = arg_19_1:getTouchMovePosition().y - arg_19_1:getTouchBeganPosition().y

	if math.abs(var_19_0) > math.abs(var_19_1) then
		var_19_0 = math.abs(var_19_0) > var_0_7 and var_0_7 * (math.abs(var_19_0) / var_19_0) or var_19_0

		arg_19_3:setPositionX(self.towerPanelInfo[arg_19_3.registrationX][arg_19_3.registrationY].positionX + var_19_0)
		arg_19_3:setPositionY(self.towerPanelInfo[arg_19_3.registrationX][arg_19_3.registrationY].positionY)

		if math.abs(var_19_0) < var_0_7 / 2 then
			self.curSwapTowerItem = nil

			return
		end

		if var_19_0 > 0 then
			if arg_19_3.registrationY == 6 then
				self.curSwapTowerItem = nil
			else
				self.curSwapTowerItem = self.towerPanelInfo[arg_19_3.registrationX][arg_19_3.registrationY + 1].towerItem

				self.curSwapTowerItem:setPositionX(self.towerPanelInfo[arg_19_3.registrationX][arg_19_3.registrationY + 1].positionX - var_19_0)
			end
		elseif arg_19_3.registrationY == 1 then
			self.curSwapTowerItem = nil
		else
			self.curSwapTowerItem = self.towerPanelInfo[arg_19_3.registrationX][arg_19_3.registrationY - 1].towerItem

			self.curSwapTowerItem:setPositionX(self.towerPanelInfo[arg_19_3.registrationX][arg_19_3.registrationY - 1].positionX - var_19_0)
		end
	else
		var_19_1 = math.abs(var_19_1) > var_0_8 and var_0_8 * (math.abs(var_19_1) / var_19_1) or var_19_1

		arg_19_3:setPositionX(self.towerPanelInfo[arg_19_3.registrationX][arg_19_3.registrationY].positionX)
		arg_19_3:setPositionY(self.towerPanelInfo[arg_19_3.registrationX][arg_19_3.registrationY].positionY + var_19_1)

		if math.abs(var_19_1) < var_0_8 / 2 then
			if self.curSwapTowerItem then
				self.curSwapTowerItem:Homing()
			end

			self.curSwapTowerItem = nil

			return
		end

		if var_19_1 > 0 then
			if arg_19_3.registrationX == 1 then
				self.curSwapTowerItem = nil
			else
				self.curSwapTowerItem = self.towerPanelInfo[arg_19_3.registrationX - 1][arg_19_3.registrationY].towerItem

				self.curSwapTowerItem:setPositionY(self.towerPanelInfo[arg_19_3.registrationX - 1][arg_19_3.registrationY].positionY - var_19_1)
			end
		elseif arg_19_3.registrationX == 6 then
			self.curSwapTowerItem = nil
		else
			self.curSwapTowerItem = self.towerPanelInfo[arg_19_3.registrationX + 1][arg_19_3.registrationY].towerItem

			self.curSwapTowerItem:setPositionY(self.towerPanelInfo[arg_19_3.registrationX + 1][arg_19_3.registrationY].positionY - var_19_1)
		end
	end
end

function var_0_0:TouchEndHandle(arg_20_1, arg_20_2, arg_20_3)
	if os.clock() - self.starttime <= 0.1 and math.abs(arg_20_1:getTouchEndPosition().x - arg_20_1:getTouchBeganPosition().x) < var_0_7 / 2 and math.abs(arg_20_1:getTouchEndPosition().y - arg_20_1:getTouchBeganPosition().y) < var_0_8 / 2 then
		if self.curSwapTowerItem then
			self.curSwapTowerItem:Homing()

			self.curSwapTowerItem = nil
		end

		arg_20_3:Homing()
		print("判断为点击")
		arg_20_3:clickHandle()

		return
	end

	if not self.curSwapTowerItem then
		arg_20_3:Homing()

		return
	end

	local var_20_0 = arg_20_3.registrationX

	arg_20_3:Swap(self.curSwapTowerItem.registrationX, self.curSwapTowerItem.registrationY)
	self.curSwapTowerItem:Swap(var_20_0, arg_20_3.registrationY)

	self.curSwapTowerItem = nil
	self.swapTimes = self.swapTimes - 1

	self:updateUIRef()
	self:addRevertArray(arg_20_3, self.curSwapTowerItem)
	self:checkDispel(arg_20_3, self.curSwapTowerItem)
end

function var_0_0:checkDispel(arg_21_1, arg_21_2)
	local var_21_0 = {}
	local var_21_1 = {}

	for iter_21_0 = 1, 6 do
		local var_21_2 = {}

		for iter_21_1 = 1, 6 do
			if not var_21_2.type then
				var_21_2.type = self:getUsingType(iter_21_0, iter_21_1)
				var_21_2.number = 1
				var_21_2.indexs = {}

				table.insert(var_21_2.indexs, iter_21_1)
			elseif var_21_2.type == self:getUsingType(iter_21_0, iter_21_1) and self.towerPanelInfo[iter_21_0][iter_21_1].towerItem.level ~= 4 then
				var_21_2.number = var_21_2.number + 1

				table.insert(var_21_2.indexs, iter_21_1)
			else
				if var_21_2.number >= 3 then
					table.insert(var_21_1, {
						Row = iter_21_0,
						type = var_21_2.type,
						indexs = var_21_2.indexs
					})
					table.insert(var_21_0, {
						Row = iter_21_0,
						type = var_21_2.type,
						indexs = var_21_2.indexs
					})
				end

				var_21_2 = {
					number = 1,
					type = self:getUsingType(iter_21_0, iter_21_1),
					indexs = {
						iter_21_1
					}
				}
			end
		end

		if var_21_2.number and var_21_2.number >= 3 then
			table.insert(var_21_1, {
				Row = iter_21_0,
				type = var_21_2.type,
				indexs = var_21_2.indexs
			})
			table.insert(var_21_0, {
				Row = iter_21_0,
				type = var_21_2.type,
				indexs = var_21_2.indexs
			})
		end
	end

	local var_21_3 = {}

	for iter_21_2 = 1, 6 do
		local var_21_4 = {}

		for iter_21_3 = 1, 6 do
			if not var_21_4.type then
				var_21_4.type = self:getUsingType(iter_21_3, iter_21_2)
				var_21_4.number = 1
				var_21_4.indexs = {}

				table.insert(var_21_4.indexs, iter_21_3)
			elseif var_21_4.type == self:getUsingType(iter_21_3, iter_21_2) and self.towerPanelInfo[iter_21_3][iter_21_2].towerItem.level ~= 4 then
				var_21_4.number = var_21_4.number + 1

				table.insert(var_21_4.indexs, iter_21_3)
			else
				if var_21_4.number >= 3 then
					table.insert(var_21_3, {
						Columns = iter_21_2,
						type = var_21_4.type,
						indexs = var_21_4.indexs
					})
					table.insert(var_21_0, {
						Columns = iter_21_2,
						type = var_21_4.type,
						indexs = var_21_4.indexs
					})
				end

				var_21_4 = {
					number = 1,
					type = self:getUsingType(iter_21_3, iter_21_2),
					indexs = {
						iter_21_3
					}
				}
			end
		end

		if var_21_4.number and var_21_4.number >= 3 then
			table.insert(var_21_3, {
				Columns = iter_21_2,
				type = var_21_4.type,
				indexs = var_21_4.indexs
			})
			table.insert(var_21_0, {
				Columns = iter_21_2,
				type = var_21_4.type,
				indexs = var_21_4.indexs
			})
		end
	end

	local var_21_5 = {}
	local var_21_6 = {}
	local var_21_7 = {}

	for iter_21_4, iter_21_5 in pairs(var_21_0) do
		local var_21_8 = {}

		if iter_21_5.Row then
			for iter_21_6, iter_21_7 in pairs(iter_21_5.indexs) do
				table.insert(var_21_8, self.towerPanelInfo[iter_21_5.Row][iter_21_7].towerItem)

				if not vInTable(var_21_5, self.towerPanelInfo[iter_21_5.Row][iter_21_7].towerItem) then
					table.insert(var_21_5, self.towerPanelInfo[iter_21_5.Row][iter_21_7].towerItem)
				else
					table.insert(var_21_6, self.towerPanelInfo[iter_21_5.Row][iter_21_7].towerItem)
				end
			end
		else
			for iter_21_8, iter_21_9 in pairs(iter_21_5.indexs) do
				table.insert(var_21_8, self.towerPanelInfo[iter_21_9][iter_21_5.Columns].towerItem)

				if not vInTable(var_21_5, self.towerPanelInfo[iter_21_9][iter_21_5.Columns].towerItem) then
					table.insert(var_21_5, self.towerPanelInfo[iter_21_9][iter_21_5.Columns].towerItem)
				else
					table.insert(var_21_6, self.towerPanelInfo[iter_21_9][iter_21_5.Columns].towerItem)
				end
			end
		end

		table.insert(var_21_7, var_21_8)
	end

	var_0_0:dispel(var_21_6, var_21_7, var_21_5, arg_21_1, arg_21_2)
end

function var_0_0:dispel(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	if #arg_22_2 == 0 then
		if self.combo > 2 then
			self.swapTimes = self.swapTimes + self.combo - 1
		end

		self.combo = 0

		if self.swapTimes <= 0 then
			self:switchStatus(var_0_5)
		end

		self:updateUIRef()

		return
	end

	self:clearRevertArray()

	local var_22_0 = {}

	self.combo = self.combo + 1

	for iter_22_0, iter_22_1 in ipairs(arg_22_2) do
		if #iter_22_1 > 3 then
			self.moreDispel = self.moreDispel + #iter_22_1 - 3
		end

		local var_22_1 = 1

		for iter_22_2, iter_22_3 in ipairs(iter_22_1) do
			if vInTable(arg_22_1, iter_22_3) or arg_22_4 and arg_22_4 == iter_22_3 or arg_22_5 and arg_22_5 == iter_22_3 then
				var_22_1 = iter_22_2
			end
		end

		for iter_22_4, iter_22_5 in ipairs(iter_22_1) do
			if var_22_1 == iter_22_4 then
				table.insert(var_22_0, iter_22_5)
			else
				iter_22_5:setLevelMoveTo(iter_22_1[var_22_1].registrationX, iter_22_1[var_22_1].registrationY)
			end
		end
	end

	if #arg_22_1 > 0 then
		self.moreDispel = self.moreDispel + #arg_22_1 * 2
	end

	for iter_22_6, iter_22_7 in ipairs(arg_22_3) do
		if vInTable(var_22_0, iter_22_7) then
			iter_22_7:levelUp()
		else
			iter_22_7:deregistration()
		end
	end
end

function var_0_0:beginFalling()
	for iter_23_0 = 1, 6 do
		local var_23_0 = 0

		for iter_23_1 = 6, 1, -1 do
			if not self.towerPanelInfo[iter_23_1][iter_23_0].towerItem then
				var_23_0 = var_23_0 + 1
			elseif var_23_0 > 0 then
				self.towerPanelInfo[iter_23_1][iter_23_0].towerItem:fallDown(var_23_0)
			end
		end

		for iter_23_2 = var_23_0, 1, -1 do
			local var_23_1 = self.UIRef.towersPool:getObjectByMyType(math.random(5), TowerSprite)

			if not var_23_1:getParent() then
				self.UIRef.bg:addChild(var_23_1)
			end

			var_23_1:fallDownNew(var_23_0 - iter_23_2 + 1, iter_23_2, iter_23_0)
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

function var_0_0:addBecomeCount()
	self.becomeCount = self.becomeCount + 1
end

function var_0_0:completeBecome()
	self.becomeCount = self.becomeCount - 1

	if self.becomeCount == 0 then
		self:checkDispel()
	end
end

function var_0_0:gameUpdate(arg_30_1)
	local var_30_0 = cc.UserDefault:getInstance():getBoolForKey("TowerSwapTwiceSpeed", false) and 2 or 1

	if self.gameStatus == var_0_4 then
		self:dayTimeUpdate(arg_30_1 * var_30_0)
	else
		self:nightTimeUpdate(arg_30_1 * var_30_0)
	end
end

function var_0_0.dayTimeUpdate(arg_31_0, arg_31_1)
	return
end

function var_0_0:nightTimeUpdate(arg_32_1)
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in ipairs(self.UIRef.bulletsPool.activePool) do
		iter_32_1:update(arg_32_1)
	end

	local var_32_1 = {}

	for iter_32_2, iter_32_3 in ipairs(self.liveMonstersPool) do
		if not iter_32_3.dieAniEnd then
			var_32_0 = var_32_0 + 1

			table.insert(var_32_1, iter_32_3)
		end

		iter_32_3:updateFightState(arg_32_1)
	end

	self.liveMonstersPool = var_32_1

	if var_32_0 == 0 then
		self:switchStatus(var_0_4)
		self:cleanLiveMonster()
	end

	for iter_32_4, iter_32_5 in ipairs(self.towerPanelInfo) do
		for iter_32_6, iter_32_7 in ipairs(iter_32_5) do
			iter_32_7.towerItem:updateFightState(arg_32_1)
		end
	end
end

function var_0_0:switchStatus(arg_33_1)
	if self.gameStatus == arg_33_1 then
		return
	end

	self.gameStatus = arg_33_1

	if arg_33_1 == var_0_5 then
		self:initNightGame()
		self.UIRef:initNightTimeMask()
	elseif arg_33_1 == var_0_4 then
		self:passGameLevel()
		self.UIRef.nightMask:setVisible(false)
	end
end

function var_0_0:passGameLevel(arg_34_1)
	network:rpc("activity_update_towerswap_score", {
		activityid = self.UIRef.activityId,
		score = self.score
	}, function(arg_35_0)
		return
	end)

	local var_34_0

	if self.level % 10 == 0 then
		RoleDefault:getInstance():setIntegerForKey("TSBossChannelIndex", 0)

		var_34_0 = {
			activityid = self.UIRef.activityId
		}
	end

	var_34_0.towersInfo = self:saveTowerPanelInfo()
	var_34_0.hp = self.hp
	var_34_0.score = self.score

	network:rpc("activity_pass_towerswap_level", var_34_0, function(arg_36_0)
		hx_print("activity_pass_towerswap_level")
		print_lua_table(arg_36_0)

		if arg_36_0.result == 1 then
			global_gain(arg_36_0)

			self.level = self.level + 1
			self.swapTimes = 4

			self:clearRevertArray()
			self.UIRef:showBossChannelTip()
			self:updateUIRef()

			if arg_34_1 then
				arg_34_1()
			end
		end
	end)
end

function var_0_0:initNightGame(arg_37_1)
	if self.UIRef.bossChannelTip then
		self.UIRef.bossChannelTip:setVisible(false)
	end

	if self.level % 10 == 0 then
		self.UIRef.monstersPool:getObjectByMyType(1, SummerTSMonster):registered()
	else
		self.UIRef:hideBossHpProgress()

		for iter_37_0 = 1, self.level * 2 + 2 do
			self.UIRef.monstersPool:getObjectByMyType(0, SummerTSMonster):registered()
		end
	end

	for iter_37_1, iter_37_2 in ipairs(self.towerPanelInfo) do
		for iter_37_3, iter_37_4 in ipairs(iter_37_2) do
			iter_37_4.towerItem:switchState(1)
		end
	end
end

function var_0_0:getUsingType(arg_38_1, arg_38_2)
	return self.towerPanelInfo[arg_38_1][arg_38_2].towerItem.type * 5 + self.towerPanelInfo[arg_38_1][arg_38_2].towerItem.level + 1
end

function var_0_0:registLiveMonster(arg_39_1)
	table.insert(self.liveMonstersPool, arg_39_1)

	return #self.liveMonstersPool
end

function var_0_0.cleanLiveMonster(arg_40_0, arg_40_1)
	arg_40_0.liveMonstersPool = {}
end

local var_0_11 = 1
local var_0_12 = 2
local var_0_13 = 3

local function var_0_14(arg_41_0, arg_41_1)
	if arg_41_1 > #arg_41_0 then
		return arg_41_0
	end

	local var_41_0 = {}

	for iter_41_0 = 1, #arg_41_0 do
		var_41_0[iter_41_0] = iter_41_0
	end

	for iter_41_1 = #arg_41_0, 2, -1 do
		local var_41_1 = math.random(iter_41_1)

		var_41_0[iter_41_1], var_41_0[var_41_1] = var_41_0[var_41_1], var_41_0[iter_41_1]
	end

	local var_41_2 = {}

	for iter_41_2 = 1, arg_41_1 do
		var_41_2[iter_41_2] = arg_41_0[var_41_0[iter_41_2]]
	end

	return var_41_2
end

function var_0_0.trigger_gold_special_events(arg_42_0, arg_42_1, arg_42_2)
	hx_print("trigger_gold_special_events")
	print(arg_42_1)

	if arg_42_1 == var_0_11 then
		local function var_42_0(arg_43_0)
			local var_43_0 = {}

			for iter_43_0, iter_43_1 in ipairs(arg_42_0.towerPanelInfo) do
				for iter_43_2, iter_43_3 in ipairs(iter_43_1) do
					if iter_43_3.towerItem.type ~= arg_43_0 and iter_43_3.towerItem.level == 0 then
						table.insert(var_43_0, iter_43_3)
					end
				end
			end

			arg_42_2:deregistration()

			for iter_43_4, iter_43_5 in ipairs((var_0_14(var_43_0, 4))) do
				iter_43_5.towerItem:becomeOther(arg_43_0)
			end

			arg_42_0.is_special_events = false
		end

		arg_42_2:MoveToWithCoordinate(nil, nil, 5, nil, function()
			arg_42_0.UIRef:showGoldChooseEventLayer(arg_42_1, var_42_0)
		end)
	elseif arg_42_1 == var_0_12 then
		local function var_42_1(arg_45_0)
			local var_45_0 = {}

			for iter_45_0, iter_45_1 in ipairs(arg_42_0.towerPanelInfo) do
				for iter_45_2, iter_45_3 in ipairs(iter_45_1) do
					if iter_45_3.towerItem.type == arg_45_0 and iter_45_3.towerItem.level == 0 then
						table.insert(var_45_0, iter_45_3)
					end
				end
			end

			arg_42_2:deregistration()

			for iter_45_4, iter_45_5 in ipairs(var_45_0) do
				iter_45_5.towerItem:deregistration()
			end

			arg_42_0.is_special_events = false
		end

		arg_42_2:MoveToWithCoordinate(nil, nil, 5, nil, function()
			arg_42_0.UIRef:showGoldChooseEventLayer(arg_42_1, var_42_1)
		end)
	elseif arg_42_1 == var_0_13 then
		arg_42_2:MoveToWithCoordinate(nil, nil, 5, nil, function()
			arg_42_2:becomeOther(math.random(5), 1, true)

			arg_42_0.is_special_events = false
		end)
	end
end

function var_0_0:addRevertArray(arg_48_1, arg_48_2)
	table.insert(self.revertArray, {
		arg_48_1,
		arg_48_2
	})
end

function var_0_0.clearRevertArray(arg_49_0)
	arg_49_0.revertArray = {}
end

function var_0_0:revertHandle()
	if self.gameStatus == var_0_5 then
		return
	end

	if self.dispelCount ~= 0 or self.fallCount ~= 0 or self.becomeCount ~= 0 then
		return
	end

	if self.is_special_events then
		return
	end

	if #self.revertArray == 0 then
		global_ShowBlockWords("没有可以撤回的步骤哦~")

		return
	end

	self.revertArray[#self.revertArray][1]:Swap(self.revertArray[#self.revertArray][2].registrationX, self.revertArray[#self.revertArray][2].registrationY)
	self.revertArray[#self.revertArray][2]:Swap(self.revertArray[#self.revertArray][1].registrationX, self.revertArray[#self.revertArray][1].registrationY)
	table.remove(self.revertArray, #self.revertArray)

	self.swapTimes = self.swapTimes + 1

	self:updateUIRef()
	global_ShowBlockWords("撤回成功！")
end

function var_0_0:buyPhysical(arg_51_1)
	local var_51_0 = activity_towerswap_conf[self.UIRef.activityId].cost_diamond or 20

	LayerManager:pushInLayer("PopDoLayer", {
		costtype = "diamond",
		surecallback = function()
			self:buy_towerswap_physical(arg_51_1)
		end,
		cost = var_51_0,
		own = playermodel.diamond,
		labels = {
			titleImage = "title_warorder.png",
			button = L_BUY_TIMES_MSG_MODETYPE_2.button,
			des = string.format("消耗%d魂晶购买一点体力值", var_51_0)
		}
	})
end

function var_0_0:buy_towerswap_physical(arg_53_1)
	network:rpc("buy_towerswap_physical", {
		activityid = self.UIRef.activityId
	}, function(arg_54_0)
		hx_print("buy_towerswap_physical")
		print_lua_table(arg_54_0)

		if arg_54_0.result == 1 then
			if arg_54_0.cost_diamond then
				playermodel.diamond = playermodel.diamond - arg_54_0.cost_diamond

				global_update_gold_stone_diamond(nil, nil, arg_54_0.cost_diamond)
			end

			self.physical = arg_54_0.physical

			self:updateUIRef()
			global_ShowBlockWords("购买成功！")
		elseif arg_54_0.result == 2 then
			global_ShowBlockWords("体力值已满！")
		elseif arg_54_0.result == 3 then
			global_ShowBlockWords("钻石不足！")
		end
	end)
end

function var_0_0:start_towerswap_game()
	network:rpc("start_towerswap_game", {
		activityid = self.UIRef.activityId
	}, function(arg_56_0)
		hx_print("start_towerswap_game")
		print_lua_table(arg_56_0)

		if arg_56_0.result == 1 then
			self.physical = arg_56_0.physical
			self.max_physical = arg_56_0.max_physical
			self.game_start = arg_56_0.game_start

			self:updateUIRef()
		elseif arg_56_0.result == 2 then
			global_ShowBlockWords("体力值不足！")
		end
	end)
end

function vInTable(arg_57_0, arg_57_1)
	if arg_57_0 == nil then
		return false
	end

	for iter_57_0, iter_57_1 in pairs(arg_57_0) do
		if iter_57_1 == arg_57_1 then
			return true
		end
	end

	return false
end

return var_0_0
