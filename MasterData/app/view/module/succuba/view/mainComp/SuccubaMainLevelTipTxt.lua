local SuccubaMainLevelTipTxt = class("SuccubaMainLevelTipTxt", require("app.fairyGUI.succuba.UI_SuccubaMainLevelTipTxt"))

function SuccubaMainLevelTipTxt:ctor()
	return
end

function SuccubaMainLevelTipTxt:updateTextUI(arg_2_1, arg_2_2)
	local var_2_0 = g.core.config.talent_skill_info.get(arg_2_1.talent)

	self:setTitle((g.core.lang:get(431003, {
		level = arg_2_1.level,
		name = arg_2_1.name
	})))
	self.m_desTxt:setText((g.core.lang:get(431004, {
		name = var_2_0.name,
		effectDes = var_2_0.description
	})))

	if arg_2_2 < arg_2_1.level then
		self.m_unlockTipTxt:setText(g.core.lang:get(431002, {
			level = arg_2_1.level
		}))
		self.m_isActiveController:setSelectedIndex(0)
	else
		self.m_isActiveController:setSelectedIndex(1)
	end
end

return SuccubaMainLevelTipTxt
