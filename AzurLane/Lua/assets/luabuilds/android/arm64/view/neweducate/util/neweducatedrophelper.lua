class = var_0_10000

local var_0_0 = var_0_10000("NewEducateDropHelper")

function var_0_0.HandleDrops(arg_1_0)
	local var_1_0 = {}

	ipairs = var_1_10002

	local var_1_1

	if not arg_1_0.base_drop then
		var_1_1 = {}
	end

	for iter_1_0, iter_1_1 in var_1_10002(var_1_1) do
		local var_1_2 = {
			type = iter_1_1.type,
			id = iter_1_1.id,
			number = iter_1_1.number
		}

		table = var_1_10008

		var_1_10008.insert(var_1_0, var_1_2)
	end

	ipairs = var_2

	local var_1_3

	if not arg_1_0.benefit_drop then
		var_1_3 = {}
	end

	for iter_1_2, iter_1_3 in var_2(var_1_3) do
		local var_1_4 = {
			isBenefit = true,
			type = iter_1_3.type,
			id = iter_1_3.id,
			number = iter_1_3.number
		}

		table = var_1_10008

		var_1_10008.insert(var_1_0, var_1_4)
	end

	local var_1_5 = {}

	ipairs = var_3

	for iter_1_4, iter_1_5 in var_3(var_1_0) do
		switch = var_1_10008

		local var_1_6 = iter_1_5.type
		local var_1_7 = {}

		NewEducateConst = var_1_10012
		var_1_7[var_1_10012.DROP_TYPE.ATTR] = function()
			if var_0_0.AddAttrDrop(iter_1_5) then
				table = var_2_10001

				var_2_10001.insert(var_1_5, var_0)
			end

			return
		end
		NewEducateConst = var_1_10012
		var_1_7[var_1_10012.DROP_TYPE.RES] = function()
			if var_0_0.AddResDrop(iter_1_5) then
				table = var_2_10001

				var_2_10001.insert(var_1_5, var_0)
			end

			return
		end
		NewEducateConst = var_1_10012
		var_1_7[var_1_10012.DROP_TYPE.POLAROID] = function()
			if var_0_0.AddPolaroidDrop(iter_1_5) then
				table = var_2_10001

				var_2_10001.insert(var_1_5, var_0)
			end

			return
		end
		NewEducateConst = var_1_10012
		var_1_7[var_1_10012.DROP_TYPE.BUFF] = function()
			if var_0_0.AddBuffDrop(iter_1_5) then
				table = var_2_10001

				var_2_10001.insert(var_1_5, var_0)
			end

			return
		end
		NewEducateConst = var_1_10012
		var_1_7[var_1_10012.DROP_TYPE.TAROT] = function()
			if var_0_0.AddTarotDrop(iter_1_5) then
				table = var_2_10001

				var_2_10001.insert(var_1_5, var_0)
			end

			return
		end
		NewEducateConst = var_1_10012
		var_1_7[var_1_10012.DROP_TYPE.CHOOSE] = function()
			var_0_0.AddChooseState(iter_1_5)

			return
		end
		NewEducateConst = var_1_10012
		var_1_7[var_1_10012.DROP_TYPE.UP_ENTRY] = function()
			var_0_0.AddUpEntryState(iter_1_5)

			return
		end
		NewEducateConst = var_1_10012
		var_1_7[var_1_10012.DROP_TYPE.TEMP_ROUND] = function()
			var_0_0.AddTempRound(iter_1_5)

			return
		end

		var_1_10008(var_1_6, var_1_7)
	end

	var_0_0.UpdateBenefitDisplay(arg_1_0.display)

	return var_1_5
end

function var_0_0.AddAttrDrop(arg_10_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003)

	var_1.UpdateAttr(var_10_0, arg_10_0.id, arg_10_0.number)

	pg = var_1

	local var_10_1 = var_1.child2_attr[arg_10_0.id].type

	NewEducateChar = var_2

	return var_10_1 == var_2.ATTR_TYPE.ATTR and arg_10_0 or nil
end

function var_0_0.AddResDrop(arg_11_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)
	local var_11_1 = var_1.GetCurChar(var_11_0)
	local var_11_2 = var_2.GetRes(var_11_1, arg_11_0.id) + arg_11_0.number

	math = var_3

	local var_11_3 = var_3.max
	local var_11_4 = 0

	pg = var_1_10006

	local var_11_5 = var_11_3(var_11_4, var_11_2 - var_1_10006.child2_resource[arg_11_0.id].max_value)

	var_1:UpdateRes(arg_11_0.id, arg_11_0.number)

	local var_11_6 = {}

	if var_11_5 then
		setmetatable = var_11_4
		var_11_6 = var_11_4({
			overflow = var_11_5
		}, {
			__index = arg_11_0
		})
	else
		var_11_6 = arg_11_0
	end

	return var_11_6
end

function var_0_0.AddPolaroidDrop(arg_12_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)

	var_1.AddPolaroid(var_12_0, arg_12_0.id, arg_12_0.number)

	return arg_12_0
end

function var_0_0.AddBuffDrop(arg_13_0)
	if var_0_0.CheckReplaceTarot(arg_13_0) then
		var_0_0.AddReplaceTarotState(arg_13_0)

		do return nil end

		goto label_13_1
	end

	getProxy = var_1
	NewEducateProxy = var_3

	local var_13_0 = var_1(var_3)

	var_1.AddBuff(var_13_0, arg_13_0.id, arg_13_0.number)

	pg = var_1

	local var_13_1 = var_1.child2_benefit_list[arg_13_0.id]
	local var_13_2 = arg_13_0.number

	if 0 < var_13_2 and var_13_1.is_show == 1 then
		do
			local var_13_3 = var_13_1.type

			NewEducateBuff = var_3

			local var_13_4

			if var_13_3 == var_3.TYPE.TALENT or not arg_13_0 then
				::label_13_0::

				var_13_4 = nil
			end

			return var_13_4
		end

		::label_13_1::

		return
	end
end

function var_0_0.AddTarotDrop(arg_14_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)

	var_1.AddBuff(var_14_0, arg_14_0.id, arg_14_0.number)

	if arg_14_0.number > 0 then
		pg = var_1

		local var_14_1

		if var_1.child2_benefit_list[arg_14_0.id].is_show ~= 1 or not arg_14_0 then
			::label_14_0::

			var_14_1 = nil
		end

		return var_14_1
	end
end

function var_0_0.AddTempRound(arg_15_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)

	var_1.AddTempRound(var_15_0, arg_15_0.number)

	return
end

function var_0_0.CheckReplaceTarot(arg_16_0)
	if arg_16_0.number <= 0 then
		return false
	end

	pg = var_1

	local var_16_0 = var_1.child2_benefit_list[arg_16_0.id].type

	NewEducateBuff = var_2

	local var_16_3

	if var_16_0 == var_2.TYPE.TAROT then
		getProxy = var_2
		NewEducateProxy = var_1_10004

		local var_16_1 = var_2(var_1_10004)
		local var_16_2 = var_2.GetCurChar(var_16_1)

		var_16_3 = var_2.GetTarotId(var_16_2)
	else
		var_16_3 = false
	end

	if false then
		var_16_3 = true
	end

	return var_16_3
end

function var_0_0.AddReplaceTarotState(arg_17_0)
	if arg_17_0.number <= 0 then
		return
	end

	getProxy = var_1
	NewEducateProxy = var_1_10003

	local var_17_0 = var_1(var_1_10003)
	local var_17_1 = var_1.GetCurChar(var_17_0)
	local var_17_2 = var_1.GetFSM(var_17_1)

	for iter_17_0 = 1, arg_17_0.number do
		var_17_2:AddReplaceTarotState(arg_17_0.id)
	end

	pg = var_2

	local var_17_3 = var_2.m02
	local var_17_4 = var_2.sendNotification

	GAME = iter_17_0

	var_17_4(var_17_3, iter_17_0.NEW_EDUCATE_CHECK_PRIORITY_FSM)

	return
end

function var_0_0.AddChooseState(arg_18_0)
	if arg_18_0.number <= 0 then
		return
	end

	getProxy = var_1
	NewEducateProxy = var_1_10003

	local var_18_0 = var_1(var_1_10003)
	local var_18_1 = var_1.GetCurChar(var_18_0)
	local var_18_2 = var_1.GetFSM(var_18_1)

	for iter_18_0 = 1, arg_18_0.number do
		var_18_2:AddChooseState(arg_18_0.id)
	end

	pg = var_2

	local var_18_3 = var_2.m02
	local var_18_4 = var_2.sendNotification

	GAME = iter_18_0

	var_18_4(var_18_3, iter_18_0.NEW_EDUCATE_CHECK_PRIORITY_FSM)

	return
end

function var_0_0.AddUpEntryState(arg_19_0)
	if arg_19_0.number <= 0 then
		return
	end

	getProxy = var_1
	NewEducateProxy = var_1_10003

	local var_19_0 = var_1(var_1_10003)
	local var_19_1 = var_1.GetCurChar(var_19_0)
	local var_19_2 = var_1.GetFSM(var_19_1)

	for iter_19_0 = 1, arg_19_0.number do
		var_19_2:AddChooseUpEntryState()
	end

	pg = var_2

	local var_19_3 = var_2.m02
	local var_19_4 = var_2.sendNotification

	GAME = iter_19_0

	var_19_4(var_19_3, iter_19_0.NEW_EDUCATE_CHECK_PRIORITY_FSM)

	return
end

function var_0_0.UpdateBenefitDisplay(arg_20_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)
	local var_20_1 = var_1.GetCurChar(var_20_0)
	local var_20_2 = var_1.GetBenefitData(var_20_1)

	var_1.UpdateDisplayPct(var_20_2, arg_20_0.benefit_display)
	var_1:UpdateDisplayNum(arg_20_0.dollar_num_display)
	var_1:UpdateDisplayCounter(arg_20_0.counter)

	return
end

return var_0_0
