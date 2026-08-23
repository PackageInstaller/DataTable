local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_1 = g.core.const.ConstMgr.PubgConst.map
local PubgMapHelp = require("app.view.module.pubg.view.pubgMap.mapWorld.PubgMapHelp")
local var_0_3 = g.core.model.User.pubgData
local var_0_4
local PubgFloorComp = class("PubgFloorComp", require("app.fairyGUI.pubg.UI_PubgFloorComp"))

function PubgFloorComp:ctor()
	var_0_4 = var_0_3:getMapData()
	self._curPosX = 0
	self._curPosY = 0
	self._curPosDict = {}
	self._userDict = {}
	self._userPoolList = {}
	self._mountainPoolList = {}
	self._mountainUsedDict = {}
	self._fogPoolList = {}
	self._fogUsedDict = {}
	self._grassPoolList = {}
	self._grassUsedDict = {}
	self._levelBanPoolList = {}
	self._levelBanDict = {}
	self._monsterPoolList = {}
	self._monsterDict = {}
	self._buffPoolList = {}
	self._buffCompDict = {}
	self._flagPool = {}
	self._usedFlag = {}
	self._mountainConfig = {}
	self._moveActionCompDict = {}
	self._deadActionCompDict = {}
	self._showCanAttackDict = {}
	self._airDropDict = {}
	self._airDropPoolList = {}
	self._playAirDropAnimUidDict = {}

	self:_initMapFloor()
end

function PubgFloorComp:_initMapFloor()
	for iter_2_0 = 1, 20 do
		local var_2_0 = fgui.UIPackage:createObject("pubg", "PubgGridMountain")

		var_2_0:setVisible(false)
		self.m_mountainAndBuildHolder:addChild(var_2_0)
		table.insert(self._mountainPoolList, var_2_0)
	end

	for iter_2_1 = 1, 10 do
		local var_2_1 = fgui.UIPackage:createObject("pubg", "PubgGridGrass")

		var_2_1:setVisible(false)
		self.m_grassHolder:addChild(var_2_1)
		table.insert(self._grassPoolList, var_2_1)
	end

	for iter_2_2 = 1, 20 do
		local var_2_2 = fgui.UIPackage:createObject("pubg", "PubgGridFog")

		var_2_2:setVisible(false)
		self.m_fogHolder:addChild(var_2_2)
		table.insert(self._fogPoolList, var_2_2)
	end

	for iter_2_3 = 1, 3 do
		local var_2_3 = fgui.UIPackage:createObject("pubg", "PubgGridUser")

		var_2_3:setVisible(false)
		self.m_mountainAndBuildHolder:addChild(var_2_3)
		table.insert(self._userPoolList, var_2_3)
	end

	for iter_2_4 = 1, 20 do
		local var_2_4 = fgui.UIPackage:createObject("pubg", "PubgGridLevelBan")

		var_2_4:setVisible(false)
		self.m_levelBanHolder:addChild(var_2_4)
		table.insert(self._levelBanPoolList, var_2_4)
	end

	for iter_2_5 = 1, 4 do
		local var_2_5 = fgui.UIPackage:createObject("pubg", "PubgGridMonster")

		var_2_5:setVisible(false)
		self.m_mountainAndBuildHolder:addChild(var_2_5)
		table.insert(self._monsterPoolList, var_2_5)
	end

	for iter_2_6 = 1, 4 do
		local var_2_6 = fgui.UIPackage:createObject("pubg", "PubgGridBuff")

		var_2_6:setVisible(false)
		self.m_mountainAndBuildHolder:addChild(var_2_6)
		table.insert(self._buffPoolList, var_2_6)
	end

	for iter_2_7 = 1, 1 do
		local var_2_7 = fgui.UIPackage:createObject("pubg", "PubgGridAirDrop")

		var_2_7:setVisible(false)
		self.m_mountainAndBuildHolder:addChild(var_2_7)
		table.insert(self._airDropPoolList, var_2_7)
	end
end

function PubgFloorComp:loadConfig(arg_3_1)
	self._mountainConfig = require((string.format("app.view.module.pubg.view.pubgMap.mapWorld.mapConfig.PubgMountainConfig_%d", arg_3_1)))
end

function PubgFloorComp:clearConfig(arg_4_1)
	self._mountainConfig = {}
	package.loaded[string.format("app.view.module.pubg.view.pubgMap.mapWorld.mapConfig.PubgMountainConfig_%d", arg_4_1)] = nil
end

function PubgFloorComp:getFogComp()
	local var_5_0 = table.remove(self._fogPoolList)

	if not var_5_0 then
		var_5_0 = fgui.UIPackage:createObject("pubg", "PubgGridFog")

		self.m_fogHolder:addChild(var_5_0)
	end

	var_5_0:setVisible(true)
	var_5_0:setOpacity(255)

	return var_5_0
end

function PubgFloorComp:recycleFogComp(arg_6_1)
	arg_6_1:stopAllFGActions()
	arg_6_1:setVisible(false)
	table.insert(self._fogPoolList, arg_6_1)
end

function PubgFloorComp:getAirDropComp()
	local var_7_0 = table.remove(self._airDropPoolList)

	if not var_7_0 then
		var_7_0 = fgui.UIPackage:createObject("pubg", "PubgGridAirDrop")

		self.m_mountainAndBuildHolder:addChild(var_7_0)
	end

	var_7_0:setVisible(true)

	return var_7_0
end

function PubgFloorComp:recycleAirDropComp(arg_8_1)
	arg_8_1:stopAllFGActions()
	arg_8_1:setVisible(false)
	arg_8_1:resetComp()
	table.insert(self._airDropPoolList, arg_8_1)
end

function PubgFloorComp:getGrassComp()
	local var_9_0 = table.remove(self._grassPoolList)

	if not var_9_0 then
		var_9_0 = fgui.UIPackage:createObject("pubg", "PubgGridGrass")

		self.m_grassHolder:addChild(var_9_0)
	end

	var_9_0:setVisible(true)

	return var_9_0
end

function PubgFloorComp:recycleGrassComp(arg_10_1)
	arg_10_1:setVisible(false)
	table.insert(self._grassPoolList, arg_10_1)
end

function PubgFloorComp:getUserComp()
	local var_11_0 = table.remove(self._userPoolList)

	if not var_11_0 then
		var_11_0 = fgui.UIPackage:createObject("pubg", "PubgGridUser")

		self.m_mountainAndBuildHolder:addChild(var_11_0)
	end

	var_11_0:setVisible(true)

	return var_11_0
end

function PubgFloorComp:recycleUserComp(arg_12_1)
	arg_12_1:setVisible(false)
	arg_12_1:resetComp()
	table.insert(self._userPoolList, arg_12_1)
end

function PubgFloorComp:getMonsterComp()
	local var_13_0 = table.remove(self._monsterPoolList)

	if not var_13_0 then
		var_13_0 = fgui.UIPackage:createObject("pubg", "PubgGridMonster")

		self.m_mountainAndBuildHolder:addChild(var_13_0)
	end

	var_13_0:setVisible(true)

	return var_13_0
end

function PubgFloorComp:recycleMonsterComp(arg_14_1)
	arg_14_1:setVisible(false)
	arg_14_1:resetComp()
	table.insert(self._monsterPoolList, arg_14_1)
end

function PubgFloorComp:getBuffComp()
	local var_15_0 = table.remove(self._buffPoolList)

	if not var_15_0 then
		var_15_0 = fgui.UIPackage:createObject("pubg", "PubgGridBuff")

		self.m_mountainAndBuildHolder:addChild(var_15_0)
	end

	var_15_0:setVisible(true)

	return var_15_0
end

function PubgFloorComp:recycleBuffComp(arg_16_1)
	arg_16_1:resetComp()
	arg_16_1:setVisible(false)
	table.insert(self._buffPoolList, arg_16_1)
end

function PubgFloorComp:getLevelBanComp()
	local var_17_0 = table.remove(self._levelBanPoolList)

	if not var_17_0 then
		var_17_0 = fgui.UIPackage:createObject("pubg", "PubgGridLevelBan")

		self.m_levelBanHolder:addChild(var_17_0)
	end

	var_17_0:setVisible(true)

	return var_17_0
end

function PubgFloorComp:recycleLevelBanComp(arg_18_1)
	arg_18_1:setVisible(false)
	table.insert(self._levelBanPoolList, arg_18_1)
end

function PubgFloorComp:getMountainComp()
	local var_19_0 = table.remove(self._mountainPoolList)

	if not var_19_0 then
		var_19_0 = fgui.UIPackage:createObject("pubg", "PubgGridMountain")

		self.m_mountainAndBuildHolder:addChild(var_19_0)
	end

	var_19_0:setVisible(true)

	return var_19_0
end

function PubgFloorComp:recycleMountainComp(arg_20_1)
	arg_20_1:setVisible(false)
	table.insert(self._mountainPoolList, arg_20_1)
end

function PubgFloorComp:updateCurPos(arg_21_1, arg_21_2)
	local var_21_0, var_21_1 = PubgMapHelp.pixelToCoord(-arg_21_1, arg_21_2)

	if math.abs(self._curPosX - arg_21_1) < var_0_1.MAP_DRAG_CHECK_NUM * var_0_1.MAP_TILE_WIDTH and math.abs(self._curPosY - arg_21_2) < var_0_1.MAP_DRAG_CHECK_NUM * var_0_1.MAP_TILE_HEIGHT then
		return
	end

	self._curPosX = arg_21_1
	self._curPosY = arg_21_2

	local var_21_2 = math.ceil(display.width / (2 * var_0_1.MAP_TILE_WIDTH)) + var_0_1.MAP_BORDER_NUM
	local var_21_3 = math.ceil(display.height / (2 * var_0_1.MAP_TILE_HEIGHT)) + var_0_1.MAP_BORDER_NUM
	local var_21_4 = {}

	for iter_21_0 = 1, 2 * var_21_2 do
		for iter_21_1 = 1, 2 * var_21_3 do
			local var_21_5 = math.max(0, var_21_0 - var_21_2 - var_21_3 + iter_21_0 + iter_21_1)
			local var_21_6 = math.max(0, var_21_1 + var_21_2 - var_21_3 - iter_21_0 + iter_21_1)

			self:checkTempPos(var_21_5, var_21_6, var_21_4)
			self:checkTempPos(var_21_5, math.max(0, var_21_6 - 1), var_21_4)
		end
	end

	self:checkTempPosDictDiff(var_21_4)

	self._curPosDict = var_21_4
end

function PubgFloorComp:checkTempPos(arg_22_1, arg_22_2, arg_22_3)
	if arg_22_1 + arg_22_2 <= 0 then
		return
	end

	arg_22_3[PubgMapHelp.getKey(arg_22_1, arg_22_2)] = true
end

function PubgFloorComp:checkTempPosDictDiff(arg_23_1)
	local var_23_0 = {}
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		if iter_23_1 and not self._curPosDict[iter_23_0] then
			table.insert(var_23_0, iter_23_0)
		end
	end

	for iter_23_2, iter_23_3 in pairs(self._curPosDict) do
		if iter_23_3 and not arg_23_1[iter_23_2] then
			table.insert(var_23_1, iter_23_2)
		end
	end

	self:checkDelPosList(var_23_1)
	self:checkAddPosList(var_23_0)
	self:sortMountainAndUserComp()
	self:sortGrassComp()
end

function PubgFloorComp:sortMountainAndUserComp()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(self._mountainUsedDict) do
		local var_24_1, var_24_2 = PubgMapHelp.getPos(iter_24_0)

		table.insert(var_24_0, {
			x = var_24_1,
			y = var_24_2,
			comp = iter_24_1
		})
	end

	for iter_24_2, iter_24_3 in pairs(self._monsterDict) do
		local var_24_3, var_24_4 = PubgMapHelp.getPos(iter_24_2)

		table.insert(var_24_0, {
			x = var_24_3 + 1,
			y = var_24_4 + 1,
			comp = iter_24_3
		})
	end

	for iter_24_4, iter_24_5 in pairs(self._userDict) do
		for iter_24_6, iter_24_7 in pairs(iter_24_5) do
			local var_24_5, var_24_6 = PubgMapHelp.getPos(iter_24_4)

			table.insert(var_24_0, {
				x = var_24_5 + 1,
				y = var_24_6 + 1,
				comp = iter_24_7
			})
		end
	end

	for iter_24_8, iter_24_9 in pairs(self._moveActionCompDict) do
		for iter_24_10, iter_24_11 in pairs(iter_24_9) do
			local var_24_7, var_24_8 = PubgMapHelp.getPos(iter_24_8)

			table.insert(var_24_0, {
				x = var_24_7 + 2,
				y = var_24_8 + 2,
				comp = iter_24_11
			})
		end
	end

	for iter_24_12, iter_24_13 in pairs(self._buffCompDict) do
		local var_24_9, var_24_10 = PubgMapHelp.getPos(iter_24_12)

		table.insert(var_24_0, {
			x = var_24_9,
			y = var_24_10,
			comp = iter_24_13
		})
	end

	table.sort(var_24_0, function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0.x + arg_25_0.y
		local var_25_1 = arg_25_1.x + arg_25_1.y

		if arg_25_0.x + arg_25_0.y == arg_25_1.x + arg_25_1.y then
			return arg_25_0.x < arg_25_1.x
		end

		return var_25_0 < var_25_1
	end)

	for iter_24_14 = 1, #var_24_0 do
		self.m_mountainAndBuildHolder:setChildIndex(var_24_0[iter_24_14].comp, iter_24_14 - 1)
	end
end

function PubgFloorComp:sortGrassComp()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self._grassUsedDict) do
		local var_26_1, var_26_2 = PubgMapHelp.getPos(iter_26_0)

		table.insert(var_26_0, {
			x = var_26_1,
			y = var_26_2,
			comp = iter_26_1
		})
	end

	table.sort(var_26_0, function(arg_27_0, arg_27_1)
		local var_27_0 = arg_27_0.x + arg_27_0.y
		local var_27_1 = arg_27_1.x + arg_27_1.y

		if arg_27_0.x + arg_27_0.y == arg_27_1.x + arg_27_1.y then
			return arg_27_0.x < arg_27_1.x
		end

		return var_27_0 < var_27_1
	end)

	for iter_26_2 = 1, #var_26_0 do
		self.m_grassHolder:setChildIndex(var_26_0[iter_26_2].comp, iter_26_2 - 1)
	end
end

function PubgFloorComp:checkDelPosList(arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		if self._mountainUsedDict[iter_28_1] then
			self:recycleMountainComp(self._mountainUsedDict[iter_28_1])

			self._mountainUsedDict[iter_28_1] = nil
		end

		if self._fogUsedDict[iter_28_1] then
			self:recycleFogComp(self._fogUsedDict[iter_28_1])

			self._fogUsedDict[iter_28_1] = nil
		end

		if self._grassUsedDict[iter_28_1] then
			self:recycleGrassComp(self._grassUsedDict[iter_28_1])

			self._grassUsedDict[iter_28_1] = nil
		end

		if self._userDict[iter_28_1] then
			for iter_28_2, iter_28_3 in pairs(self._userDict[iter_28_1]) do
				self:recycleUserComp(iter_28_3)

				self._userDict[iter_28_1][iter_28_2] = nil
			end
		end

		if self._levelBanDict[iter_28_1] then
			self:recycleLevelBanComp(self._levelBanDict[iter_28_1])

			self._levelBanDict[iter_28_1] = nil
		end

		if self._monsterDict[iter_28_1] then
			self:recycleMonsterComp(self._monsterDict[iter_28_1])

			self._monsterDict[iter_28_1] = nil
		end

		if self._buffCompDict[iter_28_1] then
			self:recycleBuffComp(self._buffCompDict[iter_28_1])

			self._buffCompDict[iter_28_1] = nil
		end

		if self._levelBanDict[iter_28_1] then
			self:recycleLevelBanComp(self._levelBanDict[iter_28_1])

			self._levelBanDict[iter_28_1] = nil
		end

		if self._airDropDict[iter_28_1] then
			self:recycleAirDropComp(self._airDropDict[iter_28_1])

			self._airDropDict[iter_28_1] = nil
		end
	end
end

function PubgFloorComp:checkAddPosList(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_0, var_29_1 = PubgMapHelp.getPos(iter_29_1)
		local var_29_2, var_29_3 = PubgMapHelp.coordToCompPos(var_29_0, var_29_1)

		if self._mountainConfig[iter_29_1] then
			local var_29_4 = self:getMountainComp()

			var_29_4:setPosition(var_29_2, var_29_3)
			var_29_4:setIcon("ui://pubg/" .. self._mountainConfig[iter_29_1])

			self._mountainUsedDict[iter_29_1] = var_29_4
		end

		if var_0_4:isGrass(iter_29_1) then
			local var_29_5 = self:getGrassComp()

			var_29_5:setPosition(var_29_2, var_29_3)

			self._grassUsedDict[iter_29_1] = var_29_5
		end

		if var_0_4:isBan(iter_29_1) then
			local var_29_6 = self:getLevelBanComp()

			var_29_6:setPosition(var_29_2, var_29_3)
			var_29_6:setOpacity(255)

			self._levelBanDict[iter_29_1] = var_29_6
		elseif var_0_4:isBaning(iter_29_1) then
			local var_29_7 = self:getLevelBanComp()

			var_29_7:setPosition(var_29_2, var_29_3)
			var_29_7:setOpacity(100)

			self._levelBanDict[iter_29_1] = var_29_7
		end

		local var_29_8 = var_0_4:getMonsterByPos(var_29_0, var_29_1)

		if var_29_8 then
			local var_29_9 = self:getMonsterComp()

			var_29_9:setPosition(var_29_2, var_29_3)
			var_29_9:setMonster(var_29_8)

			self._monsterDict[iter_29_1] = var_29_9
		end

		local var_29_10 = var_0_4:getBuffByPos(var_29_0, var_29_1)

		if var_29_10 then
			local var_29_11 = self:getBuffComp()

			var_29_11:setPosition(var_29_2, var_29_3)
			var_29_11:setBuff(var_29_10)

			self._buffCompDict[iter_29_1] = var_29_11
		end

		local var_29_12 = var_0_4:getAirDropByPos(var_29_0, var_29_1)

		if var_29_12 then
			local var_29_13 = self:getAirDropComp()

			var_29_13:setPosition(var_29_2, var_29_3)
			var_29_13:setAirDrop(var_29_12)

			self._airDropDict[iter_29_1] = var_29_13
		end

		if var_0_4:hasFog(var_29_0, var_29_1) then
			local var_29_14 = self:getFogComp()

			var_29_14:setPosition(var_29_2, var_29_3)

			self._fogUsedDict[iter_29_1] = var_29_14
		elseif var_0_4:isSightGrassWithMe(iter_29_1) then
			for iter_29_2, iter_29_3 in ipairs((var_0_4:getUserByPos(var_29_0, var_29_1))) do
				if iter_29_3:isMe() or not iter_29_3:isHide() then
					local var_29_15 = self:getUserComp()

					var_29_15:setPosition(var_29_2, var_29_3)
					var_29_15:setUser(iter_29_3)

					self._userDict[iter_29_1] = self._userDict[iter_29_1] or {}
					self._userDict[iter_29_1][iter_29_3:getUid()] = var_29_15

					var_29_15:setGrass(self._grassUsedDict[iter_29_1] ~= nil or iter_29_3:isHide())
				end
			end
		end
	end
end

function PubgFloorComp:refreshGridList(arg_30_1, arg_30_2, arg_30_3)
	for iter_30_0, iter_30_1 in pairs(arg_30_1) do
		if self._curPosDict[iter_30_0] then
			local var_30_0, var_30_1 = PubgMapHelp.getPos(iter_30_0)
			local var_30_2, var_30_3 = PubgMapHelp.coordToCompPos(var_30_0, var_30_1)
			local var_30_4 = self._grassUsedDict[iter_30_0]

			if var_0_4:hasFog(var_30_0, var_30_1) then
				if not self._fogUsedDict[iter_30_0] then
					local var_30_5 = self:getFogComp()

					var_30_5:setPosition(var_30_2, var_30_3)

					self._fogUsedDict[iter_30_0] = var_30_5
				end

				if self._userDict[iter_30_0] then
					for iter_30_2, iter_30_3 in pairs(self._userDict[iter_30_0]) do
						self:recycleUserComp(iter_30_3)

						self._userDict[iter_30_0][iter_30_2] = nil
					end
				end
			else
				local var_30_6

				if self._fogUsedDict[iter_30_0] then
					self:recycleFogComp(self._fogUsedDict[iter_30_0])

					self._fogUsedDict[iter_30_0] = nil
					var_30_6 = {}
				end

				if var_0_4:isSightGrassWithMe(iter_30_0) then
					for iter_30_4, iter_30_5 in ipairs((var_0_4:getUserByPos(var_30_0, var_30_1))) do
						if iter_30_5:isMe() or not iter_30_5:isHide() then
							local var_30_7 = iter_30_5:getUid()

							var_30_6[var_30_7] = true
							self._userDict[iter_30_0] = self._userDict[iter_30_0] or {}

							local var_30_8 = self._userDict[iter_30_0][var_30_7]

							if not self._userDict[iter_30_0][var_30_7] then
								var_30_8 = self:getUserComp()

								var_30_8:setPosition(var_30_2, var_30_3)

								self._userDict[iter_30_0][var_30_7] = var_30_8
							end

							var_30_8:setUser(iter_30_5)
							var_30_8:setGrass(var_30_4 ~= nil or iter_30_5:isHide())
						end
					end
				end

				if self._userDict[iter_30_0] then
					for iter_30_6, iter_30_7 in pairs(self._userDict[iter_30_0]) do
						if not var_30_6[iter_30_6] then
							self:recycleUserComp(iter_30_7)

							self._userDict[iter_30_0][iter_30_6] = nil
						end
					end
				end
			end

			local var_30_9 = self._monsterDict[iter_30_0]
			local var_30_10 = var_0_4:getMonsterByPos(var_30_0, var_30_1)

			if var_30_10 then
				if not var_30_9 then
					var_30_9 = self:getMonsterComp()

					var_30_9:setPosition(var_30_2, var_30_3)
					var_30_9:setMonster(var_30_10)

					self._monsterDict[iter_30_0] = var_30_9
				else
					var_30_9:setMonster(var_30_10)
				end

				if arg_30_2 then
					var_30_9:playRefreshEventEff()
				end
			elseif var_30_9 then
				self:recycleMonsterComp(var_30_9)

				self._monsterDict[iter_30_0] = nil
			end

			local var_30_11 = self._buffCompDict[iter_30_0]
			local var_30_12 = var_0_4:getBuffByPos(var_30_0, var_30_1)

			if var_30_12 then
				if not var_30_11 then
					var_30_11 = self:getBuffComp()

					var_30_11:setPosition(var_30_2, var_30_3)
					var_30_11:setBuff(var_30_12)

					self._buffCompDict[iter_30_0] = var_30_11
				else
					var_30_11:setBuff(var_30_12)
				end

				if arg_30_2 then
					var_30_11:playRefreshEventEff(nil)
				end
			elseif var_30_11 then
				self:recycleBuffComp(var_30_11)

				self._buffCompDict[iter_30_0] = nil
			end

			local var_30_13 = self._airDropDict[iter_30_0]
			local var_30_14 = var_0_4:getAirDropByPos(var_30_0, var_30_1)

			if var_30_14 then
				if not var_30_13 then
					var_30_13 = self:getAirDropComp()

					var_30_13:setPosition(var_30_2, var_30_3)
					var_30_13:setAirDrop(var_30_14)

					self._airDropDict[iter_30_0] = var_30_13
				else
					var_30_13:setAirDrop(var_30_14)
				end

				if arg_30_3 == var_30_14:getUid() then
					var_30_13:playRefreshEventEff(nil)
				end
			elseif var_30_13 then
				self:recycleAirDropComp(var_30_13)

				self._airDropDict[iter_30_0] = nil
			end

			local var_30_15 = self._levelBanDict[iter_30_0]

			if var_0_4:isBan(iter_30_0) then
				if not var_30_15 then
					var_30_15 = self:getLevelBanComp()

					var_30_15:setPosition(var_30_2, var_30_3)
					var_30_15:setOpacity(255)

					self._levelBanDict[iter_30_0] = var_30_15
				else
					var_30_15:setOpacity(255)
				end
			elseif var_0_4:isBaning(iter_30_0) then
				if not var_30_15 then
					var_30_15 = self:getLevelBanComp()

					var_30_15:setPosition(var_30_2, var_30_3)
					var_30_15:setOpacity(100)

					self._levelBanDict[iter_30_0] = var_30_15
				else
					var_30_15:setOpacity(100)
				end
			elseif var_30_15 then
				self:recycleLevelBanComp(var_30_15)

				self._levelBanDict[iter_30_0] = nil
			end
		end
	end
end

function PubgFloorComp:refreshGridByUser(arg_31_1, arg_31_2)
	if not arg_31_1 then
		self:refreshGridList(var_0_4:getMyUser():getUserVisualFieldPos())
	else
		local var_31_0 = var_0_4:getUserById(arg_31_1)

		if var_31_0:isMe() then
			self:refreshGridList(var_31_0:getUserVisualFieldPos())
		elseif var_0_4:getMyUser():isInVisualField(var_31_0:getPos()) then
			self:refreshGridList({
				[PubgMapHelp.getKey(var_31_0:getPos())] = true
			})
		end
	end

	if arg_31_2 then
		self:sortMountainAndUserComp()
	end
end

function PubgFloorComp:refreshLevelChange()
	self:refreshGridList(self._curPosDict)
end

function PubgFloorComp:refreshShowLevelBaning()
	self:refreshGridList(self._curPosDict)
end

function PubgFloorComp:refreshAirDrop(arg_34_1)
	self:refreshGridList(self._airDropDict, false, arg_34_1)
end

function PubgFloorComp:stopUserAirDrop(arg_35_1)
	for iter_35_0, iter_35_1 in pairs(self._playAirDropAnimUidDict) do
		local var_35_0 = PubgMapHelp.getKey(var_0_4:getUserById(iter_35_0):getPos())
		local var_35_1 = self._userDict[var_35_0] and self._userDict[var_35_0][iter_35_0]

		if var_35_1 then
			var_35_1:playKnightAnimation(BattleConst.SPINE_ACTION_TYPE.IDLE, true, 1)
		end
	end

	self._playAirDropAnimUidDict = {}

	self:refreshGridByUser(arg_35_1.user_id)
end

function PubgFloorComp:playUserPickingAirDrop(arg_36_1)
	self:refreshAirDrop()
	self:refreshGridByUser(arg_36_1.user_id, false)

	local var_36_0 = PubgMapHelp.getKey(var_0_4:getUserById(arg_36_1.user_id):getPos())
	local var_36_1 = self._userDict[var_36_0] and self._userDict[var_36_0][arg_36_1.user_id]

	if var_36_1 then
		var_36_1:playKnightAnimation(BattleConst.SPINE_ACTION_TYPE.ATTACK, true, 1)

		self._playAirDropAnimUidDict[arg_36_1.user_id] = true
	end
end

function PubgFloorComp:playUserMove(arg_37_1)
	local var_37_0 = arg_37_1.user_id

	self:refreshGridByUser(nil, false)

	local var_37_1 = PubgMapHelp.getKey(arg_37_1.x, arg_37_1.y)
	local var_37_2 = self._userDict[var_37_1] and self._userDict[var_37_1][arg_37_1.user_id]

	if var_37_2 then
		local var_37_3 = var_37_2:getUser()
		local var_37_4 = cc.p(arg_37_1.x, arg_37_1.y)

		if var_37_4 then
			local var_37_5 = var_37_3:getOldPos()

			if var_37_5.x ~= var_37_4.x or var_37_5.y ~= var_37_4.y then
				var_37_2:setVisible(false)

				local var_37_6 = self:getUserComp()

				self._moveActionCompDict[var_37_1] = self._moveActionCompDict[var_37_1] or {}
				self._moveActionCompDict[var_37_1][arg_37_1.user_id] = var_37_6

				var_37_6:setUser(var_37_3)

				local var_37_7 = cc.p(PubgMapHelp.coordToCompPos(var_37_5.x, var_37_5.y))

				var_37_6:setPosition(var_37_7)

				local var_37_8 = cc.p(PubgMapHelp.coordToCompPos(var_37_4.x, var_37_4.y))
				local var_37_9 = cc.pSub(var_37_8, var_37_7)

				if var_37_9.x < 0 then
					var_37_2:setKnightScaleX(-1)
					var_37_6:setKnightScaleX(-1)
				elseif var_37_9.x > 0 then
					var_37_2:setKnightScaleX(1)
					var_37_6:setKnightScaleX(1)
				end

				local var_37_10 = cc.pAdd(var_37_9, cc.p(0, -60))
				local var_37_11 = var_37_3:getMovingActionTime() / 2
				local var_37_12 = cc.Director:getInstance():getScheduler():getTimeScale()

				var_37_6:runFGAction((fgui.FSequence:create({
					fgui.FMoveTo:create(var_37_11 * var_37_12, cc.pAdd(var_37_7, cc.p(var_37_10.x / 2, var_37_10.y / 2))),
					fgui.FMoveTo:create(var_37_11 * var_37_12, cc.p(var_37_8)),
					(fgui.FCallFunc:create(handler(self, function(arg_38_0)
						var_37_3:setMovingPos(nil)

						local var_38_0 = arg_38_0._userDict[var_37_1] and arg_38_0._userDict[var_37_1][var_37_0]

						if var_38_0 then
							var_38_0:setVisible(true)
						end

						arg_38_0:recycleUserComp(var_37_6)

						arg_38_0._moveActionCompDict[var_37_1][var_37_0] = nil
					end)))
				})))

				if self._grassUsedDict[var_37_1] or var_37_3:isHide() then
					var_37_6:setGrass(true)
				end

				self:sortMountainAndUserComp()
			end
		end
	end
end

function PubgFloorComp:addExp(arg_39_1)
	local var_39_0 = var_0_4:getMyUser()

	if var_39_0 then
		local var_39_1 = var_39_0:getUid()
		local var_39_2 = PubgMapHelp.getKey(var_39_0:getPos())

		if self._userDict[var_39_2] and self._userDict[var_39_2][var_39_1] then
			self._userDict[var_39_2][var_39_1]:addExp(arg_39_1)
		end

		if self._moveActionCompDict[var_39_2] and self._moveActionCompDict[var_39_2][var_39_1] then
			self._moveActionCompDict[var_39_2][var_39_1]:addExp(arg_39_1)
		end
	end
end

function PubgFloorComp:monsterDead(arg_40_1)
	if arg_40_1 then
		local var_40_0 = PubgMapHelp.getKey(arg_40_1:getPos())

		if self._monsterDict[var_40_0] then
			self:recycleMonsterComp(self._monsterDict[var_40_0])

			self._monsterDict[var_40_0] = nil
		end
	end
end

function PubgFloorComp:userDead(arg_41_1)
	local var_41_0 = arg_41_1:getUid()

	if arg_41_1 then
		local var_41_1 = PubgMapHelp.getKey(arg_41_1:getPos())
		local var_41_2 = self._userDict[var_41_1] and self._userDict[var_41_1][var_41_0]

		if var_41_2 then
			self:recycleUserComp(var_41_2)

			self._userDict[var_41_1][var_41_0] = nil
		end
	end
end

function PubgFloorComp:userRecover(arg_42_1)
	self:refreshGridByUser(arg_42_1.user_id, true)

	local var_42_0 = var_0_4:getUserById(arg_42_1.user_id)
	local var_42_1 = PubgMapHelp.getKey(var_42_0:getPos())
	local var_42_2 = self._userDict[var_42_1]

	if self._userDict[var_42_1] then
		var_42_2 = self._userDict[var_42_1][var_42_0:getUid()]
	end

	if var_42_2 then
		var_42_2:playReliveEffect()
		var_42_2:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			var_42_2:playKnightAnimation(BattleConst.SPINE_ACTION_TYPE.IN, false)
		end), cc.DelayTime:create(1), cc.CallFunc:create(function()
			var_42_2:playKnightAnimation(BattleConst.SPINE_ACTION_TYPE.IDLE, true)
		end)))
	end

	local var_42_3 = self._moveActionCompDict[var_42_1] and self._moveActionCompDict[var_42_1][var_42_0:getUid()]

	if var_42_3 then
		var_42_3:playReliveEffect()
	end
end

function PubgFloorComp:pickBuffNotify(arg_45_1)
	local var_45_0 = var_0_4:getPickBuffById(arg_45_1.id)

	if var_45_0 then
		local var_45_1 = PubgMapHelp.getKey(var_45_0:getPos())
		local var_45_2 = self._buffCompDict[var_45_1]

		if self._buffCompDict[var_45_1] then
			self._buffCompDict[var_45_1] = nil

			self._buffCompDict[var_45_1]:playGetBuffEff(handler(self, function(arg_46_0)
				arg_46_0:recycleBuffComp(var_45_2)
			end))
		end

		local var_45_3 = var_0_4:getUserById(arg_45_1.userId)

		if var_45_3:isMe() then
			local var_45_4 = PubgMapHelp.getKey(var_45_3:getPos())
			local var_45_5 = self._userDict[var_45_4] and self._userDict[var_45_4][var_45_3:getUid()]

			if var_45_5 then
				var_45_5:playGetBuffEff(var_45_0)
				var_45_5:setGrass(var_45_3:isHide())
			end

			local var_45_6 = self._moveActionCompDict[var_45_4] and self._moveActionCompDict[var_45_4][var_45_3:getUid()]

			if var_45_6 then
				var_45_6:playGetBuffEff(var_45_0)
				var_45_6:setGrass(var_45_3:isHide())
			end
		end
	end

	var_0_4:delPickBuff(arg_45_1.id)
end

function PubgFloorComp:pickAirDropEnd(arg_47_1)
	local var_47_0 = var_0_4:getPickAirDropById(arg_47_1.airdrop_id)

	if var_47_0 then
		local var_47_1 = PubgMapHelp.getKey(var_47_0:getPos())
		local var_47_2 = self._airDropDict[var_47_1]

		if self._airDropDict[var_47_1] then
			self._airDropDict[var_47_1] = nil

			self._airDropDict[var_47_1]:playGetAirDropEff(handler(self, function(arg_48_0)
				arg_48_0:recycleAirDropComp(var_47_2)
			end))
		end

		local var_47_3 = var_0_4:getUserById(arg_47_1.user_id)
		local var_47_4 = PubgMapHelp.getKey(var_47_3:getPos())
		local var_47_5 = self._userDict[var_47_4] and self._userDict[var_47_4][var_47_3:getUid()]

		if var_47_5 then
			var_47_5:playPickAirDropEffect(var_47_0)
		end

		local var_47_6 = self._moveActionCompDict[var_47_4] and self._moveActionCompDict[var_47_4][var_47_3:getUid()]

		if var_47_6 then
			var_47_6:playPickAirDropEffect(var_47_0)
		end
	end

	var_0_4:delPickAirDrop(arg_47_1.airdrop_id)
	self:refreshAirDrop()
	self:stopUserAirDrop(arg_47_1)
end

function PubgFloorComp:playUserLevelUp(arg_49_1)
	local var_49_0 = var_0_4:getUserById(arg_49_1)
	local var_49_1 = PubgMapHelp.getKey(var_49_0:getPos())
	local var_49_2 = self._userDict[var_49_1] and self._userDict[var_49_1][var_49_0:getUid()]

	if var_49_2 then
		var_49_2:playLevelUpEffect()
	end

	local var_49_3 = self._moveActionCompDict[var_49_1] and self._moveActionCompDict[var_49_1][var_49_0:getUid()]

	if var_49_3 then
		var_49_3:playLevelUpEffect()
	end
end

function PubgFloorComp:playUserReliveUp(arg_50_1)
	local var_50_0 = var_0_4:getUserById(arg_50_1)
	local var_50_1 = PubgMapHelp.getKey(var_50_0:getPos())
	local var_50_2 = self._userDict[var_50_1] and self._userDict[var_50_1][var_50_0:getUid()]

	if var_50_2 then
		var_50_2:playReliveEffect()
	end

	local var_50_3 = self._moveActionCompDict[var_50_1] and self._moveActionCompDict[var_50_1][var_50_0:getUid()]

	if var_50_3 then
		var_50_3:playReliveEffect()
	end
end

function PubgFloorComp:removeBuffNotify(arg_51_1)
	self:refreshGridByUser(arg_51_1.user_id)
end

function PubgFloorComp:refreshEvent(arg_52_1)
	self:refreshGridList(self._curPosDict, true)
end

function PubgFloorComp:refreshInvincibleUsers(arg_53_1)
	for iter_53_0, iter_53_1 in ipairs(arg_53_1) do
		local var_53_0 = PubgMapHelp.getKey(iter_53_1:getPos())
		local var_53_1 = self._userDict[var_53_0] and self._userDict[var_53_0][iter_53_1:getUid()]

		if var_53_1 then
			var_53_1:refreshInvincibleState()
		end
	end
end

function PubgFloorComp:refreshAddExp(arg_54_1)
	self:addExp(arg_54_1)
end

function PubgFloorComp:playDeadNotify(arg_55_1)
	local var_55_0 = var_0_4:getMyUser()
	local var_55_1 = arg_55_1.dead

	if arg_55_1.tp == 1 then
		local var_55_2 = var_0_4:getUserById(var_55_1.id)

		if not var_55_2 then
			return
		end

		if not var_55_2:isMe() and not var_55_0:isInVisualField(var_55_2:getPos()) then
			return
		end

		self:userDead(var_55_2)

		local var_55_3 = self:getUserComp()

		var_55_3:setUser(var_55_2)
		var_55_3:setPosition(PubgMapHelp.coordToCompPos(var_55_2:getPos()))

		self._deadActionCompDict[var_55_2:getOnlyKey()] = var_55_3

		self:playDeadAction(var_55_1)
	elseif arg_55_1.tp == 2 then
		if var_55_1.tp == 1 then
			local var_55_4 = var_0_4:getDeadMonsterById(var_55_1.id)

			if not var_55_4 then
				return
			end

			if not var_55_0:isInVisualField(var_55_4:getPos()) then
				return
			end

			self:monsterDead(var_55_4)

			local var_55_5 = self:getMonsterComp()

			var_55_5:setPosition(PubgMapHelp.coordToCompPos(var_55_4:getPos()))
			var_55_5:setMonster(var_55_4)

			self._deadActionCompDict[var_55_4:getOnlyKey()] = var_55_5
		elseif var_55_1.tp == 2 then
			local var_55_6 = var_0_4:getUserById(var_55_1.id)

			if not var_55_6 then
				return
			end

			if not var_55_6:isMe() and not var_55_0:isInVisualField(var_55_6:getPos()) then
				return
			end

			self:userDead(var_55_6)

			local var_55_7 = self:getUserComp()

			var_55_7:setUser(var_55_6)
			var_55_7:setPosition(PubgMapHelp.coordToCompPos(var_55_6:getPos()))

			self._deadActionCompDict[var_55_6:getOnlyKey()] = var_55_7
		end

		self:playAttackAction(arg_55_1.attack, arg_55_1.defend, handler(self, self.playDeadAction), var_55_1)
	end
end

function PubgFloorComp:playAttackAction(arg_56_1, arg_56_2, arg_56_3, arg_56_4)
	local var_56_0 = var_0_4:getUserById(arg_56_1.id)
	local var_56_1 = arg_56_2.tp == 1 and (arg_56_4.tp == 2 and var_0_4:getMonsterById(arg_56_2.id) or var_0_4:getDeadMonsterById(arg_56_2.id)) or var_0_4:getUserById(arg_56_2.id)

	if not var_56_0 or not var_56_1 then
		return
	end

	local var_56_2, var_56_3 = var_56_0:getPos()
	local var_56_4, var_56_5 = PubgMapHelp.coordToCompPos(var_56_2, var_56_3)
	local var_56_6, var_56_7 = PubgMapHelp.coordToCompPos(var_56_1:getPos())
	local var_56_8 = fgui.GComponent:create()

	self.m_effectHolder:addChild(var_56_8)
	var_56_8:setPosition(var_56_4, var_56_5 - 50)
	var_56_8:runFGAction((fgui.FSequence:create({
		fgui.FMoveTo:create(0.3, cc.p(var_56_6, var_56_7 - 50)),
		(fgui.FCallFunc:create(function()
			if arg_56_3 then
				arg_56_3(arg_56_4)
			end
		end))
	})))

	if not var_56_0:isDead() then
		local var_56_9 = PubgMapHelp.getKey(var_56_2, var_56_3)
		local var_56_10 = self._userDict[var_56_9]

		if self._userDict[var_56_9] then
			var_56_10 = self._userDict[var_56_9][var_56_0:getUid()]
		end

		if var_56_10 then
			if var_56_6 - var_56_4 < 0 then
				var_56_10:setKnightScaleX(-1)
			elseif var_56_6 - var_56_4 > 0 then
				var_56_10:setKnightScaleX(1)
			end

			var_56_10:runAction(self:createAttackAction(var_56_10, handler(self, function(arg_58_0, arg_58_1)
				arg_58_0:refreshGridList({
					[var_56_9] = true
				})
			end), var_56_10))
		else
			var_56_10 = self:getUserComp()

			var_56_10:setPosition(var_56_4, var_56_5)
			var_56_10:setUser(var_56_0)
			var_56_10:runAction(self:createAttackAction(var_56_10, handler(self, function(arg_59_0, arg_59_1)
				arg_59_0:refreshGridList({
					[var_56_9] = true
				})
				arg_59_0:recycleUserComp(var_56_10)
			end), var_56_10))
		end
	end

	if arg_56_2.tp == 2 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.PUBG_DEAD_CLIENT_TIP, false, nil, {})
	end

	if var_56_0:isMe() then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SH_Attack_other_players)
	end
end

function PubgFloorComp:onAttackActionEnd(arg_60_1)
	self:recycleUserComp(arg_60_1)
end

function PubgFloorComp:playDeadAction(arg_61_1)
	if arg_61_1.tp == 1 then
		local var_61_0 = var_0_4:getDeadMonsterById(arg_61_1.id)

		if not var_61_0 then
			return
		end

		local var_61_1 = self._deadActionCompDict[var_61_0:getOnlyKey()]

		if var_61_1 then
			var_61_1:runAction(self:createDeadAction(var_61_1, handler(self, self.onDeadActionEnd), var_61_0))
		end
	elseif arg_61_1.tp == 2 then
		local var_61_2 = var_0_4:getUserById(arg_61_1.id)

		if not var_61_2 then
			return
		end

		local var_61_3 = self._deadActionCompDict[var_61_2:getOnlyKey()]

		if var_61_3 then
			var_61_3:runAction(self:createDeadAction(var_61_3, handler(self, self.onDeadActionEnd), var_61_2))
		end
	end
end

function PubgFloorComp:onDeadActionEnd(arg_62_1)
	if arg_62_1:getType() == var_0_1.itemType.knight then
		local var_62_0 = self._deadActionCompDict[arg_62_1:getOnlyKey()]

		if var_62_0 then
			self:recycleUserComp(var_62_0)

			self._deadActionCompDict[arg_62_1:getOnlyKey()] = nil
		end

		if arg_62_1:isMe() then
			self:refreshGridByUser(nil, true)
		end
	elseif arg_62_1:getType() == var_0_1.itemType.monster then
		local var_62_1 = self._deadActionCompDict[arg_62_1:getOnlyKey()]

		if var_62_1 then
			self:recycleMonsterComp(var_62_1)

			self._deadActionCompDict[arg_62_1:getOnlyKey()] = nil
		end
	end
end

function PubgFloorComp:createDeadAction(arg_63_1, arg_63_2, arg_63_3)
	return cc.Sequence:create(cc.CallFunc:create(function()
		arg_63_1:playDeadEffect()
		arg_63_1:playKnightAnimation(BattleConst.SPINE_ACTION_TYPE.DEAD, false)
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		arg_63_1:playKnightAnimation(BattleConst.SPINE_ACTION_TYPE.IDLE, true)

		if arg_63_2 then
			arg_63_2(arg_63_3)
		end
	end))
end

function PubgFloorComp:createAttackAction(arg_66_1, arg_66_2, arg_66_3)
	return cc.Sequence:create(cc.CallFunc:create(function()
		arg_66_1:playKnightAnimation(BattleConst.SPINE_ACTION_TYPE.ATTACK, false, 1.5)
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		arg_66_1:playKnightAnimation(BattleConst.SPINE_ACTION_TYPE.IDLE, true)

		if arg_66_2 then
			arg_66_2(arg_66_3)
		end
	end))
end

function PubgFloorComp:updateCanAttackUsersComp(arg_69_1)
	self._showCanAttackDict = {}

	for iter_69_0, iter_69_1 in ipairs(arg_69_1) do
		local var_69_0 = iter_69_1:getOnlyKey()

		if self._showCanAttackDict[var_69_0] then
			self._showCanAttackDict[var_69_0] = nil
		end

		self:_updateCanAttack(iter_69_1, true, var_69_0)
	end

	for iter_69_2, iter_69_3 in pairs(self._showCanAttackDict) do
		self:_updateCanAttack(iter_69_3, false, iter_69_3:getOnlyKey())
	end
end

function PubgFloorComp:_updateCanAttack(arg_70_1, arg_70_2, arg_70_3)
	if arg_70_1:getType() == var_0_1.itemType.knight then
		local var_70_0 = PubgMapHelp.getKey(arg_70_1:getPos())
		local var_70_1 = self._userDict[var_70_0] and self._userDict[var_70_0][arg_70_1:getUid()]

		if var_70_1 then
			var_70_1:setCanAttack(arg_70_2)

			if arg_70_2 then
				self._showCanAttackDict[arg_70_3] = arg_70_1
			end
		else
			self._showCanAttackDict[arg_70_3] = nil
		end
	elseif arg_70_1:getType() == var_0_1.itemType.monster then
		local var_70_2 = self._monsterDict[PubgMapHelp.getKey(arg_70_1:getPos())]

		if var_70_2 then
			var_70_2:setCanAttack(arg_70_2)

			if arg_70_2 then
				self._showCanAttackDict[arg_70_3] = arg_70_1
			end
		else
			self._showCanAttackDict[arg_70_3] = nil
		end
	end
end

return PubgFloorComp
