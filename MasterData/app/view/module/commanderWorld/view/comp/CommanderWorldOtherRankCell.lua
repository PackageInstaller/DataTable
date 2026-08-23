local var_0_0 = g.core.const.ConstMgr.CommanderWorldConst
local CommanderWorldOtherRankCell = class("CommanderWorldOtherRankCell", require("app.fairyGUI.commanderWorld.UI_CommanderWorldOtherRankCell"))

function CommanderWorldOtherRankCell:ctor()
	self.m_avatar:addClickListener(handler(self, self._onClickKnightIcon))
	self.m_avatar:setOverrideClick(true)

	self._user = nil
end

function CommanderWorldOtherRankCell:updateRankCell(arg_2_1, arg_2_2)
	if not arg_2_1 or not arg_2_1.id then
		self.m_avatar:setVisible(false)
		self.m_nameTxt:setText("")
		self.m_guildNameTxt:setText("")

		return
	end

	self._params = arg_2_1

	self.m_rankTxt:setText(arg_2_1.rank)
	self.m_scoreTxt:setText(arg_2_1.score)

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id)

	self._user = var_2_0

	if var_2_0 then
		self.m_avatar:updateAsUser(var_2_0)
		self.m_avatar:setVisible(true)
		self.m_nameTxt:setText(var_2_0.name)

		local var_2_1 = ""

		if arg_2_2 == var_0_0.SERVER_TYPE.LOCAL then
			var_2_1 = var_2_0.guild_name

			if not var_2_0.guild_name or var_2_1 == "" then
				var_2_1 = g.core.lang:get(1012)
			end
		else
			var_2_1 = var_2_0.server_name
		end

		self.m_guildNameTxt:setText(var_2_1)
	else
		self.m_avatar:setVisible(false)
		self.m_nameTxt:setText("")
		self.m_guildNameTxt:setText("")
	end
end

function CommanderWorldOtherRankCell:_onClickKnightIcon(arg_3_1)
	if not self._user then
		return
	end

	if self:checkIsSelf() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			isSelf = true
		})
	else
		local var_3_0

		if arg_3_1 then
			var_3_0 = {}

			local var_3_1 = arg_3_1:getInput():getTouch()

			var_3_0.x = var_3_1:getLocationInView().x
			var_3_0.y = var_3_1:getLocationInView().y
		end

		local var_3_2 = self:_checkAndGetPopInfo(self._user)

		var_3_2.clickWorldPos = var_3_0

		self:addPopup(require("app.view.base.infoPop.InfoUserMenuPop").new(var_3_2), {
			isUpdateBlack = false,
			hideContinue = true
		})
	end
end

function CommanderWorldOtherRankCell:checkIsSelf()
	if not self._roleId then
		return false
	end

	return math.uint64_equal(self._roleId, g.core.model.User:getId())
end

function CommanderWorldOtherRankCell:_checkAndGetPopInfo(arg_5_1)
	local var_5_0 = {}
	local var_5_1 = {
		user = clone(arg_5_1)
	}

	if var_5_1.user.guild_id and var_5_1.user.guild_id == 0 then
		var_5_1.user.guild_id = -1
	end

	var_5_0.playerInfo = var_5_1

	return var_5_0
end

return CommanderWorldOtherRankCell
