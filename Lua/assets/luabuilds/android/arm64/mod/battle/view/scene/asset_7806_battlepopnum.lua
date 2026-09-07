ys = ys or {}
ys.Battle.BattlePopNum = class("BattlePopNum")
ys.Battle.BattlePopNum.__name = "BattlePopNum"

local var_0_1 = ys.Battle.BattlePopNum

ys.Battle.BattlePopNum.NUM_INIT_OFFSET = Vector3(0, 1.6, 0)

local var_0_2 = Vector3(10000, 10000)
local var_0_3 = Vector2(1, 1)

function ys.Battle.BattlePopNum:Ctor(arg_1_1, arg_1_2)
	self.bundle = arg_1_2.bundle
	self.pool = arg_1_1

	local var_1_0 = Object.Instantiate(arg_1_2.template)

	self._go = var_1_0
	self._tf = var_1_0.transform

	self:SetParent(arg_1_2.parentTF)

	self._animator = var_1_0:GetComponent(typeof(Animator))

	local var_1_1 = self._tf:Find("text")

	if var_1_1 then
		self.textCom = var_1_1:GetComponent(typeof(Text))
	end

	var_1_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_2_0)
		arg_1_1:Recycle(self)

		return
	end)

	self._offsetVector = Vector3.zero

	return
end

function ys.Battle.BattlePopNum:SetParent(arg_3_1)
	self._tf:SetParent(arg_3_1, false)

	return
end

function ys.Battle.BattlePopNum:SetText(arg_4_1)
	self.textCom.text = tostring(arg_4_1)

	return
end

function ys.Battle.BattlePopNum:SetReferenceCharacter(arg_5_1, arg_5_2)
	self._offsetVector.x = arg_5_2.x

	local var_5_0 = arg_5_1:GetReferenceVector(self._offsetVector)

	var_5_0:Add(var_0_1.NUM_INIT_OFFSET)

	self._tf.position = var_5_0

	return
end

function ys.Battle.BattlePopNum:Play()
	self._animator.enabled = true

	return
end

function ys.Battle.BattlePopNum:SetScale(arg_7_1)
	self._tf.localScale = Vector2(arg_7_1, arg_7_1)

	return
end

function ys.Battle.BattlePopNum:Init()
	self._go:SetActive(true)

	return
end

function ys.Battle.BattlePopNum:Recycle()
	self._animator.enabled = false
	self._tf.position = var_0_2
	self._tf.localScale = var_0_3

	return
end

function ys.Battle.BattlePopNum:Dispose()
	self._go:SetActive(false)

	self._go = nil
	self._tf = nil

	return
end

return
