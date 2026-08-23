local CommonAttrPop = class("CommonAttrPop", require("app.fairyGUI.tip.UI_CommonAttrPop"), function()
	return fgui.GComponent:create({
		pkgName = "tip",
		pkgPath = "ui/tip/tip",
		resName = "CommonAttrPop"
	})
end)

function CommonAttrPop:ctor(arg_2_1)
	self._attrData = arg_2_1 or {}

	self:showAtCenter()
end

function CommonAttrPop:onLoad()
	self:updateView()
end

function CommonAttrPop:updateView()
	local var_4_0 = self._attrData.isMax
	local var_4_1 = self._attrData.attrList or {}

	for iter_4_0 = 1, 5 do
		if var_4_1[iter_4_0] then
			self["m_attrComp" .. iter_4_0]:setVisible(true)
			self["m_attrComp" .. iter_4_0]:updateAttrComp(var_4_1[iter_4_0], var_4_0)
		else
			self["m_attrComp" .. iter_4_0]:setVisible(false)
		end
	end

	if self._attrData.title then
		self.m_bgPanel:setTitle(self._attrData.title)
	end

	self.m_isMaxController:setSelectedIndex(var_4_0 and 1 or 0)
end

return CommonAttrPop
