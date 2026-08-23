local var_0_0 = g.core.model.User.knightSoulData
local var_0_1 = g.core.config.ksoul_info
local InfoKnightSoulComp = class("InfoKnightSoulComp", require("app.fairyGUI.infoPop.UI_InfoKnightSoulComp"))

function InfoKnightSoulComp:ctor()
	self._belongToBookList = {}

	self.m_bookNameList:setVirtual()
	self.m_bookNameList:setItemRenderer(handler(self, self._onRenderBookNameList))
	self.m_bookList:setVirtual()
	self.m_bookList:setItemRendererAsync1(handler(self, self._onRenderBookList), 0.08, true)
	self.m_bookList:setScrollEnabled(false)
end

function InfoKnightSoulComp:updateShow(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = var_0_1.fetch(arg_2_1.value)

	if var_2_0 then
		self.m_desc:setTitle(var_2_0.description)
	end

	self._belongToBookList = var_0_0:getKnightSoulBelongToBookId(arg_2_1.value)

	self.m_bookNameList:setNumItems(#self._belongToBookList)
	self.m_activateTxt:setText(g.core.lang:get(410616, {
		num = #var_0_0:getKsoulActivatedBookIds(arg_2_1.value)
	}))
	self.m_bookList:setNumItems(#self._belongToBookList)
end

function InfoKnightSoulComp:_onRenderBookNameList(arg_3_1, arg_3_2)
	local var_3_0 = var_0_0:getBookById(self._belongToBookList[arg_3_1 + 1])

	arg_3_2:setTitle(var_3_0:getName())
	arg_3_2:setCtrlState("isActivate", {
		index = var_3_0:isActivate() and 1 or 0
	})
end

function InfoKnightSoulComp:_onRenderBookList(arg_4_1, arg_4_2)
	arg_4_2:updateBookCell((var_0_0:getBookById(self._belongToBookList[arg_4_1 + 1])))
end

return InfoKnightSoulComp
