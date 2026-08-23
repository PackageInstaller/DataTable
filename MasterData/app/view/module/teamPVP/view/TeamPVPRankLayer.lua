local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.const.ConstMgr.TeamPvpConst
local TeamPVPRankLayer = class("TeamPVPRankLayer", require("app.fairyGUI.teamPVP.UI_TeamPVPRankLayer"), function()
	return fgui.GComponent:create({
		resName = "TeamPVPRankLayer",
		pkgPath = "ui/teamPVP/teamPVP",
		isFullScreen = true,
		pkgName = "teamPVP"
	}, ...)
end)

function TeamPVPRankLayer:ctor(arg_2_1)
	self:_initRegisterUI()

	if arg_2_1 then
		self._tabSel = arg_2_1.tab or 0
	end

	self._typeSel = 0
	self._showRankList = {}

	if self._tabSel > 0 then
		self.m_tabSelController:setSelectedIndex(self._tabSel)
	end

	self._showRewardList = var_0_0:getRankRewardByTab(self._tabSel)
end

function TeamPVPRankLayer:_initRegisterUI()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_topBarComp:setResInfoById(var_0_1.TOP_BAR_ID)
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
	self.m_rankRewardList:setVirtual()
	self.m_rankRewardList:doFairyBatching(false)
	self.m_rankRewardList:setItemRenderer(handler(self, self._onRenderRankRewardList))
	self.m_honorRewardList:setVirtual()
	self.m_honorRewardList:doFairyBatching(false)
	self.m_honorRewardList:setItemRenderer(handler(self, self._onRenderHonorRewardList))
	self.m_typeSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTypeSelChanged))
	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
end

function TeamPVPRankLayer:_updateView()
	if self._tabSel == var_0_1.RANK_TAB_TYPE.CROSS then
		local var_4_0 = var_0_0:getMyRank()

		if var_4_0 > 0 then
			self.m_myRank:setText(var_4_0)
		else
			self.m_myRank:setText(g.core.lang:get(420429))
		end

		if self._typeSel == var_0_1.RANK_TOP_TYPE.RANK then
			self.m_rankList:setNumItems(var_0_1.SHOW_RANK_NUM)
			self.m_honorNum:setText(var_0_0:getMyHonorNum())
		else
			self.m_rankRewardList:setNumItems(#self._showRewardList)

			if var_0_0:isActivityInExpire() then
				self.m_crossTip:setVisible(false)
			else
				self.m_honorTip:setVisible(true)
				self.m_crossTip:setText(g.core.lang:get(420434, {
					day = g.core.common.ServerTime:getLeftTimeParts(var_0_0:getEndTime())
				}))
			end
		end
	else
		local var_4_1 = var_0_0:getMyTitleInfo()

		if var_4_1 then
			self.m_myTitle:setText(var_4_1.title)
		else
			self.m_myRank:setText(g.core.lang:get(420428))
		end

		self.m_honorRewardList:setNumItems(#self._showRewardList)

		if var_0_0:isActivityInExpire() then
			self.m_honorTip:setVisible(false)
		else
			self.m_honorTip:setVisible(true)
			self.m_honorTip:setText(g.core.lang:get(420434, {
				day = g.core.common.ServerTime:getLeftTimeParts(var_0_0:getEndTime())
			}))
		end
	end
end

function TeamPVPRankLayer:_onRenderRankList(arg_5_1, arg_5_2)
	arg_5_2:updateRankCell(self._showRankList[arg_5_1 + 1], arg_5_1 + 1)
end

function TeamPVPRankLayer:_onRenderRankRewardList(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._showRewardList[arg_6_1 + 1], arg_6_1 + 1)
end

function TeamPVPRankLayer:_onRenderHonorRewardList(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._showRewardList[#self._showRewardList - arg_7_1], arg_7_1, #self._showRewardList - arg_7_1)
end

function TeamPVPRankLayer:_onTabSelChanged()
	self._tabSel = self.m_tabSelController:getSelectedIndex()
	self._showRewardList = var_0_0:getRankRewardByTab(self._tabSel)

	self:_updateView()
end

function TeamPVPRankLayer:_onTypeSelChanged()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RANKING_SWITCH_PAGE)

	self._typeSel = self.m_typeSelController:getSelectedIndex()

	self:_updateView()
end

function TeamPVPRankLayer:_onRefreshRankList()
	self._showRankList = var_0_0:getRankList()

	self:_updateView()
end

function TeamPVPRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRefreshRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onRefreshRankList, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		id = g.core.network.proto.GROUP_BATTLE_HONOR_CROSS,
		size = var_0_1.SHOW_RANK_NUM
	})
end

return TeamPVPRankLayer
