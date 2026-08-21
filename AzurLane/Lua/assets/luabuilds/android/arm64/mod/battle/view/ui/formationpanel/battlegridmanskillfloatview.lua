ys = ys or {}

local var_0_0 = ys.Battle.BattleConfig

ys.Battle.BattleGridmanSkillFloatView = class("BattleGridmanSkillFloatView")
ys.Battle.BattleGridmanSkillFloatView.__name = "BattleGridmanSkillFloatView"

function ys.Battle.BattleGridmanSkillFloatView.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)

	arg_1_0:init()

	return
end

function ys.Battle.BattleGridmanSkillFloatView.init(arg_2_0)
	arg_2_0._fusion = {}
	arg_2_0._fusion[var_0_0.FRIENDLY_CODE] = arg_2_0._tf:Find("fusion_1")
	arg_2_0._fusion[var_0_0.FOE_CODE] = arg_2_0._tf:Find("fusion_-1")
	arg_2_0._skillList = {}

	;(function(arg_3_0)
		arg_2_0._skillList[arg_3_0] = {}

		for iter_3_0 = 1, 3 do
			table.insert(arg_2_0._skillList[arg_3_0], {
				idle = true,
				tf = arg_2_0._tf:Find("skill_" .. iter_3_0 * arg_3_0)
			})
		end

		return
	end)(var_0_0.FRIENDLY_CODE)
	;(function(arg_3_0)
		arg_2_0._skillList[arg_3_0] = {}

		for iter_3_0 = 1, 3 do
			table.insert(arg_2_0._skillList[arg_3_0], {
				idle = true,
				tf = arg_2_0._tf:Find("skill_" .. iter_3_0 * arg_3_0)
			})
		end

		return
	end)(var_0_0.FOE_CODE)

	arg_2_0._resource = arg_2_0._tf:Find("res")

	return
end

function ys.Battle.BattleGridmanSkillFloatView.DoSkillFloat(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0

	for iter_4_0 = 1, 3 do
		if arg_4_0._skillList[arg_4_2][iter_4_0].idle then
			var_4_0 = arg_4_0._skillList[arg_4_2][iter_4_0]

			break
		end
	end

	if not var_4_0 then
		return
	end

	var_4_0.idle = false

	local var_4_1 = var_4_0.tf
	local var_4_2 = var_4_0.tf:Find("anima")

	setImageSprite(var_4_2, arg_4_0._resource:Find(arg_4_1):GetComponent(typeof(Image)).sprite, true)
	setActive(var_4_0.tf, true)
	var_4_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_5_0)
		var_4_0.idle = true

		setActive(var_4_1, false)

		return
	end)

	return
end

function ys.Battle.BattleGridmanSkillFloatView.DoFusionFloat(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._fusion[arg_6_1]

	setActive(arg_6_0._fusion[arg_6_1], true)
	arg_6_0._fusion[arg_6_1]:Find("anima"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_7_0)
		setActive(var_6_0, false)

		return
	end)

	return
end

function ys.Battle.BattleGridmanSkillFloatView.Dispose(arg_8_0)
	return
end

return
