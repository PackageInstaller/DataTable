local var_0_0 = class("NewbieDrawHeroSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/NewbiePoolSelectPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
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

	arg_5_0.btnController_ = arg_5_0.controller_:GetController("btn")
	arg_5_0.limitController_ = arg_5_0.controller_:GetController("tips")
	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, NewBieDrawHeroItem)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.idList_[arg_6_1])
	arg_6_2:RegistClickFunc(function()
		arg_6_0:OnHeroClick(arg_6_0.idList_[arg_6_1])
	end)
	arg_6_2:RefreshSelect(arg_6_0.curHeroId_ == arg_6_0.idList_[arg_6_1])
end

function var_0_0.OnHeroClick(arg_8_0, arg_8_1)
	if arg_8_0.upHeroID == arg_8_1 then
		arg_8_0.btnController_:SetSelectedState("current")
	else
		arg_8_0.btnController_:SetSelectedState(arg_8_0.upID ~= arg_8_1 and "true" or "current")
	end

	arg_8_0.curHeroId_ = arg_8_1

	arg_8_0.uiList_:Refresh()
end

function var_0_0.AddUIListener(arg_9_0)
	local function var_9_0()
		local var_10_0 = DrawPoolCfg[arg_9_0.params_.poolId]
		local var_10_1 = table.indexof(var_10_0.optional_detail, arg_9_0.curHeroId_)
		local var_10_2 = var_10_0.optional_lists_poolId[var_10_1]

		DrawAction.SetPollUpID(arg_9_0.params_.poolId, var_10_2)
	end

	arg_9_0:AddBtnListener(arg_9_0.btnrenewalBtn_, nil, function()
		if arg_9_0.curHeroId_ == nil or arg_9_0.curHeroId_ == 0 then
			return
		end

		if arg_9_0.curHeroId_ == arg_9_0.upHeroID then
			arg_9_0:Back()

			return
		end

		if DrawPoolCfg[arg_9_0.params_.poolId].pool_type == 1 then
			var_9_0()

			return
		end

		if arg_9_0.params_.isFirst then
			var_9_0()

			return
		end

		if arg_9_0.upHeroID == 0 then
			var_9_0()
		elseif DrawPoolCfg[arg_9_0.params_.poolId].pool_change == 0 then
			var_9_0()
		else
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("DRAW_POOL_SCREEN_TYPE_4"),
				SecondTip = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), ""),
				SecondValue = DrawData:GetUpRemainTime(arg_9_0.params_.poolId),
				OkCallback = var_9_0
			})
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.btnLock_, nil, function()
		if arg_9_0.curHeroId_ == nil or arg_9_0.curHeroId_ == 0 then
			ShowTips("DRAW_NOT_SELECT_TIPS")

			return
		end
	end)
end

function var_0_0.OnSetPollUpID(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:Back()
end

function var_0_0.OnTop(arg_14_0)
	arg_14_0:UpdateBar()
end

function var_0_0.OnBehind(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.upID = DrawData:GetPollUpID(arg_17_0.params_.poolId)
	arg_17_0.upHeroID = DrawData:ConvertUpId(arg_17_0.params_.poolId, arg_17_0.upID, 0)
	arg_17_0.curHeroId_ = arg_17_0.upHeroID

	if arg_17_0.curHeroId_ == 0 then
		arg_17_0.btnController_:SetSelectedState("false")
	else
		arg_17_0.btnController_:SetSelectedState("current")
	end

	local var_17_0 = DrawPoolCfg[arg_17_0.params_.poolId]

	arg_17_0.titleTxt1_.text = GetTips(var_17_0.pool_type == 1 and "DRAW_SELECT_STANDARD_TIPS" or "DRAW_SELECT_NEWBEE_TIPS")
	arg_17_0.titleTxt2_.text = GetTips(var_17_0.pool_type == 1 and "DRAW_STANDARD_TIPS" or "DRAW_NEWBEE_TIPS")

	arg_17_0:UpdateList()
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0:RemoveAllEventListener()

	arg_18_0.params_.heroId = arg_18_0.curHeroId_
	arg_18_0.params_.poolId = arg_18_0.params_.poolId
	arg_18_0.params_.isFirst = arg_18_0.params_.isFirst

	manager.windowBar:HideBar()
end

function var_0_0.UpdateList(arg_19_0)
	arg_19_0.idList_ = arg_19_0.params_.heroIdList

	arg_19_0.uiList_:StartScroll(#arg_19_0.idList_)

	local var_19_0 = DrawPoolCfg[arg_19_0.params_.poolId]

	if var_19_0.pool_change == 0 or arg_19_0.params_.isFirst then
		arg_19_0.limitController_:SetSelectedState("false")
	else
		arg_19_0.limitController_:SetSelectedState("true")

		local var_19_1 = DrawData:GetPoolUpTimes(arg_19_0.params_.poolId)
		local var_19_2 = DrawPoolCfg[arg_19_0.params_.poolId].pool_change - var_19_1

		arg_19_0.timesText_.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(var_19_2))
	end

	if var_19_0.pool_type == 9 then
		arg_19_0.uilistSrex_.enabled = true
	else
		arg_19_0.uilistSrex_.enabled = false
	end
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.uiList_ then
		arg_20_0.uiList_:Dispose()

		arg_20_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
