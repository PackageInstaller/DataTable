local TipConst = require("app.view.module.tip.const.TipConst")
local KnightAttrTip = class("KnightAttrTip", require("app.fairyGUI.tip.UI_KnightAttrTip"), function()
	return fgui.GComponent:create({
		pkgName = "tip",
		pkgPath = "ui/tip/tip",
		resName = "KnightAttrTip"
	})
end)

function KnightAttrTip:ctor(arg_2_1)
	self:getView():center(true)

	self._data = arg_2_1
	self._expandType = nil

	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))

	self._initialY = self.m_attrExpandComp:getY()
end

function KnightAttrTip:onLoad()
	self:updateComp(self._data)
end

function KnightAttrTip:updateComp(arg_4_1)
	self.m_attrComp:updateComp(arg_4_1)
end

function KnightAttrTip:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "KnightAttrExpandClick" then
		local var_5_0 = self:getView():displayObject()
		local var_5_1 = var_5_0:convertToNodeSpace(arg_5_2.pos)
		local var_5_2

		if self:getView().getSize(var_5_0).height - 30 >= var_5_1.y + self.m_attrExpandComp:getSize().height then
			var_5_2 = var_5_1
		end

		self:_showAttrsExpandComp(arg_5_2.type, (var_5_2 or nil) and (var_5_2.y or nil))
	end
end

function KnightAttrTip:_showAttrsExpandComp(arg_6_1, arg_6_2)
	local var_6_0 = self.m_isShowExpandController:getSelectedIndex() == 1

	if not var_6_0 or self._expandType ~= arg_6_1 then
		self.m_isShowExpandController:setSelectedIndex(var_6_0 and 0 or 1)

		self._expandType = arg_6_1

		self.m_attrExpandComp:showAttrsExpand({
			attrType = arg_6_1,
			attrData = self.m_attrComp:getObjAttrByType(arg_6_1)
		})

		if arg_6_2 then
			self.m_attrExpandComp:setY(arg_6_2)
		else
			self.m_attrExpandComp:setY(self._initialY)
		end
	end
end

function KnightAttrTip:_onTouchEnd(arg_7_1)
	if self.m_attrExpandComp:containPoint((arg_7_1:getInput():getTouch():getLocation())) then
		return
	end

	if self.m_attrExpandComp and self.m_isShowExpandController:getSelectedIndex() == 1 then
		self.m_isShowExpandController:setSelectedIndex(0)
	end
end

return KnightAttrTip
