local QWorldQuestToggleItem = class("QWorldQuestToggleItem", ReduxView)

function QWorldQuestToggleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function QWorldQuestToggleItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldQuestToggleItem:InitUI()
	self:BindCfgUI()

	self.selectController = self.conEx_:GetController("select")
end

function QWorldQuestToggleItem:AddUIListener()
	self:AddToggleListener(self.toggle_, function(arg_5_0)
		if arg_5_0 and self.callback_ then
			self.callback_()
		end

		self:SetValue(arg_5_0)
	end)
end

function QWorldQuestToggleItem:SetValue(arg_6_1)
	self.selectController:SetSelectedState(arg_6_1 and "true" or "false")
end

function QWorldQuestToggleItem:SetToggleValue(arg_7_1)
	self.toggle_.isOn = arg_7_1
end

function QWorldQuestToggleItem:SetCallback(arg_8_1)
	self.callback_ = arg_8_1
end

function QWorldQuestToggleItem:Dispose()
	QWorldQuestToggleItem.super.Dispose(self)
end

return QWorldQuestToggleItem
