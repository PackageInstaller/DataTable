local NewSlgBossTeamInvitedPop = class("NewSlgBossTeamInvitedPop", function()
	return fgui.GComponent:create({
		resName = "NewSlgBossTeamInvitedPop",
		pkgName = "newSlg",
		pkgPath = "ui/newSlg/newSlg"
	}, ...)
end)

function NewSlgBossTeamInvitedPop:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	self:getView():center(true)

	self._inviteArr = arg_2_1.inviteArr or {}
	self._btnCheck = self:getChild("Btn_check")

	self._btnCheck:addClickListener(handler(self, self._onClickBtnCheck))

	self._listTeam = self:getChild("List_team")

	self._listTeam:setVirtual(self)
	self._listTeam:setItemRenderer(handler(self, self._onRenderListTeamCell))
	self._listTeam:setNumItems(#self._inviteArr)
end

function NewSlgBossTeamInvitedPop:_onClickBtnCheck()
	g.core.model.User.newSlgData.bossInviteIsRefuse = self._btnCheck:isSelected()
end

function NewSlgBossTeamInvitedPop:_onRenderListTeamCell(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._inviteArr[arg_4_1 + 1])
end

return NewSlgBossTeamInvitedPop
