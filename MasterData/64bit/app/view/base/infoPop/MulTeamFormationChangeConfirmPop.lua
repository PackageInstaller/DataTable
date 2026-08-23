local MulTeamFormationChangeComfirmPop = class("MulTeamFormationChangeComfirmPop", require("app.fairyGUI.infoPop.UI_MulTeamFormationChangeConfirmPop"), function()
	return fgui.GComponent:create({
		pkgName = "infoPop",
		resName = "MulTeamFormationChangeConfirmPop",
		pkgPath = "ui/infoPop/infoPop"
	}, ...)
end)

function MulTeamFormationChangeComfirmPop:ctor(arg_2_1)
	self._onClose = false
	self._onConfirm = arg_2_1.onConfirm
	self._itemDataArr = arg_2_1.itemDataArr or {}

	self:showAtCenter()
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancelBtn))

	if arg_2_1.isPreciousSuit then
		self.m_showStateController:setSelectedIndex(1)
		self.m_skillList:setVirtual(self)
		self.m_skillList:setItemRenderer(handler(self, self._onSkillListRenderer))
	else
		self.m_showStateController:setSelectedIndex(0)
		self.m_iconList:setVirtual(self)
		self.m_iconList:setItemRenderer(handler(self, self._onIconListRenderer))
	end

	self.m_tipTxt:setText(arg_2_1.desc or "")
end

function MulTeamFormationChangeComfirmPop:onLoad()
	if self.m_showStateController:getSelectedIndex() == 1 then
		self.m_skillList:setNumItems(#self._itemDataArr)
	else
		self.m_iconList:setNumItems(#self._itemDataArr)
	end
end

function MulTeamFormationChangeComfirmPop:_onClickConfirmBtn()
	if self._onClose then
		return
	end

	self._onClose = true

	if self._onConfirm then
		self._onConfirm()
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function MulTeamFormationChangeComfirmPop:_onClickCancelBtn()
	if not self._onClose then
		self._onClose = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function MulTeamFormationChangeComfirmPop:_onIconListRenderer(arg_6_1, arg_6_2)
	arg_6_2:getChild("teamNameTxt"):setText(self._itemDataArr[arg_6_1 + 1].teamName)
	arg_6_2:getChild("baseIcon"):updateIcon({
		type = self._itemDataArr[arg_6_1 + 1].type,
		value = self._itemDataArr[arg_6_1 + 1].value
	})
end

function MulTeamFormationChangeComfirmPop:_onSkillListRenderer(arg_7_1, arg_7_2)
	arg_7_2:getChild("teamNameTxt"):setText(self._itemDataArr[arg_7_1 + 1].teamName)
	arg_7_2:getChild("preciousSkill"):updateSuitIcon(0, self._itemDataArr[arg_7_1 + 1].groupId)
end

return MulTeamFormationChangeComfirmPop
