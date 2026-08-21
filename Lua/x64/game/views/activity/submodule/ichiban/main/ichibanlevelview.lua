local var_0_0 = class("IchiBanLevelView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.getAllController_ = arg_1_0.uiControllerEx_:GetController("default0")
	arg_1_0.scrollList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.uiList_, IchiBanLevelItem)
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.scrollList_:Dispose()

	arg_2_0.scrollList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.uiBtn_, nil, function()
		ShowTips("ICHIBAN_COLLECT_TIPS")
	end)
	arg_3_0:AddBtnListener(arg_3_0.uiInfoBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_ichiban_teaser_news_touch",
			activity_id = arg_3_0.cfg_.activity_id,
			type = arg_3_0.cfg_.level
		})
		JumpTools.OpenPageByJump("iChiBanPop", {
			id = arg_3_0.id_
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.id_ = arg_6_1

	local var_6_0 = IchiBanTeaserCfg[arg_6_1]

	arg_6_0.cfg_ = var_6_0

	arg_6_0.scrollList_:StartScroll(#var_6_0.reward)
	arg_6_0:PlayAnimator()

	arg_6_0.uiIcon_.sprite = pureGetSpriteWithoutAtlas(var_6_0.clue_pic)

	arg_6_0:RefreshText()
end

function var_0_0.RefreshText(arg_7_0)
	arg_7_0.uiCntText_.text = string.format("%s/%s", #IchiBanData:GetIchiBanDataList(arg_7_0.cfg_.activity_id, arg_7_0.cfg_.level), #arg_7_0.cfg_.reward)
end

function var_0_0.UpdateData(arg_8_0)
	arg_8_0.scrollList_:Refresh()
	arg_8_0:PlayAnimator()
	arg_8_0:RefreshText()
end

function var_0_0.PlayAnimator(arg_9_0)
	local var_9_0 = IchiBanTools.IsGotAllLevelReward(arg_9_0.id_)

	arg_9_0.getAllController_:SetSelectedState(var_9_0 and "state1" or "state0")

	if table.keyof(IchiBanData:GetUILevelReward(arg_9_0.cfg_.activity_id), arg_9_0.cfg_.level) then
		arg_9_0.uiAnimator_:Play("Rank_unlock", 0, 0)
		arg_9_0.uiAnimator_:Update(0)
	elseif var_9_0 then
		arg_9_0.uiAnimator_:Play("Rank_unlock", 0, 1)
		arg_9_0.uiAnimator_:Update(1)
	else
		arg_9_0.uiAnimator_:Play("New State", 0, 0)
		arg_9_0.uiAnimator_:Update(0)
	end
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, arg_11_0.cfg_, rewardData)
end

return var_0_0
