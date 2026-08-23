local var_0_0 = g.core.const.ConstMgr.PetConst
local PetStarAttrPop = class("PetStarAttrPop", require("app.fairyGUI.pet.UI_PetStarAttrPop"), function()
	return fgui.GComponent:create({
		pkgName = "pet",
		resName = "PetStarAttrPop"
	})
end)

function PetStarAttrPop:ctor(arg_2_1, arg_2_2)
	self:showAtCenter()
	self:updateAttrInfo(arg_2_1, arg_2_2)
end

function PetStarAttrPop:updateAttrInfo(arg_3_1, arg_3_2)
	if not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_2 == var_0_0.ATTR_BASE_POP
	local var_3_1 = arg_3_1:getCurStarAttrArr()
	local var_3_2, var_3_3 = arg_3_1:getNextStarAttrArr()

	for iter_3_0 = 1, 4 do
		local var_3_4 = var_3_1[iter_3_0]

		if var_3_1[iter_3_0] then
			if var_3_0 then
				var_3_4.isAll = true
			else
				var_3_4.isAllDev = true
			end

			local var_3_5

			if var_3_0 then
				var_3_5 = var_3_4.baseValue or var_3_4.devValue
			end

			var_3_4.value = var_3_5

			if var_3_3[iter_3_0] then
				local var_3_6

				if var_3_0 then
					var_3_6 = var_3_3[iter_3_0].baseValue or var_3_3[iter_3_0].devValue
				end

				var_3_4.nextValue = g.core.lang:getAttrValue(var_3_4.type, tonumber(var_3_6))
				var_3_4.addValue = g.core.lang:getAttrValue(var_3_4.type, tonumber(var_3_6 - var_3_5))
			end
		end

		self["m_attrComp" .. iter_3_0]:updateAttrCell(var_3_4)
	end

	if var_3_2 then
		self.m_isMaxController:setSelectedIndex(1)
	end

	self.m_isBasicController:setSelectedIndex(arg_3_2 - 1)
end

return PetStarAttrPop
