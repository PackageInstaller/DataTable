local NewEducateDropHelper = class("NewEducateDropHelper")

function NewEducateDropHelper:HandleDrops()
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(self.base_drop or {}) do
		table.insert(var_1_0, {
			type = iter_1_1.type,
			id = iter_1_1.id,
			number = iter_1_1.number
		})
	end

	for iter_1_2, iter_1_3 in ipairs(self.benefit_drop or {}) do
		table.insert(var_1_0, {
			isBenefit = true,
			type = iter_1_3.type,
			id = iter_1_3.id,
			number = iter_1_3.number
		})
	end

	local var_1_1 = {}

	for iter_1_4, iter_1_5 in ipairs(var_1_0) do
		switch(iter_1_5.type, {
			[NewEducateConst.DROP_TYPE.ATTR] = function()
				local var_2_0 = NewEducateDropHelper.AddAttrDrop(iter_1_5)

				if var_2_0 then
					table.insert(var_1_1, var_2_0)
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.RES] = function()
				local var_3_0 = NewEducateDropHelper.AddResDrop(iter_1_5)

				if var_3_0 then
					table.insert(var_1_1, var_3_0)
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.POLAROID] = function()
				local var_4_0 = NewEducateDropHelper.AddPolaroidDrop(iter_1_5)

				if var_4_0 then
					table.insert(var_1_1, var_4_0)
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.BUFF] = function()
				local var_5_0 = NewEducateDropHelper.AddBuffDrop(iter_1_5)

				if var_5_0 then
					table.insert(var_1_1, var_5_0)
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.TAROT] = function()
				local var_6_0 = NewEducateDropHelper.AddTarotDrop(iter_1_5)

				if var_6_0 then
					table.insert(var_1_1, var_6_0)
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.CHOOSE] = function()
				NewEducateDropHelper.AddChooseState(iter_1_5)

				return
			end,
			[NewEducateConst.DROP_TYPE.UP_ENTRY] = function()
				NewEducateDropHelper.AddUpEntryState(iter_1_5)

				return
			end,
			[NewEducateConst.DROP_TYPE.TEMP_ROUND] = function()
				NewEducateDropHelper.AddTempRound(iter_1_5)

				return
			end
		})
	end

	NewEducateDropHelper.UpdateBenefitDisplay(self.display)

	return var_1_1
end

function NewEducateDropHelper:AddAttrDrop()
	getProxy(NewEducateProxy):UpdateAttr(self.id, self.number)

	return pg.child2_attr[self.id].type == NewEducateChar.ATTR_TYPE.ATTR and self or nil
end

function NewEducateDropHelper:AddResDrop()
	local var_11_0 = getProxy(NewEducateProxy)
	local var_11_1 = math.max(0, var_11_0:GetCurChar():GetRes(self.id) + self.number - pg.child2_resource[self.id].max_value)

	var_11_0:UpdateRes(self.id, self.number)

	return var_11_1 and setmetatable({
		overflow = var_11_1
	}, {
		__index = self
	}) or self
end

function NewEducateDropHelper:AddPolaroidDrop()
	getProxy(NewEducateProxy):AddPolaroid(self.id, self.number)

	return self
end

function NewEducateDropHelper:AddBuffDrop()
	if NewEducateDropHelper.CheckReplaceTarot(self) then
		NewEducateDropHelper.AddReplaceTarotState(self)

		return nil
	else
		getProxy(NewEducateProxy):AddBuff(self.id, self.number)

		local var_13_0 = pg.child2_benefit_list[self.id]

		return self.number > 0 and var_13_0.is_show == 1 and var_13_0.type ~= NewEducateBuff.TYPE.TALENT and self or nil
	end

	return
end

function NewEducateDropHelper:AddTarotDrop()
	getProxy(NewEducateProxy):AddBuff(self.id, self.number)

	return self.number > 0 and pg.child2_benefit_list[self.id].is_show == 1 and self or nil
end

function NewEducateDropHelper:AddTempRound()
	getProxy(NewEducateProxy):AddTempRound(self.number)

	return
end

function NewEducateDropHelper:CheckReplaceTarot()
	if self.number <= 0 then
		return false
	end

	return pg.child2_benefit_list[self.id].type == NewEducateBuff.TYPE.TAROT and getProxy(NewEducateProxy):GetCurChar():GetTarotId()
end

function NewEducateDropHelper:AddReplaceTarotState()
	if self.number <= 0 then
		return
	end

	local var_17_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

	for iter_17_0 = 1, self.number do
		var_17_0:AddReplaceTarotState(self.id)
	end

	pg.m02:sendNotification(GAME.NEW_EDUCATE_CHECK_PRIORITY_FSM)

	return
end

function NewEducateDropHelper:AddChooseState()
	if self.number <= 0 then
		return
	end

	local var_18_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

	for iter_18_0 = 1, self.number do
		var_18_0:AddChooseState(self.id)
	end

	pg.m02:sendNotification(GAME.NEW_EDUCATE_CHECK_PRIORITY_FSM)

	return
end

function NewEducateDropHelper:AddUpEntryState()
	if self.number <= 0 then
		return
	end

	local var_19_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

	for iter_19_0 = 1, self.number do
		var_19_0:AddChooseUpEntryState()
	end

	pg.m02:sendNotification(GAME.NEW_EDUCATE_CHECK_PRIORITY_FSM)

	return
end

function NewEducateDropHelper:UpdateBenefitDisplay()
	local var_20_0 = getProxy(NewEducateProxy):GetCurChar():GetBenefitData()

	var_20_0:UpdateDisplayPct(self.benefit_display)
	var_20_0:UpdateDisplayNum(self.dollar_num_display)
	var_20_0:UpdateDisplayCounter(self.counter)

	return
end

return NewEducateDropHelper
