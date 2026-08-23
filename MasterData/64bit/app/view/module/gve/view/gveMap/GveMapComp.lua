local GveMapWorld = require("app.view.module.gve.view.gveMap.GveMapWorld")
local var_0_1 = g.core.model.User.gveDataMgr
local var_0_2 = g.core.model.User.gveDataMgr:getGveData()
local GveMapComp = class("GveMapComp", require("app.fairyGUI.gve.UI_GveMapComp"))

function GveMapComp:ctor()
	var_0_2 = var_0_1:getGveData()
	self._stage = nil

	self:_initTiledMap()
end

function GveMapComp:setStage(arg_2_1)
	self._stage = arg_2_1
end

function GveMapComp:onLoad()
	self:updatePlayerIcon()
end

function GveMapComp:_initTiledMap()
	self._mapWorld = GveMapWorld.new(self, var_0_1:getGveBaseCfg().map)

	self._mapWorld:startObserver(self.m_touchMap)
	self.m_tiledHolder:addNode(self._mapWorld)
end

function GveMapComp:getMapWorld()
	return self._mapWorld
end

function GveMapComp:moveToPoint(arg_6_1, arg_6_2)
	self._mapWorld:moveCell2SC({
		x = arg_6_1,
		y = arg_6_2
	})
	self:onMapMoveEnd()
end

function GveMapComp:getScreenCenterPoint()
	local var_7_0 = self:getMapWorld():convertToNodeSpace({
		x = display.cx,
		y = display.cy
	})
	local var_7_1, var_7_2 = self:getMapWorld():getMapGround():pixelToCoord(var_7_0.x, var_7_0.y)

	return {
		x = var_7_1,
		y = var_7_2
	}
end

function GveMapComp:getCenterPos()
	return
end

function GveMapComp:checkIsMonsterPoint(arg_9_1, arg_9_2)
	if self._stage then
		local var_9_0, var_9_1 = self._stage:checkIsMonsterPoint(arg_9_1, arg_9_2)

		return var_9_0, var_9_1
	end

	return false
end

function GveMapComp:updateFloorCompPos(arg_10_1, arg_10_2)
	self.m_floorComp:setPosition(arg_10_1, arg_10_2)
	self.m_floorComp:updateCurPos(arg_10_1, arg_10_2)
	self.m_operateComp:setPosition(arg_10_1, arg_10_2)
	self._mapWorld:checkAndLoadParts(self:getCenterPos())
end

function GveMapComp:updatePlayerIcon()
	if self._stage then
		local var_11_0 = var_0_2:getLastAddPoint()
		local var_11_1, var_11_2 = self:getMapWorld():getMapGround():coordToPixel(var_11_0.x, var_11_0.y)

		return self._stage:updatePlayerIcon(self:getMapWorld():convertToNodeSpace({
			x = display.cx,
			y = display.cy
		}), {
			x = var_11_1,
			y = var_11_2
		})
	end
end

function GveMapComp:onSingleClick(arg_12_1, arg_12_2)
	self:setTargetPosTiledId(cc.p(arg_12_1, arg_12_2))
	self.m_operateComp:updateCtrlComp({
		x = arg_12_1,
		y = arg_12_2
	})
end

function GveMapComp:onBossAliveClick(arg_13_1, arg_13_2, arg_13_3)
	self.m_operateComp:updateAliveBoss(arg_13_1, arg_13_2, arg_13_3)
end

function GveMapComp:onBossDeadClick(arg_14_1, arg_14_2, arg_14_3)
	self.m_operateComp:updateDeadBoss(arg_14_1, arg_14_2, arg_14_3)
end

function GveMapComp:onMapMoveEnd()
	local var_15_0 = self:getScreenCenterPoint()
	local var_15_1 = var_0_2:getCurPosition()

	if not var_15_1 or var_15_1.x ~= var_15_0.x or var_15_1.y ~= var_15_0.y then
		g.core.network.GameNetProxy:send_C2S_GVE_WorldMove(var_15_0)
		var_0_2:setCurPosition(var_15_0)
		self._stage:updateMapState()
	end
end

function GveMapComp:updateMiniMap()
	self._stage:updateMiniMap((self:getScreenCenterPoint()))
end

function GveMapComp:updateMapState()
	self._stage:updateMapState()
end

function GveMapComp:getTargetPosTiledId(arg_18_1)
	return self._mapWorld:getTargetPosTiledId(arg_18_1)
end

function GveMapComp:setTargetPosTiledId(arg_19_1)
	local var_19_0 = var_0_2:getGridOwner(arg_19_1)
	local var_19_1

	if var_19_0 then
		local var_19_2 = string.split(var_19_0, "_")

		var_19_1 = cc.p(tonumber(var_19_2[1]), (tonumber(var_19_2[2])))
	else
		var_19_1 = arg_19_1
	end

	if not var_0_2:isTargetTileSaved(var_19_1) then
		var_0_2:saveTargetTile(var_19_1, (self:getTargetPosTiledId(var_19_1)))
	end
end

function GveMapComp:checkAndSaveCanBeUsedGid()
	for iter_20_0, iter_20_1 in ipairs((var_0_2:getAllMySiteInfoList())) do
		self:setTargetPosTiledId(iter_20_1)
	end
end

return GveMapComp
