local var_0_1 = g.core.const.ConstMgr.NewSlgConst.REPORT
local NewSlgBattleReportCell = class("NewSlgBattleReportCell", require("app.fairyGUI.newSlg.UI_NewSlgBattleReportCell"))

function NewSlgBattleReportCell:ctor()
	self._report = nil

	self:_initCell()
end

function NewSlgBattleReportCell:_initCell()
	self.m_detailBtn:addClickListener(handler(self, self._onClickReport))
	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRender))
end

function NewSlgBattleReportCell:updateReportCell(arg_3_1, arg_3_2, arg_3_3)
	self._report = arg_3_1
	self._score = arg_3_1.score

	g.core.model.User.newSlgData:viewedBattleReport(arg_3_1.report_id)

	if arg_3_2 then
		self.m_newComp:setCtrlState("style", {
			index = 2
		})
	else
		self.m_newComp:setCtrlState("style", {
			index = 0
		})
	end

	self.m_detailComp:updateReportDetailInfo(self._report)
	self.m_detailBtn:setSelected(arg_3_3)

	self._awards = self:_filterAwards(arg_3_1.awards or {})

	local var_3_0 = #self._awards

	if arg_3_1.is_win then
		if self._score and self._score > 0 then
			var_3_0 = var_3_0 + 1
		end
	elseif (arg_3_1.report_type == var_0_1.SVR_TYPE.NEW_SLG_REPORT_TYPE_CITY or arg_3_1.report_type == var_0_1.SVR_TYPE.NEW_SLG_REPORT_TYPE_FARM) and self._score and self._score > 0 then
		var_3_0 = var_3_0 + 1
	end

	if var_3_0 > 0 then
		self.m_rewardList:setNumItems(var_3_0)
		self:setCtrlState("hasReward", {
			index = 1
		})
	else
		self:setCtrlState("hasReward", {
			index = 0
		})
	end

	local var_3_1 = self._report.battle_num

	self.m_detailBtn:setTitle(self._report.battle_num)
	self.m_detailBtn:setVisible(var_3_1 > 1)
end

function NewSlgBattleReportCell:_filterAwards(arg_4_1)
	local var_4_0 = {}
	local var_4_1 = -1
	local var_4_2 = {
		["9_117"] = true,
		["3_2115"] = true,
		["9_118"] = true,
		["9_119"] = true
	}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if var_4_2[table.concat({
			iter_4_1.type,
			iter_4_1.value
		}, "_")] then
			var_4_1 = iter_4_0
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_1) do
		if var_4_1 < iter_4_2 then
			var_4_0[#var_4_0 + 1] = iter_4_3
		end
	end

	return var_4_0
end

function NewSlgBattleReportCell:_onClickReport()
	self:dispatchCompEvent("changeDetail", {
		id = self._report.report_id
	})
end

function NewSlgBattleReportCell:_onRewardItemRender(arg_6_1, arg_6_2)
	if self._awards and self._awards[arg_6_1 + 1] then
		arg_6_2:updateReportReward(self._awards[arg_6_1 + 1])
	else
		arg_6_2:updateReportReward(nil, true, self._score or 0)
	end
end

return NewSlgBattleReportCell
