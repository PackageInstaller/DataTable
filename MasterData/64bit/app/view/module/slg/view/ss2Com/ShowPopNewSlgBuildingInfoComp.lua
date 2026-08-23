local ShowPopNewSlgBuildingInfoComp = class("ShowPopNewSlgBuildingInfoComp")

function ShowPopNewSlgBuildingInfoComp:ctor()
	self._compPlace = self:getChild("Comp_place")
	self._txtName = self:getChild("Txt_name")
end

function ShowPopNewSlgBuildingInfoComp:updateView(arg_2_1)
	if self._sprite then
		self._sprite:removeFromParent()

		self._sprite = nil
	end

	self._sprite = display.newSprite("#" .. g.core.common.Path:getNewSlgBuilding(arg_2_1.res_1))

	self._sprite:setScale(arg_2_1.scale / 10000)
	self._sprite:setAnchorPoint(0.5, 0)
	self._compPlace:addNode(self._sprite)

	local var_2_0 = g.core.model.User.newSlgData:getCityInfoById(arg_2_1.value)

	self._txtName:setText(g.core.lang:get(429010, {
		num = var_2_0.level,
		name = var_2_0.name
	}))
end

return ShowPopNewSlgBuildingInfoComp
