local var_0_0 = class("NiewWorldBossRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.width = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.state == 1 then
			ActivityWorldBossAction.QueryHealthRward(arg_4_0.activity_id, {
				arg_4_0.index
			})
		elseif arg_4_0.state == 2 then
			JumpTools.OpenPageByJump("rewardPreview", {
				is_receive = true,
				rewardList = arg_4_0.rewardList
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		else
			JumpTools.OpenPageByJump("rewardPreview", {
				is_receive = false,
				rewardList = arg_4_0.rewardList
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.activity_id = arg_6_1
	arg_6_0.index = arg_6_2

	local var_6_0 = ActivityWorldBossCfg[arg_6_1].health_reward_list[arg_6_2]
	local var_6_1 = var_6_0[1] / 10
	local var_6_2 = var_6_0[2]

	arg_6_0.rewardList = getRewardFromDropCfg(var_6_2, true)
	arg_6_0.m_lab.text = var_6_1 .. "%"

	local var_6_3 = arg_6_0.width - arg_6_0.width * var_6_1 / 100

	arg_6_0.transform_.localPosition = Vector3.New(var_6_3, 0, 0)
	arg_6_0.state = ActivityWorldBossData:GetHealthRewardState(arg_6_1, arg_6_2)

	arg_6_0.stateController:SetSelectedIndex(arg_6_0.state)
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
