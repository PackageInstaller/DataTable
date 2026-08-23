local SuccubaPopTalentChildComp = class("SuccubaPopTalentChildComp", require("app.fairyGUI.succuba.UI_SuccubaPopTalentChildComp"))

function SuccubaPopTalentChildComp:ctor()
	self._descList = {}

	self:_initListView()
end

function SuccubaPopTalentChildComp:_initListView()
	self.m_descList:setIniter()
	self.m_descList:setItemRenderer(handler(self, self._onRenderDescList))
end

function SuccubaPopTalentChildComp:_onRenderDescList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._descList[arg_3_1 + 1])
end

function SuccubaPopTalentChildComp:updateComp(arg_4_1)
	self._descList = arg_4_1

	self.m_descList:setNumItems(#self._descList)
	self.m_descList:resizeToFit(#self._descList)
end

return SuccubaPopTalentChildComp
