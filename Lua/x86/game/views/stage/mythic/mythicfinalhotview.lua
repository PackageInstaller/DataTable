local var_0_0 = class("MythicFinalHotView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI(arg_1_0.gameObject_)
	arg_1_0:AddListeners()

	arg_1_0.List_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshFilterItem), arg_1_0.uiList_, MythicFinalHotItem)
	arg_1_0.levelList_ = MythicFinalCfg.all
	arg_1_0.handler_ = handler(arg_1_0, arg_1_0.OnMythicFinalHotItemClick)
end

function var_0_0.OnEnter(arg_2_0)
	local var_2_0 = MythicData:GetCurHotLevelId()

	arg_2_0.filterID_ = 1

	if var_2_0 then
		arg_2_0.filterID_ = table.indexof(MythicFinalCfg.all, var_2_0) or 1
	end

	arg_2_0:RefreshUI()
	arg_2_0.List_:StartScroll(#arg_2_0.levelList_, arg_2_0.filterID_)
	manager.notify:RegistListener(MYTHIC_FINAL_HOTITEM_CLICK, arg_2_0.handler_)
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(MYTHIC_FINAL_HOTITEM_CLICK, arg_3_0.handler_)
	SetActive(arg_3_0.filterPanel_, false)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.mask_, nil, function()
		SetActive(arg_4_0.filterPanel_, false)
	end)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		SetActive(arg_4_0.filterPanel_, true)
	end)
	arg_4_0:AddBtnListener(arg_4_0.closebtn_, nil, function()
		SetActive(arg_4_0.filterPanel_, false)
	end)
end

function var_0_0.RefreshFilterItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.levelList_[arg_8_1]

	arg_8_2:SetSpectID(var_8_0, arg_8_1, arg_8_0.filterID_)
end

function var_0_0.OnMythicFinalHotItemClick(arg_9_0, arg_9_1)
	arg_9_0.filterID_ = arg_9_1

	SetActive(arg_9_0.filterPanel_, false)
	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.levelText_.text = MythicFinalCfg[arg_10_0.filterID_].id
	arg_10_0.hotlevelText_.text = string.format(MythicFinalCfg[arg_10_0.filterID_].level_diffuculty)

	MythicData:SetCurHotLevelId(MythicFinalCfg[arg_10_0.filterID_].id)

	if MythicData:GetHotLevelIsPass(MythicData:GetCurHotLevelId()) then
		SetActive(arg_10_0.ispassGo_, true)
	else
		SetActive(arg_10_0.ispassGo_, false)
	end
end

function var_0_0.OnMythicFinalUpdate(arg_11_0)
	local var_11_0 = MythicData:GetCurHotLevelId()

	arg_11_0.filterID_ = 1

	if var_11_0 then
		arg_11_0.filterID_ = table.indexof(MythicFinalCfg.all, var_11_0) or 1
	end

	arg_11_0:RefreshUI()
	arg_11_0.List_:StartScroll(#arg_11_0.levelList_, 1)
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.List_ then
		arg_12_0.List_:Dispose()

		arg_12_0.List_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
