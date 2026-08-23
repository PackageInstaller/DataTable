local var_0_0 = g.core.config.ksoul_honor_info
local var_0_1 = g.core.model.User.knightSoulData
local KnightSoulAchievementActiveComp = class("KnightSoulAchievementActiveComp", require("app.fairyGUI.knightSoul.UI_KnightSoulAchievementActiveComp"))

function KnightSoulAchievementActiveComp:ctor()
	self._attrs = {}
end

function KnightSoulAchievementActiveComp:update(arg_2_1)
	self._params = arg_2_1.data or {}

	local var_2_0 = self._params.id
	local var_2_1 = var_0_0.get(self._params.id)

	if var_2_1.type ~= 1 then
		self.m_bigPointController:setSelectedIndex(0)

		if var_2_1.type == 2 then
			self.m_exDescTxt:setText(var_2_1.if_unlock_chapter)
		elseif var_2_1.type == 3 then
			self.m_exDescTxt:setText(var_2_1.unlock_chapter_star)
		end
	else
		self.m_bigPointController:setSelectedIndex(1)
	end

	local var_2_2 = var_0_1:getKnightSoulHonorAttr(var_2_0)

	if var_2_2 then
		self._attrs = var_2_2.attrList or {}
	end

	self.m_attrList:updateAttributes(nil, self._attrs)
end

function KnightSoulAchievementActiveComp:_onAttrRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateAttr({
		type = self._attrs[arg_3_1 + 1].attrType,
		value = self._attrs[arg_3_1 + 1].attrValue
	})
end

return KnightSoulAchievementActiveComp
