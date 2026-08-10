local var_0_0 = class("EquipBreakThroughMaterialMapInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapDetailsPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "name")
	arg_3_0.toggleItemList_ = {
		EquipBreakThroughMaterialMapInfoBtn.New(arg_3_0.teamInfoGo_, EquipBreakThroughMaterialConst.TOGGLE_TYPE.TEAM),
		EquipBreakThroughMaterialMapInfoBtn.New(arg_3_0.buffGo_, EquipBreakThroughMaterialConst.TOGGLE_TYPE.BUFF)
	}
	arg_3_0.selectToggleHandler_ = handler(arg_3_0, arg_3_0.RefreshToggle)
	arg_3_0.teamInfoView_ = EquipBreakThroughMaterialTeamInfoView.New(arg_3_0.teamContentGo_)
	arg_3_0.buffView_ = EquipBreakThroughMaterialBuffView.New(arg_3_0.buffContentGo_)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.toggleType_ = arg_4_0.params_.toggleType

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.toggleItemList_) do
		iter_4_1:OnEnter(arg_4_0.toggleType_)
	end

	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, arg_4_0.selectToggleHandler_)
	arg_4_0:RefreshToggle(arg_4_0.toggleType_)
	arg_4_0.teamInfoView_:OnEnter()
	arg_4_0.buffView_:OnEnter()
end

function var_0_0.OnExit(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.toggleItemList_) do
		iter_5_1:OnExit()
	end

	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, arg_5_0.selectToggleHandler_)
	arg_5_0.teamInfoView_:OnExit()
	arg_5_0.buffView_:OnExit()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.toggleItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.toggleItemList_ = nil
	arg_6_0.selectToggleHandler_ = nil

	arg_6_0.teamInfoView_:Dispose()

	arg_6_0.teamInfoView_ = nil

	arg_6_0.buffView_:Dispose()

	arg_6_0.buffView_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	return
end

function var_0_0.RefreshToggle(arg_8_0, arg_8_1)
	if arg_8_1 == EquipBreakThroughMaterialConst.TOGGLE_TYPE.BUFF then
		arg_8_0.controller_:SetSelectedState("buff")
	else
		arg_8_0.controller_:SetSelectedState("team")
	end
end

return var_0_0
