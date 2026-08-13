class = var_0_10000

local var_0_0 = "NewEducateProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.RESOURCE_UPDATED = "NewEducateProxy.RESOURCE_UPDATED"
var_0_1.ATTR_UPDATED = "NewEducateProxy.ATTR_UPDATED"
var_0_1.PERSONALITY_UPDATED = "NewEducateProxy.PERSONALITY_UPDATED"
var_0_1.TALENT_UPDATED = "NewEducateProxy.TALENT_UPDATED"
var_0_1.STATUS_UPDATED = "NewEducateProxy.STATUS_UPDATED"
var_0_1.TAROT_UPDATED = "NewEducateProxy.TAROT_UPDATED"
var_0_1.POLAROID_UPDATED = "NewEducateProxy.POLAROID_UPDATED"
var_0_1.ENDING_UPDATED = "NewEducateProxy.ENDING_UPDATED"
var_0_1.NEXT_ROUND = "NewEducateProxy.NEXT_ROUND"

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}

	return
end

function var_0_1.ReqDataCheck(arg_2_0, arg_2_1)
	local var_2_0 = {}

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_2_0, iter_2_1 in var_1_10003(var_1_10005.child2_data.all) do
		table = var_1_10008

		var_1_10008.insert(var_2_0, function(arg_3_0)
			if not arg_2_0.data[iter_2_1] then
				pg = var_1

				local var_3_0 = var_1.m02
				local var_3_1 = var_1.sendNotification

				GAME = var_2_10004

				var_3_1(var_3_0, var_2_10004.NEW_EDUCATE_REQUEST, {
					id = iter_2_1,
					callback = arg_3_0
				})
			else
				arg_3_0()
			end

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_2_0, function()
		existCall = var_2_10000

		var_2_10000(arg_2_1)

		return
	end)

	return
end

function var_0_1.GetChar(arg_5_0, arg_5_1)
	return arg_5_0.data[arg_5_1]
end

function var_0_1.UpdateChar(arg_6_0, arg_6_1, arg_6_2)
	NewEducateChar = var_1_10003

	local var_6_0 = var_1_10003.New(arg_6_1)

	arg_6_0.data[var_6_0.id] = var_6_0

	local var_6_1 = arg_6_0.data[var_6_0.id]

	var_4.InitPermanent(var_6_1, arg_6_2)

	local var_6_2 = arg_6_0.data[var_6_0.id]

	var_4.InitFSM(var_6_2, arg_6_1.fsm)

	return
end

function var_0_1.ResetChar(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.data[arg_7_1]
	local var_7_1 = var_3.GetPermanentData(var_7_0)

	var_3.AddGameCnt(var_7_1)

	local var_7_2 = arg_7_0.data

	NewEducateChar = var_7_0
	var_7_2[arg_7_1] = var_7_0.New(arg_7_2)

	local var_7_3 = arg_7_0.data[arg_7_1]

	var_4.SetPermanent(var_7_3, var_3)

	local var_7_4 = arg_7_0.data[arg_7_1]

	var_4.InitFSM(var_7_4, arg_7_2.fsm)

	return
end

function var_0_1.RefreshChar(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.data[arg_8_1]
	local var_8_1 = var_3.GetPermanentData(var_8_0)
	local var_8_2 = arg_8_0.data

	NewEducateChar = var_8_0
	var_8_2[arg_8_1] = var_8_0.New(arg_8_2)

	local var_8_3 = arg_8_0.data[arg_8_1]

	var_4.SetPermanent(var_8_3, var_8_1)

	local var_8_4 = arg_8_0.data[arg_8_1]

	var_4.InitFSM(var_8_4, arg_8_2.fsm)

	NewEducateHelper = var_4

	var_4.ClearEventPerformance(arg_8_0.data[arg_8_1])

	return
end

function var_0_1.SetCurChar(arg_9_0, arg_9_1)
	arg_9_0.curId = arg_9_1

	return
end

function var_0_1.GetCurChar(arg_10_0)
	return arg_10_0.data[arg_10_0.curId]
end

function var_0_1.AddTempRound(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.data[arg_11_0.curId]
	local var_11_1 = var_2.GetRoundData(var_11_0)

	var_2.AddTempCnt(var_11_1, arg_11_1)

	return
end

function var_0_1.AddBuff(arg_12_0, arg_12_1, arg_12_2)
	assert = var_1_10003
	pg = var_1_10005

	var_1_10003(var_1_10005.child2_benefit_list[arg_12_1], "child2_benefit_list不存在id" .. arg_12_1)

	pg = var_1_10003

	if not var_1_10003.child2_benefit_list[arg_12_1] then
		return
	end

	local var_12_0 = arg_12_0.data[arg_12_0.curId]

	var_3.AddBuff(var_12_0, arg_12_1, arg_12_2)

	pg = var_3

	local var_12_1 = var_3.child2_benefit_list[arg_12_1].type

	NewEducateBuff = var_4

	if var_12_1 == var_4.TYPE.TALENT then
		arg_12_0:sendNotification(var_0_1.TALENT_UPDATED)
	else
		NewEducateBuff = var_4

		if var_12_1 == var_4.TYPE.STATUS then
			arg_12_0:sendNotification(var_0_1.STATUS_UPDATED)
		else
			arg_12_0:sendNotification(var_0_1.TAROT_UPDATED)
		end
	end

	return
end

function var_0_1.UpdateResources(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.data[arg_13_0.curId]

	var_2.SetResources(var_13_0, arg_13_1)
	arg_13_0:sendNotification(var_0_1.RESOURCE_UPDATED)

	return
end

function var_0_1.UpdateRes(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.data[arg_14_0.curId]

	var_3.UpdateRes(var_14_0, arg_14_1, arg_14_2)
	arg_14_0:sendNotification(var_0_1.RESOURCE_UPDATED)

	return
end

function var_0_1.UpdateAttrs(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.data[arg_15_0.curId]

	var_2.SetAttrs(var_15_0, arg_15_1)
	arg_15_0:sendNotification(var_0_1.ATTR_UPDATED)

	return
end

function var_0_1.UpdateAttr(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.data[arg_16_0.curId]
	local var_16_1 = var_3.GetPersonalityTag(var_16_0)
	local var_16_2 = arg_16_0.data[arg_16_0.curId]

	var_4.UpdateAttr(var_16_2, arg_16_1, arg_16_2)
	arg_16_0:sendNotification(var_0_1.ATTR_UPDATED)

	local var_16_3 = arg_16_0.data[arg_16_0.curId]

	if arg_16_1 == var_4.GetPersonalityId(var_16_3) then
		arg_16_0:sendNotification(var_0_1.PERSONALITY_UPDATED, {
			number = arg_16_2,
			oldTag = var_16_1
		})
	end

	return
end

function var_0_1.AddPolaroid(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.data[arg_17_0.curId]
	local var_17_1 = var_3.GetPermanentData(var_17_0)

	var_3.AddPolaroid(var_17_1, arg_17_1)
	arg_17_0:sendNotification(var_0_1.POLAROID_UPDATED)

	pg = var_3

	local var_17_2 = var_3.m02
	local var_17_3 = var_3.sendNotification

	GAME = var_6

	local var_17_4 = var_6.NEW_EDUCATE_TRACK

	NewEducateTrackCommand = var_1_10007

	local var_17_5 = var_1_10007.BuildDataPolariod
	local var_17_6 = arg_17_0.data[arg_17_0.curId]
	local var_17_7 = var_9.GetGameCnt(var_17_6)
	local var_17_8 = arg_17_0.data[arg_17_0.curId]

	var_17_3(var_17_2, var_17_4, var_17_5(var_17_7, var_10.GetRoundData(var_17_8).round, arg_17_1))

	return
end

function var_0_1.AddActivatedEndings(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.data[arg_18_0.curId]
	local var_18_1 = var_2.GetPermanentData(var_18_0)

	var_2.AddActivatedEndings(var_18_1, arg_18_1)
	arg_18_0:sendNotification(var_0_1.ENDING_UPDATED)

	return
end

function var_0_1.AddFinishedEnding(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.data[arg_19_0.curId]
	local var_19_1 = var_2.GetPermanentData(var_19_0)

	var_2.AddFinishedEnding(var_19_1, arg_19_1)
	arg_19_0:sendNotification(var_0_1.ENDING_UPDATED)

	return
end

function var_0_1.UpdateUnlock(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or arg_20_0.curId

	if not arg_20_0.data[arg_20_1] then
		return
	end

	local var_20_0 = arg_20_0.data[arg_20_1]
	local var_20_1 = var_2.GetPermanentData(var_20_0)

	var_2.UpdateSecretaryIDs(var_20_1, true)

	return
end

function var_0_1.Costs(arg_21_0, arg_21_1)
	underscore = var_1_10002

	var_1_10002.each(arg_21_1, function(arg_22_0)
		local var_22_0 = arg_21_0

		var_1.Cost(var_22_0, arg_22_0)

		return
	end)

	return
end

function var_0_1.Cost(arg_23_0, arg_23_1)
	switch = var_1_10002

	local var_23_0 = arg_23_1.type
	local var_23_1 = {}

	NewEducateConst = var_1_10006
	var_23_1[var_1_10006.DROP_TYPE.ATTR] = function()
		local var_24_0 = arg_23_0

		var_0.UpdateAttr(var_24_0, arg_23_1.id, -arg_23_1.number)

		return
	end
	NewEducateConst = var_6
	var_23_1[var_6.DROP_TYPE.RES] = function()
		local var_25_0 = arg_23_0

		var_0.UpdateRes(var_25_0, arg_23_1.id, -arg_23_1.number)

		return
	end

	var_1_10002(var_23_0, var_23_1, function()
		assert = var_2_10000

		var_2_10000(false, "非法消耗类型:" .. arg_23_1.type)

		return
	end)

	return
end

function var_0_1.NextRound(arg_27_0)
	local var_27_0 = arg_27_0.data[arg_27_0.curId]

	var_1.OnNextRound(var_27_0)
	arg_27_0:sendNotification(var_0_1.NEXT_ROUND)

	return
end

function var_0_1.GetStoryInfo(arg_28_0)
	local var_28_0 = arg_28_0.data[arg_28_0.curId]
	local var_28_1 = var_1.GetPaintingName(var_28_0)
	local var_28_2 = var_1:GetCallName()
	local var_28_3 = var_1:GetBGName()
end

function var_0_1.RecordEnterTime(arg_29_0, arg_29_1)
	if arg_29_1 then
		var_1_10002 = 0
	else
		pg = var_1_10002

		local var_29_0 = var_1_10002.TimeMgr.GetInstance()

		var_1_10002 = var_1_10002.GetServerTime(var_29_0)
	end

	arg_29_0.enterTimeStamp = var_1_10002

	return
end

function var_0_1.GetEnterTime(arg_30_0)
	local var_30_0

	if not arg_30_0.enterTimeStamp then
		var_30_0 = 0
	end

	return var_30_0
end

function var_0_1.remove(arg_31_0)
	return
end

return var_0_1
