local var_0_0 = g.core.config.help_text_info
local LoginStageLevelPop = class("LoginStageLevelPop", require("app.fairyGUI.login.UI_LoginStageLevelPop"), function()
	return fgui.GComponent:create({
		resName = "LoginStageLevelPop",
		pkgPath = "ui/login/login",
		pkgName = "login"
	})
end)
local var_0_2 = 100001

function LoginStageLevelPop:ctor()
	self:showAtCenter()
	self:_initView(var_0_2)
end

function LoginStageLevelPop:_initView(arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = var_0_0:fetch(1)

	if var_3_0 then
		self.m_popPanel:setTitle(var_3_0.name)
		self.m_stageTipsTxt:setText(var_3_0.text, true)
	end
end

return LoginStageLevelPop
