local NewSlgBossInviteCell = class("NewSlgBossInviteCell", require("app.fairyGUI.newSlg.UI_NewSlgBossInviteCell"))

function NewSlgBossInviteCell:ctor()
	self._compUserIcon = self:getChild("Comp_userIcon")
	self._compName = self:getChild("Comp_name")
	self._btnInvite = self:getChild("Btn_invite")

	self._btnInvite:addClickListener(handler(self, self._onClickBtnInvite))

	self._txtLegionDesc = self:getChild("Txt_legionDesc")
	self._txtLegionName = self:getChild("legion_name")
	self._txtFightValue = self:getChild("fight_value")
end

function NewSlgBossInviteCell:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self._user = arg_2_1

	self._compUserIcon:updateAsUser(arg_2_1)
	self._compName:setText(arg_2_1.name)
	self._txtLegionName:setText(arg_2_1.alliance_name)
	self._txtFightValue:setText(arg_2_1.fight_value)
	self.m_isInvitedController:setSelectedIndex(arg_2_2 and 1 or 0)
end

function NewSlgBossInviteCell:_onClickBtnInvite()
	self:dispatchCompEvent("NewSlgBossInviteCell_onClickBtnInvite", {
		user = self._user
	})
end

return NewSlgBossInviteCell
