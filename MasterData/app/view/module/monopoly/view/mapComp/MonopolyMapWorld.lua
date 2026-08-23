local MonopolyConst = require("app.view.module.monopoly.const.MonopolyConst")
local CommonKnight = require("app.view.common.CommonKnight")
local var_0_4 = g.core.const.ConstMgr.SpineConst
local var_0_5 = g.core.model.User.knightsData
local var_0_6 = g.core.model.User.monopolyDataMgr
local var_0_7 = 0.5
local var_0_8 = 0
local MonopolyMapWorld = class("MonopolyMapWorld", require("app.fairyGUI.monopoly.UI_MonopolyMapWorld"))

function MonopolyMapWorld:ctor()
	self._MAP_TILE_HW = 83
	self._MAP_TILE_HH = 41.5
	self._HALF_RANGE = math.ceil(math.sqrt(display.width^2 + display.height^2) / self._MAP_TILE_HW / 2) + 1
	self._HALF_WIDTH_SIZE = self._HALF_RANGE
	self._HALF_HEIGHT_SIZE = self._HALF_RANGE
	self._gridPool = {}
	self._inShowGrid = {}
	self._gridMap = {}
	self._gridIdMap = {}

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_FINISH, self._onGameTouchFinish, self)
	self:createRole()
end

function MonopolyMapWorld:coordToPixelF(arg_2_1, arg_2_2)
	return (arg_2_1 - arg_2_2) * self._MAP_TILE_HW, -(-(arg_2_1 + arg_2_2) * self._MAP_TILE_HH)
end

function MonopolyMapWorld:pixelToCoordF(arg_3_1, arg_3_2)
	arg_3_2 = -arg_3_2

	return math.round((arg_3_1 / self._MAP_TILE_HW + -arg_3_2 / self._MAP_TILE_HH) / 2), math.round((-arg_3_2 / self._MAP_TILE_HH - arg_3_1 / self._MAP_TILE_HW) / 2)
end

function MonopolyMapWorld:createRole()
	self._monopolyData = var_0_6:getMonopolyData()
	self._roleIndex = self._monopolyData:getCurrentIndex()

	if not self._ownEntity then
		self._ownEntity = fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")

		local var_4_0 = var_0_5:getMainRoleKnight()[1]

		self._entityDownEffHolder = fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")

		self._ownEntity:addChild(self._entityDownEffHolder)

		local var_4_1 = g.core.model.User:getAssistantDressId()
		local var_4_2 = CommonKnight.new((g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot((g.core.model.User:packUser()))))

		var_4_2:setScale(0.8)
		self._ownEntity:addChild(var_4_2)

		self._entityUpEffHolder = fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")

		self._ownEntity:addChild(self._entityUpEffHolder)
		self.m_playerHolder:addChild(self._ownEntity)
		var_4_2:setScaleX(self._monopolyData:getNextMoveDir())
	end

	local var_4_3 = self._monopolyData:getRoleIndexPos(self._roleIndex)
	local var_4_4, var_4_5 = self:getRoleGridPos(var_4_3.x, var_4_3.y)

	self._ownEntity:setPosition(var_4_4, var_4_5)
end

function MonopolyMapWorld:getRoleGridPos(arg_5_1, arg_5_2)
	local var_5_0, var_5_1 = self:coordToPixelF(arg_5_1, arg_5_2)

	return var_5_0 + self._MAP_TILE_HW - 50, var_5_1 + self._MAP_TILE_HH - 15
end

function MonopolyMapWorld:getRolePos()
	return self:globalToLocal(self._ownEntity:localToGlobal(cc.p(0, 0)))
end

function MonopolyMapWorld:setAnimSkip()
	self._monopolyData:setInDiceAnim(false)
	self._ownEntity:removeFromParent()

	self._ownEntity = nil

	self:createRole()
	self:updateGridSkipShow()
end

function MonopolyMapWorld:addGirdFromPool(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0, var_8_1 = self:coordToPixelF(arg_8_1, arg_8_2)
	local var_8_2 = arg_8_1 .. "_" .. arg_8_2

	if not self._gridPool[1] then
		local var_8_3 = fgui.UIPackage:createObject("monopoly", "MonopolyPathGridComp")

		var_8_3:setEffNode(self)
		self.m_pathHolder:addChild(var_8_3)
		var_8_3:changeGridType(arg_8_3, arg_8_1, arg_8_2)
		var_8_3:setPosition(var_8_0, var_8_1)

		self._inShowGrid[var_8_2] = var_8_3

		var_8_3:addClickListener(handler(self, self._onGridClick))
	else
		local var_8_4 = table.remove(self._gridPool, 1)

		var_8_4:setVisible(true)
		var_8_4:setPosition(var_8_0, var_8_1)
		var_8_4:changeGridType(arg_8_3, arg_8_1, arg_8_2)

		self._inShowGrid[var_8_2] = var_8_4
	end

	self._gridIdMap[arg_8_3.id] = self._inShowGrid[var_8_2]

	self._inShowGrid[var_8_2]:updateGridLv(arg_8_3)
end

function MonopolyMapWorld:playGridLevelUpAnim(arg_9_1, arg_9_2, arg_9_3)
	if self._gridIdMap[arg_9_1] then
		self._gridIdMap[arg_9_1]:playLevelUpAnim(arg_9_3, arg_9_2)
	else
		arg_9_2()
	end
end

function MonopolyMapWorld:playBoxRewardAndChangeAnim(arg_10_1, arg_10_2)
	if self._gridIdMap[arg_10_2.grid] then
		self._gridIdMap[arg_10_2.grid]:playRewardBoxAnim(arg_10_1)
	end

	if self._gridIdMap[arg_10_2.nextId] then
		self._gridIdMap[arg_10_2.nextId]:showNewBox()
	end
end

function MonopolyMapWorld:showBoxWithTarget(arg_11_1)
	self.m_boxImg:setVisible(true)
	self.m_boxImg:setPosition((self:globalToLocal(arg_11_1:localToGlobal(cc.p(0, 0)))))
end

function MonopolyMapWorld:returnGridIntoPool(arg_12_1, arg_12_2)
	if self._inShowGrid[arg_12_1 .. "_" .. arg_12_2] then
		self._inShowGrid[arg_12_1 .. "_" .. arg_12_2]:setVisible(false)
		table.insert(self._gridPool, self._inShowGrid[arg_12_1 .. "_" .. arg_12_2])

		self._inShowGrid[arg_12_1 .. "_" .. arg_12_2] = nil
	end
end

function MonopolyMapWorld:updateGridShow(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self._inShowGrid) do
		iter_13_1:updateGridShow(arg_13_1)
	end
end

function MonopolyMapWorld:updateGridSkipShow()
	for iter_14_0, iter_14_1 in pairs(self._inShowGrid) do
		iter_14_1:updateGridSkipShow()
	end
end

function MonopolyMapWorld:roleMove(arg_15_1, arg_15_2)
	self._ownEntity:stopAllFGActions()

	local var_15_0 = self._monopolyData:gotoPath(arg_15_1.start, arg_15_1.step)
	local var_15_1, var_15_2 = self:getRoleGridPos(var_15_0[1].startPos.x, var_15_0[1].startPos.y)

	self._ownEntity:setPosition(var_15_1, var_15_2)
	self:playRunAnim()

	local var_15_3, var_15_4 = self:getMoveActionByList(var_15_0, arg_15_2)

	self._moveAnimCacheList = var_15_4

	self._ownEntity:runFGAction(fgui.FSequence:create(var_15_3))
end

function MonopolyMapWorld:getMoveActionByList(arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_2

		if 0 == 0 then
			var_16_2 = self:addAnimIntoAnimList(var_16_0, iter_16_1, iter_16_0, #arg_16_1)
		else
			table.insert(var_16_1, iter_16_1)
		end
	end

	table.insert(var_16_0, fgui.FCallFunc:create(handler(self, function(arg_17_0)
		arg_17_0:playIdleAnim()
		arg_16_2()
	end)))

	return var_16_0, var_16_1
end

function MonopolyMapWorld:showGridEff(arg_18_1, arg_18_2)
	if arg_18_1.node and arg_18_1.eff then
		if not arg_18_2 then
			local var_18_0 = self.m_effHolder:globalToLocal(arg_18_1.node:localToGlobal(cc.p(0, 0)))

			arg_18_1.eff.x = var_18_0.x
			arg_18_1.eff.y = -var_18_0.y

			self.m_effHolder:addEffectSpine(arg_18_1.eff)
		else
			local var_18_1 = self.m_effDownHolder:globalToLocal(arg_18_1.node:localToGlobal(cc.p(0, 0)))

			arg_18_1.eff.x = var_18_1.x
			arg_18_1.eff.y = -var_18_1.y

			self.m_effDownHolder:addEffectSpine(arg_18_1.eff)
		end
	end
end

function MonopolyMapWorld:addAnimIntoAnimList(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0, var_19_1 = self:getRoleGridPos(arg_19_2.endPos.x, arg_19_2.endPos.y)
	local var_19_2 = math.abs(arg_19_2.endPos.x - arg_19_2.startPos.x) + math.abs(arg_19_2.endPos.y - arg_19_2.startPos.y)
	local var_19_3 = 1

	var_19_3 = arg_19_2.endPos.y ~= arg_19_2.startPos.y and (arg_19_2.endPos.y > arg_19_2.startPos.y and -1 or 1) or arg_19_2.endPos.x > arg_19_2.startPos.x and 1 or -1

	table.insert(arg_19_1, fgui.FCallFunc:create(handler(self, function(arg_20_0)
		arg_20_0._ownEntity:getChild("CommonKnight"):setScaleX(var_19_3)
	end)))
	table.insert(arg_19_1, fgui.FMoveTo:create(MonopolyConst.PER_GRID_RUN_TIME * var_19_2, cc.p(var_19_0, var_19_1)))

	return 0
end

function MonopolyMapWorld:updateMapState()
	return
end

function MonopolyMapWorld:checkVisibleGrid()
	local var_22_0 = self.m_pathHolder:globalToLocal(cc.p(display.cx, display.cy))
	local var_22_1, var_22_2 = self:pixelToCoordF(var_22_0.x, var_22_0.y)

	for iter_22_0, iter_22_1 in pairs(self._inShowGrid) do
		local var_22_3 = string.split(iter_22_0, "_")
		local var_22_4 = tonumber(var_22_3[1])
		local var_22_5 = tonumber(var_22_3[2])

		if var_22_4 < var_22_1 - self._HALF_WIDTH_SIZE or var_22_4 > var_22_1 + self._HALF_WIDTH_SIZE or var_22_5 < var_22_2 - self._HALF_HEIGHT_SIZE or var_22_5 > var_22_2 + self._HALF_HEIGHT_SIZE then
			self:returnGridIntoPool(var_22_4, var_22_5)
		end
	end

	local var_22_6 = self._monopolyData:getMonopolyTypeMap()

	for iter_22_2 = var_22_1 - self._HALF_WIDTH_SIZE, var_22_1 + self._HALF_WIDTH_SIZE do
		if iter_22_2 >= 0 then
			for iter_22_3 = var_22_2 - self._HALF_HEIGHT_SIZE, var_22_2 + self._HALF_HEIGHT_SIZE do
				if iter_22_3 >= 0 and not self._inShowGrid[iter_22_2 .. "_" .. iter_22_3] and var_22_6[iter_22_2 .. "_" .. iter_22_3] then
					self:addGirdFromPool(iter_22_2, iter_22_3, var_22_6[iter_22_2 .. "_" .. iter_22_3])
				end
			end
		end
	end

	if not self._isCheckInit then
		self._isCheckInit = true

		self:updateGridShow()
	end
end

function MonopolyMapWorld:playExMoveEff(arg_23_1, arg_23_2)
	if arg_23_1.isEvent then
		local var_23_0 = arg_23_1.startPos
		local var_23_1 = arg_23_1.finalPos and self._monopolyData:formatStepFinishIndex(arg_23_1.finalPos) or self._monopolyData:formatStepFinishIndex(arg_23_1.startPos + arg_23_1.step)

		if self._gridIdMap[arg_23_1.startPos] then
			self._gridIdMap[var_23_0]:showEffExMove(arg_23_2)
		end

		if self._gridIdMap[var_23_1] then
			self._gridIdMap[var_23_1]:showEffExMove()
		end
	end
end

function MonopolyMapWorld:playAwardEff(arg_24_1, arg_24_2)
	local var_24_0 = g.core.config.monopoly_grid_info.get(arg_24_1.grid)

	if self._inShowGrid[var_24_0.x .. "_" .. var_24_0.y] then
		self._inShowGrid[var_24_0.x .. "_" .. var_24_0.y]:showRewardEff(arg_24_2)
	end
end

function MonopolyMapWorld:playRunAnim()
	self._ownEntity:getChild("CommonKnight"):playAction(var_0_4.LOOP_ACTION.RUN)
end

function MonopolyMapWorld:playIdleAnim()
	self._ownEntity:getChild("CommonKnight"):playAction(var_0_4.LOOP_ACTION.IDLE)
end

function MonopolyMapWorld:_onGameTouchFinish()
	self.m_tipsComp:setVisible(false)
end

function MonopolyMapWorld:_onGridClick(arg_28_1)
	if g.core.common.ServerTime:getTime() - var_0_8 < var_0_7 then
		return
	end

	var_0_8 = g.core.common.ServerTime:getTime()

	local var_28_0 = arg_28_1:getSender()

	self.m_tipsComp:setVisible(true)
	self.m_tipsComp:setPosition((self:globalToLocal(var_28_0:localToGlobal(cc.p(0, 0)))))
	self.m_tipsComp:updateGridInfo(var_28_0:getGridData())
end

return MonopolyMapWorld
