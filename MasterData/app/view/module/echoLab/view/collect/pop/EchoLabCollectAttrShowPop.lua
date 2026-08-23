local EchoLabCollectAttrShowPop = class("EchoLabCollectAttrShowPop", require("app.fairyGUI.echoLab.UI_EchoLabCollectAttrShowPop"), function()
	return fgui.GComponent:create({
		resName = "EchoLabCollectAttrShowPop",
		pkgPath = "ui/echoLab/echoLab",
		pkgName = "echoLab"
	})
end)

function EchoLabCollectAttrShowPop:ctor(arg_2_1)
	self._attrInfoList = arg_2_1

	self:_init()
	self:showAtCenter()
end

function EchoLabCollectAttrShowPop:_init()
	for iter_3_0, iter_3_1 in ipairs(self._attrInfoList) do
		local var_3_0 = fgui.UIPackage:createObject("echoLab", "EchoLabCollectAttrsComp")

		var_3_0:setTitle(iter_3_1.name)
		var_3_0:setProviderPath("ui://echoLab/EchoLabCollectMultiLineAttr")
		var_3_0:updateAttrs(iter_3_1.attrDesList)
		self.m_listComp:addItem(var_3_0)
	end

	if #self._attrInfoList < 1 then
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

return EchoLabCollectAttrShowPop
