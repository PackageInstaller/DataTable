local KnightSoulSelectComp = class("KnightSoulSelectComp", require("app.fairyGUI.knightSoul.UI_KnightSoulSelectComp"))

function KnightSoulSelectComp:ctor()
	self._attrList = {}
	self._curSelectedAttr = 0
	self._btnSelectedAttr = 0

	self.m_attrList:setVirtual(self)
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
	self.m_attrList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickAttrBtn))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
end

function KnightSoulSelectComp:updateSelectComp(arg_2_1, arg_2_2)
	self._curSelectedAttr = arg_2_2
	self._attrList = arg_2_1 or {}

	self.m_attrList:setNumItems(#self._attrList)
end

function KnightSoulSelectComp:_onRenderAttrList(arg_3_1, arg_3_2)
	if self._attrList[arg_3_1 + 1] then
		arg_3_2:setTitle(self._attrList[arg_3_1 + 1].attrName)
	end
end

function KnightSoulSelectComp:_onClickAttrBtn(arg_4_1)
	self._btnSelectedAttr = self._attrList[arg_4_1:getDataValue() + 1].type
end

function KnightSoulSelectComp:_onClickConfirmBtn()
	if self._curSelectedAttr ~= self._btnSelectedAttr then
		self._curSelectedAttr = self._btnSelectedAttr

		self:dispatchCompEvent("select_attr_finish", {
			attrType = self._curSelectedAttr
		})
	end

	self:dispatchCompEvent("reset_screen_status")
end

return KnightSoulSelectComp
