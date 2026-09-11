local EquipBreakThroughMaterialMapItem = class("EquipBreakThroughMaterialMapItem", ReduxView)

function EquipBreakThroughMaterialMapItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.typeController_ = ControllerUtil.GetController(self.transform_, "equipMaterial")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.currentPosController_ = ControllerUtil.GetController(self.transform_, "currentPosition")
	self.finishStateController_ = ControllerUtil.GetController(self.transform_, "finish")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.colorController_ = ControllerUtil.GetController(self.transform_, "open")
end

function EquipBreakThroughMaterialMapItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if table.keyof(EquipBreakThroughMaterialData:GetFinishStageList(), self.mapStageID_) or self.lock_ then
			return
		end

		EquipBreakThroughMaterialData:SetChooseMapStageID(self.mapStageID_)

		local var_3_0 = self.cfg_.stage_type == EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.HEAL and GameSetting.equip_crossroads_heal_stage_id.value[1] or self.cfg_.stage_type == EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.BUFF and GameSetting.equip_crossroads_buff_stage_id.value[1] or EquipBreakThroughMaterialData:GetStageData()[self.mapStageID_].stageID

		self:Go("equipBreakThroughMaterialStageInfo", {
			section = var_3_0
		})
	end)
end

function EquipBreakThroughMaterialMapItem:SetData(arg_4_1)
	self.mapStageID_ = arg_4_1
	self.cfg_ = EquipBreakThroughMaterialMapCfg[arg_4_1]
	self.lock_ = true

	self:RefreshItemState()
	self:RefreshItemPosition()
	SetActive(self.gameObject_, true)
end

function EquipBreakThroughMaterialMapItem:OnExit()
	return
end

function EquipBreakThroughMaterialMapItem:Dispose()
	EquipBreakThroughMaterialMapItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function EquipBreakThroughMaterialMapItem:OnTop()
	self.selectController_:SetSelectedState("off")
end

function EquipBreakThroughMaterialMapItem:OnBehind()
	if self.mapStageID_ == EquipBreakThroughMaterialData:GetChooseMapStageID() then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

function EquipBreakThroughMaterialMapItem:RefreshItemPosition()
	self.transform_.localPosition = Vector3(EquipBreakThroughMaterialStagePositionCfg[0].row_position * self.cfg_.col, EquipBreakThroughMaterialStagePositionCfg[self.cfg_.row].row_position, 0)
end

function EquipBreakThroughMaterialMapItem:RefreshItemState()
	local var_10_0 = EquipBreakThroughMaterialData:GetFinishStageList()
	local var_10_1 = var_10_0[#var_10_0]

	if table.keyof(EquipBreakThroughMaterialData:GetFinishStageList(), self.mapStageID_) then
		self.finishStateController_:SetSelectedState("on")
	else
		self.finishStateController_:SetSelectedState("off")
	end

	local var_10_2 = EquipBreakThroughMaterialMapCfg[self.mapStageID_]

	if table.keyof(EquipBreakThroughMaterialPointCfg.all, EquipBreakThroughMaterialMapCfg[self.mapStageID_].stage_type) then
		self.pointText_.text = EquipBreakThroughMaterialPointCfg[var_10_2.stage_type].stage_point[var_10_2.col]
	end

	self.canvasGroup_.blocksRaycasts = false

	if self.mapStageID_ == var_10_1 then
		self.currentPosController_:SetSelectedState("on")
	else
		self.currentPosController_:SetSelectedState("off")
	end

	if var_10_1 == nil then
		var_10_1 = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[EquipBreakThroughMaterialData:GetMapID()][1]

		if var_10_1 == self.mapStageID_ then
			self.canvasGroup_.blocksRaycasts = true

			self.lockController_:SetSelectedState("off")

			self.lock_ = false

			self.colorController_:SetSelectedState(tostring(var_10_2.stage_type))
		else
			self.lockController_:SetSelectedState(tostring(var_10_2.stage_type))
			self.colorController_:SetSelectedState("0")
		end
	elseif table.keyof(EquipBreakThroughMaterialMapCfg[var_10_1].next_id_list, self.mapStageID_) then
		self.lockController_:SetSelectedState("off")

		self.canvasGroup_.blocksRaycasts = true
		self.lock_ = false

		self.colorController_:SetSelectedState(tostring(var_10_2.stage_type))
	elseif table.keyof(EquipBreakThroughMaterialData:GetFinishStageList(), self.mapStageID_) then
		self.lockController_:SetSelectedState("off")
		self.colorController_:SetSelectedState("0")
	else
		self.lockController_:SetSelectedState(tostring(var_10_2.stage_type))
		self.colorController_:SetSelectedState("0")
	end

	self.typeController_:SetSelectedState(tostring(var_10_2.stage_type))

	self.nameText_.text = var_10_2.stage_type == 1 and GetTips("EQUIP_BREAK_STAGE_TYPE_1") or var_10_2.stage_type == 2 and GetTips("EQUIP_BREAK_STAGE_TYPE_2") or var_10_2.stage_type == 3 and GetTips("EQUIP_BREAK_STAGE_TYPE_3") or var_10_2.stage_type == 4 and GetTips("EQUIP_BREAK_STAGE_TYPE_4") or GetTips("EQUIP_BREAK_STAGE_TYPE_5")
	self.icon_.sprite = getSprite("Atlas/Stage", EquipBreakThroughMaterialPointCfg[var_10_2.stage_type].icon)
end

function EquipBreakThroughMaterialMapItem:GetLocalPosition()
	return self.transform_.localPosition
end

function EquipBreakThroughMaterialMapItem:IsOpenSectionInfo()
	return self:IsOpenRoute("equipBreakThroughMaterialStageInfo")
end

return EquipBreakThroughMaterialMapItem
