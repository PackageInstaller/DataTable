local var_0_0 = class("DrawAllHeroSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/pool_3000304_SelectPop"
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
	arg_5_0:InitTapView()

	arg_5_0.btnCon_ = arg_5_0.collection_:GetController("btn")
	arg_5_0.tipCon_ = arg_5_0.collection_:GetController("tips")
	arg_5_0.scrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, DrawAllHeroSelectItem)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.curList_[arg_6_1]

	arg_6_2.gameObject_.name = tostring(var_6_0)

	arg_6_2:SetHeroID(var_6_0, arg_6_0.type_)
	arg_6_2:SetSelected(arg_6_2.heroID_ == arg_6_0.curHeroId_)
	arg_6_2:RegisterClickListener(handler(arg_6_0, arg_6_0.OnHeroClick))
end

function var_0_0.OnHeroClick(arg_7_0, arg_7_1)
	arg_7_0.curHeroId_ = arg_7_1

	arg_7_0:UpdateBtnState()
	arg_7_0.scrollHelper_:Refresh()
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btnLock_, nil, function()
		ShowTips("DRAW_NOT_SELECT_TIPS")
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnrenewalBtn_, nil, function()
		if arg_8_0.curHeroId_ == nil or arg_8_0.curHeroId_ == 0 then
			return
		end

		if arg_8_0.curHeroId_ == arg_8_0.params_.heroId then
			arg_8_0:Back()
		else
			if arg_8_0.params_.isFirst then
				arg_8_0:ChangeUp()

				return
			end

			if DrawPoolCfg[arg_8_0.params_.poolId].pool_change == 0 then
				arg_8_0:ChangeUp()
			else
				arg_8_0:ShowChangeUpPopTip()
			end
		end
	end)
end

function var_0_0.ChangeUp(arg_11_0)
	local var_11_0 = DrawPoolCfg[arg_11_0.params_.poolId]
	local var_11_1 = table.indexof(var_11_0.optional_detail, arg_11_0.curHeroId_)
	local var_11_2 = var_11_0.optional_lists_poolId[var_11_1]

	DrawAction.SetPollUpID(arg_11_0.params_.poolId, var_11_2)
end

function var_0_0.ShowChangeUpPopTip(arg_12_0)
	ShowMessageBox({
		isTop = true,
		title = GetTips("PROMPT"),
		content = GetTips("DRAW_SWITCH_LIMIT_CONFIRM_TIP"),
		SecondTip = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), ""),
		SecondValue = DrawData:GetUpRemainTime(arg_12_0.params_.poolId),
		OkCallback = function()
			arg_12_0:ChangeUp()
		end,
		CancelCallback = function()
			return
		end
	})
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.upID = DrawData:GetPollUpID(arg_15_0.params_.poolId)
	arg_15_0.upHeroID = DrawData:ConvertUpId(arg_15_0.params_.poolId, arg_15_0.upID, 0)
	arg_15_0.curHeroId_ = arg_15_0.upHeroID

	arg_15_0:RefreshData()
	arg_15_0:UpdateBtnState()
	arg_15_0:UpdateTipState()
	arg_15_0:RefreshTap()
	arg_15_0:AddEventListeners()

	if arg_15_0.curHeroId_ == 0 then
		arg_15_0.btnCon_:SetSelectedState("false")
	else
		arg_15_0.btnCon_:SetSelectedState("current")
	end

	arg_15_0:UpdateTitleTxt()
end

function var_0_0.UpdateTitleTxt(arg_16_0)
	local var_16_0 = arg_16_0.params_.poolId

	if DrawPoolCfg[var_16_0].pool_type == 9 then
		arg_16_0.titleTxt_.text = GetTips("NEW_REGRESSION__POOL_SCREEN_TYPE_3")
	else
		arg_16_0.titleTxt_.text = GetTips("NEW_REGRESSION__POOL_SCREEN_TYPE_2")
	end
end

function var_0_0.RefreshData(arg_17_0)
	if arg_17_0.poolID_ ~= arg_17_0.params_.poolId then
		arg_17_0.allHeroList_ = arg_17_0.params_.heroIdList
		arg_17_0.poolID_ = arg_17_0.params_.poolId
		arg_17_0.tapSort_ = {}
	end
end

function var_0_0.UpdateBtnState(arg_18_0)
	local var_18_0 = DrawData:GetPollUpID(arg_18_0.params_.poolId)
	local var_18_1 = DrawData:ConvertUpId(arg_18_0.params_.poolId, var_18_0, 0)

	arg_18_0.btnCon_:SetSelectedState(arg_18_0.curHeroId_ ~= var_18_1 and "true" or "current")
end

function var_0_0.UpdateTipState(arg_19_0)
	if DrawPoolCfg[arg_19_0.params_.poolId].pool_change == 0 or arg_19_0.params_.isFirst then
		arg_19_0.tipCon_:SetSelectedState("true")
	else
		arg_19_0.tipCon_:SetSelectedState("false")

		local var_19_0 = DrawData:GetPoolUpTimes(arg_19_0.params_.poolId)
		local var_19_1 = DrawPoolCfg[arg_19_0.params_.poolId].pool_change - var_19_0

		arg_19_0.timesText_.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(var_19_1))
	end
end

function var_0_0.RefreshTap(arg_20_0)
	if not arg_20_0.params_.isBack then
		arg_20_0.tapView_:Reset()
	end

	arg_20_0.tapView_:Refresh()
end

function var_0_0.RefreshList(arg_21_0)
	local var_21_0

	if arg_21_0.isAll_ then
		var_21_0 = arg_21_0.allHeroList_
	else
		if not arg_21_0.tapSort_[arg_21_0.selectTapID_] then
			local var_21_1 = {}

			for iter_21_0, iter_21_1 in ipairs(arg_21_0.allHeroList_) do
				local var_21_2 = HeroCfg[iter_21_1].ATK_attribute[1]

				if arg_21_0.selectTapID_ == var_21_2 then
					table.insert(var_21_1, iter_21_1)
				end
			end

			arg_21_0.tapSort_[arg_21_0.selectTapID_] = var_21_1
		end

		var_21_0 = arg_21_0.tapSort_[arg_21_0.selectTapID_]
	end

	if not arg_21_0.curList_ or not table.equal(arg_21_0.curList_, var_21_0, "all") then
		arg_21_0.curList_ = var_21_0

		arg_21_0.scrollHelper_:StartScroll(#arg_21_0.curList_)
	end
end

function var_0_0.AddEventListeners(arg_22_0)
	return
end

function var_0_0.OnSetPollUpID(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:Back()
end

function var_0_0.OnTop(arg_24_0)
	arg_24_0:UpdateBar()
end

function var_0_0.OnBehind(arg_25_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_26_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_27_0)
	arg_27_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_28_0)
	return
end

function var_0_0.Dispose(arg_29_0)
	if arg_29_0.tapView_ then
		arg_29_0.tapView_:Dispose()

		arg_29_0.tapView_ = nil
	end

	if arg_29_0.scrollHelper_ then
		arg_29_0.scrollHelper_:Dispose()

		arg_29_0.scrollHelper_ = nil
	end

	var_0_0.super.Dispose(arg_29_0)
end

function var_0_0.InitTapView(arg_30_0)
	arg_30_0.tapTypeList_ = {
		HeroConst.HERO_ATTACK_TYPE.ALL,
		HeroConst.HERO_ATTACK_TYPE.PYISICS,
		HeroConst.HERO_ATTACK_TYPE.WIND,
		HeroConst.HERO_ATTACK_TYPE.FLAME,
		HeroConst.HERO_ATTACK_TYPE.THUNDER,
		HeroConst.HERO_ATTACK_TYPE.DARK,
		HeroConst.HERO_ATTACK_TYPE.LIGHT,
		HeroConst.HERO_ATTACK_TYPE.FREEZE,
		HeroConst.HERO_ATTACK_TYPE.WATER,
		HeroConst.HERO_ATTACK_TYPE.RANDOM
	}
	arg_30_0.tapView_ = CommonHeroSkillAttributeFilter.New(arg_30_0.tapGo_)

	arg_30_0.tapView_:SetAttributeIdList(arg_30_0.tapTypeList_)
	arg_30_0.tapView_:SetSelectAttributeCallback(handler(arg_30_0, arg_30_0.OnSelectTap))
end

function var_0_0.ResetTap(arg_31_0)
	arg_31_0.selectTapID_ = 1

	arg_31_0.tapView_:Reset()
end

function var_0_0.OnSelectTap(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0.selectTapID_ = arg_32_1
	arg_32_0.isAll_ = arg_32_2

	arg_32_0:RefreshList()
end

return var_0_0
