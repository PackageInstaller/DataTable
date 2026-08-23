local HLTrainLvUpBtn = class("HLTrainLvUpBtn", require("app.fairyGUI.homeLandTrain.UI_HLTrainLvUpBtn"))

function HLTrainLvUpBtn:ctor()
	return
end

function HLTrainLvUpBtn:refreshNeed(arg_2_1, arg_2_2)
	self:setIcon(arg_2_1)
	self.m_numTxt:setText(arg_2_2)
end

function HLTrainLvUpBtn:setGray(arg_3_1)
	self.m_grayController:setSelectedIndex(arg_3_1 and 1 or 0)
end

return HLTrainLvUpBtn
