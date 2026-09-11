local SimBusinessSpecialStageItem = class("SimBusinessSpecialStageItem", ReduxView)

function SimBusinessSpecialStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SimBusinessSpecialStageItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.scoreController = self.controller:GetController("score")
	self.stateController = self.controller:GetController("state")
end

function SimBusinessSpecialStageItem:InitUI()
	self:BindCfgUI()
end

function SimBusinessSpecialStageItem:AddUIListener()
	self:AddBtnListener(self.btn, nil, function()
		if self.clickFunc and self.id and not self.lock then
			self.clickFunc(self.id)
		end
	end)
end

function SimBusinessSpecialStageItem:RefreshView(arg_6_1)
	self.id = arg_6_1
	self.icon.sprite = SimBusinessTools.GetStageIcon(self.id)
	self.name.text = SimBusinessStageCfg[self.id].name

	local var_6_0, var_6_1 = SimBusinessTools.GetStageState(self.id)

	if var_6_0 == "lock" then
		self.lock = true

		self.stateController:SetSelectedState("lock")

		self.lockDesc.text = GetTips(var_6_1)
	else
		self.lock = false

		self.stateController:SetSelectedState("normal")
	end

	if var_6_1 then
		self.scoreController:SetSelectedState("1")

		self.score.text = var_6_1
	else
		self.scoreController:SetSelectedState("0")
	end

	if manager.redPoint:getTipBoolean((SimBusinessTools.GetSpStageRedPoint(arg_6_1))) then
		manager.redPoint:SetRedPointIndependent(self.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

function SimBusinessSpecialStageItem:RegisterClickFunc(arg_7_1)
	self.clickFunc = arg_7_1
end

function SimBusinessSpecialStageItem:Dispose()
	SimBusinessSpecialStageItem.super.Dispose(self)
end

return SimBusinessSpecialStageItem
