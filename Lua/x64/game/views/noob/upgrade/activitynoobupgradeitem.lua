local var_0_0 = class("ActivityNoobUpgradeView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "stage")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		local var_3_0 = GameSetting.levelup_reward.value[arg_2_0.index_]
		local var_3_1 = var_3_0[1]

		if arg_2_0.isFinish_ and not table.keyof(ActivityNoobData:GetUpgradeFinishList(), var_3_1) then
			ActivityNoobAction.ReceiveUpgradeReward(var_3_1, function(arg_4_0)
				if isSuccess(arg_4_0.result) then
					getReward2(arg_4_0.reward_list)
					ActivityNoobData:SetUpgradeFinish(var_3_1)
					ActivityNoobAction.PlayerUpgradeRedPoint()
					arg_2_0:ReceiveReward()
				else
					ShowTips(arg_4_0.result)
				end
			end)
		else
			JumpTools.OpenPageByJump("rewardPreview", {
				rewardList = {
					var_3_0[2]
				}
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.disposed_ = true

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = PlayerData:GetPlayerInfo().userLevel
	local var_6_1 = GameSetting.levelup_reward.value[arg_6_0.index_][1]

	arg_6_0.isFinish_ = var_6_1 <= var_6_0

	if arg_6_0.isFinish_ then
		if table.keyof(ActivityNoobData:GetUpgradeFinishList(), var_6_1) then
			arg_6_0:ReceiveReward()
		else
			arg_6_0.controller_:SetSelectedState("1")
		end
	else
		arg_6_0.controller_:SetSelectedState("0")
	end

	local var_6_2 = GameSetting.levelup_reward.value[arg_6_0.index_]

	ItemTools.GetItemSpriteAsync(var_6_2[2][1], function(arg_7_0, arg_7_1)
		if arg_6_0.disposed_ then
			return
		end

		if arg_7_0 == var_6_2[2][1] then
			arg_6_0.imageImg_.sprite = arg_7_1
		end
	end)
end

function var_0_0.ReceiveReward(arg_8_0)
	arg_8_0.controller_:SetSelectedState("2")
end

return var_0_0
