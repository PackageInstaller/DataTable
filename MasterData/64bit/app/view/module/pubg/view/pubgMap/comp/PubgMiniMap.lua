local var_0_0 = 1072
local var_0_1 = 536
local var_0_2 = 60
local var_0_3 = g.core.const.ConstMgr.PubgConst
local var_0_4 = g.core.model.User.pubgData
local PubgMapHelp = require("app.view.module.pubg.view.pubgMap.mapWorld.PubgMapHelp")
local PubgMiniMap = class("PubgMiniMap", require("app.fairyGUI.pubg.UI_PubgMiniMap"))

function PubgMiniMap:ctor()
	self._centerPos = self.m_centerComp:getPosition()
	self._P_HEIGHT = var_0_1 / var_0_2
	self._P_WIDTH = var_0_0 / var_0_2
	self._startPos = {
		x = self._centerPos.x,
		y = self._centerPos.y - self._P_HEIGHT * var_0_2 / 2
	}
	self._mapItems = {}
	self._showItemDict = {}
	self._miniItemPool = {}

	self.m_mapLoader:setURL((g.core.common.Path:getPubgMiniMapBg((var_0_4:getMapData():getMapId()))))
	self:updateCurPositionRange()
end

function PubgMiniMap:getMiniMapItemComp()
	if not self._miniItemPool[1] then
		local var_2_0 = fgui.UIPackage:createObject("pubg", "PubgMiniMapItemComp", self)

		self.m_colorComp:addChild(var_2_0)

		return var_2_0
	end

	local var_2_1 = table.remove(self._miniItemPool, 1)

	var_2_1:setVisible(true)

	return var_2_1
end

function PubgMiniMap:returnItemToPool(arg_3_1)
	if arg_3_1 then
		arg_3_1:setVisible(false)
		arg_3_1:resetComp()
		table.insert(self._miniItemPool, arg_3_1)
	end
end

function PubgMiniMap:showInAirDropItem(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in pairs(var_0_4:getMapData():getAirDropDict()) do
		local var_4_0, var_4_1 = iter_4_1:getPos()
		local var_4_2 = PubgMapHelp.getKey(var_4_0, var_4_1)
		local var_4_3 = iter_4_1:getOnlyKey()
		local var_4_4 = self._showItemDict[var_4_3] or {}

		if var_4_4.xy ~= var_4_2 then
			self:returnItemToPool(var_4_4.comp)

			local var_4_5 = self:getMiniMapItemComp()

			var_4_5:setCtrlState("ctrl", {
				index = 3
			})

			local var_4_6 = self:coordToPixel(var_4_0, var_4_1)

			var_4_5:setPosition(var_4_6.x, -var_4_6.y)

			var_4_4 = {
				x = var_4_0,
				y = var_4_1,
				xy = var_4_2,
				comp = var_4_5,
				oid = var_4_3
			}

			table.insert(self._mapItems, var_4_4)

			self._showItemDict[var_4_3] = var_4_4
		end

		if arg_4_1 == var_4_0 and arg_4_2 == var_4_1 then
			var_4_4.comp:playShowAirDrop()
		end
	end
end

function PubgMiniMap:getMapPosByPosition(arg_5_1)
	return math.round(((arg_5_1.x - self._startPos.x) / (self._P_WIDTH / 2) + (arg_5_1.y - self._startPos.y) / (self._P_HEIGHT / 2)) / 2), math.round(((arg_5_1.y - self._startPos.y) / (self._P_HEIGHT / 2) - (arg_5_1.x - self._startPos.x) / (self._P_WIDTH / 2)) / 2)
end

function PubgMiniMap:coordToPixel(arg_6_1, arg_6_2)
	return {
		x = (arg_6_1 - arg_6_2) * (self._P_WIDTH / 2),
		y = -(arg_6_1 + arg_6_2) * (self._P_HEIGHT / 2)
	}
end

function PubgMiniMap:updateCurPositionRange(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = var_0_4:getMapData()
	local var_7_1 = var_7_0:getMyUser()
	local var_7_2, var_7_3 = var_7_1:getPos()

	arg_7_1 = arg_7_1 or var_7_2
	arg_7_2 = arg_7_2 or var_7_3

	local var_7_4 = PubgMapHelp.getKey(var_7_2, var_7_3)

	for iter_7_0, iter_7_1 in pairs(self._showItemDict) do
		if not var_7_0:getItemByOid(iter_7_0) then
			self:returnItemToPool(iter_7_1.comp)

			self._showItemDict[iter_7_0] = nil
		end
	end

	for iter_7_2 = arg_7_1 - var_0_3.MINIMAP_RANGE_POINTS, arg_7_1 + var_0_3.MINIMAP_RANGE_POINTS do
		for iter_7_3 = arg_7_2 - var_0_3.MINIMAP_RANGE_POINTS, arg_7_2 + var_0_3.MINIMAP_RANGE_POINTS do
			local var_7_5 = PubgMapHelp.getKey(iter_7_2, iter_7_3)
			local var_7_6 = var_7_0:getBuffByPos(iter_7_2, iter_7_3)

			if var_7_6 then
				local var_7_7 = var_7_6:getOnlyKey()
				local var_7_8 = self._showItemDict[var_7_7] or {}

				if var_7_8.xy ~= var_7_5 then
					self:returnItemToPool(var_7_8.comp)

					local var_7_9 = self:getMiniMapItemComp()

					var_7_9:setCtrlState("ctrl", {
						index = 1
					})

					local var_7_10 = self:coordToPixel(iter_7_2, iter_7_3)

					var_7_9:setPosition(var_7_10.x, -var_7_10.y)

					local var_7_11 = {
						x = iter_7_2,
						y = iter_7_3,
						xy = var_7_5,
						comp = var_7_9,
						oid = var_7_7
					}

					table.insert(self._mapItems, var_7_11)

					self._showItemDict[var_7_7] = var_7_11
				end
			end

			local var_7_12 = var_7_0:getMonsterByPos(iter_7_2, iter_7_3)

			if var_7_12 then
				local var_7_13 = var_7_12:getOnlyKey()
				local var_7_14 = self._showItemDict[var_7_13] or {}

				if var_7_14.xy ~= var_7_5 then
					self:returnItemToPool(var_7_14.comp)

					local var_7_15 = self:getMiniMapItemComp()

					var_7_15:setCtrlState("ctrl", {
						index = 2
					})

					local var_7_16 = self:coordToPixel(iter_7_2, iter_7_3)

					var_7_15:setPosition(var_7_16.x, -var_7_16.y)

					local var_7_17 = {
						x = iter_7_2,
						y = iter_7_3,
						xy = var_7_5,
						comp = var_7_15,
						oid = var_7_13
					}

					table.insert(self._mapItems, var_7_17)

					self._showItemDict[var_7_13] = var_7_17
				end
			end

			if not arg_7_3 then
				local var_7_18 = var_7_0:getAirDropByPos(iter_7_2, iter_7_3)

				if var_7_18 then
					local var_7_19 = var_7_18:getOnlyKey()
					local var_7_20 = self._showItemDict[var_7_19] or {}

					if var_7_20.xy ~= var_7_5 then
						self:returnItemToPool(var_7_20.comp)

						local var_7_21 = self:getMiniMapItemComp()

						var_7_21:setCtrlState("ctrl", {
							index = 3
						})

						local var_7_22 = self:coordToPixel(iter_7_2, iter_7_3)

						var_7_21:setPosition(var_7_22.x, -var_7_22.y)

						local var_7_23 = {
							x = iter_7_2,
							y = iter_7_3,
							xy = var_7_5,
							comp = var_7_21,
							oid = var_7_19
						}

						table.insert(self._mapItems, var_7_23)

						self._showItemDict[var_7_19] = var_7_23

						var_7_21:playLoopAirDrop()
					end
				end
			end
		end
	end

	local var_7_24 = var_7_1:getOnlyKey()
	local var_7_25 = self._showItemDict[var_7_24] or {}

	if var_7_25.xy ~= var_7_4 then
		self:returnItemToPool(var_7_25.comp)

		local var_7_26 = self:getMiniMapItemComp()

		var_7_26:setCtrlState("ctrl", {
			index = 0
		})

		local var_7_27 = self:coordToPixel(var_7_2, var_7_3)

		var_7_26:setPosition(var_7_27.x, -var_7_27.y)

		local var_7_28 = {
			x = var_7_2,
			y = var_7_3,
			xy = var_7_4,
			comp = var_7_26,
			oid = var_7_24
		}

		table.insert(self._mapItems, var_7_28)

		self._showItemDict[var_7_24] = var_7_28
	end

	for iter_7_4 = #self._mapItems, 1, -1 do
		if not self._showItemDict[self._mapItems[iter_7_4].oid] then
			self:returnItemToPool(self._mapItems[iter_7_4].comp)
			table.remove(self._mapItems, iter_7_4)
		elseif self._mapItems[iter_7_4].xy ~= self._showItemDict[self._mapItems[iter_7_4].oid].xy then
			if arg_7_1 - var_0_3.MINIMAP_RANGE_POINTS > self._mapItems[iter_7_4].x or arg_7_1 + var_0_3.MINIMAP_RANGE_POINTS < self._mapItems[iter_7_4].x or arg_7_2 - var_0_3.MINIMAP_RANGE_POINTS > self._mapItems[iter_7_4].y or arg_7_2 + var_0_3.MINIMAP_RANGE_POINTS < self._mapItems[iter_7_4].y then
				self:returnItemToPool(self._mapItems[iter_7_4].comp)
			end

			table.remove(self._mapItems, iter_7_4)
		end
	end
end

return PubgMiniMap
