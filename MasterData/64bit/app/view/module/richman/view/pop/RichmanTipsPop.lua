local var_0_0 = g.core.config.richman_event_text_info
local RichmanTipsPop = class("RichmanTipsPop", require("app.fairyGUI.richman.UI_RichmanTipsPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/richman/richman",
		resName = "RichmanTipsPop",
		pkgName = "richman"
	})
end)

function RichmanTipsPop:ctor()
	self:showAtCenter()
	self.m_tipsList:setVirtual()
	self.m_tipsList:setItemRenderer(handler(self, self._onTipsRenderer))
	self.m_tipsList:setNumItems(var_0_0.getLength())
end

function RichmanTipsPop:_onTipsRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateRichmanTipsCell(arg_3_1 + 1)
end

return RichmanTipsPop
