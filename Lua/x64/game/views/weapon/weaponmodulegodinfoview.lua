local var_0_0 = class("WeaponModuleGodInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_module/HeroModuleGodPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, arg_4_0.curIndex_, getAstrolabeID(arg_4_0.effectList_[arg_4_1], 0))
	arg_4_2:SetSelectCallBack(arg_4_0.selectStageItemHandler_)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.curIndex_ = 1
	arg_5_0.selectStageItemHandler_ = handler(arg_5_0, arg_5_0.OnSelectStageItem)
	arg_5_0.list_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.listGo_, WeaponModuleGodItem)
end

function var_0_0.OnSelectStageItem(arg_6_0, arg_6_1)
	arg_6_0.curIndex_ = arg_6_1

	arg_6_0.list_:Refresh()
	arg_6_0:RefreshDes()
end

function var_0_0.RefreshDes(arg_7_0)
	local var_7_0 = getAstrolabeID(arg_7_0.effectList_[arg_7_0.curIndex_], 0)
	local var_7_1 = HeroAstrolabeCfg[var_7_0]

	arg_7_0.nameText1_.text = GetI18NText(var_7_1.suit_name) .. "·" .. GetI18NText(var_7_1.name)
	arg_7_0.nameText2_.text = GetI18NText(var_7_1.suit_name) .. "·" .. GetI18NText(var_7_1.name)
	arg_7_0.frontDesText_.text = GetCfgDescription(AstrolabeEffectCfg[var_7_0].desc[1], 1)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.frontcontentTrans_)

	local var_7_2

	for iter_7_0, iter_7_1 in pairs(AstrolabeEffectCfg[var_7_0].equip_orange_desc) do
		if iter_7_1[1] == 0 and iter_7_1[3] == arg_7_0.effectList_[arg_7_0.curIndex_] then
			var_7_2 = iter_7_1[2]
		end
	end

	local var_7_3 = GetCfgDescription(var_7_2, 1)

	arg_7_0.nextDesText_.text = var_7_3

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.nextcontentTrans_)
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.effectList_ = arg_10_0.params_.effectList
	arg_10_0.heroID_ = arg_10_0.params_.heroID
	arg_10_0.curIndex_ = 1

	if #arg_10_0.effectList_ > 1 then
		SetActive(arg_10_0.listGo_, true)
		arg_10_0.list_:StartScroll(#arg_10_0.effectList_)
	else
		SetActive(arg_10_0.listGo_, false)
	end

	arg_10_0:RefreshDes()
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.list_ then
		arg_11_0.list_:Dispose()

		arg_11_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
