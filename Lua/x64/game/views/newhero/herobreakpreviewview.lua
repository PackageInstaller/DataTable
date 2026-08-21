local var_0_0 = class("HeroBreakPreviewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_arrt/HeroArrtBreakPreviewPopUI"
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

	arg_4_0.needList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexNeedItem), arg_4_0.needListGo_, CommonItemView)
end

function var_0_0.indexNeedItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = arg_5_0.breakCfg_.cost[arg_5_1][1]

	function var_5_0.clickFun(arg_6_0)
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_6_0.id
		})
	end

	arg_5_2:SetData(var_5_0)

	if ItemTools.getItemNum(arg_5_0.breakCfg_.cost[arg_5_1][1]) < arg_5_0.breakCfg_.cost[arg_5_1][2] then
		arg_5_2:RefreshBottomText(string.format("<color=#F76866>%d</color>", arg_5_0.breakCfg_.cost[arg_5_1][2]))
	else
		arg_5_2:RefreshBottomText(string.format(arg_5_0.breakCfg_.cost[arg_5_1][2]))
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.preBtn_, nil, function()
		arg_7_0:SwitchBreakLevel(arg_7_0.curBreakIndex_ - 1)
	end)
	arg_7_0:AddBtnListener(arg_7_0.nextBtn_, nil, function()
		arg_7_0:SwitchBreakLevel(arg_7_0.curBreakIndex_ + 1)
	end)
end

function var_0_0.InitData(arg_11_0)
	arg_11_0.heroInfo_ = arg_11_0.params_.heroInfo
	arg_11_0.heroCfg_ = HeroCfg[arg_11_0.heroInfo_.id]
	arg_11_0.breakIdList_ = clone(HeroBreakCfg.get_id_list_by_race[arg_11_0.heroCfg_.race])
	arg_11_0.curBreakId_ = HeroTools.GetHeroBreakConfig(arg_11_0.heroCfg_.race, arg_11_0.heroInfo_.break_level or 0).id

	for iter_11_0 = 1, #arg_11_0.breakIdList_ do
		if HeroBreakCfg[arg_11_0.breakIdList_[iter_11_0]].cost_gold == 0 then
			table.remove(arg_11_0.breakIdList_, iter_11_0)

			break
		end
	end

	arg_11_0.curBreakIndex_ = table.indexof(arg_11_0.breakIdList_, arg_11_0.curBreakId_) or #arg_11_0.breakIdList_
end

function var_0_0.SwitchBreakLevel(arg_12_0, arg_12_1)
	arg_12_0.curBreakIndex_ = arg_12_1
	arg_12_0.curBreakId_ = arg_12_0.breakIdList_[arg_12_1]
	arg_12_0.breakCfg_ = HeroBreakCfg[arg_12_0.curBreakId_]

	if arg_12_0.breakCfg_.break_times < #arg_12_0.breakIdList_ then
		arg_12_0.nextBreakCfg_ = HeroTools.GetHeroBreakConfig(arg_12_0.heroCfg_.race, arg_12_0.breakCfg_.break_times + 1 or 0)
		arg_12_0.upLevelText_.text = GetTips("LEVEL") .. arg_12_0.nextBreakCfg_.max_level
	end

	arg_12_0.needList_:StartScroll(#arg_12_0.breakCfg_.cost)

	if PlayerData:GetPlayerInfo().userLevel >= arg_12_0.breakCfg_.user_level then
		arg_12_0.conditionLabel_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), arg_12_0.breakCfg_.user_level)
	else
		arg_12_0.conditionLabel_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), arg_12_0.breakCfg_.user_level)
	end

	local var_12_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)

	arg_12_0.needIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)

	if var_12_0 < arg_12_0.breakCfg_.cost_gold then
		arg_12_0.needCountLabel_.text = string.format("<color=#F76866>%d</color>", arg_12_0.breakCfg_.cost_gold)
	else
		arg_12_0.needCountLabel_.text = tostring(arg_12_0.breakCfg_.cost_gold)
	end

	SetActive(arg_12_0.preBtn_.gameObject, arg_12_1 > 1)
	SetActive(arg_12_0.nextBtn_.gameObject, arg_12_1 < #arg_12_0.breakIdList_)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:InitData()
	arg_13_0:SwitchBreakLevel(arg_13_0.curBreakIndex_)
end

function var_0_0.CameraEnter(arg_14_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		2
	})
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0:SwitchBreakLevel(arg_15_0.curBreakIndex_)
end

function var_0_0.OnExit(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.needList_ then
		arg_17_0.needList_:Dispose()

		arg_17_0.needList_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
