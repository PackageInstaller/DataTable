local var_0_0 = class("ActivityWuluoVehicleInfoPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_BallInfoPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListner()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.vehicleSkillItemList_ = {}
	arg_4_0.vehicleSkillIdList_ = MergeBallVehicleCfg.get_id_list_by_type[BilliardGameConst.VehicleType.SKILL]

	for iter_4_0 = 1, #arg_4_0.vehicleSkillIdList_ do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, arg_4_0["gearGo_" .. iter_4_0])

		var_4_0.lockController = var_4_0.transCon_:GetController("lock")

		table.insert(arg_4_0.vehicleSkillItemList_, var_4_0)
	end

	arg_4_0.vehicleList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.vehicleListGo_, VehicleSelectItemView)
end

function var_0_0.AddUIListner(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		if arg_5_0.selectedItem_ then
			VehicleBallAction.SetVehicle({
				vehicleId = arg_5_0.selectedVehicleId_
			})
		end

		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.vehicleIdList_ = MergeBallVehicleCfg.get_id_list_by_type[BilliardGameConst.VehicleType.VEHICLE]
	arg_7_0.passedStageList_ = VehicleBallData:GetPassedStageList()
	arg_7_0.selectedVehicleId_ = arg_7_0.params_.vehicleID or VehicleBallData:GetSelectedVehicleId()
	arg_7_0.unLockVehicleId_ = arg_7_0.params_.unLockVehicleID
	arg_7_0.params_.vehicleID = nil
	arg_7_0.params_.unLockVehicleID = nil

	arg_7_0.vehicleList_:StartScroll(#arg_7_0.vehicleIdList_)
	arg_7_0:RefreshGearInfo()
	arg_7_0:RefreshVehicleInfo()
end

function var_0_0.OnExit(arg_8_0)
	if arg_8_0.selectedItem_ then
		arg_8_0.selectedItem_:ShowSelect(false)

		arg_8_0.selectedItem_ = nil
	end
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.vehicleList_ then
		arg_9_0.vehicleList_:Dispose()

		arg_9_0.vehicleList_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.RefreshGearInfo(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.vehicleSkillIdList_ do
		local var_10_0 = MergeBallVehicleCfg[arg_10_0.vehicleSkillIdList_[iter_10_0]]
		local var_10_1 = arg_10_0.vehicleSkillItemList_[iter_10_0]
		local var_10_2 = table.indexof(arg_10_0.passedStageList_, var_10_0.unlock_stage) == false

		var_10_1.lockController:SetSelectedIndex(var_10_2 and 0 or 1)

		if var_10_2 then
			var_10_1.lockDesc_.text = var_10_0.desc_lock
		else
			var_10_1.icon_ = pureGetSpriteWithoutAtlas(var_10_0.icon)
			var_10_1.skillDesc_.text = var_10_0.desc
		end
	end
end

function var_0_0.RefreshVehicleInfo(arg_11_0)
	local var_11_0 = MergeBallVehicleCfg[arg_11_0.selectedVehicleId_]

	arg_11_0.ballIcon_.sprite = pureGetSpriteWithoutAtlas(var_11_0.icon)
	arg_11_0.hpText_.text = var_11_0.param[2]
	arg_11_0.nameText_.text = var_11_0.name
	arg_11_0.descText_.text = var_11_0.desc
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.vehicleIdList_[arg_12_1]
	local var_12_1 = MergeBallVehicleCfg[var_12_0].unlock_stage
	local var_12_2 = not table.indexof(arg_12_0.passedStageList_, var_12_1) and var_12_1 ~= 0
	local var_12_3 = var_12_0 == arg_12_0.selectedVehicleId_

	if var_12_3 then
		arg_12_0.selectedItem_ = arg_12_2
	end

	arg_12_2:RefreshUI(var_12_0, var_12_2, var_12_3)
	arg_12_2:RegisterClickListener(handler(arg_12_0, arg_12_0.OnSelectVehicle))

	if var_12_0 == arg_12_0.unLockVehicleId_ then
		arg_12_2.anim_:Play("ballTabItem_unlock")
	end
end

function var_0_0.OnSelectVehicle(arg_13_0, arg_13_1)
	if arg_13_0.selectedItem_ then
		arg_13_0.selectedItem_:ShowSelect(false)
	end

	arg_13_0.selectedItem_ = arg_13_1

	arg_13_0.selectedItem_:ShowSelect(true)

	arg_13_0.selectedVehicleId_ = arg_13_1.vehicleId_

	arg_13_0:RefreshVehicleInfo()
end

return var_0_0
