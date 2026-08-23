local var_0_0 = 1240
local var_0_1 = 620
local var_0_2 = 290
local var_0_3 = g.core.const.ConstMgr.GveConst
local var_0_4 = g.core.model.User.gveDataMgr
local var_0_5 = g.core.model.User.gveDataMgr:getGveData()
local GveStrategyMap = class("GveStrategyMap", require("app.fairyGUI.gve.UI_GveStrategyMap"))

function GveStrategyMap:ctor()
	var_0_5 = var_0_4:getGveData()

	self.m_mapLoader:setURL("bg/gve/bg_pshc_ditu.jpg")

	self._centerPos = self.m_centerComp:getPosition()
	self._P_HEIGHT = var_0_1 / var_0_2
	self._P_WIDTH = var_0_0 / var_0_2
	self._startPos = {
		x = self._centerPos.x,
		y = self._centerPos.y - self._P_HEIGHT * var_0_2 / 2
	}
	self._playerPool = {}
	self._usedPlayer = {}
	self._bossPool = {}
	self._usedBoss = {}

	self:updateMapState()
	self:setScale(var_0_3.STRATEGY_SCALE)
end

function GveStrategyMap:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_GRID_STATE_CHANGE, handler(self, self._onCellNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDUSERDATAFLUSH, handler(self, self._onFirstUserInfoBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_BOSSNOTIFYDEAD, handler(self, self.onBossStateChange), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_SYNCRANDOMBOSSINFO, handler(self, self.updateBossState), self)
end

function GveStrategyMap:_onCellNotify(arg_3_1, arg_3_2, arg_3_3)
	local var_3_1 = arg_3_3.delete or {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_3.add or {}) do
		if self:checkInShowRange(iter_3_1) then
			self:updateCurPositionPlayers()

			return
		end
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_1) do
		if self:checkInShowRange(iter_3_3) then
			self:updateCurPositionPlayers()

			return
		end
	end
end

function GveStrategyMap:checkInShowRange(arg_4_1)
	local var_4_0 = var_0_5:getCurPosition() or var_0_5:getInitPoint()
	local var_4_1 = string.split(arg_4_1, "_")
	local var_4_2 = {
		x = tonumber(var_4_1[1]),
		y = tonumber(var_4_1[2])
	}

	if var_4_0.x - var_0_3.STRATEGY_RANGE_POINTS <= var_4_2.x and var_4_0.x + var_0_3.STRATEGY_RANGE_POINTS >= var_4_2.x and var_4_0.y - var_0_3.STRATEGY_RANGE_POINTS <= var_4_2.y and var_4_0.y + var_0_3.STRATEGY_RANGE_POINTS >= var_4_2.y then
		return true
	end

	return false
end

function GveStrategyMap:_onFirstUserInfoBack()
	if not self._isFirstInit then
		self._isFirstInit = true

		self:updateCurPositionPlayers()
		self:updateBossState()
	end
end

function GveStrategyMap:onBossStateChange(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if var_0_5:getBossData(arg_6_4.boss_id):isDeadByIndex() then
		self:updateBossState()
	end
end

function GveStrategyMap:getPlayerComp()
	if not self._playerPool[1] then
		local var_7_0 = fgui.UIPackage:createObject("gve", "GveMiniMapColor", self)

		self.m_colorComp:addChild(var_7_0)

		return var_7_0
	end

	local var_7_1 = table.remove(self._playerPool, 1)

	var_7_1:setVisible(true)

	return var_7_1
end

function GveStrategyMap:getBossComp(arg_8_1, arg_8_2)
	local var_8_0 = var_0_5:getPosNowBossCfg(arg_8_1, arg_8_2)

	if not var_0_5:isCurPosInFogCloud({
		x = arg_8_1,
		y = arg_8_2
	}) and var_8_0 then
		local var_8_1

		self._usedBoss[var_8_0.boss_type] = self._usedBoss[var_8_0.boss_type] or {}
		self._bossPool[var_8_0.boss_type] = self._bossPool[var_8_0.boss_type] or {}

		if var_8_0.boss_type == 1 then
			if next(self._bossPool[var_8_0.boss_type]) then
				var_8_1 = table.remove(self._bossPool[var_8_0.boss_type], 1)

				var_8_1:setVisible(true)
			else
				var_8_1 = fgui.UIPackage:createObject("gve", "GveMiniMapBossComp")

				self.m_colorComp:addChild(var_8_1)
				var_8_1:setScale(0.5)
			end

			var_8_1:updateIcon(g.core.common.Path:getKnightIconById(var_8_0.image))
		elseif next(self._bossPool[var_8_0.boss_type]) then
			var_8_1 = table.remove(self._bossPool[var_8_0.boss_type], 1)

			var_8_1:setVisible(true)
		else
			var_8_1 = fgui.UIPackage:createObject("gve", "GveMiniMapRandBoss")

			var_8_1:setScale(0.5)
		end

		table.insert(self._usedBoss[var_8_0.boss_type], var_8_1)

		return var_8_1
	end

	return nil
end

function GveStrategyMap:allClearToBossPool()
	for iter_9_0, iter_9_1 in pairs(self._usedBoss) do
		for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
			iter_9_3:setVisible(false)
			table.insert(self._bossPool[iter_9_0], iter_9_3)
		end

		self._usedBoss[iter_9_0] = {}
	end
end

function GveStrategyMap:updateBossState()
	return
end

function GveStrategyMap:returnPlayerToPool(arg_11_1)
	arg_11_1:setVisible(false)
	table.insert(self._playerPool, arg_11_1)
end

function GveStrategyMap:updateMapState()
	self:updateCurPositionPlayers()
end

function GveStrategyMap:getMapPosByPosition(arg_13_1)
	return math.round(((arg_13_1.x - self._startPos.x) / (self._P_WIDTH / 2) + (arg_13_1.y - self._startPos.y) / (self._P_HEIGHT / 2)) / 2), math.round(((arg_13_1.y - self._startPos.y) / (self._P_HEIGHT / 2) - (arg_13_1.x - self._startPos.x) / (self._P_WIDTH / 2)) / 2)
end

function GveStrategyMap:coordToPixel(arg_14_1, arg_14_2)
	return {
		x = (arg_14_1 - arg_14_2) * (self._P_WIDTH / 2),
		y = -(arg_14_1 + arg_14_2) * (self._P_HEIGHT / 2)
	}
end

function GveStrategyMap:updateCurPositionPlayers()
	local var_15_0 = var_0_5:getCurPosition() or var_0_5:getInitPoint()

	for iter_15_0, iter_15_1 in ipairs(self._usedPlayer) do
		self:returnPlayerToPool(iter_15_1)
	end

	self._usedPlayer = {}

	local var_15_1 = var_0_5:getAllOccupiedPoint()

	for iter_15_2 = var_15_0.x - var_0_3.STRATEGY_RANGE_POINTS, var_15_0.x + var_0_3.STRATEGY_RANGE_POINTS do
		for iter_15_3 = var_15_0.y - var_0_3.STRATEGY_RANGE_POINTS, var_15_0.y + var_0_3.STRATEGY_RANGE_POINTS do
			if var_15_1[iter_15_2 .. "_" .. iter_15_3] then
				local var_15_2 = self:getPlayerComp()

				if var_0_5:getMinePointData(iter_15_2, iter_15_3) then
					var_15_2:setCtrlState("ctrl", {
						index = 0
					})
				else
					var_15_2:setCtrlState("ctrl", {
						index = 1
					})
				end

				local var_15_3 = self:coordToPixel(iter_15_2, iter_15_3)

				var_15_2:setPosition(var_15_3.x, -var_15_3.y)
				table.insert(self._usedPlayer, var_15_2)
			end
		end
	end
end

function GveStrategyMap:updateCUrPositionBoss()
	return
end

function GveStrategyMap:onUnload()
	return
end

return GveStrategyMap
