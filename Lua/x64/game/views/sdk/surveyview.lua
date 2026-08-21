local var_0_0 = class("SurveyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Medium/InvestigateUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.surveyList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, SurveyItem)
	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "conName")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.UpdateData(arg_7_0)
	arg_7_0.itemList_ = {}

	local var_7_0 = SurveyData:GetSurveyList()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if arg_7_0.params_.type == iter_7_1.type then
			table.insert(arg_7_0.itemList_, iter_7_1)
		end
	end

	table.sort(arg_7_0.itemList_, function(arg_8_0, arg_8_1)
		local function var_8_0(arg_9_0)
			if arg_9_0 == 1 then
				return 1
			end

			if arg_9_0 == 2 then
				return 3
			end

			if arg_9_0 == 0 then
				return 2
			end
		end

		local var_8_1 = var_8_0(arg_8_0.status)
		local var_8_2 = var_8_0(arg_8_1.status)

		if var_8_1 ~= var_8_2 then
			return var_8_1 < var_8_2
		end

		return arg_8_0.id > arg_8_1.id
	end)
end

function var_0_0.indexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:RefreshUI(arg_10_0.itemList_[arg_10_1])
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:UpdateData()

	if #arg_11_0.itemList_ <= 0 then
		arg_11_0.controller_:SetSelectedState("false")
	else
		arg_11_0.controller_:SetSelectedState("true")
		arg_11_0.surveyList_:StartScroll(#arg_11_0.itemList_)
	end
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.OnGetSurveyGift(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:UpdateData()
	arg_13_0.surveyList_:StartScroll(#arg_13_0.itemList_)
	getReward2(mergeReward2(arg_13_1.item_list))
end

function var_0_0.OnFinishSurvey(arg_14_0)
	arg_14_0:UpdateData()
	arg_14_0.surveyList_:StartScroll(#arg_14_0.itemList_)
end

function var_0_0.OnExitInput(arg_15_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.surveyList_:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
