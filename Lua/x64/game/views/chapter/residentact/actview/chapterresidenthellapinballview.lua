ChapterResidentActBaseView = import("game.views.chapter.residentAct.ChapterResidentActBaseView")

local var_0_0 = class("ChapterResidentHellaPinballView", ChapterResidentActBaseView)

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:AddUIListener()

	if arg_1_0.rewardListGo_ then
		arg_1_0.rewardList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexRewardItem), arg_1_0.rewardListGo_, CommonItemView)
	end

	arg_1_0.btnStateController_ = arg_1_0.controller_:GetController("btnState")

	arg_1_0:BindRed(true)

	arg_1_0.progressControlller_ = arg_1_0.progressControllerEx_:GetController("progress")
end

function var_0_0.RefreshUI(arg_2_0)
	var_0_0.super.RefreshUI(arg_2_0)

	arg_2_0.progress_ = PinballData:GetStageFinishProgress()
	arg_2_0.progressSlider_.value = arg_2_0.progress_
	arg_2_0.progressValueTxt_.text = math.floor(arg_2_0.progress_ * 100) .. "%"

	if arg_2_0.progress_ < 0.42 then
		arg_2_0.progressControlller_:SetSelectedState("yellow")
	elseif arg_2_0.progress_ < 0.67 then
		arg_2_0.progressControlller_:SetSelectedState("orange")
	elseif arg_2_0.progress_ < 1 then
		arg_2_0.progressControlller_:SetSelectedState("red")
	else
		arg_2_0.progressControlller_:SetSelectedState("green")
	end
end

return var_0_0
