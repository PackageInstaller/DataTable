local var_0_0 = {
	LEVEL_UP = 1,
	WORKING = 0,
	STOP = 2
}
local var_0_1 = g.core.model.User.hlTrainData
local HLTrainState = class("HLTrainState", require("app.fairyGUI.homeLandTrain.UI_HLTrainState"))

function HLTrainState:ctor()
	self._placeCompArr = {
		self.m_placeComp_1,
		self.m_placeComp_2,
		self.m_placeComp_3
	}
end

function HLTrainState:updateComp(arg_2_1)
	local var_2_0 = var_0_1:getRoomStruct(arg_2_1)

	self.m_nameTxt:setText(var_2_0.refCfgBaseInfo.name)
	self.m_levelTxt:setText(g.core.lang:get(2052, {
		level = var_2_0.curLevel
	}))
	self.m_icon:setURL("ui://homeLandTrain/" .. var_2_0.refCfgBaseInfo.mini_icon)

	for iter_2_0, iter_2_1 in ipairs(self._placeCompArr) do
		iter_2_1:updateComp((var_2_0:getDispatchPlaceState(iter_2_0)))
	end

	self.m_stateController:setSelectedIndex((self:_getRoomState(var_2_0)))
end

function HLTrainState:_getRoomState(arg_3_1)
	if arg_3_1:isCanLevelUp() then
		return var_0_0.LEVEL_UP
	elseif arg_3_1:isWorking() then
		return var_0_0.WORKING
	else
		return var_0_0.STOP
	end
end

return HLTrainState
