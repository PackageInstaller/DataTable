local var_0_0 = require("app.view.module.homeLandTrain.const.HLTrainConst").DISPATCH_PLACE_STATE
local HLTrainDispatchPlaceComp = class("HLTrainDispatchPlaceComp", require("app.fairyGUI.homeLandTrain.UI_HLTrainDispatchPlaceComp"))

function HLTrainDispatchPlaceComp:updateComp(arg_1_1)
	arg_1_1 = arg_1_1 or var_0_0.LOCK

	self.m_stateController:setSelectedIndex(arg_1_1)
end

return HLTrainDispatchPlaceComp
