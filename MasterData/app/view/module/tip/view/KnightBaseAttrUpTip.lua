local KnightBaseAttrUpTip = class("KnightBaseAttrUpTip", require("app.fairyGUI.tip.UI_KnightBaseAttrUpTip"), function()
	return fgui.GComponent:create({
		resName = "KnightBaseAttrUpTip",
		pkgPath = "ui/tip/tip",
		pkgName = "tip"
	})
end)
local var_0_1 = g.core.model.User.knightsData

KnightBaseAttrUpTip.ATTR_UP_STATE = {
	ADVANCE_UP = 1,
	STAR_UP = 0
}

function KnightBaseAttrUpTip:ctor(arg_2_1)
	self._data = arg_2_1

	self:getView():center(true)
	self.m_attrList:setIniter()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrRenderer))
end

function KnightBaseAttrUpTip:onLoad()
	self:updateComp(self._data)
end

function KnightBaseAttrUpTip:updateComp(arg_4_1)
	local var_4_0 = var_0_1:getKnight({
		id = arg_4_1.knightSid
	})
	local var_4_1 = false

	if arg_4_1.type == self.ATTR_UP_STATE.ADVANCE_UP then
		self._data, var_4_1 = var_4_0:getCurAdvanceAttr()
	else
		self._data, var_4_1 = var_4_0:getNextStarAttr()
	end

	if var_4_1 then
		self.m_isMaxController:setSelectedIndex(1)

		for iter_4_0 = 1, 4 do
			if self["m_attr" .. iter_4_0] and self["m_attr" .. iter_4_0].updateCell then
				self._data[iter_4_0].showAdd = true

				self["m_attr" .. iter_4_0]:updateCell(self._data[iter_4_0])
			end
		end
	else
		self.m_isMaxController:setSelectedIndex(0)
		self.m_attrList:setNumItems(#self._data)
	end
end

function KnightBaseAttrUpTip:_onAttrRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._data[arg_5_1 + 1])
end

return KnightBaseAttrUpTip
