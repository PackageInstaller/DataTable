local SummerRaceEquipInfoPopView = class("SummerRaceEquipInfoPopView", ReduxView)

local function var_0_1(arg_1_0)
	if arg_1_0 == nil or arg_1_0.equipId == nil then
		error("SummerRaceEquipInfoPopView requires params.equipId")
	end

	return arg_1_0.equipId
end

function SummerRaceEquipInfoPopView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_OutGameUI/pop/Activity_SummerRace_EquipInfoPopUI"
end

function SummerRaceEquipInfoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerRaceEquipInfoPopView:Init()
	self:BindCfgUI()
	self:BindViewRuntime()
	self:AddUIListener()
end

function SummerRaceEquipInfoPopView:BindViewRuntime()
	self.typeController_ = self.controllerEx_:GetController("type")
end

function SummerRaceEquipInfoPopView:OnEnter()
	self:RefreshView()
end

function SummerRaceEquipInfoPopView:OnExit()
	return
end

function SummerRaceEquipInfoPopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function SummerRaceEquipInfoPopView:RefreshView()
	local var_11_0 = SummerRaceData:GetEquipInfoModel((var_0_1(self.params_)))

	self.equipNameText_.text = tostring(var_11_0.equipName or "")
	self.typeText_.text = tostring(var_11_0.typeText or "")
	self.costText_.text = tostring(var_11_0.cost or "")
	self.energyText_.text = tostring(var_11_0.energyCost or "")
	self.descText_.text = tostring(var_11_0.desc or "")
	self.valueText_.text = tostring(var_11_0.valueText or "")

	self.typeController_:SetSelectedState(var_11_0.typeText or "weapon")
end

return SummerRaceEquipInfoPopView
