local var_0_0 = class("NewEducateDropHelper")

function var_0_0.HandleDrops(arg_1_0)
	local var_1_0 = arg_1_0.base_drop or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert({}, {
			type = iter_1_1.type,
			id = iter_1_1.id,
			number = iter_1_1.number
		})
	end

	local var_1_1 = arg_1_0.benefit_drop or {}

	for iter_1_2, iter_1_3 in ipairs(var_1_1) do
		table.insert({}, {
			isBenefit = true,
			type = iter_1_3.type,
			id = iter_1_3.id,
			number = iter_1_3.number
		})
	end

	local var_1_2 = {}

	for iter_1_4, iter_1_5 in ipairs({}) do
		switch(iter_1_5.type, {
			[NewEducateConst.DROP_TYPE.ATTR] = function()
				local var_2_0 = var_0_0.AddAttrDrop(iter_1_5)

				if var_2_0 then
					table.insert(var_1_2, var_2_0)
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.RES] = function()
				local var_3_0 = var_0_0.AddResDrop(iter_1_5)

				if var_3_0 then
					table.insert(var_1_2, var_3_0)
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.POLAROID] = function()
				local var_4_0 = var_0_0.AddPolaroidDrop(iter_1_5)

				if var_4_0 then
					table.insert(var_1_2, var_4_0)
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.BUFF] = function()
				local var_5_0 = var_0_0.AddBuffDrop(iter_1_5)

				if var_5_0 then
					table.insert(var_1_2, var_5_0)
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.TAROT] = function()
				local var_6_0 = var_0_0.AddTarotDrop(iter_1_5)

				if var_6_0 then
					table.insert(var_1_2, var_6_0)
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.CHOOSE] = function()
				var_0_0.AddChooseState(iter_1_5)

				return
			end,
			[NewEducateConst.DROP_TYPE.UP_ENTRY] = function()
				var_0_0.AddUpEntryState(iter_1_5)

				return
			end,
			[NewEducateConst.DROP_TYPE.TEMP_ROUND] = function()
				var_0_0.AddTempRound(iter_1_5)

				return
			end
		})
	end

	var_0_0.UpdateBenefitDisplay(arg_1_0.display)

	return {}
end

function var_0_0.AddAttrDrop(arg_10_0)
	getProxy(NewEducateProxy):UpdateAttr(arg_10_0.id, arg_10_0.number)

	return pg.child2_attr[arg_10_0.id].type == NewEducateChar.ATTR_TYPE.ATTR and arg_10_0 or nil
end

function var_0_0.AddResDrop(arg_11_0)
	local var_11_0 = getProxy(NewEducateProxy)
	local var_11_1 = math.max(0, var_11_0:GetCurChar():GetRes(arg_11_0.id) + arg_11_0.number - pg.child2_resource[arg_11_0.id].max_value)

	var_11_0:UpdateRes(arg_11_0.id, arg_11_0.number)

	return var_11_1 and setmetatable({
		overflow = var_11_1
	}, {
		__index = arg_11_0
	}) or arg_11_0
end

function var_0_0.AddPolaroidDrop(arg_12_0)
	getProxy(NewEducateProxy):AddPolaroid(arg_12_0.id, arg_12_0.number)

	return arg_12_0
end

function var_0_0.AddBuffDrop(arg_13_0)
	if var_0_0.CheckReplaceTarot(arg_13_0) then
		var_0_0.AddReplaceTarotState(arg_13_0)

		return nil
	else
		getProxy(NewEducateProxy):AddBuff(arg_13_0.id, arg_13_0.number)

		local var_13_0 = pg.child2_benefit_list[arg_13_0.id]

		return arg_13_0.number > 0 and var_13_0.is_show == 1 and var_13_0.type ~= NewEducateBuff.TYPE.TALENT and arg_13_0 or nil
	end

	return
end

function var_0_0.AddTarotDrop(arg_14_0)
	getProxy(NewEducateProxy):AddBuff(arg_14_0.id, arg_14_0.number)

	return arg_14_0.number > 0 and pg.child2_benefit_list[arg_14_0.id].is_show == 1 and arg_14_0 or nil
end

function var_0_0.AddTempRound(arg_15_0)
	getProxy(NewEducateProxy):AddTempRound(arg_15_0.number)

	return
end

function var_0_0.CheckReplaceTarot(arg_16_0)
	if arg_16_0.number <= 0 then
		return false
	end

	return pg.child2_benefit_list[arg_16_0.id].type == NewEducateBuff.TYPE.TAROT and getProxy(NewEducateProxy):GetCurChar():GetTarotId()
end

function var_0_0.AddReplaceTarotState(arg_17_0)
	if arg_17_0.number <= 0 then
		return
	end

	local var_17_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

	for iter_17_0 = 1, arg_17_0.number do
		var_17_0:AddReplaceTarotState(arg_17_0.id)
	end

	pg.m02:sendNotification(GAME.NEW_EDUCATE_CHECK_PRIORITY_FSM)

	return
end

function var_0_0.AddChooseState(arg_18_0)
	if arg_18_0.number <= 0 then
		return
	end

	local var_18_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

	for iter_18_0 = 1, arg_18_0.number do
		var_18_0:AddChooseState(arg_18_0.id)
	end

	pg.m02:sendNotification(GAME.NEW_EDUCATE_CHECK_PRIORITY_FSM)

	return
end

function var_0_0.AddUpEntryState(arg_19_0)
	if arg_19_0.number <= 0 then
		return
	end

	local var_19_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

	for iter_19_0 = 1, arg_19_0.number do
		var_19_0:AddChooseUpEntryState()
	end

	pg.m02:sendNotification(GAME.NEW_EDUCATE_CHECK_PRIORITY_FSM)

	return
end

function var_0_0.UpdateBenefitDisplay(arg_20_0)
	local var_20_0 = getProxy(NewEducateProxy):GetCurChar():GetBenefitData()

	var_20_0:UpdateDisplayPct(arg_20_0.benefit_display)
	var_20_0:UpdateDisplayNum(arg_20_0.dollar_num_display)
	var_20_0:UpdateDisplayCounter(arg_20_0.counter)

	return
end

return var_0_0
