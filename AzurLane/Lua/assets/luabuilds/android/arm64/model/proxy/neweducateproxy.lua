local var_0_0 = class("NewEducateProxy", import(".NetProxy"))

var_0_0.RESOURCE_UPDATED = "NewEducateProxy.RESOURCE_UPDATED"
var_0_0.ATTR_UPDATED = "NewEducateProxy.ATTR_UPDATED"
var_0_0.PERSONALITY_UPDATED = "NewEducateProxy.PERSONALITY_UPDATED"
var_0_0.TALENT_UPDATED = "NewEducateProxy.TALENT_UPDATED"
var_0_0.STATUS_UPDATED = "NewEducateProxy.STATUS_UPDATED"
var_0_0.TAROT_UPDATED = "NewEducateProxy.TAROT_UPDATED"
var_0_0.POLAROID_UPDATED = "NewEducateProxy.POLAROID_UPDATED"
var_0_0.ENDING_UPDATED = "NewEducateProxy.ENDING_UPDATED"
var_0_0.NEXT_ROUND = "NewEducateProxy.NEXT_ROUND"

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}

	return
end

function var_0_0.ReqDataCheck(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(pg.child2_data.all) do
		table.insert({}, function(arg_3_0)
			if not arg_2_0.data[iter_2_1] then
				pg.m02:sendNotification(GAME.NEW_EDUCATE_REQUEST, {
					id = iter_2_1,
					callback = arg_3_0
				})
			else
				arg_3_0()
			end

			return
		end)
	end

	seriesAsync({}, function()
		existCall(arg_2_1)

		return
	end)

	return
end

function var_0_0.GetChar(arg_5_0, arg_5_1)
	return arg_5_0.data[arg_5_1]
end

function var_0_0.UpdateChar(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = NewEducateChar.New(arg_6_1)

	arg_6_0.data[var_6_0.id] = var_6_0

	arg_6_0.data[var_6_0.id]:InitPermanent(arg_6_2)
	arg_6_0.data[var_6_0.id]:InitFSM(arg_6_1.fsm)

	return
end

function var_0_0.ResetChar(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.data[arg_7_1]:GetPermanentData()

	var_7_0:AddGameCnt()

	arg_7_0.data[arg_7_1] = NewEducateChar.New(arg_7_2)

	arg_7_0.data[arg_7_1]:SetPermanent(var_7_0)
	arg_7_0.data[arg_7_1]:InitFSM(arg_7_2.fsm)

	return
end

function var_0_0.RefreshChar(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.data[arg_8_1] = NewEducateChar.New(arg_8_2)

	arg_8_0.data[arg_8_1]:SetPermanent((arg_8_0.data[arg_8_1]:GetPermanentData()))
	arg_8_0.data[arg_8_1]:InitFSM(arg_8_2.fsm)
	NewEducateHelper.ClearEventPerformance(arg_8_0.data[arg_8_1])

	return
end

function var_0_0.SetCurChar(arg_9_0, arg_9_1)
	arg_9_0.curId = arg_9_1

	return
end

function var_0_0.GetCurChar(arg_10_0)
	return arg_10_0.data[arg_10_0.curId]
end

function var_0_0.AddTempRound(arg_11_0, arg_11_1)
	arg_11_0.data[arg_11_0.curId]:GetRoundData():AddTempCnt(arg_11_1)

	return
end

function var_0_0.AddBuff(arg_12_0, arg_12_1, arg_12_2)
	assert(pg.child2_benefit_list[arg_12_1], "child2_benefit_list不存在id" .. arg_12_1)

	if not pg.child2_benefit_list[arg_12_1] then
		return
	end

	arg_12_0.data[arg_12_0.curId]:AddBuff(arg_12_1, arg_12_2)

	if pg.child2_benefit_list[arg_12_1].type == NewEducateBuff.TYPE.TALENT then
		arg_12_0:sendNotification(var_0_0.TALENT_UPDATED)
	elseif pg.child2_benefit_list[arg_12_1].type == NewEducateBuff.TYPE.STATUS then
		arg_12_0:sendNotification(var_0_0.STATUS_UPDATED)
	else
		arg_12_0:sendNotification(var_0_0.TAROT_UPDATED)
	end

	return
end

function var_0_0.UpdateResources(arg_13_0, arg_13_1)
	arg_13_0.data[arg_13_0.curId]:SetResources(arg_13_1)
	arg_13_0:sendNotification(var_0_0.RESOURCE_UPDATED)

	return
end

function var_0_0.UpdateRes(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.data[arg_14_0.curId]:UpdateRes(arg_14_1, arg_14_2)
	arg_14_0:sendNotification(var_0_0.RESOURCE_UPDATED)

	return
end

function var_0_0.UpdateAttrs(arg_15_0, arg_15_1)
	arg_15_0.data[arg_15_0.curId]:SetAttrs(arg_15_1)
	arg_15_0:sendNotification(var_0_0.ATTR_UPDATED)

	return
end

function var_0_0.UpdateAttr(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.data[arg_16_0.curId]:UpdateAttr(arg_16_1, arg_16_2)
	arg_16_0:sendNotification(var_0_0.ATTR_UPDATED)

	if arg_16_1 == arg_16_0.data[arg_16_0.curId]:GetPersonalityId() then
		arg_16_0:sendNotification(var_0_0.PERSONALITY_UPDATED, {
			number = arg_16_2,
			oldTag = arg_16_0.data[arg_16_0.curId]:GetPersonalityTag()
		})
	end

	return
end

function var_0_0.AddPolaroid(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.data[arg_17_0.curId]:GetPermanentData():AddPolaroid(arg_17_1)
	arg_17_0:sendNotification(var_0_0.POLAROID_UPDATED)
	pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataPolariod(arg_17_0.data[arg_17_0.curId]:GetGameCnt(), arg_17_0.data[arg_17_0.curId]:GetRoundData().round, arg_17_1))

	return
end

function var_0_0.AddActivatedEndings(arg_18_0, arg_18_1)
	arg_18_0.data[arg_18_0.curId]:GetPermanentData():AddActivatedEndings(arg_18_1)
	arg_18_0:sendNotification(var_0_0.ENDING_UPDATED)

	return
end

function var_0_0.AddFinishedEnding(arg_19_0, arg_19_1)
	arg_19_0.data[arg_19_0.curId]:GetPermanentData():AddFinishedEnding(arg_19_1)
	arg_19_0:sendNotification(var_0_0.ENDING_UPDATED)

	return
end

function var_0_0.UpdateUnlock(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or arg_20_0.curId

	if not arg_20_0.data[arg_20_1] then
		return
	end

	arg_20_0.data[arg_20_1]:GetPermanentData():UpdateSecretaryIDs(true)

	return
end

function var_0_0.Costs(arg_21_0, arg_21_1)
	underscore.each(arg_21_1, function(arg_22_0)
		arg_21_0:Cost(arg_22_0)

		return
	end)

	return
end

function var_0_0.Cost(arg_23_0, arg_23_1)
	switch(arg_23_1.type, {
		[NewEducateConst.DROP_TYPE.ATTR] = function()
			arg_23_0:UpdateAttr(arg_23_1.id, -arg_23_1.number)

			return
		end,
		[NewEducateConst.DROP_TYPE.RES] = function()
			arg_23_0:UpdateRes(arg_23_1.id, -arg_23_1.number)

			return
		end
	}, function()
		assert(false, "非法消耗类型:" .. arg_23_1.type)

		return
	end)

	return
end

function var_0_0.NextRound(arg_27_0)
	arg_27_0.data[arg_27_0.curId]:OnNextRound()
	arg_27_0:sendNotification(var_0_0.NEXT_ROUND)

	return
end

function var_0_0.GetStoryInfo(arg_28_0)
	local var_28_0 = arg_28_0.data[arg_28_0.curId]:GetPaintingName()
	local var_28_1 = arg_28_0.data[arg_28_0.curId]:GetCallName()
	local var_28_2 = arg_28_0.data[arg_28_0.curId]:GetBGName()
end

function var_0_0.RecordEnterTime(arg_29_0, arg_29_1)
	arg_29_0.enterTimeStamp = arg_29_1 and 0 or pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.GetEnterTime(arg_30_0)
	return arg_30_0.enterTimeStamp or 0
end

function var_0_0.remove(arg_31_0)
	return
end

return var_0_0
