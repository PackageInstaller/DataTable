local var_0_0 = class("EquipBreakThroughMaterialMapItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.typeController_ = ControllerUtil.GetController(arg_1_0.transform_, "equipMaterial")
	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
	arg_1_0.currentPosController_ = ControllerUtil.GetController(arg_1_0.transform_, "currentPosition")
	arg_1_0.finishStateController_ = ControllerUtil.GetController(arg_1_0.transform_, "finish")
	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
	arg_1_0.colorController_ = ControllerUtil.GetController(arg_1_0.transform_, "open")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		local var_3_0 = EquipBreakThroughMaterialData:GetFinishStageList()

		if table.keyof(var_3_0, arg_2_0.mapStageID_) or arg_2_0.lock_ then
			return
		end

		EquipBreakThroughMaterialData:SetChooseMapStageID(arg_2_0.mapStageID_)

		local var_3_1

		if arg_2_0.cfg_.stage_type == EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.HEAL then
			var_3_1 = GameSetting.equip_crossroads_heal_stage_id.value[1]
		elseif arg_2_0.cfg_.stage_type == EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.BUFF then
			var_3_1 = GameSetting.equip_crossroads_buff_stage_id.value[1]
		else
			var_3_1 = EquipBreakThroughMaterialData:GetStageData()[arg_2_0.mapStageID_].stageID
		end

		arg_2_0:Go("equipBreakThroughMaterialStageInfo", {
			section = var_3_1
		})
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.mapStageID_ = arg_4_1
	arg_4_0.cfg_ = EquipBreakThroughMaterialMapCfg[arg_4_1]
	arg_4_0.lock_ = true

	arg_4_0:RefreshItemState()
	arg_4_0:RefreshItemPosition()
	SetActive(arg_4_0.gameObject_, true)
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	Object.Destroy(arg_6_0.gameObject_)

	arg_6_0.transform_ = nil
	arg_6_0.gameObject_ = nil
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0.selectController_:SetSelectedState("off")
end

function var_0_0.OnBehind(arg_8_0)
	if arg_8_0.mapStageID_ == EquipBreakThroughMaterialData:GetChooseMapStageID() then
		arg_8_0.selectController_:SetSelectedState("on")
	else
		arg_8_0.selectController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshItemPosition(arg_9_0)
	local var_9_0 = EquipBreakThroughMaterialStagePositionCfg[0].row_position
	local var_9_1 = arg_9_0.cfg_

	arg_9_0.transform_.localPosition = Vector3(var_9_0 * var_9_1.col, EquipBreakThroughMaterialStagePositionCfg[var_9_1.row].row_position, 0)
end

function var_0_0.RefreshItemState(arg_10_0)
	local var_10_0 = EquipBreakThroughMaterialData:GetFinishStageList()
	local var_10_1 = var_10_0[#var_10_0]

	if table.keyof(EquipBreakThroughMaterialData:GetFinishStageList(), arg_10_0.mapStageID_) then
		arg_10_0.finishStateController_:SetSelectedState("on")
	else
		arg_10_0.finishStateController_:SetSelectedState("off")
	end

	local var_10_2 = EquipBreakThroughMaterialMapCfg[arg_10_0.mapStageID_]

	if table.keyof(EquipBreakThroughMaterialPointCfg.all, var_10_2.stage_type) then
		arg_10_0.pointText_.text = EquipBreakThroughMaterialPointCfg[var_10_2.stage_type].stage_point[var_10_2.col]
	end

	arg_10_0.canvasGroup_.blocksRaycasts = false

	if arg_10_0.mapStageID_ == var_10_1 then
		arg_10_0.currentPosController_:SetSelectedState("on")
	else
		arg_10_0.currentPosController_:SetSelectedState("off")
	end

	local var_10_3 = true

	if var_10_1 == nil then
		local var_10_4 = EquipBreakThroughMaterialData:GetMapID()

		var_10_1 = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[var_10_4][1]

		if var_10_1 == arg_10_0.mapStageID_ then
			arg_10_0.canvasGroup_.blocksRaycasts = true

			arg_10_0.lockController_:SetSelectedState("off")

			arg_10_0.lock_ = false

			arg_10_0.colorController_:SetSelectedState(tostring(var_10_2.stage_type))
		else
			arg_10_0.lockController_:SetSelectedState(tostring(var_10_2.stage_type))
			arg_10_0.colorController_:SetSelectedState("0")
		end
	elseif table.keyof(EquipBreakThroughMaterialMapCfg[var_10_1].next_id_list, arg_10_0.mapStageID_) then
		arg_10_0.lockController_:SetSelectedState("off")

		arg_10_0.canvasGroup_.blocksRaycasts = true
		arg_10_0.lock_ = false

		arg_10_0.colorController_:SetSelectedState(tostring(var_10_2.stage_type))
	elseif table.keyof(EquipBreakThroughMaterialData:GetFinishStageList(), arg_10_0.mapStageID_) then
		arg_10_0.lockController_:SetSelectedState("off")
		arg_10_0.colorController_:SetSelectedState("0")
	else
		arg_10_0.lockController_:SetSelectedState(tostring(var_10_2.stage_type))
		arg_10_0.colorController_:SetSelectedState("0")
	end

	arg_10_0.typeController_:SetSelectedState(tostring(var_10_2.stage_type))

	if var_10_2.stage_type == 1 then
		arg_10_0.nameText_.text = GetTips("EQUIP_BREAK_STAGE_TYPE_1")
	elseif var_10_2.stage_type == 2 then
		arg_10_0.nameText_.text = GetTips("EQUIP_BREAK_STAGE_TYPE_2")
	elseif var_10_2.stage_type == 3 then
		arg_10_0.nameText_.text = GetTips("EQUIP_BREAK_STAGE_TYPE_3")
	elseif var_10_2.stage_type == 4 then
		arg_10_0.nameText_.text = GetTips("EQUIP_BREAK_STAGE_TYPE_4")
	else
		arg_10_0.nameText_.text = GetTips("EQUIP_BREAK_STAGE_TYPE_5")
	end

	arg_10_0.icon_.sprite = getSprite("Atlas/Stage", EquipBreakThroughMaterialPointCfg[var_10_2.stage_type].icon)
end

function var_0_0.GetLocalPosition(arg_11_0)
	return arg_11_0.transform_.localPosition
end

function var_0_0.IsOpenSectionInfo(arg_12_0)
	return arg_12_0:IsOpenRoute("equipBreakThroughMaterialStageInfo")
end

return var_0_0
