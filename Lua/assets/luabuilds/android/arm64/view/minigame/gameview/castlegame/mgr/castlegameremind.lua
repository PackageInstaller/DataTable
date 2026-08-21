local var_0_0 = class("CastleGameRemind")

var_0_0.remind_type_1 = "remind_type_1"
var_0_0.remind_type_2 = "remind_type_2"
var_0_0.remind_type_3 = "remind_type_3"
var_0_0.remind_type_4 = "remind_type_4"

local var_0_1 = {
	{
		tpl = "remind_1",
		type = var_0_0.remind_type_1
	},
	{
		tpl = "remind_2",
		type = var_0_0.remind_type_2
	},
	{
		tpl = "remind_3",
		type = var_0_0.remind_type_3
	},
	{
		tpl = "remind_4",
		type = var_0_0.remind_type_4
	}
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tplContent = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0.remindPool = {}
	arg_1_0.reminds = {}

	return
end

function var_0_0.setContent(arg_2_0, arg_2_1)
	if not arg_2_1 then
		print("地板的容器不能为nil")

		return
	end

	arg_2_0._content = arg_2_1

	return
end

function var_0_0.start(arg_3_0)
	for iter_3_0 = #arg_3_0.reminds, 1, -1 do
		arg_3_0:returnRemind((table.remove(arg_3_0.reminds, iter_3_0)))
	end

	return
end

function var_0_0.step(arg_4_0)
	for iter_4_0 = #arg_4_0.reminds, 1, -1 do
		if arg_4_0.reminds[iter_4_0].removeTime and arg_4_0.reminds[iter_4_0].removeTime > 0 then
			arg_4_0.reminds[iter_4_0].removeTime = arg_4_0.reminds[iter_4_0].removeTime - CastleGameVo.deltaTime

			if arg_4_0.reminds[iter_4_0].removeTime <= 0 then
				arg_4_0.reminds[iter_4_0].removeTime = nil

				arg_4_0:returnRemind((table.remove(arg_4_0.reminds, iter_4_0)))
			end
		end
	end

	return
end

function var_0_0.addRemind(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0:getRemindByType(arg_5_3)

	var_5_0.removeTime = CastleGameVo.item_ready_time

	setActive(var_5_0.tf, false)
	setActive(var_5_0.tf, true)

	var_5_0.tf.anchoredPosition = CastleGameVo.GetRotationPosByWH(arg_5_1, arg_5_2)

	table.insert(arg_5_0.reminds, var_5_0)

	return
end

function var_0_0.getRemindByType(arg_6_0, arg_6_1)
	local var_6_0

	for iter_6_0 = 1, #arg_6_0.remindPool do
		if arg_6_0.remindPool[iter_6_0].type == arg_6_1 then
			var_6_0 = table.remove(arg_6_0.remindPool, iter_6_0)

			return var_6_0
		end
	end

	if not var_6_0 then
		for iter_6_1 = 1, #var_0_1 do
			if arg_6_1 == var_0_1[iter_6_1].type then
				local var_6_1 = tf(instantiate(findTF(arg_6_0._tplContent, var_0_1[iter_6_1].tpl)))

				setParent(var_6_1, arg_6_0._content)

				return {
					tf = var_6_1,
					dft = GetComponent(findTF(var_6_1, "zPos"), typeof(DftAniEvent)),
					type = arg_6_1
				}
			end
		end
	end

	return
end

function var_0_0.returnRemind(arg_7_0, arg_7_1)
	setActive(arg_7_1.tf, false)

	arg_7_1.removeTime = nil

	table.insert(arg_7_0.remindPool, arg_7_1)

	return
end

function var_0_0.clear(arg_8_0)
	return
end

return var_0_0
