local var_0_0 = class("RectKeyInfo")

function var_0_0.Ctor(arg_1_0)
	arg_1_0._inPutKeyDic = {}

	return
end

function var_0_0.setKeyPress(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:getKeyData(arg_2_1).status = arg_2_2

	arg_2_0:setKeyData(arg_2_1, arg_2_2)

	if arg_2_0._triggerCallback then
		arg_2_0._triggerCallback(arg_2_1, arg_2_2)
	end

	return
end

function var_0_0.setTriggerCallback(arg_3_0, arg_3_1)
	arg_3_0._triggerCallback = arg_3_1

	return
end

function var_0_0.setKeyData(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0 = 1, #arg_4_0._inPutKeyDic do
		if arg_4_0._inPutKeyDic[iter_4_0].code == arg_4_1 then
			arg_4_0._inPutKeyDic[iter_4_0].status = arg_4_2
		end
	end

	return
end

function var_0_0.getKeyData(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	local var_5_0

	for iter_5_0 = 1, #arg_5_0._inPutKeyDic do
		if arg_5_0._inPutKeyDic[iter_5_0].code == arg_5_1 then
			var_5_0 = arg_5_0._inPutKeyDic[iter_5_0]
		end
	end

	if not var_5_0 then
		var_5_0 = {
			status = false,
			code = arg_5_1
		}

		table.insert(arg_5_0._inPutKeyDic, {
			status = false,
			code = arg_5_1
		})
	end

	return var_5_0
end

function var_0_0.getKeyCode(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return nil
	end

	local var_6_0

	for iter_6_0 = 1, #arg_6_0._inPutKeyDic do
		if arg_6_0._inPutKeyDic[iter_6_0].code == arg_6_1 then
			var_6_0 = arg_6_0._inPutKeyDic[iter_6_0]
		end
	end

	if not var_6_0 then
		var_6_0 = {
			status = false,
			code = arg_6_1
		}

		table.insert(arg_6_0._inPutKeyDic, {
			status = false,
			code = arg_6_1
		})
	end

	return var_6_0.status
end

return var_0_0
