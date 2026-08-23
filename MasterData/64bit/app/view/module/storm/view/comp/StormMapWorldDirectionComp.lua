local StormMapWorldDirectionComp = class("StormMapWorldDirectionComp", require("app.fairyGUI.storm.UI_StormMapWorldDirectionComp"))

function StormMapWorldDirectionComp:updateGuideClue(arg_1_1, arg_1_2, arg_1_3)
	self.m_directionIconClue:setVisible(arg_1_1)

	if arg_1_1 then
		self.m_directionIconClue:setRotation(arg_1_2)
		self.m_posClueController:setSelectedIndex(arg_1_3 or 0)
	end
end

function StormMapWorldDirectionComp:updateGuideBox(arg_2_1, arg_2_2, arg_2_3)
	self.m_directionIconBox:setVisible(arg_2_1)

	if arg_2_1 then
		self.m_directionIconBox:getChild("n0"):setRotation(arg_2_2 + 50)
		self.m_posBoxController:setSelectedIndex(arg_2_3 or 0)
	end
end

function StormMapWorldDirectionComp:updateGuideMonster(arg_3_1, arg_3_2, arg_3_3)
	self.m_directionIconMonster:setVisible(arg_3_1)

	if arg_3_1 then
		self.m_directionIconMonster:getChild("n0"):setRotation(arg_3_2 + 50)
		self.m_posMonsterController:setSelectedIndex(arg_3_3 or 0)
	end
end

return StormMapWorldDirectionComp
