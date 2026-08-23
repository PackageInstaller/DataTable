local var_0_0 = g.core.model.User.echoLabData
local EchoLabTreeAttrPop = class("EchoLabTreeAttrPop", require("app.fairyGUI.echoLab.UI_EchoLabTreeAttrPop"), function()
	return fgui.GComponent:create({
		resName = "EchoLabTreeAttrPop",
		pkgPath = "ui/echoLab/echoLab",
		pkgName = "echoLab"
	})
end)

function EchoLabTreeAttrPop:ctor()
	self:showAtCenter()

	self._attrList = {}

	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrRender))
end

function EchoLabTreeAttrPop:_onAttrRender(arg_3_1, arg_3_2)
	arg_3_2:updateAttr(self._attrList[arg_3_1 + 1])
end

function EchoLabTreeAttrPop:onLoad()
	self._attrList = {}

	for iter_4_0, iter_4_1 in pairs((var_0_0:getTreeData():getAllActiveAttrList())) do
		table.insert(self._attrList, {
			isAll = true,
			type = iter_4_0,
			value = iter_4_1
		})
	end

	if #self._attrList > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_attrList:setNumItems(#self._attrList)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

return EchoLabTreeAttrPop
