local var_0_0 = class("PlotTalkItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockController_ = arg_3_0.controller_:GetController("lock")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.talkBtn_, nil, function()
		if arg_4_0.clickLimitFunc_ and not arg_4_0.clickLimitFunc_(arg_4_0.preStoryID_) then
			return
		end

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		manager.story:StartStoryById(arg_4_0.storyId_, function()
			if arg_4_0.storyCallBack_ then
				arg_4_0.storyCallBack_(arg_4_0.storyId_)
			end
		end)

		if arg_4_0.callBack_ then
			arg_4_0.callBack_()
		end
	end)
end

function var_0_0.SetClickLimitFunc(arg_7_0, arg_7_1)
	arg_7_0.clickLimitFunc_ = arg_7_1
end

function var_0_0.SetCallBack(arg_8_0, arg_8_1)
	arg_8_0.callBack_ = arg_8_1
end

function var_0_0.SetStoryCallBack(arg_9_0, arg_9_1)
	arg_9_0.storyCallBack_ = arg_9_1
end

function var_0_0.OnEnter(arg_10_0)
	return
end

function var_0_0.RefreshUI(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.titleText_.text = arg_11_1
	arg_11_0.storyId_ = arg_11_2
	arg_11_0.preStoryID_ = arg_11_3

	if arg_11_3 > 0 and not manager.story:IsStoryPlayed(arg_11_3) then
		arg_11_0.lockController_:SetSelectedState("on")
	else
		arg_11_0.lockController_:SetSelectedState("off")
	end
end

function var_0_0.Show(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.descRect_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.rect_)
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
