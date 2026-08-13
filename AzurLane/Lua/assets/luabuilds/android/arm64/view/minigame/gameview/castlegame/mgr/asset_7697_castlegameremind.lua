class = var_0_10000

local var_0_0 = var_0_10000("CastleGameRemind")

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
		print = var_1_10002

		var_1_10002("地板的容器不能为nil")

		return
	end

	arg_2_0._content = arg_2_1

	return
end

function var_0_0.start(arg_3_0)
	for iter_3_0 = #arg_3_0.reminds, 1, -1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.remove(arg_3_0.reminds, iter_3_0)

		arg_3_0:returnRemind(var_1_10005)
	end

	return
end

function var_0_0.step(arg_4_0)
	for iter_4_0 = #arg_4_0.reminds, 1, -1 do
		if arg_4_0.reminds[iter_4_0].removeTime then
			local var_4_0 = var_5.removeTime

			if 0 < var_4_0 then
				local var_4_1 = var_5.removeTime

				CastleGameVo = var_7
				var_5.removeTime = var_4_1 - var_7.deltaTime

				if var_5.removeTime <= 0 then
					var_5.removeTime = nil
					table = var_6

					local var_4_2 = var_6.remove(arg_4_0.reminds, iter_4_0)

					arg_4_0:returnRemind(var_4_2)
				end
			end
		end
	end

	return
end

function var_0_0.addRemind(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.getRemindByType(var_5_0, arg_5_3)

	CastleGameVo = var_1_10005
	var_5_1.removeTime = var_1_10005.item_ready_time
	CastleGameVo = var_5

	local var_5_2 = var_5.GetRotationPosByWH(arg_5_1, arg_5_2)

	setActive = var_5_0

	var_5_0(var_5_1.tf, false)

	setActive = var_5_0

	var_5_0(var_5_1.tf, true)

	local var_5_3 = var_5_1.tf

	var_5_3.anchoredPosition = var_5_2
	table = var_5_3

	var_5_3.insert(arg_5_0.reminds, var_5_1)

	return
end

function var_0_0.getRemindByType(arg_6_0, arg_6_1)
	local var_6_0

	for iter_6_0 = 1, #arg_6_0.remindPool do
		if arg_6_0.remindPool[iter_6_0].type == arg_6_1 then
			table = var_7

			return (var_7.remove(arg_6_0.remindPool, iter_6_0))
		end
	end

	if not var_6_0 then
		for iter_6_1 = 1, #var_0_1 do
			if arg_6_1 == var_0_1[iter_6_1].type then
				tf = var_7
				instantiate = var_1_10009
				findTF = var_1_10011

				local var_6_1 = var_7(var_1_10009(var_1_10011(arg_6_0._tplContent, var_0_1[iter_6_1].tpl)))

				setParent = var_1_10008

				var_1_10008(var_6_1, arg_6_0._content)

				GetComponent = var_1_10008
				findTF = var_10

				local var_6_2 = var_10(var_6_1, "zPos")

				typeof = var_1_10011
				DftAniEvent = var_13
				var_1_10008 = var_1_10008(var_6_2, var_1_10011(var_13))

				return {
					tf = var_6_1,
					dft = var_1_10008,
					type = arg_6_1
				}
			end
		end
	end

	return
end

function var_0_0.returnRemind(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_1.tf, false)

	arg_7_1.removeTime = nil
	table = var_2

	var_2.insert(arg_7_0.remindPool, arg_7_1)

	return
end

function var_0_0.clear(arg_8_0)
	return
end

return var_0_0
