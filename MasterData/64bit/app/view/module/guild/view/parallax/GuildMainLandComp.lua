local BGFactory = require("app.view.common.BGFactory")
local GuildMainLandComp = class("GuildMainLandComp", require("app.fairyGUI.guild.UI_GuildMainLandComp"))
local GuildMainPageCfg = require("app.view.module.guild.const.GuildMainPageCfg")
local var_0_3 = 254

function GuildMainLandComp:ctor()
	return
end

function GuildMainLandComp:onLoad()
	self:_updateRed()
end

function GuildMainLandComp:init()
	self:initData()

	self._parallaxComp = BGFactory.create({
		bgPath = "parallax/guild/01/guild.pcfg",
		isAsync = true,
		parent = self,
		stage = self.m_bgComp,
		initPosX = -self._rangeTable.minX,
		quality = g.core.resource.ResourceManager:getDeviceRealQuality()
	})

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:initParallaxPos()
end

function GuildMainLandComp:setUserActionOperate(arg_4_1, arg_4_2)
	local var_4_0 = self._parallaxComp:getBackground()

	for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
		local var_4_1 = var_4_0:getChild(arg_4_1 .. iter_4_0)

		var_4_1:bindLua("app.view.module.guild.view.GuildBuildBtn")
		var_4_1:setData(iter_4_1)
	end
end

function GuildMainLandComp:updateRed()
	self:_updateRed()
end

function GuildMainLandComp:initData()
	self._isRange = json.decodeFile("parallax/guild/01/guild.pcfg").isRange

	self:checkRangeRange()
end

function GuildMainLandComp:_onTouchBegin(arg_7_1)
	arg_7_1:captureTouch()

	local var_7_0 = arg_7_1:getInput():getTouch()

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0:getLocation()

	self._curTouchX = var_7_1.x
	self._curTouchY = var_7_1.y

	self:_stopMoveMap()
end

function GuildMainLandComp:_onTouchMove(arg_8_1)
	local var_8_0 = arg_8_1:getInput():getTouch()

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0:getLocation()

	self._curTouchX = var_8_1.x
	self._curTouchY = var_8_1.y

	if self._isRange then
		self:_rangeMoveMap(var_8_1.x - self._curTouchX, var_8_1.y - self._curTouchY)
	end
end

function GuildMainLandComp:_rangeMoveMap(arg_9_1, arg_9_2)
	local var_9_0 = self.m_bgComp:getX() + arg_9_1
	local var_9_1 = self.m_bgComp:getY() - arg_9_2

	if var_9_0 < -self._rangeTable.maxX then
		var_9_0 = -self._rangeTable.maxX
	elseif var_9_0 > -self._rangeTable.minX then
		var_9_0 = -self._rangeTable.minX
	end

	if self._yDoNotMove then
		var_9_1 = self._rangeTable.minY
	elseif var_9_1 > self._rangeTable.maxY then
		var_9_1 = self._rangeTable.maxY
	elseif var_9_1 < self._rangeTable.minY then
		var_9_1 = self._rangeTable.minY
	end

	self._parallaxComp:setPosition(var_9_0, var_9_1)
	self:_updateRed()

	return true
end

function GuildMainLandComp:_updateRed()
	local var_10_0 = {}
	local var_10_1 = self._parallaxComp:getBackground()

	for iter_10_0, iter_10_1 in ipairs(GuildMainPageCfg) do
		local var_10_2 = var_10_1:getChild("fun_tag_" .. iter_10_0)

		if var_10_2 then
			if var_10_2 and var_10_2:getX() < -150 and var_10_2:getRedPointStyle() > 0 then
				var_10_0.leftStyle = var_10_2:getRedPointStyle()
			elseif var_10_2:getX() > display.width - var_0_3 and var_10_2:getRedPointStyle() > 0 then
				var_10_0.rightStyle = var_10_2:getRedPointStyle()
			end
		end
	end

	self:dispatchCompEvent("Guid_show_red_point", var_10_0)
end

function GuildMainLandComp:_stopMoveMap()
	if self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end
end

function GuildMainLandComp:moveMap(arg_12_1)
	self._direction = arg_12_1
	self._redTarget = nil

	local var_12_0 = self._parallaxComp:getBackground()

	if arg_12_1 == 1 then
		for iter_12_0 = 6, 1, -1 do
			local var_12_1 = var_12_0:getChild("fun_tag_" .. GuildMainPageCfg[iter_12_0].index)

			if var_12_1 and var_12_1:getX() < 0 and var_12_1:getRedPointStyle() > 0 then
				self._redTarget = var_12_1

				break
			end
		end
	else
		for iter_12_1 = 1, 6 do
			local var_12_2 = var_12_0:getChild("fun_tag_" .. GuildMainPageCfg[iter_12_1].index)

			if var_12_2 and var_12_2:getX() > display.width - var_0_3 and var_12_2:getRedPointStyle() > 0 then
				self._redTarget = var_12_2

				break
			end
		end
	end

	self:_stopMoveMap()

	self._scheduleHandler = self:newSchedule(handler(self, self._updateMapPos), 0.01)
end

function GuildMainLandComp:_updateMapPos()
	if self._direction == 1 then
		if not self._redTarget or self._redTarget:getX() > display.width / 2 then
			self:_stopMoveMap()

			return
		end

		self:_rangeMoveMap(60, 0)
	else
		if not self._redTarget or self._redTarget:getX() < display.width / 2 then
			self:_stopMoveMap()

			return
		end

		self:_rangeMoveMap(-60, 0)
	end

	local var_13_0 = self.m_bgComp:getX()

	if var_13_0 <= -self._rangeTable.maxX then
		self:_stopMoveMap()
	elseif var_13_0 >= -self._rangeTable.minX then
		self:_stopMoveMap()
	end
end

function GuildMainLandComp:getCameraRoute()
	local var_14_0 = json.decodeFile("parallax/guild/01/01_camera.scfg")
	local var_14_1 = {}

	if not next(var_14_1) then
		var_14_1 = var_14_0.route

		for iter_14_0, iter_14_1 in ipairs(var_14_0.route) do
			iter_14_1.y = display.height / 2 - iter_14_1.y + (display.height - CC_DESIGN_RESOLUTION.height) / 2
		end

		table.insert(var_14_1, 1, {
			x = 0,
			y = var_14_1[1].y
		})
		table.insert(var_14_1, {
			x = var_14_0.mapSize.width,
			y = var_14_1[#var_14_1].y
		})
	end

	return var_14_1
end

function GuildMainLandComp:checkRangeRange()
	if self._isRange then
		local var_15_0 = self:getCameraRoute()
		local var_15_1 = -9999999
		local var_15_2 = -9999999
		local var_15_3 = 9999999
		local var_15_4 = 9999999

		if #var_15_0 > 3 then
			for iter_15_0 = 2, #var_15_0 - 1 do
				if var_15_1 < var_15_0[iter_15_0].x then
					var_15_1 = var_15_0[iter_15_0].x
				end

				if var_15_3 > var_15_0[iter_15_0].x then
					var_15_3 = var_15_0[iter_15_0].x
				end

				if var_15_2 < var_15_0[iter_15_0].y then
					var_15_2 = var_15_0[iter_15_0].y
				end

				if var_15_4 > var_15_0[iter_15_0].y then
					var_15_4 = var_15_0[iter_15_0].y
				end
			end

			self._rangeTable = {
				maxX = var_15_1 - 568 - (display.width - CC_DESIGN_RESOLUTION.width),
				maxY = var_15_2 - 55 - (display.height - CC_DESIGN_RESOLUTION.height) / 2,
				minX = var_15_3 - 568,
				minY = var_15_4 - 55 + (display.height - CC_DESIGN_RESOLUTION.height) / 2
			}

			if self._rangeTable.maxY < self._rangeTable.minY then
				self._yDoNotMove = true
			end
		end
	end
end

function GuildMainLandComp:initParallaxPos()
	self._parallaxComp:setPosition(-self._rangeTable.minX, self._rangeTable.minY)
end

return GuildMainLandComp
