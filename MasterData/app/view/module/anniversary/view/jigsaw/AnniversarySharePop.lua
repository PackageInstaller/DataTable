local var_0_0 = g.core.model.User.anniversaryData
local var_0_1 = g.core.const.ConstMgr.AnniversaryConst
local AnniversarySharePop = class("AnniversarySharePop", require("app.fairyGUI.anniversary.UI_AnniversarySharePop"), function()
	return fgui.GComponent:create({
		resName = "AnniversarySharePop",
		pkgName = "anniversary"
	}, ...)
end)

function AnniversarySharePop:ctor()
	self:showAtCenter()

	self._selectData = {}

	self.m_enterTransition:play()
	self.m_shareList:setVirtual()
	self.m_shareList:setItemRenderer(handler(self, self._onShareItemRender))
	self.m_shareList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickShareListItem))
	self.m_shareBtn:addClickListener(handler(self, self._onClickShareBtn))
	self.m_shareCrossBtn:addClickListener(handler(self, self._onClickShareCrossBtn))
	self.m_shareGuildBtn:addClickListener(handler(self, self._onClickShareGuildBtn))
	self.m_shareFriendBtn:addClickListener(handler(self, self._onClickShareFriendBtn))
	self.m_bg:setURL(var_0_0:getActivityResource("ui_cocos", "pic_xmhy_majiangfx_di1.png"))
end

function AnniversarySharePop:_onShareItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._shareData[arg_3_1 + 1])
end

function AnniversarySharePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETINFO, handler(self, self._onRecvInfo), self)
	g.core.network.GameNetProxy:send_C2S_Anniversary_GetInfo({})
end

function AnniversarySharePop:updateMainView()
	self._shareData = var_0_0:getOwnJigsaws()

	if #self._shareData > 0 then
		self.m_shareList:setNumItems(#self._shareData)

		self._selectData = self._shareData[1]

		self.m_shareList:setSelectedIndex(0)
	end

	self.m_isEmptyController:setSelectedIndex(#self._shareData == 0 and 1 or 0)

	local var_5_0 = var_0_0:getTodayShareLimitNum()

	self.m_shareBtn:setTitle(g.core.lang:get(431657, {
		cur = math.max(var_5_0 - var_0_0:getCurShareTimes(), 0),
		max = var_5_0
	}))
end

function AnniversarySharePop:_onRecvInfo()
	self:updateMainView()
end

function AnniversarySharePop:_onClickShareListItem(arg_7_1)
	self._selectData = self._shareData[arg_7_1:getDataValue() + 1]
end

function AnniversarySharePop:_onClickShareBtn()
	if #self._shareData == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431660))

		return
	end

	if var_0_0:getTodayShareLimitNum() - var_0_0:getCurShareTimes() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431659))

		return
	end

	if self.m_isShowShareTypeController:getSelectedIndex() == 0 then
		self.m_isShowShareTypeController:setSelectedIndex(1)
	else
		self.m_isShowShareTypeController:setSelectedIndex(0)
	end
end

function AnniversarySharePop:_onClickShareCrossBtn()
	g.core.network.GameNetProxy:send_C2S_BulletScreenSend({
		content = "",
		type = g.core.const.ConstMgr.ChatConst.ANNIVERSARY,
		share = {
			share_type = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_25
		},
		param1 = tostring((g.core.model.User:getId())) .. ";" .. tostring(self._selectData.jigsawId) .. ";" .. tostring((g.core.common.ServerTime:getTime())),
		invite_id = var_0_1.SHARE_INVITE.CROSS,
		unique_id = g.core.model.User:getId()
	})
	g.core.module.ModuleManager:tip(g.core.lang:get(431655))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function AnniversarySharePop:_onClickShareGuildBtn()
	local var_10_0

	if not g.core.model.User.guildData:hasGuild() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1012))

		do return end

		var_10_0 = {
			content = "",
			channel = g.core.const.ConstMgr.ChatConst.ARMY,
			name = g.core.model.User:getName(),
			invite_id = var_0_1.SHARE_INVITE.GUILD
		}
	end

	var_10_0.param1 = tostring((g.core.model.User:getId())) .. ";" .. tostring(self._selectData.jigsawId) .. ";" .. tostring((g.core.common.ServerTime:getTime()))
	var_10_0.share = {
		share_type = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_25
	}

	g.core.network.GameNetProxy:send_C2S_Chat(var_10_0)
	g.core.module.ModuleManager:tip(g.core.lang:get(431656))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function AnniversarySharePop:_onClickShareFriendBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.anniversary.view.jigsaw.AnniversaryShareFriendPop").new({
		jigsawId = self._selectData.jigsawId
	})))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return AnniversarySharePop
