local var_0_0 = g.core.const.ConstMgr.TipConst
local var_0_1 = g.core.model.User.equipmentData
local EquipMagicalStageTalentCell = class("EquipMagicalStageTalentCell", require("app.fairyGUI.tip.UI_EquipMagicalStageTalentCell"))
local var_0_3 = g.core.lang

function EquipMagicalStageTalentCell:updateCell(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.m_styleController:setSelectedIndex(arg_1_2)

	local var_1_0 = g.core.config.talent_skill_info.get(arg_1_1.talentId)

	self.m_talentNameText:setText((var_0_3:get(201303, {
		name = var_1_0.name
	})))

	local var_1_1 = var_1_0.description

	self:setAlpha(arg_1_1.isActive and 1 or 0.3)
	self.m_talentUnLockTxt:setVisible(not arg_1_1.isActive)

	if var_1_1 == 0 then
		var_1_1 = var_0_3:get(201011)
	end

	self.m_descText:setText(var_1_1)

	if arg_1_2 == var_0_0.EquipMagicalTipType.ONE then
		self.m_nameTitle:setText(var_0_3:get(201657, {
			name = arg_1_4.name,
			level = arg_1_1.stage
		}))

		if not arg_1_1.isActive then
			self.m_talentUnLockTxt:setText(var_0_3:get(201653, {
				level = arg_1_1.stage
			}))
		end
	else
		arg_1_4 = var_0_1:getSuitStageInfoBySuitIdAndStage(arg_1_1.suitId, arg_1_1.stage)

		local var_1_2 = g.core.config.equipment_suit_info.get(arg_1_1.suitId)

		arg_1_3 = arg_1_3 or 0

		if arg_1_2 == var_0_0.EquipMagicalTipType.TWO then
			self.m_nameTitle:setText(var_0_3:get(201658, {
				name = arg_1_4.talent_name_1,
				level = arg_1_1.stage,
				own = math.min(arg_1_3, 2)
			}))

			if not arg_1_1.isActive then
				self.m_talentUnLockTxt:setText(var_0_3:get(201673, {
					name = var_1_2.name,
					level = arg_1_1.stage
				}))
			end
		else
			self.m_nameTitle:setText(var_0_3:get(201659, {
				name = arg_1_4.talent_name_2,
				level = arg_1_1.stage,
				own = math.min(arg_1_3, 4)
			}))

			if not arg_1_1.isActive then
				self.m_talentUnLockTxt:setText(var_0_3:get(201674, {
					name = var_1_2.name,
					level = arg_1_1.stage
				}))
			end
		end
	end
end

return EquipMagicalStageTalentCell
