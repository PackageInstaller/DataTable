local AssignedShipScene = class("AssignedShipScene", import(".BaseAssignedShipScene"))

function AssignedShipScene:getUIName()
	return "AssignedShipUI"
end

function AssignedShipScene:init()
	AssignedShipScene.super.init(self)

	self.scrollrect = self._tf:Find("layer/select_panel")
	self.rightBtn = self._tf:Find("layer/right")
	self.leftBtn = self._tf:Find("layer/left")

	return
end

function AssignedShipScene:didEnter()
	AssignedShipScene.super.didEnter(self)

	self.isZero = true
	self.isOne = false

	onScroll(self, self.scrollrect, function(arg_4_0)
		local var_4_0 = Mathf.Clamp01(arg_4_0.x)

		self.isZero = var_4_0 - 0.0001 <= 0
		self.isOne = var_4_0 + 0.0001 >= 1

		if self.isZero ~= self.isZero or self.isOne ~= self.isOne then
			self:UpdateArr()
		end

		return
	end)
	self:UpdateArr()

	return
end

function AssignedShipScene:UpdateArr()
	setActive(self.rightBtn, not self.isZero)
	setActive(self.leftBtn, not self.isOne)

	return
end

return AssignedShipScene
