local var_0_0 = g.core.const.ConstMgr.EasterEggConst
local EasterEggTalkComp = class("EasterEggTalkComp", require("app.fairyGUI.easterEgg.UI_EasterEggTalkComp"))

function EasterEggTalkComp:ctor()
	self._talkListStr = {}

	self.m_talkList:setVirtual()
	self.m_talkList:setItemRenderer(handler(self, self._onRendererTalkList))
end

function EasterEggTalkComp:_onRendererTalkList(arg_2_1, arg_2_2)
	arg_2_2:update(self._talkListStr[arg_2_1 + 1], handler(self, self._onSelectCell))
end

function EasterEggTalkComp:_onSelectCell(arg_3_1)
	self:dispatchCompEvent("EasterEggTalkComp_selectId", {
		index = arg_3_1
	})
end

function EasterEggTalkComp:setTalkList(arg_4_1)
	self._talkListStr = {}

	for iter_4_0 = 1, var_0_0.TALK_NUM do
		if arg_4_1["talk" .. iter_4_0] and arg_4_1["talk" .. iter_4_0] ~= "" then
			table.insert(self._talkListStr, {
				index = iter_4_0,
				talkStr = arg_4_1["talk" .. iter_4_0]
			})
		end
	end

	self.m_talkList:setNumItems(#self._talkListStr)
end

return EasterEggTalkComp
