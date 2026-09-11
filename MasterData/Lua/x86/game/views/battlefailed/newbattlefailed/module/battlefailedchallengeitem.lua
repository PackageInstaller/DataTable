local BattleFailedChallengeItem = class("BattleFailedChallengeItem", ReduxView)

function BattleFailedChallengeItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddUIListener()

	self.stateController = self.controllerEx_:GetController("state")

	if arg_1_2 == 1 then
		self.stateController:SetSelectedIndex(0)
	end
end

function BattleFailedChallengeItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.index)
		end
	end)
end

function BattleFailedChallengeItem:OnRenderItem(arg_4_1, arg_4_2)
	self:Show(true)

	self.typeImg_.sprite = arg_4_1
	self.index = arg_4_2

	if arg_4_2 == 1 then
		self.stateController:SetSelectedIndex(0)
	else
		self.stateController:SetSelectedIndex(1)
	end
end

function BattleFailedChallengeItem:RegistCallBack(arg_5_1)
	self.clickFunc = arg_5_1
end

function BattleFailedChallengeItem:RefreshState(arg_6_1)
	if arg_6_1 == self.index then
		self.stateController:SetSelectedIndex(0)
	else
		self.stateController:SetSelectedIndex(1)
	end
end

function BattleFailedChallengeItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function BattleFailedChallengeItem:Dispose()
	BattleFailedChallengeItem.super.Dispose(self)
end

return BattleFailedChallengeItem
