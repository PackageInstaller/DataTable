local AutoChessMedalInfoView = class("AutoChessMedalInfoView", ReduxView)

function AutoChessMedalInfoView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_BadgePopUI"
end

function AutoChessMedalInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessMedalInfoView:Init()
	self:BindCfgUI()
	self:AddUIListeners()

	self.lockController = self.controllers_:GetController("lock")
	self.tabController = self.controllers_:GetController("tab")
	self.gotoFormationController = self.controllers_:GetController("formation")
end

function AutoChessMedalInfoView:AddUIListeners()
	self:AddBtnListener(self.leftBtn_, nil, function()
		self:SwitchMedal(AutoChessMedalInfoView.SwitchOp.Prev)
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		self:SwitchMedal(AutoChessMedalInfoView.SwitchOp.Next)
	end)
	self:AddBtnListener(self.maskBtn_, nil, JumpTools.Back)
	self:AddBtnListener(self.formationBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessRecordView", {
			medalID = self.id
		})
		OperationRecorder.RecordButtonTouch({
			source = 2,
			button_name = "activity_autochess_record_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	self:AddBtnListener(self.tab01Btn_, nil, function()
		self.category = AutoChessData.MedalCategory.Basic

		self:SetData(self.id)
	end)
	self:AddBtnListener(self.tab02Btn_, nil, function()
		self.category = AutoChessData.MedalCategory.Advanced

		self:SetData(self.id)
	end)
end

function AutoChessMedalInfoView:OnEnter()
	self.id = self.params_.id or self.id or AutoChessMedalCfg.all[1]
	self.category = self.params_.medalLevel or self.category or AutoChessData.MedalCategory.Basic

	self:SetData(self.id)
end

function AutoChessMedalInfoView:SetData(arg_11_1)
	local var_11_0 = AutoChessMedalCfg[arg_11_1]
	local var_11_1, var_11_2 = AutoChessData:IsMedalUnlocked(arg_11_1)
	local var_11_3

	if var_11_1 then
		var_11_3 = self.category or AutoChessData.MedalCategory.Locked
	end

	local var_11_4 = var_11_3 == AutoChessData.MedalCategory.Advanced

	self:SetMedalIcon()

	self.iconStateController_ = self.iconController_:GetController("state")

	if var_11_3 == AutoChessData.MedalCategory.Locked then
		self.lockController:SetSelectedState("on")
		self.tabController:SetSelectedState("off")

		self.condition_.text = var_11_0.unlock_desc

		self.iconStateController_:SetSelectedState("02")
		self.gotoFormationController:SetSelectedState("hide")

		self.name_.text = "? ? ? ? ? ?"
	else
		local var_11_5

		self.name_.text = var_11_0.name

		local var_11_6 = 0

		if var_11_3 == AutoChessData.MedalCategory.Basic then
			var_11_5 = var_11_0.unlock_desc
			var_11_6 = var_11_2.unlockTime

			self.gotoFormationController:SetSelectedState("lock")
			self.lockController:SetSelectedState("off")
			self.iconStateController_:SetSelectedState("01")
		else
			local var_11_7 = AutoChessData.IsMedalAdvancedFromInfo(var_11_2)

			var_11_5 = var_11_0.upgrade_desc

			self.gotoFormationController:SetSelectedState(var_11_7 and self:IsHasGloryRecord(arg_11_1) and "unlock" or "lock")
			self.lockController:SetSelectedState(var_11_7 and "off" or "on")
			self.iconStateController_:SetSelectedState(var_11_7 and "03" or "04")

			var_11_6 = var_11_2.advanceTime
		end

		self.time_.text = manager.time:DescCTime(var_11_6, "达成时间 - %Y.%m.%d")
		self.desc_.text = var_11_0.desc
		self.condition_.text = var_11_5

		self.tabController:SetSelectedState(var_11_4 and "tab2" or "tab1")
	end
end

function AutoChessMedalInfoView:IsHasGloryRecord(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(AutoChessData:GetRecordDataList(AutoChessConst.RECORD_TYPE.GLORY) or {}) do
		if iter_12_1.medalId == arg_12_1 then
			return true
		end
	end

	return false
end

function AutoChessMedalInfoView:SetMedalIcon()
	self.iconController_ = nil

	for iter_13_0, iter_13_1 in ipairs(AutoChessMedalCfg.all) do
		if iter_13_1 == self.id then
			self.iconController_ = self["controller" .. iter_13_1 .. "_"]

			SetActive(self.iconController_.gameObject, true)
		else
			SetActive(self["controller" .. iter_13_1 .. "_"].gameObject, false)
		end
	end
end

local function var_0_1(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0 < arg_14_1 then
		arg_14_0 = arg_14_0 + (arg_14_2 - arg_14_1) + 1
	elseif arg_14_2 < arg_14_0 then
		arg_14_0 = arg_14_0 - (arg_14_2 - arg_14_1) - 1
	end

	return arg_14_0
end

local function var_0_2(arg_15_0)
	return table.indexof(AutoChessMedalCfg.all, arg_15_0)
end

AutoChessMedalInfoView.SwitchOp = {
	Next = 1,
	Prev = -1
}

function AutoChessMedalInfoView:SwitchMedal(arg_16_1)
	local var_16_0 = var_0_2(self.id)

	self.id = AutoChessMedalCfg.all[var_16_0 and var_0_1(var_16_0 + arg_16_1, 1, #AutoChessMedalCfg.all) or 1]

	self:SetData(self.id)
end

return AutoChessMedalInfoView
