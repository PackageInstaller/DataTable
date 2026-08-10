local var_0_0 = class("CustomCenterSceneDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/CustomCenter/CustomCenterDetailUI"
end

local var_0_1 = {
	DESC = 1,
	TAG = 2
}

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.itemList_ = {}
	arg_3_0.typeController_ = arg_3_0.controllerEx_:GetController("type")
	arg_3_0.showDescController = arg_3_0.controllerEx_:GetController("showDesc")

	function arg_3_0.onItemSelect(arg_4_0)
		arg_3_0:OnItemSelect(arg_4_0)
	end

	function arg_3_0.onItemClearSelect(arg_5_0)
		arg_3_0:OnItemClearSelect(arg_5_0)
	end
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	arg_6_0.sceneID_ = arg_6_0.params_.sceneID
	arg_6_0.curType_ = var_0_1.DESC

	arg_6_0:RefreshUI()
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:SetTagDetail(nil, nil)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.itemList_) do
		iter_8_1:Dispose()
	end

	arg_8_0.itemList_ = {}

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.typeBtn_, nil, function()
		if arg_9_0.curType_ == var_0_1.DESC then
			arg_9_0.curType_ = var_0_1.TAG
		else
			arg_9_0.curType_ = var_0_1.DESC
		end

		arg_9_0:SwitchType()
	end)
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = HomeSceneSettingCfg[arg_11_0.sceneID_]

	arg_11_0.titleText_.text = var_11_0.title
	arg_11_0.descText_.text = var_11_0.desc

	arg_11_0:SwitchType(var_11_0)
	arg_11_0:RefreshItemList(var_11_0.scene_tag)
end

function var_0_0.SwitchType(arg_12_0)
	arg_12_0.tagTglGroup_:SetAllTogglesOff()

	if arg_12_0.curType_ == var_0_1.DESC then
		arg_12_0.typeController_:SetSelectedState("desc")
	else
		arg_12_0.typeController_:SetSelectedState("tag")
	end
end

function var_0_0.RefreshItemList(arg_13_0, arg_13_1)
	for iter_13_0 = 1, #arg_13_1 do
		local var_13_0 = arg_13_0.itemList_[iter_13_0] or CustomCenterSceneDetailTagItem.New(arg_13_0.itemGo_, arg_13_0.itemParent_)

		arg_13_0.itemList_[iter_13_0] = var_13_0

		var_13_0:SetData(arg_13_1[iter_13_0])
		var_13_0:SetOnSelectCallback(arg_13_0.onItemSelect)
		var_13_0:SetOnClearCallback(arg_13_0.onItemClearSelect)
	end

	for iter_13_1 = #arg_13_1 + 1, #arg_13_0.itemList_ do
		arg_13_0.itemList_[iter_13_1]:Show(false)
	end
end

function var_0_0.OnItemSelect(arg_14_0, arg_14_1)
	arg_14_0:SetTagDetail(arg_14_1.cfg.tag_desc, arg_14_1.cfg.tag_detail)
end

function var_0_0.OnItemClearSelect(arg_15_0, arg_15_1)
	arg_15_0:SetTagDetail(nil, nil)
end

function var_0_0.SetTagDetail(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 then
		arg_16_0.tagName_.text = arg_16_1
		arg_16_0.tagDesc_.text = arg_16_2

		arg_16_0.showDescController:SetSelectedState("true")
	else
		arg_16_0.showDescController:SetSelectedState("false")
	end
end

return var_0_0
