local var_0_0 = {
	"SOLO_HEART_DEMON_EASY",
	"SOLO_HEART_DEMON_HARD",
	"SOLO_HEART_DEMON_NIGHTMARE"
}
local var_0_1 = class("SoloHeartDemonRewardItem", ReduxView)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		if arg_3_0.type ~= 1 then
			return
		end

		SoloHeartDemonAction.GetReward({
			reward_list = {
				arg_3_0.data
			}
		})
	end)
end

function var_0_1.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.controller = arg_5_0.allBtnController_:GetController("all")
	arg_5_0.rewardItems_ = {}

	SetActive(arg_5_0[string.format("awardItem%dObj_", 3)], false)
end

function var_0_1.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.index = arg_6_2
	arg_6_0.data = arg_6_1
	arg_6_0.type = arg_6_3

	arg_6_0:UpdateView()
end

function var_0_1.UpdateView(arg_7_0)
	arg_7_0.rewardCfg = SoloHeartDemonRewardCfg[arg_7_0.data]
	arg_7_0.conditionCfg = ConditionCfg[arg_7_0.rewardCfg.condition]
	arg_7_0.rewardList = SoloHeartDemonData:GetDataByPara("rewardList")[arg_7_0.data]
	arg_7_0.taskData = SoloHeartDemonData:GetDataByPara("taskData")[arg_7_0.data]

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.rewardCfg.reward_list) do
		if arg_7_0.rewardItems_[iter_7_0] == nil then
			arg_7_0.rewardItems_[iter_7_0] = CommonItemView.New(arg_7_0[string.format("awardItem%dObj_", iter_7_0)])
		end

		local var_7_0 = clone(ItemTemplateData)

		var_7_0.id = iter_7_1[1]
		var_7_0.number = iter_7_1[2]
		var_7_0.completedFlag = arg_7_0.rewardList and true or false

		function var_7_0.clickFun(arg_8_0)
			ShowPopItem(POP_ITEM, {
				arg_8_0.id,
				arg_8_0.number
			})
		end

		arg_7_0.rewardItems_[iter_7_0]:SetData(var_7_0)
	end

	for iter_7_2 = #arg_7_0.rewardCfg.reward_list + 1, #arg_7_0.rewardItems_ do
		arg_7_0.rewardItems_[iter_7_2]:SetData(nil)
	end

	if arg_7_0.type == 1 then
		SetActive(arg_7_0[string.format("awardItem%dObj_", 2)], true)
	else
		SetActive(arg_7_0[string.format("awardItem%dObj_", 2)], false)
	end

	arg_7_0[arg_7_0.type == 1 and "UpdateNormalView" or "UpdateRankView"](arg_7_0)
end

function var_0_1.UpdateRankView(arg_9_0)
	local var_9_0

	if arg_9_0.data == 1001 then
		var_9_0 = string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS2"), arg_9_0.rewardCfg.reward_rank[1])
	else
		var_9_0 = string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS1"), arg_9_0.rewardCfg.reward_rank[1], arg_9_0.rewardCfg.reward_rank[2])
	end

	arg_9_0.titleText_.text = string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS"), var_9_0)
end

function var_0_1.UpdateNormalView(arg_10_0)
	if arg_10_0.rewardList then
		arg_10_0.controller:SetSelectedState("complete")
	elseif arg_10_0.taskData[1] >= arg_10_0.taskData[2] then
		arg_10_0.controller:SetSelectedState("receive")
	else
		arg_10_0.controller:SetSelectedState("lock")
	end

	SetActive(arg_10_0.progressBar_.gameObject, arg_10_0.conditionCfg.progress_show == 1)

	arg_10_0.progressBar_.value = arg_10_0.taskData[1] / arg_10_0.taskData[2]
	arg_10_0.progressText_.text = arg_10_0.taskData[1] .. "/" .. arg_10_0.taskData[2]

	if arg_10_0.conditionCfg.type == 11001 then
		arg_10_0.titleText_.text = string.format(GetI18NText(arg_10_0.conditionCfg.desc), tostring(GetTips(var_0_0[arg_10_0.conditionCfg.params[1]])))
	elseif arg_10_0.conditionCfg.type == 11002 then
		arg_10_0.titleText_.text = string.format(GetI18NText(arg_10_0.conditionCfg.desc), tostring(GetTips(var_0_0[arg_10_0.conditionCfg.params[1]])))
	elseif arg_10_0.conditionCfg.type == 11003 then
		arg_10_0.titleText_.text = string.format(GetI18NText(arg_10_0.conditionCfg.desc), tostring(arg_10_0.conditionCfg.params[1]))
	elseif arg_10_0.conditionCfg.type == 11004 then
		arg_10_0.titleText_.text = string.format(GetI18NText(arg_10_0.conditionCfg.desc), tostring(arg_10_0.conditionCfg.params[1]))
	elseif arg_10_0.conditionCfg.type == 11005 then
		arg_10_0.titleText_.text = string.format(GetI18NText(arg_10_0.conditionCfg.desc), tostring(arg_10_0.conditionCfg.params[1]))
	end
end

function var_0_1.OnEnter(arg_11_0)
	arg_11_0:UpdateView()
end

function var_0_1.Dispose(arg_12_0)
	if arg_12_0.list then
		arg_12_0.list:Dispose()

		arg_12_0.list = nil
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.rewardItems_) do
		iter_12_1:Dispose()
	end

	arg_12_0.rewardItems_ = {}

	var_0_1.super.Dispose(arg_12_0)
	Object.Destroy(arg_12_0.gameObject_)
end

return var_0_1
