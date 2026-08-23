local CommonTalentCell = class("CommonTalentCell", require("app.fairyGUI.tip.UI_CommonTalentCell"))

function CommonTalentCell:updateTalentCell(arg_1_1)
	if not arg_1_1 then
		return
	end

	local var_1_0 = arg_1_1.state or 0
	local var_1_1 = arg_1_1.titleType or 0
	local var_1_2 = arg_1_1.descType or 0
	local var_1_3 = arg_1_1.desc or ""

	self.m_stateController:setSelectedIndex(var_1_0)
	self.m_titleController:setSelectedIndex(var_1_1)
	self.m_descController:setSelectedIndex(var_1_2)

	if var_1_0 == 1 then
		var_1_3 = g.core.utils.String.paintDescGreyColorful(var_1_3)
	end

	if var_1_1 == 0 then
		self.m_titleText:setText(arg_1_1.title)
	else
		self.m_bigTitleText:setTitle(arg_1_1.title)
	end

	if var_1_2 == 0 then
		self.m_descText:enableRich()
		self.m_descText:setText(var_1_3 or "", true)
	else
		self.m_descText:setText(" ")

		local var_1_4 = arg_1_1.attrList or {}

		for iter_1_0 = 1, 2 do
			local var_1_5 = self["m_attrComp" .. iter_1_0]
			local var_1_6 = var_1_4[iter_1_0]

			if var_1_4[iter_1_0] then
				var_1_6.isGray = var_1_0 == 1

				var_1_5:setVisible(true)
				var_1_5:updateAttr(var_1_6)
			else
				var_1_5:setVisible(false)
			end
		end
	end
end

return CommonTalentCell
