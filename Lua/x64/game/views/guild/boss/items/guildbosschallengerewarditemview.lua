local var_0_0 = class("GuildBossChallengeRewardItemView", ReduxView)

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

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.gameObject_:GetComponent(typeof(Button)), nil, function()
		if not GuildData:HaveGetGuildBossPersonalReward(arg_4_0.needScore_) and arg_4_0.score_ >= arg_4_0.needScore_ then
			GuildAction.GetGuildBossReward(GuildData:GetGuildInfo().id, 1, arg_4_0.needScore_)
		else
			JumpTools.OpenPageByJump("rewardPreview", {
				rewardList = arg_4_0.bonusDataList_
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.data_ = arg_7_1
	arg_7_0.score_ = arg_7_2
	arg_7_0.needScore_ = arg_7_0.data_[1]
	arg_7_0.bonusDataList_ = arg_7_0.data_[2]

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.scoreLabel_.text = arg_8_0.needScore_

	if GuildData:HaveGetGuildBossPersonalReward(arg_8_0.needScore_) then
		arg_8_0.statusController_:SetSelectedState("haveGet")
	elseif arg_8_0.score_ >= arg_8_0.needScore_ then
		arg_8_0.statusController_:SetSelectedState("canGet")
	else
		arg_8_0.statusController_:SetSelectedState("cannotGet")
	end
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:AddEventListeners()
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.data_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
