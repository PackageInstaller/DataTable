local StormSmallCityConst = require("app.view.module.storm.const.StormSmallCityConst")
local KsMath = require("app.core.utils.KsMath")
local StormGround = class("StormGround", require("app.core.ksmap.MapGround"))

function StormGround:ctor(arg_1_1)
	self._tempHoldMap = {}
	self._clearFogMap = {}
	self._oldShowFogs = {}

	StormGround.super.ctor(self, arg_1_1)

	self._halfWidthNum = math.ceil(display.width / (4 * self._MAP_TILE_HW)) + 5
	self._halfHeightNum = math.ceil(display.height / (4 * self._MAP_TILE_HH)) + 5

	self:createFogDadNode()
	self:_deserializeStormFog()
	self:initFog()
end

function StormGround:doBasePath()
	return g.core.common.Path:getStormMainBasePath()
end

function StormGround:checkPosUnlocked(arg_3_1, arg_3_2)
	return true
end

function StormGround:_doTiledLayer()
	return {
		StormSmallCityConst.MAP_FLOOR,
		StormSmallCityConst.MAP_DECORATE
	}
end

function StormGround:doAttachNode()
	return {
		StormSmallCityConst.MAP_FLOOR,
		StormSmallCityConst.MAP_DECORATE
	}
end

function StormGround:_serializeStormFog()
	g.core.common.Storage:save(self:_getFogJsonName(), self._clearFogMap)
end

function StormGround:_deserializeStormFog()
	self._clearFogMap = g.core.common.Storage:load((self:_getFogJsonName())) or {}
end

function StormGround:_getFogJsonName()
	return "storm_small_map_fog_" .. self:getMapWorld():getMapId() .. ".json"
end

function StormGround:_addToFogPool(arg_9_1)
	if not arg_9_1 then
		return
	end

	self._fogPool = self._fogPool or {}

	arg_9_1:setVisible(false)
	table.insert(self._fogPool, arg_9_1)
end

function StormGround:_updateFogFromPool(arg_10_1, arg_10_2)
	self._fogPool = self._fogPool or {}

	local var_10_0

	if not next(self._fogPool) then
		var_10_0 = self:_createFogSprite(arg_10_1, arg_10_2)
	else
		var_10_0 = table.remove(self._fogPool, 1)

		var_10_0:setName((KsMath.coord2Unified(arg_10_1, arg_10_2)))

		local var_10_1, var_10_2 = self:coordToPixel(arg_10_1, arg_10_2)

		var_10_0:setPosition(var_10_1, var_10_2)
	end

	var_10_0:setVisible(true)
end

function StormGround:_removeFog(arg_11_1, arg_11_2)
	local var_11_0 = KsMath.coord2Unified(arg_11_1, arg_11_2)
	local var_11_1 = self._fogDadNode:getChildByName(var_11_0)

	if var_11_1 then
		self:_addToFogPool(var_11_1)
	end

	self._clearFogMap[var_11_0] = 1
end

function StormGround:isFogClear(arg_12_1, arg_12_2)
	return self._clearFogMap[KsMath.coord2Unified(arg_12_1, arg_12_2)] == 1
end

function StormGround:updateFogInView()
	local var_13_0 = self:getMapWorld():convertScreenCenter()
	local var_13_1, var_13_2 = self:pixelToCoord(var_13_0.x, var_13_0.y)
	local var_13_3 = {}

	if not self._oldXy or math.abs(self._oldXy.x - var_13_1) + math.abs(self._oldXy.y - var_13_2) >= 4 then
		self._oldXy = {
			x = var_13_1,
			y = var_13_2
		}

		for iter_13_0 = var_13_1 - self._halfWidthNum, var_13_1 + self._halfWidthNum do
			for iter_13_1 = var_13_2 - self._halfHeightNum, var_13_2 + self._halfHeightNum do
				local var_13_4 = KsMath.coord2Unified(iter_13_0, iter_13_1)

				if not self:isFogClear(iter_13_0, iter_13_1) and not self._fogDadNode:getChildByName(var_13_4) then
					self:_updateFogFromPool(iter_13_0, iter_13_1)
				end

				var_13_3[var_13_4] = 1
				self._oldShowFogs[var_13_4] = nil
			end
		end

		for iter_13_2, iter_13_3 in pairs(self._oldShowFogs) do
			local var_13_5 = self._fogDadNode:getChildByName(iter_13_2)

			if var_13_5 then
				self:_addToFogPool(var_13_5)
			end
		end

		self._oldShowFogs = var_13_3
	end
end

function StormGround:createFogDadNode()
	self._fogDadNode = cc.Node:create()

	self:addChild(self._fogDadNode, 999)
end

function StormGround:getFogDadNode()
	return self._fogDadNode
end

function StormGround:initFog()
	return
end

function StormGround:clearFog(arg_17_1, arg_17_2)
	arg_17_2 = arg_17_2 or StormSmallCityConst.FOG_CLEAR_RANGE

	local var_17_0 = false

	for iter_17_0 = -arg_17_2, arg_17_2 do
		for iter_17_1 = -arg_17_2, arg_17_2 do
			if not self:isFogClear(arg_17_1.x + iter_17_0, arg_17_1.y + iter_17_1) then
				var_17_0 = true

				self:_removeFog(arg_17_1.x + iter_17_0, arg_17_1.y + iter_17_1)
			end
		end
	end

	if var_17_0 then
		self:_serializeStormFog()
	end

	return var_17_0
end

function StormGround:_createFogSprite(arg_18_1, arg_18_2)
	local var_18_0 = cc.Sprite:create(StormSmallCityConst.FOG_IMG_PATH)

	var_18_0:setName((KsMath.coord2Unified(arg_18_1, arg_18_2)))
	var_18_0:setScale(StormSmallCityConst.FOG_MASK_SCALE)
	var_18_0:setOpacity(255 * StormSmallCityConst.FOG_MASK_OPACITY)

	local var_18_1, var_18_2 = self:coordToPixel(arg_18_1, arg_18_2)

	var_18_0:setPosition(var_18_1, var_18_2)
	self._fogDadNode:addChild(var_18_0)

	return var_18_0
end

function StormGround:updateTempGroundHold(arg_19_1)
	for iter_19_0, iter_19_1 in pairs(self._tempHoldMap) do
		if type(iter_19_1) == "table" then
			for iter_19_2, iter_19_3 in ipairs(iter_19_1) do
				self:setHoldType(iter_19_3.x, iter_19_3.y, 0)
			end
		else
			self:setHoldType(iter_19_1.x, iter_19_1.y, 0)
		end
	end

	self._tempHoldMap = {}

	for iter_19_4, iter_19_5 in pairs(arg_19_1) do
		for iter_19_6, iter_19_7 in ipairs(iter_19_5) do
			if self._tempHoldMap[iter_19_4] and type(self._tempHoldMap[iter_19_4]) ~= "table" then
				self._tempHoldMap[iter_19_4] = {}

				table.insert(self._tempHoldMap[iter_19_4], self._tempHoldMap[iter_19_4])
				table.insert(self._tempHoldMap[iter_19_4], iter_19_7._coord)
			elseif type(self._tempHoldMap[iter_19_4]) == "table" then
				table.insert(self._tempHoldMap[iter_19_4], iter_19_7._coord)
			else
				self._tempHoldMap[iter_19_4] = iter_19_7._coord
			end

			self:setHoldType(iter_19_7._coord.x, iter_19_7._coord.y, nil)
		end
	end
end

return StormGround
