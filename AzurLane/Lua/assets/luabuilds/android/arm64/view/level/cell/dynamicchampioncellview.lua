local var_0_0 = class("DynamicChampionCellView", DecorateClass(import(".DynamicCellView"), (import(".ChampionCellView"))))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0.Ctor(arg_1_0, arg_1_1)
	var_0.Ctor(arg_1_0)
	var_0.InitChampionCellTransform(arg_1_0)

	return
end

function var_0_0.GetOrder(arg_2_0)
	return ChapterConst.CellPriorityEnemy
end

function var_0_0.SetActive(arg_3_0, arg_3_1)
	arg_3_0:SetActiveModel(arg_3_1)

	return
end

function var_0_0.SetActiveModel(arg_4_0, arg_4_1)
	arg_4_0:SetSpineVisible(arg_4_1)
	setActive(arg_4_0.tfShadow, arg_4_1)

	for iter_4_0, iter_4_1 in pairs(arg_4_0._extraEffectList) do
		if not IsNil(iter_4_1) then
			setActive(iter_4_1, arg_4_1)
		end
	end

	return
end

function var_0_0.PlayShuiHua()
	return
end

function var_0_0.UpdateChampionCell(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	var_0.UpdateChampionCell(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:RefreshLinePosition(arg_6_1, arg_6_2)

	return
end

function var_0_0.TweenShining(arg_7_0, arg_7_1)
	arg_7_0:StopTween()

	local var_7_0 = arg_7_0:GetSpineRole()

	if not var_7_0 then
		return
	end

	var_7_0:TweenShining(0.5, arg_7_1, 0, 1, Color.New(0, 0, 0, 0), Color.New(1, 1, 1, 1), true, true)

	return
end

function var_0_0.StopTween(arg_8_0)
	if not arg_8_0.tweenId then
		return
	end

	LeanTween.cancel(arg_8_0.tweenId, true)

	arg_8_0.tweenId = nil

	return
end

function var_0_0.Clear(arg_9_0)
	arg_9_0:StopTween()

	if arg_9_0.go then
		LeanTween.cancel(arg_9_0.go)
	end

	var_0.Clear(arg_9_0)

	return
end

return var_0_0
