local var_0_0 = g.core.const.ConstMgr.AnniversaryConst
local AnniversaryShareFriendCell = class("AnniversaryShareFriendCell", require("app.fairyGUI.anniversary.UI_AnniversaryShareFriendCell"))

function AnniversaryShareFriendCell:ctor(arg_1_1)
	self.m_inviteBtn:addClickListener(handler(self, self._onClickInvite))
end

function AnniversaryShareFriendCell:updateInviteCell(arg_2_1, arg_2_2)
	self._friend = arg_2_1
	self._jigsawId = arg_2_2

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, (self._friend:getFriendId()))

	if var_2_0 then
		self.m_userIcon:updateAsUser(var_2_0)
	end

	self.m_name:setText(self._friend:getFriendName(), false, true)

	local var_2_1 = self._friend:getBasicInfo()
	local var_2_2 = var_2_1.guild_name

	if not var_2_1.guild_name or string.len(var_2_2) == 0 then
		var_2_2 = g.core.lang:get(300011)
	end

	self.m_guildName:setText(var_2_2)
	self.m_fightValue:setText(g.core.utils.Number.transFightValue(var_2_1.fight_value))
end

function AnniversaryShareFriendCell:_onClickInvite()
	g.core.network.GameNetProxy:send_C2S_Mail_Send({
		content = table.concat({
			g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_25,
			var_0_0.SHARE_INVITE.FRIEND,
			g.core.model.User:getId(),
			self._jigsawId,
			(g.core.common.ServerTime:getTime())
		}, ";"),
		uid = self._friend:getFriendId(),
		name = self._friend:getFriendName(),
		sub_type = g.core.const.ConstMgr.MailConst.SUB_TYPE.SHARE
	})
end

return AnniversaryShareFriendCell
