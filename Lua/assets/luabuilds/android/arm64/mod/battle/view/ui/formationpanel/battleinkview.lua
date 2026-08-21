ys = ys or {}

local var_0_0 = ys.Battle.BattleVariable
local var_0_1 = class("BattleInkView")

ys.Battle.BattleInkView = var_0_1
var_0_1.__name = "BattleInkView"
var_0_1.ANIMATION_STATE_INITIAL = "intial"
var_0_1.ANIMATION_STATE_IDLE = "idle"
var_0_1.ANIMATION_STATE_FINALE = "int"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function var_0_1.init(arg_2_0)
	arg_2_0._tf = arg_2_0._go.transform
	arg_2_0._hollowTpl = arg_2_0._tf:Find("ink_tpl")
	arg_2_0._hollowContainer = arg_2_0._tf:Find("container")
	arg_2_0._unitHollowList = {}
	arg_2_0._state = var_0_1.ANIMATION_STATE_IDLE

	return
end

function var_0_1.IsActive(arg_3_0)
	return arg_3_0._isActive
end

function var_0_1.Update(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._unitHollowList) do
		if iter_4_0:IsAlive() then
			iter_4_1.hollow.position = var_0_0.CameraPosToUICamera(iter_4_1.pos:Copy(iter_4_0:GetPosition()) + Vector3(0, 0, 0))
		else
			arg_4_0:RemoveHollow(iter_4_0)
		end
	end

	return
end

function var_0_1.SetActive(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._isActive = arg_5_1

	if arg_5_1 then
		arg_5_0._state = var_0_1.ANIMATION_STATE_INITIAL

		for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
			arg_5_0:AddHollow(iter_5_1)
		end

		setActive(arg_5_0._go, true)
	else
		local var_5_0 = true

		for iter_5_2, iter_5_3 in pairs(arg_5_0._unitHollowList) do
			local function var_5_1()
				arg_5_0:RemoveHollow(iter_5_2)
				setActive(arg_5_0._go, false)

				arg_5_0._state = var_0_1.ANIMATION_STATE_IDLE

				return
			end

			arg_5_0.doHollowScaleAnima(iter_5_3.hollow, 125, 0.3, var_5_0 and var_5_1 or nil)

			var_5_0 = false
		end
	end

	return
end

function var_0_1.AddHollow(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetAttrByName("blindedHorizon")

	if arg_7_0._unitHollowList[arg_7_1] then
		if arg_7_0._unitHollowList[arg_7_1].range ~= var_7_0 then
			arg_7_0.doHollowScaleAnima(arg_7_0._unitHollowList[arg_7_1].hollow, var_7_0)
		end

		arg_7_0._unitHollowList[arg_7_1].range = var_7_0

		return
	elseif var_7_0 == 0 then
		return
	end

	local var_7_1 = {}
	local var_7_2 = cloneTplTo(arg_7_0._hollowTpl, arg_7_0._hollowContainer)

	var_7_2.localScale = Vector3(125, 125, 0)

	arg_7_0.doHollowScaleAnima(var_7_2, var_7_0)
	Vector3.zero:Copy(arg_7_1:GetPosition())

	var_7_1.range = var_7_0
	var_7_1.hollow = var_7_2
	var_7_1.pos = Vector3.zero
	arg_7_0._unitHollowList[arg_7_1] = var_7_1

	return
end

function var_0_1.RemoveHollow(arg_8_0, arg_8_1, arg_8_2)
	LeanTween.cancel(arg_8_0._unitHollowList[arg_8_1].hollow.gameObject)
	Destroy(arg_8_0._unitHollowList[arg_8_1].hollow.gameObject)

	arg_8_0._unitHollowList[arg_8_1] = nil

	return
end

function var_0_1.UpdateHollow(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		arg_9_0:AddHollow(iter_9_1)
	end

	return
end

function var_0_1.doHollowScaleAnima(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	LeanTween.cancel(go(arg_10_0))

	if arg_10_3 then
		LeanTween.scale(arg_10_0, Vector3(arg_10_1, arg_10_1, 0), var_10_0):setOnComplete(System.Action(function()
			arg_10_3()

			return
		end))
	end

	return
end

function var_0_1.Dispose(arg_12_0)
	arg_12_0:SetActive(false)

	for iter_12_0, iter_12_1 in pairs(arg_12_0._unitHollowList) do
		LeanTween.cancel(iter_12_1.hollow.gameObject)
		Destroy(iter_12_1.hollow.gameObject)
	end

	arg_12_0._go = nil
	arg_12_0._tf = nil
	arg_12_0._unitHollowList = nil

	return
end

return
