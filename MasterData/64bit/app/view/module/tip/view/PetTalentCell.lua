local var_0_0 = g.core.lang
local PetTalentCell = class("PetTalentCell", require("app.fairyGUI.tip.UI_PetTalentCell"))

function PetTalentCell:updateCell(arg_1_1)
	self.m_titleTxt:setText(var_0_0:get(201311, {
		level = arg_1_1.stage
	}))

	if #(arg_1_1.talentName or "") > 0 then
		self.m_talentNameTxt:setText((var_0_0:get(201303, {
			name = arg_1_1.talentName
		})))
		self.m_talentDescTxt:setText(arg_1_1.talentDesc)
		self.m_showTalentController:setSelectedIndex(1)
	else
		self.m_showTalentController:setSelectedIndex(0)
	end

	if #(arg_1_1.passiveName or "") > 0 then
		self.m_passiveNameTxt:setText((var_0_0:get(201308, {
			name = arg_1_1.passiveName
		})))
		self.m_levelTxt:setText(var_0_0:get(201309, {
			level = arg_1_1.passiveLv
		}))
		self.m_passiveDescTxt:setText((arg_1_1.active or nil) and (arg_1_1.passiveDesc or g.core.utils.String.paintDescGreyColorful(arg_1_1.passiveDesc)))
		self.m_showPassiveController:setSelectedIndex(1)
		self:setHeight(150 + self.m_passiveDescTxt:getHeight() - 26)
	else
		self:setHeight(90)
		self.m_showPassiveController:setSelectedIndex(0)
	end

	if arg_1_1.active then
		self:setAlpha(1)
		self.m_activeController:setSelectedIndex(1)
	else
		self:setAlpha(0.3)

		local var_1_0 = var_0_0:get(201306, {
			level = arg_1_1.stage
		})

		self.m_talentUnlockTxt:setText(var_1_0)
		self.m_passiveUnlockTxt:setText(var_1_0)
		self.m_activeController:setSelectedIndex(0)
	end
end

function PetTalentCell:_resetHeight()
	self:setHeight(self.m_contentGroup:getY() + self.m_contentGroup:getHeight())
end

return PetTalentCell
