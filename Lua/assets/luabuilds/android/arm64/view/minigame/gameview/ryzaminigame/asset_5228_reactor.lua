local Reactor = class("Reactor", import("view.miniGame.gameView.RyzaMiniGame.BaseReactor"))

function Reactor:GetBaseOrder()
	return 1
end

function Reactor:CellPassability()
	return true
end

function Reactor:FirePassability()
	return 0
end

function Reactor:InTimeRiver()
	return false
end

function Reactor:Init(arg_5_1)
	self.name = arg_5_1.name

	if self:GetBaseOrder() ~= "floor" then
		SetCanvasOverrideSorting(self._tf, true)
	end

	Reactor.UpdatePos(self, NewPos(unpack(arg_5_1.pos)))

	self.realPos = NewPos(unpack(arg_5_1.realPos or arg_5_1.pos))

	self:UpdatePosition()
	self:InitUI(arg_5_1)
	self:InitRegister(arg_5_1)

	return
end

function Reactor:InitUI(arg_6_1)
	return
end

function Reactor:InitRegister(arg_7_1)
	return
end

function Reactor:UpdatePos(arg_8_1)
	local var_8_0 = self:GetBaseOrder()

	if var_8_0 ~= "floor" then
		self._tf:GetComponent(typeof(Canvas)).sortingOrder = arg_8_1.y * 10 + var_8_0
	end

	self.pos = arg_8_1

	return
end

function Reactor:UpdatePosition()
	setAnchoredPosition(self._tf, {
		x = self.realPos.x * 32,
		y = self.realPos.y * -32
	})

	return
end

return Reactor
