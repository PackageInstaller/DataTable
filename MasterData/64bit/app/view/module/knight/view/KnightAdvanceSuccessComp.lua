local KnightAdvanceSuccessComp = class("KnightAdvanceSuccessComp", require("app.fairyGUI.knight.UI_KnightAdvanceSuccessComp"))
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.config.knight_advance_info
local var_0_3 = g.core.config.talent_skill_info
local var_0_4 = g.core.config.passive_skill_info
local var_0_5 = g.core.const.ConstMgr.QUALITY_TYPE

function KnightAdvanceSuccessComp:ctor()
	return
end

function KnightAdvanceSuccessComp:update(arg_2_1)
	local var_2_0

	if arg_2_1 ~= nil then
		if arg_2_1.knightAdvId then
			var_2_0 = var_0_1:getKnight({
				advance_id = arg_2_1.knightAdvId
			})
		elseif arg_2_1.knight then
			var_2_0 = arg_2_1.knight
		elseif arg_2_1.knightId then
			var_2_0 = var_0_1:getKnight({
				base_id = arg_2_1.knightId
			})
		elseif arg_2_1.knightSid then
			var_2_0 = var_0_1:getKnight({
				id = arg_2_1.knightSid
			})
		end
	end

	if var_2_0 then
		local var_2_1 = var_2_0:getBaseInfo()
		local var_2_3 = var_0_1:getKnightAdvLevelBySid((var_2_0:getServerId()))

		if var_2_1.promote_code <= 0 or var_2_3 <= 0 then
			return nil
		end

		local var_2_4 = var_0_2:get((math.max(var_2_3 - 1, 1)))

		self.m_lastLevelText:setText(var_2_4.stage)
		self.m_levelText:setText(var_2_4.stage + 1)

		local var_2_5 = var_2_0:getAdvaceAttrs()

		for iter_2_0 = 1, 4 do
			if var_2_4["affect_type_" .. iter_2_0] and var_2_4["affect_value_" .. iter_2_0] and var_2_5[var_2_4["affect_type_" .. iter_2_0]] then
				self["m_attr" .. iter_2_0]:updateAttr({
					type = var_2_4["affect_type_" .. iter_2_0],
					value = var_2_5[var_2_4["affect_type_" .. iter_2_0]] - var_2_4["affect_value_" .. iter_2_0],
					value2 = var_2_5[var_2_4["affect_type_" .. iter_2_0]]
				})
			end
		end

		if var_2_1.quality == var_0_5.UR then
			self.m_skillType:setText(g.core.lang:get(205541))
		end

		local var_2_6 = var_2_1["promote_talent_" .. var_2_4.stage + 1]
		local var_2_7 = var_2_1["promote_passive_" .. var_2_4.stage + 1 .. "_1"]

		if var_2_1["promote_talent_" .. var_2_4.stage + 1] > 0 or var_2_7 > 0 then
			if var_2_6 > 0 and var_2_7 > 0 then
				self.m_styleController:setSelectedIndex(2)
			elseif var_2_7 > 0 then
				self.m_styleController:setSelectedIndex(1)
			else
				self.m_styleController:setSelectedIndex(0)
			end

			local var_2_8 = {}

			if var_2_7 > 0 then
				local var_2_9 = var_0_4.get(var_2_7)
				local var_2_10, var_2_11 = g.core.utils.String.formatPassiveSkillDesc(var_2_7)

				var_2_8.level = var_2_9.level
				var_2_8.name = var_2_9.name
				var_2_8.desc = var_2_10
				var_2_8.buffDesc = var_2_11

				self.m_skillComp:updateComp(var_2_8)
			end

			if var_2_6 > 0 then
				local var_2_12 = var_0_3.get(var_2_6)

				var_2_8.name = var_2_12.name
				var_2_8.desc = var_2_12.description

				self.m_talentComp:updateComp(var_2_8)
			end
		else
			self.m_styleController:setSelectedIndex(3)
		end
	end
end

return KnightAdvanceSuccessComp
