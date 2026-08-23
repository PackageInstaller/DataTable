local var_0_0 = g.core.model.User.snapShotCacheData
local var_0_1 = g.core.model.User.guildData
local GuildMergeSendPop = class("GuildMergeSendPop", require("app.fairyGUI.guild.UI_GuildMergeSendPop"), function()
	return fgui.GComponent:create({
		resName = "GuildMergeSendPop",
		pkgPath = "ui/guild/guild",
		pkgName = "guild"
	}, ...)
end)

function GuildMergeSendPop:ctor(arg_2_1)
	self:showAtCenter()

	self._targetGid = arg_2_1.targetGid
	self._userList = {}
	self._selectDict = {}

	self:initView()
end

function GuildMergeSendPop:initView()
	self.m_userList:setVirtual()
	self.m_userList:setItemRenderer(handler(self, self._onUserListRenderer))
	self:addListen(self.m_userList)
	self.m_allSelectBtn:addClickListener(handler(self, self._onAllSelectClick))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmClick))
end

function GuildMergeSendPop:_onAllSelectClick()
	if self.m_allSelectBtn:isSelected() then
		for iter_4_0, iter_4_1 in ipairs(self._userList) do
			self._selectDict[iter_4_1.user.id] = true
		end
	else
		self._selectDict = {}
	end

	self.m_userList:refreshVirtualList()
	self.m_userNum:setText(g.core.lang:get(200523, {
		curNum = table.nums(self._selectDict),
		totalNum = #self._userList
	}))
end

function GuildMergeSendPop:_onUserListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateSendCell(self._userList[arg_5_1 + 1], arg_5_1, self._selectDict)
end

function GuildMergeSendPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_REQUEST, self._onRequestSucc, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self.updateView, self)
	self:updateView()
	self.m_userNum:setText(g.core.lang:get(200523, {
		curNum = table.nums(self._selectDict),
		totalNum = #self._userList
	}))
end

function GuildMergeSendPop:updateView()
	self._userList = var_0_1:getCanMergeList()

	self.m_userList:setNumItems(#self._userList)

	local var_7_0 = var_0_0:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, self._targetGid)

	if not var_7_0 then
		return
	end

	self.m_tipDesc:setText(g.core.lang:get(430011, {
		guildName = var_7_0.name
	}))
end

function GuildMergeSendPop:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "merge_send_select_user" then
		self._selectDict[arg_8_2.uid] = arg_8_2.isSelect and true or nil

		local var_8_0 = table.nums(self._selectDict)
		local var_8_1 = #self._userList

		self.m_userNum:setText(g.core.lang:get(200523, {
			curNum = var_8_0,
			totalNum = #self._userList
		}))
		self.m_allSelectBtn:setSelected(var_8_0 == var_8_1)
	end
end

function GuildMergeSendPop:_onConfirmClick()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self._selectDict) do
		table.insert(var_9_0, iter_9_0)
	end

	if #var_9_0 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(430001))

		return
	end

	if #var_9_0 == #self._userList then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(430002),
			onConfirm = handler(self, self._onConfirmSendIntegration)
		}), {
			touchDisappear = true
		})
	else
		self:_onConfirmSendIntegration()
	end
end

function GuildMergeSendPop:_onConfirmSendIntegration()
	g.core.network.GameNetProxy:send_C2S_Guild_Merge_Request({
		target_guild = self._targetGid,
		target_user = table.keys(self._selectDict)
	})
end

function GuildMergeSendPop:_onRequestSucc()
	g.core.module.ModuleManager:tip(g.core.lang:get(430009))
	self:newScheduleOnce(handler(self, self._onClickClose), 0.1)
end

function GuildMergeSendPop:_onClickClose()
	if not self._onClose then
		self._onClose = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

return GuildMergeSendPop
