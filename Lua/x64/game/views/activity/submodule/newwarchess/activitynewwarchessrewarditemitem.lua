local var_0_0 = class("ActivityNewWarChessRewardItemItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:AddEventListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.m_list, CommonItem)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshData(formatReward(arg_4_0.cfg_[arg_4_1]))
	arg_4_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, arg_4_0.cfg_[arg_4_1])
	end)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_receiveBtn, nil, function()
		NewWarChessAction.GetActivityReward(arg_6_0.levelID_, arg_6_0.activityId_, {
			arg_6_0.exploreLevel_
		})
	end)
end

function var_0_0.AddEventListeners(arg_8_0)
	arg_8_0:RegistEventListener(ACTIVITY_NEWWARCHESS_REWARD_UPDATE, function(arg_9_0, arg_9_1)
		if arg_9_0 == arg_8_0.levelID_ and table.indexof(arg_9_1, arg_8_0.exploreLevel_) then
			arg_8_0:UpdateView()
		end
	end)
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0.index_ = arg_10_1
	arg_10_0.levelID_ = arg_10_2
	arg_10_0.activityId_ = arg_10_3
	arg_10_0.exploreLevel_ = arg_10_4

	local var_10_0 = table.indexof(NewWarChessLevelCfg[arg_10_2].explore, arg_10_0.exploreLevel_)

	arg_10_0.cfg_ = NewWarChessLevelCfg[arg_10_0.levelID_].reward[var_10_0]

	arg_10_0:UpdateView()
end

function var_0_0.UpdateView(arg_11_0)
	arg_11_0.m_pointLab.text = arg_11_0.exploreLevel_ .. "%"

	arg_11_0.uiList_:StartScroll(#arg_11_0.cfg_)

	local var_11_0 = NewWarChessData:GetExploreValue(arg_11_0.levelID_)

	if NewWarChessData:GetRewardIsGet(arg_11_0.levelID_, arg_11_0.exploreLevel_) then
		arg_11_0.statusController_:SetSelectedState("rewarded")
	elseif var_11_0 >= arg_11_0.exploreLevel_ then
		arg_11_0.statusController_:SetSelectedState("complete")
	else
		arg_11_0.statusController_:SetSelectedState("unfinished")
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllEventListener()

	if arg_12_0.uiList_ then
		arg_12_0.uiList_:Dispose()

		arg_12_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
