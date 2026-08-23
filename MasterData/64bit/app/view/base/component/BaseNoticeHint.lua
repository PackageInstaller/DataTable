local BaseNoticeHint = class("BaseNoticeHint", require("app.fairyGUI.base_new.UI_BaseNoticeHint"), function()
	return fgui.GComponent:create({
		resName = "BaseNoticeHint",
		pkgName = "base_new",
		pkgPath = "ui/base_new/base_new"
	})
end)

function var_0_0:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = self.m_title

	self.m_title:setText(arg_2_1.strHint or "")

	if arg_2_1.fontSize then
		var_2_0:setFontSize(arg_2_1.fontSize)
	end
end

return var_0_0
