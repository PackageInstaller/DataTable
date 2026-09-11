local SummerRaceTankDetailPopView = class("SummerRaceTankDetailPopView", ReduxView)

local function var_0_1(arg_1_0)
	if arg_1_0 == nil or arg_1_0.buildData == nil then
		error("SummerRaceTankDetailPopView requires params.buildData")
	end

	return arg_1_0.buildData
end

function SummerRaceTankDetailPopView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_OutGameUI/pop/Activity_SummerRace_TankDetailPopUI"
end

function SummerRaceTankDetailPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerRaceTankDetailPopView:Init()
	self:BindCfgUI()
	self:BindViewRuntime()
	self:AddUIListener()
end

function SummerRaceTankDetailPopView:BindViewRuntime()
	self.equipSlotItemList_ = LuaList.New(handler(self, self.IndexSlotItem), self.equipListGo_, SummerRaceEquipSlotItemView)
	self.stateController_ = self.controllerEx_:GetController("state")
	self.slotList_ = {}
end

function SummerRaceTankDetailPopView:OnEnter()
	self:RefreshView()
end

function SummerRaceTankDetailPopView:OnExit()
	return
end

function SummerRaceTankDetailPopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function SummerRaceTankDetailPopView:IndexSlotItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.slotList_[arg_11_1], arg_11_1, handler(self, self.OnSlotAction))
end

function SummerRaceTankDetailPopView:OnSlotAction(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 == "select" and arg_12_2 and arg_12_2.itemId ~= "" then
		SummerRaceAction.OpenEquipInfoPop(arg_12_2.itemId)
	end
end

function SummerRaceTankDetailPopView:RefreshView()
	local var_13_0 = SummerRaceData:GetTankSnapshotModel((var_0_1(self.params_)))

	self.slotList_ = var_13_0.slotList or {}
	self.tankNameText_.text = tostring(var_13_0.tankName or "")
	self.costText_.text = tostring(var_13_0.cost or "")

	self.stateController_:SetSelectedState(#self.slotList_ > 0 and "show" or "hide")
	self.equipSlotItemList_:StartScroll(#self.slotList_)
end

function SummerRaceTankDetailPopView:Dispose()
	if self.equipSlotItemList_ then
		self.equipSlotItemList_:Dispose()

		self.equipSlotItemList_ = nil
	end

	SummerRaceTankDetailPopView.super.Dispose(self)
end

return SummerRaceTankDetailPopView
