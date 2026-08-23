local var_0_0 = g.core.model.User.snapShotCacheData
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.model.User.guildData
local GuildMergeLookApplyPop = class("GuildMergeLookApplyPop", require("app.fairyGUI.guild.UI_GuildMergeLookApplyPop"), function()
	return fgui.GComponent:create({
		resName = "GuildMergeLookApplyPop",
		pkgName = "guild",
		pkgPath = "ui/guild/guild"
	}, ...)
end)

function GuildMergeLookApplyPop:ctor(arg_2_1)
	self._targetGid = arg_2_1.targetGid
	self._mergeGuild = nil
	self._selectChangeDict = {}
	self._applyList = {}
	self._myUserList = {}
	self._lockTime = 0

	self:showAtCenter()
	self:initData()
	self:initView()
end

function GuildMergeLookApplyPop:initData()
	self._guildPlace = var_0_2:getCfg().number - #var_0_2:getMemberData()
	self._mergeNum = 0
end

function GuildMergeLookApplyPop:initView()
	self.m_applyList:setVirtual()
	self.m_applyList:setItemRenderer(handler(self, self._onApplyListRenderer))
	self.m_myUserList:setVirtual()
	self.m_myUserList:setItemRenderer(handler(self, self._onMyUserListRenderer))
	self:addListen(self.m_myUserList)
	self.m_allSelectBtn:addClickListener(handler(self, self._onAllSelectClick))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmClick))
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancel))
end

function GuildMergeLookApplyPop:_onClickCancel()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(430016),
		onConfirm = handler(self, self._sendCancel)
	}), {
		touchDisappear = true
	})
end

function GuildMergeLookApplyPop:_sendCancel()
	if not self or not self._targetGid then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Guild_Merge_Cancel({
		target_guild = self._targetGid
	})
end

function GuildMergeLookApplyPop:_onAllSelectClick()
	if self.m_allSelectBtn:isSelected() then
		for iter_7_0, iter_7_1 in ipairs(self._myUserList) do
			self._selectChangeDict[iter_7_1.user.id] = true
		end
	else
		self._selectChangeDict = {}
	end

	self.m_myUserList:refreshVirtualList()
	self:updateCanChangeDesc()
end

function GuildMergeLookApplyPop:updateCanChangeDesc()
	local var_8_0 = table.nums(self._selectChangeDict)

	if self._isConfirm then
		var_8_0 = #self._myUserList
	end

	if self._guildPlace >= self._mergeNum then
		self.m_canChangeDesc:setText(g.core.lang:get(430005, {
			min = 0,
			max = self._mergeNum,
			curNum = var_8_0
		}))
	else
		self.m_canChangeDesc:setText(g.core.lang:get(430005, {
			min = self._mergeNum - self._guildPlace,
			max = self._mergeNum,
			curNum = var_8_0
		}))
	end
end

function GuildMergeLookApplyPop:_onApplyListRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateApplyUser(self._applyList[arg_9_1 + 1], arg_9_1)
end

function GuildMergeLookApplyPop:_onMyUserListRenderer(arg_10_1, arg_10_2)
	arg_10_2:updateMyGuildUser(self._myUserList[arg_10_1 + 1], arg_10_1, self._isConfirm, self._selectChangeDict)
end

function GuildMergeLookApplyPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_AGREE, handler(self, self._onAgreeApply), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_CANCEL, handler(self, self._onClickClose), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, handler(self, self.updateTargetGuild), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_NOTIFY, self._onClickClose, self)
	self:updateTargetGuild()
	self:updateView()
end

function GuildMergeLookApplyPop:updateView()
	local var_12_0 = var_0_2:getReceiveMergeData(self._targetGid)

	self._applyList = var_12_0.change_members or {}

	local var_12_1 = var_0_2:getMergeLockTime()

	self._isConfirm = var_12_0.is_confirm

	if self._isConfirm then
		self.m_isConfirmController:setSelectedIndex(1)

		self._myUserList = var_12_0.send_members or {}
		self._lockTime = var_12_0.merge_time + var_12_1

		self.m_lockTime:setText(g.core.lang:get(430003, {
			time = var_0_1:getLeftHMSFormat(self._lockTime)
		}))

		self._lockSchedule = self._lockSchedule or self:newSchedule(handler(self, self._onScheduleLockTime), 1)
	else
		self.m_isConfirmController:setSelectedIndex(0)

		self._myUserList = var_0_2:getMemberData()

		self.m_applyTip:setText(g.core.lang:get(430004, {
			time = var_0_1:getTimeStrSimple(var_12_1)
		}))
	end

	self._mergeNum = #self._applyList

	self.m_applyList:setNumItems(self._mergeNum)

	if #self._myUserList > 0 then
		self.m_hasChangeController:setSelectedIndex(1)
		self.m_myUserList:setNumItems(#self._myUserList)
	else
		self.m_hasChangeController:setSelectedIndex(0)
	end

	self.m_mergeUserNum:setText(g.core.lang:get(430008, {
		num = self._mergeNum
	}))
	self.m_myGuildName:setText(var_0_2:getGuildData().name)
	self:updateCanChangeDesc()
end

function GuildMergeLookApplyPop:updateTargetGuild()
	local var_13_0 = var_0_0:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, self._targetGid)

	if not var_13_0 then
		return
	end

	self.m_applyGuildName:setText(var_13_0.name)
end

function GuildMergeLookApplyPop:_onScheduleLockTime()
	if var_0_1:getTime() > self._lockTime then
		self.m_lockTime:setText("")
	else
		self.m_lockTime:setText(g.core.lang:get(430003, {
			time = var_0_1:getLeftHMSFormat(self._lockTime)
		}))
	end
end

function GuildMergeLookApplyPop:_onClickClose()
	if not self._onClose then
		self._onClose = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function GuildMergeLookApplyPop:receiveCompEvent(arg_16_1, arg_16_2)
	if arg_16_1 == "merge_change_select_user" then
		self._selectChangeDict[arg_16_2.uid] = arg_16_2.isSelect and true or nil

		self.m_allSelectBtn:setSelected(table.nums(self._selectChangeDict) == #self._myUserList)
		self:updateCanChangeDesc()
	end
end

function GuildMergeLookApplyPop:_onConfirmClick()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(self._selectChangeDict) do
		table.insert(var_17_0, iter_17_0)
	end

	if ((self._guildPlace < self._mergeNum or nil) and self._mergeNum - self._guildPlace) > #var_17_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(430006))

		return
	elseif #var_17_0 > self._mergeNum then
		g.core.module.ModuleManager:tip(g.core.lang:get(430007))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Guild_Merge_Agree({
		target_guild = self._targetGid,
		change_user = var_17_0
	})
end

function GuildMergeLookApplyPop:_onAgreeApply(arg_18_1, arg_18_2, arg_18_3)
	self:updateView()
end

return GuildMergeLookApplyPop
