local MainIconView = class("MainIconView", import("...base.MainBaseView"))
local var_0_1 = 1
local var_0_2 = 2

function MainIconView:Ctor(arg_1_1)
	MainIconView.super.Ctor(self, arg_1_1, nil)

	self._tf = arg_1_1
	self._go = arg_1_1.gameObject
	self.iconList = {
		[var_0_1] = MainSpineIcon.New(arg_1_1),
		[var_0_2] = MainEducateCharIcon.New(arg_1_1)
	}

	return
end

function MainIconView:GetIconType(arg_2_1)
	if isa(arg_2_1, VirtualEducateCharShip) then
		return var_0_2
	else
		return var_0_1
	end

	return
end

function MainIconView:Init(arg_3_1)
	self.ship = arg_3_1

	if self.iconInstance then
		self.iconInstance:Unload()

		self.iconInstance = nil
	end

	self.iconInstance = self.iconList[self:GetIconType(arg_3_1)]

	self.iconInstance:Load(arg_3_1:getPrefab())

	return
end

function MainIconView:Refresh(arg_4_1)
	if self.iconList[self:GetIconType(arg_4_1)] ~= self.iconInstance or self.ship:getPrefab() ~= arg_4_1:getPrefab() then
		self:Init(arg_4_1)
	elseif self.iconInstance then
		self.iconInstance:Resume()
	end

	self.ship = arg_4_1

	return
end

function MainIconView:Disable()
	if self.iconInstance then
		self.iconInstance:Pause()
	end

	return
end

function MainIconView:IsLoading()
	if self.iconInstance then
		return self.iconInstance:IsLoading()
	end

	return false
end

function MainIconView:GetDirection()
	return Vector2(0, 1)
end

function MainIconView:Dispose()
	MainIconView.super.Dispose(self)

	for iter_8_0, iter_8_1 in ipairs(self.iconList) do
		iter_8_1:Dispose()
	end

	self.iconList = nil
	self.iconInstance = nil

	return
end

return MainIconView
