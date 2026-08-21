local var_0_0 = class("IslandFishingEffectMgr", import("Mod.Island.Core.View.IslandBaseUnit"))

var_0_0.EFFECT_NORMAL = "vfx_diaoyu_diandian"
var_0_0.EFFECT_ENTER = "vfx_diaoyu_rushui"
var_0_0.EFFECT_WAITING = "vfx_diaoyu_dengdai"
var_0_0.EFFECT_HOOKED = "vfx_diaoyu_yaogou"
var_0_0.EFFECT_SHAKE = "vfx_diaoyu_zhenzha"
var_0_0.EFFECT_LEAVE = "vfx_diaoyu_chushui"
var_0_0.EFFECT_ENTER_TIME = 1
var_0_0.EFFECT_LEAVE_TIME = 0.7

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.effects = {}

	arg_1_0:Init()

	return
end

function var_0_0.SetFishHook(arg_2_0, arg_2_1)
	arg_2_0.hookTr = arg_2_1

	return
end

function var_0_0.Preload(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.effects[var_0_0.EFFECT_NORMAL] = arg_3_0:GetView():GetUnitModuleWithType(IslandConst.UNIT_LIST_FISH_POINT, arg_3_1)._go.transform:Find("vfx")

	for iter_3_0, iter_3_1 in ipairs({
		var_0_0.EFFECT_ENTER,
		var_0_0.EFFECT_HOOKED,
		var_0_0.EFFECT_WAITING,
		var_0_0.EFFECT_SHAKE,
		var_0_0.EFFECT_LEAVE
	}) do
		table.insert({}, function(arg_4_0)
			if arg_3_0.eixted then
				return
			end

			arg_3_0:GetPoolMgr():GetFishingEffect("island/effect/prefab/game/diaoyu/" .. iter_3_1, function(arg_5_0)
				setParent(arg_5_0, var_0._go.transform)

				arg_3_0.effects[iter_3_1] = arg_5_0

				setActive(arg_5_0, false)
				arg_4_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, arg_3_2)

	return
end

function var_0_0.Play(arg_6_0, arg_6_1)
	arg_6_0:RemoveTimer()

	for iter_6_0, iter_6_1 in pairs(arg_6_0.effects) do
		setActive(iter_6_1, iter_6_0 == arg_6_1)
	end

	if arg_6_1 == var_0_0.EFFECT_ENTER then
		-- block empty
	end

	return
end

function var_0_0.UpdatePositions(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.effects) do
		if iter_7_0 ~= var_0_0.EFFECT_NORMAL then
			local var_7_0 = iter_7_1.transform

			var_7_0.position = IsNil(arg_7_0.hookTr) and Vector3(0, 0, 0) or Vector3(arg_7_0.hookTr.position.x, arg_7_0.effects[var_0_0.EFFECT_NORMAL].transform.position.y, arg_7_0.hookTr.position.z)
		end
	end

	return
end

function var_0_0.DelayPlay(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:RemoveTimer()
	arg_8_0:AddTimer(arg_8_1, function()
		arg_8_0:Play(arg_8_2)

		return
	end)

	return
end

function var_0_0.AddTimer(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.timer = Timer.New(arg_10_2, arg_10_1, 1)

	arg_10_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_11_0)
	if arg_11_0.timer then
		arg_11_0.timer:Stop()

		arg_11_0.timer = nil
	end

	return
end

function var_0_0.OnDestroy(arg_12_0)
	arg_12_0:RemoveTimer()

	for iter_12_0, iter_12_1 in pairs(arg_12_0.effects) do
		if iter_12_0 ~= var_0_0.EFFECT_NORMAL then
			arg_12_0:GetPoolMgr():ReturnFishingEffect("island/effect/prefab/game/diaoyu/" .. iter_12_0, iter_12_1)
		else
			setActive(iter_12_1, true)
		end
	end

	arg_12_0.effects = {}
	arg_12_0.eixted = true

	return
end

return var_0_0
