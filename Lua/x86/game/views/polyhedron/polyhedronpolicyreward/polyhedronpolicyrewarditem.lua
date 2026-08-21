local var_0_0 = class("PolyhedronPolicyRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	if arg_4_0.btn_ then
		arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
			PolyhedronAction.QueryPolicyReward(2, arg_4_0.level_)
		end)
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.ID_ = arg_6_1
	arg_6_0.rewardCfg_ = PolyhedronPolicyCfg[arg_6_0.ID_].rewards[1]
	arg_6_0.level_ = PolyhedronPolicyCfg[arg_6_0.ID_].level
	arg_6_0.curLevel_ = arg_6_2

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.levelText_.text = arg_7_0.level_

	local var_7_0 = clone(ItemTemplateData)

	var_7_0.id = arg_7_0.rewardCfg_[1]
	var_7_0.number = arg_7_0.rewardCfg_[2]

	function var_7_0.clickFun(arg_8_0)
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_8_0.id,
			arg_8_0.number
		})
	end

	if arg_7_0.commonItem_ == nil then
		arg_7_0.commonItem_ = CommonItemPool.New(arg_7_0.rewardPanelGo_, var_7_0)
	else
		arg_7_0.commonItem_:SetData(var_7_0)
	end

	local var_7_1 = PolyhedronData:GetPolicyApplyList()

	if arg_7_0.stateController_ then
		if var_7_1[arg_7_0.level_] == true then
			arg_7_0.stateController_:SetSelectedState("received")
		elseif arg_7_0.curLevel_ >= arg_7_0.level_ then
			arg_7_0.stateController_:SetSelectedState("unreceive")
		else
			arg_7_0.stateController_:SetSelectedState("uncomplete")
		end
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.commonItem_:Dispose()

	arg_9_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
