local BaseEquipMagicalComp = class("BaseEquipMagicalComp", require("app.fairyGUI.base_new.UI_BaseEquipMagicalComp5"))

function BaseEquipMagicalComp:ctor()
	return
end

function BaseEquipMagicalComp:updateTypeAndStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_4 = arg_2_4 or 0

	self.m_equipTypeController:setSelectedIndex(arg_2_1)

	if arg_2_5 == g.core.const.ConstMgr.QUALITY_TYPE.UR then
		self.m_equipQualityController:setSelectedIndex(0)
	elseif arg_2_5 == g.core.const.ConstMgr.QUALITY_TYPE.MR then
		self.m_equipQualityController:setSelectedIndex(1)
	end

	for iter_2_0 = 1, arg_2_3 do
		local var_2_0 = self["m_stage" .. iter_2_0]

		if self["m_stage" .. iter_2_0] then
			local var_2_1 = iter_2_0 <= arg_2_2 and iter_2_0 ~= arg_2_4

			var_2_0:setCtrlState("isActive", {
				index = iter_2_0 <= arg_2_2 and iter_2_0 ~= arg_2_4 and 1 or 0
			})

			if var_2_1 then
				var_2_0:playActiveEff()
			elseif iter_2_0 == arg_2_4 then
				var_2_0:playNextActiveEff()
			else
				var_2_0:hideEff()
			end
		end
	end
end

function BaseEquipMagicalComp:playStageUpEff(arg_3_1)
	if self["m_stage" .. arg_3_1] then
		self["m_stage" .. arg_3_1]:playMagicalStageUpEff()
	end
end

return BaseEquipMagicalComp
