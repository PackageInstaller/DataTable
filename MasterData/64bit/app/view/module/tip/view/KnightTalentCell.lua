local var_0_0 = g.core.const.ConstMgr.TipConst
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local KnightTalentCell = class("KnightTalentCell", require("app.fairyGUI.tip.UI_KnightTalentCell"))
local var_0_3 = g.core.lang

function KnightTalentCell:updateCell(arg_1_1, arg_1_2)
	if arg_1_1 and (arg_1_1.talentId or arg_1_1.skillId) and arg_1_1.value then
		if arg_1_1.talentId and arg_1_1.skillId then
			self.m_styleController:setSelectedIndex(2)
		elseif arg_1_1.skillId then
			self.m_styleController:setSelectedIndex(1)
		else
			self.m_styleController:setSelectedIndex(0)
		end

		if arg_1_1.talentId then
			self:_setTalent(arg_1_1)
		end

		if arg_1_1.skillId then
			self:_setPassive(arg_1_1)
		end

		if arg_1_2 == var_0_0.KnightTipType.STAR then
			self.m_nameTitle:setText(var_0_3:get(201310, {
				level = self._opValue
			}))
		elseif arg_1_2 == var_0_0.KnightTipType.RANK then
			self.m_nameTitle:setText(var_0_3:get(201311, {
				level = self._opValue
			}))
		elseif arg_1_2 == var_0_0.KnightTipType.WEDDING then
			self.m_nameTitle:setText(var_0_3:get(201313, {
				level = self._opValue
			}))
		end

		self:setAlpha(self._isActive and 1 or 0.3)
		self:refreshSize()
	end
end

function KnightTalentCell:_setTalent(arg_2_1)
	self.m_descText:setText("")

	local var_2_0 = g.core.config.talent_skill_info.get(arg_2_1.talentId)

	self.m_talentNameText:setText((var_0_3:get(201303, {
		name = var_2_0.name
	})))

	local var_2_1 = var_2_0.description

	self._isActive = arg_2_1.value >= var_2_0.open_value
	self._opValue = var_2_0.open_value

	self.m_talentUnLockTxt:setVisible(false)

	if var_2_1 == "0" then
		var_2_1 = var_0_3:get(201011)
	elseif not self._isActive then
		self.m_talentUnLockTxt:setVisible(true)

		if var_2_0.open_type == var_0_0.KnightTipType.STAR then
			self.m_talentUnLockTxt:setText(var_0_3:get(201300, {
				level = var_2_0.open_value
			}))
		elseif var_2_0.open_type == var_0_0.KnightTipType.RANK then
			self.m_talentUnLockTxt:setText(var_0_3:get(201301, {
				level = var_2_0.open_value
			}))
		elseif var_2_0.open_type == var_0_0.KnightTipType.WEDDING then
			self.m_talentUnLockTxt:setText(var_0_3:get(201314, {
				level = var_2_0.open_value
			}))
		end
	end

	self.m_descText:setText(var_2_1)
end

function KnightTalentCell:_setPassive(arg_3_1)
	self.m_skillDescTxt:setText("")

	local var_3_0 = g.core.config.passive_skill_info.get(arg_3_1.skillId)
	local var_3_1 = ""

	if not arg_3_1.passiveSkillType or arg_3_1.passiveSkillType == var_0_1.ADVANCE_PASSIVE_SKILL_TYPE.PASSIVE then
		var_3_1 = var_0_3:get(201308, {
			name = var_3_0.name
		})

		self.m_levelGroup:setVisible(true)
	elseif arg_3_1.passiveSkillType == var_0_1.ADVANCE_PASSIVE_SKILL_TYPE.BLOOD then
		var_3_1 = var_0_3:get(201315, {
			name = var_3_0.name
		})

		self.m_levelGroup:setVisible(false)
	end

	self.m_passiveNameText:setText(var_3_1)

	local var_3_2, var_3_3 = g.core.utils.String.formatPassiveSkillDesc(arg_3_1.skillId)

	self._isActive = arg_3_1.value >= arg_3_1.openValue
	self._opValue = arg_3_1.openValue

	self.m_skillUnLockTxt:setVisible(false)

	if var_3_2 == "0" then
		var_3_2 = var_0_3:get(201011)
	elseif not self._isActive then
		self.m_skillUnLockTxt:setVisible(true)

		if var_3_0.level == 1 then
			self.m_skillUnLockTxt:setText(var_0_3:get(201306, {
				level = arg_3_1.openValue
			}))
		else
			self.m_skillUnLockTxt:setText(var_0_3:get(201307, {
				level = arg_3_1.openValue
			}))
		end
	end

	var_3_2 = self._isActive and var_3_2 or g.core.utils.String.paintDescGreyColorful(var_3_2)

	self.m_skillDescTxt:setText(var_3_2)
	self.m_levelTxt:setText(var_0_3:get(201309, {
		level = var_3_0.level
	}))
end

function KnightTalentCell:refreshSize()
	local var_4_0 = self.m_styleController:getSelectedIndex()
	local var_4_1 = 90

	if var_4_0 == 0 then
		var_4_1 = self.m_descText:getPosition().y + self.m_descText:getHeight() + 4
	elseif var_4_0 == 1 then
		self.m_skillGroup:setPosition(cc.p(28, 31))

		var_4_1 = self.m_skillDescTxt:getPosition().y + self.m_skillDescTxt:getHeight() + 4
	else
		var_4_1 = self.m_skillDescTxt:getPosition().y + self.m_skillDescTxt:getHeight() + 4
	end

	var_4_1 = var_4_1 > 90 and var_4_1 or 90

	self:setHeight(var_4_1)
end

return KnightTalentCell
