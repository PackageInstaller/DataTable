local MainSequenceView = class("MainSequenceView")

function MainSequenceView:Ctor()
	self.sequence = {
		MainAwakeGuideSequence.New(),
		MainRefundSequence.New(),
		MainForcePlayerNameModificationSequence.New(),
		MainRequestLoveLetterDataSequence.New(),
		MainRequestNPCShipSequence.New(),
		MainRequestVoteInfoSequence.New(),
		MainStroySequence.New(),
		MainRequestActDataSequence.New(),
		MainUrShipReFetchSequence.New(),
		MainUrgencySceneSequence.New(),
		MainEquipmentChangeSequence.New(),
		MainServerNoticeSequence.New(),
		MainSublayerSequence.New(),
		MainChapterTimeUpSequence.New(),
		MainTechnologySequence.New(),
		MainSubmitTaskSequence.New(),
		MainRemoveNpcSequence.New(),
		MainReplaceFoodSequence.New(),
		MainOverDueEquipmentSequence.New(),
		MainSkinDiscountItemTipSequence.New(),
		MainOverDueSkinDiscountItemSequence.New(),
		MainOverDueAttireSequence.New(),
		MainOverDueSkinSequence.New(),
		MainGuildSequence.New(),
		MainMonthCardSequence.New(),
		MainMetaSkillSequence.New(),
		MainReceiveBossRushAwardsSequence.New(),
		MainReceiveRemasterBossRushAwardsSequence.New(),
		MainActivateInsTopicSequence.New(),
		MainCheckTrackerSequence.New(),
		MainNotificationWindowSequence.New(),
		MainRequestFeastActDataSequence.New(),
		MainActDataExpirationReminderSequence.New(),
		MainRequestNewInstagramDataSequence.New(),
		MainCalcHxSequence.New(),
		MainGuideSequence.New(),
		MainOpenSystemSequence.New()
	}

	return
end

function MainSequenceView:MapSequence(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(var_2_0, function(arg_3_0)
			if self._exited then
				return
			end

			iter_2_1:Execute(arg_3_0)

			return
		end)
	end

	return var_2_0
end

function MainSequenceView:Execute(arg_4_1)
	if not pg.SeriesGuideMgr.GetInstance():isEnd() then
		arg_4_1()

		return
	end

	self.executable = self.executable or self:MapSequence(self.sequence)

	seriesAsync(self.executable, arg_4_1)

	return
end

function MainSequenceView:Disable()
	for iter_5_0, iter_5_1 in ipairs(self.sequence) do
		if iter_5_1.Clear ~= nil then
			iter_5_1:Clear()
		end
	end

	return
end

function MainSequenceView:Dispose()
	self._exited = true

	for iter_6_0, iter_6_1 in ipairs(self.sequence) do
		if iter_6_1.Dispose ~= nil then
			iter_6_1:Dispose()
		end
	end

	self.sequence = nil
	self.executable = nil

	return
end

return MainSequenceView
