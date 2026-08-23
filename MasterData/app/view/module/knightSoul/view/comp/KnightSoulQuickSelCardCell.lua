local KnightSoulQuickSelCardCell = class("KnightSoulQuickSelCardCell", require("app.fairyGUI.knightSoul.UI_KnightSoulQuickSelCardCell"))

function KnightSoulQuickSelCardCell:ctor()
	return
end

function KnightSoulQuickSelCardCell:updateCell(arg_2_1)
	local var_2_0 = g.core.config.ksoul_info.fetch(arg_2_1)

	if var_2_0 then
		self.m_kSoulIcon:updateIcon({
			overrideClick = true,
			type = g.core.const.ConstMgr.BAG_TYPE.KSOUL,
			value = arg_2_1
		})
		self.m_nameText:setText(var_2_0.name)
	end
end

return KnightSoulQuickSelCardCell
