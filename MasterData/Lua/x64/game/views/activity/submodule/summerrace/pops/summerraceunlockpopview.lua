local SummerRaceUnlockPopItemView = class("SummerRaceUnlockPopItemView", ReduxView)

function SummerRaceUnlockPopItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SummerRaceUnlockPopItemView:Init()
	self:BindCfgUI()

	self.isCarController_ = self.controllerEx_:GetController("isCar")
end

function SummerRaceUnlockPopItemView:SetData(arg_3_1)
	self.itemData_ = arg_3_1

	self:RefreshView()
end

function SummerRaceUnlockPopItemView:RefreshView()
	self.nameText_.text = tostring(self.itemData_.itemName or "")

	self.isCarController_:SetSelectedState(self.itemData_.isCar and "true" or "false")

	if self.itemData_.isCar then
		if self.itemData_.iconPath ~= "" then
			self.carIcon_.spriteSync = self.itemData_.iconPath or nil
		end
	elseif self.itemData_.iconPath ~= "" then
		self.normalIcon_.spriteSync = self.itemData_.iconPath or nil
	end
end

function SummerRaceUnlockPopItemView:Dispose()
	self.itemData_ = nil

	SummerRaceUnlockPopItemView.super.Dispose(self)
end

local SummerRaceUnlockPopView = class("SummerRaceUnlockPopView", ReduxView)

function SummerRaceUnlockPopView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_EquipUnlockPopUI"
end

function SummerRaceUnlockPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerRaceUnlockPopView:Init()
	self:BindCfgUI()

	self.unlockItemList_ = LuaList.New(handler(self, self.IndexUnlockItem), self.listGo_, SummerRaceUnlockPopItemView)
	self.unlockItemDataList_ = {}
	self.followupUnlockTimer_ = nil

	self:AddUIListener()
end

function SummerRaceUnlockPopView:OnEnter()
	self:RefreshView()
end

function SummerRaceUnlockPopView:OnExit()
	self:StopFollowupUnlockTimer()
end

function SummerRaceUnlockPopView:AddUIListener()
	self:AddBtnListener(self.sureBtn_, nil, function()
		JumpTools.Back()
		self:ScheduleFollowupUnlock()
	end)
	self:AddBtnListener(self.goModifyBtn_, nil, function()
		JumpTools.Back()
		SummerRaceAction.OpenModifyView("all")
	end)
end

function SummerRaceUnlockPopView:IndexUnlockItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.unlockItemDataList_[arg_14_1])
end

function SummerRaceUnlockPopView:RefreshView()
	self.unlockItemDataList_ = SummerRaceData:GetUnlockPopViewModel().unlockItemList

	self.unlockItemList_:StartScroll(#self.unlockItemDataList_)
end

function SummerRaceUnlockPopView:ScheduleFollowupUnlock()
	self:StopFollowupUnlockTimer()

	self.followupUnlockTimer_ = Timer.New(function()
		self:StopFollowupUnlockTimer()
		SummerRaceAction.TryContinuePendingUnlockFlow()
	end, 0.05, 1)

	self.followupUnlockTimer_:Start()
end

function SummerRaceUnlockPopView:StopFollowupUnlockTimer()
	if self.followupUnlockTimer_ ~= nil then
		self.followupUnlockTimer_:Stop()

		self.followupUnlockTimer_ = nil
	end
end

function SummerRaceUnlockPopView:Dispose()
	self:StopFollowupUnlockTimer()

	if self.unlockItemList_ ~= nil then
		self.unlockItemList_:Dispose()

		self.unlockItemList_ = nil
	end

	self.unlockItemDataList_ = nil

	SummerRaceUnlockPopView.super.Dispose(self)
end

return SummerRaceUnlockPopView
