local NewSlgBossTeamInvitedCell = class("NewSlgBossTeamInvitedCell")

function NewSlgBossTeamInvitedCell:ctor()
	self._btnJoin = self:getChild("Btn_join")

	self._btnJoin:addClickListener(handler(self, self._onClickBtnJoin))

	self._compName = self:getChild("Comp_name")
	self._compUserIcon = self:getChild("Comp_userIcon")
	self._txtDesc = self:getChild("Txt_desc")
	self._txtAuthority = self:getChild("Txt_authority")
	self._txtLDesc = self:getChild("Txt_lDesc")
	self._txtRDesc = self:getChild("Txt_rDesc")
end

function NewSlgBossTeamInvitedCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._data = arg_2_1

	local var_2_0 = g.core.model.User.newSlgData:getBossInfoById(arg_2_1.bossId)

	self._txtDesc:setText(g.core.lang:get(428899, {
		level = var_2_0.level,
		name = var_2_0.name
	}))
	self._compUserIcon:updateAsUser(arg_2_1.user)
	self._compName:updateQualityTxtForce({
		text = arg_2_1.user.name,
		quality = g.core.config.knight_info.get(arg_2_1.user.base_id).quality
	})
	self._txtAuthority:setText(arg_2_1.authority or 0)

	local var_2_1, var_2_2 = g.core.common.GlobalFunc.getAllianceOrGuildName(arg_2_1.user)

	self._txtLDesc:setText(var_2_1)
	self._txtRDesc:setText(var_2_2)
end

function NewSlgBossTeamInvitedCell:_onClickBtnJoin()
	g.core.utils.Tools.newSlgFunc.clickBossInvite(self._data)
end

return NewSlgBossTeamInvitedCell
