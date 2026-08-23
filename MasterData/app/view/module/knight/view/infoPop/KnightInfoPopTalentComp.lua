local KnightInfoPopTalentComp = class("KnightInfoPopTalentComp", require("app.fairyGUI.knight.UI_KnightInfoPopTalentComp"))

function KnightInfoPopTalentComp:ctor()
	self._starTalentData = {}
	self._starTalentDataNum = 0
	self._advaceTalentData = {}
	self._advaceTalentDataNum = 0

	self.m_starUpList:setIniter()
	self.m_starUpList:setItemRenderer(handler(self, self._onStarUpItemRenderer))
	self.m_trainList:setIniter()
	self.m_trainList:setItemRenderer(handler(self, self._onTrainItemRenderer))
end

function KnightInfoPopTalentComp:updateShow(arg_2_1)
	self._starTalentDataNum, self._starTalentData = arg_2_1:getStarTalentData()

	self.m_starUpList:setNumItems(self._starTalentDataNum)
	self.m_starUpList:resizeToFit(self._starTalentDataNum)

	self._advaceTalentDataNum, self._advaceTalentData = arg_2_1:getAdvaceTalentData()

	self.m_trainList:setNumItems(self._advaceTalentDataNum)
	self.m_trainList:resizeToFit(self._advaceTalentDataNum)
end

function KnightInfoPopTalentComp:_onStarUpItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._starTalentData[arg_3_1 + 1])
end

function KnightInfoPopTalentComp:_onTrainItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._advaceTalentData[arg_4_1 + 1])
end

return KnightInfoPopTalentComp
