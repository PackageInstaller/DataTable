local NewEducateProxy = class("NewEducateProxy", import(".NetProxy"))

NewEducateProxy.RESOURCE_UPDATED = "NewEducateProxy.RESOURCE_UPDATED"
NewEducateProxy.ATTR_UPDATED = "NewEducateProxy.ATTR_UPDATED"
NewEducateProxy.PERSONALITY_UPDATED = "NewEducateProxy.PERSONALITY_UPDATED"
NewEducateProxy.TALENT_UPDATED = "NewEducateProxy.TALENT_UPDATED"
NewEducateProxy.STATUS_UPDATED = "NewEducateProxy.STATUS_UPDATED"
NewEducateProxy.TAROT_UPDATED = "NewEducateProxy.TAROT_UPDATED"
NewEducateProxy.POLAROID_UPDATED = "NewEducateProxy.POLAROID_UPDATED"
NewEducateProxy.ENDING_UPDATED = "NewEducateProxy.ENDING_UPDATED"
NewEducateProxy.NEXT_ROUND = "NewEducateProxy.NEXT_ROUND"

function NewEducateProxy:register()
	self.data = {}

	return
end

function NewEducateProxy:ReqDataCheck(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(pg.child2_data.all) do
		table.insert(var_2_0, function(arg_3_0)
			if not self.data[iter_2_1] then
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

	seriesAsync(var_2_0, function()
		existCall(arg_2_1)

		return
	end)

	return
end

function NewEducateProxy:GetChar(arg_5_1)
	return self.data[arg_5_1]
end

function NewEducateProxy:UpdateChar(arg_6_1, arg_6_2)
	local var_6_0 = NewEducateChar.New(arg_6_1)

	self.data[var_6_0.id] = var_6_0

	self.data[var_6_0.id]:InitPermanent(arg_6_2)
	self.data[var_6_0.id]:InitFSM(arg_6_1.fsm)

	return
end

function NewEducateProxy:ResetChar(arg_7_1, arg_7_2)
	local var_7_0 = self.data[arg_7_1]:GetPermanentData()

	var_7_0:AddGameCnt()

	self.data[arg_7_1] = NewEducateChar.New(arg_7_2)

	self.data[arg_7_1]:SetPermanent(var_7_0)
	self.data[arg_7_1]:InitFSM(arg_7_2.fsm)

	return
end

function NewEducateProxy:RefreshChar(arg_8_1, arg_8_2)
	self.data[arg_8_1] = NewEducateChar.New(arg_8_2)

	self.data[arg_8_1]:SetPermanent((self.data[arg_8_1]:GetPermanentData()))
	self.data[arg_8_1]:InitFSM(arg_8_2.fsm)
	NewEducateHelper.ClearEventPerformance(self.data[arg_8_1])

	return
end

function NewEducateProxy:SetCurChar(arg_9_1)
	self.curId = arg_9_1

	return
end

function NewEducateProxy:GetCurChar()
	return self.data[self.curId]
end

function NewEducateProxy:AddTempRound(arg_11_1)
	self.data[self.curId]:GetRoundData():AddTempCnt(arg_11_1)

	return
end

function NewEducateProxy:AddBuff(arg_12_1, arg_12_2)
	assert(pg.child2_benefit_list[arg_12_1], "child2_benefit_list不存在id" .. arg_12_1)

	if not pg.child2_benefit_list[arg_12_1] then
		return
	end

	self.data[self.curId]:AddBuff(arg_12_1, arg_12_2)

	if pg.child2_benefit_list[arg_12_1].type == NewEducateBuff.TYPE.TALENT then
		self:sendNotification(NewEducateProxy.TALENT_UPDATED)
	elseif pg.child2_benefit_list[arg_12_1].type == NewEducateBuff.TYPE.STATUS then
		self:sendNotification(NewEducateProxy.STATUS_UPDATED)
	else
		self:sendNotification(NewEducateProxy.TAROT_UPDATED)
	end

	return
end

function NewEducateProxy:UpdateResources(arg_13_1)
	self.data[self.curId]:SetResources(arg_13_1)
	self:sendNotification(NewEducateProxy.RESOURCE_UPDATED)

	return
end

function NewEducateProxy:UpdateRes(arg_14_1, arg_14_2)
	self.data[self.curId]:UpdateRes(arg_14_1, arg_14_2)
	self:sendNotification(NewEducateProxy.RESOURCE_UPDATED)

	return
end

function NewEducateProxy:UpdateAttrs(arg_15_1)
	self.data[self.curId]:SetAttrs(arg_15_1)
	self:sendNotification(NewEducateProxy.ATTR_UPDATED)

	return
end

function NewEducateProxy:UpdateAttr(arg_16_1, arg_16_2)
	self.data[self.curId]:UpdateAttr(arg_16_1, arg_16_2)
	self:sendNotification(NewEducateProxy.ATTR_UPDATED)

	if arg_16_1 == self.data[self.curId]:GetPersonalityId() then
		self:sendNotification(NewEducateProxy.PERSONALITY_UPDATED, {
			number = arg_16_2,
			oldTag = self.data[self.curId]:GetPersonalityTag()
		})
	end

	return
end

function NewEducateProxy:AddPolaroid(arg_17_1, arg_17_2)
	self.data[self.curId]:GetPermanentData():AddPolaroid(arg_17_1)
	self:sendNotification(NewEducateProxy.POLAROID_UPDATED)
	pg.m02:sendNotification(GAME.NEW_EDUCATE_TRACK, NewEducateTrackCommand.BuildDataPolariod(self.data[self.curId]:GetGameCnt(), self.data[self.curId]:GetRoundData().round, arg_17_1))

	return
end

function NewEducateProxy:AddActivatedEndings(arg_18_1)
	self.data[self.curId]:GetPermanentData():AddActivatedEndings(arg_18_1)
	self:sendNotification(NewEducateProxy.ENDING_UPDATED)

	return
end

function NewEducateProxy:AddFinishedEnding(arg_19_1)
	self.data[self.curId]:GetPermanentData():AddFinishedEnding(arg_19_1)
	self:sendNotification(NewEducateProxy.ENDING_UPDATED)

	return
end

function NewEducateProxy:UpdateUnlock(arg_20_1)
	arg_20_1 = arg_20_1 or self.curId

	if not self.data[arg_20_1] then
		return
	end

	self.data[arg_20_1]:GetPermanentData():UpdateSecretaryIDs(true)

	return
end

function NewEducateProxy:Costs(arg_21_1)
	underscore.each(arg_21_1, function(arg_22_0)
		self:Cost(arg_22_0)

		return
	end)

	return
end

function NewEducateProxy:Cost(arg_23_1)
	switch(arg_23_1.type, {
		[NewEducateConst.DROP_TYPE.ATTR] = function()
			self:UpdateAttr(arg_23_1.id, -arg_23_1.number)

			return
		end,
		[NewEducateConst.DROP_TYPE.RES] = function()
			self:UpdateRes(arg_23_1.id, -arg_23_1.number)

			return
		end
	}, function()
		assert(false, "非法消耗类型:" .. arg_23_1.type)

		return
	end)

	return
end

function NewEducateProxy:NextRound()
	self.data[self.curId]:OnNextRound()
	self:sendNotification(NewEducateProxy.NEXT_ROUND)

	return
end

function NewEducateProxy:GetStoryInfo()
	local var_28_0 = self.data[self.curId]:GetPaintingName()
	local var_28_1 = self.data[self.curId]:GetCallName()
	local var_28_2 = self.data[self.curId]:GetBGName()
end

function NewEducateProxy:RecordEnterTime(arg_29_1)
	self.enterTimeStamp = arg_29_1 and 0 or pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function NewEducateProxy:GetEnterTime()
	return self.enterTimeStamp or 0
end

function NewEducateProxy:remove()
	return
end

return NewEducateProxy
