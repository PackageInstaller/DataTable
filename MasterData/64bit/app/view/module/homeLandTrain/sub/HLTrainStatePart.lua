local var_0_0 = g.core.model.User
local HLTrainStatePart = class("HLTrainStatePart", require("app.fairyGUI.homeLandTrain.UI_HLTrainStatePart"))

function HLTrainStatePart:ctor()
	self._placeCompArr = {
		self.m_placeComp_1,
		self.m_placeComp_2,
		self.m_placeComp_3
	}
	self._roomStruct = nil
end

function HLTrainStatePart:updateComp(arg_2_1)
	local var_2_0 = var_0_0.hlTrainData:getRoomStruct(arg_2_1)

	self._roomStruct = var_2_0

	self.m_nameTxt:setText(var_2_0.refCfgBaseInfo.name)
	self.m_lvTxt:setText(g.core.lang:get(2052, {
		level = var_2_0.curLevel
	}))
	self.m_roomIconLoader:setURL("ui://homeLandTrain/" .. var_2_0.refCfgBaseInfo.mini_icon)

	for iter_2_0, iter_2_1 in ipairs(self._placeCompArr) do
		iter_2_1:updateComp((var_2_0:getDispatchPlaceState(iter_2_0)))
	end
end

return HLTrainStatePart
