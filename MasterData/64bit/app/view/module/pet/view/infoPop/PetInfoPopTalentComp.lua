local PetInfoPopTalentComp = class("PetInfoPopTalentComp", require("app.fairyGUI.pet.UI_PetInfoPopTalentComp"))

function PetInfoPopTalentComp:ctor()
	self._advanceTalentData = {}
	self._advanceTalentDataNum = 0

	self.m_trainList:setIniter()
	self.m_trainList:setItemRenderer(handler(self, self._onTrainItemRenderer))
end

function PetInfoPopTalentComp:updateShow(arg_2_1)
	self._advanceTalentDataNum, self._advanceTalentData = arg_2_1:getAdvanceTalentData()

	self.m_trainList:setNumItems(self._advanceTalentDataNum)
	self.m_trainList:resizeToFit(self._advanceTalentDataNum)
end

function PetInfoPopTalentComp:_onTrainItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._advanceTalentData[arg_3_1 + 1])
end

return PetInfoPopTalentComp
