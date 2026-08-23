local BountyRankPop = class("BountyRankPop", require("app.fairyGUI.bounty.UI_BountyRankPop"), function()
	return fgui.GComponent:create({
		resName = "BountyRankPop",
		pkgPath = "ui/bounty/bounty",
		isFullScreen = true,
		pkgName = "bounty"
	})
end)

function BountyRankPop:ctor()
	self._listData = nil
	self._checkGuildMap = {}

	self:_initPop()
end

function BountyRankPop:_initPop()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_leftTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onLeftTabItemClick))
	self.m_topTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTopTabItemClick))
	self.m_rankList:setVirtual(self)
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_leftTabList:setSelectedIndex(0)
end

function BountyRankPop:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETGUILDRANK, handler(self, self._updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, handler(self, self._onS2CGetGuildSnapShot), self)
end

function BountyRankPop:onLoad()
	self:_addCustomListener()
	g.core.network.GameNetProxy:send_C2S_Bounty_GetGuildRank({
		size = 100
	})
end

function BountyRankPop:_onLeftTabItemClick(arg_6_1)
	self.m_topTabList:setSelectedIndex((math.max(self.m_topTabList:getSelectedIndex(), 0)))
	self:_onTopTabItemClick(arg_6_1)
end

function BountyRankPop:_onTopTabItemClick(arg_7_1)
	local var_7_0 = self.m_topTabList:getSelectedIndex()
	local var_7_1, var_7_2 = g.core.model.User.bountyData:getRankListAndMyRank()

	if g.core.model.User:isJoinGuild() then
		self.m_rankTxt:setText(g.core.lang:get(422043, {
			rank = (var_7_2 == 0 or nil) and g.core.lang:get(410300)
		}))
	else
		self.m_rankTxt:setText(g.core.lang:get(411025))
	end

	local var_7_4

	if var_7_0 == 0 then
		self._listData = var_7_1

		self.m_rankList:setNumItems(#self._listData)

		var_7_4 = self.m_rankList
	elseif var_7_0 == 1 then
		self._listData = g.core.model.User.bountyData:getRankRwdList()

		self.m_awardList:setNumItems(#self._listData)

		var_7_4 = self.m_awardList
	end

	if arg_7_1 then
		var_7_4:transitionShowCells("enter_left", 0.03)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Menu_Slide_01)
	end

	self.m_rankTypeController:setSelectedIndex(var_7_0)
	self.m_isEmptyController:setSelectedIndex(#self._listData > 0 and 0 or 1)
end

function BountyRankPop:_updateView()
	print("BountyRankPop:_updateView")
	self.m_leftTabList:setSelectedIndex(0)
	self:_onLeftTabItemClick(true)
end

function BountyRankPop:_onS2CGetGuildSnapShot()
	self:_onLeftTabItemClick()
end

function BountyRankPop:_onRenderRankList(arg_10_1, arg_10_2)
	arg_10_2:updateCell(self._listData[arg_10_1 + 1], arg_10_1 + 1)
end

function BountyRankPop:_onRenderAwardList(arg_11_1, arg_11_2)
	arg_11_2:updateCell(arg_11_1 + 1, self._listData[arg_11_1 + 1].cfg.min_rank, self._listData[arg_11_1 + 1].cfg.max_rank, self._listData[arg_11_1 + 1].awards)
end

return BountyRankPop
