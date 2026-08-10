local var_0_0 = class("AchievementStoryItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = ControllerUtil.GetController(arg_1_0.transform_, "state")

	arg_1_0:SetData(arg_1_2)
	arg_1_0:Refresh()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.buttonStory_, nil, function()
		if AchievementData:GetStoryReadFlag(arg_2_0.id_) ~= true then
			AchievementAction.ReadAchievementStory(arg_2_0.id_, function(arg_4_0)
				if isSuccess(arg_4_0.result) then
					arg_2_0:Refresh()
				else
					ShowTips(arg_4_0.result)
				end
			end)
		end

		JumpTools.OpenPageByJump("achievementStoryInfo", {
			storyID = arg_2_0.id_
		})
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.id_ = arg_5_1

	local var_5_0 = AchievementStoryCfg[arg_5_0.id_]

	arg_5_0.textTitle_.text = GetI18NText(var_5_0.name)
	arg_5_0.textTitle2_.text = GetI18NText(var_5_0.name)
end

function var_0_0.Refresh(arg_6_0)
	if AchievementStoryCfg[arg_6_0.id_].unlock_point <= AchievementData:GetAchievementPoint() then
		arg_6_0.stateController_:SetSelectedState("unlock")
	else
		arg_6_0.stateController_:SetSelectedState("lock")
	end

	if AchievementData:GetStoryReadFlag(arg_6_0.id_) == true then
		SetActive(arg_6_0.goRedPoint_, false)
	else
		SetActive(arg_6_0.goRedPoint_, true)
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
