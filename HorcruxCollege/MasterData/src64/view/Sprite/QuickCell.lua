local QuickCell = class("QuickCell", function()
	return ccui.Widget:create()
end)
local var_0_1 = cc.Director:getInstance():getVisibleSize()
local var_0_2 = schedule

function QuickCell:ctor()
	self._entered = false
	self._active = true
end

function QuickCell:Create(arg_3_1)
	local var_3_0 = QuickCell.new()

	if var_3_0 and var_3_0:Init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function QuickCell:Init(arg_4_1)
	self._data = arg_4_1

	local var_4_0 = self._data.wid or 100
	local var_4_1 = self._data.hei or 50
	local var_4_2 = self._data.anchor or {
		x = 0,
		y = 0
	}

	self:setContentSize({
		width = var_4_0,
		height = var_4_1
	})
	self:setAnchorPoint(var_4_2)
	self:Active()

	return true
end

function QuickCell:Update(arg_5_1)
	if arg_5_1 and arg_5_1.createCell then
		self._data.createCell = arg_5_1.createCell
	end

	self:Exit()
end

function QuickCell:Enter()
	if self._entered then
		return false
	end

	self._entered = true

	local var_6_0 = self._data.wid or 100
	local var_6_1 = self._data.hei or 50

	if not self._data.createCell then
		return false
	end

	local var_6_2 = self._data.createCell()

	self:addChild(var_6_2)

	if not self._data.nobool then
		var_6_2:setAnchorPoint({
			x = 0.5,
			y = 0.5
		})
		var_6_2:setPosition({
			x = var_6_0 / 2,
			y = var_6_1 / 2
		})
	end
end

function QuickCell:Exit()
	if not self._entered then
		return false
	end

	self._entered = false

	self:removeAllChildren()
end

function QuickCell:Refresh()
	if not self._active then
		return false
	end

	if self:IsActive() then
		self:Enter()
	else
		self:Exit()
	end
end

function QuickCell:Active()
	self._active = true

	local var_9_0 = self._data.tick_interval or 0.02

	self:stopAllActions()
	var_0_2(self, function()
		self:Refresh()
	end, var_9_0)
end

function QuickCell:Sleep()
	self._active = false

	self:stopAllActions()
end

function QuickCell:IsEnter()
	return self._entered
end

function QuickCell:IsActive()
	local var_13_0 = true

	if self._data.activeEvent then
		var_13_0 = self._data.activeEvent(self)
	elseif self._data.eventX then
		local var_13_1 = self:getWorldPosition()
		local var_13_2 = self._data.wid or 100

		if not self._data.hei then
			-- block empty
		end

		var_13_0 = var_13_1.x < var_0_1.width + var_13_2 and var_13_1.x > -var_13_2
	else
		local var_13_4 = self:getWorldPosition()

		if not self._data.wid then
			-- block empty
		end

		local var_13_6 = self._data.hei or 50

		var_13_0 = var_13_4.y < var_0_1.height + var_13_6 and var_13_4.y > -var_13_6
	end

	return var_13_0
end

return QuickCell
