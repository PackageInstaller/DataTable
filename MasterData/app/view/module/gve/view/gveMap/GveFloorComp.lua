local var_0_0 = g.core.const.ConstMgr.GveConst
local GveCommon = require("app.view.module.gve.common.GveCommon")
local GveMountainConfig = require("app.view.module.gve.const.GveMountainConfig")
local var_0_3 = g.core.model.User.gveDataMgr
local var_0_4 = g.core.model.User.gveDataMgr:getGveData()
local GveFloorComp = class("GveFloorComp", require("app.fairyGUI.gve.UI_GveFloorComp"))

function GveFloorComp:ctor()
	var_0_4 = var_0_3:getGveData()
	self._curPosX = 0
	self._curPosY = 0
	self._curPosDict = {}
	self._colorPoolList = {}
	self._colorUsedDict = {}
	self._mountainPoolList = {}
	self._mountainUsedDict = {}
	self._buildPoolList = {}
	self._buildUsedDict = {}
	self._fogPoolList = {}
	self._fogUsedDict = {}
	self._monsterDict = {}
	self._inCancelDict = {}
	self._buffCompDict = {}
	self._flagPool = {}
	self._usedFlag = {}

	self:_initMapFloor()
end

function GveFloorComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_GRID_STATE_CHANGE, handler(self, self._onCellNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_BOSSNOTIFYDEAD, handler(self, self._onBossDataChange), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_REFRESH_GRID_COLOR, handler(self, self.refreshCurColorDict), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_GETALLBOSSISDEAD, handler(self, self._onAllBossInfoBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDGIVEUPCELL, handler(self, self.onGridGiveUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDCANCALGIVEUPCELL, handler(self, self.onGridCancelGiveUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDUSERDATAFLUSH, handler(self, self.onAllUserData), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_MY_GRID_CHANGE, handler(self, self._onDeleteMyGrid), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_GRID_BUFF_REFRESH, handler(self, self._onGridBuffUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_SYNCRANDOMBOSSINFO, handler(self, self._onRandBossStateChange), self)

	if self._outMap then
		self._outMap = false

		self:refreshCurColorDict()
		self:updateCloud()
	end

	self:checkScheduler()
end

function GveFloorComp:onUnload()
	self._outMap = true

	self:cancelGiveUpScheduler()
end

function GveFloorComp:_initMapFloor()
	for iter_4_0 = 1, var_0_0.MAP_COLOR_POOL_NUM do
		local var_4_0 = fgui.UIPackage:createObject("gve", "GveColorComp")

		var_4_0:setVisible(false)
		self.m_colorHolder:addChild(var_4_0)
		table.insert(self._colorPoolList, var_4_0)
	end

	for iter_4_1 = 1, var_0_0.MAP_MOUNTAIN_POOL_NUM do
		local var_4_1 = fgui.UIPackage:createObject("gve", "GveMountainComp")

		var_4_1:setVisible(false)
		self.m_mountainAndBuildHolder:addChild(var_4_1)
		table.insert(self._mountainPoolList, var_4_1)
	end

	for iter_4_2 = 1, var_0_0.MAP_BUILD_POOL_NUM do
		local var_4_2 = fgui.UIPackage:createObject("gve", "GveBuildComp")

		var_4_2:setVisible(false)
		self.m_mountainAndBuildHolder:addChild(var_4_2)
		table.insert(self._buildPoolList, var_4_2)
	end

	self:initMonsterShow()
end

function GveFloorComp:getFlagComp()
	if not next(self._flagPool) then
		local var_5_0 = fgui.GLoader:create()

		var_5_0:setPivot(0.5, 0.5, true)
		var_5_0:setAutoSize(true)
		var_5_0:setURL("ui://gve/icon_pshc_zhengshi_dikuai_zhanling")
		var_5_0:setTouchable(false)
		self.m_flagHolder:addChild(var_5_0)

		return var_5_0
	end

	local var_5_1 = table.remove(self._flagPool, 1)

	var_5_1:setVisible(true)

	return var_5_1
end

function GveFloorComp:returnToFlagPool(arg_6_1)
	table.insert(self._flagPool, arg_6_1)
	arg_6_1:setVisible(false)
end

function GveFloorComp:refreshFlagComp()
	for iter_7_0, iter_7_1 in ipairs(self._usedFlag) do
		self:returnToFlagPool(iter_7_1)
	end

	self._usedFlag = {}

	for iter_7_2, iter_7_3 in pairs(self._curPosDict) do
		local var_7_0 = string.split(iter_7_2, "_")
		local var_7_1 = {
			x = tonumber(var_7_0[1]),
			y = tonumber(var_7_0[2])
		}

		if var_0_4:getGridColorEnum(var_7_1.x, var_7_1.y) == var_0_0.COLOR_TYPE.MINE then
			local var_7_2 = self:getFlagComp()
			local var_7_3, var_7_4 = GveCommon.coordToCompPos(var_7_1.x, var_7_1.y)

			var_7_2:setPosition(var_7_3, var_7_4)
			table.insert(self._usedFlag, var_7_2)
		end
	end
end

function GveFloorComp:updateCurPos(arg_8_1, arg_8_2)
	local var_8_0, var_8_1 = GveCommon.pixelToCoord(-arg_8_1, arg_8_2)

	var_0_4:setCurCenterPos(cc.p(var_8_0, var_8_1))

	if math.abs(self._curPosX - arg_8_1) < var_0_0.MAP_DRAG_CHECK_NUM * var_0_0.MAP_TILE_WIDTH and math.abs(self._curPosY - arg_8_2) < var_0_0.MAP_DRAG_CHECK_NUM * var_0_0.MAP_TILE_HEIGHT then
		return
	end

	self._curPosX = arg_8_1
	self._curPosY = arg_8_2

	local var_8_2 = math.ceil(display.width / (2 * var_0_0.MAP_TILE_WIDTH)) + var_0_0.MAP_BORDER_NUM
	local var_8_3 = math.ceil(display.height / (2 * var_0_0.MAP_TILE_HEIGHT)) + var_0_0.MAP_BORDER_NUM
	local var_8_4 = {}

	for iter_8_0 = 1, 2 * var_8_2 do
		for iter_8_1 = 1, 2 * var_8_3 do
			local var_8_5 = math.max(0, var_8_0 - var_8_2 - var_8_3 + iter_8_0 + iter_8_1)
			local var_8_6 = math.max(0, var_8_1 + var_8_2 - var_8_3 - iter_8_0 + iter_8_1)

			self:checkTempPos(var_8_5, var_8_6, var_8_4)
			self:checkTempPos(var_8_5, math.max(0, var_8_6 - 1), var_8_4)
		end
	end

	self:checkTempPosDictDiff(var_8_4)

	self._curPosDict = var_8_4

	self:refreshFlagComp()
end

function GveFloorComp:checkTempPos(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 + arg_9_2 <= 0 then
		return
	end

	arg_9_3[arg_9_1 .. "_" .. arg_9_2] = true
end

function GveFloorComp:checkTempPosDictDiff(arg_10_1)
	local var_10_0 = {}
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		if iter_10_1 and not self._curPosDict[iter_10_0] then
			table.insert(var_10_0, iter_10_0)
		end
	end

	for iter_10_2, iter_10_3 in pairs(self._curPosDict) do
		if iter_10_3 and not arg_10_1[iter_10_2] then
			table.insert(var_10_1, iter_10_2)
		end
	end

	self:checkDelPosList(var_10_1)
	self:checkAddPosList(var_10_0)
	self:sortMountainAndBuildComp()
	self:refreshFlagComp()
end

function GveFloorComp:checkDelPosList(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		self:putColorCompToPool(iter_11_1)

		if self._mountainUsedDict[iter_11_1] then
			self._mountainUsedDict[iter_11_1]:setVisible(false)
			table.insert(self._mountainPoolList, self._mountainUsedDict[iter_11_1])

			self._mountainUsedDict[iter_11_1] = nil
		end

		local var_11_0 = self._buildUsedDict[iter_11_1]

		if self._buildUsedDict[iter_11_1] then
			var_11_0:setVisible(false)
			table.insert(self._buildPoolList, var_11_0)

			self._buildUsedDict[iter_11_1] = nil
		end

		local var_11_1 = self._fogUsedDict[iter_11_1]

		if self._fogUsedDict[iter_11_1] then
			var_11_1:setVisible(false)
			table.insert(self._fogPoolList, var_11_1)

			self._fogUsedDict[iter_11_1] = nil
		end
	end
end

function GveFloorComp:checkAddPosList(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_0 = string.split(iter_12_1, "_")
		local var_12_1 = {
			x = tonumber(var_12_0[1]),
			y = tonumber(var_12_0[2])
		}
		local var_12_2, var_12_3 = GveCommon.coordToCompPos(var_12_1.x, var_12_1.y)

		self:newOrReuseColorComp(iter_12_1)

		local var_12_4 = var_0_4:getBuildDataByPos(var_12_1)
		local var_12_5 = GveMountainConfig[iter_12_1]

		if GveMountainConfig[iter_12_1] and (not var_12_4 or var_12_5 == 311 or var_12_5 == 312 or not var_0_4:isPointHasBuild(var_12_4)) then
			local var_12_6

			if #self._mountainPoolList > 0 then
				var_12_6 = table.remove(self._mountainPoolList, 1)
			else
				var_12_6 = fgui.UIPackage:createObject("gve", "GveMountainComp")

				self.m_mountainAndBuildHolder:addChild(var_12_6)
			end

			var_12_6:setVisible(true)
			var_12_6:setPosition(var_12_2, var_12_3)
			var_12_6:updateMountainInfo(var_12_5, var_12_1)

			self._mountainUsedDict[iter_12_1] = var_12_6
		end

		local var_12_7 = var_0_4:getBuildDataByPos(var_12_1, true)

		if var_12_7 and var_12_7.cfg.pic > 0 and not var_0_4:isCurPosInFogCloud(var_12_1) then
			local var_12_8

			if #self._buildPoolList > 0 then
				var_12_8 = table.remove(self._buildPoolList, 1)
			else
				var_12_8 = fgui.UIPackage:createObject("gve", "GveBuildComp")

				self.m_mountainAndBuildHolder:addChild(var_12_8)
			end

			var_12_8:setVisible(true)
			var_12_8:setPosition(var_12_2, var_12_3)
			var_12_8:updateBuildInfo(var_12_7, var_12_1)

			self._buildUsedDict[iter_12_1] = var_12_8
		end

		if var_0_4:isCurPosInFogCloud(var_12_1) then
			local var_12_9

			if #self._fogPoolList > 0 then
				var_12_9 = table.remove(self._fogPoolList, 1)
			else
				var_12_9 = fgui.UIPackage:createObject("gve", "GveCloudComp")

				self.m_cloudHolder:addChild(var_12_9)
			end

			var_12_9:setVisible(true)
			var_12_9:setPosition(var_12_2, var_12_3)

			self._fogUsedDict[iter_12_1] = var_12_9
		end
	end
end

function GveFloorComp:sortMountainAndBuildComp()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self._mountainUsedDict) do
		local var_13_1 = string.split(iter_13_0, "_")

		table.insert(var_13_0, {
			x = tonumber(var_13_1[1]),
			y = tonumber(var_13_1[2]),
			comp = iter_13_1
		})
	end

	for iter_13_2, iter_13_3 in pairs(self._buildUsedDict) do
		local var_13_2 = string.split(iter_13_2, "_")

		table.insert(var_13_0, {
			x = tonumber(var_13_2[1]),
			y = tonumber(var_13_2[2]),
			comp = iter_13_3
		})
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0.x + arg_14_0.y
		local var_14_1 = arg_14_1.x + arg_14_1.y

		if arg_14_0.x + arg_14_0.y == arg_14_1.x + arg_14_1.y then
			return arg_14_0.x < arg_14_1.x
		end

		return var_14_0 < var_14_1
	end)

	for iter_13_4 = 1, #var_13_0 do
		self.m_mountainAndBuildHolder:setChildIndex(var_13_0[iter_13_4].comp, iter_13_4 - 1)
	end
end

function GveFloorComp:checkGiveUpMySite()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(self._inCancelDict) do
		iter_15_1:setVisible(false)
		table.insert(var_15_0, iter_15_1)
	end

	self._inCancelDict = {}

	for iter_15_2, iter_15_3 in ipairs((var_0_4:getAllGiveUpTiled())) do
		if not self._inCancelDict[iter_15_3.x .. "_" .. iter_15_3.y] then
			local var_15_1

			if var_15_0[1] then
				var_15_1 = table.remove(var_15_0, 1)
				self._inCancelDict[iter_15_3.x .. "_" .. iter_15_3.y] = var_15_1

				var_15_1:setVisible(true)
			else
				var_15_1 = fgui.UIPackage:createObject("gve", "GveQuitComp")
				self._inCancelDict[iter_15_3.x .. "_" .. iter_15_3.y] = var_15_1

				self.m_cancelHolder:addChild(var_15_1)
			end

			local var_15_2 = var_0_4:getBuildDataByPos(iter_15_3)
			local var_15_3 = var_0_4:getBaseCfgByPos(iter_15_3)
			local var_15_4, var_15_5 = self:getOpeCompShowPos(var_15_2.cfg.x, var_15_2.cfg.y, var_15_3.base_type)

			var_15_1:setType(var_15_3.base_type)
			var_15_1:setPosition(var_15_4, var_15_5)
			var_15_1:updateQuitComp(iter_15_3.x, iter_15_3.y)
		end
	end

	for iter_15_4, iter_15_5 in ipairs(var_15_0) do
		iter_15_5:removeSelf()
	end

	self:checkScheduler()
end

function GveFloorComp:checkScheduler()
	if next(self._inCancelDict) then
		self:startUpdateGiveUpScheduler()
	else
		self:cancelGiveUpScheduler()
	end
end

function GveFloorComp:startUpdateGiveUpScheduler()
	self._updateGiveUpScheduler = self._updateGiveUpScheduler or self:newSchedule(handler(self, self.onUpdateGiveUpTimer), 1)
end

function GveFloorComp:cancelGiveUpScheduler()
	if self._updateGiveUpScheduler then
		self:cancelSchedule(self._updateGiveUpScheduler)

		self._updateGiveUpScheduler = nil
	end
end

function GveFloorComp:onUpdateGiveUpTimer()
	for iter_19_0, iter_19_1 in pairs(self._inCancelDict) do
		local var_19_0 = string.split(iter_19_0, "_")

		iter_19_1:updateQuitComp(tonumber(var_19_0[1]), (tonumber(var_19_0[2])))
	end
end

function GveFloorComp:onGridGiveUp(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if not self._inCancelDict[arg_20_4.x .. "_" .. arg_20_4.y] then
		local var_20_0 = fgui.UIPackage:createObject("gve", "GveQuitComp")

		self._inCancelDict[arg_20_4.x .. "_" .. arg_20_4.y] = var_20_0

		self.m_cancelHolder:addChild(var_20_0)

		local var_20_1 = var_0_4:getBuildDataByPos(arg_20_4)
		local var_20_2 = var_0_4:getBaseCfgByPos(arg_20_4)
		local var_20_3, var_20_4 = self:getOpeCompShowPos(var_20_1.cfg.x, var_20_1.cfg.y, var_20_2.base_type)

		var_20_0:setType(var_20_2.base_type)
		var_20_0:setPosition(var_20_3, var_20_4)
		var_20_0:updateQuitComp(arg_20_4.x, arg_20_4.y)
		self:checkScheduler()
	end
end

function GveFloorComp:onGridCancelGiveUp(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if self._inCancelDict[arg_21_4.x .. "_" .. arg_21_4.y] then
		self._inCancelDict[arg_21_4.x .. "_" .. arg_21_4.y]:removeSelf()

		self._inCancelDict[arg_21_4.x .. "_" .. arg_21_4.y] = nil

		self:checkScheduler()
	end
end

function GveFloorComp:_onDeleteMyGrid(arg_22_1, arg_22_2, arg_22_3)
	if arg_22_3 and arg_22_3.delete then
		if self._inCancelDict[arg_22_3.delete.x .. "_" .. arg_22_3.delete.y] then
			self._inCancelDict[arg_22_3.delete.x .. "_" .. arg_22_3.delete.y]:removeSelf()

			self._inCancelDict[arg_22_3.delete.x .. "_" .. arg_22_3.delete.y] = nil

			self:checkScheduler()
		end
	end
end

function GveFloorComp:onAllUserData()
	self:checkGiveUpMySite()
end

function GveFloorComp:getOpeCompShowPos(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0, var_24_1 = GveCommon.coordToCompPos(arg_24_1, arg_24_2)

	if arg_24_3 == 1 then
		return var_24_0, var_24_1
	elseif arg_24_3 == 2 then
		local var_24_2, var_24_3 = GveCommon.coordToCompPos(arg_24_1, arg_24_2 + 1)

		return (var_24_0 + var_24_2) / 2, (var_24_1 + var_24_3) / 2
	elseif arg_24_3 == 3 then
		local var_24_4, var_24_5 = GveCommon.coordToCompPos(arg_24_1 + 1, arg_24_2)

		return (var_24_0 + var_24_4) / 2, (var_24_1 + var_24_5) / 2
	elseif arg_24_3 == 4 then
		local var_24_6, var_24_7 = GveCommon.coordToCompPos(arg_24_1 + 1, arg_24_2 + 1)

		return (var_24_0 + var_24_6) / 2, (var_24_1 + var_24_7) / 2
	end
end

function GveFloorComp:putColorCompToPool(arg_25_1)
	if self._colorUsedDict[arg_25_1] then
		self._colorUsedDict[arg_25_1]:setVisible(false)
		table.insert(self._colorPoolList, self._colorUsedDict[arg_25_1])

		self._colorUsedDict[arg_25_1] = nil
	end
end

function GveFloorComp:newOrReuseColorComp(arg_26_1)
	local var_26_0 = string.split(arg_26_1, "_")
	local var_26_1 = {
		x = tonumber(var_26_0[1]),
		y = tonumber(var_26_0[2])
	}
	local var_26_2, var_26_3 = GveCommon.coordToCompPos(var_26_1.x, var_26_1.y)
	local var_26_4 = var_0_4:getGridColorEnum(var_26_1.x, var_26_1.y)

	if var_26_4 then
		local var_26_5

		if #self._colorPoolList > 0 then
			var_26_5 = table.remove(self._colorPoolList, 1)
		else
			var_26_5 = fgui.UIPackage:createObject("gve", "GveColorComp")

			self.m_colorHolder:addChild(var_26_5)
		end

		var_26_5:setVisible(true)
		var_26_5:setPosition(var_26_2, var_26_3)
		var_26_5:updateColorInfo(var_26_4, var_26_1)

		self._colorUsedDict[arg_26_1] = var_26_5
	end
end

function GveFloorComp:refreshCurColorDict()
	local var_27_0 = {}
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in pairs(self._curPosDict) do
		local var_27_2 = string.split(iter_27_0, "_")
		local var_27_3 = {
			x = tonumber(var_27_2[1]),
			y = tonumber(var_27_2[2])
		}
		local var_27_4 = var_0_4:getGridColorEnum(var_27_3.x, var_27_3.y)

		if var_27_4 and not self._colorUsedDict[iter_27_0] then
			table.insert(var_27_0, iter_27_0)
		elseif not var_27_4 and self._colorUsedDict[iter_27_0] then
			table.insert(var_27_1, iter_27_0)
		end
	end

	self:_onCellNotify(nil, nil, {
		add = var_27_0,
		delete = var_27_1
	})
end

function GveFloorComp:_onGridBuffUpdate()
	if not var_0_4:isGridBuffShow() then
		for iter_28_0, iter_28_1 in pairs(self._buffCompDict) do
			iter_28_1:removeSelf()
		end

		self._buffCompDict = {}

		return
	end

	local var_28_0 = {}

	for iter_28_2, iter_28_3 in pairs(self._buffCompDict) do
		table.insert(var_28_0, iter_28_3)
		iter_28_3:setVisible(false)
	end

	self._buffCompDict = {}

	for iter_28_4, iter_28_5 in pairs(self._curPosDict) do
		local var_28_1 = string.split(iter_28_4, "_")
		local var_28_2 = {
			x = tonumber(var_28_1[1]),
			y = tonumber(var_28_1[2])
		}
		local var_28_3 = var_0_4:getGridBuff(var_28_2.x, var_28_2.y)

		if var_28_3 and not var_0_4:getGridColorEnum(var_28_2.x, var_28_2.y) and var_0_4:getBuildDataByPos(var_28_2, true) then
			local var_28_4

			if var_28_0[1] then
				var_28_4 = table.remove(var_28_0, 1)

				var_28_4:setVisible(true)
			else
				var_28_4 = fgui.UIPackage:createObject("gve", "GveGridBuffComp")

				self.m_buffHolder:addChild(var_28_4)
			end

			var_28_4:updateBuff(var_28_3)

			local var_28_5, var_28_6 = GveCommon.coordToCompPos(var_28_2.x, var_28_2.y)

			var_28_4:setPosition(var_28_5, var_28_6)

			self._buffCompDict[iter_28_4] = var_28_4
		end
	end

	for iter_28_6, iter_28_7 in ipairs(var_28_0) do
		iter_28_7:removeSelf()
	end
end

function GveFloorComp:initMonsterShow()
	for iter_29_0, iter_29_1 in pairs((var_0_4:getAllBossMap())) do
		local var_29_0 = string.split(iter_29_0, "_")
		local var_29_1 = tonumber(var_29_0[1])
		local var_29_2 = tonumber(var_29_0[2])
		local var_29_3 = fgui.UIPackage:createObject("gve", "GveBossComp")

		self.m_bossHolder:addChild(var_29_3)

		local var_29_4, var_29_5 = GveCommon.coordToCompPos(var_29_1, var_29_2)

		var_29_3:setPosition(var_29_4, var_29_5)

		self._monsterDict[iter_29_0] = var_29_3

		var_29_3:setXy(var_29_1, var_29_2)
	end
end

function GveFloorComp:_onBossDataChange(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	self:updateBossCompById(arg_30_4.boss_id)

	if var_0_4:getBossData(arg_30_4.boss_id):isDeadByIndex() then
		self:updateCloud()
	end
end

function GveFloorComp:_onRandBossStateChange(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	if not arg_31_4 then
		return
	end

	for iter_31_0, iter_31_1 in ipairs(arg_31_4.boss_info) do
		self:updateBossCompById(iter_31_1.boss_id)
	end
end

function GveFloorComp:updateBossCompById(arg_32_1)
	local var_32_0 = var_0_4:getBossData(arg_32_1):getInfo()

	if self._monsterDict[var_32_0.x .. "_" .. var_32_0.y] then
		self._monsterDict[var_32_0.x .. "_" .. var_32_0.y]:updateBoss()
	end
end

function GveFloorComp:checkFogBossShow()
	for iter_33_0, iter_33_1 in pairs(self._monsterDict or {}) do
		iter_33_1:updateBoss()
	end
end

function GveFloorComp:_onAllBossInfoBack()
	for iter_34_0, iter_34_1 in pairs(self._monsterDict or {}) do
		iter_34_1:updateBoss()
	end

	if not self._allBossStateBack then
		self:updateCloud()

		self._allBossStateBack = true
	end
end

function GveFloorComp:_onCellNotify(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_3.add or {}
	local var_35_1 = arg_35_3.delete or {}

	for iter_35_0 = 1, #var_35_0 do
		if self._curPosDict[var_35_0[iter_35_0]] and not self._colorUsedDict[var_35_0[iter_35_0]] then
			self:newOrReuseColorComp(var_35_0[iter_35_0])
		end
	end

	for iter_35_1 = 1, #var_35_1 do
		if self._curPosDict[var_35_1[iter_35_1]] then
			self:putColorCompToPool(var_35_1[iter_35_1])
		end
	end

	for iter_35_2, iter_35_3 in pairs(self._colorUsedDict) do
		local var_35_2 = string.split(iter_35_2, "_")
		local var_35_3 = {
			x = tonumber(var_35_2[1]),
			y = tonumber(var_35_2[2])
		}
		local var_35_4 = var_0_4:getGridColorEnum(var_35_3.x, var_35_3.y)

		if var_35_4 then
			iter_35_3:updateColorInfo(var_35_4, var_35_3)
		end
	end

	self:refreshFlagComp()
end

function GveFloorComp:updateCloud()
	self:checkFogBossShow()
	self:updateFogRangeShow()
	self:sortMountainAndBuildComp()
end

function GveFloorComp:updateFogRangeShow()
	for iter_37_0, iter_37_1 in pairs(self._buildUsedDict) do
		iter_37_1:setVisible(false)
		table.insert(self._buildPoolList, iter_37_1)
	end

	self._buildUsedDict = {}

	for iter_37_2, iter_37_3 in pairs(self._fogUsedDict) do
		iter_37_3:setVisible(false)
		table.insert(self._fogPoolList, iter_37_3)
	end

	self._fogUsedDict = {}

	for iter_37_4, iter_37_5 in pairs(self._curPosDict) do
		local var_37_0 = string.split(iter_37_4, "_")
		local var_37_1 = {
			x = tonumber(var_37_0[1]),
			y = tonumber(var_37_0[2])
		}
		local var_37_2, var_37_3 = GveCommon.coordToCompPos(var_37_1.x, var_37_1.y)
		local var_37_4 = var_0_4:getBuildDataByPos(var_37_1, true)

		if var_37_4 and var_37_4.cfg.pic > 0 and not var_0_4:isCurPosInFogCloud(var_37_1) then
			local var_37_5

			if #self._buildPoolList > 0 then
				var_37_5 = table.remove(self._buildPoolList, 1)
			else
				var_37_5 = fgui.UIPackage:createObject("gve", "GveBuildComp")

				self.m_mountainAndBuildHolder:addChild(var_37_5)
			end

			var_37_5:setVisible(true)
			var_37_5:setPosition(var_37_2, var_37_3)
			var_37_5:updateBuildInfo(var_37_4, var_37_1)

			self._buildUsedDict[iter_37_4] = var_37_5
		end

		if self._mountainUsedDict[iter_37_4] then
			self._mountainUsedDict[iter_37_4]:updateInFogState(var_37_1)
		end

		if var_0_4:isCurPosInFogCloud(var_37_1) then
			local var_37_6

			if #self._fogPoolList > 0 then
				var_37_6 = table.remove(self._fogPoolList, 1)
			else
				var_37_6 = fgui.UIPackage:createObject("gve", "GveCloudComp")

				self.m_cloudHolder:addChild(var_37_6)
			end

			var_37_6:setVisible(true)
			var_37_6:setPosition(var_37_2, var_37_3)

			self._fogUsedDict[iter_37_4] = var_37_6
		end
	end
end

return GveFloorComp
