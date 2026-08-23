local var_0_0 = g.core.const.ConstMgr.WeeklyCompetitionConst
local var_0_1 = g.core.module.ModuleManager
local WeeklyCompetitionRankComp = class("WeeklyCompetitionRankComp", (require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionRankComp")))

function WeeklyCompetitionRankComp:ctor()
	self._weeklyCompetitionData = nil

	self.m_serverBtn:addClickListener(handler(self, self._onClickServerBtn))
	self.m_screenCross:addClickListener((handler(self, self._onClickScreenCross)))

	self._curSelectedIndex = var_0_0.SERVER_TYPE.LOCAL

	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
	self.m_screenCross:setVisible(true)

	self._rankList = {}
	self._myRank = -1

	self.m_otherRankList:setVirtual()
	self.m_otherRankList:setItemRenderer(handler(self, self._onRenderOtherRankList))
end

function WeeklyCompetitionRankComp:_initRankComp()
	self:getChild("n9"):setText(g.core.lang:get(420108, {
		name = self._weeklyCompetitionData:getScoreIconName()
	}))

	for iter_2_0 = 1, 3 do
		self["m_topCell" .. iter_2_0]:setVisible(false)
		self["m_topCell" .. iter_2_0]:setItemName(self._weeklyCompetitionData:getScoreIconName())
	end

	self:updateTab()
end

function WeeklyCompetitionRankComp:updateTab()
	self.m_screenCross:setVisible(false)
	self.m_tabSelController:setSelectedIndex(self._curSelectedIndex - 1)
	self:_updateGuaranteeTip()
end

function WeeklyCompetitionRankComp:initRankData(arg_4_1)
	self._weeklyCompetitionData = arg_4_1

	self:_initRankComp()
end

function WeeklyCompetitionRankComp:updateRankComp(arg_5_1)
	self._rankList = arg_5_1.rankList or {}
	self._myRank = arg_5_1.myRank

	self.m_myScore:setText(self._weeklyCompetitionData:getResourceNum(), false, true)

	if self._myRank == 0 then
		self.m_isShowRankController:setSelectedIndex(0)
	else
		self.m_isShowRankController:setSelectedIndex(1)
		self.m_myRank:setText(self._myRank)
	end

	self:_updateRankList()
end

function WeeklyCompetitionRankComp:_updateRankList()
	if #self._rankList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)

		return
	end

	self.m_isEmptyController:setSelectedIndex(0)
	self:_updateTopRank()

	if #self._rankList > 3 then
		self.m_otherRankList:setNumItems(#self._rankList - 3)
	else
		self.m_otherRankList:setNumItems(0)
	end
end

function WeeklyCompetitionRankComp:_onTabSelChanged()
	self._curSelectedIndex = self.m_tabSelController:getSelectedIndex() + 1

	self:_updateGuaranteeTip()
	self:dispatchCompEvent("Change_ServerType")
end

function WeeklyCompetitionRankComp:_updateGuaranteeTip()
	if self._weeklyCompetitionData then
		self.m_tipTxt:setText(g.core.lang:get(420109, {
			name = self._weeklyCompetitionData:getScoreIconName(),
			score = self._weeklyCompetitionData:getCurBaseInfo().cfg["grade_" .. self._curSelectedIndex]
		}))
	end
end

function WeeklyCompetitionRankComp:_onRenderOtherRankList(arg_9_1, arg_9_2)
	arg_9_2:updateRankCell(self._rankList[arg_9_1 + 4], self._curSelectedIndex, self._weeklyCompetitionData:getScoreIconName())
end

function WeeklyCompetitionRankComp:_updateTopRank()
	for iter_10_0 = 1, 3 do
		if self._rankList[iter_10_0] then
			self["m_topCell" .. iter_10_0]:setVisible(true)
			self["m_topCell" .. iter_10_0]:updateTopRankCell(self._rankList[iter_10_0], self._curSelectedIndex)
		else
			self["m_topCell" .. iter_10_0]:setVisible(false)
		end
	end
end

function WeeklyCompetitionRankComp:_onClickServerBtn()
	var_0_1:pushPopup(require("app.view.module.commanderWorld.view.CommanderWorldMatchServerPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function WeeklyCompetitionRankComp:_onClickScreenCross()
	var_0_1:tip(g.core.lang:get(410304))
end

function WeeklyCompetitionRankComp:getServerType()
	return self._curSelectedIndex or var_0_0.SERVER_TYPE.LOCAL
end

return WeeklyCompetitionRankComp
