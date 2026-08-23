local var_0_0 = g.core.model.User.snapShotCacheData
local var_0_1 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_2 = g.core.const.ConstMgr.AllianceConst
local var_0_3 = g.core.model.User.allianceData
local AllianceGuildApplyListPop = class("AllianceGuildApplyListPop", require("app.fairyGUI.alliance.UI_AllianceGuildApplyListPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/alliance/alliance",
		resName = "AllianceGuildApplyListPop",
		pkgName = "alliance"
	}, ...)
end)

function AllianceGuildApplyListPop:ctor()
	self._sortType = var_0_2.SORT_TYPE_INDEX.H_TO_L
	self._applyList = {}

	self:initView()
end

function AllianceGuildApplyListPop:initView()
	self:showAtCenter()
	self.m_showList:setVirtual()
	self.m_showList:setItemRenderer(handler(self, self._onRenderShowList))
	self.m_sortTouch:addClickListener(handler(self, self._onClickSort))
end

function AllianceGuildApplyListPop:_onClickSort()
	self._sortType = 1 - self._sortType

	self.m_sortTypeController:setSelectedIndex(self._sortType)
	self:updateList()
end

function AllianceGuildApplyListPop:_onRenderShowList(arg_5_1, arg_5_2)
	arg_5_2:updateApplyCell(self._applyList[arg_5_1 + 1])
end

function AllianceGuildApplyListPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self.updateList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_CANCELAPPLY, handler(self, self.updateList), self)

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs((var_0_3:getGuildApplyList())) do
		if not self:getAlliance(iter_6_1) then
			table.insert(var_6_0, iter_6_1)
		end
	end

	if #var_6_0 == 0 then
		self:updateList()
	end
end

function AllianceGuildApplyListPop:updateList()
	self._applyList = var_0_3:getGuildApplyList()

	if self._sortType == var_0_2.SORT_TYPE_INDEX.H_TO_L then
		table.sort(self._applyList, function(arg_8_0, arg_8_1)
			return self:getAlliance(arg_8_0).fight_value > self:getAlliance(arg_8_1).fight_value
		end)
	else
		table.sort(self._applyList, function(arg_9_0, arg_9_1)
			return self:getAlliance(arg_9_0).fight_value < self:getAlliance(arg_9_1).fight_value
		end)
	end

	if #self._applyList > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_showList:setNumItems(#self._applyList)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function AllianceGuildApplyListPop:getAlliance(arg_10_1)
	return var_0_0:getSnapShot(var_0_1.SNAP_SHOT_KEY.ALLIANCE, arg_10_1) or {
		fight_value = 0
	}
end

return AllianceGuildApplyListPop
