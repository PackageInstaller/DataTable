local AllianceTrialRankAwardCell = class("AllianceTrialRankAwardCell", require("app.fairyGUI.allianceTrial.UI_AllianceTrialRankAwardCell"))

function AllianceTrialRankAwardCell:ctor()
	self._awardList = {}

	self:_initListView()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function AllianceTrialRankAwardCell:_initListView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function AllianceTrialRankAwardCell:_onRenderAwardList(arg_3_1, arg_3_2)
	self._awardList[arg_3_1 + 1].scaleIndex = 4

	arg_3_2:updateIcon(self._awardList[arg_3_1 + 1])
end

function AllianceTrialRankAwardCell:updateAwardCell(arg_4_1, arg_4_2)
	if not arg_4_2 then
		return
	end

	self.m_isShowBgController:setSelectedIndex(arg_4_1 % 2 == 0 and 1 or 0)

	local var_4_0 = arg_4_2.minRank
	local var_4_1 = arg_4_2.maxRank
	local var_4_2 = arg_4_2.minRank == arg_4_2.maxRank
	local var_4_3 = arg_4_2.minRank == arg_4_2.maxRank and var_4_0 <= 3

	if arg_4_2.minRank == arg_4_2.maxRank and var_4_0 <= 3 then
		self.m_rankIndexComp:updateRankIndex({
			rank = var_4_0
		})
	else
		self.m_rankText:setText((var_4_2 or nil) and (g.core.lang:get(302509, {
			rank = var_4_0
		}) or g.core.lang:get(302510, {
			rank1 = var_4_0,
			rank2 = var_4_1
		})))
	end

	self.m_isTopThreeController:setSelectedIndex(var_4_3 and 1 or 0)

	self._awardList = arg_4_2.data or {}

	self.m_awardList:setNumItems(#self._awardList)
end

return AllianceTrialRankAwardCell
