ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattlePopNum = var_0_10003("BattlePopNum")
var_0.Battle.BattlePopNum.__name = "BattlePopNum"

local var_0_3 = var_0.Battle.BattlePopNum

Vector3 = var_3
var_0_3.NUM_INIT_OFFSET = var_3(0, 1.6, 0)
Vector3 = var_3

local var_0_4 = var_3(10000, 10000)

Vector2 = var_0_10004

local var_0_5 = var_0_10004(1, 1)

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.bundle = arg_1_2.bundle
	arg_1_0.pool = arg_1_1
	Object = var_3
	arg_1_0._go = var_3.Instantiate(arg_1_2.template)
	arg_1_0._tf = var_3.transform

	arg_1_0:SetParent(arg_1_2.parentTF)

	local var_1_0 = var_3
	local var_1_1 = var_3.GetComponent

	typeof = var_7
	Animator = var_1_10009
	arg_1_0._animator = var_1_1(var_1_0, var_7(var_1_10009))

	local var_1_2 = arg_1_0._tf

	if var_4.Find(var_1_2, "text") then
		local var_1_3 = var_4
		local var_1_4 = var_4.GetComponent

		typeof = var_1_10008
		Text = var_1_10010
		arg_1_0.textCom = var_1_4(var_1_3, var_1_10008(var_1_10010))
	end

	local var_1_5 = var_3
	local var_1_6 = var_3.GetComponent

	typeof = var_1_10008
	DftAniEvent = var_1_10010

	local var_1_7 = var_1_6(var_1_5, var_1_10008(var_1_10010))

	var_5.SetEndEvent(var_1_7, function(arg_2_0)
		local var_2_0 = arg_1_1

		var_1.Recycle(var_2_0, arg_1_0)

		return
	end)

	Vector3 = var_6
	arg_1_0._offsetVector = var_6.zero

	return
end

function var_0_3.SetParent(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._tf

	var_2.SetParent(var_3_0, arg_3_1, false)

	return
end

function var_0_3.SetText(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.textCom

	tostring = var_1_10003
	var_4_0.text = var_1_10003(arg_4_1)

	return
end

function var_0_3.SetReferenceCharacter(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._offsetVector.x = arg_5_2.x

	local var_5_0 = arg_5_1:GetReferenceVector(arg_5_0._offsetVector)

	var_3.Add(var_5_0, var_0_3.NUM_INIT_OFFSET)

	arg_5_0._tf.position = var_3

	return
end

function var_0_3.Play(arg_6_0)
	arg_6_0._animator.enabled = true

	return
end

function var_0_3.SetScale(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._tf

	Vector2 = var_1_10003
	var_7_0.localScale = var_1_10003(arg_7_1, arg_7_1)

	return
end

function var_0_3.Init(arg_8_0)
	local var_8_0 = arg_8_0._go

	var_1.SetActive(var_8_0, true)

	return
end

function var_0_3.Recycle(arg_9_0)
	arg_9_0._animator.enabled = false
	arg_9_0._tf.position = var_0_4
	arg_9_0._tf.localScale = var_0_5

	return
end

function var_0_3.Dispose(arg_10_0)
	local var_10_0 = arg_10_0._go

	var_1.SetActive(var_10_0, false)

	arg_10_0._go = nil
	arg_10_0._tf = nil

	return
end

return
