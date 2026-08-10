local var_0_0 = class("WaterPipeStageMapView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stageIDList = ActivityWaterPipeStageCfg.all
	arg_2_0.stageItemList = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.stageIDList) do
		arg_2_0.stageItemList[iter_2_0] = WaterPipeStageItem.New(arg_2_0[string.format("pipestageitemGo_%o", iter_2_0)], iter_2_1)
	end
end

function var_0_0.RefreshUI(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.stageItemList) do
		iter_3_1:RefreshUI()
	end
end

function var_0_0.BindRedPoint(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.stageItemList) do
		iter_4_1:BindRedPoint()
	end
end

function var_0_0.UnBindRedPoint(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.stageItemList) do
		iter_5_1:UnBindRedPoint()
	end
end

function var_0_0.MoveToOptimal(arg_6_0)
	local var_6_0 = #arg_6_0.stageIDList

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.stageIDList) do
		local var_6_1 = WaterPipeData:GetStageInfoByStageID(iter_6_1)

		if WaterPipeData:CheckStageIsUnLock(iter_6_1) then
			if var_6_1 and (var_6_1.letter_reward == false or var_6_1.letter_reward == nil) then
				var_6_0 = iter_6_0

				break
			elseif not var_6_1 then
				var_6_0 = iter_6_0

				break
			else
				var_6_0 = iter_6_0
			end
		end
	end

	arg_6_0:ScrollList(var_6_0)
end

function var_0_0.ScrollList(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.scrollviewTrs_.rect.width
	local var_7_1 = arg_7_0.stageItemList[arg_7_1].transform_.parent.anchoredPosition.x
	local var_7_2 = arg_7_0.stageItemList[arg_7_1].transform_.rect.width
	local var_7_3 = arg_7_0.contentTrs_.anchoredPosition.x / 2
	local var_7_4 = arg_7_0.contentTrs_.rect.width
	local var_7_5 = var_7_0 - var_7_1 - var_7_2 - 400
	local var_7_6 = Mathf.Min(var_7_5, 0)
	local var_7_7 = Mathf.Max(var_7_6, var_7_0 - var_7_4)

	arg_7_0.contentTrs_.anchoredPosition = Vector2(var_7_7, arg_7_0.contentTrs_.anchoredPosition.y)
end

function var_0_0.PlaySettleAni(arg_8_0, arg_8_1)
	local var_8_0 = table.indexof(arg_8_0.stageIDList, arg_8_1)
	local var_8_1 = var_8_0 + 1

	for iter_8_0, iter_8_1 in pairs(arg_8_0.stageItemList) do
		iter_8_1:ShowStageAni(false)
	end

	arg_8_0.stageItemList[var_8_0]:ShowStageAni(true)
	arg_8_0:StopNextStageTimer()

	arg_8_0.nextStageTimer = Timer.New(function()
		if arg_8_0.stageItemList[var_8_1] then
			arg_8_0.stageItemList[var_8_1]:ShowStageAni(true)
		end

		arg_8_0:StopNextStageTimer()
	end, 1)

	arg_8_0.nextStageTimer:Start()
end

function var_0_0.StopNextStageTimer(arg_10_0)
	if arg_10_0.nextStageTimer then
		arg_10_0.nextStageTimer:Stop()

		arg_10_0.nextStageTimer = nil
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:StopNextStageTimer()

	for iter_11_0, iter_11_1 in pairs(arg_11_0.stageItemList) do
		if iter_11_1 then
			iter_11_1:Dispose()

			iter_11_1 = nil
		end
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
