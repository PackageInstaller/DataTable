local var_0_0 = class("DormVisitRewardNewPop", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormVisitingGiftPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.awardListScroll_ = LuaList.New(handler(arg_5_0, arg_5_0.indexAwardItem), arg_5_0.uilistGo_, DormAwardNewItem)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.confirmBtn, nil, function()
		JumpTools.Back()
	end)
end

local var_0_1 = "(%d/%d)"

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = arg_8_0.params_.awardList

	arg_8_0:UpdataView()

	arg_8_0.titleTxt_.text = GetTips("ERROR_BACKHOME_VISIT_REWARD_TITLE") .. string.format(var_0_1, DormData:GetWeekReceivedGiftNum(), DormData:GetMaxWeekReceivedGiftNum())
end

function var_0_0.UpdataView(arg_9_0)
	arg_9_0.awardListScroll_:StartScroll(#arg_9_0.params_.awardList)
end

function var_0_0.indexAwardItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:RefreshUI(arg_10_0.params_.awardList[arg_10_1])
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.awardListScroll_ then
		arg_11_0.awardListScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
