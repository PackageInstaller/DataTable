local var_0_0 = class("AutoChessOpenCardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.cardID_ = 0

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.btnController_ = arg_3_0.controller_:GetController("Btn")
	arg_3_0.isCompleteController_ = arg_3_0.controller_:GetController("completeBtn")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		if arg_4_0.activityId_ == ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD then
			if not ActivityData:GetActivityIsOpen(arg_4_0.activityId_) then
				return
			end

			if AutoChessCardData:GetFriendCardList() == nil then
				AutoChessCardAction.GetCardDesireList(AutoChessCardConst.DESIRE_TYPE.FRIEND, function()
					if AutoChessCardData:GetOtherCardList() == nil then
						AutoChessCardAction.GetCardDesireList(AutoChessCardConst.DESIRE_TYPE.OTHER, function()
							JumpTools.OpenPageByJump("/autoChessDesireMainView")
						end)
					else
						JumpTools.OpenPageByJump("/autoChessDesireMainView")
					end
				end)
			elseif AutoChessCardData:GetOtherCardList() == nil then
				AutoChessCardAction.GetCardDesireList(AutoChessCardConst.DESIRE_TYPE.OTHER, function()
					JumpTools.OpenPageByJump("/autoChessDesireMainView")
				end)
			else
				JumpTools.OpenPageByJump("/autoChessDesireMainView")
			end
		elseif arg_4_0.activityId_ == ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8 then
			if AutoChessCardData:GetCardBagPower() >= GameSetting.auto_chess_2_pack_energy_max.value[1] then
				saveData("auto_chess_4_8", "card_power_is_show", 0)
			end

			manager.redPoint:setTip(RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW, 0)
			JumpTools.OpenPageByJump("/autoChessRemakeMainView", {
				isStartMatch = true
			})
		end
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1)
	arg_9_0.activityId_ = arg_9_1

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = 0

	if arg_10_0.activityId_ == ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD then
		arg_10_0.txtTitle_.text = GetTips("AUTO_CHESS_2_SOURCE_EXCHANGE")

		local var_10_2 = GameSetting.auto_chess_2_exchange_reward_pack_num.value[1]

		var_10_1 = AutoChessCardData:GetIsDayReward() == 1 and 0 or var_10_2
		arg_10_0.txtNum_.text = string.format("%d/%d", var_10_1, var_10_2)
	else
		arg_10_0.txtTitle_.text = GetTips("AUTO_CHESS_2_SOURCE_BATTLE")

		local var_10_3 = GameSetting.auto_chess_2_pack_energy_max.value[1]

		var_10_1 = AutoChessCardData:GetCardBagPower()
		arg_10_0.txtNum_.text = string.format("%d/%d", var_10_1, var_10_3)
	end

	if var_10_1 == 0 then
		arg_10_0.btnController_:SetSelectedState("completeBtn")
		arg_10_0.isCompleteController_:SetSelectedState("on")
	else
		arg_10_0.btnController_:SetSelectedState("goBtn")
	end
end

function var_0_0.SetActive(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.GetBtnTransform(arg_12_0)
	return arg_12_0.goBtn_.transform
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
