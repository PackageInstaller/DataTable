local var_0_0 = g.core.model.User.snapShotCacheData
local var_0_1 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_2 = g.core.const.ConstMgr.AllianceConst
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local AllianceGuildListPop = class("AllianceGuildListPop", require("app.fairyGUI.alliance.UI_AllianceGuildListPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceGuildListPop",
		pkgPath = "ui/alliance/alliance",
		pkgName = "alliance"
	}, ...)
end)

function AllianceGuildListPop:ctor(arg_2_1)
	self._allianceSnapshot = arg_2_1.allianceSnapshot
	self._guildList = {}
	self._sortType = var_0_2.SORT_TYPE_INDEX.H_TO_L

	self:initView()
end

function AllianceGuildListPop:initView()
	self:showAtCenter()
	self.m_showList:setVirtual()
	self.m_showList:setItemRenderer(handler(self, self._onRenderShowList))
	self.m_sortTouch:addClickListener(handler(self, self._onClickSortTouch))
end

function AllianceGuildListPop:_onClickSortTouch()
	self._sortType = 1 - self._sortType

	self.m_sortTypeController:setSelectedIndex(self._sortType)
	self:updateList()
end

function AllianceGuildListPop:_onRenderShowList(arg_5_1, arg_5_2)
	arg_5_2:updateGuildCell(self._guildList[arg_5_1 + 1])
end

function AllianceGuildListPop:onLoad()
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, handler(self, self.updateList), self)

	local var_6_0 = {}

	var_6_0.guild_ids = self._allianceSnapshot.guild_ids or {}

	g.core.network.GameNetProxy:send_C2S_GetGuildSnapShot(var_6_0)
end

function AllianceGuildListPop:updateList()
	self._guildList = self._allianceSnapshot.guild_ids

	if self._sortType == var_0_2.SORT_TYPE_INDEX.H_TO_L then
		table.sort(self._guildList, function(arg_8_0, arg_8_1)
			return self:getGuild(arg_8_0).fight_value > self:getGuild(arg_8_1).fight_value
		end)
	else
		table.sort(self._guildList, function(arg_9_0, arg_9_1)
			return self:getGuild(arg_9_0).fight_value < self:getGuild(arg_9_1).fight_value
		end)
	end

	self.m_showList:setNumItems(#self._guildList)
end

function AllianceGuildListPop:getGuild(arg_10_1)
	return var_0_0:getSnapShot(var_0_1.SNAP_SHOT_KEY.GUILD, arg_10_1)
end

return AllianceGuildListPop
