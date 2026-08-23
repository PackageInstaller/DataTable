local ShowPopNewSlgPvcNormalFailComp = class("ShowPopNewSlgPvcNormalFailComp")

function ShowPopNewSlgPvcNormalFailComp:ctor()
	self._txtDesc = self:getChild("Txt_desc")
	self._txtProg = self:getChild("Txt_prog")
	self._compProg = self:getChild("Comp_prog")

	self._compProg:setMax(100)
	self._compProg:setValue(100)

	self._compBuildingInfo = self:getChild("Comp_buildingInfo")
	self._compIcon = self:getChild("Comp_icon")
end

function ShowPopNewSlgPvcNormalFailComp:update(arg_2_1)
	self._compBuildingInfo:updateView((g.core.model.User.newSlgData:getCityComponentById(arg_2_1.result.city_battle_result.city_id)))

	local var_2_0 = g.core.model.User.newSlgData:getCityInfoById(arg_2_1.result.city_battle_result.city_id)

	self._txtProg:setText(g.core.lang:get(105014, {
		num1 = var_2_0.city_blood,
		num2 = var_2_0.city_blood
	}))
	self._txtDesc:setText(g.core.lang:get(429014, {
		num = arg_2_1.result.city_battle_result.kill_num
	}))

	if arg_2_1.result.awards and #arg_2_1.result.awards > 0 then
		self._compIcon:updateIcon(arg_2_1.result.awards[1])
	end
end

return ShowPopNewSlgPvcNormalFailComp
