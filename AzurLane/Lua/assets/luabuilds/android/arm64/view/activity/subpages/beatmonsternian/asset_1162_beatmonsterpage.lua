class = var_0_10000

local var_0_0 = "BeatMonsterPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	arg_3_0:Show()

	local var_3_0 = arg_3_0.activity
	local var_3_1 = arg_3_0:PacketData(var_3_0)

	if not arg_3_0.controller then
		BeatMonsterController = var_3
		arg_3_0.controller = var_3.New()

		local var_3_2 = arg_3_0.controller.mediator

		var_3.SetUI(var_3_2, arg_3_0._go)

		local var_3_3 = arg_3_0.controller

		var_3.SetUp(var_3_3, var_3_1, function(arg_4_0)
			local var_4_0 = arg_3_0
			local var_4_1 = var_1.emit

			ActivityMainScene = var_2_10004

			var_4_1(var_4_0, var_2_10004.LOCK_ACT_MAIN, arg_4_0)

			return
		end)
	else
		local var_3_4 = arg_3_0.controller

		var_3.NetData(var_3_4, var_3_1)
	end

	return
end

function var_0_1.PacketData(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetDataConfig("hp") - arg_5_1.data3
	local var_5_1 = arg_5_1:GetCountForHitMonster()
	local var_5_2 = arg_5_1
	local var_5_3 = arg_5_1.GetDataConfig(var_5_2, "story")
	local var_5_4 = {}

	math = var_5_2
	var_5_4.hp = var_5_2.max(var_5_0, 0)
	var_5_4.maxHp = var_2
	var_5_4.leftCount = var_5_1
	var_5_4.storys = var_5_3

	return var_5_4
end

function var_0_1.OnDestroy(arg_6_0)
	local var_6_0 = arg_6_0.controller

	var_1.Dispose(var_6_0)

	return
end

return var_0_1
