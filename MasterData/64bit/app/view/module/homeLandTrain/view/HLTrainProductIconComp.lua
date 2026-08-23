local var_0_0 = g.core.config.homeland_train_product_info
local HLTrainProductIconComp = class("HLTrainProductIconComp", require("app.fairyGUI.homeLandTrain.UI_HLTrainProductIconComp"))

function HLTrainProductIconComp:updateIcon(arg_1_1)
	if arg_1_1 == 0 then
		self.m_workingController:setSelectedIndex(0)
	else
		local var_1_0 = var_0_0.get(arg_1_1)

		self.m_productComp:updateIcon({
			type = var_1_0.product_type,
			value = var_1_0.product_value
		})
		self.m_productComp:setNum(0)
		self.m_workingController:setSelectedIndex(1)
	end
end

return HLTrainProductIconComp
