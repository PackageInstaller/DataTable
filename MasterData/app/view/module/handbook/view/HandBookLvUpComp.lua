local HandBookLvUpComp = class("HandBookLvUpComp", require("app.fairyGUI.handBook.UI_HandBookLvUpComp"))

function HandBookLvUpComp:ctor()
	self._attrList = {}

	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrRenderer))
end

function HandBookLvUpComp:update(arg_2_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = g.core.const.ConstMgr.BaseShowTypeConst.HAND_BOOK_ACHIEVEMENT
		}
	})

	local var_2_0 = g.core.model.User.handBookData:getCurScoreInfo(arg_2_1.data.oldScore) or {
		id = 0
	}
	local var_2_1 = g.core.model.User.handBookData:getCurScoreInfo()

	self._attrList = {}

	for iter_2_0, iter_2_1 in pairs((g.core.model.User.handBookData:getChangeAttrs(var_2_0.id, var_2_1.id))) do
		table.insert(self._attrList, {
			type = iter_2_0,
			value = iter_2_1
		})
	end

	self.m_lvTxt1:setText(var_2_0.id)
	self.m_lvTxt2:setText(var_2_1.id)
	self.m_attrList:setNumItems(#self._attrList)
end

function HandBookLvUpComp:_onAttrRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateAttr({
		isAll = true,
		withoutPlus1 = false,
		type = self._attrList[arg_3_1 + 1].type,
		value = self._attrList[arg_3_1 + 1].value
	})
end

function HandBookLvUpComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FIGHT_VALUE_CHANGE)
end

return HandBookLvUpComp
