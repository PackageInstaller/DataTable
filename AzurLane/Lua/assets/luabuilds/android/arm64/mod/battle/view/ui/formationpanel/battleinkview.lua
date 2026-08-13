ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleVariable

class = var_0_10002

local var_0_2 = var_0_10002("BattleInkView")

var_0.Battle.BattleInkView = var_0_2
var_0_2.__name = "BattleInkView"
var_0_2.ANIMATION_STATE_INITIAL = "intial"
var_0_2.ANIMATION_STATE_IDLE = "idle"
var_0_2.ANIMATION_STATE_FINALE = "int"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function var_0_2.init(arg_2_0)
	arg_2_0._tf = arg_2_0._go.transform

	local var_2_0 = arg_2_0._tf

	arg_2_0._hollowTpl = var_1.Find(var_2_0, "ink_tpl")

	local var_2_1 = arg_2_0._tf

	arg_2_0._hollowContainer = var_1.Find(var_2_1, "container")
	arg_2_0._unitHollowList = {}
	arg_2_0._state = var_0_2.ANIMATION_STATE_IDLE

	return
end

function var_0_2.IsActive(arg_3_0)
	return arg_3_0._isActive
end

function var_0_2.Update(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0._unitHollowList) do
		if iter_4_0:IsAlive() then
			local var_4_0 = iter_4_1.pos
			local var_4_1 = iter_4_1.hollow
			local var_4_2 = var_4_0:Copy(iter_4_0:GetPosition())
			local var_4_3 = var_0_1.CameraPosToUICamera

			Vector3 = var_11
			var_4_1.position = var_4_3(var_4_2 + var_11(0, 0, 0))
		else
			arg_4_0:RemoveHollow(iter_4_0)
		end
	end

	return
end

function var_0_2.SetActive(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._isActive = arg_5_1

	if arg_5_1 then
		arg_5_0._state = var_0_2.ANIMATION_STATE_INITIAL
		ipairs = var_3

		for iter_5_0, iter_5_1 in var_3(arg_5_2) do
			arg_5_0:AddHollow(iter_5_1)
		end

		setActive = var_3

		var_3(arg_5_0._go, true)
	else
		local var_5_0 = true

		pairs = var_1_10004

		for iter_5_2, iter_5_3 in var_1_10004(arg_5_0._unitHollowList) do
			local var_5_1 = iter_5_3.hollow

			local function var_5_2()
				local var_6_0 = arg_5_0

				var_0.RemoveHollow(var_6_0, iter_5_2)

				setActive = var_0

				var_0(arg_5_0._go, false)

				arg_5_0._state = var_0_2.ANIMATION_STATE_IDLE

				return
			end

			arg_5_0.doHollowScaleAnima(var_5_1, 125, 0.3, var_5_0 and var_5_2 or nil)

			var_5_0 = false
		end
	end

	return
end

function var_0_2.AddHollow(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.GetAttrByName(var_7_0, "blindedHorizon")

	if arg_7_0._unitHollowList[arg_7_1] then
		if var_3.range ~= var_7_1 then
			arg_7_0.doHollowScaleAnima(var_3.hollow, var_7_1)
		end

		var_3.range = var_7_1

		return
	elseif var_7_1 == 0 then
		return
	end

	local var_7_2 = {}

	cloneTplTo = var_7_0

	local var_7_3 = var_7_0(arg_7_0._hollowTpl, arg_7_0._hollowContainer)

	Vector3 = var_5
	var_7_3.localScale = var_5(125, 125, 0)

	arg_7_0.doHollowScaleAnima(var_7_3, var_7_1)

	Vector3 = var_5

	local var_7_4 = var_5.zero

	var_5.Copy(var_7_4, arg_7_1:GetPosition())

	var_7_2.range = var_7_1
	var_7_2.hollow = var_7_3
	var_7_2.pos = var_5
	arg_7_0._unitHollowList[arg_7_1] = var_7_2

	return
end

function var_0_2.RemoveHollow(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._unitHollowList[arg_8_1].hollow.gameObject

	LeanTween = var_1_10005

	var_1_10005.cancel(var_8_0)

	Destroy = var_5

	var_5(var_8_0)

	arg_8_0._unitHollowList[arg_8_1] = nil

	return
end

function var_0_2.UpdateHollow(arg_9_0, arg_9_1)
	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_1) do
		arg_9_0:AddHollow(iter_9_1)
	end

	return
end

function var_0_2.doHollowScaleAnima(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_2 or 0.5

	LeanTween = var_1_10005

	local var_10_1 = var_1_10005.cancel

	go = var_1_10007

	var_10_1(var_1_10007(arg_10_0))

	LeanTween = var_10_1

	local var_10_2 = var_10_1.scale
	local var_10_3 = arg_10_0

	Vector3 = var_1_10008

	local var_10_4 = var_10_2(var_10_3, var_1_10008(arg_10_1, arg_10_1, 0), var_10_0)

	if arg_10_3 then
		local var_10_5 = var_10_4
		local var_10_6 = var_10_4.setOnComplete

		System = var_9

		var_10_6(var_10_5, var_9.Action(function()
			arg_10_3()

			return
		end))
	end

	return
end

function var_0_2.Dispose(arg_12_0)
	arg_12_0:SetActive(false)

	pairs = var_1

	for iter_12_0, iter_12_1 in var_1(arg_12_0._unitHollowList) do
		local var_12_0 = iter_12_1.hollow.gameObject

		LeanTween = var_1_10007

		var_1_10007.cancel(var_12_0)

		Destroy = var_1_10007

		var_1_10007(var_12_0)
	end

	arg_12_0._go = nil
	arg_12_0._tf = nil
	arg_12_0._unitHollowList = nil

	return
end

return
