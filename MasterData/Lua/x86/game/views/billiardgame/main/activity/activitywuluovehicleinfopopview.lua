local ActivityWuluoVehicleInfoPopView = class("ActivityWuluoVehicleInfoPopView", ReduxView)

function ActivityWuluoVehicleInfoPopView:UIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_BallInfoPopUI"
end

function ActivityWuluoVehicleInfoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityWuluoVehicleInfoPopView:Init()
	self:InitUI()
	self:AddUIListner()
end

function ActivityWuluoVehicleInfoPopView:InitUI()
	self:BindCfgUI()

	self.vehicleSkillItemList_ = {}
	self.vehicleSkillIdList_ = MergeBallVehicleCfg.get_id_list_by_type[BilliardGameConst.VehicleType.SKILL]

	for iter_4_0 = 1, #self.vehicleSkillIdList_ do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, self["gearGo_" .. iter_4_0])

		var_4_0.lockController = var_4_0.transCon_:GetController("lock")

		table.insert(self.vehicleSkillItemList_, var_4_0)
	end

	self.vehicleList_ = LuaList.New(handler(self, self.IndexItem), self.vehicleListGo_, VehicleSelectItemView)
end

function ActivityWuluoVehicleInfoPopView:AddUIListner()
	self:AddBtnListener(self.backBtn_, nil, function()
		if self.selectedItem_ then
			VehicleBallAction.SetVehicle({
				vehicleId = self.selectedVehicleId_
			})
		end

		self:Back()
	end)
end

function ActivityWuluoVehicleInfoPopView:OnEnter()
	self.vehicleIdList_ = MergeBallVehicleCfg.get_id_list_by_type[BilliardGameConst.VehicleType.VEHICLE]
	self.passedStageList_ = VehicleBallData:GetPassedStageList()
	self.selectedVehicleId_ = self.params_.vehicleID or VehicleBallData:GetSelectedVehicleId()
	self.unLockVehicleId_ = self.params_.unLockVehicleID
	self.params_.vehicleID = nil
	self.params_.unLockVehicleID = nil

	self.vehicleList_:StartScroll(#self.vehicleIdList_)
	self:RefreshGearInfo()
	self:RefreshVehicleInfo()
end

function ActivityWuluoVehicleInfoPopView:OnExit()
	if self.selectedItem_ then
		self.selectedItem_:ShowSelect(false)

		self.selectedItem_ = nil
	end
end

function ActivityWuluoVehicleInfoPopView:Dispose()
	if self.vehicleList_ then
		self.vehicleList_:Dispose()

		self.vehicleList_ = nil
	end

	ActivityWuluoVehicleInfoPopView.super.Dispose(self)
end

function ActivityWuluoVehicleInfoPopView:RefreshGearInfo()
	for iter_10_0 = 1, #self.vehicleSkillIdList_ do
		local var_10_0 = MergeBallVehicleCfg[self.vehicleSkillIdList_[iter_10_0]]
		local var_10_1 = self.vehicleSkillItemList_[iter_10_0]
		local var_10_2 = table.indexof(self.passedStageList_, MergeBallVehicleCfg[self.vehicleSkillIdList_[iter_10_0]].unlock_stage) == false

		self.vehicleSkillItemList_[iter_10_0].lockController:SetSelectedIndex(var_10_2 and 0 or 1)

		if var_10_2 then
			var_10_1.lockDesc_.text = var_10_0.desc_lock
		else
			var_10_1.icon_ = pureGetSpriteWithoutAtlas(var_10_0.icon)
			var_10_1.skillDesc_.text = var_10_0.desc
		end
	end
end

function ActivityWuluoVehicleInfoPopView:RefreshVehicleInfo()
	self.ballIcon_.sprite = pureGetSpriteWithoutAtlas(MergeBallVehicleCfg[self.selectedVehicleId_].icon)
	self.hpText_.text = MergeBallVehicleCfg[self.selectedVehicleId_].param[2]
	self.nameText_.text = MergeBallVehicleCfg[self.selectedVehicleId_].name
	self.descText_.text = MergeBallVehicleCfg[self.selectedVehicleId_].desc
end

function ActivityWuluoVehicleInfoPopView:IndexItem(arg_12_1, arg_12_2)
	local var_12_0 = self.vehicleIdList_[arg_12_1]

	if self.vehicleIdList_[arg_12_1] == self.selectedVehicleId_ then
		self.selectedItem_ = arg_12_2
	end

	arg_12_2:RefreshUI(var_12_0, not table.indexof(self.passedStageList_, MergeBallVehicleCfg[self.vehicleIdList_[arg_12_1]].unlock_stage) and MergeBallVehicleCfg[self.vehicleIdList_[arg_12_1]].unlock_stage ~= 0, self.vehicleIdList_[arg_12_1] == self.selectedVehicleId_)
	arg_12_2:RegisterClickListener(handler(self, self.OnSelectVehicle))

	if var_12_0 == self.unLockVehicleId_ then
		arg_12_2.anim_:Play("ballTabItem_unlock")
	end
end

function ActivityWuluoVehicleInfoPopView:OnSelectVehicle(arg_13_1)
	if self.selectedItem_ then
		self.selectedItem_:ShowSelect(false)
	end

	self.selectedItem_ = arg_13_1

	self.selectedItem_:ShowSelect(true)

	self.selectedVehicleId_ = arg_13_1.vehicleId_

	self:RefreshVehicleInfo()
end

return ActivityWuluoVehicleInfoPopView
