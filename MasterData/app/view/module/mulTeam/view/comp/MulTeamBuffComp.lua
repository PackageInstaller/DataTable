local var_0_0 = g.core.model.User.towerData
local MulTeamBuffComp = class("MulTeamBuffComp", require("app.fairyGUI.mulTeam.UI_MulTeamBuffComp"))

function MulTeamBuffComp:updateComp(arg_1_1)
	self.m_buffGroup:getChild("buffDesc"):setText(arg_1_1.details_2)

	local var_1_0 = var_0_0:getTowerBuffInfo(arg_1_1.stage_type)

	if var_1_0 then
		self.m_buffServer:setVisible(true)
		self.m_buffServer:getChild("buffDesc"):setText(var_1_0.description)
	else
		self.m_buffServer:setVisible(false)
	end

	self.m_buffActivity:setVisible(false)

	local var_1_1, var_1_2 = var_0_0:getCurTowerIdByType(arg_1_1.stage_type)
	local var_1_3 = var_0_0:getCapacityAddListDataById(var_1_1, var_1_2)

	self.m_showTitleGroup:setVisible(var_1_3[1] ~= nil)

	for iter_1_0 = 1, 4 do
		local var_1_4 = var_1_3[iter_1_0]
		local var_1_5 = self["m_addRes" .. iter_1_0]

		if self["m_addRes" .. iter_1_0] then
			var_1_5:update(var_1_4, false)
			var_1_5:setVisible(var_1_4 ~= nil)
		elseif var_1_4 then
			local var_1_6 = fgui.UIPackage:createObject("mulTeam", "MulTeamTowerResComp")

			self["m_addRes" .. iter_1_0] = var_1_6

			var_1_6:update(var_1_4, false)
			self:addChild(var_1_6)
			var_1_6:setGroup(self.m_resGroup)
		end
	end
end

return MulTeamBuffComp
