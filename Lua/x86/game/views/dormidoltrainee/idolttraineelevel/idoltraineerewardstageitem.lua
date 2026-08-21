local var_0_0 = class("IdolTraineeRewardStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.stageID = arg_3_1

	if arg_3_0.stageID then
		arg_3_0.nameText_.text = IdolTraineePveBattleCfg[arg_3_0.stageID].name

		arg_3_0:InitRewardList()
	end
end

function var_0_0.InitRewardList(arg_4_0)
	if not arg_4_0.awardList then
		arg_4_0.awardList = {}

		local var_4_0 = IdolTraineePveBattleCfg[arg_4_0.stageID].taskIDList

		if var_4_0 and var_4_0 ~= "" then
			for iter_4_0, iter_4_1 in ipairs(var_4_0) do
				local var_4_1 = Object.Instantiate(arg_4_0.levelitemGo_, arg_4_0.contentTrs_)

				arg_4_0.awardList[iter_4_1] = IdolTraineeRewardListItem.New(var_4_1)

				arg_4_0.awardList[iter_4_1]:SetData(iter_4_1)
			end
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.contentTrs_)
	end
end

function var_0_0.RefreshUI(arg_5_0)
	if arg_5_0.awardList then
		for iter_5_0, iter_5_1 in pairs(arg_5_0.awardList) do
			iter_5_1:SetData(iter_5_0)
		end
	end
end

function var_0_0.GetCanReciveAwardList(arg_6_0)
	local var_6_0 = {}

	if arg_6_0.awardList then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.awardList) do
			if iter_6_1.stateController_:GetSelectedState() == "complete" then
				table.insert(var_6_0, iter_6_0)
			end
		end
	end

	return var_6_0
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.awardList then
		for iter_7_0, iter_7_1 in pairs(arg_7_0.awardList) do
			iter_7_1:Dispose()
		end

		arg_7_0.awardList = nil
	end

	Object.DestroyImmediate(arg_7_0.gameObject_)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
