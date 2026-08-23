local var_0_0 = g.core.model.User.commanderWorldData
local var_0_1 = g.core.const.ConstMgr.CommanderWorldConst
local var_0_2 = g.core.module.ModuleManager
local CommanderWorldRankComp = class("CommanderWorldRankComp", require("app.fairyGUI.commanderWorld.UI_CommanderWorldRankComp"))

function CommanderWorldRankComp:ctor()
	self.m_serverBtn:addClickListener(handler(self, self._onClickServerBtn))
	self.m_screenCross:addClickListener((handler(self, self._onClickScreenCross)))

	self._curSelectedIndex = var_0_1.SERVER_TYPE.LOCAL

	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
	self.m_screenCross:setVisible(true)

	self._rankList = {}

	self.m_otherRankList:setVirtual()
	self.m_otherRankList:setItemRenderer(handler(self, self._onRenderOtherRankList))
	self:_initRankComp()
end

function CommanderWorldRankComp:_initRankComp()
	for iter_2_0 = 1, 3 do
		self["m_topCell" .. iter_2_0]:setVisible(false)
	end

	self:updateTab()
end

function CommanderWorldRankComp:updateTab()
	local var_3_0, var_3_1 = var_0_0:getActivityStageAndRemainTime()

	self.m_screenCross:setVisible(var_3_0 == var_0_1.STAGE.LOCALSERVICE)

	if var_3_0 == var_0_1.STAGE.LOCALSERVICE then
		self.m_crossBtn:setTitle(g.core.lang:get(410323, {
			date = g.core.common.ServerTime:getDateMDFormat(g.core.common.ServerTime:getTime() + var_3_1)
		}))
	end

	if var_3_0 == var_0_1.STAGE.CROSSSERVICE then
		self._curSelectedIndex = var_0_1.SERVER_TYPE.CROSS

		self.m_localBtn:setTitle(g.core.lang:get(410316))
		self.m_crossBtn:setTitle(g.core.lang:get(410327))
	end

	if var_3_0 == var_0_1.STAGE.REWARDDAY then
		self.m_localBtn:setTitle(g.core.lang:get(410316))
		self.m_crossBtn:setTitle(g.core.lang:get(410317))
	end

	self.m_tabSelController:setSelectedIndex(self._curSelectedIndex - 1)
	self:_updateGuaranteeTip()
end

function CommanderWorldRankComp:updateRankComp()
	local var_4_0 = var_0_0:getMyPersonScore()

	self.m_myScore:setText(var_4_0)

	local var_4_1 = var_0_0:getRankGuaranteedScore(self._curSelectedIndex)
	local var_4_2 = var_0_0:getMyRankInfo(self._curSelectedIndex)

	self.m_isShowRankController:setSelectedIndex(var_4_2 > 0 and var_4_1 <= var_4_0 and 1 or 0)
	self.m_myRank:setText(var_4_2)
	self:_updateRankList()
end

function CommanderWorldRankComp:_updateRankList()
	local var_5_0 = var_0_0:getRankShowInfos(self._curSelectedIndex)

	if not var_5_0.rankData then
		return
	end

	self._rankList = var_5_0.rankData

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

function CommanderWorldRankComp:_onTabSelChanged()
	self._curSelectedIndex = self.m_tabSelController:getSelectedIndex() + 1

	self:_updateGuaranteeTip()
	self:updateRankComp()
	self:dispatchCompEvent("Change_ServerType")
end

function CommanderWorldRankComp:_updateGuaranteeTip()
	self.m_tipTxt:setText(g.core.lang:get(410301, {
		score = var_0_0:getRankGuaranteedScore(self._curSelectedIndex)
	}))
end

function CommanderWorldRankComp:_onRenderOtherRankList(arg_8_1, arg_8_2)
	arg_8_2:updateRankCell(self._rankList[arg_8_1 + 4], self._curSelectedIndex)
end

function CommanderWorldRankComp:_updateTopRank()
	for iter_9_0 = 1, 3 do
		if self._rankList[iter_9_0] then
			self["m_topCell" .. iter_9_0]:setVisible(true)
			self["m_topCell" .. iter_9_0]:updateTopRankCell(self._rankList[iter_9_0], self._curSelectedIndex)
		else
			self["m_topCell" .. iter_9_0]:setVisible(false)
		end
	end
end

function CommanderWorldRankComp:_onClickServerBtn()
	var_0_2:pushPopup(require("app.view.module.commanderWorld.view.CommanderWorldMatchServerPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function CommanderWorldRankComp:_onClickScreenCross()
	var_0_2:tip(g.core.lang:get(410304))
end

function CommanderWorldRankComp:getServerType()
	return self._curSelectedIndex or var_0_1.SERVER_TYPE.LOCAL
end

return CommanderWorldRankComp
