class = var_0_10000

local var_0_0 = "IslandFishingEffectMgr"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.IslandBaseUnit"))

var_0_1.EFFECT_NORMAL = "vfx_diaoyu_diandian"
var_0_1.EFFECT_ENTER = "vfx_diaoyu_rushui"
var_0_1.EFFECT_WAITING = "vfx_diaoyu_dengdai"
var_0_1.EFFECT_HOOKED = "vfx_diaoyu_yaogou"
var_0_1.EFFECT_SHAKE = "vfx_diaoyu_zhenzha"
var_0_1.EFFECT_LEAVE = "vfx_diaoyu_chushui"
var_0_1.EFFECT_ENTER_TIME = 1
var_0_1.EFFECT_LEAVE_TIME = 0.7

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.effects = {}

	arg_1_0:Init()

	return
end

function var_0_1.SetFishHook(arg_2_0, arg_2_1)
	arg_2_0.hookTr = arg_2_1

	return
end

function var_0_1.Preload(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetView()
	local var_3_1 = var_3.GetUnitModuleWithType

	IslandConst = var_1_10006

	local var_3_2 = var_3_1(var_3_0, var_1_10006.UNIT_LIST_FISH_POINT, arg_3_1)._go.transform
	local var_3_3 = var_4.Find(var_3_2, "vfx")

	arg_3_0.effects[var_0_1.EFFECT_NORMAL] = var_3_3

	local var_3_4 = {}

	ipairs = var_6

	for iter_3_0, iter_3_1 in var_6({
		var_0_1.EFFECT_ENTER,
		var_0_1.EFFECT_HOOKED,
		var_0_1.EFFECT_WAITING,
		var_0_1.EFFECT_SHAKE,
		var_0_1.EFFECT_LEAVE
	}) do
		table = var_1_10011

		var_1_10011.insert(var_3_4, function(arg_4_0)
			if arg_3_0.eixted then
				return
			end

			local var_4_0 = "island/effect/prefab/game/diaoyu/" .. iter_3_1
			local var_4_1 = arg_3_0
			local var_4_2 = var_2.GetPoolMgr(var_4_1)

			var_2.GetFishingEffect(var_4_2, var_4_0, function(arg_5_0)
				setParent = var_3_10001

				var_3_10001(arg_5_0, var_0._go.transform)

				local var_5_0 = arg_3_0.effects

				var_5_0[iter_3_1] = arg_5_0
				setActive = var_5_0

				var_5_0(arg_5_0, false)
				arg_4_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_3_4, arg_3_2)

	return
end

function var_0_1.Play(arg_6_0, arg_6_1)
	arg_6_0:RemoveTimer()

	pairs = var_2

	for iter_6_0, iter_6_1 in var_2(arg_6_0.effects) do
		setActive = var_1_10007

		var_1_10007(iter_6_1, iter_6_0 == arg_6_1)
	end

	if arg_6_1 == var_0_1.EFFECT_ENTER then
		-- block empty
	end

	return
end

function var_0_1.UpdatePositions(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.effects) do
		if iter_7_0 ~= var_0_1.EFFECT_NORMAL then
			local var_7_0 = arg_7_0.effects[var_0_1.EFFECT_NORMAL].transform.position.y
			local var_7_1 = iter_7_1.transform

			IsNil = var_1_10008

			if var_1_10008(arg_7_0.hookTr) then
				Vector3 = var_1_10008

				if not var_1_10008(0, 0, 0) then
					Vector3 = var_1_10008
					var_1_10008 = var_1_10008(arg_7_0.hookTr.position.x, var_7_0, arg_7_0.hookTr.position.z)
				end

				var_7_1.position = var_1_10008
			end
		end
	end

	return
end

function var_0_1.DelayPlay(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:RemoveTimer()
	arg_8_0:AddTimer(arg_8_1, function()
		local var_9_0 = arg_8_0

		var_0.Play(var_9_0, arg_8_2)

		return
	end)

	return
end

function var_0_1.AddTimer(arg_10_0, arg_10_1, arg_10_2)
	Timer = var_1_10003
	arg_10_0.timer = var_1_10003.New(arg_10_2, arg_10_1, 1)

	local var_10_0 = arg_10_0.timer

	var_3.Start(var_10_0)

	return
end

function var_0_1.RemoveTimer(arg_11_0)
	if arg_11_0.timer then
		local var_11_0 = arg_11_0.timer

		var_1.Stop(var_11_0)

		arg_11_0.timer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_12_0)
	arg_12_0:RemoveTimer()

	pairs = var_1

	for iter_12_0, iter_12_1 in var_1(arg_12_0.effects) do
		local var_12_0

		if iter_12_0 ~= var_0_1.EFFECT_NORMAL then
			var_12_0 = "island/effect/prefab/game/diaoyu/" .. iter_12_0

			local var_12_1 = arg_12_0:GetPoolMgr()

			var_7.ReturnFishingEffect(var_12_1, var_12_0, iter_12_1)
		else
			setActive = var_12_0

			var_12_0(iter_12_1, true)
		end
	end

	arg_12_0.effects = {}
	arg_12_0.eixted = true

	return
end

return var_0_1
