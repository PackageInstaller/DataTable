local BaseEquipSuitSkillCell = class("BaseEquipSuitSkillCell", require("app.fairyGUI.base_new.UI_BaseEquipSuitSkillCell"))

function BaseEquipSuitSkillCell:ctor()
	return
end

function BaseEquipSuitSkillCell:update(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1.skillInfo then
		local var_2_0 = arg_2_1.skillInfo
		local var_2_1 = arg_2_1.curSuitNum
		local var_2_2 = arg_2_1.targetSuitNum

		if arg_2_1.curSuitNum and var_2_2 then
			self.m_activeController:setSelectedIndex(var_2_2 <= var_2_1 and 0 or 1)
			self.m_skillNumTxt:setText(g.core.lang:get(201616, {
				num = math.min(var_2_1, var_2_2),
				max = var_2_2
			}))
		else
			self.m_skillNumTxt:setText("")
		end

		self.m_skillNameTxt:setText(var_2_0.name)

		local var_2_3, var_2_4 = g.core.utils.String.formatPassiveSkillDesc(var_2_0.id)

		var_2_3 = var_2_2 <= var_2_1 and var_2_3 or g.core.utils.String.paintDescGreyColorful(var_2_3)

		self.m_descTxt:getChild("title"):enableRich()
		self.m_descTxt:setTitle(var_2_3)

		if var_2_0.icon then
			self.m_skillIconComp:updateIcon({
				isPassive = true,
				skillId = var_2_0.id,
				icon = var_2_0.icon
			})
		end
	end
end

function BaseEquipSuitSkillCell:onLoad()
	return
end

function BaseEquipSuitSkillCell:onUnload()
	return
end

return BaseEquipSuitSkillCell
