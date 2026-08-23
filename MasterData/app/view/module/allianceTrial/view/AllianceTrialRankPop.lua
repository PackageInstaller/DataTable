local var_0_0 = g.core.const.ConstMgr.AllianceConst
local var_0_1 = g.core.const.ConstMgr.RankAwardConst
local RankAward = require("app.core.common.RankAward")
local var_0_3 = {
	AWARD = 1,
	RANK = 0
}
local AllianceTrialRankPop = class("AllianceTrialRankPop", require("app.fairyGUI.allianceTrial.UI_AllianceTrialRankPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceTrialRankPop",
		pkgPath = "ui/allianceTrial/allianceTrial",
		isFullScreen = true,
		pkgName = "allianceTrial"
	}, ...)
end)

function AllianceTrialRankPop:ctor()
	self._selectedTab = var_0_3.RANK
	self._rankUserList = {}
	self._awardList = {}

	self:initView()
end

function AllianceTrialRankPop:initView()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_userList:setVirtual()
	self.m_userList:setItemRenderer(handler(self, self._onRenderUserList))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
end

function AllianceTrialRankPop:_onTabSelChanged()
	self._selectedTab = self.m_tabController:getSelectedIndex()

	self:updateView()
end

function AllianceTrialRankPop:_onRenderUserList(arg_5_1, arg_5_2)
	arg_5_2:updateUserCell(arg_5_1, self._rankUserList[arg_5_1 + 1])
end

function AllianceTrialRankPop:_onRenderAwardList(arg_6_1, arg_6_2)
	arg_6_2:updateAwardCell(arg_6_1 + 1, self._awardList[arg_6_1 + 1])
end

function AllianceTrialRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_RANKLIST, handler(self, self.onGetRankInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self.updateView), self)
	g.core.network.GameNetProxy:send_C2S_AllianceTrial_RankList({})
	self.m_tabController:setSelectedIndex(self._selectedTab)
end

function AllianceTrialRankPop:onGetRankInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self._rankUserList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_4.units or {}) do
		table.insert(self._rankUserList, {
			uid = iter_8_1.id,
			damage = iter_8_1.first,
			fightValue = iter_8_1.second,
			rank = iter_8_0
		})
	end

	self:updateView()

	if arg_8_4.rank and arg_8_4.rank > 0 then
		self.m_rankText:setText(arg_8_4.rank)
		self.m_damageText:setText(arg_8_4.damage or "")
	else
		self.m_rankText:setText(g.core.lang:get(422026))
		self.m_damageText:setText(g.core.lang:get(422026))
	end
end

function AllianceTrialRankPop:updateView()
	if self._selectedTab == var_0_3.RANK then
		self.m_userList:setNumItems(#self._rankUserList)
		self.m_isEmptyController:setSelectedIndex(#self._rankUserList == 0 and 1 or 0)
	else
		if not next(self._awardList) then
			self._awardList = RankAward:getRankAwardArray(var_0_1.ALLIANCE_TRIA)
		end

		self.m_awardList:setNumItems(#self._awardList)
		self.m_isEmptyController:setSelectedIndex(#self._awardList == 0 and 1 or 0)
	end

	self.m_tipText:setText(g.core.lang:get(430410, {
		num = g.core.model.User.allianceData:getParams(var_0_0.PARAMETER.TRIAL_RANK_LEVEL)
	}))
end

return AllianceTrialRankPop
