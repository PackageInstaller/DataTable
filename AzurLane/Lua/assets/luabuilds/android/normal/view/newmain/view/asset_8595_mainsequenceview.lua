class = var_0_10000

local var_0_0 = var_0_10000("MainSequenceView")

function var_0_0.Ctor(arg_1_0)
	local var_1_0 = {}

	MainAwakeGuideSequence = var_1_10002
	var_1_0[1] = var_1_10002.New()
	MainRefundSequence = var_2
	var_1_0[2] = var_2.New()
	MainForcePlayerNameModificationSequence = var_2
	var_1_0[3] = var_2.New()
	MainRequestLoveLetterDataSequence = var_2
	var_1_0[4] = var_2.New()
	MainRequestNPCShipSequence = var_2
	var_1_0[5] = var_2.New()
	MainRequestVoteInfoSequence = var_2
	var_1_0[6] = var_2.New()
	MainStroySequence = var_2
	var_1_0[7] = var_2.New()
	MainRequestActDataSequence = var_2
	var_1_0[8] = var_2.New()
	MainUrShipReFetchSequence = var_2
	var_1_0[9] = var_2.New()
	MainUrgencySceneSequence = var_2
	var_1_0[10] = var_2.New()
	MainEquipmentChangeSequence = var_2
	var_1_0[11] = var_2.New()
	MainServerNoticeSequence = var_2
	var_1_0[12] = var_2.New()
	MainSublayerSequence = var_2
	var_1_0[13] = var_2.New()
	MainChapterTimeUpSequence = var_2
	var_1_0[14] = var_2.New()
	MainTechnologySequence = var_2
	var_1_0[15] = var_2.New()
	MainSubmitTaskSequence = var_2
	var_1_0[16] = var_2.New()
	MainRemoveNpcSequence = var_2
	var_1_0[17] = var_2.New()
	MainReplaceFoodSequence = var_2
	var_1_0[18] = var_2.New()
	MainOverDueEquipmentSequence = var_2
	var_1_0[19] = var_2.New()
	MainSkinDiscountItemTipSequence = var_2
	var_1_0[20] = var_2.New()
	MainOverDueSkinDiscountItemSequence = var_2
	var_1_0[21] = var_2.New()
	MainOverDueAttireSequence = var_2
	var_1_0[22] = var_2.New()
	MainOverDueSkinSequence = var_2
	var_1_0[23] = var_2.New()
	MainGuildSequence = var_2
	var_1_0[24] = var_2.New()
	MainMonthCardSequence = var_2
	var_1_0[25] = var_2.New()
	MainMetaSkillSequence = var_2
	var_1_0[26] = var_2.New()
	MainReceiveBossRushAwardsSequence = var_2
	var_1_0[27] = var_2.New()
	MainReceiveRemasterBossRushAwardsSequence = var_2
	var_1_0[28] = var_2.New()
	MainActivateInsTopicSequence = var_2
	var_1_0[29] = var_2.New()
	MainCheckTrackerSequence = var_2
	var_1_0[30] = var_2.New()
	MainNotificationWindowSequence = var_2
	var_1_0[31] = var_2.New()
	MainRequestFeastActDataSequence = var_2
	var_1_0[32] = var_2.New()
	MainActDataExpirationReminderSequence = var_2
	var_1_0[33] = var_2.New()
	MainRequestNewInstagramDataSequence = var_2
	var_1_0[34] = var_2.New()
	MainCalcHxSequence = var_2
	var_1_0[35] = var_2.New()
	MainGuideSequence = var_2
	var_1_0[36] = var_2.New()
	MainOpenSystemSequence = var_2
	var_1_0[37] = var_2.New()
	arg_1_0.sequence = var_1_0

	return
end

function var_0_0.MapSequence(arg_2_0, arg_2_1)
	local var_2_0 = {}

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_1) do
		table = var_1_10008

		var_1_10008.insert(var_2_0, function(arg_3_0)
			if arg_2_0._exited then
				return
			end

			local var_3_0 = iter_2_1

			var_1.Execute(var_3_0, arg_3_0)

			return
		end)
	end

	return var_2_0
end

function var_0_0.Execute(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.SeriesGuideMgr.GetInstance()

	if not var_2.isEnd(var_4_0) then
		arg_4_1()

		return
	end

	if not arg_4_0.executable then
		arg_4_0.executable = arg_4_0:MapSequence(arg_4_0.sequence)
	end

	seriesAsync = var_2

	var_2(arg_4_0.executable, arg_4_1)

	return
end

function var_0_0.Disable(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.sequence) do
		if iter_5_1.Clear ~= nil then
			iter_5_1:Clear()
		end
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0._exited = true
	ipairs = var_1

	for iter_6_0, iter_6_1 in var_1(arg_6_0.sequence) do
		if iter_6_1.Dispose ~= nil then
			iter_6_1:Dispose()
		end
	end

	arg_6_0.sequence = nil
	arg_6_0.executable = nil

	return
end

return var_0_0
