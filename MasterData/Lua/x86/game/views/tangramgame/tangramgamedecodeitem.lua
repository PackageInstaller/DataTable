local TangramGameDecodeItem = class("TangramGameDecodeItem", ReduxView)

function TangramGameDecodeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function TangramGameDecodeItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.clickState = false
	self.stateController = self.controller:GetController("state")
end

function TangramGameDecodeItem:InitUI()
	self:BindCfgUI()
end

function TangramGameDecodeItem:AddUIListener()
	self:AddBtnListener(self.btn, nil, function()
		self.clickState = not self.clickState

		if self.clickState then
			self.stateController:SetSelectedState("true")
		else
			self.stateController:SetSelectedState("false")
		end

		if self.clickFunc then
			self.clickFunc(self.tipsID, self.clickState, self)
		end
	end)
end

function TangramGameDecodeItem:AddClickItem(arg_6_1)
	if arg_6_1 then
		self.clickFunc = arg_6_1
	end
end

function TangramGameDecodeItem:SetChooseIndex(arg_7_1)
	self.chooseIndex = arg_7_1

	self:RefreshChooseState()
end

function TangramGameDecodeItem:RefreshUI(arg_8_1)
	self.tipsID = arg_8_1
	self.desc.text = GetTips(arg_8_1)
end

function TangramGameDecodeItem:RefreshChooseState()
	self.numText.text = self.chooseIndex
end

function TangramGameDecodeItem:Dispose()
	TangramGameDecodeItem.super.Dispose(self)
end

return TangramGameDecodeItem
