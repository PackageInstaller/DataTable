local var_0_0 = class("MainSequenceView")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.sequence = {
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

function var_0_0.MapSequence(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert({}, function(arg_3_0)
			if arg_2_0._exited then
				return
			end

			iter_2_1:Execute(arg_3_0)

			return
		end)
	end

	return {}
end

function var_0_0.Execute(arg_4_0, arg_4_1)
	if not pg.SeriesGuideMgr.GetInstance():isEnd() then
		arg_4_1()

		return
	end

	arg_4_0.executable = arg_4_0.executable or arg_4_0:MapSequence(arg_4_0.sequence)

	seriesAsync(arg_4_0.executable, arg_4_1)

	return
end

function var_0_0.Disable(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.sequence) do
		if iter_5_1.Clear ~= nil then
			iter_5_1:Clear()
		end
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0._exited = true

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.sequence) do
		if iter_6_1.Dispose ~= nil then
			iter_6_1:Dispose()
		end
	end

	arg_6_0.sequence = nil
	arg_6_0.executable = nil

	return
end

return var_0_0
