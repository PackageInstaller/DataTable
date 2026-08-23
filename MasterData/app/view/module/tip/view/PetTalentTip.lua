local var_0_0 = g.core.config.pet_advance_info
local var_0_1 = g.core.config.talent_skill_info
local var_0_2 = g.core.config.passive_skill_info
local var_0_3 = g.core.config.parameter_info
local PetTalentTip = class("PetTalentTip", require("app.fairyGUI.tip.UI_PetTalentTip"), function()
	return fgui.GComponent:create({
		resName = "PetTalentTip",
		pkgPath = "ui/tip/tip",
		pkgName = "tip"
	})
end)

function PetTalentTip:ctor(arg_2_1)
	self._talentArr = self:_getTalentArr(arg_2_1)

	self:showAtCenter()
	self.m_talentList:setVirtual()
	self.m_talentList:setItemRenderer(handler(self, self._onTalentListRenderer))
end

function PetTalentTip:onLoad()
	self.m_talentList:setNumItems(#self._talentArr)
end

function PetTalentTip:_onTalentListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._talentArr[arg_4_1 + 1])
end

function PetTalentTip:_getTalentArr(arg_5_1)
	local var_5_0 = {}
	local var_5_1 = arg_5_1:getBigSmallStage()
	local var_5_2 = arg_5_1:getAdvanceId()
	local var_5_3 = 0
	local var_5_4 = var_0_3.get(19007).parameter

	for iter_5_0, iter_5_1 in var_0_0.ipairs() do
		local var_5_12

		if iter_5_1.advance_id == var_5_2 then
			local var_5_5
			local var_5_6
			local var_5_7
			local var_5_8
			local var_5_9

			if iter_5_1.talent_skill_1 > 0 and iter_5_1.node == 0 then
				local var_5_10 = var_0_1.get(iter_5_1.talent_skill_1)

				var_5_5 = var_5_10.name
				var_5_6 = var_5_10.description
			end

			if iter_5_1.skill_1 > 0 and iter_5_1.node == 0 then
				local var_5_11 = var_0_2.get(iter_5_1.skill_1)

				var_5_7 = var_5_11.name
				var_5_9 = var_5_11.level
				var_5_8 = g.core.utils.String.formatPassiveSkillDesc(iter_5_1.skill_1)

				if 0 ~= iter_5_1.skill_1 then
					var_5_12 = iter_5_1.skill_1
				else
					var_5_7 = ""
				end
			end

			if var_5_5 or var_5_7 then
				local var_5_13 = {
					stage = iter_5_1.stage,
					active = var_5_1 >= iter_5_1.stage,
					talentName = var_5_5,
					talentDesc = var_5_6,
					passiveName = var_5_7,
					passiveLv = var_5_9,
					passiveDesc = var_5_8
				}

				if not var_5_13.active then
					var_5_3 = var_5_3 + 1
				end

				if var_5_3 <= var_5_4 then
					table.insert(var_5_0, var_5_13)
				end
			end
		end
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		return arg_6_0.stage < arg_6_1.stage
	end)

	return var_5_0
end

return PetTalentTip
