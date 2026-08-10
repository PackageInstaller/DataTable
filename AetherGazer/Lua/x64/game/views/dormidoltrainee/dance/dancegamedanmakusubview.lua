local var_0_0 = class("DanceGameDanmakuSubView", BaseView)
local var_0_1 = class("DanceGameDanmakuSubView")

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.kp = arg_1_1
	arg_1_0.ki = arg_1_2 or 0
	arg_1_0.kd = arg_1_3 or 0
	arg_1_0.v = 0
	arg_1_0.expect = 0
	arg_1_0.pause = 0
end

function var_0_1.Update(arg_2_0, arg_2_1)
	local var_2_0 = (arg_2_0.monitorValue and arg_2_0.monitorValue() or arg_2_0.v) - arg_2_0.expect

	if arg_2_0.pause > 0 then
		-- block empty
	else
		local var_2_1 = arg_2_0.kp * arg_2_1 * math.random()

		if var_2_0 > 0 then
			var_2_1 = -var_2_1
		elseif var_2_0 == 0 then
			var_2_1 = (math.random() * 2 - 1) * arg_2_1
		end

		arg_2_0.v = var_2_1 + arg_2_0.v
	end

	arg_2_0.pause = arg_2_0.pause - arg_2_1
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	arg_3_0.gameObject_ = arg_3_1
	arg_3_0.transform_ = arg_3_1.transform
	arg_3_0.pool = {}
	arg_3_0.danmaku = {}
	arg_3_0.ticker = nil
	arg_3_0.danmakuAmountControl = var_0_1.New(1.5)

	function arg_3_0.danmakuAmountControl.monitorValue()
		return #arg_3_0.danmaku
	end

	arg_3_0:Init()
end

function var_0_0.Init(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:ClearAllDanmaku()

	for iter_6_0, iter_6_1 in pairs(arg_6_0.pool) do
		Object.Destroy(iter_6_1.obj)
	end

	arg_6_0.danmaku = nil
	arg_6_0.pool = nil
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:StopUpdateTicker()
end

function var_0_0.Update(arg_9_0, arg_9_1)
	arg_9_0:UpdateActiveDanmaku(arg_9_1)
	arg_9_0:UpdateGenDanmakuTask(arg_9_1)
end

function var_0_0.StartUpdateTicker(arg_10_0)
	arg_10_0:StopUpdateTicker()

	local var_10_0 = Time.time

	arg_10_0.ticker = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		local var_11_0 = Time.time
		local var_11_1 = var_11_0 - var_10_0

		arg_10_0:Update(var_11_1)

		var_10_0 = var_11_0
	end, -1, true)
end

function var_0_0.StopUpdateTicker(arg_12_0)
	if arg_12_0.ticker then
		FuncTimerManager.inst:RemoveFuncTimer(arg_12_0.ticker)

		arg_12_0.ticker = nil
	end
end

local function var_0_2(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.rect.height
	local var_13_1 = arg_13_0.anchoredPosition

	return var_13_1.x >= 0 and var_13_0 >= var_13_1.y and var_13_1.y > -arg_13_1.rect.height
end

local function var_0_3(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.obj.transform
	local var_14_1 = Vector2.left * (arg_14_1 * arg_14_0.speed)

	var_14_0.anchoredPosition = var_14_0.anchoredPosition + var_14_1
end

function var_0_0.UpdateActiveDanmaku(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.danmaku) do
		if var_0_2(iter_15_1.obj.transform, arg_15_0.viewport_) then
			local var_15_0 = iter_15_1.speed

			var_0_3(iter_15_1, arg_15_1)
		else
			arg_15_0:RecycleDanmaku(iter_15_1)

			arg_15_0.danmaku[iter_15_0] = nil
		end
	end
end

function var_0_0.ClaimDanmakuFromPool(arg_16_0)
	if arg_16_0.pool[1] then
		return table.remove(arg_16_0.pool)
	end

	local var_16_0 = Object.Instantiate(arg_16_0.danmakuPrefab_, arg_16_0.viewport_)
	local var_16_1 = var_16_0:GetComponent("Text")

	return {
		speed = 1,
		active = false,
		obj = var_16_0,
		text = var_16_1
	}
end

function var_0_0.ClearAllDanmaku(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.danmaku) do
		arg_17_0:RecycleDanmaku(iter_17_1)

		arg_17_0.danmaku[iter_17_0] = nil
	end
end

function var_0_0.RecycleDanmaku(arg_18_0, arg_18_1)
	arg_18_1.active = false

	SetActive(arg_18_1.obj, false)
	table.insert(arg_18_0.pool, arg_18_1)
end

function var_0_0.GenDanmaku(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:ClaimDanmakuFromPool()

	SetActive(var_19_0.obj, true)

	var_19_0.text.text = arg_19_1
	var_19_0.speed = arg_19_2

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(var_19_0.obj.transform)
	arg_19_0:ArrangeDanmaku(var_19_0)

	var_19_0.active = true

	table.insert(arg_19_0.danmaku, var_19_0)
end

function var_0_0.ArrangeDanmaku(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.obj.transform
	local var_20_1 = var_20_0.rect.width
	local var_20_2 = var_20_0.rect.height
	local var_20_3 = arg_20_0.viewport_.rect.height
	local var_20_4 = 0.25 * var_20_2 * math.random()
	local var_20_5 = {}

	for iter_20_0 = var_20_4, var_20_3 - var_20_2, 1.1 * var_20_2 do
		table.insert(var_20_5, {
			weight = 0,
			y = -iter_20_0
		})
	end

	for iter_20_1, iter_20_2 in pairs(arg_20_0.danmaku) do
		local var_20_6 = iter_20_2.obj.transform
		local var_20_7 = var_20_6.anchoredPosition
		local var_20_8 = var_20_6.rect.width
		local var_20_9 = var_20_6.rect.height

		for iter_20_3, iter_20_4 in pairs(var_20_5) do
			local var_20_10 = iter_20_4.y

			if var_20_10 <= var_20_7.y + var_20_2 and var_20_10 >= var_20_7.y - var_20_9 - var_20_2 then
				iter_20_4.weight = iter_20_4.weight + var_20_8
			end
		end
	end

	CommonTools.UniversalSortEx(var_20_5, {
		ascend = true,
		map = function(arg_21_0)
			return arg_21_0.weight
		end
	}, {
		map = function(arg_22_0)
			return arg_22_0.y
		end
	})

	var_20_0.anchoredPosition = Vector2(arg_20_0.viewport_.rect.width + var_20_1, var_20_5[1].y)
end

function var_0_0.SetDanmakuFilter(arg_23_0, arg_23_1)
	arg_23_0.danmakuFilter = arg_23_1
end

local var_0_4 = 2

function var_0_0.UpdateGenDanmakuTask(arg_24_0, arg_24_1)
	arg_24_0.danmakuAmountControl:Update(arg_24_1)

	local var_24_0 = math.min(var_0_4, math.round(arg_24_0.danmakuAmountControl.v) - #arg_24_0.danmaku)
	local var_24_1 = 0
	local var_24_2

	if arg_24_0.danmakuFilter then
		var_24_2 = IdolBulletComment.get_id_list_by_comment_type[arg_24_0.danmakuFilter]
	else
		var_24_2 = IdolBulletComment.all
	end

	local var_24_3 = var_24_2 and #var_24_2 or 0

	if var_24_0 > 0 then
		local var_24_4 = math.random(var_24_3)
		local var_24_5 = IdolBulletComment[var_24_2[var_24_4]]

		arg_24_0:GenDanmaku(var_24_5.comment_desc, var_24_5.comment_speed * 100)

		arg_24_0.danmakuAmountControl.pause = 1 / var_24_0 * math.random()
	end
end

function var_0_0.SetExpectDanmakuAmount(arg_25_0, arg_25_1)
	arg_25_0.danmakuAmountControl.expect = arg_25_1
end

return var_0_0
