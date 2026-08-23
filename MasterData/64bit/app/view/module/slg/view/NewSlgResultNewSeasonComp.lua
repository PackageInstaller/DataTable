local NewSlgResultNewSeasonComp = class("NewSlgResultNewSeasonComp", require("app.fairyGUI.newSlg.UI_NewSlgResultNewSeasonComp"))

function NewSlgResultNewSeasonComp:ctor()
	self._curSeasonDes = {}
	self._newSeasonDes = {}

	self.m_curSeasonList:setVirtual()
	self.m_curSeasonList:setItemRenderer(handler(self, self._onCurSeasonItemRender))
	self.m_newSeasonList:setVirtual()
	self.m_newSeasonList:setItemRenderer(handler(self, self._onNewSeasonItemRender))
end

function NewSlgResultNewSeasonComp:onLoad()
	self._curSeasonDes = self:_getHelpInfoArrById(368)

	self.m_curSeasonList:setNumItems(#self._curSeasonDes)

	self._newSeasonDes = self:_getHelpInfoArrById(369)

	self.m_newSeasonList:setNumItems(#self._newSeasonDes)
end

function NewSlgResultNewSeasonComp:_onCurSeasonItemRender(arg_3_1, arg_3_2)
	arg_3_2:setTitle(self._curSeasonDes[arg_3_1 + 1].text)
end

function NewSlgResultNewSeasonComp:_onNewSeasonItemRender(arg_4_1, arg_4_2)
	arg_4_2:setTitle(self._newSeasonDes[arg_4_1 + 1].text)
end

function NewSlgResultNewSeasonComp:_getHelpInfoArrById(arg_5_1)
	local var_5_0 = {}

	repeat
		local var_5_2 = g.core.config.help_text_info.fetch(arg_5_1, 1)

		if var_5_2 then
			table.insert(var_5_0, var_5_2)
		end
	until not var_5_2

	return var_5_0
end

return NewSlgResultNewSeasonComp
