local var_0_0 = class("StrongholdOperateSkillPage", StrongholdOperateBasePage)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.hander_ = arg_1_1

	local var_1_0 = Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdRewardUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:Refresh()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, StrongholdOperateRewardItem)
	arg_4_0.rewardController = ControllerUtil.GetController(arg_4_0.transform_, "reward")
	arg_4_0.specItems = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = arg_4_0["m_specReward" .. iter_4_0]

		table.insert(arg_4_0.specItems, StrongholdOperateRewardSpecItem.New(var_4_0))
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_rewardBtn, function()
		local var_6_0 = arg_5_0:GetAllRecevieRewardIdList()

		StrongholdAction.QueryReward(arg_5_0.activity_id, var_6_0)
	end)
end

function var_0_0.Refresh(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 == nil then
		arg_7_2 = true
	end

	arg_7_0.activity_id = arg_7_1
	arg_7_0.rewardDataList = ActivityStrongholdRewardCfg.get_id_list_by_tag[0]

	table.sort(arg_7_0.rewardDataList, function(arg_8_0, arg_8_1)
		local var_8_0 = StrongholdData:GetRewardState(arg_7_1, arg_8_0)
		local var_8_1 = StrongholdData:GetRewardState(arg_7_1, arg_8_1)

		if var_8_0 == var_8_1 then
			return arg_8_0 < arg_8_1
		else
			return var_8_0 < var_8_1
		end
	end)

	if arg_7_2 then
		arg_7_0.list:StartScroll(#arg_7_0.rewardDataList)
	else
		local var_7_0 = arg_7_0.list:GetScrolledPosition()

		arg_7_0.list:StartScrollWithoutAnimator(#arg_7_0.rewardDataList, var_7_0)
	end

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = arg_9_0:GetAllRecevieRewardIdList()

	arg_9_0.rewardController:SetSelectedIndex(#var_9_0 > 0 and 1 or 0)

	local var_9_1 = ActivityStrongholdRewardCfg.get_id_list_by_tag[1]

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if arg_9_0.specItems[iter_9_0] then
			arg_9_0.specItems[iter_9_0]:SetData(arg_9_0.activity_id, iter_9_1)
		end
	end
end

function var_0_0.GetAllRecevieRewardIdList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(ActivityStrongholdRewardCfg.all) do
		if StrongholdData:GetRewardState(arg_10_0.activity_id, iter_10_1) == 0 then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.list:Dispose()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.specItems) do
		iter_11_1:Dispose()
	end

	arg_11_0.specItems = {}

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.rewardDataList[arg_12_1]

	arg_12_2:SetData(arg_12_0.activity_id, var_12_0)
end

function var_0_0.OnStrongholdUpdateReward(arg_13_0)
	arg_13_0:Refresh(arg_13_0.activity_id, false)
end

return var_0_0
