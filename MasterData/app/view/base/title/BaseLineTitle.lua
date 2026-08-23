local BaseLineTitle = class("BaseLineTitle", require("app.fairyGUI.base.UI_BaseLineTitle"))

function BaseLineTitle:updateOutline(arg_1_1)
	local var_1_1

	if arg_1_1 then
		if arg_1_1 then
			var_1_1 = arg_1_1.text or ""

			if arg_1_1.outline or false then
				self.m_title:enableOutline(2, g.core.common.Color.newOutline)

				goto label_1_0
			end
		end
	end

	self.m_title:enableOutline(0, g.core.common.Color.newOutline)

	::label_1_0::

	if var_1_1 ~= "" then
		self:setTitle(var_1_1)
	end
end

return BaseLineTitle
