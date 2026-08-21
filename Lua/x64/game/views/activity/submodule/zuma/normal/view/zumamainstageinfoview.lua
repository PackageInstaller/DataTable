local var_0_0 = class("ZumaMainStageInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.difficultType = arg_1_2
	arg_1_0.difficultCfgList = ZumaData:GetZumaCfgData()[arg_1_2]

	arg_1_0:InitUI()
end

function var_0_0.GetDifficultCfgList(arg_2_0)
	return arg_2_0.difficultCfgList
end

function var_0_0.SetRedState(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.stageList) do
		iter_3_1:SetRedState(arg_3_1)
	end
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	if arg_4_0.scrollviewGo_ then
		arg_4_0.scrollMoveView_ = ScrollMoveView.New(arg_4_0, arg_4_0.scrollviewGo_)
	end

	arg_4_0.stagePosList = {}
	arg_4_0.stageList = {}

	for iter_4_0 = 1, #arg_4_0.difficultCfgList do
		local var_4_0, var_4_1 = arg_4_0:CreateStageItem(iter_4_0)

		arg_4_0.stageList[iter_4_0] = ZumaMainStageItem.New(var_4_0, var_4_1, arg_4_0.difficultCfgList[iter_4_0], iter_4_0)
	end
end

function var_0_0.CreateStageItem(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0[string.format("stage%sTrs_", arg_5_1)]

	arg_5_0.stagePosList[arg_5_1] = var_5_0.anchoredPosition.x

	return var_5_0:GetChild(0).gameObject, nil
end

function var_0_0.DefalutSelect(arg_6_0, arg_6_1)
	local var_6_0

	for iter_6_0, iter_6_1 in pairs(arg_6_0.stageList) do
		if arg_6_1 == iter_6_1.levelID then
			local var_6_1 = iter_6_0

			break
		end
	end
end

function var_0_0.UpdateMoveView(arg_7_0, arg_7_1)
	if arg_7_1 then
		local var_7_0 = arg_7_0.stagePosList[arg_7_1]

		arg_7_0:BeginMoveTween(Vector2(-var_7_0, 0))
	else
		arg_7_0:BeginMoveTween()
	end

	if arg_7_0.scrollviewSr_ then
		if arg_7_1 then
			arg_7_0.scrollviewSr_.enabled = false
		else
			arg_7_0.scrollviewSr_.enabled = true
		end
	end
end

function var_0_0.BeginMoveTween(arg_8_0, arg_8_1)
	arg_8_0:RemoveTween()

	local var_8_0 = arg_8_0.contentTrs_
	local var_8_1 = false

	if arg_8_0.scrollviewTrs_ then
		var_8_1 = true
		var_8_0 = arg_8_0.scrollviewTrs_
	end

	if not arg_8_1 then
		arg_8_1 = Vector2.zero
	elseif var_8_1 then
		arg_8_1.x = arg_8_0.scrollviewTrs_.rect.width / 2 + arg_8_1.x - arg_8_0.contentTrs_.anchoredPosition.x
	end

	local var_8_2 = var_8_0.anchoredPosition

	arg_8_0.tween_ = LeanTween.value(var_8_0.gameObject, var_8_2, arg_8_1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
		var_8_0.anchoredPosition = Vector2(arg_9_0, 0)
	end)):setOnComplete(System.Action(function()
		arg_8_0:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function var_0_0.RemoveTween(arg_11_0)
	if arg_11_0.tween_ then
		arg_11_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_11_0.tween_.id)

		arg_11_0.tween_ = nil
	end
end

function var_0_0.IsOpenSectionInfo(arg_12_0)
	return true
end

function var_0_0.RefreshStageUI(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0.stageList[arg_13_1]:RefreshUI()
	else
		for iter_13_0, iter_13_1 in pairs(arg_13_0.stageList) do
			iter_13_1:RefreshUi()
		end
	end
end

function var_0_0.GetTragetItem(arg_14_0, arg_14_1)
	return arg_14_0.stageList[arg_14_1]
end

function var_0_0.GetAllScore(arg_15_0)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0.stageList) do
		var_15_0 = var_15_0 + (ZumaData:GetZumaStageScore(iter_15_1.levelID) or 0)
	end

	return var_15_0
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveTween()

	for iter_16_0, iter_16_1 in pairs(arg_16_0.stageList) do
		iter_16_1:Dispose()
	end

	if arg_16_0.scrollMoveView_ then
		arg_16_0.scrollMoveView_:Dispose()

		arg_16_0.scrollMoveView_ = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
