local var_0_0 = g.core.const.ConstMgr.BountyConst
local var_0_1 = g.core.const.ConstMgr.ShareConst
local BountyShareEnsurePop = class("BountyShareEnsurePop", require("app.fairyGUI.bounty.UI_BountyShareEnsurePop"), function()
	return fgui.GComponent:create({
		pkgName = "bounty",
		resName = "BountyShareEnsurePop"
	})
end)

function BountyShareEnsurePop:ctor(arg_2_1)
	self:showAtCenter()

	self._monsterStruct = arg_2_1 and arg_2_1.monster

	self:_initBtn()
	self:updateView()
end

function BountyShareEnsurePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_SHAREMONSTER, self._onRecvShareMonster, self)
end

function BountyShareEnsurePop:_initBtn()
	self.m_cancelBtn:addClickListener(handler(self, self._onCancelClick))
	self.m_ensureBtn:addClickListener(handler(self, self._onEnsureClick))
end

function BountyShareEnsurePop:updateView()
	if not self._monsterStruct then
		return
	end

	local var_5_0 = self._monsterStruct:getShareType()

	self.m_itemIcon:updateIcon((self._monsterStruct:getExtraReward() or {})[1])
	self.m_tipsText:setVisible(not (var_5_0 == var_0_0.SHARE_SEL_TYPE.MINE))
	self.m_tipsText:setText(g.core.lang:get(422030 + var_5_0))
end

function BountyShareEnsurePop:_showErrorRetTip(arg_6_1)
	local var_6_0

	if arg_6_1 == var_0_0.ERROR_RET_CODE.MONSTER_DEFEATED then
		var_6_0 = 422561
	elseif arg_6_1 == var_0_0.ERROR_RET_CODE.ACTIVITY_EXPIRED then
		var_6_0 = 422562
	elseif arg_6_1 == var_0_0.ERROR_RET_CODE.MONSTER_EXPIRED or arg_6_1 == var_0_0.ERROR_RET_CODE.MONSTER_NOT_EXIST then
		var_6_0 = 422563
	elseif arg_6_1 == var_0_0.ERROR_RET_CODE.MONSTER_SHARE_CHANGED then
		var_6_0 = 422564
	elseif arg_6_1 == var_0_0.ERROR_RET_CODE.SHARE_GUILD_CHANGED then
		var_6_0 = 422565
	end

	if var_6_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(var_6_0))
	end
end

function BountyShareEnsurePop:_onRecvShareMonster(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3.error_ret then
		self:_showErrorRetTip(arg_7_3.error_ret)
		self:dispatchCompEvent("bounty_battle_error", {
			ret = arg_7_3.error_ret
		})
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	local var_7_0 = self.m_selectTypeController:getSelectedIndex() + 1

	g.core.module.ModuleManager:tip(g.core.lang:get(422027 + var_7_0))

	local var_7_1 = var_0_0.SHARE_CHANNEL[var_7_0]
	local var_7_2 = 1

	for iter_7_0, iter_7_1 in g.core.config.chat_invite_info.ipairs() do
		if iter_7_1.function_id == g.core.const.ConstMgr.FUNCTION_TYPE.BOUNTY and iter_7_1.channel == var_7_1 then
			var_7_2 = iter_7_1.id

			break
		end
	end

	if var_7_0 == var_0_0.SHARE_SEL_TYPE.CROSS_SERVER then
		g.core.network.GameNetProxy:send_C2S_BulletScreenSend({
			look = 0,
			content = "",
			type = g.core.model.User.chatData:toSvrChatType(var_7_1),
			invite_id = var_7_2,
			unique_id = self._monsterStruct:getId(),
			param1 = tostring(self._monsterStruct:getStarNum()),
			share = {
				share_type = var_0_1.SHARE_TYPE.TYPE_ID_21,
				id = g.core.model.User:getId()
			}
		})
	else
		g.core.network.GameNetProxy:send_C2S_Chat({
			content = "",
			channel = var_7_1,
			name = g.core.model.User:getName(),
			invite_id = var_7_2,
			unique_id = self._monsterStruct:getId(),
			param1 = tostring(self._monsterStruct:getStarNum()),
			share = {
				share_type = var_0_1.SHARE_TYPE.TYPE_ID_21,
				id = g.core.model.User:getId()
			}
		})
	end

	g.core.model.User.chatData:setLastSendConnectTime(var_7_1)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function BountyShareEnsurePop:_onCancelClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function BountyShareEnsurePop:_onEnsureClick()
	if not self._monsterStruct then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end

	if g.core.model.User.bountyData:isInShareCD(self._monsterStruct:getId()) then
		g.core.module.ModuleManager:tip(g.core.lang:get(422034))

		return
	end

	local var_9_0 = self.m_selectTypeController:getSelectedIndex() + 1

	if var_9_0 == self._monsterStruct:getShareType() then
		g.core.module.ModuleManager:tip(g.core.lang:get(422006))

		return
	elseif var_9_0 == var_0_0.SHARE_SEL_TYPE.GUILD and not g.core.model.User.guildData:hasGuild() then
		g.core.module.ModuleManager:tip(g.core.lang:get(422007))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Bounty_ShareMonster({
		id = self._monsterStruct:getId(),
		share_type = var_9_0
	})
end

return BountyShareEnsurePop
