local PinballStageItem = class("PinballStageItem", BaseView)

function PinballStageItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PinballStageItem:Dispose()
	PinballStageItem.super.Dispose(self)
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
end

local function var_0_1(arg_3_0, arg_3_1)
	arg_3_0[arg_3_1 .. "Controller"] = arg_3_0.controllers_:GetController(arg_3_1)
end

function PinballStageItem:Init()
	self:BindCfgUI()
	self:AddUIListener()
	var_0_1(self, "status")
	var_0_1(self, "select")
	var_0_1(self, "name")

	self.conditions = PinballStageView.InitDetailConditionCom(self, self.conditionGo_)
end

function PinballStageItem:IsSelected()
	return self.selectController:GetSelectedState() ~= "false"
end

function PinballStageItem:SetData(arg_6_1, arg_6_2)
	self.index = arg_6_1
	self.stage = arg_6_2

	self:Refresh()
end

function PinballStageItem:Refresh()
	self.index_.text = self.index
	self.stageName_.text = nullable(PinballStageCfg, self.stage, "name") or ""

	self:RefreshIcon()
	self:RefreshLockState()
	manager.redPoint:SetRedPointIndependent(self.transform_, manager.redPoint:getTipBoolean((PinballTools.StageRedPoint(self.stage))))

	for iter_7_0, iter_7_1 in ipairs(self.conditions) do
		PinballTools.RefreshDetailConditionCom(iter_7_1, self.stage, iter_7_0)
	end
end

function PinballStageItem:RefreshIcon()
	local var_8_0 = PinballTools.GetBossIconPath(PinballStageCfg[self.stage].monster_list[1])

	self.icon_.spriteSync = var_8_0
	self.iconShadowed_.spriteSync = var_8_0
end

function PinballStageItem:RefreshLockState()
	local var_9_0 = PinballData:GetStageState(self.stage)

	self.statusController:SetSelectedState(var_9_0)
	self:UpdateNameState(self:IsSelected(), var_9_0 == "lock")
end

function PinballStageItem:UpdateNameState(arg_10_1, arg_10_2)
	self.nameController:SetSelectedState(arg_10_1 and (arg_10_2 and "selectlock" or "selectunlock") or arg_10_2 and "lock" or "unlock")
end

function PinballStageItem:SetSelected(arg_11_1)
	self.selectController:SetSelectedState(arg_11_1 and "true" or "false")
	self:UpdateNameState(arg_11_1, PinballData:GetStageState(self.stage) == "lock")
end

function PinballStageItem:SetOnClick(arg_12_1)
	self.onClick = arg_12_1
end

function PinballStageItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.onClick then
			self:onClick()
		end

		PinballTools.MarkStageRedPointViewed(self.stage)
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end)
end

return PinballStageItem
