ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleGridmanSkillFloatView = var_0_10003("BattleGridmanSkillFloatView")
var_0.Battle.BattleGridmanSkillFloatView.__name = "BattleGridmanSkillFloatView"

local var_0_3 = var_0.Battle.BattleGridmanSkillFloatView

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	tf = var_1_10002
	arg_1_0._tf = var_1_10002(arg_1_1)

	arg_1_0:init()

	return
end

function var_0_3.init(arg_2_0)
	arg_2_0._fusion = {}

	local var_2_0 = arg_2_0._fusion
	local var_2_1 = var_0_1.FRIENDLY_CODE
	local var_2_2 = arg_2_0._tf

	var_2_0[var_2_1] = var_3.Find(var_2_2, "fusion_1")

	local var_2_3 = arg_2_0._fusion
	local var_2_4 = var_0_1.FOE_CODE
	local var_2_5 = arg_2_0._tf

	var_2_3[var_2_4] = var_3.Find(var_2_5, "fusion_-1")
	arg_2_0._skillList = {}

	;(function(arg_3_0)
		arg_2_0._skillList[arg_3_0] = {}

		for iter_3_0 = 1, 3 do
			local var_3_0 = iter_3_0 * arg_3_0
			local var_3_1 = arg_2_0._tf
			local var_3_2 = var_6.Find(var_3_1, "skill_" .. var_3_0)

			table = var_3_1

			var_3_1.insert(arg_2_0._skillList[arg_3_0], {
				idle = true,
				tf = var_3_2
			})
		end

		return
	end)(var_0_1.FRIENDLY_CODE)
	var_1(var_0_1.FOE_CODE)

	local var_2_6 = arg_2_0._tf

	arg_2_0._resource = var_2.Find(var_2_6, "res")

	return
end

function var_0_3.DoSkillFloat(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0
	local var_4_1 = arg_4_0._skillList[arg_4_2]

	for iter_4_0 = 1, 3 do
		if var_4_1[iter_4_0].idle then
			var_4_0 = var_4_1[iter_4_0]

			break
		end
	end

	if not var_4_0 then
		return
	end

	var_4_0.idle = false

	local var_4_2 = var_4_0.tf
	local var_4_3 = var_5.Find(var_4_2, "anima")
	local var_4_4 = arg_4_0._resource
	local var_4_5 = var_7.Find(var_4_4, arg_4_1)
	local var_4_6 = var_7.GetComponent

	typeof = var_9
	Image = var_1_10010

	local var_4_7 = var_4_6(var_4_5, var_9(var_1_10010)).sprite

	setImageSprite = var_4_5

	var_4_5(var_4_3, var_4_7, true)

	setActive = var_4_5

	var_4_5(var_5, true)

	local var_4_8 = var_4_3
	local var_4_9 = var_4_3.GetComponent

	typeof = var_10
	DftAniEvent = var_11

	local var_4_10 = var_4_9(var_4_8, var_10(var_11))

	var_8.SetEndEvent(var_4_10, function(arg_5_0)
		local var_5_0 = var_4_0

		var_5_0.idle = true
		setActive = var_5_0

		var_5_0(var_0, false)

		return
	end)

	return
end

function var_0_3.DoFusionFloat(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._fusion[arg_6_1]

	setActive = var_1_10003

	var_1_10003(var_6_0, true)

	local var_6_1 = var_6_0:Find("anima")
	local var_6_2 = var_3.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10006

	local var_6_3 = var_6_2(var_6_1, var_5(var_1_10006))

	var_3.SetEndEvent(var_6_3, function(arg_7_0)
		setActive = var_2_10001

		var_2_10001(var_6_0, false)

		return
	end)

	return
end

function var_0_3.Dispose(arg_8_0)
	return
end

return
