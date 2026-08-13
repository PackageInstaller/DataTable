import = var_0_10000

local var_0_0 = var_0_10000(".DynamicCellView")

import = var_0_10001

local var_0_1 = var_0_10001(".ChampionCellView")

class = var_2

local var_0_2 = "DynamicChampionCellView"

DecorateClass = var_0_10005

local var_0_3 = var_2(var_0_2, var_0_10005(var_0_0, var_0_1))

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_1.Ctor(arg_1_0)
	var_0_1.InitChampionCellTransform(arg_1_0)

	return
end

function var_0_3.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityEnemy
end

function var_0_3.SetActive(arg_3_0, arg_3_1)
	arg_3_0:SetActiveModel(arg_3_1)

	return
end

function var_0_3.SetActiveModel(arg_4_0, arg_4_1)
	arg_4_0:SetSpineVisible(arg_4_1)

	setActive = var_2

	var_2(arg_4_0.tfShadow, arg_4_1)

	pairs = var_2

	for iter_4_0, iter_4_1 in var_2(arg_4_0._extraEffectList) do
		IsNil = var_1_10007

		if not var_1_10007(iter_4_1) then
			setActive = var_1_10007

			var_1_10007(iter_4_1, arg_4_1)
		end
	end

	return
end

function var_0_3.PlayShuiHua()
	return
end

function var_0_3.UpdateChampionCell(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	var_0_1.UpdateChampionCell(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:RefreshLinePosition(arg_6_1, arg_6_2)

	return
end

function var_0_3.TweenShining(arg_7_0, arg_7_1)
	arg_7_0:StopTween()

	if not arg_7_0:GetSpineRole() then
		return
	end

	local var_7_0 = var_2
	local var_7_1 = var_2.TweenShining
	local var_7_2 = 0.5
	local var_7_3 = arg_7_1
	local var_7_4 = 0
	local var_7_5 = 1

	Color = var_1_10010

	local var_7_6 = var_1_10010.New(0, 0, 0, 0)

	Color = var_1_10011

	var_7_1(var_7_0, var_7_2, var_7_3, var_7_4, var_7_5, var_7_6, var_1_10011.New(1, 1, 1, 1), true, true)

	return
end

function var_0_3.StopTween(arg_8_0)
	if not arg_8_0.tweenId then
		return
	end

	LeanTween = var_1

	var_1.cancel(arg_8_0.tweenId, true)

	arg_8_0.tweenId = nil

	return
end

function var_0_3.Clear(arg_9_0)
	arg_9_0:StopTween()

	if arg_9_0.go then
		LeanTween = var_1

		var_1.cancel(arg_9_0.go)
	end

	var_0_1.Clear(arg_9_0)

	return
end

return var_0_3
