local var_0_0 = g.core.model.User.snapShotCacheData
local var_0_1 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_2 = g.core.const.ConstMgr.AllianceConst
local var_0_3 = g.core.model.User.allianceData
local AllianceGuildInviteListPop = class("AllianceGuildInviteListPop", require("app.fairyGUI.alliance.UI_AllianceGuildInviteListPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceGuildInviteListPop",
		pkgPath = "ui/alliance/alliance",
		pkgName = "alliance"
	}, ...)
end)

function AllianceGuildInviteListPop:ctor()
	self._inviteList = {}
	self._sortType = var_0_2.SORT_TYPE_INDEX.H_TO_L

	self:initView()
end

function AllianceGuildInviteListPop:initView()
	self:showAtCenter()
	self.m_showList:setVirtual()
	self.m_showList:setItemRenderer(handler(self, self._onRenderShowList))
	self.m_sortTouch:addClickListener(handler(self, self._onClickSortTouch))
end

function AllianceGuildInviteListPop:_onClickSortTouch()
	self._sortType = 1 - self._sortType

	self.m_sortTypeController:setSelectedIndex(self._sortType)
	self:updateList()
end

function AllianceGuildInviteListPop:_onRenderShowList(arg_5_1, arg_5_2)
	arg_5_2:updateInviteCell(self._inviteList[arg_5_1 + 1])
end

function AllianceGuildInviteListPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self.updateList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_APPROVEINVITE, handler(self, self._onApproveInvite), self)

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs((var_0_3:getGuildInviteList())) do
		if not self:getAlliance(iter_6_1) then
			table.insert(var_6_0, iter_6_1)
		end
	end

	if #var_6_0 == 0 then
		self:updateList()
	end
end

function AllianceGuildInviteListPop:_onApproveInvite(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.agree then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	else
		self:updateList()
	end
end

function AllianceGuildInviteListPop:updateList()
	self._inviteList = var_0_3:getGuildInviteList()

	if self._sortType == var_0_2.SORT_TYPE_INDEX.H_TO_L then
		table.sort(self._inviteList, function(arg_9_0, arg_9_1)
			return self:getAlliance(arg_9_0).fight_value > self:getAlliance(arg_9_1).fight_value
		end)
	else
		table.sort(self._inviteList, function(arg_10_0, arg_10_1)
			return self:getAlliance(arg_10_0).fight_value < self:getAlliance(arg_10_1).fight_value
		end)
	end

	if #self._inviteList > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_showList:setNumItems(#self._inviteList)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function AllianceGuildInviteListPop:getAlliance(arg_11_1)
	return var_0_0:getSnapShot(var_0_1.SNAP_SHOT_KEY.ALLIANCE, arg_11_1) or {
		fight_value = 0
	}
end

return AllianceGuildInviteListPop
