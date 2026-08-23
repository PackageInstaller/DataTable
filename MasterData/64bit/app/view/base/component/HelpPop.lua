local HelpPop = class("HelpPop", require("app.fairyGUI.base.UI_BaseHelpPop"), function()
	return fgui.GComponent:create({
		resName = "BaseHelpPop",
		pkgName = "base"
	})
end)
local var_0_1 = g.core.config.help_text_info

function HelpPop:ctor(arg_2_1)
	self:showAtCenter()

	if arg_2_1 and arg_2_1.id then
		self:_initView(arg_2_1.id, arg_2_1.title)
	end
end

function HelpPop:_initView(arg_3_1, arg_3_2)
	if not arg_3_1 then
		return
	end

	if arg_3_2 then
		self.m_title:setText(arg_3_2)
	end

	local var_3_0 = {}

	repeat
		local var_3_2 = var_0_1.fetch(arg_3_1, 1)

		if var_3_2 then
			table.insert(var_3_0, var_3_2)
		end
	until not var_3_2

	if #var_3_0 > 0 then
		self.m_textList:setVirtual(self)
		self.m_textList:setItemRenderer(function(arg_4_0, arg_4_1)
			if var_3_0[arg_4_0 + 1] then
				arg_4_1:getChild("titleLabel"):setText(var_3_0[arg_4_0 + 1].name, true)

				local var_4_0 = arg_4_1:getChild("descTxt")

				var_4_0:enableRich()
				var_4_0:setText(var_3_0[arg_4_0 + 1].text, true)
			end
		end)
		self.m_textList:setNumItems(#var_3_0)
		self.m_textList:scrollToView(0)
	end
end

return HelpPop
