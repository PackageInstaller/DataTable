ys = ys or {}
ys.Battle.BattlePopNum = class("BattlePopNum")
ys.Battle.BattlePopNum.__name = "BattlePopNum"

local var_0_1 = ys.Battle.BattlePopNum

ys.Battle.BattlePopNum.NUM_INIT_OFFSET = Vector3(0, 1.6, 0)

local var_0_2 = Vector3(10000, 10000)
local var_0_3 = Vector2(1, 1)

function ys.Battle.BattlePopNum.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.bundle = arg_1_2.bundle
	arg_1_0.pool = arg_1_1

	local var_1_0 = Object.Instantiate(arg_1_2.template)

	arg_1_0._go = var_1_0
	arg_1_0._tf = var_1_0.transform

	arg_1_0:SetParent(arg_1_2.parentTF)

	arg_1_0._animator = var_1_0:GetComponent(typeof(Animator))

	local var_1_1 = arg_1_0._tf:Find("text")

	if var_1_1 then
		arg_1_0.textCom = var_1_1:GetComponent(typeof(Text))
	end

	var_1_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_2_0)
		arg_1_1:Recycle(arg_1_0)

		return
	end)

	arg_1_0._offsetVector = Vector3.zero

	return
end

function ys.Battle.BattlePopNum.SetParent(arg_3_0, arg_3_1)
	arg_3_0._tf:SetParent(arg_3_1, false)

	return
end

function ys.Battle.BattlePopNum.SetText(arg_4_0, arg_4_1)
	arg_4_0.textCom.text = tostring(arg_4_1)

	return
end

function ys.Battle.BattlePopNum.SetReferenceCharacter(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._offsetVector.x = arg_5_2.x

	local var_5_0 = arg_5_1:GetReferenceVector(arg_5_0._offsetVector)

	var_5_0:Add(var_0_1.NUM_INIT_OFFSET)

	arg_5_0._tf.position = var_5_0

	return
end

function ys.Battle.BattlePopNum.Play(arg_6_0)
	arg_6_0._animator.enabled = true

	return
end

function ys.Battle.BattlePopNum.SetScale(arg_7_0, arg_7_1)
	arg_7_0._tf.localScale = Vector2(arg_7_1, arg_7_1)

	return
end

function ys.Battle.BattlePopNum.Init(arg_8_0)
	arg_8_0._go:SetActive(true)

	return
end

function ys.Battle.BattlePopNum.Recycle(arg_9_0)
	arg_9_0._animator.enabled = false
	arg_9_0._tf.position = var_0_2
	arg_9_0._tf.localScale = var_0_3

	return
end

function ys.Battle.BattlePopNum.Dispose(arg_10_0)
	arg_10_0._go:SetActive(false)

	arg_10_0._go = nil
	arg_10_0._tf = nil

	return
end

return
