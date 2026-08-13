ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleMainDamagedView = var_0_10003("BattleMainDamagedView")
class = var_0_2

local var_0_3 = var_0_2("BattleMainDamagedView")

var_0.Battle.BattleMainDamagedView = var_0_3
var_0_3.__name = "BattleMainDamagedView"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:Init()

	return
end

function var_0_3.Init(arg_2_0)
	arg_2_0._tf = arg_2_0._go.transform
	findTF = var_1
	arg_2_0._bleedView = var_1(arg_2_0._tf, "mainUnitDamaged")

	local var_2_0 = arg_2_0._bleedView
	local var_2_1 = var_1.GetComponent

	typeof = var_4
	Animator = var_1_10006
	arg_2_0._bleedAnimation = var_2_1(var_2_0, var_4(var_1_10006))

	local var_2_2 = arg_2_0._bleedView
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006

	local var_2_4 = var_2_3(var_2_2, var_4(var_1_10006))

	var_1.SetEndEvent(var_2_4, function(arg_3_0)
		setActive = var_2_10001

		var_2_10001(arg_2_0._bleedView, false)

		arg_2_0._isPlaying = false

		return
	end)

	setActive = var_2

	var_2(arg_2_0._bleedView, false)

	arg_2_0._isPlaying = false

	return
end

function var_0_3.Play(arg_4_0)
	if not arg_4_0._isPlaying then
		setActive = var_1

		var_1(arg_4_0._bleedView, true)
	end

	arg_4_0._isPlaying = true

	return
end

function var_0_3.Dispose(arg_5_0)
	arg_5_0._bleedView = nil
	arg_5_0._bleedAnimation = nil
	arg_5_0._tf = nil
	arg_5_0._go = nil

	return
end

return
